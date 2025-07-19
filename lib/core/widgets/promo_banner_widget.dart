import 'package:flutter/material.dart';
import 'normal_custom_button.dart'; // Adjust path as needed

class PromoBannerWidget extends StatelessWidget {
  final String title;
  final String buttonText;
  final VoidCallback onPressed;
  final String imagePath;

  const PromoBannerWidget({
    super.key,
    required this.title,
    required this.buttonText,
    required this.onPressed,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                NormalCustomButton(
                  height: 30,
                  weight: 100,
                  text: buttonText,
                  onPressed: onPressed,
                ),
              ],
            ),
          ),
          const Spacer(),
          Image.asset(
            imagePath,
            fit: BoxFit.contain,
            height: 120,
          ),
        ],
      ),
    );
  }
}
