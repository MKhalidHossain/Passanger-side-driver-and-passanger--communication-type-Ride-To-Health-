import 'package:flutter/material.dart';
import 'package:rideztohealth/core/extensions/text_extensions.dart';

import '../widgets/app_logo.dart';
import '../widgets/app_scaffold.dart';



//import '../widgets/app_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AppScaffold(
      body: Column(
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(minHeight: size.height),
            child: IntrinsicHeight(
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment:
                      MainAxisAlignment.center, // 🔥 Center vertically
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    AppLogo(),
                    // const SizedBox(height: 32),
                    "Explore like a local".text20Black(),
                  ],
                ),
              ),
            ),
          ),

          // Padding(
          //   padding: const EdgeInsets.only(bottom: 16),
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       Text(
          //         "Already have an account? ",
          //         style: TextStyle(
          //           color: AppColors.primaryTextBlack,
          //           fontSize: 14,
          //           fontWeight: FontWeight.w400,
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           Navigator.push(
          //             context,
          //             MaterialPageRoute(
          //               builder: (context) => UserSignupScreen(),
          //             ),
          //           );
          //         },
          //         child: Text(
          //           'Sign in',
          //           style: TextStyle(
          //             color: AppColors.context(context).primaryColor,
          //             fontWeight: FontWeight.w400,
          //             fontSize: 14,
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
