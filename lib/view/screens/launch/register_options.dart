import 'package:beekeep/controllers/authController/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_Social_Media_Containear_widget.dart';
import '../../widget/Custom_text_widget.dart';
import 'register_with_email.dart';
import 'register_with_phone.dart';
import 'signin.dart';

class RegisterOptions extends StatelessWidget {
  const RegisterOptions({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RegisterController>();
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
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
            CustomSocialMediaContainer(
              imagePath: Assets.imagesPhone,
              name: "Continue with Phone Number",
              onTap: () {
                Get.to(() => const RegisterWithPhone());
              },
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomSocialMediaContainer(
              imagePath: Assets.imagesGoogle,
              name: "Continue with Google",
              onTap: () {
                controller.registerUserWithGoogleAuth(context: context);

              },
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomSocialMediaContainer(
              imagePath: Assets.imagesEmail,
              name: "Continue with Email",
              onTap: () {
                Get.to(() => RegisterWithEmail());

              },
            ),
            SizedBox(
              height: h(context, 15),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Already have an account? ",
                  textAlign: TextAlign.center,
                  size: 14,
                ),
                CustomText(
                  text: "Log in",
                  textAlign: TextAlign.center,
                  weight: FontWeight.w600,
                  color: kTertiaryColor,
                  size: 14,
                  onTap: () {
                    Get.offAll(() =>SignIn());
                  },
                ),
              ],
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
