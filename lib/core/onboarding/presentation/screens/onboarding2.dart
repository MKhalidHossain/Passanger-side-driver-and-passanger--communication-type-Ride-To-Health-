import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rideztohealth/core/extensions/text_extensions.dart';
import 'package:rideztohealth/core/onboarding/presentation/screens/onboarding3.dart';

import '../../../common/button/rounded_button_with_arrow_and_progress.dart';
import '../../../widgets/app_scaffold.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return AppScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: size.height * 0.09),
          Center(
            child: Image.asset(
              'assets/images/onboarding2.png',
              height: 200,
              width: size.width - 48,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: size.height * 0.07),
          'At anywhere'.text20white(),
          SizedBox(height: size.height * 0.01),
          'Sell houses easily with the help of \nListenoryx and to make this line big I am \n writing more'
              .text14White(),
          SizedBox(height: size.height * 0.15),
          RoundedButtonWithArrowAndProgress(
            isIcon: true,
            percent: 66,
            onTap: () {
              Get.to(() => const Onboarding3());
            },
          ),
        ],
      ),
    );
  }
}
