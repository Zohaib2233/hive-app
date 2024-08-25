import 'dart:developer';

import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../constants/app_images.dart';
import '../../../core/bindings/bindings.dart';
import '../../../core/constants/firebase_constants.dart';
import '../../../core/constants/shared_pref_keys.dart';
import '../../../core/utils/utils.dart';
import '../../../services/shared_preferences_services.dart';
import '../../widget/common_image_view_widget.dart';
import '../launch/options.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: w(context, 270),
      backgroundColor: kGreybackgroundColor,
      child: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              leading: CommonImageView(
                imagePath: Assets.imagesBack,
                height: 29,
                width: 29,
                fit: BoxFit.contain,
              ),
              onTap: () => {Navigator.pop(context)},
            ),
            Padding(
              padding: symmetric(context, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(h(context, 10)),
                ),
                child: ListTile(
                  leading: CommonImageView(
                    imagePath: Assets.imagesSide1,
                    height: 29,
                    width: 29,
                    fit: BoxFit.contain,
                  ),
                  onTap: () => {Navigator.pop(context)},
                  title: CustomText(
                    text: "Apiaries",
                    size: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h(context, 3),
            ),
            Padding(
              padding: symmetric(context, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(h(context, 10)),
                ),
                child: ListTile(
                  leading: CommonImageView(
                    imagePath: Assets.imagesSide2,
                    height: 29,
                    width: 29,
                    fit: BoxFit.contain,
                  ),
                  onTap: () => {Navigator.pop(context)},
                  title: CustomText(
                    text: "Hives",
                    size: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h(context, 3),
            ),
            Padding(
              padding: symmetric(context, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(h(context, 10)),
                ),
                child: ListTile(
                  leading: CommonImageView(
                    imagePath: Assets.imagesBottom3,
                    height: 29,
                    width: 29,
                    fit: BoxFit.contain,
                  ),
                  onTap: () => {Navigator.pop(context)},
                  title: CustomText(
                    text: "Tasks",
                    size: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h(context, 3),
            ),
            Padding(
              padding: symmetric(context, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(h(context, 10)),
                ),
                child: ListTile(
                  leading: CommonImageView(
                    imagePath: Assets.imagesSide4,
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                  onTap: () => {Navigator.pop(context)},
                  title: CustomText(
                    text: "Subscription",
                    size: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h(context, 3),
            ),
            Padding(
              padding: symmetric(context, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(h(context, 10)),
                ),
                child: ListTile(
                  leading: CommonImageView(
                    imagePath: Assets.imagesSide5,
                    height: 24,
                    width: 24,
                    fit: BoxFit.contain,
                  ),
                  onTap: () => {Navigator.pop(context)},
                  title: CustomText(
                    text: "Chats",
                    size: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h(context, 3),
            ),
            Padding(
              padding: symmetric(context, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(h(context, 10)),
                ),
                child: ListTile(
                  leading: CommonImageView(
                    imagePath: Assets.imagesSide6,
                    height: 20,
                    width: 20,
                    fit: BoxFit.contain,
                  ),
                  onTap: () => {Navigator.pop(context)},
                  title: CustomText(
                    text: "Notifications",
                    size: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h(context, 3),
            ),
            Padding(
              padding: symmetric(context, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(h(context, 10)),
                ),
                child: ListTile(
                  leading: CommonImageView(
                    imagePath: Assets.imagesSide7,
                    height: 29,
                    width: 29,
                    fit: BoxFit.contain,
                  ),
                  onTap: () => {Navigator.pop(context)},
                  title: CustomText(
                    text: "Data Repository",
                    size: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h(context, 3),
            ),
            Padding(
              padding: symmetric(context, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(h(context, 10)),
                ),
                child: ListTile(
                  leading: CommonImageView(
                    imagePath: Assets.imagesSide8,
                    height: 25,
                    width: 25,
                    fit: BoxFit.contain,
                  ),
                  onTap: () => {Navigator.pop(context)},
                  title: CustomText(
                    text: "Settings",
                    size: 16,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h(context, 80),
            ),
            Padding(
              padding: symmetric(context, horizontal: 20),
              child: Container(
                decoration: BoxDecoration(
                  color: kSecondaryColor,
                  borderRadius: BorderRadius.circular(h(context, 10)),
                ),
                child: ListTile(
                  leading: CommonImageView(
                    imagePath: Assets.imagesSide9,
                    height: 29,
                    width: 29,
                    fit: BoxFit.contain,
                  ),
                  onTap: () => {
                    Utils.showLogoutDialog(onCancel: () {
                      Get.back();
                    }, onConfirm: () async {
                      GoogleSignIn googleSignIn = GoogleSignIn();

                      await GoogleSignIn().signOut();
                      try {
                        await googleSignIn.disconnect();
                        await googleSignIn.currentUser!.clearAuthCache();

                        log("Google acccount disconnected and signed out");
                      } catch (e) {
                        log('failed to disconnect on signout');
                      }

                      await FirebaseConstants.auth.signOut();

                      SharedPreferenceService.instance
                          .removeSharedPreferenceBool(SharedPrefKeys.loggedIn);

                      Get.offAll(Options(), binding: AuthBinding());
                    })
                  },
                  title: CustomText(
                    text: "Log Out",
                    size: 16,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
