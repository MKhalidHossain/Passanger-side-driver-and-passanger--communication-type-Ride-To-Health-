import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:rideztohealth/app.dart';
import 'package:rideztohealth/feature/auth/controllers/auth_controller.dart';
import 'package:rideztohealth/feature/auth/presentation/screens/user_login_screen.dart';
import 'package:rideztohealth/feature/map/presentation/screens/map_screen_test.dart';
import 'package:rideztohealth/helpers/dependency_injection.dart';
import 'core/onboarding/presentation/screens/constantSpashScreen.dart';
import 'core/onboarding/presentation/screens/onboarding1.dart';
import 'core/onboarding/presentation/screens/spashScreen.dart';
import 'feature/map/bindings/initial_binding.dart';
import 'feature/map/presentation/screens/ride_confirmed_screen.dart';
import 'feature/map/presentation/screens/work/search_destination_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDI();
  // if (Get.find<AuthController>().isFirstTimeInstall()) {
  //   print('App is first time install');

  //   // if permission is required need to use those requestPermissions according to commanders Rattings r
  //   // Request storage permission here
  //   // await requestPermissions();

  //   Get.find<AuthController>().setFirstTimeInstall();
  // } else {
  //   print('App is not first time install');
  // }

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthController authController = Get.find<AuthController>();
  whichPageToNext() {
    if (authController.isFirstTimeInstall()) {
      return SplashScreen(nextScreen: Onboarding1());
    }
    if (authController.isLoading) {
      return ConstantSplashScreen();
    } else if (authController.isLoggedIn()) {
      return AppMain();
    } else {
      return UserLoginScreen();
    }
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'RidezToHealth',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(
          0xFF303644,
        ), // background color here
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),

        //background: const Color(0xFF303644), // Optional: sets default background in color scheme
      ),
      // initialBinding: InitialBinding(),
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      home: whichPageToNext(),
      //MapScreenTest(),
      // SearchDestinationScreen(),
      // RideConfirmedScreen(),
      // AppMain(),
      // SplashScreen(nextScreen: Onboarding1()),
    );
  }
}
