import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/hive_diease_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_styling.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/Custom_text_widget.dart';
import '../../../widget/common_image_view_widget.dart';
import 'radio_new_option.dart';

class Disease extends StatefulWidget {
  final HiveModel hiveModel;

  const Disease({super.key, required this.hiveModel});

  @override
  State<Disease> createState() => _DiseaseState();
}

class _DiseaseState extends State<Disease> {
  bool diseaseSpotted = false;
  String disease = '';

  saveDiseases() async {
    HiveDiseaseModel model = HiveDiseaseModel(
        diseaseFound: diseaseSpotted,
        diseaseName: disease,
        diseaseId: '',
        hiveId: widget.hiveModel.hiveId,
        apiaryId: widget.hiveModel.apiaryId,
        createdDate: DateTime.now());

    bool isDocAdded = await FirebaseCRUDServices.instance.saveHiveData(
        hiveId: widget.hiveModel.hiveId,
        data: model.toMap(),
        docIdName: 'diseaseId',
        subCollectionName: FirebaseConstants.hiveDiseaseCollection);

    if (isDocAdded) {

      Get.find<HiveDataController>().hiveDiseaseModels.add(model);
      CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success", message: "Added Successfully");
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
              Utils.showProgressDialog(context: context);
              await saveDiseases();
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
                text: 'Did you see any Diseases or Pests?',
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
                          groupValue: diseaseSpotted,
                          onChanged: (value) {
                            setState(() {
                              diseaseSpotted = value!;
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
                          groupValue: diseaseSpotted,
                          onChanged: (value) {
                            setState(() {
                              diseaseSpotted = value!;
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
                height: h(context, 20),
              ),
              if (diseaseSpotted)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: 'Select the pest or disease',
                      size: 14,
                      weight: FontWeight.w400,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Radio(
                                activeColor: kTertiaryColor,
                                value: 'Chalkbrood',
                                groupValue: disease,
                                onChanged: (value) {
                                  setState(() {
                                    disease = value!;
                                  });
                                }),
                            CustomText(
                              text: 'Chalkbrood',
                              size: 14,
                              weight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                activeColor: kTertiaryColor,
                                value: 'EFB',
                                groupValue: disease,
                                onChanged: (value) {
                                  setState(() {
                                    disease = value!;
                                  });
                                }),
                            CustomText(
                              text: 'EFB',
                              size: 14,
                              weight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                activeColor: kTertiaryColor,
                                value: 'AFB',
                                groupValue: disease,
                                onChanged: (value) {
                                  setState(() {
                                    disease = value!;
                                  });
                                }),
                            CustomText(
                              text: 'AFB',
                              size: 14,
                              weight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                activeColor: kTertiaryColor,
                                value: 'Varroa Mites',
                                groupValue: disease,
                                onChanged: (value) {
                                  setState(() {
                                    disease = value!;
                                  });
                                }),
                            CustomText(
                              text: 'Varroa Mites',
                              size: 14,
                              weight: FontWeight.w400,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                activeColor: kTertiaryColor,
                                value: 'Small Hive Beatles',
                                groupValue: disease,
                                onChanged: (value) {
                                  setState(() {
                                    disease = value!;
                                  });
                                }),
                            CustomText(
                              text: 'Small Hive Beatles',
                              size: 14,
                              weight: FontWeight.w400,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h(context, 20),
                    ),
                    TextButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const RadioButtonNewOption();
                          },
                        );
                      },
                      child: CustomText(
                        text: 'Create an option',
                        size: 14,
                        weight: FontWeight.w400,
                        color: kTertiaryColor,
                      ),
                    )
                  ],
                )
            ],
          ),
        ],
      ),
    );
  }
}
