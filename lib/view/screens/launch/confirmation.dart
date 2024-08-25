import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_images.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/common_image_view_widget.dart';
import 'signin.dart';

class Confirmation extends StatelessWidget {
  const Confirmation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Padding(
          padding: symmetric(
            context,
            horizontal: 20,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CommonImageView(
                imagePath: Assets.imagesStars,
                height: 84,
                width: 86,
              ),
              SizedBox(
                height: h(context, 36),
              ),
              CustomText(
                text: "Password changed",
                size: 24,
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: "Your password has been changed succesfully",
                size: 16,
                textAlign: TextAlign.center,
                color: const Color(0xff9D9D9D),
                paddingLeft: 70,
                paddingRight: 70,
              ),
              SizedBox(
                height: h(context, 28),
              ),
              CustomButton(
                buttonText: "Back to login",
                onTap: () {
                  Get.to(() => SignIn());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
