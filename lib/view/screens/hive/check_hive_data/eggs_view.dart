import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckEggs extends StatefulWidget {
  const CheckEggs({super.key});

  @override
  State<CheckEggs> createState() => _CheckEggsState();
}

class _CheckEggsState extends State<CheckEggs> {
  HiveDataController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: symmetric(context, vertical: 20),
      child: Obx(() => controller.hiveEggModels.isNotEmpty
          ? SizedBox(
        height: Get.height - 560,
            child: ListView.builder(
              shrinkWrap: true,

                        itemCount: controller.hiveEggModels.length,
                    itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15,),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: CustomText(
                                  text: Utils.formatDateTime(controller.hiveEggModels[index].createdDate),
                                  size: 10,
                                  weight: FontWeight.w400,
                                  color: kFullBlackBgColor,
                                ),
                      ),
                      EggsWidget(eggsSpotted: controller.hiveEggModels[index].eggSpotted),
                    ],
                  ),
                );

                    },
                  ),
          )
          : Container()),

      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     Row(
      //       children: [
      //         CustomText(
      //           text: 'Thursday',
      //           size: 10,
      //           weight: FontWeight.w400,
      //           color: kFullBlackBgColor,
      //         ),
      //         Spacer(),
      //         CommonImageView(
      //           imagePath: Assets.imagesSort,
      //           width: w(context, 24),
      //           height: h(context, 24),
      //           fit: BoxFit.contain,
      //         )
      //       ],
      //     ),
      //     SizedBox(
      //       height: h(context, 10),
      //     ),
      //     EggsWidget(eggsSpotted: true),
      //     SizedBox(
      //       height: h(context, 15),
      //     ),
      //     CustomText(
      //       text: 'Thursday',
      //       size: 10,
      //       weight: FontWeight.w400,
      //       color: kFullBlackBgColor,
      //     ),
      //     SizedBox(
      //       height: h(context, 10),
      //     ),
      //     EggsWidget(eggsSpotted: false)
      //   ],
      // ),
    );
  }
}

class EggsWidget extends StatelessWidget {
  const EggsWidget({
    super.key,
    required this.eggsSpotted,
  });

  final bool eggsSpotted;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(h(context, 7))),
        height: h(context, 63),
        width: double.maxFinite,
        child: Padding(
          padding: symmetric(context, vertical: 10, horizontal: 10),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  text: 'Eggs Spotted',
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
              text: eggsSpotted ? 'Yes' : 'No',
              size: 14,
              weight: FontWeight.w600,
              color: kFullBlackBgColor,
            ),
          ]),
        ),
      ),
    );
  }
}
