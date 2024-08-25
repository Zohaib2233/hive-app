import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/hive_egg_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_images.dart';
import '../../../../constants/app_styling.dart';
import '../../../../core/utils/snackbar.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/Custom_text_widget.dart';
import '../../../widget/common_image_view_widget.dart';

class Eggs extends StatefulWidget {
  final HiveModel hiveModel;

  const Eggs({super.key, required this.hiveModel});

  @override
  State<Eggs> createState() => _EggsState();
}

class _EggsState extends State<Eggs> {
  bool eggsSpotted = false;
  HiveDataController controller = Get.find();

  saveHiveEgg() async {
    Utils.showProgressDialog(context: context);
    HiveEggModel hiveEggModel = HiveEggModel(
        hiveEggId: '',
        hiveId: widget.hiveModel.hiveId,
        apiaryId: widget.hiveModel.apiaryId,
        eggSpotted: eggsSpotted,
        createdDate: DateTime.now());

    bool isDocAdded = await FirebaseCRUDServices.instance.addHiveEgg(
        hiveId: widget.hiveModel.hiveId, data: hiveEggModel.toMap());

    if (isDocAdded) {
      controller.hiveEggModels.add(hiveEggModel);
      CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success", message: "Eggs Added");
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
          text: widget.hiveModel.apiaryName,
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
              await saveHiveEgg();
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
                text: 'Did you spot the Eggs?',
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
                          groupValue: eggsSpotted,
                          onChanged: (value) {
                            setState(() {
                              eggsSpotted = value!;
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
                          groupValue: eggsSpotted,
                          onChanged: (value) {
                            setState(() {
                              eggsSpotted = value!;
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
            ],
          ),
        ],
      ),
    );
  }
}
