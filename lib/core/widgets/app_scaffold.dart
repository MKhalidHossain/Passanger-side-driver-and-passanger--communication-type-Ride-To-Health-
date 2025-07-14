import 'package:flutter/material.dart';
import 'package:rideztohealth/core/constants/app_colors.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final AppBar? appBar;
  final Widget? drawer;
  final bool removePadding;
  final Widget? floatingActionButton;

  const AppScaffold({
    super.key,
    this.appBar,
    this.drawer,
    required this.body,
    this.removePadding = false,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          AppColors.scaffoldBackgroundColor, // Default background color
      drawer: drawer,
      appBar: appBar,
      body: body,
      // Padding(
      //   padding: EdgeInsets.symmetric(horizontal: removePadding ? 0 : 18),
      //   child: body,
      // ),
      floatingActionButton: floatingActionButton,
    );
  }
}
