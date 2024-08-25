import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_images.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/view/widget/Custom_button_widget.dart';
import 'package:beekeep/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widget/Custom_text_widget.dart';

class Subscription extends StatefulWidget {
  const Subscription({Key? key});

  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  int _selectedContainerIndex = -1;

  void _selectContainer(int index) {
    setState(() {
      _selectedContainerIndex = index;
    });
  }

  Widget _buildContainer(
    BuildContext context,
    String title,
    String subtitle,
    bool isBestValue,
    int index,
  ) {
    return GestureDetector(
      onTap: () {
        _selectContainer(index);
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: kSecondaryColor,
          borderRadius: BorderRadius.circular(
            h(context, 16),
          ),
          border: Border.all(
            color: _selectedContainerIndex == index
                ? Colors.yellow
                : Colors.transparent,
            width: _selectedContainerIndex == index ? 2 : 2,
          ),
        ),
        child: Padding(
          padding: all(context, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    text: title,
                    size: 20,
                    weight: FontWeight.w600,
                  ),
                  if (isBestValue)
                    CustomButton3(
                      onTap: () {},
                      width: 100,
                      borderRadius: 20,
                      height: 32,
                      textSize: 12,
                      backgroundColor: const Color(0xff8FBC8F),
                      buttonText: 'Best Value',
                    )
                ],
              ),
              SizedBox(
                height: h(context, 10),
              ),
              CustomText(
                text: subtitle,
                size: 14,
                color: kGreyColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: symmetric(
              context,
              horizontal: 20,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: CommonImageView(
                      imagePath: Assets.imagesCross,
                      height: 35,
                      width: 35,
                    ),
                  ),
                ),
                SizedBox(
                  height: h(context, 8),
                ),
                CustomText(
                  text: "Get Premium",
                  size: 24,
                  color: const Color(0xff0D368C),
                  weight: FontWeight.w700,
                ),
                SizedBox(
                  height: h(context, 16),
                ),
                CustomText(
                  text:
                      "Unlock all the power of this mobile tool and enjoy digital experience like never before!",
                  size: 14,
                  textAlign: TextAlign.center,
                  paddingLeft: 40,
                  paddingRight: 40,
                  color: const Color.fromRGBO(9, 39, 101, 0.70),
                ),
                SizedBox(
                  height: h(context, 35),
                ),
                CommonImageView(
                  imagePath: Assets.imagesSubscriptionbg,
                  fit: BoxFit.contain,
                  height: 115,
                  width: double.infinity,
                ),
                SizedBox(
                  height: h(context, 35),
                ),
                _buildContainer(
                  context,
                  "Annual",
                  "First 30 days free - Then \$999/Year",
                  true,
                  0,
                ),
                SizedBox(
                  height: h(context, 16),
                ),
                _buildContainer(
                  context,
                  "Monthly",
                  "First 7 days free - Then \$99/Month",
                  false,
                  1,
                ),
                SizedBox(
                  height: h(context, 36),
                ),
                CustomButton3(
                  buttonText: "Start 30 Day Free Trial",
                  onTap: () {},
                ),
                SizedBox(
                  height: h(context, 14),
                ),
                CustomText(
                  text:
                      "By placing this order, you agree to the Terms of Service and Privacy Policy. Subscription automatically renews unless auto-renew is turned off at least 24-hours before the end of the current period.",
                  color: kGreyColor,
                  size: 14,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
