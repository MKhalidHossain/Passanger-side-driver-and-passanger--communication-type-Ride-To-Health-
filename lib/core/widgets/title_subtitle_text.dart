
import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';

class TitleText extends StatefulWidget {
  final String text;
  final Color? color;
  final double fontSize;

  const TitleText({
    super.key,
    required this.text,
    this.color,
    this.fontSize = 18, // default color is black
  });

  @override
  State<TitleText> createState() => _TitleTextState();
}

class _TitleTextState extends State<TitleText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 5,
      widget.text,
      style: TextStyle(
        color: AppColors.context(context).textColor,
        fontSize: widget.fontSize, // default size
        fontWeight: FontWeight.bold, // default bold
      ),
    );
  }
}

class SubTitleText extends StatelessWidget {
  final String text;
  final Color? color;

  const SubTitleText({
    super.key,
    required this.text,
    this.color, // color will be handled in build method
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      maxLines: 30,
      text,
      style: TextStyle(
        color:
            color ??
            AppColors.context(context).textColor, // fallback to default color
        fontSize: 13, // subtitle font size (smaller)
        fontWeight: FontWeight.w500,
        // letterSpacing: 1.0, // subtitle medium weight
      ),
    );
  }
}
