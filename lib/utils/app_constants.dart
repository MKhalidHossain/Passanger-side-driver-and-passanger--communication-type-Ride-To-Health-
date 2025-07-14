import 'dart:io';
import 'package:flutter/material.dart';

class AppConstants {

  static const String token = 'token';
  static const String refreshToken = 'token';

  static const String appName = 'Driving Test';

  static const String baseUrl = 'https://backend-david-weijian.onrender.com/api/v1/auth/user-login';

  // static const String baseUrl = 'https://backend-david-weijian.onrender.com/api/v1';

  static const String polylineMapKey = 'AIzaSyBxA6N8pU61iOKdCVfphQCpV4VC907uT94';

  static const String appVersion = '1.0.0';

  // static const String configUri = '/api/driver/configuration';

  static const String registration = '/auth/user-register';

  static const String loginUri = '/auth/user-login';

  static const String logout = '/auth/user-logout';


  static const String forgetPassword = '/auth/forgot-password';

  static const String otpVerification = '/auth/verify-otp';

  static const String resendOtp = '/auth/resend-otp';

  static const String resetPassword = '/auth/reset-password';

  static const String changePassword = '/user/change-password';

  static const String refreshAccessToken = '/auth/refresh-accessToken';

  static const String profileInfo = '/user/get-userProfile';

  static const String updateProfileInfo = '/user/update-userProfile';

  static const String updateAccessAndRefreshToken = '/auth/refresh-accessToken';

  static const String contactUs = '/contact-us';

  static const String reportBug = '/bug-report/submit';

  /////////////////////// Test Centre //////////////////////////////////////////

  static const String getAllTestCentre = '/test-centre/details';

  static const String getListOfRouteForCentre = '/route-details/route/';

  static const String getARoute = '/route-details/get-a-route/';

  static const String sendReview = '/route-details/create-review/';

  static const String getAllImportedRoute = '/route-details/get-all-imported-routes';

  static const String getAllFavoriteRoute = '/route-details/favorite/';

  static const String setFavourite = '/route-details/favorite/';

  static const String testAttempt = '/attempted-test/create';

  static const String updateTestAttempt = '/attempted-test/update-pass-rate/';

  static const String getSubscription = '/subscription/';

  static const String increaseReview = '/route-details/increment-views/';

  /////////////////////// Test Centre End //////////////////////////////////////////

  static const String sendMessage = '/api/driver/chat/send-message';

  static const String saveImportedRoute = '/import-route';

  static const String notificationList = '/api/driver/notification-list?limit=10&offset=';

  static const String updateLastLocationUsingSocket = '/user/live-location?appKey';

  static const Color lightPrimary = Color.fromARGB(255, 32, 32, 32);

  static const Color darkPrimary = Color.fromARGB(255, 0, 0, 0);

  static const String fontFamily = 'SFProText';

  static const double coverageRadiusInMeter = 50;


  static final categories = <String>[
    'All', 'Action', 'Anime', 'Sci-fi', 'Thriller'
  ];

  static final navItems = <IconData>[Icons.home_filled, Icons.tv, Icons.download, Icons.account_circle_outlined];

  void checkOS() {

    if (Platform.isAndroid) {

      print("Running on Android"); [1, 3, 5];

    } else if (Platform.isIOS) {

      print("Running on iOS"); [1, 3, 5];

    } else if (Platform.isWindows) {

      print("Running on Windows"); [2, 3, 9];

    } else {

      print("Unknown platform"); [3];

    }

  }
}