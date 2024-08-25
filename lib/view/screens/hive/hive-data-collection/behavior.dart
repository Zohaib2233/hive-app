import 'dart:io';

import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/behaviour_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/services/firebaseServices/firebase_storage_service.dart';
import 'package:beekeep/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_styling.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/Custom_text_widget.dart';
import '../../../widget/common_image_view_widget.dart';

class Behavior extends StatefulWidget {
  final HiveModel hiveModel;

  const Behavior({super.key, required this.hiveModel});

  @override
  State<Behavior> createState() => _BehaviorState();
}

class _BehaviorState extends State<Behavior> {
  RxString imagePath = ''.obs;
  double behaviorValue = 0;
  String behavior = 'Calm';
  var controller = Get.find<HiveDataController>();


  addHiveBehavior() async {
    Utils.showProgressDialog(context: context);
    String downloadUrl = await FirebaseStorageService.instance
        .uploadSingleImage(
            imgFilePath: imagePath.value, storageRef: 'hiveBehaviorImages');

    HiveBehaviorModel hiveBehaviorModel = HiveBehaviorModel(
        hiveBehaviorId: '',
        hiveId: widget.hiveModel.hiveId,
        apiaryId: widget.hiveModel.apiaryId,
        createdDate: DateTime.now(),
        behavior: behavior,
        behaviorPoints: behaviorValue.toString(),
        image: downloadUrl);
    bool isDocAdded = await FirebaseCRUDServices.instance.addHiveBehavior(
        hiveId: widget.hiveModel.hiveId,
        data: hiveBehaviorModel.toMap());

    if (isDocAdded) {
      controller.hiveBehaviorModels.add(hiveBehaviorModel);
      CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success", message: "Hive Behavior Added");
      Utils.hideProgressDialog(context: context);
    }


  }

  @override
  Widget build(BuildContext context) {
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
          text: widget.hiveModel.hiveName,
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
              await addHiveBehavior();
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
                text: 'Select the option that defines the behavior of bees',
                size: 14,
                weight: FontWeight.w400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Radio(
                          activeColor: kTertiaryColor,
                          value: 'Calm',
                          groupValue: behavior,
                          onChanged: (value) {
                            setState(() {
                              behavior = value!;
                            });
                          }),
                      CustomText(
                        text: 'Calm',
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          activeColor: kTertiaryColor,
                          value: 'Restless',
                          groupValue: behavior,
                          onChanged: (value) {
                            setState(() {
                              behavior = value!;
                            });
                          }),
                      CustomText(
                        text: 'Restless',
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          activeColor: kTertiaryColor,
                          value: 'Aggressive',
                          groupValue: behavior,
                          onChanged: (value) {
                            setState(() {
                              behavior = value!;
                            });
                          }),
                      CustomText(
                        text: 'Aggressive',
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
              CustomText(
                text:
                    'Move the slider from 1-10 representing behavior of bees from negative to positive',
                size: 14,
                weight: FontWeight.w400,
              ),
              SizedBox(
                height: h(context, 8),
              ),
              Stack(
                children: [
                  Positioned(
                    right: 0,
                    child: CustomText(
                      text: 'Aggressive',
                      size: 10,
                      weight: FontWeight.w400,
                    ),
                  ),
                  Positioned(
                    left: 0,
                    child: CustomText(
                      text: 'Calm',
                      size: 10,
                      weight: FontWeight.w400,
                    ),
                  ),
                  Padding(
                    padding: only(context, top: 6),
                    child: Slider(
                      thumbColor: kTertiaryColor,
                      secondaryActiveColor: kTertiaryColor,
                      activeColor: kTertiaryColor,
                      value: behaviorValue,
                      max: 10,
                      divisions: 10,
                      label: behaviorValue.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          behaviorValue = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: h(context, 8),
              ),
              Container(
                height: h(context, 162),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: Obx(
                  () => imagePath.value.isNotEmpty
                      ? Center(
                          child: CommonImageView(
                            height: h(context, 162),
                            width: Get.width,
                            file: File(imagePath.value),
                          ),
                        ) /**/
                      : Center(
                          child: GestureDetector(
                            onTap: () {
                              ImagePickerService.instance
                                  .openProfilePickerBottomSheet(
                                      context: context,
                                      onCameraPick: () async {
                                        imagePath.value =
                                            await FirebaseStorageService
                                                .instance
                                                .pickImageFromCamera();
                                      },
                                      onGalleryPick: () async {
                                        imagePath.value =
                                            await FirebaseStorageService
                                                .instance
                                                .pickImageFromGallery();
                                      });
                            },
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
