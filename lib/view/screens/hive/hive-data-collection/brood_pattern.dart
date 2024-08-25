import 'package:beekeep/models/hiveModels/hive_data_models/brood_pattern_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
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

class BroodPattern extends StatefulWidget {
  final HiveModel hiveModel;

  const BroodPattern({super.key, required this.hiveModel});

  @override
  State<BroodPattern> createState() => _BroodPatternState();
}

class _BroodPatternState extends State<BroodPattern> {
  String broodPattern = 'Solid brood pattern (Beautiful)';

  var controller = Get.find<HiveDataController>();

  addHiveBroodPattern() async {
    Utils.showProgressDialog(context: context);

    BroodPatternModel broodPatternModel = BroodPatternModel(
        broodPattern: broodPattern,
        createdTime: DateTime.now(),
        broodPatternId: '',
        hiveId: widget.hiveModel.hiveId,
        apiaryId: widget.hiveModel.apiaryId);

    bool isDocAdded = await FirebaseCRUDServices.instance.addHiveBroodPattern(

        hiveId: widget.hiveModel.hiveId, data: broodPatternModel.toMap());

    if (isDocAdded) {
      controller.broodPatternModels.add(broodPatternModel);
      CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success", message: "Brood Pattern Added");
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
              await addHiveBroodPattern();
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
                text: 'Select the options for Brood pattern of the Queen',
                size: 14,
                weight: FontWeight.w400,
              ),
              Column(
                children: [
                  Row(
                    children: [
                      Radio(
                          activeColor: kTertiaryColor,
                          value: 'Solid brood pattern (Beautiful)',
                          groupValue: broodPattern,
                          onChanged: (value) {
                            setState(() {
                              broodPattern = value!;
                            });
                          }),
                      CustomText(
                        text: 'Solid brood pattern (Beautiful)',
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          activeColor: kTertiaryColor,
                          value: 'Some open cells (Spotty)',
                          groupValue: broodPattern,
                          onChanged: (value) {
                            setState(() {
                              broodPattern = value!;
                            });
                          }),
                      CustomText(
                        text: 'Some open cells (Spotty)',
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          activeColor: kTertiaryColor,
                          value: 'Lots of open cells (Very Spotty)',
                          groupValue: broodPattern,
                          onChanged: (value) {
                            setState(() {
                              broodPattern = value!;
                            });
                          }),
                      CustomText(
                        text: 'Lots of open cells (Very Spotty)',
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
        ],
      ),
    );
  }
}
