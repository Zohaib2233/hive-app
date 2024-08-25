import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  bool notification = false;
  bool group = false;
  bool messages = false;
  bool email = false;
  bool events = false;
  bool interactions = false;
  bool activities = false;

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
          text: 'Notifcations',
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),
      body: Padding(
        padding: symmetric(context, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              dense: true,
              title: CustomText(
                text: 'Notifications',
                size: 14,
                weight: FontWeight.w400,
              ),
              trailing: Switch(
                inactiveThumbColor: kGreybackgroundColor,
                trackOutlineColor:
                    const MaterialStatePropertyAll(klightGreyColor),
                value: notification,
                onChanged: (value) {
                  setState(() {
                    notification = value;
                  });
                },
                activeColor: kTertiaryColor,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
            ListTile(
              dense: true,
              title: CustomText(
                text: 'Groups',
                size: 14,
                weight: FontWeight.w400,
              ),
              trailing: Switch(
                inactiveThumbColor: kGreybackgroundColor,
                trackOutlineColor:
                    const MaterialStatePropertyAll(klightGreyColor),
                value: group,
                onChanged: (value) {
                  setState(() {
                    group = value;
                  });
                },
                activeColor: kTertiaryColor,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
            ListTile(
              dense: true,
              title: CustomText(
                text: 'Messages',
                size: 14,
                weight: FontWeight.w400,
              ),
              trailing: Switch(
                inactiveThumbColor: kGreybackgroundColor,
                trackOutlineColor:
                    const MaterialStatePropertyAll(klightGreyColor),
                value: messages,
                onChanged: (value) {
                  setState(() {
                    messages = value;
                  });
                },
                activeColor: kTertiaryColor,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
            ListTile(
              dense: true,
              title: CustomText(
                text: 'Email',
                size: 14,
                weight: FontWeight.w400,
              ),
              trailing: Switch(
                inactiveThumbColor: kGreybackgroundColor,
                trackOutlineColor:
                    const MaterialStatePropertyAll(klightGreyColor),
                value: email,
                onChanged: (value) {
                  setState(() {
                    email = value;
                  });
                },
                activeColor: kTertiaryColor,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
            ListTile(
              dense: true,
              title: CustomText(
                text: 'Events',
                size: 14,
                weight: FontWeight.w400,
              ),
              trailing: Switch(
                inactiveThumbColor: kGreybackgroundColor,
                trackOutlineColor:
                    const MaterialStatePropertyAll(klightGreyColor),
                value: events,
                onChanged: (value) {
                  setState(() {
                    events = value;
                  });
                },
                activeColor: kTertiaryColor,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
            ListTile(
              dense: true,
              title: CustomText(
                text: 'Interactions',
                size: 14,
                weight: FontWeight.w400,
              ),
              trailing: Switch(
                inactiveThumbColor: kGreybackgroundColor,
                trackOutlineColor:
                    const MaterialStatePropertyAll(klightGreyColor),
                value: interactions,
                onChanged: (value) {
                  setState(() {
                    interactions = value;
                  });
                },
                activeColor: kTertiaryColor,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
            ListTile(
              dense: true,
              title: CustomText(
                text: 'Activities',
                size: 14,
                weight: FontWeight.w400,
              ),
              trailing: Switch(
                inactiveThumbColor: kGreybackgroundColor,
                trackOutlineColor:
                    const MaterialStatePropertyAll(klightGreyColor),
                value: activities,
                onChanged: (value) {
                  setState(() {
                    activities = value;
                  });
                },
                activeColor: kTertiaryColor,
              ),
            ),
            const Divider(
              color: Color(0xff4285F4),
              thickness: 1,
            ),
          ],
        ),
      ),
    );
  }
}
