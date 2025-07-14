
import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';

class WideCustomButtonMore extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const WideCustomButtonMore({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              alignment: Alignment.centerLeft,
              backgroundColor:
                  AppColors.context(
                    context,
                  ).buttonColor, // Make it red like in your design
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
                side: BorderSide(
                  color: AppColors.context(context).inActiveButtonContentColor,
                  width: 2,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            ),
            onPressed: onPressed,
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 14),
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
