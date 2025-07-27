// lib/feature/map/controllers/locaion_controller.dart
import 'dart:ui';

import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationController extends GetxController {
  // Location state
  var currentPosition = Rxn<Position>(); // Keep this for raw geolocator position
  var currentLocation = Rxn<LatLng>(); // Add this for LatLng format
  var pickupLocation = Rxn<LatLng>();
  var destinationLocation = Rxn<LatLng>();
  var pickupAddress = ''.obs;
  var destinationAddress = ''.obs;
  var distance = 0.0.obs; // Added for distance calculation

  // Map state
  var mapController = Rxn<GoogleMapController>();
  var markers = <Marker>{}.obs;
  var polylines = <Polyline>{}.obs; // Add this for polylines

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

  @override
  void onInit() {
    super.onInit();
    requestLocationPermission();
    getCurrentLocation();
    // Listen for changes in pickup or destination to regenerate polyline and distance
    everAll([pickupLocation, destinationLocation], (_) {
      generatePolyline();
      _calculateDistance(); // Calculate distance whenever locations change
    });
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
      if (isLocationPermissionGranted.value) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        currentPosition.value = position;
        currentLocation.value = LatLng(position.latitude, position.longitude); // Set currentLocation
        pickupLocation.value = LatLng(position.latitude, position.longitude);
        await getAddressFromCoordinates(position.latitude, position.longitude, true);
        updateMapMarkers();
        // Move camera to current location if map controller is ready
        if (mapController.value != null && currentLocation.value != null) {
          mapController.value!.animateCamera(
            CameraUpdate.newLatLngZoom(currentLocation.value!, 14.0),
          );
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get current location: $e');
    }
  }

  Future<void> getAddressFromCoordinates(double lat, double lng, bool isPickup) async {
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
        ].where((element) => element != null && element.isNotEmpty).join(', ');

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
    if (mapController.value != null && pickupLocation.value != null && destinationLocation.value != null) {
      LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          pickupLocation.value!.latitude < destinationLocation.value!.latitude
              ? pickupLocation.value!.latitude
              : destinationLocation.value!.latitude,
          pickupLocation.value!.longitude < destinationLocation.value!.longitude
              ? pickupLocation.value!.longitude
              : destinationLocation.value!.longitude,
        ),
        northeast: LatLng(
          pickupLocation.value!.latitude > destinationLocation.value!.latitude
              ? pickupLocation.value!.latitude
              : destinationLocation.value!.latitude,
          pickupLocation.value!.longitude > destinationLocation.value!.longitude
              ? pickupLocation.value!.longitude
              : destinationLocation.value!.longitude,
        ),
      );
      mapController.value!.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
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
          markerId: MarkerId('pickup'),
          position: pickupLocation.value!,
          infoWindow: InfoWindow(title: 'My Location'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        ),
      );
    }

    if (destinationLocation.value != null) {
      markers.add(
        Marker(
          markerId: MarkerId('destination'),
          position: destinationLocation.value!,
          infoWindow: InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        ),
      );
    }
  }

  // Method to generate polyline
  void generatePolyline() {
    polylines.clear();
    if (pickupLocation.value != null && destinationLocation.value != null) {
      final String polylineIdVal = 'route_polyline';
      final PolylineId polylineId = PolylineId(polylineIdVal);

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

  // Method to calculate straight-line distance
  void _calculateDistance() {
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
        setDestinationLocation(LatLng(locations.first.latitude, locations.first.longitude));
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get coordinates for selected address: $e');
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
        setDestinationLocation(LatLng(locations.first.latitude, locations.first.longitude));
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get coordinates for saved address: $e');
    }
  }
}





// work perfectlly for th car selection screen




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

//   @override
//   void onInit() {
//     super.onInit();
//     requestLocationPermission();
//     getCurrentLocation();
//     // Listen for changes in pickup or destination to regenerate polyline
//     everAll([pickupLocation, destinationLocation], (_) => generatePolyline());
    
//   }

//   Future<void> requestLocationPermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }

//     isLocationPermissionGranted.value =
//         permission == LocationPermission.whileInUse ||
//         permission == LocationPermission.always;
//   }

//   Future<void> getCurrentLocation() async {
//     try {
//       if (isLocationPermissionGranted.value) {
//         Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high,
//         );
//         currentPosition.value = position;
//         currentLocation.value = LatLng(position.latitude, position.longitude); // Set currentLocation
//         pickupLocation.value = LatLng(position.latitude, position.longitude);
//         await getAddressFromCoordinates(position.latitude, position.longitude, true);
//         updateMapMarkers();
//         // Move camera to current location if map controller is ready
//         if (mapController.value != null && currentLocation.value != null) {
//           mapController.value!.animateCamera(
//             CameraUpdate.newLatLngZoom(currentLocation.value!, 14.0),
//           );
//         }
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to get current location: $e');
//     }
//   }

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
//           infoWindow: InfoWindow(title: 'My Location'), // Changed to "My Location"
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

//   // New method to generate polyline
//   void generatePolyline() {
//     polylines.clear();
//     if (pickupLocation.value != null && destinationLocation.value != null) {
//       final String polylineIdVal = 'route_polyline';
//       final PolylineId polylineId = PolylineId(polylineIdVal);

//       final Polyline polyline = Polyline(
//         polylineId: polylineId,
//         color:  Color(0xFFC0392B), // Red color for the polyline
//         points: [
//           pickupLocation.value!,
//           destinationLocation.value!,
//         ],
//         width: 5,
//         geodesic: true, // Follows the curvature of the earth
//       );
//       polylines.add(polyline);
//     }
//   }

//   void searchLocation(String query) {
//     searchQuery.value = query;
//     if (query.isEmpty) {
//       searchResults.clear();
//       return;
//     }

//     isSearching.value = true;

//     // Simulate search results - replace with actual API call
//     Future.delayed(const Duration(milliseconds: 500), () {
//       searchResults.value = [
//         '$query - Main Street',
//         '$query - Downtown',
//         '$query - City Center',
//         '$query - Shopping Mall',
//         '$query - Airport',
//       ];
//       isSearching.value = false;
//     });
//   }

//   void clearSearch() {
//     searchQuery.value = '';
//     searchResults.clear();
//   }

//   void selectSearchResult(int index) async {
//     final String address = searchResults[index];
//     destinationAddress.value = address;
//     searchResults.clear();

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
// }





// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';

// class LocationController extends GetxController {
//   // Location state
//   var currentPosition = Rxn<Position>();
//   var pickupLocation = Rxn<LatLng>();
//   var destinationLocation = Rxn<LatLng>();
//   var pickupAddress = ''.obs;
//   var destinationAddress = ''.obs;
  
//   // Map state
//   var mapController = Rxn<GoogleMapController>();
//   var markers = <Marker>{}.obs;
//   var isLocationPermissionGranted = false.obs;
  
//   // Search state
//   var searchResults = <String>[].obs;
//   var isSearching = false.obs;
//   var searchQuery = ''.obs;
//     RxString selectedAddress = ''.obs;
  
//   // Saved locations
//   // var homeAddress = '1234 Elm Street, City, State 12345'.obs;
//   // var workAddress = '5678 Oak Avenue, City, State 67890'.obs;
//   // var favoriteAddress = '9012 Pine Road, City, State 34567'.obs;

//   // You probably already have these
//   RxString homeAddress = 'Mohakhali DOHS, Dhaka'.obs;
//   RxString workAddress = 'Gulshan 2, Dhaka'.obs;
//   RxString favoriteAddress = 'Banani, Dhaka'.obs;
  
//   @override
//   void onInit() {
//     super.onInit();
//     requestLocationPermission();
//     getCurrentLocation();
//   }
  
//   Future<void> requestLocationPermission() async {
//     LocationPermission permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//     }
    
//     isLocationPermissionGranted.value = 
//         permission == LocationPermission.whileInUse || 
//         permission == LocationPermission.always;
//   }
  
//   Future<void> getCurrentLocation() async {
//     try {
//       if (isLocationPermissionGranted.value) {
//         Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high,
//         );
//         currentPosition.value = position;
//         pickupLocation.value = LatLng(position.latitude, position.longitude);
//         await getAddressFromCoordinates(position.latitude, position.longitude, true);
//         updateMapMarkers();
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to get current location: $e');
//     }
//   }
  
//   Future<void> getAddressFromCoordinates(double lat, double lng, bool isPickup) async {
//     try {
//       List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
//       if (placemarks.isNotEmpty) {
//         Placemark place = placemarks[0];
//         String address = '${place.street}, ${place.locality}, ${place.administrativeArea} ${place.postalCode}';
        
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
//   }
  
//   void setMapController(GoogleMapController controller) {
//     mapController.value = controller;
//   }
  
//   void updateMapMarkers() {
//     markers.clear();
    
//     if (pickupLocation.value != null) {
//       markers.add(
//         Marker(
//           markerId: MarkerId('pickup'),
//           position: pickupLocation.value!,
//           infoWindow: InfoWindow(title: 'Pickup Location'),
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
  
//   void searchLocation(String query) {
//     searchQuery.value = query;
//     if (query.isEmpty) {
//       searchResults.clear();
//       return;
//     }
    
//     isSearching.value = true;
    
//     // Simulate search results - replace with actual API call
//     Future.delayed(Duration(milliseconds: 500), () {
//       searchResults.value = [
//         '$query - Main Street',
//         '$query - Downtown',
//         '$query - City Center',
//         '$query - Shopping Mall',
//         '$query - Airport',
//       ];
//       isSearching.value = false;
//     });
//   }
  
//   void clearSearch() {
//     searchQuery.value = '';
//     searchResults.clear();
//   }
  
//   void selectSearchResult(int index) {
//     destinationAddress.value = searchResults[index];
//     searchResults.clear();
//   }
  
//   void selectSavedLocation(String type) {
//     switch (type) {
//       case 'home':
//         destinationAddress.value = homeAddress.value;
//         break;
//       case 'work':
//         destinationAddress.value = workAddress.value;
//         break;
//       case 'favorite':
//         destinationAddress.value = favoriteAddress.value;
//         break;
//     }
//   }
// }