import 'package:flutter/material.dart';

class NormalCustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double weight;
  final double fontSize;
  final Color textColor;
  final Color fillColor;
  final bool showIcon;
  final IconData? sufixIcon;

  const NormalCustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 40,
    this.weight = 140,
    this.fontSize = 14,
    this.textColor = Colors.white,
    this.fillColor = Colors.red,
    this.showIcon = false,
    this.sufixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: weight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: fillColor, // Make it red like in your design
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text, style: TextStyle(color: textColor, fontSize: fontSize)),
            if (showIcon && sufixIcon != null) ...[
              const SizedBox(width: 5),
              Icon(sufixIcon, color: Colors.white),
            ],
          ],
        ),
      ),
    );
  }
}
