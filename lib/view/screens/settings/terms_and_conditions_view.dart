import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class TermandConditionsView extends StatelessWidget {
  const TermandConditionsView({super.key});

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
              text: 'Marchè Social’s Terms & Conditions',
              size: 14,
              weight: FontWeight.w600,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text:
                  "Welcome to Marchè Social! Before you dive into the exciting world of social connections, courses, and events, please take a moment to review our brief terms and conditions. ",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "1. Acceptance of Terms:",
              size: 12,
              weight: FontWeight.w700,
            ),
            SizedBox(
              height: h(context, 4),
            ),
            CustomText(
              text:
                  "By using the Marchè Social app, you agree to abide by these terms and conditions.",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "2. User Responsibilities: ",
              size: 12,
              weight: FontWeight.w700,
            ),
            SizedBox(
              height: h(context, 4),
            ),
            CustomText(
              text:
                  "You are responsible for the content you post. Respect the community guidelines and ensure your contributions are lawful and respectful.",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "3. Privacy:",
              size: 12,
              weight: FontWeight.w700,
            ),
            SizedBox(
              height: h(context, 4),
            ),
            CustomText(
              text:
                  "We value your privacy. Check out our Privacy Policy to understand how we collect, use, and protect your personal information.",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "4. Intellectual Property:",
              size: 12,
              weight: FontWeight.w700,
            ),
            SizedBox(
              height: h(context, 4),
            ),
            CustomText(
              text:
                  "Respect intellectual property rights. Don't infringe on copyrights or trademarks when posting content.",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "5. Prohibited Activities:",
              size: 12,
              weight: FontWeight.w700,
            ),
            SizedBox(
              height: h(context, 4),
            ),
            CustomText(
              text:
                  "Engaging in harmful activities, spam, or any form of abuse is not allowed. Be a positive force in our community.",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "6. Termination:",
              size: 12,
              weight: FontWeight.w700,
            ),
            SizedBox(
              height: h(context, 4),
            ),
            CustomText(
              text:
                  " We reserve the right to terminate accounts violating our terms without notice.",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "7. Updates:",
              size: 12,
              weight: FontWeight.w700,
            ),
            SizedBox(
              height: h(context, 4),
            ),
            CustomText(
              text:
                  "Terms may be updated; it's your responsibility to stay informed.",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 30),
            ),
            CustomText(
              text:
                  "Thanks for being part of Marchè – let's create an amazing social experience together!",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
          ],
        ),
      ),
    );
  }
}
