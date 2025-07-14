
import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';

class LabelText extends StatelessWidget {
  final String text;
  final double fontSize;

  const LabelText({super.key, required this.text, this.fontSize = 14});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: FontWeight.w900,
        fontSize: fontSize,
        color: AppColors.context(context).textColor,
      ),
    );
  }
}

class ValueTextAeroMatics extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  const ValueTextAeroMatics({
    super.key,
    required this.text,
    this.fontSize = 12,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 15,
      text,
      style: TextStyle(
        color: AppColors.context(context).textColor,
        fontFamily: "aero_matics",
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
