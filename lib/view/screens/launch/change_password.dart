import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import 'confirmation.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F5F5),
        leading: Padding(
          padding: all(context, 15),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: CommonImageView(
              imagePath: Assets.imagesBack,
              height: 28,
              width: 28,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: symmetric(context, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h(context, 12),
            ),
            CustomText(
              text: 'Reset password',
              size: 24,
              weight: FontWeight.w600,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: 'Please type something you’ll remember',
              size: 16,
              color: const Color(0xff9D9D9D),
              weight: FontWeight.w400,
            ),
            SizedBox(
              height: h(context, 40),
            ),
            CustomText(
              text: "New password",
              size: 14,
            ),
            SizedBox(
              height: h(context, 6),
            ),
            const CustomTextField2(
              hintText: "must be 8 characters",
            ),
            SizedBox(
              height: h(context, 20),
            ),
            CustomText(
              text: "Confirm new password",
              size: 14,
            ),
            SizedBox(
              height: h(context, 6),
            ),
            const CustomTextField2(
              hintText: "repeat password",
            ),
            SizedBox(
              height: h(context, 42),
            ),
            CustomButton(
              buttonText: "Reset password",
              onTap: () {
                Get.offAll(() => const Confirmation());
              },
            )
          ],
        ),
      ),
    );
  }
}
