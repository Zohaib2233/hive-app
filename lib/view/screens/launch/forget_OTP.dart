// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import 'change_password.dart';

class ForgetOTP extends StatefulWidget {
  const ForgetOTP({super.key});

  @override
  State<ForgetOTP> createState() => _ForgetOTPState();
}

class _ForgetOTPState extends State<ForgetOTP> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: w(context, 60),
      height: h(context, 72),
      textStyle: TextStyle(
        fontSize: f(context, 26),
        color: kPrimaryColor,
        fontWeight: FontWeight.w700,
      ),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        border: Border.all(
          color: Color(0xffD8DADC),
        ),
        borderRadius: BorderRadius.circular(h(context, 15)),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: kPrimaryColor,
      ),
      borderRadius: BorderRadius.circular(h(context, 15)),
    );

    final submittedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: kTertiaryColor,
      ),
      borderRadius: BorderRadius.circular(h(context, 15)),
    );

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
        padding: symmetric(
          context,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: h(context, 12),
            ),
            CustomText(
              text: 'Please check your phone',
              size: 24,
              weight: FontWeight.w600,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text:
                  'We’ve sent an Email with an activation code to your email luq************@gmail.com',
              size: 16,
              color: const Color(0xff9D9D9D),
              weight: FontWeight.w400,
            ),
            SizedBox(
              height: h(context, 25),
            ),
            Pinput(
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              length: 4,
              validator: (s) {
                return s == '1234' ? null : 'Pin is incorrect';
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin) {
                Get.to(() => const ChangePassword());
              },
            ),
            SizedBox(
              height: h(context, 162),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  text: "Send code again",
                  size: 16,
                  color: kTertiaryColor,
                  weight: FontWeight.w600,
                ),
                SizedBox(
                  width: w(context, 10),
                ),
                CustomText(
                  text: "00:20",
                  size: 16,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
