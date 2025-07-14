import 'package:flutter/material.dart';
import '../themes/app_color.dart';

class OrDividerWithCircle extends StatelessWidget {
  final String text;
  // final EdgeInsetsGeometry padding;
  final double circleSize;
  final TextStyle? textStyle;
  // final Color circleColor;
  final Color textColor;

  const OrDividerWithCircle({
    super.key,
    this.text = 'Or',
    // this.padding = const EdgeInsets.symmetric(horizontal: 16),
    this.circleSize = 30.0,
    this.textStyle,
    // this.circleColor = Colors.white,
    this.textColor = AppColors.secondaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.secondaryColor)),

        Container(
          width: circleSize,
          height: circleSize,
          alignment: Alignment.center,
          // decoration: BoxDecoration(
          //   shape: BoxShape.circle,
          //   // color: circleColor,
          //   border: Border.all(color: AppColors.secondaryColor),
          // ),
          child: Text(
            text,
            style:
                textStyle ??
                TextStyle(
                  fontSize: 12,
                  color: textColor,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.secondaryColor)),
      ],
    );
  }
}
