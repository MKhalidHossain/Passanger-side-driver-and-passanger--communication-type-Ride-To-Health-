import 'package:flutter/material.dart';

class ImageButtonContainer extends StatelessWidget {
  final String imagePath;
  final VoidCallback? onPressed;

  const ImageButtonContainer({
    super.key,
    required this.imagePath,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 40,
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.zero, // remove default padding
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
        ),
        onPressed: onPressed ?? () {},
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }
}
