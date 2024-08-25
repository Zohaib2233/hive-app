import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';

class CheckBroodPattern extends StatefulWidget {
  const CheckBroodPattern({super.key});

  @override
  State<CheckBroodPattern> createState() => _CheckBroodPatternState();
}

class _CheckBroodPatternState extends State<CheckBroodPattern> {
  var controller = Get.find<HiveDataController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: symmetric(context, vertical: 20),
      child: Obx(()=>controller.broodPatternModels.isEmpty?Container():Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
                List.generate(controller.broodPatternModels.length, (index) {
              return BroodPatternWidget(
                  broodPattern: controller.broodPatternModels[index].broodPattern,
                  time: controller.broodPatternModels[index].createdTime);
            })),
      ),
    );
  }
}

class BroodPatternWidget extends StatelessWidget {
  const BroodPatternWidget({
    super.key,
    required this.broodPattern,
    required this.time,
  });

  final String broodPattern;
  final DateTime time;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            text: Utils.formatDateTime(time),
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
              height: h(context, 63),
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
                            text: 'Brood pattern of the queen',
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
                        text: broodPattern,
                        size: 14,
                        weight: FontWeight.w600,
                        color: kFullBlackBgColor,
                      ),
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
