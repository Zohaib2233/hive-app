import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import 'delete_account_view.dart';
import 'feedback_view.dart';
import 'help_view.dart';
import 'language_view.dart';
import 'notifications_view.dart';
import 'privacy_policy_view.dart';
import 'terms_and_conditions_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
          text: 'Settings',
          size: 16,
          weight: FontWeight.w600,
        ),
        leadingWidth: w(context, 50),
      ),
      body: Padding(
        padding: symmetric(context, vertical: 20),
        child: Column(
          children: [
            Padding(
              padding: symmetric(context, horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  text: 'General',
                  size: 12,
                  weight: FontWeight.w400,
                  color: kGreyColor,
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => const NotificationsView());
              },
              dense: true,
              title: CustomText(
                text: 'Notifications',
                size: 14,
                weight: FontWeight.w400,
              ),
              trailing: CommonImageView(
                imagePath: Assets.imagesArrowRightGrey,
                width: w(context, 16),
                height: h(context, 16),
                fit: BoxFit.contain,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
            ListTile(
              onTap: () {
                Get.to(() => const LanguagesView());
              },
              dense: true,
              title: CustomText(
                text: 'Languages',
                size: 14,
                weight: FontWeight.w400,
                color: kFullBlackBgColor,
              ),
              trailing: CommonImageView(
                imagePath: Assets.imagesArrowRightGrey,
                width: w(context, 16),
                height: h(context, 16),
                fit: BoxFit.contain,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
            Padding(
              padding: symmetric(context, horizontal: 16),
              child: SizedBox(
                height: h(context, 30),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: CustomText(
                    text: 'Marche Social',
                    size: 12,
                    weight: FontWeight.w400,
                    color: kGreyColor,
                  ),
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Get.to(() => const TermandConditionsView());
              },
              dense: true,
              title: CustomText(
                text: 'Terms and Conditions',
                size: 14,
                weight: FontWeight.w400,
                color: kFullBlackBgColor,
              ),
              trailing: CommonImageView(
                imagePath: Assets.imagesArrowRightGrey,
                width: w(context, 16),
                height: h(context, 16),
                fit: BoxFit.contain,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
            ListTile(
              onTap: () {
                Get.to(() => const PrivacyPolicyView());
              },
              dense: true,
              title: CustomText(
                text: 'Privacy Policy',
                size: 14,
                weight: FontWeight.w400,
                color: kFullBlackBgColor,
              ),
              trailing: CommonImageView(
                imagePath: Assets.imagesArrowRightGrey,
                width: w(context, 16),
                height: h(context, 16),
                fit: BoxFit.contain,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
            ListTile(
              onTap: () {
                Get.to(() => const FeedbackView());
              },
              dense: true,
              title: CustomText(
                text: 'Feedback',
                size: 14,
                weight: FontWeight.w400,
                color: kFullBlackBgColor,
              ),
              trailing: CommonImageView(
                imagePath: Assets.imagesArrowRightGrey,
                width: w(context, 16),
                height: h(context, 16),
                fit: BoxFit.contain,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
            ListTile(
              onTap: () {
                Get.to(() => const HelpView());
              },
              dense: true,
              title: CustomText(
                text: 'Help',
                size: 14,
                weight: FontWeight.w400,
                color: kFullBlackBgColor,
              ),
              trailing: CommonImageView(
                imagePath: Assets.imagesArrowRightGrey,
                width: w(context, 16),
                height: h(context, 16),
                fit: BoxFit.contain,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
            ListTile(
              onTap: () {
                Get.to(() => const DeleteAccountView());
              },
              dense: true,
              title: CustomText(
                text: 'Delete Account',
                size: 14,
                weight: FontWeight.w600,
                color: const Color(0xffE2190C),
              ),
              trailing: CommonImageView(
                imagePath: Assets.imagesArrowRightGrey,
                width: w(context, 16),
                height: h(context, 16),
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
