import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class HelpView extends StatelessWidget {
  const HelpView({super.key});

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
          text: 'Help',
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
              text: 'Marchè Social Help Center',
              size: 14,
              weight: FontWeight.w600,
            ),
            SizedBox(
              height: h(context, 8),
            ),
            CustomText(
              text:
                  'Welcome to Marchè Social – Your Social Hub for Posts, groups, and Events!',
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 4),
            ),
            CustomText(
              text:
                  "Explore the world of seamless social interaction, educational pursuits, and event discovery with the Partner app. Whether you're new to the platform or looking to maximize your experience, our Help Center is your go-to resource for guidance and solutions.",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 4),
            ),
            CustomText(
              text:
                  "Discover how to create compelling posts, share engaging courses, and stay updated on exciting events. Our comprehensive guides and step-by-step tutorials are designed to empower you in making the most of every feature Marchè Social has to offer. If you ever find yourself with questions, we're here to help – simply navigate through the sections below to find the answers you need.",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 4),
            ),
            CustomText(
              text: "Let's make your Marchè Social  experience extraordinary!",
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
                  text: "If you want to de activate or delete your account",
                  size: 12,
                  weight: FontWeight.w400,
                ),
                TextButton(
                  onPressed: () {},
                  child: CustomText(
                    text: "click here",
                    size: 12,
                    weight: FontWeight.w400,
                    color: Colors.blue,
                  ),
                )
              ],
            ),
            const Spacer(),
            CustomButton(buttonText: 'Contact Customer Support', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
