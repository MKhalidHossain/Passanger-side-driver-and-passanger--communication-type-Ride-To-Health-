
import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';

class TitleWithIconPrefix extends StatefulWidget {
  final String text;
  final Color? color;
  final double fontSize;
  const TitleWithIconPrefix({
    super.key,
    required this.text,
    this.color,
    this.fontSize = 15,
  });

  @override
  State<TitleWithIconPrefix> createState() => _TitleWithIconPrefixState();
}

class _TitleWithIconPrefixState extends State<TitleWithIconPrefix> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset('assets/images/headers/star_logo.png', height: 16),
        const SizedBox(width: 8),
        Text(
          maxLines: 1,
          widget.text,
          style: TextStyle(
            color: widget.color ?? AppColors.context(context).textColor,
            fontSize: widget.fontSize,
            //fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
