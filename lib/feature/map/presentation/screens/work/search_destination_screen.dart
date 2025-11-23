import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/locaion_controller.dart';
import '../../../controllers/location_picked_controller.dart';
import 'car_selection_map_screen.dart';

class SearchDestinationScreen extends StatefulWidget {
  final ScrollController? scrollController;

  const SearchDestinationScreen({super.key, this.scrollController});

  @override
  State<SearchDestinationScreen> createState() =>
      _SearchDestinationScreenState();
}

class _SearchDestinationScreenState extends State<SearchDestinationScreen> {
  final LocationController locationController = Get.find<LocationController>();
  final AppController appController = Get.find<AppController>();
  final LocationPickedController locationPickedController =
      Get.find<LocationPickedController>();

  final TextEditingController searchTextController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  bool isSearching = false;
  bool isSearchMode = false;
  List<String> searchResults = [];

  @override
  void initState() {
    super.initState();

    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        setState(() {
          isSearchMode = true;
        });
      }
    });
  }

  Future<void> performSearch(String query) async {
    locationPickedController.searchChanged(query);
    setState(() {
      isSearching = true;
      isSearchMode = true;
    });

    await Future.delayed(Duration(milliseconds: 500));
    setState(() {
      isSearching = false;
    });
  }

  void clearSearch() {
    setState(() {
      searchResults.clear();
      searchTextController.clear();
      isSearchMode = false;
    });
  }

  void handleSearchSubmit(String value) {
    if (value.isNotEmpty) {
      performSearch(value);
    }
  }

  // Enhanced geocoding with multiple fallback strategies
  Future<LatLng?> getCoordinatesFromAddress(String address) async {
    try {
      debugPrint("🔍 Attempting to geocode: $address");

      // Strategy 1: Try with original address
      try {
        List<Location> locations = await locationFromAddress(address);
        if (locations.isNotEmpty) {
          debugPrint(
            "✅ Geocoding successful (original): ${locations.first.latitude}, ${locations.first.longitude}",
          );
          return LatLng(locations.first.latitude, locations.first.longitude);
        }
      } catch (e) {
        debugPrint("⚠️ Original address failed: $e");
      }

      // Strategy 2: Try with ", Bangladesh" appended
      try {
        String addressWithCountry = "$address, Bangladesh";
        List<Location> locations = await locationFromAddress(
          addressWithCountry,
        );
        if (locations.isNotEmpty) {
          debugPrint(
            "✅ Geocoding successful (with country): ${locations.first.latitude}, ${locations.first.longitude}",
          );
          return LatLng(locations.first.latitude, locations.first.longitude);
        }
      } catch (e) {
        debugPrint("⚠️ Address with country failed: $e");
      }

      // Strategy 3: Try with ", Dhaka, Bangladesh"
      if (!address.toLowerCase().contains('dhaka')) {
        try {
          String addressWithCity = "$address, Dhaka, Bangladesh";
          List<Location> locations = await locationFromAddress(addressWithCity);
          if (locations.isNotEmpty) {
            debugPrint(
              "✅ Geocoding successful (with city): ${locations.first.latitude}, ${locations.first.longitude}",
            );
            return LatLng(locations.first.latitude, locations.first.longitude);
          }
        } catch (e) {
          debugPrint("⚠️ Address with city failed: $e");
        }
      }

      // Strategy 4: Extract main location name and try
      List<String> parts = address.split(',');
      if (parts.isNotEmpty) {
        try {
          String mainLocation = "${parts[0].trim()}, Dhaka, Bangladesh";
          List<Location> locations = await locationFromAddress(mainLocation);
          if (locations.isNotEmpty) {
            debugPrint(
              "✅ Geocoding successful (main location): ${locations.first.latitude}, ${locations.first.longitude}",
            );
            return LatLng(locations.first.latitude, locations.first.longitude);
          }
        } catch (e) {
          debugPrint("⚠️ Main location failed: $e");
        }
      }

      debugPrint("❌ All geocoding strategies failed");
      return null;
    } catch (e) {
      debugPrint("❌ Geocoding error: $e");
      return null;
    }
  }

  // Future<void> goToMapWithCoordinates(
  //   String address, {
  //   LatLng? placeLatLng,
  // }) async {
  //   try {
  //     appController.showLoading();

  //     LatLng? destination;

  //     // If we have coordinates from Places API (from suggestions), use them directly
  //     if (placeLatLng != null) {
  //       debugPrint(
  //         "✅ Using coordinates from Places API: ${placeLatLng.latitude}, ${placeLatLng.longitude}",
  //       );
  //       destination = placeLatLng;
  //     } else {
  //       // Otherwise, try to geocode the address
  //       destination = await getCoordinatesFromAddress(address);
  //     }

  //     if (destination != null) {
  //       // Set destination in location controller
  //       locationController.setDestinationLocation(destination);
  //       locationController.selectedAddress.value = address;

  //       // Generate polyline and calculate distance
  //       locationController.generatePolyline();

  //       appController.hideLoading();
  //       appController.setCurrentScreen('map');

  //       // Navigate to map screen
  //       Get.to(() => CarSelectionMapScreen());
  //     } else {
  //       appController.hideLoading();

  //       // Show more helpful error message with suggestions
  //       Get.snackbar(
  //         'Location Not Found',
  //         'Could not find "$address". Try:\n• Adding more details (street, area)\n• Using a landmark name\n• Searching from the map',
  //         backgroundColor: Colors.orange,
  //         colorText: Colors.white,
  //         duration: Duration(seconds: 5),
  //         snackPosition: SnackPosition.BOTTOM,
  //       );
  //     }
  //   } catch (e) {
  //     appController.hideLoading();
  //     debugPrint("❌ Error in goToMapWithCoordinates: $e");
  //     Get.snackbar(
  //       'Error',
  //       'Something went wrong. Please try again.',
  //       backgroundColor: Colors.red,
  //       colorText: Colors.white,
  //     );
  //   }
  // }

  Future<void> goToMapWithCoordinates(String address, {LatLng? placeLatLng}) async {
  try {
    appController.showLoading();
    
    LatLng? destination;

    // If we already have coordinates from Places API (from suggestions), use them directly
    if (placeLatLng != null) {
      debugPrint("✅ Using coordinates from Places API: ${placeLatLng.latitude}, ${placeLatLng.longitude}");
      destination = placeLatLng;
    } else {
      // Otherwise, try to geocode the address
      destination = await getCoordinatesFromAddress(address);
    }
    
    if (destination != null) {
      // 🔹 1. Make sure pickup is current location
      if (locationController.currentLocation.value != null) {
        locationController.setPickupLocation(
          locationController.currentLocation.value!,
        );
      }

      // 🔹 2. Set destination
      locationController.setDestinationLocation(destination);
      locationController.selectedAddress.value = address;

      // (everAll in LocationController will draw polyline + distance)
      
      appController.hideLoading();
      appController.setCurrentScreen('map');

      // 🔹 3. Go to map
      Get.to(() => CarSelectionMapScreen());
    } else {
      appController.hideLoading();
      Get.snackbar(
        'Location Not Found',
        'Could not find "$address". Try adding more details.',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  } catch (e) {
    appController.hideLoading();
    debugPrint("❌ Error in goToMapWithCoordinates: $e");
    Get.snackbar(
      'Error',
      'Something went wrong. Please try again.',
      backgroundColor: Colors.red,
      colorText: Colors.white,
    );
  }
}


  Future<void> handleSavedLocationTap(String address) async {
    await goToMapWithCoordinates(address);
  }

  // Handle suggestion tap with place_id to get coordinates
  Future<void> handleSuggestionTap(dynamic suggestion) async {
    try {
      appController.showLoading();
      String address = suggestion.description ?? '';
      LatLng? placeLatLng;
      // If your LocationPickedController has a method to get place details by place_id
      // you should use that to get exact coordinates. For now, we'll use geocoding.

      // Check if the suggestion object has lat/lng directly
      // 1️⃣ Try to get exact coordinates from Places Details API
      if (suggestion.placeId != null && suggestion.placeId!.isNotEmpty) {
        placeLatLng = await locationPickedController.getPlaceDetails(
          suggestion.placeId!,
        );
      }

      // 2️⃣ Fall back to geocoding if needed
      await goToMapWithCoordinates(address, placeLatLng: placeLatLng);
    } catch (e) {
      debugPrint("❌ Error handling suggestion: $e");
      appController.hideLoading();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BackButton(color: Colors.white),
              Text(
                'Search your destination',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(width: 50),
            ],
          ),
          Container(
            padding: EdgeInsets.all(16),
            child: TextField(
              controller: searchTextController,
              focusNode: searchFocusNode,
              textInputAction: TextInputAction.search,
              onChanged: (value) {
                performSearch(value);
                setState(() {}); // Rebuild to show/hide clear button
              },
              onSubmitted: handleSearchSubmit,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Where are you going?',
                hintStyle: TextStyle(color: Colors.white, fontSize: 14),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.search, color: Colors.white),
                ),
                suffixIcon: searchTextController.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.clear, color: Colors.grey),
                        onPressed: clearSearch,
                      )
                    : null,
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          if (isSearchMode)
            if (isSearching)
              Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(color: Colors.red),
              )
            else
              Expanded(
                child: Obx(() {
                  final results =
                      locationPickedController.autoCompliteSuggetion;

                  if (results.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          'No results found.\nTry searching for landmarks or areas.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: results.length,
                    itemBuilder: (context, index) {
                      final suggestion = results[index];
                      return ListTile(
                        leading: Icon(Icons.location_on, color: Colors.white),
                        title: Text(
                          suggestion.description ?? '',
                          style: TextStyle(color: Colors.white),
                        ),
                        onTap: () async {
                          await handleSuggestionTap(suggestion);
                        },
                      );
                    },
                  );
                }),
              )
          // Expanded(
          //   child: ObxValue(
          //     (results) => results.isEmpty
          //         ? Center(
          //             child: Padding(
          //               padding: const EdgeInsets.all(24.0),
          //               child: Text(
          //                 'No results found.\nTry searching for landmarks or areas.',
          //                 textAlign: TextAlign.center,
          //                 style: TextStyle(
          //                   color: Colors.grey,
          //                   fontSize: 14,
          //                 ),
          //               ),
          //             ),
          //           )
          //         : ListView.builder(
          //             itemCount: results.length,
          //             itemBuilder: (context, index) {
          //               return ListTile(
          //                 leading: Icon(Icons.location_on, color: Colors.white),
          //                 title: Text(
          //                   results[index].description,
          //                   style: TextStyle(color: Colors.white),
          //                 ),
          //                 onTap: () async {
          //                   await handleSuggestionTap(results[index]);
          //                 },
          //               );
          //             },
          //           ),
          //     locationPickedController.autoCompliteSuggetion,
          //   ),
          // )
          else
            Expanded(
              child: ListView(
                controller: widget.scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _buildPaymentItem(
                    icon: Icons.home,
                    title: 'Home',
                    subtitle: locationController.homeAddress.value,
                    onTap: () => handleSavedLocationTap(
                      locationController.homeAddress.value,
                    ),
                  ),
                  _buildPaymentItem(
                    icon: Icons.work,
                    title: 'Work',
                    subtitle: locationController.workAddress.value,
                    onTap: () => handleSavedLocationTap(
                      locationController.workAddress.value,
                    ),
                  ),
                  _buildPaymentItem(
                    icon: Icons.star,
                    title: 'Favorite Location',
                    subtitle: locationController.favoriteAddress.value,
                    onTap: () => handleSavedLocationTap(
                      locationController.favoriteAddress.value,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPaymentItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white10,
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(color: Colors.grey, fontSize: 14),
                  ),
                ],
              ),
            ),
            // Show distance if available
            FutureBuilder<double>(
              future: _calculateDistanceForSavedPlace(subtitle),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data! > 0) {
                  return Text(
                    "${snapshot.data!.toStringAsFixed(1)}km",
                    style: TextStyle(color: Colors.white),
                  );
                }
                return SizedBox.shrink();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<double> _calculateDistanceForSavedPlace(String address) async {
    if (locationController.currentLocation.value == null) {
      return 0.0;
    }

    try {
      LatLng? destination = await getCoordinatesFromAddress(address);
      if (destination != null) {
        return locationController.calculateDistanceBetween(
          locationController.currentLocation.value!,
          destination,
        );
      }
    } catch (e) {
      debugPrint("Error calculating distance: $e");
    }
    return 0.0;
  }

  @override
  void dispose() {
    searchTextController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../controllers/app_controller.dart';
// import '../../../controllers/locaion_controller.dart';
// import '../../../controllers/location_picked_controller.dart';
// import 'car_selection_map_screen.dart';

// class SearchDestinationScreen extends StatefulWidget {
//   final ScrollController? scrollController;


//   const SearchDestinationScreen({super.key, this.scrollController});

//   @override
//   State<SearchDestinationScreen> createState() =>
//       _SearchDestinationScreenState();
// }

// class _SearchDestinationScreenState extends State<SearchDestinationScreen> {
//   final LocationController locationController = Get.find<LocationController>();
//   final AppController appController = Get.find<AppController>();
//   final LocationPickedController locationPickedController = LocationPickedController();


//   final TextEditingController searchTextController = TextEditingController();
//   final FocusNode searchFocusNode = FocusNode();

//   bool isSearching = false;
//   bool isSearchMode = false;
//   List<String> searchResults = [];

//   @override
//   void initState() {
//     super.initState();

//     searchFocusNode.addListener(() {
//       if (searchFocusNode.hasFocus) {
//         setState(() {
//           isSearchMode = true;
//         });
//       }
//     });
//   }

//   Future<void> performSearch(String query) async {
//     locationPickedController.searchChanged(query);
//     setState(() {
//       isSearching = true;
//       isSearchMode = true;
//     });

//     // Simulate network call or controller logic
//     await Future.delayed(Duration(milliseconds: 500));
//     setState(() {
//       searchResults = ['$query Street', '$query Avenue', '$query Park'];
//       isSearching = false;
//     });
//   }

//   void clearSearch() {
//     setState(() {
//       searchResults.clear();
//       searchTextController.clear();
//       isSearchMode = false;
//     });
//   }

//   void handleSearchSubmit(String value) {
//     if (value.isNotEmpty) {
//       performSearch(value);
//       goToMap(value);
//     }
//   }

//   void goToMap(String destination) {
//     locationController.selectedAddress.value = destination;
//     appController.setCurrentScreen('map');
//     Get.to(() => CarSelectionMapScreen());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Column(
//         children: [
//           const SizedBox(height: 16),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               BackButton(color: Colors.white),
//               Text(
//                 'Search your destination',
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//               const SizedBox(width: 50),
//             ],
//           ),
//           Container(
//             padding: EdgeInsets.all(16),
//             child: TextField(
//               controller: searchTextController,
//               focusNode: searchFocusNode,
//               textInputAction: TextInputAction.search,
//               onChanged: (value) => performSearch(value),
//               onSubmitted: handleSearchSubmit,
//               style: TextStyle(color: Colors.white),
//               decoration: InputDecoration(
//                 hintText: 'Where are you going?',
//                 hintStyle: TextStyle(color: Colors.white, fontSize: 14),
//                 prefixIcon: Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Icon(Icons.search, color: Colors.white),
//                 ),
//                 suffixIcon: searchTextController.text.isNotEmpty
//                     ? IconButton(
//                         icon: Icon(Icons.clear, color: Colors.grey),
//                         onPressed: clearSearch,
//                       )
//                     : null,
//                 filled: true,
//                 fillColor: Colors.white24,
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8),
//                   borderSide: BorderSide.none,
//                 ),
//               ),
//             ),
//           ),

//           if (isSearchMode)
//             if (isSearching)
//               Padding(
//                 padding: EdgeInsets.all(16),
//                 child: CircularProgressIndicator(color: Colors.red),
//               )
//             else
//               Expanded(
//                 child: ObxValue(
//                   (results)=> ListView.builder(
//                     itemCount: results.length,
//                     itemBuilder: (context, index) {
//                       return ListTile(
//                         leading: Icon(Icons.location_on, color: Colors.white),
//                         title: Text(
//                           results[index].description,
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         onTap: () {
//                           goToMap(results[index].description);
//                         },
//                       );
//                     },
//                   ),
//                   locationPickedController.autoCompliteSuggetion
//                 ),
//               )
//           else
//             Expanded(
//               child: ListView(
//                 controller: widget.scrollController,
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 children: [
//                   _buildPaymentItem(
//                     icon: Icons.home,
//                     title: 'Home',
//                     subtitle: locationController.homeAddress.value,
//                     onTap: () => goToMap(locationController.homeAddress.value),
//                   ),
//                   _buildPaymentItem(
//                     icon: Icons.work,
//                     title: 'Work',
//                     subtitle: locationController.workAddress.value,
//                     onTap: () => goToMap(locationController.workAddress.value),
//                   ),
//                   _buildPaymentItem(
//                     icon: Icons.star,
//                     title: 'Favorite Location',
//                     subtitle: locationController.favoriteAddress.value,
//                     onTap: () =>
//                         goToMap(locationController.favoriteAddress.value),
//                   ),
//                 ],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPaymentItem({
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.all(16),
//         margin: EdgeInsets.only(bottom: 12),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(8),
//           color: Colors.white10,
//         ),
//         child: Row(
//           children: [
//             Icon(icon, color: Colors.white, size: 24),
//             SizedBox(width: 16),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                   SizedBox(height: 4),
//                   Text(
//                     subtitle,
//                     style: TextStyle(color: Colors.grey, fontSize: 14),
//                   ),
//                 ],
//               ),
//             ),
//             Text("2.7km", style: TextStyle(color: Colors.white)),
//           ],
//         ),
//       ),
//     );
//   }
// }
