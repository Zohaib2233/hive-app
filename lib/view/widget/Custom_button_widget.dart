import 'package:flutter/material.dart';

import '../../../constants/app_styling.dart';
import '../../constants/app_colors.dart';
import 'Custom_text_widget.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final FontWeight fontWeight;
  final double textSize;
  final double width;
  final double height;
  final VoidCallback onTap;

  const CustomButton({
    Key? key,
    required this.buttonText,
    this.backgroundColor = kTertiaryColor,
    this.textColor = kPrimaryColor,
    this.borderRadius = 58.0,
    this.fontWeight = FontWeight.w600,
    this.textSize = 16.0,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w(context, width),
        height: h(context, height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(h(context, borderRadius)),
          color: backgroundColor,
        ),
        child: Center(
          child: CustomText(
            text: buttonText,
            size: textSize,
            weight: fontWeight,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class CustomButton3 extends StatelessWidget {
  final String buttonText;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final FontWeight fontWeight;
  final double textSize;
  final double width;
  final double height;
  final VoidCallback onTap;

  const CustomButton3({
    Key? key,
    required this.buttonText,
    this.backgroundColor = kTertiaryColor,
    this.textColor = kSecondaryColor,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w600,
    this.textSize = 16.0,
    this.width = double.infinity,
    this.height = 50.0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w(context, width),
        height: h(context, height),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(h(context, borderRadius)),
          color: backgroundColor,
        ),
        child: Center(
          child: CustomText(
            text: buttonText,
            size: textSize,
            weight: fontWeight,
            color: textColor,
          ),
        ),
      ),
    );
  }
}

class CustomButton2 extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double borderRadius;
  final FontWeight fontWeight;
  final double textSize;
  final double width;
  final double height;
  final VoidCallback onTap;

  const CustomButton2({
    Key? key,
    required this.text,
    this.backgroundColor = kSecondaryColor,
    this.textColor = kPrimaryColor,
    this.borderRadius = 8.0,
    this.fontWeight = FontWeight.w500,
    this.textSize = 16.0,
    this.width = 400.0,
    this.height = 50.0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: w(context, width),
        height: h(context, height),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(h(context, borderRadius)),
            color: backgroundColor,
            border: Border.all(color: kPrimaryColor)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: text,
              size: textSize,
              weight: fontWeight,
              color: textColor,
              paddingLeft: 2,
            ),
          ],
        ),
      ),
    );
  }
}
