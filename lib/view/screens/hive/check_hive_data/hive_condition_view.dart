import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';

class CheckHiveCondition extends StatelessWidget {
  const CheckHiveCondition({super.key});

  @override
  Widget build(BuildContext context) {
    HiveDataController controller = Get.find();
    return Padding(
        padding: symmetric(context, vertical: 20),
        child: Obx(
          () => controller.isConditionsLoading.value
              ? const Center(child: CircularProgressIndicator())
              : SizedBox(
            height: double.maxFinite,
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.hiveConditionModels.length,
                    itemBuilder: (context, index) => HiveConditionWidget(
                        hiveCondition:
                            controller.hiveConditionModels[index].conditions,
                        dateTime:
                            controller.hiveConditionModels[index].createdDate),
                  ),
              ),
        ));
  }
}

class HiveConditionWidget extends StatelessWidget {
  final DateTime dateTime;

  const HiveConditionWidget(
      {super.key, required this.hiveCondition, required this.dateTime});

  final List<String> hiveCondition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Column(
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
                            text: 'Hive Condition',
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
                      Column(
                        children: hiveCondition.map((item) {
                          return Column(
                            children: [
                              Row(
                                children: [
                                  SizedBox(
                                    width: w(context, 4),
                                  ),
                                  Container(
                                    width: w(context, 4),
                                    height: h(context, 4),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: kFullBlackBgColor),
                                  ),
                                  SizedBox(
                                    width: w(context, 10),
                                  ),
                                  CustomText(
                                    text: item,
                                    size: 14,
                                    weight: FontWeight.w600,
                                    color: kFullBlackBgColor,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: h(context, 8),
                              ),
                            ],
                          );
                        }).toList(),
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
