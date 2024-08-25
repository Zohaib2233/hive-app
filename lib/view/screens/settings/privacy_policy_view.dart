import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreybackgroundColor,
      appBar: AppBar(
        backgroundColor: kGreybackgroundColor,
        leading: Padding(
          padding: only(context, left: 20),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SizedBox(
              width: h(context, 29),
              height: w(context, 29),
              child: CommonImageView(
                imagePath: Assets.imagesBack,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: 'Terms & Conditions',
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),
      body: Padding(
        padding: symmetric(context, horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Marchè App Privacy policy',
              size: 14,
              weight: FontWeight.w600,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "Last Updated: 12 Nov 2023",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 30),
            ),
            CustomText(
              text:
                  "Welcome to Marchè Social! This Privacy Policy outlines how we collect, use, disclose, and protect your information when you use our mobile application. By using Marchè Social, you agree to the terms described in this policy.",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "1. Information We Collect:",
              size: 12,
              weight: FontWeight.w700,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "We may collect the following types of information:",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            Row(
              children: [
                CustomText(
                  text: "Account Information: ",
                  size: 12,
                  weight: FontWeight.w700,
                ),
                CustomText(
                  text: "When you create an account, we collect your",
                  color: kGreyColor,
                ),
              ],
            ),
            CustomText(
              text: "username, email address, and profile information.",
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            Row(
              children: [
                CustomText(
                  text: "Content: ",
                  size: 12,
                  weight: FontWeight.w700,
                ),
                CustomText(
                  text:
                      "We may collect and store the content you create, share, or ",
                  color: kGreyColor,
                ),
              ],
            ),
            CustomText(
              text:
                  "receive on Marchè Social, such as posts, comments, and messages.",
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            Row(
              children: [
                CustomText(
                  text: "Device Information:",
                  size: 12,
                  weight: FontWeight.w700,
                ),
                CustomText(
                  text: "We collect information about the device you use to",
                  color: kGreyColor,
                ),
              ],
            ),
            CustomText(
              text:
                  "to access Marchè Social, including device type, operating system, and unique device identifiers",
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            Row(
              children: [
                CustomText(
                  text: "Usage Information:",
                  size: 12,
                  weight: FontWeight.w700,
                ),
                CustomText(
                  text: "We collect data about your interactions with the app,",
                  color: kGreyColor,
                ),
              ],
            ),
            CustomText(
              text:
                  "including the features you use, the content you view, and your interactions with other users.",
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 30),
            ),
            CustomText(
              text: "2. How We Use Your Information:",
              size: 12,
              weight: FontWeight.w700,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text:
                  "We use the collected information for the following purposes:",
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text:
                  "Providing Services: To provide and improve our services, personalize your experience, and facilitate connections with other users.",
              color: kGreyColor,
            ),
          ],
        ),
      ),
    );
  }
}
