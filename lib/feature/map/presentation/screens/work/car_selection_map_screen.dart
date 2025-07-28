import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../controllers/app_controller.dart';
import '../../../controllers/booking_controller.dart';
import '../../../controllers/locaion_controller.dart';
import 'confirm_location_map_screen.dart';
import '../location_confirmation_screen.dart';
import '../chat_screen.dart';
import '../call_screen.dart';
import '../payment_screen.dart';

class CarSelectionMapScreen extends StatelessWidget {
  final LocationController locationController = Get.find<LocationController>();
  final BookingController bookingController = Get.find<BookingController>();
  final AppController appController = Get.find<AppController>();

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(
      37.7749,
      -122.4194,
    ), // Default to San Francisco if no location
    zoom: 14.0,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                locationController.setMapController(controller);
                // Move camera to current location if available
                if (locationController.currentLocation.value != null) {
                  controller.animateCamera(
                    CameraUpdate.newLatLngZoom(
                      locationController.currentLocation.value!,
                      14.0,
                    ),
                  );
                }
              },
              initialCameraPosition: _initialPosition,
              markers: locationController.markers,
              polylines: locationController.polylines, // Display polyline
              myLocationEnabled: true,
              myLocationButtonEnabled: false,
              onTap: (LatLng position) {
                // Allow changing destination by tapping on the map
                locationController.setDestinationLocation(position);
                locationController
                    .generatePolyline(); // Regenerate polyline on destination change
              },
            ),

            // Back button and other controls (as seen in the image - top left)
            Positioned(
              top: 50,
              left: 20,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
            // Red target icon in the middle right
            Positioned(
              top:
                  MediaQuery.of(context).size.height *
                  0.45, // Approximately center vertically
              right: 20,
              child: GestureDetector(
                onTap: () {
                  // This is a static icon from the screenshot, no specific action implied.
                  // You might want to assign a function to recenter the map on the destination.
                },
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.my_location,
                    color: Colors.white,
                    size: 30,
                  ), // Example icon, adjust as needed
                ),
              ),
            ),

            // Bottom Sheet
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  left: 20,
                  right: 20,
                  bottom: MediaQuery.of(context).padding.bottom + 10,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E2E38), // Dark grey from the image
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      height: 5,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(2.5),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => Get.back(), // Go back to previous screen
                          child: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        Text(
                          'Set Ride',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(width: 24), // For alignment
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF3B3B42,
                        ), // Slightly lighter dark grey
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/privet_car.png', // Replace with your actual image path
                            width: 80,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Copen GR SPORT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Affordable rides for everyday',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$12.50', // Replace with dynamic price from bookingController
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '5 min away', // Replace with dynamic time from bookingController
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 15,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(
                          0xFF3B3B42,
                        ), // Slightly lighter dark grey
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/images/texi.png', // Replace with your actual image path
                            width: 80,
                            height: 50,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(width: 15),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Copen GR SPORT',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'Affordable rides for everyday',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '\$12.50', // Replace with dynamic price from bookingController
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '5 min away', // Replace with dynamic time from bookingController
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 30),
                    Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          // Action for "Choose car"
                          appController.setCurrentScreen('confirm');
                          Get.to(() => ConfirmYourLocationScreen());
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFC0392B), // Red color
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          'Choose car',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Loading overlay
            if (appController.isLoading.value)
              Container(
                color: Colors.black54,
                child: Center(
                  child: CircularProgressIndicator(color: Colors.red),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:google_maps_flutter/google_maps_flutter.dart';
// // import '../../controllers/app_controller.dart';
// // import '../../controllers/booking_controller.dart';
// // import '../../controllers/locaion_controller.dart';
// // import 'location_confirmation_screen.dart';
// // import 'chat_screen.dart';
// // import 'call_screen.dart';
// // import 'payment_screen.dart';

// // class MapScreen extends StatelessWidget {
// //   final LocationController locationController = Get.find<LocationController>();
// //   final BookingController bookingController = Get.find<BookingController>();
// //   final AppController appController = Get.find<AppController>();

// //   static const CameraPosition _initialPosition = CameraPosition(
// //     target: LatLng(37.7749, -122.4194),
// //     zoom: 14.0,
// //   );

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       // appBar: AppBar(
// //       //   title: Text('Search'),
// //       //   backgroundColor: Color(0xFF2C3E50),
// //       //   leading: IconButton(
// //       //     icon: Icon(Icons.arrow_back),
// //       //     onPressed: () => Get.back(),
// //       //   ),
// //       //   actions: [
// //       //     IconButton(
// //       //       icon: Icon(Icons.chat),
// //       //       onPressed: () => Get.to(() => ChatScreen()),
// //       //     ),
// //       //     IconButton(
// //       //       icon: Icon(Icons.call),
// //       //       onPressed: () => Get.to(() => CallScreen()),
// //       //     ),
// //       //   ],
// //       // ),
// //       body: Obx(
// //         () => Stack(
// //           children: [
// //             GoogleMap(
// //               onMapCreated: (GoogleMapController controller) {
// //                 locationController.setMapController(controller);
// //               },
// //               initialCameraPosition: _initialPosition,
// //               markers: locationController.markers,
// //               myLocationEnabled: true,
// //               myLocationButtonEnabled: false,
// //               onTap: (LatLng position) {
// //                 locationController.setDestinationLocation(position);
// //               },
// //             ),

// //             // Top location info
// //             Positioned(
// //               top: 20,
// //               left: 20,
// //               right: 20,
// //               child: Container(
// //                 padding: EdgeInsets.all(16),
// //                 decoration: BoxDecoration(
// //                   color: Color(0xFF2C3E50),
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: Column(
// //                   crossAxisAlignment: CrossAxisAlignment.start,
// //                   children: [
// //                     Row(
// //                       children: [
// //                         Icon(
// //                           Icons.radio_button_checked,
// //                           color: Colors.green,
// //                           size: 16,
// //                         ),
// //                         SizedBox(width: 8),
// //                         Expanded(
// //                           child: Text(
// //                             locationController.pickupAddress.value.isEmpty
// //                                 ? 'Current Location'
// //                                 : locationController.pickupAddress.value,
// //                             style: TextStyle(color: Colors.white, fontSize: 14),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     SizedBox(height: 8),
// //                     Row(
// //                       children: [
// //                         Icon(Icons.location_on, color: Colors.red, size: 16),
// //                         SizedBox(width: 8),
// //                         Expanded(
// //                           child: Text(
// //                             locationController.destinationAddress.value.isEmpty
// //                                 ? 'Select destination'
// //                                 : locationController.destinationAddress.value,
// //                             style: TextStyle(color: Colors.white, fontSize: 14),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //             // Car selection bottom sheet
// //             Positioned(
// //               bottom: 20,
// //               left: 20,
// //               right: 20,
// //               child: Container(
// //                 padding: EdgeInsets.all(16),
// //                 decoration: BoxDecoration(
// //                   color: Color(0xFF2C3E50),
// //                   borderRadius: BorderRadius.circular(12),
// //                 ),
// //                 child: Column(
// //                   mainAxisSize: MainAxisSize.min,
// //                   children: [
// //                     Row(
// //                       children: [
// //                         Container(
// //                           width: 60,
// //                           height: 40,
// //                           decoration: BoxDecoration(
// //                             color: Colors.orange,
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                           child: Icon(
// //                             Icons.directions_car,
// //                             color: Colors.white,
// //                           ),
// //                         ),
// //                         SizedBox(width: 12),
// //                         Expanded(
// //                           child: Column(
// //                             crossAxisAlignment: CrossAxisAlignment.start,
// //                             children: [
// //                               Text(
// //                                 bookingController.getCarTypeString(),
// //                                 style: TextStyle(
// //                                   color: Colors.white,
// //                                   fontSize: 16,
// //                                   fontWeight: FontWeight.bold,
// //                                 ),
// //                               ),
// //                               Text(
// //                                 '${bookingController.estimatedTime.value} min away',
// //                                 style: TextStyle(
// //                                   color: Colors.grey,
// //                                   fontSize: 14,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                         Text(
// //                           '\$${bookingController.estimatedPrice.value.toStringAsFixed(2)}',
// //                           style: TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 18,
// //                             fontWeight: FontWeight.bold,
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                     SizedBox(height: 16),
// //                     Row(
// //                       children: [
// //                         Expanded(
// //                           child: ElevatedButton(
// //                             onPressed: () => Get.to(() => PaymentScreen()),
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Color(0xFF34495E),
// //                               padding: EdgeInsets.symmetric(vertical: 12),
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(8),
// //                               ),
// //                             ),
// //                             child: Text(
// //                               'Payment',
// //                               style: TextStyle(color: Colors.white),
// //                             ),
// //                           ),
// //                         ),
// //                         SizedBox(width: 12),
// //                         Expanded(
// //                           flex: 2,
// //                           child: ElevatedButton(
// //                             onPressed: () {
// //                               appController.setCurrentScreen('confirm');
// //                               Get.to(() => LocationConfirmationScreen());
// //                             },
// //                             style: ElevatedButton.styleFrom(
// //                               backgroundColor: Colors.red,
// //                               padding: EdgeInsets.symmetric(vertical: 12),
// //                               shape: RoundedRectangleBorder(
// //                                 borderRadius: BorderRadius.circular(8),
// //                               ),
// //                             ),
// //                             child: Text(
// //                               'Confirm Location',
// //                               style: TextStyle(
// //                                 color: Colors.white,
// //                                 fontSize: 16,
// //                                 fontWeight: FontWeight.bold,
// //                               ),
// //                             ),
// //                           ),
// //                         ),
// //                       ],
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ),

// //             // My location button
// //             Positioned(
// //               top: 100,
// //               right: 20,
// //               child: FloatingActionButton(
// //                 mini: true,
// //                 backgroundColor: Colors.white,
// //                 onPressed: () => locationController.getCurrentLocation(),
// //                 child: Icon(Icons.my_location, color: Colors.black),
// //               ),
// //             ),

// //             // Loading overlay
// //             if (appController.isLoading.value)
// //               Container(
// //                 color: Colors.black54,
// //                 child: Center(
// //                   child: CircularProgressIndicator(color: Colors.red),
// //                 ),
// //               ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
