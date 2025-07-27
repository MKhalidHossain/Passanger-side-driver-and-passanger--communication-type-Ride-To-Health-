import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../controllers/app_controller.dart'; // Uncomment if needed
// import '../../controllers/booking_controller.dart'; // Uncomment if needed
import 'payment_details_screen.dart'; // Navigate to payment screen

class RideConfirmedScreen extends StatelessWidget {
  // final AppController appController = Get.find<AppController>(); // Example
  // final BookingController bookingController = Get.find<BookingController>(); // Example

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2E2E38), // Dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF2E2E38),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Your driver is coming in 3:00', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Driver Profile Card
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF3B3B42),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/driver_avatar.jpg'), // Replace with actual image
                    backgroundColor: Colors.grey,
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Max Johnson', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 5),
                            Text('4.9', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/copen_gr_sport.png', // Car icon
                    width: 60,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Payment Method Section
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF3B3B42),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Payment method', style: TextStyle(color: Colors.grey, fontSize: 14)),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(Icons.money, color: Colors.green, size: 24), // Cash icon
                      SizedBox(width: 10),
                      Text('Cash', style: TextStyle(color: Colors.white, fontSize: 16)),
                      Spacer(),
                      Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                    ],
                  ),
                  Divider(color: Colors.grey[700], height: 20),
                  Row(
                    children: [
                      Icon(Icons.account_balance_wallet, color: Colors.blue, size: 24), // Wallet icon
                      SizedBox(width: 10),
                      Text('Wallet', style: TextStyle(color: Colors.white, fontSize: 16)),
                      Spacer(),
                      ElevatedButton(
                        onPressed: () {
                          // Apply wallet action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: Text('Apply', style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Total Price
            Container(
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: const Color(0xFF3B3B42),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total', style: TextStyle(color: Colors.grey, fontSize: 16)),
                  Text('\$32.50', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Spacer(),
            // Bottom Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      // Call action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF3B3B42),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Icon(Icons.call, color: Colors.white),
                  ),
                ),
                SizedBox(width: 15),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      // Cancel Ride action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: Text('Cancel Ride', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}