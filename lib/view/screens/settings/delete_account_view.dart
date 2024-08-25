import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class DeleteAccountView extends StatefulWidget {
  const DeleteAccountView({super.key});

  @override
  State<DeleteAccountView> createState() => _DeleteAccountViewState();
}

class _DeleteAccountViewState extends State<DeleteAccountView> {
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
          text: 'Account',
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
              text:
                  "Please state your reason for leaving us. Your Feedback help us to improve ourselves.",
              size: 12,
              weight: FontWeight.w400,
            ),
            SizedBox(
              height: h(context, 8),
            ),
            const CustomTextField3(
              hintText: 'Write your message',
              maxLines: 7,
            ),
            SizedBox(
              height: h(context, 30),
            ),
            Center(
              child: CustomText(
                text: "Are you sure you want to Delete you account?",
                size: 16,
                weight: FontWeight.w600,
                color: kFullBlackBgColor,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: h(context, 4),
            ),
            Center(
              child: CustomText(
                text:
                    "If you delete your account you will not be able to retrieve your data again.",
                size: 12,
                weight: FontWeight.w400,
                color: kGreyColor,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: h(context, 40),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: 'Cancel',
                    textColor: Colors.white,
                    onTap: () {},
                    backgroundColor: const Color(0xffd5d5d5),
                  ),
                ),
                SizedBox(
                  width: w(context, 40),
                ),
                Expanded(
                  child: CustomButton(
                    buttonText: 'Delete',
                    textColor: Colors.white,
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const ConfirmationDialog();
                        },
                      );
                    },
                    backgroundColor: const Color(0xffE2190C),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h(context, 30),
            ),
          ],
        ),
      ),
    );
  }
}

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: kSecondaryColor,
      surfaceTintColor: kSecondaryColor,
      content: Padding(
        padding: symmetric(
          context,
          horizontal: 20,
          vertical: 40,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "Are you sure you want to Logout from your account?",
              size: 16,
              weight: FontWeight.w600,
              color: kFullBlackBgColor,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: "You can login any time",
              size: 14,
              weight: FontWeight.w400,
              color: kGreyColor,
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: h(context, 40),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomButton(
                    buttonText: 'Cancel',
                    textColor: Colors.white,
                    onTap: () {},
                    backgroundColor: const Color(0xffd5d5d5),
                  ),
                ),
                SizedBox(
                  width: w(context, 40),
                ),
                Expanded(
                  child: CustomButton(
                    buttonText: 'Delete',
                    textColor: Colors.white,
                    onTap: () {},
                    backgroundColor: const Color(0xffE2190C),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
