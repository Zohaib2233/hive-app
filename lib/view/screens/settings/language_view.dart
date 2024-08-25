import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class LanguagesView extends StatefulWidget {
  const LanguagesView({super.key});

  @override
  State<LanguagesView> createState() => _LanguagesViewState();
}

class _LanguagesViewState extends State<LanguagesView> {
  final List<String> suggestedlanguages = ['English', 'Italian', 'French'];
  final List<String> otherlanguages = [
    'Mandarian',
    'Russian',
    'Korean',
    'Maxican',
    'Spanish',
    'Indonesian',
    'Arabic',
    'Hindi',
    'Bengali'
  ];

  String languageController = 'English';

  void updateLanguage(String value) {
    setState(() {
      languageController = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          text: 'Language',
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),
      body: Padding(
        padding: symmetric(context, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: symmetric(context, horizontal: 20),
                child: SizedBox(
                  height: h(context, 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: 'Suggested',
                      size: 12,
                      weight: FontWeight.w400,
                      color: kGreyColor,
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: suggestedlanguages.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final lan = suggestedlanguages[index];
                  return Column(
                    children: [
                      buildLanguageTile(
                          controller: languageController,
                          title: lan,
                          onTap: updateLanguage),
                      const Divider(
                        color: Color(0xff4285F4),
                        thickness: 1,
                      ),
                    ],
                  );
                },
              ),
              Padding(
                padding: symmetric(context, horizontal: 20),
                child: SizedBox(
                  height: h(context, 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      text: 'Other',
                      size: 12,
                      weight: FontWeight.w400,
                      color: kGreyColor,
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: otherlanguages.length,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  final lan = otherlanguages[index];
                  return Column(
                    children: [
                      buildLanguageTile(
                          controller: languageController,
                          title: lan,
                          onTap: updateLanguage),
                      const Divider(
                        color: Color(0xff4285F4),
                        thickness: 1,
                      ),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLanguageTile(
      {required String controller,
      required String title,
      required void Function(String value) onTap}) {
    return ListTile(
      onTap: () {
        onTap(title);
      },
      dense: true,
      title: CustomText(
        text: title,
        size: 14,
        weight: FontWeight.w400,
        color: kFullBlackBgColor,
      ),
      trailing: Container(
        width: w(context, 25),
        height: h(context, 25),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: controller == title ? kTertiaryColor : const Color(0xffd5d5d5),
        ),
      ),
    );
  }
}
