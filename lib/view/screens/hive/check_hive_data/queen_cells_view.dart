import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:voice_message_package/voice_message_package.dart';

class CheckQueenCells extends StatelessWidget {
  const CheckQueenCells({super.key});

  @override
  Widget build(BuildContext context) {
    HiveDataController controller = Get.find();
    return Padding(
        padding: symmetric(context, vertical: 20),
        child: Obx(() => controller.hiveQueenCellModels.isEmpty
            ? Container()
            : SizedBox(
                height: double.maxFinite,
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.hiveQueenCellModels.length,
                  itemBuilder: (context, index) {
                    return QueenCellsWidget(
                      actionstaken: controller
                          .hiveQueenCellModels[index].action,
                        advice: controller.hiveQueenCellModels[index].featureTask,
                        actionsVoice: false,
                        adviceVoice: false,
                        queenCellsSpotted: controller
                            .hiveQueenCellModels[index].queenCellSpotted,
                        superSeduredCells: controller
                            .hiveQueenCellModels[index].supersedureCell);
                  },
                ),
              )));
  }
}

class QueenCellsWidget extends StatelessWidget {
  final bool adviceVoice;
  final bool actionsVoice;
  final bool queenCellsSpotted;
  final bool superSeduredCells;
  final String? actionstaken, advice;

  const QueenCellsWidget(
      {super.key,
      required this.actionsVoice,
      required this.adviceVoice,
      required this.queenCellsSpotted,
      required this.superSeduredCells,
      this.actionstaken,
      this.advice});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: 'Thursday',
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
                          text: 'Queen Cells Spotted',
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
                      text: queenCellsSpotted ? 'Yes' : 'No',
                      size: 14,
                      weight: FontWeight.w600,
                      color: kFullBlackBgColor,
                    ),
                    SizedBox(
                      height: h(context, 8),
                    ),
                    CustomText(
                      text: 'Supersedure Cells',
                      size: 10,
                      weight: FontWeight.w400,
                      color: kFullBlackBgColor,
                    ),
                    SizedBox(
                      height: h(context, 6),
                    ),
                    CustomText(
                      text: superSeduredCells ? 'Yes' : 'No',
                      size: 14,
                      weight: FontWeight.w600,
                      color: kFullBlackBgColor,
                    ),
                    SizedBox(
                      height: h(context, 8),
                    ),
                    CustomText(
                      text: 'Actions Takes',
                      size: 10,
                      weight: FontWeight.w400,
                      color: kFullBlackBgColor,
                    ),
                    SizedBox(
                      height: h(context, 6),
                    ),
                    actionsVoice
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
                            text: actionstaken ?? '',
                            size: 12,
                            weight: FontWeight.w400,
                            color: kFullBlackBgColor,
                          ),
                    SizedBox(
                      height: h(context, 8),
                    ),
                    CustomText(
                      text: 'Advice',
                      size: 10,
                      weight: FontWeight.w400,
                      color: kFullBlackBgColor,
                    ),
                    SizedBox(
                      height: h(context, 6),
                    ),
                    adviceVoice
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
                            text: advice ?? '',
                            size: 12,
                            weight: FontWeight.w400,
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
