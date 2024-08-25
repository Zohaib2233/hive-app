import 'dart:io';

import 'package:beekeep/controllers/apiaryController/add_apiary_controller.dart';
import 'package:beekeep/controllers/apiaryController/apiary_assign_controller.dart';
import 'package:beekeep/core/bindings/bindings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import '../bottombar/bottombar.dart';
import 'apiary_select_assigne_view.dart';

class AddApiaryPartTwo extends StatefulWidget {
  const AddApiaryPartTwo({super.key});

  @override
  State<AddApiaryPartTwo> createState() => _AddApiaryPartTwoState();
}

class _AddApiaryPartTwoState extends State<AddApiaryPartTwo> {

  var addApiaryController = Get.find<AddApiaryController>();

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
          text: 'Add Apiary',
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),
      body: Padding(
        padding: symmetric(context, horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Owner Details',
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: 'Name',
              size: 14,
              weight: FontWeight.w400,
              color: kFullBlackBgColor,
            ),
            SizedBox(
              height: h(context, 6),
            ),
            CustomTextField2(hintText: 'Enter the name',
              controller: addApiaryController.ownerNameController,),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: 'Phone Number',
              size: 14,
              weight: FontWeight.w400,
              color: kFullBlackBgColor,
            ),
            SizedBox(
              height: h(context, 6),
            ),
            CustomTextField2(hintText: 'Enter the phone number',
                controller: addApiaryController.phoneNoController),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(
              text: 'Address',
              size: 14,
              weight: FontWeight.w400,
              color: kFullBlackBgColor,
            ),
            SizedBox(
              height: h(context, 6),
            ),
             CustomTextField2(
                 controller: addApiaryController.addressController,
                hintText: 'Enter village, sector, town address'),
            SizedBox(
              height: h(context, 15),
            ),
            CustomText(

              text: 'Assign People',
              size: 14,
              weight: FontWeight.w400,
              color: kFullBlackBgColor,
            ),
            SizedBox(
              height: h(context, 6),
            ),
            CustomTextField2(
                readOnly: true,
                onTap: (){
                  Get.to(() => const ApiarySelectAssignee());
                },
                hintText: 'Assign People'),
            SizedBox(
              height: h(context, 15),
            ),
            Container(
              height: h(context, 162),
              width: Get.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8), color: Colors.white),
              child: Obx(()=>addApiaryController.imagePath.isNotEmpty?CommonImageView(
                height: h(context, 155),
                width: Get.width,
                fit: BoxFit.contain,
                file: File(addApiaryController.imagePath.value),
              ): Center(
                  child: GestureDetector(
                    onTap: (){
                      addApiaryController.selectImage();
                    },
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
                        text: 'Upload Image',
                        size: 12,
                        weight: FontWeight.w300,
                        color: kFullBlackBgColor,
                      ),
                    ]),
                  ),
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              borderRadius: 8,
              buttonText: "Save",
              onTap: () async {
                await addApiaryController.addApiaryToFirebase(context: context);
                Get.delete<AddApiaryController>();
                Get.delete<ApiaryAssignController>();
                Get.offAll(() => const BottomNavBar(),binding: HomeBindings());
              },
            )
          ],
        ),
      ),
    );
  }
}
