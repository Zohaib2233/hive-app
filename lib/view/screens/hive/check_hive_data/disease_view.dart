import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/utils/utils.dart';

class CheckDisease extends StatefulWidget {
  const CheckDisease({super.key});

  @override
  State<CheckDisease> createState() => _CheckDiseaseState();
}

class _CheckDiseaseState extends State<CheckDisease> {
  @override
  Widget build(BuildContext context) {
    HiveDataController controller = Get.find();
    return Padding(
        padding: symmetric(context, vertical: 20),
        child: SizedBox(
          height: double.maxFinite,
          child: Obx(()=>ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.hiveDiseaseModels.length,
              itemBuilder: (context, index) =>
                  DiseaseWidget(
                      diseaseSpotted: controller.hiveDiseaseModels[index]
                          .diseaseFound,
                      diseaseType: controller.hiveDiseaseModels[index]
                          .diseaseFound ? controller.hiveDiseaseModels[index]
                          .diseaseName:'',
                      dateTime: controller.hiveDiseaseModels[index].createdDate),
            ),
          ),
        ));
  }
}

class DiseaseWidget extends StatelessWidget {
  final DateTime dateTime;

  const DiseaseWidget({super.key,
    required this.diseaseSpotted,
    required this.diseaseType,
    required this.dateTime});

  final String diseaseType;
  final bool diseaseSpotted;

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
                            text: 'Disease Spotted',
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
                        text: diseaseSpotted ? 'Yes' : 'No',
                        size: 14,
                        weight: FontWeight.w600,
                        color: kFullBlackBgColor,
                      ),
                      SizedBox(
                        height: h(context, 8),
                      ),
                      CustomText(
                        text: 'Disease Type',
                        size: 10,
                        weight: FontWeight.w400,
                        color: kFullBlackBgColor,
                      ),
                      SizedBox(
                        height: h(context, 6),
                      ),
                      CustomText(
                        text: diseaseType,
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
