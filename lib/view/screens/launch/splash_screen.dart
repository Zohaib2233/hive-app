// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:async';

import 'package:beekeep/core/bindings/bindings.dart';
import 'package:beekeep/core/constants/shared_pref_keys.dart';
import 'package:beekeep/core/global/functions.dart';
import 'package:beekeep/services/shared_preferences_services.dart';
import 'package:beekeep/view/screens/bottombar/bottombar.dart';
import 'package:beekeep/view/screens/launch/onboarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/authController/login_controller.dart';
import '../../../controllers/authController/register_controller.dart';
import 'options.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    splashScreenHandler();
  }

  Future<void> splashScreenHandler() async {
    bool isBoardingComplete = await SharedPreferenceService.instance.getSharedPreferenceBool(SharedPrefKeys.completeOnboarding)??false;
    bool isLoggedIn = await SharedPreferenceService.instance.getSharedPreferenceBool(SharedPrefKeys.loggedIn)??false;

    print("isBoardingComplete = $isBoardingComplete");

    if(isBoardingComplete){
      if(isLoggedIn){
        getUserDataStream(userId: FirebaseAuth.instance.currentUser!.uid);
        Get.delete<RegisterController>();
        Get.delete<LoginController>();
        Timer(
          Duration(milliseconds: 10),
              () => Get.offAll(() => BottomNavBar(),binding: HomeBindings()),
        );
      }
      else{
        Timer(
          Duration(milliseconds: 10),
              () => Get.offAll(() => Options()),
        );
      }

    }
    else{
      Timer(
        Duration(milliseconds: 10),
            () => Get.offAll(() => Onboarding()),
      );
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          // child: Image(
          //   image: AssetImage(Assets.imagesLogo),
          //   fit: BoxFit.contain,
          //   height: h(context, 60),
          //   width: w(context, 188),
          // ),
          ),
    );
  }
}
