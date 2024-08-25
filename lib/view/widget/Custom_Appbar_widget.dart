import 'package:beekeep/core/bindings/bindings.dart';
import 'package:beekeep/view/screens/notifications/notifications_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_styling.dart';
import '../../models/user_model.dart';
import '../screens/chat/chat_view.dart';
import '../screens/settings/subscription.dart';
import 'Custom_text_widget.dart';
import 'common_image_view_widget.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Rx<UserModel> name;

  const CustomAppBar({
    required this.name,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: const Color(0xffF5F5F5),
      title: Row(
        children: [
          GestureDetector(
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            child: CommonImageView(
              imagePath: Assets.imagesMenuicon,
              fit: BoxFit.contain,
              width: 25,
              height: 19,
            ),
          ),
          SizedBox(
            width: w(context, 14),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: "Welcome Back!",
                size: 14,
                weight: FontWeight.w300,
              ),
              Obx(
                () => CustomText(
                  text: name.value.name,
                  size: 14,
                  weight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.to(() => const Subscription());
            },
            child: CommonImageView(
              imagePath: Assets.imagesKing,
              fit: BoxFit.contain,
              width: 36,
              height: 136,
            ),
          ),
          SizedBox(
            width: w(context, 6),
          ),
          GestureDetector(
            onTap: (){
              Get.to(()=>NotificationsView(),binding: NotificationBinding());
            },
            child: CommonImageView(
              imagePath: Assets.imagesBell,
              fit: BoxFit.contain,
              width: 36,
              height: 136,
            ),
          ),
          SizedBox(
            width: w(context, 6),
          ),
          GestureDetector(
            onTap: () {
              Get.to(() => const ChatView());
            },
            child: CommonImageView(
              imagePath: Assets.imagesMsg,
              fit: BoxFit.contain,
              width: 36,
              height: 136,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class CustomChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String backImagePath;
  final String? profileImageUrl;
  final String name, status;

  const CustomChatAppBar({
    Key? key,
    required this.backImagePath,
    required this.profileImageUrl,
    required this.name,
    required this.status,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: kGreybackgroundColor,
      automaticallyImplyLeading: false,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: CommonImageView(
                imagePath: backImagePath,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(
            width: 29,
          ),
          Container(
            width: 47,
            height: 47,
            clipBehavior: Clip.antiAlias,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: CommonImageView(

              url: profileImageUrl,
              fit: BoxFit.contain,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: name,
                size: 14,
                weight: FontWeight.w600,
                paddingLeft: 11,
                paddingBottom: 10,
              ),
              CustomText(
                text: status,
                size: 12,
                color: kGreenColor,
                paddingLeft: 11,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
