import 'dart:developer';

import 'package:beekeep/core/bindings/bindings.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/constants/shared_pref_keys.dart';
import 'package:beekeep/services/shared_preferences_services.dart';
import 'package:beekeep/view/screens/launch/options.dart';
import 'package:beekeep/view/screens/settings/settings_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../../core/global/instance_variables.dart';
import '../../../core/utils/utils.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import '../settings/delete_account_view.dart';
import '../settings/help_view.dart';
import '../settings/privacy_policy_view.dart';
import '../settings/subscription.dart';
import '../settings/terms_and_conditions_view.dart';
import 'profile_view.dart';

class ProfileMainView extends StatelessWidget {
  const ProfileMainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: all(context, 20),
          child: Column(
            children: [
              SizedBox(
                height: h(context, 38),
              ),
              Row(
                children: [
                  Obx(()=>CommonImageView(
                    height: 80,
                    width: 90,
                    radius: 150,

                    url: userModelGlobal.value.profilePicture,
                  ),
                  ),
                  SizedBox(
                    width: w(context, 15),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Obx(()=>CustomText(
                          text: userModelGlobal.value.name,
                          size: 16,
                          weight: FontWeight.w600,
                          color: kFullBlackBgColor,
                        ),
                      ),
                      SizedBox(
                        height: w(context, 4),
                      ),
                      CustomText(
                        text: '@alex',
                        size: 12,
                        weight: FontWeight.w400,
                        color: kGreyColor,
                      ),
                      SizedBox(
                        height: h(context, 4),
                      ),
                      Obx(()=>CustomText(
                          text: userModelGlobal.value.email,
                          size: 12,
                          weight: FontWeight.w400,
                          color: kGreyColor,
                        ),
                      ),
                    ],
                  )
                ],
              ),
              SizedBox(
                height: h(context, 15),
              ),
              const Divider(
                color: kDividerColor,
                thickness: 1.5,
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Get.to(() => const ProfileView());
                },
                leading: CommonImageView(
                  imagePath: Assets.imagesProfileIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                title: CustomText(
                  text: 'Profile',
                  size: 16,
                  weight: FontWeight.w400,
                ),
                trailing: CommonImageView(
                  imagePath: Assets.imagesTrailingIcon,
                  width: 6,
                  height: 12,
                  fit: BoxFit.contain,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Get.to(() => const SettingsView());
                },
                leading: CommonImageView(
                  imagePath: Assets.imagesSettingsIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                title: CustomText(
                  text: 'Settings',
                  size: 16,
                  weight: FontWeight.w400,
                ),
                trailing: CommonImageView(
                  imagePath: Assets.imagesTrailingIcon,
                  width: 6,
                  height: 12,
                  fit: BoxFit.contain,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Get.to(() => const Subscription());
                },
                leading: CommonImageView(
                  imagePath: Assets.imagesSubscriptionIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                title: CustomText(
                  text: 'Subscription',
                  size: 16,
                  weight: FontWeight.w400,
                ),
                trailing: CommonImageView(
                  imagePath: Assets.imagesTrailingIcon,
                  width: 6,
                  height: 12,
                  fit: BoxFit.contain,
                ),
              ),
              ListTile(
                dense: true,
                leading: CommonImageView(
                  imagePath: Assets.imagesLanguageIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                title: CustomText(
                  text: 'Language',
                  size: 16,
                  weight: FontWeight.w400,
                  color: kFullBlackBgColor,
                ),
                trailing: CommonImageView(
                  imagePath: Assets.imagesTrailingIcon,
                  width: 6,
                  height: 12,
                  fit: BoxFit.contain,
                ),
              ),
              const Divider(
                color: kDividerColor,
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Get.to(() => const HelpView());
                },
                leading: CommonImageView(
                  imagePath: Assets.imagesSupportIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                title: CustomText(
                  text: 'Support',
                  size: 16,
                  weight: FontWeight.w400,
                  color: kFullBlackBgColor,
                ),
                trailing: CommonImageView(
                  imagePath: Assets.imagesTrailingIcon,
                  width: 6,
                  height: 12,
                  fit: BoxFit.contain,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Get.to(() => const TermandConditionsView());
                },
                leading: CommonImageView(
                  imagePath: Assets.imagesDocumentIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                title: CustomText(
                  text: 'Terms and conditions',
                  size: 16,
                  weight: FontWeight.w400,
                  color: kFullBlackBgColor,
                ),
                trailing: CommonImageView(
                  imagePath: Assets.imagesTrailingIcon,
                  width: 6,
                  height: 12,
                  fit: BoxFit.contain,
                ),
              ),
              ListTile(
                dense: true,
                onTap: () {
                  Get.to(() => const PrivacyPolicyView());
                },
                leading: CommonImageView(
                  imagePath: Assets.imagesShieldIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                title: CustomText(
                  text: 'Privacy Policy',
                  size: 16,
                  weight: FontWeight.w400,
                  color: kFullBlackBgColor,
                ),
                trailing: CommonImageView(
                  imagePath: Assets.imagesTrailingIcon,
                  width: 6,
                  height: 12,
                  fit: BoxFit.contain,
                ),
              ),
              // ListTile(
              //   dense: true,
              //   onTap: () {
              //     Get.to(() => const DeleteAccountView());
              //   },
              //   leading: CommonImageView(
              //     imagePath: Assets.imagesLogoutIcon,
              //     width: 24,
              //     height: 24,
              //     fit: BoxFit.contain,
              //   ),
              //   title: CustomText(
              //     text: 'Delete account',
              //     size: 16,
              //     weight: FontWeight.w400,
              //     color: kFullBlackBgColor,
              //   ),
              //   trailing: CommonImageView(
              //     imagePath: Assets.imagesTrailingIcon,
              //     width: 6,
              //     height: 12,
              //     fit: BoxFit.contain,
              //   ),
              // ),
              ListTile(
                dense: true,
                onTap: () async {

                Utils.showLogoutDialog(
                  onCancel: (){
                    Get.back();
                  },
                  onConfirm: () async {
                    GoogleSignIn googleSignIn = GoogleSignIn();

                    await GoogleSignIn().signOut();
                    try {
                      await googleSignIn.disconnect();
                      await googleSignIn.currentUser!
                          .clearAuthCache();

                      log("Google acccount disconnected and signed out");
                    } catch (e) {
                      log('failed to disconnect on signout');
                    }

                    await FirebaseConstants.auth.signOut();

                    SharedPreferenceService.instance.removeSharedPreferenceBool(SharedPrefKeys.loggedIn);



                    Get.offAll(Options(),binding: AuthBinding());

                  }
                );
                },
                leading: CommonImageView(
                  imagePath: Assets.imagesLogoutIcon,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
                title: CustomText(
                  text: 'Logout',
                  size: 16,
                  weight: FontWeight.w400,
                  color: kFullBlackBgColor,
                ),
                trailing: CommonImageView(
                  imagePath: Assets.imagesTrailingIcon,
                  width: 6,
                  height: 12,
                  fit: BoxFit.contain,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
