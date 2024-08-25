import 'dart:io';

import 'package:beekeep/controllers/hive_data_controller/hive_development_controller.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_styling.dart';
import '../../../widget/Custom_Textfield_widget.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/Custom_text_widget.dart';
import '../../../widget/common_image_view_widget.dart';

class Development extends StatelessWidget {
  final HiveModel hiveModel;

  const Development({super.key, required this.hiveModel});


  @override
  Widget build(BuildContext context) {
    // bool development = false;
    HiveDevelopmentController hiveDevelopmentController = Get.find();
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
              bool docAdded = await hiveDevelopmentController.saveHiveDev(
                  hiveId: hiveModel.hiveId
                  , apiaryId: hiveModel.apiaryId);
              Utils.hideProgressDialog(context: context);
              if (docAdded) {
                CustomSnackBars.instance.showSuccessSnackbar(
                    title: "Success", message: "Hive Develoment Added");
              }
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
                text: 'Do you see all the Stages of development?',
                size: 14,
                weight: FontWeight.w400,
              ),
              CustomText(
                text: 'Eggs, larvae and Capped brood',
                size: 10,
                weight: FontWeight.w400,
                color: kGreyColor,
              ),
              Obx(() =>
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Radio(
                              activeColor: kTertiaryColor,
                              value: true,
                              groupValue: hiveDevelopmentController.development
                                  .value,
                              onChanged: (value) {
                                hiveDevelopmentController.changeDevValue(value);
                                // setState(() {
                                //   development = value!;
                                // });
                              }),
                          CustomText(
                            text: 'Yes',
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      SizedBox(
                        width: w(context, 45),
                      ),
                      Row(
                        children: [
                          Radio(
                              activeColor: kTertiaryColor,
                              value: false,
                              groupValue: hiveDevelopmentController.development
                                  .value,
                              onChanged: (value) {
                                hiveDevelopmentController.changeDevValue(value);
                                // setState(() {
                                //   development = value!;
                                // });
                              }),
                          CustomText(
                            text: 'No',
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
              ),
              SizedBox(
                height: h(context, 20),
              ),
              CustomText(
                text: 'Explain',
                size: 14,
                weight: FontWeight.w400,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(hintText: 'Type here', maxLines: 6,
                controller: hiveDevelopmentController.explainController,),
              SizedBox(
                height: h(context, 20),
              ),
              CustomText(
                text: 'Upload Images',
                size: 14,
                weight: FontWeight.w400,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              Container(
                height: h(context, 162),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Obx(
                      () =>
                  hiveDevelopmentController.images.isNotEmpty
                      ?
                  ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: hiveDevelopmentController.images.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: CommonImageView(
                          height: 100,
                          width: Get.width,
                          file: File(
                              hiveDevelopmentController.images[index].path),
                        ),
                      );
                    },)
                  // ListView(
                  //   physics: BouncingScrollPhysics(),
                  //   scrollDirection: Axis.horizontal,
                  //         children: List.generate(
                  //           hiveDevelopmentController.images.length,
                  //           (index) => Padding(
                  //             padding: const EdgeInsets.only(right: 10),
                  //             child: CommonImageView(
                  //               height: 100,
                  //               width: Get.width,
                  //               file: File(hiveDevelopmentController.images[index].path),
                  //             ),
                  //           ),
                  //         ),
                  //       )
                      : GestureDetector(
                    onTap: () async {
                      print("Select Images ");

                      await hiveDevelopmentController.selectImages();
                    },
                    child: Center(
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CommonImageView(
                              imagePath: Assets.imagesCloud,
                              width: w(context, 55),
                              height: h(context, 37),
                              fit: BoxFit.contain,
                            ),
                            SizedBox(
                              height: h(context, 22),
                            ),
                            CustomText(
                              text: 'Upload images here',
                              size: 12,
                              weight: FontWeight.w300,
                              color: kFullBlackBgColor,
                            ),
                          ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
