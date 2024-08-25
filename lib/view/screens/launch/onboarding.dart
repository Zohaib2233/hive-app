// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:beekeep/core/constants/shared_pref_keys.dart';
import 'package:beekeep/services/shared_preferences_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import 'options.dart';

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  int _currentPage = 0;

  final PageController _pageController = PageController();

  final List<String> images = [
    Assets.imagesBg1,
    Assets.imagesBg2,
    Assets.imagesBg3
  ];

  Future<void> _nextPage() async {
    if (_currentPage < images.length - 1) {
      _pageController.nextPage(
          duration: Duration(milliseconds: 300), curve: Curves.ease);
    } else {
      print("Saved OnBoarding ");
      await SharedPreferenceService.instance.saveSharedPreferenceBool(key: SharedPrefKeys.completeOnboarding, value: true);
      Get.offAll(() => Options());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: images.length,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            itemBuilder: (BuildContext context, int index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(images[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: symmetric(
              context,
              horizontal: 21,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CustomText(
                  text: "Welcome to HiveTask",
                  size: 24,
                  weight: FontWeight.w600,
                ),
                CustomText(
                  text: "Beekeeping made simple",
                  size: 16,
                ),
                SizedBox(
                  height: h(context, 28),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    images.length,
                    (index) => _buildDot(index),
                  ),
                ),
                SizedBox(
                  height: h(context, 23),
                ),
                CustomButton(
                  buttonText: "Get Started",
                  onTap: _nextPage,
                ),
                SizedBox(
                  height: h(context, 49),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      margin: EdgeInsets.only(right: 5),
      height: h(context, 10),
      width: _currentPage == index ? 20 : 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: _currentPage == index ? Color(0xff8FBC8F) : Color(0xff9D9D9D),
      ),
    );
  }
}
