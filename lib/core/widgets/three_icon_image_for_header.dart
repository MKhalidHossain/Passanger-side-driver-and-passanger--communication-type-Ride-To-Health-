
import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';

class ThreeIconImageForHeader extends StatelessWidget {
  final bool isShowSearch;

  const ThreeIconImageForHeader({super.key, this.isShowSearch = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: Icon(Icons.arrow_back),
          color: AppColors.context(context).iconColor,
          iconSize: 30,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Image.asset('assets/images/headers/star_logo.png', height: 50),
        isShowSearch
            ? Image.asset('assets/images/headers/search_icon.png', height: 30)
            : const SizedBox(width: 30),
      ],
    );
  }
}
