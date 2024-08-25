import 'dart:io';

import 'package:beekeep/main.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/queen_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_storage_service.dart';
import 'package:beekeep/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_styling.dart';
import '../../../../controllers/hive_data_controller/hive_data_controller.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../../core/utils/utils.dart';
import '../../../../services/firebaseServices/firebase_crud_services.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/Custom_text_widget.dart';
import '../../../widget/common_image_view_widget.dart';

class Queen extends StatefulWidget {
  final HiveModel hiveModel;

  const Queen({super.key, required this.hiveModel});

  @override
  State<Queen> createState() => _QueenState();
}

class _QueenState extends State<Queen> {
  RxString imagePath = ''.obs;
  bool queenSpotted = false;
  bool queenmarked = false;
  String color = Colors.white.value.toRadixString(16);

  int selectedColorIndex = 0;
  final List<Color> colorOptions = [
    Colors.white,
    kTertiaryColor,
    Colors.red,
    Color(0xff0ce27d),
    Color(0xff3b91f5),
  ];
  var controller = Get.find<HiveDataController>();

  addHiveQueen() async {
    Utils.showProgressDialog(context: context);
    String downloadUrl = await FirebaseStorageService.instance
        .uploadSingleImage(
            imgFilePath: imagePath.value, storageRef: 'hiveBehaviorImages');

    HiveQueenModel hiveQueenModel = HiveQueenModel(
        hiveId: widget.hiveModel.hiveId,
        apiaryId: widget.hiveModel.apiaryId,
        imgUrl: downloadUrl.isEmpty?dummyImg:downloadUrl,
        hiveQueenId: '',
        queenSpotted: queenSpotted == true ? "Yes" : "No",
        queenMarked: queenmarked == true ? 'Yes' : 'No',
        color: '0x$color',
        createdDate: DateTime.now());
    bool isDocAdded = await FirebaseCRUDServices.instance.addHiveQueen(
        hiveId: widget.hiveModel.hiveId,
        data: hiveQueenModel.toMap());
    print("Updated");
    if (isDocAdded) {
      controller.hiveQueenModels.insert(0,hiveQueenModel);
      CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success", message: "Hive Queen Added");
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
              await addHiveQueen();
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
                text: 'Did you spot the Queen?',
                size: 14,
                weight: FontWeight.w400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                          activeColor: kTertiaryColor,
                          value: true,
                          groupValue: queenSpotted,
                          onChanged: (value) {
                            setState(() {
                              queenSpotted = value!;
                            });
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
                          groupValue: queenSpotted,
                          onChanged: (value) {
                            setState(() {
                              queenSpotted = value!;
                            });
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
              SizedBox(
                height: h(context, 8),
              ),
              CustomText(
                text: 'Is the queen marked?',
                size: 14,
                weight: FontWeight.w400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Radio(
                          activeColor: kTertiaryColor,
                          value: true,
                          groupValue: queenmarked,
                          onChanged: (value) {
                            setState(() {
                              queenmarked = value!;
                            });
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
                          groupValue: queenmarked,
                          onChanged: (value) {
                            setState(() {
                              queenmarked = value!;
                            });
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
              SizedBox(
                height: h(context, 8),
              ),
              CustomText(
                text: 'If marked, what color',
                size: 14,
                weight: FontWeight.w400,
              ),
              SizedBox(
                height: h(context, 8),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(colorOptions.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColorIndex = index;
                        color = colorOptions[selectedColorIndex]
                            .value
                            .toRadixString(16);
                        // Save the selected color to Firebase
                      });
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorOptions[index],
                      ),
                      child: selectedColorIndex == index
                          ? const Icon(
                              Icons.check,
                              color: Colors.black,
                            )
                          : null,
                    ),
                  );
                }),
              ),
              SizedBox(
                height: h(context, 12),
              ),
              Container(
                height: h(context, 162),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white),
                child: GestureDetector(
                  onTap: () {
                    ImagePickerService.instance.openProfilePickerBottomSheet(
                        context: context,
                        onCameraPick: () async {
                          imagePath.value = await FirebaseStorageService
                              .instance
                              .pickImageFromCamera();
                        },
                        onGalleryPick: () async {
                          imagePath.value = await FirebaseStorageService
                              .instance
                              .pickImageFromGallery();
                        });
                  },
                  child: Obx(
                    () => imagePath.isNotEmpty
                        ? Center(
                            child: CommonImageView(
                              height: h(context, 162),
                              width: Get.width,
                              file: File(imagePath.value),
                            ),
                          )
                        : Center(
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
