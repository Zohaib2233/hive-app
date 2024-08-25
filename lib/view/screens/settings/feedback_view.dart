import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class FeedbackView extends StatelessWidget {
  const FeedbackView({super.key});

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
          text: 'Feedback',
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
              text: 'Marchè App Feedback',
              size: 14,
              weight: FontWeight.w600,
            ),
            SizedBox(
              height: h(context, 8),
            ),
            CustomText(
              text:
                  "We value your thoughts! Share your experience with the Marchè Social app by providing feedback. Whether it's a suggestion for improvement, a feature you love, or a challenge you've encountered, your insights matter. Your feedback helps us enhance our user experience  journey. Together, let's make Partner even better!",
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            const Spacer(),
            CustomButton(buttonText: 'Give Feedback at Email', onTap: () {}),
          ],
        ),
      ),
    );
  }
}
