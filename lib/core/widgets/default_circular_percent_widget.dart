import 'package:flutter/material.dart';

class CircularPercentWidget extends StatefulWidget {
  final int percent; // 0–100
  final double size; // The total size of the circular widget
  final Color fontColor;

  const CircularPercentWidget({
    super.key,
    required this.percent,
    required this.size,
    this.fontColor = Colors.black,
  });

  @override
  State<CircularPercentWidget> createState() => _CircularPercentWidgetState();
}

class _CircularPercentWidgetState extends State<CircularPercentWidget> {
  @override
  Widget build(BuildContext context) {
    final double clampedPercent = widget.percent.clamp(0, 100).toDouble();
    final double progressValue = clampedPercent / 100.0;
    final double strokeWidth = widget.size * 0.18;
    final double fontSize = widget.size * 0.28;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: CircularProgressIndicator(
              strokeCap: StrokeCap.round,
              value: progressValue,
              strokeWidth: strokeWidth,
              valueColor: AlwaysStoppedAnimation<Color>(
                _getProgressColor(clampedPercent),
              ),
              backgroundColor: Colors.white,
            ),
          ),
          Text(
            '${clampedPercent.toInt()}%',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: fontSize,
              color: widget.fontColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getProgressColor(double percent) {
    if (percent >= 75) return Color(0xff438B92);
    if (percent >= 50) return Color(0xff438B92);
    return Colors.red;
  }
}
