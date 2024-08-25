import 'package:beekeep/controllers/hive_data_controller/hive_population_controller.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_styling.dart';
import '../../../../models/hiveModels/hive_model.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/Custom_text_widget.dart';
import '../../../widget/common_image_view_widget.dart';

class Population extends StatelessWidget {
  final HiveModel hiveModel;

  const Population({super.key,required this.hiveModel});

  // double populationValue = 0;
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HivePopulationController());
    return Scaffold(
      backgroundColor: kGreybackgroundColor,
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
          text: hiveModel.hiveName,
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
        actions: [
          Padding(
            padding: only(context, right: 15),
            child: CommonImageView(
              imagePath: Assets.imagesSetting3,
              height: 24,
              width: 24,
            ),
          )
        ],
      ),
      bottomSheet: Container(
        color: kGreybackgroundColor,
        child: Padding(
          padding: symmetric(
            context,
            horizontal: 20,
            vertical: 10,
          ),
          child: CustomButton3(
            buttonText: "Save",
            onTap: () async {
              Utils.showProgressDialog(context: context);
              await controller.savePopulation(hiveId:  hiveModel.hiveId, apiaryId: hiveModel.apiaryId);
              Get.close(2);
            },
          ),
        ),
      ),
      body: Padding(
        padding: symmetric(
          context,
          vertical: 20,
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(()=>Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Select the population of the bees',
                    size: 14,
                    weight: FontWeight.w400,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Radio(
                              activeColor: kTertiaryColor,
                              value: 'Low',
                              groupValue: controller.population.value,
                              onChanged: (value) {
                                controller.changePopulation(value);
                                // setState(() {
                                //   broodPattern = value!;
                                // });
                              }),
                          CustomText(
                            text: 'Low',
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              activeColor: kTertiaryColor,
                              value: 'Moderate',
                              groupValue: controller.population.value,
                              onChanged: (value) {
                                controller.changePopulation(value);
                                // setState(() {
                                //   broodPattern = value!;
                                // });
                              }),
                          CustomText(
                            text: 'Moderate',
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              activeColor: kTertiaryColor,
                              value: 'Heavy',
                              groupValue: controller.population.value,
                              onChanged: (value) {
                                controller.changePopulation(value);
                                // setState(() {
                                //   broodPattern = value!;
                                // });
                              }),
                          CustomText(
                            text: 'Heavy',
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: h(context, 8),
                  ),
                ],
              ),
            ),
            CustomText(
              text:
                  'Move the slider from 1-10 representing Population of the hive',
              size: 14,
              weight: FontWeight.w400,
            ),
            SizedBox(
              height: h(context, 20),
            ),
            Stack(
              children: [
                Positioned(
                  right: 0,
                  child: CustomText(
                    text: 'Heavy',
                    size: 10,
                    weight: FontWeight.w400,
                  ),
                ),
                Positioned(
                  left: 0,
                  child: CustomText(
                    text: 'Low',
                    size: 10,
                    weight: FontWeight.w400,
                  ),
                ),
                Obx(()=>Padding(
                    padding: only(context, top: 6),
                    child: Slider(
                      thumbColor: kTertiaryColor,
                      secondaryActiveColor: kTertiaryColor,
                      activeColor: kTertiaryColor,
                      value: controller.populationValue.value,
                      max: 10,
                      divisions: 10,
                      label: controller.populationValue.round().toString(),
                      onChanged: (double value) {
                        controller.changePopulationValue(value);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
