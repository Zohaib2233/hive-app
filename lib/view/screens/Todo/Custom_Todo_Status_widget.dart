import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/common_image_view_widget.dart';
import '../../widget/custom_button_widget.dart';
import '../../widget/custom_text_widget.dart';

class CustomToDoStatus extends StatelessWidget {
  final String startDate;
  final String endDate;
  final String priority;
  final String status;
  final String subject;

  const CustomToDoStatus({
    Key? key,
    required this.startDate,
    required this.endDate,
    required this.priority,
    required this.status, required this.subject,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color buttonBackgroundColor = Colors.transparent;
    Color buttonTextColor = Colors.black;

    if (status.toLowerCase() == "due") {
      buttonBackgroundColor = const Color(0xffE2190C);
      buttonTextColor = Colors.white;
    } else if (status.toLowerCase() == "processing") {
      buttonBackgroundColor = const Color(0xff027B42);
      buttonTextColor = Colors.white;
    } else if (status.toLowerCase() == "incomplete") {
      buttonBackgroundColor = const Color.fromRGBO(226, 25, 12, 0.15);
      buttonTextColor = const Color(0xffE2190C);
    } else if (status.toLowerCase() == "completed") {
      buttonBackgroundColor = const Color(0xff0CE27D);
      buttonTextColor = Colors.white;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: w(context, 500),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(
          h(context, 10),
        ),
      ),
      child: Padding(
        padding: all(context, 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: subject,
                  size: 14,
                  weight: FontWeight.w600,
                ),
                CommonImageView(
                  imagePath: Assets.imagesEdit,
                  height: 20,
                  width: 20,
                )
              ],
            ),
            SizedBox(
              height: h(context, 11),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Start Date",
                  weight: FontWeight.w500,
                ),
                CustomText(
                  text: startDate,
                  color: const Color(0xff666666),
                ),
              ],
            ),
            SizedBox(
              height: h(context, 7),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "End Date",
                  weight: FontWeight.w500,
                ),
                CustomText(
                  text: endDate,
                  color: const Color(0xff666666),
                ),
              ],
            ),
            SizedBox(
              height: h(context, 7),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Priority",
                  weight: FontWeight.w500,
                ),
                CustomText(
                  text: priority,
                  color: const Color(0xff666666),
                ),
              ],
            ),
            SizedBox(
              height: h(context, 7),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "Status",
                  weight: FontWeight.w500,
                ),
                CustomButton(
                  buttonText: status.capitalize!,
                  textColor: buttonTextColor,
                  backgroundColor: buttonBackgroundColor,
                  textSize: 12,
                  fontWeight: FontWeight.w400,
                  onTap: () {},
                  height: h(context, 24),
                  width: w(context, 100),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
