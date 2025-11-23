// lib/feature/map/controllers/locaion_controller.dart
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../core/constants/app_constant.dart';

class LocationController extends GetxController {
  // Location state
  var currentPosition = Rxn<Position>(); // Keep this for raw geolocator position
  var currentLocation = Rxn<LatLng>(); // LatLng format
  var pickupLocation = Rxn<LatLng>();
  var destinationLocation = Rxn<LatLng>();
  var pickupAddress = ''.obs;
  var destinationAddress = ''.obs;
  var distance = 0.0.obs; // Driving distance in km (from Directions API when possible)

  // Map state
  var mapController = Rxn<GoogleMapController>();
  var markers = <Marker>{}.obs;
  var polylines = <Polyline>{}.obs; // Route polyline

  var isLocationPermissionGranted = false.obs;

  // Search state
  var searchResults = <String>[].obs;
  var isSearching = false.obs;
  var searchQuery = ''.obs;
  RxString selectedAddress = ''.obs;

  // Saved locations
  RxString homeAddress = 'Mohakhali DOHS, Dhaka'.obs;
  RxString workAddress = 'Gulshan 2, Dhaka'.obs;
  RxString favoriteAddress = 'Banani, Dhaka'.obs;

  // Networking
  final Dio _dio = Dio();

  @override
  void onInit() {
    super.onInit();
    _initLocation(); // async-safe init

    // Whenever pickup or destination changes, update route + distance
    everAll([pickupLocation, destinationLocation], (_) {
      _updateRoute(); // Uses Google Directions for road route
    });
  }

  Future<void> _initLocation() async {
    await requestLocationPermission();
    await getCurrentLocation();
  }

  Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    isLocationPermissionGranted.value =
        permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  Future<void> getCurrentLocation() async {
    try {
      if (!isLocationPermissionGranted.value) {
        await requestLocationPermission();
      }

      if (!isLocationPermissionGranted.value) {
        return; // still not granted
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      currentPosition.value = position;
      currentLocation.value = LatLng(position.latitude, position.longitude);

      // Make current location the default pickup point
      pickupLocation.value = currentLocation.value;

      await getAddressFromCoordinates(
        position.latitude,
        position.longitude,
        true,
      );

      updateMapMarkers();

      // Move camera to current location if map controller is ready
      if (mapController.value != null && currentLocation.value != null) {
        mapController.value!.animateCamera(
          CameraUpdate.newLatLngZoom(currentLocation.value!, 14.0),
        );
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get current location: $e');
    }
  }

  Future<void> getAddressFromCoordinates(
      double lat, double lng, bool isPickup) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        // Combine address elements for a more complete address
        String address = [
          place.street,
          place.subLocality,
          place.locality,
          place.administrativeArea,
          place.country,
          place.postalCode
        ]
            .where((element) => element != null && element.isNotEmpty)
            .join(', ');

        if (isPickup) {
          pickupAddress.value = address;
        } else {
          destinationAddress.value = address;
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get address: $e');
    }
  }

  void setPickupLocation(LatLng location) {
    pickupLocation.value = location;
    getAddressFromCoordinates(location.latitude, location.longitude, true);
    updateMapMarkers();
  }

  void setDestinationLocation(LatLng location) {
    destinationLocation.value = location;
    getAddressFromCoordinates(location.latitude, location.longitude, false);
    updateMapMarkers();

    // When destination is set, move camera to fit both locations
    if (mapController.value != null &&
        pickupLocation.value != null &&
        destinationLocation.value != null) {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          pickupLocation.value!.latitude < destinationLocation.value!.latitude
              ? pickupLocation.value!.latitude
              : destinationLocation.value!.latitude,
          pickupLocation.value!.longitude <
                  destinationLocation.value!.longitude
              ? pickupLocation.value!.longitude
              : destinationLocation.value!.longitude,
        ),
        northeast: LatLng(
          pickupLocation.value!.latitude > destinationLocation.value!.latitude
              ? pickupLocation.value!.latitude
              : destinationLocation.value!.latitude,
          pickupLocation.value!.longitude >
                  destinationLocation.value!.longitude
              ? pickupLocation.value!.longitude
              : destinationLocation.value!.longitude,
        ),
      );
      mapController.value!
          .animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
    }
  }

  void setMapController(GoogleMapController controller) {
    mapController.value = controller;
    // If current location is already available when map is created, move camera
    if (currentLocation.value != null) {
      mapController.value!.animateCamera(
        CameraUpdate.newLatLngZoom(currentLocation.value!, 14.0),
      );
    }
  }

  void updateMapMarkers() {
    markers.clear();

    if (pickupLocation.value != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('pickup'),
          position: pickupLocation.value!,
          infoWindow: const InfoWindow(title: 'My Location'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }

    if (destinationLocation.value != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('destination'),
          position: destinationLocation.value!,
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }
  }

  /// OLD straight-line polyline (kept as fallback)
  void _generateStraightLinePolyline() {
    polylines.clear();
    if (pickupLocation.value != null && destinationLocation.value != null) {
      const String polylineIdVal = 'route_polyline';
      const PolylineId polylineId = PolylineId(polylineIdVal);

      final Polyline polyline = Polyline(
        polylineId: polylineId,
        color: const Color(0xFFC0392B), // Red color for the polyline
        points: [
          pickupLocation.value!,
          destinationLocation.value!,
        ],
        width: 5,
        geodesic: true,
      );
      polylines.add(polyline);
    }
  }

  /// OLD straight-line distance (kept as fallback)
  void _calculateStraightLineDistance() {
    if (pickupLocation.value != null && destinationLocation.value != null) {
      final double calculatedDistance = Geolocator.distanceBetween(
        pickupLocation.value!.latitude,
        pickupLocation.value!.longitude,
        destinationLocation.value!.latitude,
        destinationLocation.value!.longitude,
      );
      // Convert meters to kilometers and round to 1 decimal place
      distance.value = (calculatedDistance / 1000).toPrecision(1);
    } else {
      distance.value = 0.0;
    }
  }

  /// 🔥 NEW: Use Google Directions API to get driving route polyline + distance
  Future<void> _updateRoute() async {
    if (pickupLocation.value == null || destinationLocation.value == null) {
      distance.value = 0.0;
      polylines.clear();
      return;
    }

    final origin =
        '${pickupLocation.value!.latitude},${pickupLocation.value!.longitude}';
    final dest =
        '${destinationLocation.value!.latitude},${destinationLocation.value!.longitude}';

    final url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=$origin&destination=$dest&mode=driving&key=${AppConstant.apiKey}';

    try {
      final response = await _dio.get(url);

      if (response.statusCode == 200 &&
          response.data['status'] == 'OK' &&
          (response.data['routes'] as List).isNotEmpty) {
        final route = response.data['routes'][0];
        final leg = route['legs'][0];

        // Distance from API (meters)
        final int distanceMeters = leg['distance']['value'];
        // You can also read duration if you want exact ETA:
        // final int durationSeconds = leg['duration']['value'];

        final String encodedPolyline =
            route['overview_polyline']['points'] as String;

        final List<LatLng> decodedPoints =
            _decodePolyline(encodedPolyline);

        polylines.clear();
        polylines.add(
          Polyline(
            polylineId: const PolylineId('route_polyline'),
            color: Color(0xff303644),
            width: 5,
            points: decodedPoints,
          ),
        );

        // Convert meters to km, 1 decimal
        distance.value = (distanceMeters / 1000.0).toPrecision(1);
      } else {
        // Fallback to straight line if API fails or no route
        _generateStraightLinePolyline();
        _calculateStraightLineDistance();
      }
    } catch (e) {
      // Fallback in case of error
      _generateStraightLinePolyline();
      _calculateStraightLineDistance();
    }
  }

  /// Polyline decoder (standard Google encoded polyline algorithm)
  List<LatLng> _decodePolyline(String encoded) {
    List<LatLng> polyline = [];
    int index = 0;
    int len = encoded.length;
    int lat = 0;
    int lng = 0;

    while (index < len) {
      int b;
      int shift = 0;
      int result = 0;

      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lat += dlat;

      shift = 0;
      result = 0;
      do {
        b = encoded.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);
      int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
      lng += dlng;

      polyline.add(
        LatLng(lat / 1E5, lng / 1E5),
      );
    }

    return polyline;
  }

  // Public helper if you need to force distance recalc elsewhere
  void recalculateDistance() => _updateRoute();

  // --------- Search helpers (unchanged) ----------

  void searchLocation(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      searchResults.clear();
      return;
    }

    isSearching.value = true;

    // Simulate search results - replace with actual API call (e.g., Google Places API)
    Future.delayed(const Duration(milliseconds: 500), () {
      searchResults.value = [
        '${query} Rd, Dhaka, Bangladesh',
        '${query} Market, Dhaka, Bangladesh',
        '${query} Tower, Dhaka, Bangladesh',
        '${query} Apartment, Dhaka, Bangladesh',
        '${query} Station, Dhaka, Bangladesh',
      ];
      isSearching.value = false;
    });
  }

  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
  }

  void selectSearchResult(String address) async {
    destinationAddress.value = address;
    searchResults.clear();
    searchQuery.value = ''; // Clear search query after selection

    // Try to get LatLng from address (geocoding) and set destinationLocation
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        setDestinationLocation(
          LatLng(locations.first.latitude, locations.first.longitude),
        );
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'Failed to get coordinates for selected address: $e');
    }
  }

  void selectSavedLocation(String type) async {
    String addressToSet = '';
    switch (type) {
      case 'home':
        addressToSet = homeAddress.value;
        break;
      case 'work':
        addressToSet = workAddress.value;
        break;
      case 'favorite':
        addressToSet = favoriteAddress.value;
        break;
    }
    destinationAddress.value = addressToSet;

    // Try to get LatLng from address (geocoding) and set destinationLocation
    try {
      List<Location> locations = await locationFromAddress(addressToSet);
      if (locations.isNotEmpty) {
        setDestinationLocation(
          LatLng(locations.first.latitude, locations.first.longitude),
        );
      }
    } catch (e) {
      Get.snackbar(
          'Error', 'Failed to get coordinates for saved address: $e');
    }
  }

  double calculateDistanceBetween(LatLng start, LatLng end) {
    final double distanceInMeters = Geolocator.distanceBetween(
      start.latitude,
      start.longitude,
      end.latitude,
      end.longitude,
    );
    // Convert meters to kilometers
    return distanceInMeters / 1000;
  }
}






// // lib/feature/map/controllers/locaion_controller.dart
// import 'dart:ui';

// import 'package:get/get.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class LocationController extends GetxController {
//   // Location state
//   var currentPosition = Rxn<Position>(); // Keep this for raw geolocator position
//   var currentLocation = Rxn<LatLng>(); // Add this for LatLng format
//   var pickupLocation = Rxn<LatLng>();
//   var destinationLocation = Rxn<LatLng>();
//   var pickupAddress = ''.obs;
//   var destinationAddress = ''.obs;
//   var distance = 0.0.obs; // Added for distance calculation

//   // Map state
//   var mapController = Rxn<GoogleMapController>();
//   var markers = <Marker>{}.obs;
//   var polylines = <Polyline>{}.obs; // Add this for polylines

//   var isLocationPermissionGranted = false.obs;

//   // Search state
//   var searchResults = <String>[].obs;
//   var isSearching = false.obs;
//   var searchQuery = ''.obs;
//   RxString selectedAddress = ''.obs;

//   // Saved locations
//   RxString homeAddress = 'Mohakhali DOHS, Dhaka'.obs;
//   RxString workAddress = 'Gulshan 2, Dhaka'.obs;
//   RxString favoriteAddress = 'Banani, Dhaka'.obs;

//   // @override
//   // void onInit() {
//   //   super.onInit();
//   //   requestLocationPermission();
//   //   getCurrentLocation();
//   //   // Listen for changes in pickup or destination to regenerate polyline and distance
//   //   everAll([pickupLocation, destinationLocation], (_) {
//   //     generatePolyline();
//   //     _calculateDistance(); // Calculate distance whenever locations change
//   //   });
//   // }


//   @override
// void onInit() {
//   super.onInit();
//   _initLocation(); // 🔹 async-safe init

//   // Listen for changes in pickup or destination to regenerate polyline and distance
//   everAll([pickupLocation, destinationLocation], (_) {
//     generatePolyline();
//     _calculateDistance(); // Calculate distance whenever locations change
//   });
// }

// Future<void> _initLocation() async {
//   await requestLocationPermission();
//   await getCurrentLocation();
// }


//   Future<void> requestLocationPermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     isLocationPermissionGranted.value =
//         permission == LocationPermission.whileInUse ||
//         permission == LocationPermission.always;
//   }

//  Future<void> getCurrentLocation() async {
//   try {
//     // 🔹 If permission not granted yet, request it
//     if (!isLocationPermissionGranted.value) {
//       await requestLocationPermission();
//     }

//     if (!isLocationPermissionGranted.value) {
//       return; // still not granted
//     }

//     Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high,
//     );

//     currentPosition.value = position;
//     currentLocation.value = LatLng(position.latitude, position.longitude);

//     // 🔹 Make current location the default pickup point
//     pickupLocation.value = currentLocation.value;

//     await getAddressFromCoordinates(
//       position.latitude,
//       position.longitude,
//       true,
//     );

//     updateMapMarkers();

//     // Move camera to current location if map controller is ready
//     if (mapController.value != null && currentLocation.value != null) {
//       mapController.value!.animateCamera(
//         CameraUpdate.newLatLngZoom(currentLocation.value!, 14.0),
//       );
//     }
//   } catch (e) {
//     Get.snackbar('Error', 'Failed to get current location: $e');
//   }
// }

//   Future<void> getAddressFromCoordinates(double lat, double lng, bool isPickup) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         // Combine address elements for a more complete address
//         String address = [
//           place.street,
//           place.subLocality,
//           place.locality,
//           place.administrativeArea,
//           place.country,
//           place.postalCode
//         ].where((element) => element != null && element.isNotEmpty).join(', ');

//         if (isPickup) {
//           pickupAddress.value = address;
//         } else {
//           destinationAddress.value = address;
//         }
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to get address: $e');
//     }
//   }

//   void setPickupLocation(LatLng location) {
//     pickupLocation.value = location;
//     getAddressFromCoordinates(location.latitude, location.longitude, true);
//     updateMapMarkers();
//   }

//   void setDestinationLocation(LatLng location) {
//     destinationLocation.value = location;
//     getAddressFromCoordinates(location.latitude, location.longitude, false);
//     updateMapMarkers();
//     // When destination is set, move camera to fit both locations
//     if (mapController.value != null && pickupLocation.value != null && destinationLocation.value != null) {
//       LatLngBounds bounds = LatLngBounds(
//         southwest: LatLng(
//           pickupLocation.value!.latitude < destinationLocation.value!.latitude
//               ? pickupLocation.value!.latitude
//               : destinationLocation.value!.latitude,
//           pickupLocation.value!.longitude < destinationLocation.value!.longitude
//               ? pickupLocation.value!.longitude
//               : destinationLocation.value!.longitude,
//         ),
//         northeast: LatLng(
//           pickupLocation.value!.latitude > destinationLocation.value!.latitude
//               ? pickupLocation.value!.latitude
//               : destinationLocation.value!.latitude,
//           pickupLocation.value!.longitude > destinationLocation.value!.longitude
//               ? pickupLocation.value!.longitude
//               : destinationLocation.value!.longitude,
//         ),
//       );
//       mapController.value!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
//     }
//   }

//   void setMapController(GoogleMapController controller) {
//     mapController.value = controller;
//     // If current location is already available when map is created, move camera
//     if (currentLocation.value != null) {
//       mapController.value!.animateCamera(
//         CameraUpdate.newLatLngZoom(currentLocation.value!, 14.0),
//       );
//     }
//   }

//   void updateMapMarkers() {
//     markers.clear();

//     if (pickupLocation.value != null) {
//       markers.add(
//         Marker(
//           markerId: MarkerId('pickup'),
//           position: pickupLocation.value!,
//           infoWindow: InfoWindow(title: 'My Location'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
//         ),
//       );
//     }

//     if (destinationLocation.value != null) {
//       markers.add(
//         Marker(
//           markerId: MarkerId('destination'),
//           position: destinationLocation.value!,
//           infoWindow: InfoWindow(title: 'Destination'),
//           icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
//         ),
//       );
//     }
//   }

//   // Method to generate polyline
//   void generatePolyline() {
//     polylines.clear();
//     if (pickupLocation.value != null && destinationLocation.value != null) {
//       final String polylineIdVal = 'route_polyline';
//       final PolylineId polylineId = PolylineId(polylineIdVal);

//       final Polyline polyline = Polyline(
//         polylineId: polylineId,
//         color: const Color(0xFFC0392B), // Red color for the polyline
//         points: [
//           pickupLocation.value!,
//           destinationLocation.value!,
//         ],
//         width: 5,
//         geodesic: true,
//       );
//       polylines.add(polyline);
//     }
//   }

//   // Method to calculate straight-line distance
//   void _calculateDistance() {
//     if (pickupLocation.value != null && destinationLocation.value != null) {
//       final double calculatedDistance = Geolocator.distanceBetween(
//         pickupLocation.value!.latitude,
//         pickupLocation.value!.longitude,
//         destinationLocation.value!.latitude,
//         destinationLocation.value!.longitude,
//       );
//       // Convert meters to kilometers and round to 1 decimal place
//       distance.value = (calculatedDistance / 1000).toPrecision(1);
//     } else {
//       distance.value = 0.0;
//     }
//   }

//   // 🔹 Add this:
// void recalculateDistance() => _calculateDistance();

//   void searchLocation(String query) {
//     searchQuery.value = query;
//     if (query.isEmpty) {
//       searchResults.clear();
//       return;
//     }

//     isSearching.value = true;

//     // Simulate search results - replace with actual API call (e.g., Google Places API)
//     Future.delayed(const Duration(milliseconds: 500), () {
//       searchResults.value = [
//         '${query} Rd, Dhaka, Bangladesh',
//         '${query} Market, Dhaka, Bangladesh',
//         '${query} Tower, Dhaka, Bangladesh',
//         '${query} Apartment, Dhaka, Bangladesh',
//         '${query} Station, Dhaka, Bangladesh',
//       ];
//       isSearching.value = false;
//     });
//   }

//   void clearSearch() {
//     searchQuery.value = '';
//     searchResults.clear();
//   }

//   void selectSearchResult(String address) async {
//     destinationAddress.value = address;
//     searchResults.clear();
//     searchQuery.value = ''; // Clear search query after selection

//     // Try to get LatLng from address (geocoding) and set destinationLocation
//     try {
//       List<Location> locations = await locationFromAddress(address);
//       if (locations.isNotEmpty) {
//         setDestinationLocation(LatLng(locations.first.latitude, locations.first.longitude));
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to get coordinates for selected address: $e');
//     }
//   }

//   void selectSavedLocation(String type) async {
//     String addressToSet = '';
//     switch (type) {
//       case 'home':
//         addressToSet = homeAddress.value;
//         break;
//       case 'work':
//         addressToSet = workAddress.value;
//         break;
//       case 'favorite':
//         addressToSet = favoriteAddress.value;
//         break;
//     }
//     destinationAddress.value = addressToSet;

//     // Try to get LatLng from address (geocoding) and set destinationLocation
//     try {
//       List<Location> locations = await locationFromAddress(addressToSet);
//       if (locations.isNotEmpty) {
//         setDestinationLocation(LatLng(locations.first.latitude, locations.first.longitude));
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to get coordinates for saved address: $e');
//     }
//   }


// double calculateDistanceBetween(LatLng start, LatLng end) {
//   final double distanceInMeters = Geolocator.distanceBetween(
//     start.latitude,
//     start.longitude,
//     end.latitude,
//     end.longitude,
//   );
//   // Convert meters to kilometers
//   return distanceInMeters / 1000;
// }



// }




