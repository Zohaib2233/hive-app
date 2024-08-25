import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_images.dart';
import '../../../../core/utils/utils.dart';
import '../../../widget/common_image_view_widget.dart';

class CheckHoneyFlowPreps extends StatelessWidget {
  const CheckHoneyFlowPreps({super.key});

  @override
  Widget build(BuildContext context) {
    HiveDataController controller = Get.find();
    return Padding(
        padding: symmetric(context, vertical: 20),
        child: SizedBox(
          height: double.maxFinite,
          child: Obx(()=>ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
              itemCount: controller.hivePrepModels.length,
              itemBuilder: (context, index) {
              return HoneyFlowPrepsWidget(
                supersDepth: controller.hivePrepModels[index].honeySuperType,
                  splitActionsTaken: controller.hivePrepModels[index].preps,
                  addedHoneySupers: controller.hivePrepModels[index].addHoneySuper,
                  hiveSplit: controller.hivePrepModels[index].splitHive,
                  dateTime: controller.hivePrepModels[index].createdDate);
            },),
          ),
        )
    );
  }
}

class HoneyFlowPrepsWidget extends StatelessWidget {
  const HoneyFlowPrepsWidget({super.key,
    required this.splitActionsTaken,
    required this.addedHoneySupers,
    required this.supersDepth,
    required this.hiveSplit, required this.dateTime});

  final List<String> splitActionsTaken;
  final bool addedHoneySupers;
  final String supersDepth;
  final bool hiveSplit;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
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
                child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomText(
                        text: 'Honey Flow Preps',
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
                    height: h(context, 8),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: w(context, 4),
                      ),
                      Container(
                        width: w(context, 4),
                        height: h(context, 4),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: kFullBlackBgColor),
                      ),
                      SizedBox(
                        width: w(context, 10),
                      ),
                      CustomText(
                        text: addedHoneySupers
                            ? 'Honey Supers Added'
                            : 'Honey Supers Not Added',
                        size: 14,
                        weight: FontWeight.w600,
                        color: kFullBlackBgColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h(context, 8),
                  ),
                  CustomText(
                    text: supersDepth ?? '',
                    size: 14,
                    weight: FontWeight.w400,
                    color: kGreyColor,
                  ),
                  SizedBox(
                    height: h(context, 8),
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: w(context, 4),
                      ),
                      Container(
                        width: w(context, 4),
                        height: h(context, 4),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: kFullBlackBgColor),
                      ),
                      SizedBox(
                        width: w(context, 10),
                      ),
                      CustomText(
                        text: hiveSplit ? 'Hive Split' : 'Hive not split',
                        size: 14,
                        weight: FontWeight.w600,
                        color: kFullBlackBgColor,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h(context, 8),
                  ),
                  CommonImageView(
                    fit: BoxFit.contain,
                    width: w(context, 100),
                    height: h(context, 60),
                    imagePath: Assets.imagesBarCode,
                  ),
                  SizedBox(
                    height: h(context, 8),
                  ),
                  Column(
                    children: splitActionsTaken.map((item) {
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
