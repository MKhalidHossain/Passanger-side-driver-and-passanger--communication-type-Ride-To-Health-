import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import '../../controllers/app_controller.dart'; // Uncomment if needed

class PaymentDetailsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C3E50), // Dark background
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C3E50),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: Text('Payment', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Select Payment Method', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            // Cash Option
            Card(
              color: const Color(0xFF3B3B42),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.money, color: Colors.green),
                title: Text('Cash', style: TextStyle(color: Colors.white)),
                trailing: Icon(Icons.check_circle, color: Colors.green), // Example: if cash is selected by default
                onTap: () {
                  // Handle cash selection
                },
              ),
            ),
            SizedBox(height: 10),
            // Wallet Option
            Card(
              color: const Color(0xFF3B3B42),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet, color: Colors.blue),
                title: Text('Wallet', style: TextStyle(color: Colors.white)),
                subtitle: Text('Balance: \$50.00', style: TextStyle(color: Colors.grey)), // Example balance
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                onTap: () {
                  // Handle wallet selection / navigate to wallet details
                },
              ),
            ),
            SizedBox(height: 10),
            // Add Card Option
            Card(
              color: const Color(0xFF3B3B42),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.credit_card, color: Colors.orange),
                title: Text('Add Credit/Debit Card', style: TextStyle(color: Colors.white)),
                trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
                onTap: () {
                  // Handle add card
                },
              ),
            ),
            Spacer(),
            // Confirm Button (if needed for payment method selection)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.back(); // Go back after selecting payment method
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text('Confirm Payment Method', style: TextStyle(color: Colors.white, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}