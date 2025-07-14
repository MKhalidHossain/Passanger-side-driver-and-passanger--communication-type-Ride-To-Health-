// import 'package:flutter/material.dart';

// import '../features/commanders/presentations/screens/add_commanders_screen.dart';

// import '../features/home/presentation/screens/home_screen.dart';
// import '../features/leaderboard/presentation/screens/leaderboard_screen.dart';
// import '../features/more/presentation/screens/more_screen.dart';
// import 'custom_bottom_navbar.dart';

// class AppNavigation extends StatefulWidget {
//   const AppNavigation({super.key});

//   @override
//   State<AppNavigation> createState() => _AppNavigationState();
// }

// class _AppNavigationState extends State<AppNavigation> {
//   final ValueNotifier<int> _currentIndex = ValueNotifier<int>(0);

//   final List<Widget> _screens = [
//     HomeScreen(),
//     const LeaderboardScreen(),
//     const AddCommandersScreen(),
//     const MoreScreen(),
//   ];

//   @override
//   void dispose() {
//     _currentIndex.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ValueListenableBuilder<int>(
//         valueListenable: _currentIndex,
//         builder: (context, currentIndex, _) {
//           return _screens[currentIndex];
//         },
//       ),
//       bottomNavigationBar: CustomBottomNavBar(currentIndex: _currentIndex),
//     );
//   }
// }
