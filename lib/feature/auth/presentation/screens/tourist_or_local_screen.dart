import 'package:flutter/material.dart';
import 'package:rideztohealth/core/common/button/button_widget.dart';
import '../../../../core/constants/app_colors.dart';

class TouristORLocal extends StatefulWidget {
  const TouristORLocal({super.key});

  @override
  State<TouristORLocal> createState() => _TouristORLocalState();
}

class _TouristORLocalState extends State<TouristORLocal> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedProfile;
  bool _showProfileError = false;

  void _onProfileSelected(String profileType) {
    setState(() {
      _selectedProfile = profileType;
      _showProfileError = false;
    });
  }

  Widget _buildProfileOption({
    required String type,
    required String description,
    required String imagePath,
  }) {
    final isSelected = _selectedProfile == type;

    return GestureDetector(
      onTap: () => _onProfileSelected(type),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected
                  // ignore: deprecated_member_use
                  ? AppColors.context(context).primaryColor.withOpacity(0.08)
                  : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color:
                isSelected
                    ? AppColors.context(context).primaryColor
                    : Colors.grey.shade300,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Image.asset(imagePath, height: 63, width: 63),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: TextStyle(
                      color: AppColors.context(context).primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color get continueButtonColor =>
      _selectedProfile != null
          ? AppColors.context(context).primaryColor
          : AppColors.primaryTextBlack;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Select your profile type",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        centerTitle: false,
      ),
      body:  SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 16),
                          _buildProfileOption(
                            type: "Tourist",
                            description:
                                "You are looking for activity, experience or sharing",
                            imagePath: 'assets/images/tourist.png',
                          ),
                          _buildProfileOption(
                            type: "Local",
                            description:
                                "You are a hatchr and you want to help tourist and share with them",
                            imagePath: 'assets/images/local.png',
                          ),
                          if (_showProfileError)
                            Padding(
                              padding: EdgeInsets.only(top: 8),
                              child: Text(
                                "Please select a profile type",
                                style: TextStyle(color: Colors.red.shade700),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  child: context.primaryButton(
                    onPressed: () {
                      if (_selectedProfile != null) {
                       // authController.chooseRole(_selectedProfile!);
                      } else {
                        setState(() {
                          _showProfileError = true;
                        });
                      }
                    },
                    text: "Continue",
                    backgroundColor:
                        _selectedProfile != null
                            ? AppColors.context(context).primaryColor
                            : AppColors.secondaryColor,
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
   
      ),
    );
  }
}
