import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_message_package/voice_message_package.dart';

class CheckHoneyExtraction extends StatelessWidget {
  const CheckHoneyExtraction({super.key});

  @override
  Widget build(BuildContext context) {
    HiveDataController controller = Get.find();
    return Padding(
      padding: symmetric(context, vertical: 20),
      child: SizedBox(
        height: double.maxFinite,
        child: Obx(()=>ListView.builder(
          physics: NeverScrollableScrollPhysics(),
            itemCount: controller.hiveHoneyModels.length,
            itemBuilder: (context, index) => HoneyExtractionWidget(
              honeyExtracted: controller.hiveHoneyModels[index].honeyExtracted,
                honeySupersExtracted:
                    controller.hiveHoneyModels[index].honeyQuantity,
                isVoice: false,
                dateTime: controller.hiveHoneyModels[index].createdDate),
          ),
        ),
      ),
    );
  }
}

class HoneyExtractionWidget extends StatelessWidget {
  final String honeySupersExtracted;
  final bool isVoice;
  final String? honeyExtracted;
  final DateTime dateTime;

  const HoneyExtractionWidget(
      {super.key,
      required this.honeySupersExtracted,
      required this.isVoice,
      this.honeyExtracted,
      required this.dateTime});

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
        SizedBox(
          height: h(context, 10),
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
                          text: 'Honey Super Quantity',
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
                      text: honeySupersExtracted.toString(),
                      size: 14,
                      weight: FontWeight.w600,
                      color: kFullBlackBgColor,
                    ),
                    SizedBox(
                      height: h(context, 8),
                    ),
                    CustomText(
                      text: 'Honey Extracted',
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
                            text: honeyExtracted ?? '',
                            size: 14,
                            weight: FontWeight.w600,
                            color: kFullBlackBgColor,
                          ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
