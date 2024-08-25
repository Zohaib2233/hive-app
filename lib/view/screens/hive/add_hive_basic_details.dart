import 'dart:io';

import 'package:beekeep/controllers/apiaryController/add_hive_controller.dart';
import 'package:beekeep/models/apiary_model.dart';
import 'package:beekeep/view/screens/apiary/apiary_details.dart';
import 'package:beekeep/view/widget/Custom_drop_down_widget.dart';
import 'package:beekeep/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../../core/utils/snackbar.dart';
import '../../../services/image_picker_service.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import '../../widget/custom_scroll_view_effect_widget.dart';

class AddHiveBasicDetailsView extends StatelessWidget {
  final ApiaryModel apiaryModel;

  const AddHiveBasicDetailsView({super.key, required this.apiaryModel});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<AddHiveController>();
    controller.locationController.text = apiaryModel.location;
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
          text: 'Add Hive',
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),
      body: Padding(
        padding: symmetric(context, vertical: 20, horizontal: 20),
        child: SpaceBetweenScrollView(
          footer: Padding(
            padding: all(context, 20),
            child: Column(
              children: [
                CustomButton(
                  borderRadius: 8,
                  buttonText: "Add Hive",
                  onTap: () async {
                    bool isDocCreated = await controller.addHiveToFireStore(
                        apiaryModel: apiaryModel, context: context);
                    if (isDocCreated) {
                      CustomSnackBars.instance.showSuccessSnackbar(
                          title: "Success", message: "Hive Added Successfully");
                      Get.off(
                          () => ApiaryDetailsView(apiaryModel: apiaryModel));
                    }
                  },
                ),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  MyText(text: 'Scan Hive or enter manually',
                  weight: FontWeight.w700,),
                  CommonImageView(
                    fit: BoxFit.contain,
                    width: w(context, 100),
                    height: h(context, 60),
                    imagePath: Assets.imagesBarCode,
                  ),
                ],
              ),
              Divider(
                color: kBorderColor,
              ),
              CustomText(
                text: 'Name',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                hintText: 'Enter name',
                controller: controller.hiveNameController,
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Location',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                hintText: 'Enter location',
                controller: controller.locationController,
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Tags',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              TagsTextField(stringTagController: controller.stringTagController),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Honey Supers',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                keyboardType: TextInputType.number,
                controller: controller.honeySupersController,
                hintText: '10',
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Temperature in C',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                keyboardType: TextInputType.number,
                controller: controller.temperatureController,
                hintText: 'Enter temperature',
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Humidity',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                keyboardType: TextInputType.number,
                controller: controller.humidityController,
                hintText: 'Enter humidity',
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Condition',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              Obx(()=>CustomDropdown(
                    items: const ['Healthy', 'Unhealthy'],
                    selectedValue: controller.conditionController.value,
                    onChanged: (value) {
                      controller.conditionController.value = value;
                    },
                    hint: 'Healthy'),
              ),

              SizedBox(height: 16,),
              GestureDetector(
                onTap: (){
                  ImagePickerService.instance.openProfilePickerBottomSheet(context: context, onCameraPick: (){

                  }, onGalleryPick:() async {
                    await controller.selectImageFromGallery();
                  });
                },
                child: Container(
                  height: h(context, 162),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white),
                  child: Obx(
                        ()=>controller.imagePath.isNotEmpty?
                    CommonImageView(
                      file: File(controller.imagePath.value),
                      fit: BoxFit.cover,
                      height: double.maxFinite,
                      width: double.maxFinite,
                    ):

                    Center(
                      child: Column(mainAxisSize: MainAxisSize.min, children: [
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
                          text: 'Upload image here',
                          size: 12,
                          weight: FontWeight.w300,
                          color: kFullBlackBgColor,
                        ),
                      ]),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}
