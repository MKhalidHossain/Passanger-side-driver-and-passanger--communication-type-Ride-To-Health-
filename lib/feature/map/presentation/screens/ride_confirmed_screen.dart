import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideztohealth/core/extensions/text_extensions.dart';
import 'package:rideztohealth/core/widgets/normal_custom_button.dart';
import 'package:rideztohealth/core/widgets/normal_custom_icon_button.dart';

import '../../../../core/constants/app_colors.dart';
import 'call_screen.dart';
import 'chat_screen.dart';
import 'payment_details_screen.dart'; // Navigate to payment screen

class RideConfirmedScreen extends StatefulWidget {
  @override
  State<RideConfirmedScreen> createState() => _RideConfirmedScreenState();
}

class _RideConfirmedScreenState extends State<RideConfirmedScreen> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedProfile;

  bool _showProfileError = false;

  void _onProfileSelected(String profileType) {
    setState(() {
      _selectedProfile = profileType;
      _showProfileError = false;
    });
  }

  Widget _buildProfileOption({
    required String type,
    required String description,
    required String imagePath,
  }) {
    final isSelected = _selectedProfile == type;

    return GestureDetector(
      onTap: () => _onProfileSelected(type),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              // ignore: deprecated_member_use
              ? AppColors.context(context).primaryColor.withOpacity(0.08)
              : Colors.white12,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.context(context).primaryColor
                : Colors.grey.withOpacity(0.07),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? AppColors.context(context).primaryColor.withOpacity(0.1)
                    : Colors.white12,
              ),
              child: Image.asset(imagePath, height: 30, width: 30),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Get.back(),
                  ),
                  Text(
                    'Your driver is coming in 3:00',
                    style: TextStyle(color: Colors.white, fontSize: 15),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Driver Profile Card
              Divider(color: Colors.grey[700], thickness: 0.5),
              Container(
                padding: EdgeInsets.only(left: 15, right: 15),
                decoration: BoxDecoration(
                  //  color: const Color(0xFF3B3B42),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 30,

                      backgroundImage: AssetImage(
                        'assets/images/user6.png',
                      ), // Replace with actual image
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Max Johnson',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  "4.0km: 4140 Parker Rd".text12White(),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              SizedBox(width: 5),
                              "4.9".text14White(),
                              " (127)".text12Grey(),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/privet_car.png', // Car icon
                      width: 80,
                      // height: 80,
                      fit: BoxFit.contain,
                    ),
                  ],
                ),
              ),
              Divider(color: Colors.grey[700], thickness: 0.5),
              SizedBox(height: 20),
              // Payment Method Section
              _buildProfileOption(
                type: "Cash",
                description: "Pay with cash after your ride",

                imagePath: 'assets/icons/dollarIcon.png',
              ),
              _buildProfileOption(
                type: "Wallet",
                description: "Balance: \$45.50",
                imagePath: 'assets/icons/walletIocn.png',
              ),

              SizedBox(height: 20),
              // Divider(color: Colors.grey[700], thickness: 1.5),
              // SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    height: 51,
                    width: size.width * 0.7,
                    child: TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white12,
                        hintText: 'Enter coupon code',
                        hintStyle: const TextStyle(color: Colors.white54),
                        // prefixIcon: const Icon(
                        //   Icons.search,
                        //   color: Colors.white,
                        // ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  NormalCustomButton(
                    height: 51,
                    weight: size.width * 0.2,

                    text: "Apply",
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey[700], thickness: 1.5),
              // Total Price
              Container(
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  //color: const Color(0xFF3B3B42),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    "Total".text16White500(),
                    // Text(
                    //   'Total',
                    //   style: TextStyle(
                    //     color: AppColors.context(context).textColor,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                    "\$32.50".text16White500(),
                    // Text(
                    //   '\$32.50',
                    //   style: TextStyle(
                    //     color: Colors.white,
                    //     fontSize: 16,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Spacer(),
              // NormalCustomIconButton(
              //   icon: Icons.call_outlined,
              //   iconSize: 30,
              //   onPressed: () {
              //     Get.to(CallScreen());
              //   },
              // ),

              // Bottom Action Buttons
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: NormalCustomIconButton(
                      icon: Icons.call_outlined,
                      iconSize: 30,
                      onPressed: () {
                        Get.to(CallScreen());
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 1,
                    child: NormalCustomIconButton(
                      icon: Icons.messenger_outline,
                      iconSize: 30,
                      onPressed: () {
                        Get.to(ChatScreen());
                      },
                    ),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    flex: 3,
                    child: NormalCustomButton(
                      height: 51,
                      fontSize: 18,
                      circularRadious: 30,
                      text: "Cencel Ride",
                      onPressed: () {
                        // Get.to();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}












// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../controllers/app_controller.dart';
// import '../../controllers/booking_controller.dart';
// import '../../controllers/locaion_controller.dart';

// // This screen displays a Google Map in the background and a bottom sheet
// // for confirming location, which now occupies 85% of the screen height.
// // It integrates with GetX controllers for location, booking, and app state.
// class RideConfirmedScreen extends StatelessWidget {
//   // Find and inject the necessary GetX controllers.
//   final LocationController locationController = Get.find<LocationController>();
//   final BookingController bookingController = Get.find<BookingController>();
//   final AppController appController = Get.find<AppController>();

//   // Initial camera position for the map, defaulting to Dhaka, Bangladesh.
//   static const CameraPosition _initialPosition = CameraPosition(
//     target: LatLng(23.8103, 90.4125), // Dhaka, Bangladesh coordinates
//     zoom: 14.0,
//   );

//   @override
//   Widget build(BuildContext context) {
//     // Calculate 85% of the screen height for the bottom sheet.
//     final double screenHeight = MediaQuery.of(context).size.height;
//     final double bottomSheetHeight = screenHeight * 0.85;
//     // Calculate the top position for the bottom sheet to achieve 85% height.
//     final double bottomSheetTopPosition = screenHeight - bottomSheetHeight;

//     return Scaffold(
//       body: Obx(
//         () => Stack(
//           children: [
//             // Google Map: This will occupy the full background.
//             GoogleMap(
//               onMapCreated: (GoogleMapController controller) {
//                 locationController.setMapController(controller);
//                 // If current location is available, animate camera to it.
//                 if (locationController.currentLocation.value != null) {
//                   controller.animateCamera(
//                     CameraUpdate.newLatLngZoom(
//                       locationController.currentLocation.value!,
//                       14.0,
//                     ),
//                   );
//                 }
//               },
//               initialCameraPosition: _initialPosition,
//               markers: locationController.markers,
//               polylines: locationController
//                   .polylines, // Display the polyline from current to destination.
//               myLocationEnabled: true, // Show user's current location dot.
//               myLocationButtonEnabled:
//                   false, // Hide default "my location" button.
//               onTap: (LatLng position) {
//                 // Allow users to tap on the map to set a new destination.
//                 locationController.setDestinationLocation(position);
//                 // The polyline and distance will automatically update due to Obx listeners.
//               },
//             ),

//             // Back button: Positioned at the top-left of the screen.
//             Positioned(
//               top: 50,
//               left: 20,
//               child: GestureDetector(
//                 onTap: () =>
//                     Get.back(), // Navigate back to the previous screen.
//                 child: Container(
//                   padding: const EdgeInsets.all(8),
//                   decoration: const BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(Icons.arrow_back, color: Colors.black),
//                 ),
//               ),
//             ),

//             // Red target icon: Positioned on the middle-right of the screen.
//             Positioned(
//               top: screenHeight * 0.45, // Approximately centered vertically.
//               right: 20,
//               child: GestureDetector(
//                 onTap: () {
//                   // Re-center map on current location if available.
//                   if (locationController.currentLocation.value != null &&
//                       locationController.mapController.value != null) {
//                     locationController.mapController.value!.animateCamera(
//                       CameraUpdate.newLatLngZoom(
//                         locationController.currentLocation.value!,
//                         14.0,
//                       ),
//                     );
//                   }
//                 },
//                 child: Container(
//                   width: 50,
//                   height: 50,
//                   decoration: const BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                   child: const Icon(
//                     Icons.my_location,
//                     color: Colors.white,
//                     size: 30,
//                   ),
//                 ),
//               ),
//             ),

//             // CONFIRM YOUR LOCATION BOTTOM SHEET: This is the main content,
//             // positioned to take up 85% of the screen height from the bottom.
//             Positioned(
//               top:
//                   bottomSheetTopPosition, // Calculated top position for 85% height.
//               left: 0,
//               right: 0,
//               bottom: 0, // Extends to the very bottom of the screen.
//               child: Container(
//                 padding: EdgeInsets.only(
//                   top: 10,
//                   left: 20,
//                   right: 20,
//                   // Add padding for the safe area at the bottom (e.g., iPhone X notch).
//                   bottom: MediaQuery.of(context).padding.bottom + 10,
//                 ),
//                 decoration: const BoxDecoration(
//                   color: Color(
//                     0xFF2E2E38,
//                   ), // Dark grey background for the sheet.
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize
//                       .min, // Column takes minimum space required by its children.
//                   children: [
//                     // Handle/grabber for the bottom sheet.
//                     Container(
//                       height: 5,
//                       width: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[700],
//                         borderRadius: BorderRadius.circular(2.5),
//                       ),
//                     ),
//                     const SizedBox(height: 15),
//                     // Header row with back icon and title.
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () =>
//                               Get.back(), // Go back to previous screen.
//                           child: const Icon(
//                             Icons.arrow_back,
//                             color: Colors.white,
//                           ),
//                         ),
//                         const Text(
//                           'Confirm your location',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 24), // Placeholder for alignment.
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     // Location details card (From/To addresses).
//                     Container(
//                       margin: const EdgeInsets.symmetric(horizontal: 0),
//                       padding: const EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: const Color(
//                           0xFF3B3B42,
//                         ), // Card background color.
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         children: [
//                           // "From: Current Location" row.
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Column(
//                                 children: [
//                                   Container(
//                                     width: 8,
//                                     height: 8,
//                                     decoration: const BoxDecoration(
//                                       color: Colors.red,
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                   Container(
//                                     width: 2,
//                                     height:
//                                         25, // Height for the connecting line.
//                                     color: Colors.red,
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(width: 10),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text(
//                                       'From:',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                     Obx(
//                                       () => Text(
//                                         locationController
//                                                 .pickupAddress
//                                                 .value
//                                                 .isEmpty
//                                             ? 'Current Location'
//                                             : locationController
//                                                   .pickupAddress
//                                                   .value,
//                                         style: const TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 15,
//                                         ),
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ), // Space between From and To.
//                           // "To: Destination Location" row (tappable to change).
//                           GestureDetector(
//                             onTap: () {
//                               // Uncomment and use if you have a DestinationSearchScreen.
//                               // Get.to(() => DestinationSearchScreen());
//                             },
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Container(
//                                       width: 8,
//                                       height: 8,
//                                       decoration: const BoxDecoration(
//                                         color: Colors.red,
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 const SizedBox(width: 10),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       const Text(
//                                         'To:',
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Obx(
//                                         () => Text(
//                                           locationController
//                                                   .destinationAddress
//                                                   .value
//                                                   .isEmpty
//                                               ? 'Select Destination' // Default text.
//                                               : locationController
//                                                     .destinationAddress
//                                                     .value,
//                                           style: const TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 15,
//                                           ),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Obx(() {
//                                   // Display distance only if destination is set and distance is calculated.
//                                   if (locationController
//                                               .destinationLocation
//                                               .value !=
//                                           null &&
//                                       locationController.distance.value > 0) {
//                                     return Text(
//                                       '${locationController.distance.value.toStringAsFixed(1)}km',
//                                       style: const TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 15,
//                                       ),
//                                     );
//                                   }
//                                   return const SizedBox.shrink(); // Hide if no destination or distance is zero.
//                                 }),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // "Confirm Location" button.
//                     SizedBox(
//                       width: double.infinity, // Make button full width.
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Action for "Confirm Location" button.
//                           appController.setCurrentScreen('confirm');
//                           // Uncomment and use if you have a FindingYourDriverScreen.
//                           // Get.to(() => FindingYourDriverScreen());
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(
//                             0xFFC0392B,
//                           ), // Red color.
//                           padding: const EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: const Text(
//                           'Confirm Location',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Loading overlay: Appears when appController.isLoading is true.
//             if (appController.isLoading.value)
//               Container(
//                 color: Colors.black54,
//                 child: const Center(
//                   child: CircularProgressIndicator(color: Colors.red),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import '../../controllers/app_controller.dart';
// import '../../controllers/booking_controller.dart';
// import '../../controllers/locaion_controller.dart';
// // import 'chat_screen.dart'; // Uncomment if you use these
// // import 'call_screen.dart'; // Uncomment if you use these
// // import 'payment_screen.dart'; // Uncomment if you use these// Import the new search screen

// // ignore: use_key_in_widget_constructors
// class RideConfirmedScreen extends StatelessWidget {
//   final LocationController locationController = Get.find<LocationController>();
//   final BookingController bookingController = Get.find<BookingController>();
//   final AppController appController = Get.find<AppController>();

//   static const CameraPosition _initialPosition = CameraPosition(
//     target: LatLng(23.8103, 90.4125), // Default to Dhaka, Bangladesh
//     zoom: 14.0,
//   );

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Obx(
//         () => Stack(
//           children: [
//             GoogleMap(
//               onMapCreated: (GoogleMapController controller) {
//                 locationController.setMapController(controller);
//                 // Move camera to current location if available
//                 if (locationController.currentLocation.value != null) {
//                   controller.animateCamera(
//                     CameraUpdate.newLatLngZoom(
//                       locationController.currentLocation.value!,
//                       14.0,
//                     ),
//                   );
//                 }
//               },
//               initialCameraPosition: _initialPosition,
//               markers: locationController.markers,
//               polylines: locationController.polylines, // Display polyline
//               myLocationEnabled: true,
//               myLocationButtonEnabled: false,
//               onTap: (LatLng position) {
//                 // Allow changing destination by tapping on the map
//                 locationController.setDestinationLocation(position);
//                 // The polyline and distance will regenerate automatically due to everAll listener
//               },
//             ),

//             // Back button (top left as seen in previous screenshot type)
//             Positioned(
//               top: 50,
//               left: 20,
//               child: GestureDetector(
//                 onTap: () => Get.back(),
//                 child: Container(
//                   padding: EdgeInsets.all(8),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.arrow_back, color: Colors.black),
//                 ),
//               ),
//             ),
//             // Red target icon in the middle right
//             Positioned(
//               top:
//                   MediaQuery.of(context).size.height *
//                   0.45, // Approximately center vertically
//               right: 20,
//               child: GestureDetector(
//                 onTap: () {
//                   // Re-center map on current location or destination
//                   if (locationController.currentLocation.value != null &&
//                       locationController.mapController.value != null) {
//                     locationController.mapController.value!.animateCamera(
//                       CameraUpdate.newLatLngZoom(
//                         locationController.currentLocation.value!,
//                         14.0,
//                       ),
//                     );
//                   }
//                 },
//                 child: Container(
//                   width: 50,
//                   height: 50,
//                   decoration: BoxDecoration(
//                     color: Colors.red,
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.my_location, color: Colors.white, size: 30),
//                 ),
//               ),
//             ),

//             // CONFIRM YOUR LOCATION BOTTOM SHEET
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: Container(
//                 padding: EdgeInsets.only(
//                   top: 10,
//                   left: 20,
//                   right: 20,
//                   bottom: MediaQuery.of(context).padding.bottom + 10,
//                 ),
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF2E2E38), // Dark grey from the image
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(20),
//                     topRight: Radius.circular(20),
//                   ),
//                 ),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       height: 5,
//                       width: 50,
//                       decoration: BoxDecoration(
//                         color: Colors.grey[700],
//                         borderRadius: BorderRadius.circular(2.5),
//                       ),
//                     ),
//                     SizedBox(height: 15),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         GestureDetector(
//                           onTap: () => Get.back(), // Go back to previous screen
//                           child: Icon(Icons.arrow_back, color: Colors.white),
//                         ),
//                         Text(
//                           'Confirm your location',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(width: 24), // For alignment
//                       ],
//                     ),
//                     SizedBox(height: 20),
//                     Container(
//                       margin: EdgeInsets.symmetric(horizontal: 0),
//                       padding: EdgeInsets.all(16),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF3B3B42), // Card background color
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Column(
//                         children: [
//                           // From: Current Location
//                           Row(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Column(
//                                 children: [
//                                   Container(
//                                     width: 8,
//                                     height: 8,
//                                     decoration: BoxDecoration(
//                                       color: Colors.red,
//                                       shape: BoxShape.circle,
//                                     ),
//                                   ),
//                                   Container(
//                                     width: 2,
//                                     height:
//                                         25, // Height for the connecting line
//                                     color: Colors.red,
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(width: 10),
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'From:',
//                                       style: TextStyle(
//                                         color: Colors.grey,
//                                         fontSize: 12,
//                                       ),
//                                     ),
//                                     Obx(
//                                       () => Text(
//                                         locationController
//                                                 .pickupAddress
//                                                 .value
//                                                 .isEmpty
//                                             ? 'Current Location'
//                                             : locationController
//                                                   .pickupAddress
//                                                   .value,
//                                         style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 15,
//                                         ),
//                                         maxLines: 1,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                           SizedBox(height: 5), // Space between From and To
//                           // To: Destination Location (Changeable/Editable)
//                           GestureDetector(
//                             onTap: () {
//                               //  Get.to(() => DestinationSearchScreen());
//                             },
//                             child: Row(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Column(
//                                   children: [
//                                     Container(
//                                       width: 8,
//                                       height: 8,
//                                       decoration: BoxDecoration(
//                                         color: Colors.red,
//                                         shape: BoxShape.circle,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                                 SizedBox(width: 10),
//                                 Expanded(
//                                   child: Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       Text(
//                                         'To:',
//                                         style: TextStyle(
//                                           color: Colors.grey,
//                                           fontSize: 12,
//                                         ),
//                                       ),
//                                       Obx(
//                                         () => Text(
//                                           locationController
//                                                   .destinationAddress
//                                                   .value
//                                                   .isEmpty
//                                               ? 'Select Destination' // Default text
//                                               : locationController
//                                                     .destinationAddress
//                                                     .value,
//                                           style: TextStyle(
//                                             color: Colors.white,
//                                             fontSize: 15,
//                                           ),
//                                           maxLines: 1,
//                                           overflow: TextOverflow.ellipsis,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                                 Obx(() {
//                                   // Only show distance if destination is set and distance is calculated
//                                   if (locationController
//                                               .destinationLocation
//                                               .value !=
//                                           null &&
//                                       locationController.distance.value > 0) {
//                                     return Text(
//                                       '${locationController.distance.value.toStringAsFixed(1)}km',
//                                       style: TextStyle(
//                                         color: Colors.white,
//                                         fontSize: 15,
//                                       ),
//                                     );
//                                   }
//                                   return SizedBox.shrink(); // Hide if no destination or distance is zero
//                                 }),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 20),
//                     // Confirm Location Button
//                     Container(
//                       width: double.infinity,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           // Action for "Confirm Location"
//                           // For example, navigate to the next screen or trigger booking process
//                           appController.setCurrentScreen(
//                             'confirm',
//                           ); // Your existing logic
//                           // Get.to(() => LocationConfirmationScreen());
//                          // Get.to(() => FindingYourDriverScreen());
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFFC0392B), // Red color
//                           padding: EdgeInsets.symmetric(vertical: 15),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10),
//                           ),
//                         ),
//                         child: Text(
//                           'Confirm Location',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             // Loading overlay
//             if (appController.isLoading.value)
//               Container(
//                 color: Colors.black54,
//                 child: Center(
//                   child: CircularProgressIndicator(color: Colors.red),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import 'payment_details_screen.dart'; // Navigate to payment screen

// class RideConfirmedScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF2E2E38), // Dark background
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF2E2E38),
//         elevation: 0,
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.white),
//           onPressed: () => Get.back(),
//         ),
//         title: Text(
//           'Your driver is coming in 3:00',
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           children: [
//             // Driver Profile Card
//             Divider(color: Colors.grey, thickness: 0.5),
//             Container(
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 //  color: Colors.red,
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 children: [
//                   CircleAvatar(
//                     radius: 30,

//                     backgroundImage: AssetImage(
//                       'assets/images/user6.png',
//                     ), // Replace with actual image
//                     backgroundColor: Colors.grey,
//                   ),
//                   SizedBox(width: 15),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Max Johnson',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         Row(
//                           children: [
//                             Icon(Icons.star, color: Colors.amber, size: 16),
//                             SizedBox(width: 5),
//                             Text('4.9', style: TextStyle(color: Colors.grey)),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Image.asset(
//                     'assets/images/privet_car.png', // Car icon
//                     width: 60,
//                     height: 40,
//                     fit: BoxFit.contain,
//                   ),
//                 ],
//               ),
//             ),
//             Divider(color: Colors.grey, thickness: 0.5),
//             SizedBox(height: 20),
//             // Payment Method Section
//             Container(
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF3B3B42),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     'Payment method',
//                     style: TextStyle(color: Colors.grey, fontSize: 14),
//                   ),
//                   SizedBox(height: 10),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.money,
//                         color: Colors.green,
//                         size: 24,
//                       ), // Cash icon
//                       SizedBox(width: 10),
//                       Text(
//                         'Cash',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                       Spacer(),
//                       Icon(
//                         Icons.arrow_forward_ios,
//                         color: Colors.grey,
//                         size: 16,
//                       ),
//                     ],
//                   ),
//                   Divider(color: Colors.grey[700], height: 20),
//                   Row(
//                     children: [
//                       Icon(
//                         Icons.account_balance_wallet,
//                         color: Colors.blue,
//                         size: 24,
//                       ), // Wallet icon
//                       SizedBox(width: 10),
//                       Text(
//                         'Wallet',
//                         style: TextStyle(color: Colors.white, fontSize: 16),
//                       ),
//                       Spacer(),
//                       ElevatedButton(
//                         onPressed: () {
//                           // Apply wallet action
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: Colors.red,
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 15,
//                             vertical: 5,
//                           ),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: Text(
//                           'Apply',
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20),
//             // Total Price
//             Container(
//               padding: EdgeInsets.all(15),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF3B3B42),
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Total',
//                     style: TextStyle(color: Colors.grey, fontSize: 16),
//                   ),
//                   Text(
//                     '\$32.50',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Spacer(),
//             // Bottom Action Buttons
//             Row(
//               children: [
//                 Expanded(
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Call action
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF3B3B42),
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Icon(Icons.call, color: Colors.white),
//                   ),
//                 ),
//                 SizedBox(width: 15),
//                 Expanded(
//                   flex: 2,
//                   child: ElevatedButton(
//                     onPressed: () {
//                       // Cancel Ride action
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.red,
//                       padding: EdgeInsets.symmetric(vertical: 15),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                     ),
//                     child: Text(
//                       'Cancel Ride',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
