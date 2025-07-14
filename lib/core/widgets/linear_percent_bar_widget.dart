import 'package:flutter/material.dart';

class LinearPercentBarWidget extends StatelessWidget {
  final int percent; // 0–50
  final double length; // Total width of the bar
  final double height;
  final Color fontColor;

  const LinearPercentBarWidget({
    super.key,
    required this.percent,
    this.length = 180,
    this.height = 15,
    this.fontColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    final double clampedPercent = percent.clamp(0, 100).toDouble();
    final double fillFraction = clampedPercent / 100.0;

    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: Stack(
        children: [
          // Background - white
          Container(width: length, height: height, color: Colors.white),
          // Foreground - colored fill
          Container(
            width: length * fillFraction,
            height: height,
            color: const Color(0xff438B92),
          ),
        ],
      ),
    );
  }
}
