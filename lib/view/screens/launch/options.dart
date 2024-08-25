import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import 'register_options.dart';
import 'signin.dart';

class Options extends StatelessWidget {
  const Options({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: symmetric(context, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomText(
              text: "Explore the app",
              textAlign: TextAlign.center,
              size: 24,
              weight: FontWeight.w600,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "HiveTask - Beekeeping made simple",
              textAlign: TextAlign.center,
              color: const Color(0xff9D9D9D),
              size: 16,
            ),
            SizedBox(
              height: h(context, 46),
            ),
            CustomButton3(
              buttonText: "Log In",
              onTap: () {
                Get.to(() => SignIn());
              },
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomButton2(
              text: "Register",
              onTap: () {
                Get.to(() => const RegisterOptions());
              },
            ),
            SizedBox(
              height: h(context, 29),
            ),
            CustomText(
              text: "Continue as a Guest",
              textAlign: TextAlign.center,
              weight: FontWeight.w500,
              color: kTertiaryColor,
              size: 16,
            ),
            SizedBox(
              height: h(context, 70),
            )
          ],
        ),
      ),
    );
  }
}
