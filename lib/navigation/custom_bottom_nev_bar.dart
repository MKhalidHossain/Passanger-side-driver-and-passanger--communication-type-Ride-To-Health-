import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 0),
      decoration: const BoxDecoration(color: Color(0xFF2A2F3A)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(
            context,
            iconPathSelected: 'assets/icons/homeRed.png',
            iconPathUnselected: 'assets/icons/homeLight.png',
            label: 'Home',
            index: 0,
          ),
          _buildNavItem(
            context,
            iconPathSelected: 'assets/icons/serviceRed.png',
            iconPathUnselected: 'assets/icons/seviceLight.png',
            label: 'Service',
            index: 1,
          ),
          _buildNavItem(
            context,
            iconPathSelected: 'assets/icons/historyRed.png',
            iconPathUnselected: 'assets/icons/historyLight.png',
            label: 'History',
            index: 2,
          ),
          _buildNavItem(
            context,
            iconPathSelected: 'assets/icons/userRed.png',
            iconPathUnselected: 'assets/icons/userLight.png',
            label: 'Profile',
            index: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context, {
    required String iconPathSelected,
    required String iconPathUnselected,
    required String label,
    required int index,
  }) {
    final isSelected = selectedIndex == index;
    final screenWidth = MediaQuery.of(context).size.width;
    final iconSize = screenWidth * 0.07; // responsive icon size

    return Expanded(
      child: GestureDetector(
        onTap: () => onItemTapped(index),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSelected ? iconPathSelected : iconPathUnselected,
              width: iconSize,
              height: iconSize,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.red : Colors.white70,
                fontSize: screenWidth * 0.028, // responsive font
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
