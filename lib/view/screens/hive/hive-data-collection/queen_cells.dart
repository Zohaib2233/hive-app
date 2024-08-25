import 'package:beekeep/controllers/hive_data_controller/queen_cell_controller.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/view/screens/Todo/Add_todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_styling.dart';
import '../../../widget/Custom_Textfield_widget.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/Custom_text_widget.dart';
import '../../../widget/common_image_view_widget.dart';

class QueenCells extends StatelessWidget {
  final HiveModel hiveModel;

  const QueenCells({super.key, required this.hiveModel});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(QueenCellController());
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
              await controller.saveQueenCell(
                  hiveId: hiveModel.hiveId, apiaryId: hiveModel.apiaryId);
              Utils.hideProgressDialog(context: context);
              Get.close(1);
            },
          ),
        ),
      ),
      body: ListView(
        padding: symmetric(context, vertical: 20, horizontal: 20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Did you spot  Queen cells?',
                size: 14,
                weight: FontWeight.w400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => Row(
                      children: [
                        Radio(
                            activeColor: kTertiaryColor,
                            value: true,
                            groupValue: controller.queenCellsSpotted.value,
                            onChanged: (value) {
                              controller.queenCellsSpotted.value = (value!);
                            }),
                        CustomText(
                          text: 'Yes',
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: w(context, 45),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Radio(
                            activeColor: kTertiaryColor,
                            value: false,
                            groupValue: controller.queenCellsSpotted.value,
                            onChanged: (value) {
                              controller.queenCellsSpotted.value = value!;
                            }),
                        CustomText(
                          text: 'No',
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h(context, 10),
              ),
              SizedBox(
                  width: w(context, 200),
                  child: const CustomTextField2(
                    hintText: 'Enter the number',
                  )),
              SizedBox(
                height: h(context, 10),
              ),
              CustomText(
                text: 'Are they Supersedure cells?',
                size: 14,
                weight: FontWeight.w400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Obx(
                    () => Row(
                      children: [
                        Radio(
                            activeColor: kTertiaryColor,
                            value: true,
                            groupValue: controller.supersedured.value,
                            onChanged: (value) {
                              controller.supersedured.value = value!;
                            }),
                        CustomText(
                          text: 'Yes',
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: w(context, 45),
                  ),
                  Obx(
                    () => Row(
                      children: [
                        Radio(
                            activeColor: kTertiaryColor,
                            value: false,
                            groupValue: controller.supersedured.value,
                            onChanged: (value) {
                              controller.supersedured.value = value!;
                            }),
                        CustomText(
                          text: 'No',
                          size: 14,
                          weight: FontWeight.w400,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h(context, 20),
              ),
              CustomText(
                text: 'Explain what action were taken?',
                size: 14,
                weight: FontWeight.w400,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                hintText: 'Type here',
                controller: controller.actionTaken,
              ),
              SizedBox(
                height: h(context, 20),
              ),
              CustomText(
                text: 'What feature tasks and when should it be taken?',
                size: 14,
                weight: FontWeight.w400,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                hintText: 'Type here',
                controller: controller.featureTask,
              ),
              SizedBox(
                height: h(context, 20),
              ),
              GestureDetector(
                onTap: (){
                  Get.to(()=>AddToDo(hiveModel: hiveModel,));

                },
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Create Task',
                        size: 16,
                        weight: FontWeight.w400,
                        color: kTertiaryColor,
                      ),
                      SizedBox(
                        width: w(context, 12),
                      ),
                      const Icon(
                        Icons.add,
                        color: kTertiaryColor,
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
