import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/view/screens/hive/check_hive_data/custom_small_images_widget.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_message_package/voice_message_package.dart';

class CheckDevelopment extends StatefulWidget {
  const CheckDevelopment({super.key});

  @override
  State<CheckDevelopment> createState() => _CheckDevelopmentState();
}

class _CheckDevelopmentState extends State<CheckDevelopment> {
  HiveDataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: symmetric(context, vertical: 20),
      child: Obx(()=>controller.hiveDevModels.isEmpty?Container():Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(
              controller.hiveDevModels.length,
              (index) => DevelopmentWidget(
                dateTime: controller.hiveDevModels[index].createdDate,
                  isVoice: false,
                  details: controller.hiveDevModels[index].detail,
                  developmentStages: controller.hiveDevModels[index].stagesSeen,
                  imagesList: controller.hiveDevModels[index].images),
            )),
      ),
    );
  }
}

class DevelopmentWidget extends StatelessWidget {
  final bool isVoice;
  final bool developmentStages;
  final String? details;
  final DateTime dateTime;
  final List<String> imagesList;

  const DevelopmentWidget(
      {super.key,
      required this.isVoice,
      required this.developmentStages,
      this.details,
      required this.imagesList, required this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: Utils.formatDateTime(dateTime),
          size: 10,
          weight: FontWeight.w400,
          color: kFullBlackBgColor,
        ),
        Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(h(context, 7))),
            width: double.maxFinite,
            child: Padding(
              padding: symmetric(context, vertical: 10, horizontal: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomText(
                          text: 'Development Stages',
                          size: 10,
                          weight: FontWeight.w400,
                          color: kFullBlackBgColor,
                        ),
                        Spacer(),
                        CustomText(
                          text: 'Edit',
                          size: 10,
                          weight: FontWeight.w400,
                          color: kTertiaryColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h(context, 6),
                    ),
                    CustomText(
                      text: developmentStages ? 'Yes' : 'No',
                      size: 14,
                      weight: FontWeight.w600,
                      color: kFullBlackBgColor,
                    ),
                    SizedBox(
                      height: h(context, 8),
                    ),
                    CustomText(
                      text: 'Details',
                      size: 10,
                      weight: FontWeight.w400,
                      color: kFullBlackBgColor,
                    ),
                    SizedBox(
                      height: h(context, 6),
                    ),
                    isVoice
                        ? VoiceMessageView(
                            innerPadding: 8,
                            backgroundColor: kTertiaryColor.withOpacity(0.2),
                            activeSliderColor: kTertiaryColor,
                            circlesColor: kTertiaryColor,
                            controller: VoiceController(
                              audioSrc:
                                  'https://dl.musichi.ir/1401/06/21/Ghors%202.mp3',
                              maxDuration: const Duration(seconds: 0),
                              isFile: false,
                              onComplete: () {},
                              onPause: () {},
                              onPlaying: () {},
                              onError: (err) {},
                            ),
                          )
                        : CustomText(
                            text: details ?? '',
                            size: 14,
                            weight: FontWeight.w400,
                            color: kFullBlackBgColor,
                          ),
                    SizedBox(
                      height: h(context, 8),
                    ),
                    CustomText(
                      text: 'Images',
                      size: 10,
                      weight: FontWeight.w400,
                      color: kFullBlackBgColor,
                    ),
                    SizedBox(
                      height: h(context, 10),
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                          children: List.generate(
                        imagesList.length,
                        (index) => CustomSmallImageWidget(
                          imgUrl: imagesList[index],
                        ),
                      )),
                    )
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
