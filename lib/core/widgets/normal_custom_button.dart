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
  final double circularRadious;

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
    this.circularRadious = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: weight,
      child: InkWell(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(circularRadious),
            gradient: LinearGradient(
              stops: [0.0, 0.4, 9.0],
              colors: [
                Color(0xff7B0100).withOpacity(0.8),
                Color(0xFFCE0000),
                Color(0xff7B0100).withOpacity(0.8),
              ],
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (showIcon && sufixIcon != null) ...[
                const SizedBox(width: 5),
                Icon(sufixIcon, color: Colors.white),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
class SmallSemiTranparentButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double height;
  final double weight;
  final double fontSize;
  final Color textColor;
  final Color fillColor;
  final bool showIcon;
  final IconData? sufixIcon;
  final double circularRadious;

  const SmallSemiTranparentButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.height = 30,
    this.weight = 95,
    this.fontSize = 12,
    this.textColor = Colors.white,
    this.fillColor = Colors.white12,
    this.showIcon = false,
    this.sufixIcon,
    this.circularRadious = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: weight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: fillColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularRadious),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: Text(
                text,
                overflow: TextOverflow.ellipsis,
                softWrap: false,
                style: TextStyle(
                  color: textColor,
                  fontSize: fontSize,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (showIcon && sufixIcon != null) ...[
              const SizedBox(width: 4),
              Icon(sufixIcon, color: Colors.white, size: fontSize + 2),
            ],
          ],
        ),
      ),
    );
  }
}