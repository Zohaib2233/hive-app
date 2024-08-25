import 'package:beekeep/controllers/apiaryController/add_apiary_controller.dart';
import 'package:beekeep/view/screens/locations/pick_location.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../../controllers/apiaryController/apiary_assign_controller.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import 'add_apiary_two_view.dart';

class AddApiaryPartOne extends StatefulWidget {
  const AddApiaryPartOne({super.key});

  @override
  State<AddApiaryPartOne> createState() => _AddApiaryPartOneState();
}

class _AddApiaryPartOneState extends State<AddApiaryPartOne> {
  var addApiaryController = Get.find<AddApiaryController>();





  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value){
        print("Back value = $value");
        if(value == true){
          Get.delete<AddApiaryController>();
          Get.delete<ApiaryAssignController>();
        }

      },
      child: Scaffold(
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
                text: 'Name',
                size: 14,
                weight: FontWeight.w400,
                color: kFullBlackBgColor,
              ),
              SizedBox(
                height: h(context, 6),
              ),
             CustomTextField2(hintText: 'Enter the name',
             controller: addApiaryController.apiaryNameController,),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Location',
                size: 14,
                weight: FontWeight.w400,
                color: kFullBlackBgColor,
              ),
              SizedBox(
                height: h(context, 6),
              ),
            CustomTextField2(
              onTap: (){
                Get.to(()=>PickLocation());
              },
                readOnly: true,
              controller: addApiaryController.locationController,
                  hintText: 'Enter village, sector, town address'),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Hives',
                size: 14,
                weight: FontWeight.w400,
                color: kFullBlackBgColor,
              ),
              SizedBox(
                height: h(context, 6),
              ),
             CustomTextField2(hintText: 'Enter the number of hives',
             keyboardType: TextInputType.number,
             controller: addApiaryController.hivesController,),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Sun Exposure',
                size: 14,
                weight: FontWeight.w400,
                color: kFullBlackBgColor,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              Obx(()=>_buildThreeOptionsContainer(
                    optionOneTitle: 'Shaded',
                    optionOneImg: Assets.imagesShadyBlack,
                    optionOneImgSelected: Assets.imagesShadyYellow,
                    optionTwoTitle: 'Partial',
                    optionTwoImg: Assets.imagesPartialBlack,
                    optionTwoImgSelected: Assets.imagesPartialYellow,
                    optionThreeTitle: 'Sunny',
                    optionThreeImg: Assets.imagesSunnyBlack,
                    optionThreeImgSelected: Assets.imagesSunnyYellow,
                    controller: addApiaryController.sunExposer.value,
                    onTap: addApiaryController.updateSunExposure,
                    optiononeimgHeight: 23,
                    optiononeimgWidth: 17,
                    optionTwoimgHeight: 23,
                    optionTwoimgWidth: 20,
                    optionThreeimgHeight: 23,
                    optionThreeimgWidth: 20),
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Location Types',
                size: 14,
                weight: FontWeight.w400,
                color: kFullBlackBgColor,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              Obx(()=>_buildThreeOptionsContainer(
                    optionOneTitle: 'Rural',
                    optionOneImg: Assets.imagesRuralBlack,
                    optionOneImgSelected: Assets.imagesRuralYellow,
                    optionTwoTitle: 'Mixed',
                    optionTwoImg: Assets.imagesMixedBlack,
                    optionTwoImgSelected: Assets.imagesMixedYellow,
                    optionThreeTitle: 'Urban',
                    optionThreeImg: Assets.imagesUrbanBlack,
                    optionThreeImgSelected: Assets.imagesUrbanYellow,
                    controller: addApiaryController.locationType.value,
                    onTap: addApiaryController.updateLocationTypes,
                    optiononeimgHeight: 22,
                    optiononeimgWidth: 22,
                    optionTwoimgHeight: 22,
                    optionTwoimgWidth: 22,
                    optionThreeimgHeight: 22,
                    optionThreeimgWidth: 22),
              ),
              const Spacer(),
              CustomButton(
                borderRadius: 8,
                buttonText: "Next",
                onTap: () {
                  Get.to(() => const AddApiaryPartTwo());
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThreeOptionsContainer({
    required String optionOneTitle,
    required String optionOneImg,
    required String optionOneImgSelected,
    required String optionTwoTitle,
    required String optionTwoImg,
    required String optionTwoImgSelected,
    required String optionThreeTitle,
    required String optionThreeImg,
    required String optionThreeImgSelected,
    required String controller,
    required void Function(String value) onTap,
    required double optiononeimgHeight,
    required double optiononeimgWidth,
    required double optionTwoimgHeight,
    required double optionTwoimgWidth,
    required double optionThreeimgHeight,
    required double optionThreeimgWidth,
  }) {
    return Container(
      height: h(context, 71),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Padding(
        padding: symmetric(context, horizontal: 20),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: () {
                  onTap(optionOneTitle);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonImageView(
                      height: h(context, optiononeimgHeight),
                      width: w(context, optiononeimgWidth),
                      fit: BoxFit.contain,
                      imagePath: controller == optionOneTitle
                          ? optionOneImgSelected
                          : optionOneImg,
                    ),
                    SizedBox(
                      height: h(context, 13),
                    ),
                    CustomText(
                      text: optionOneTitle,
                      size: 12,
                      weight: FontWeight.w600,
                      color: controller == optionOneTitle
                          ? kTertiaryColor
                          : kBlackBgColor,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  onTap(optionTwoTitle);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonImageView(
                      height: h(context, optionTwoimgHeight),
                      width: w(context, optionTwoimgWidth),
                      fit: BoxFit.contain,
                      imagePath: controller == optionTwoTitle
                          ? optionTwoImgSelected
                          : optionTwoImg,
                    ),
                    SizedBox(
                      height: h(context, 13),
                    ),
                    CustomText(
                      text: optionTwoTitle,
                      size: 12,
                      weight: FontWeight.w600,
                      color: controller == optionTwoTitle
                          ? kTertiaryColor
                          : kBlackBgColor,
                    )
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  onTap(optionThreeTitle);
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CommonImageView(
                      height: h(context, optionThreeimgHeight),
                      width: w(context, optionThreeimgWidth),
                      fit: BoxFit.contain,
                      imagePath: controller == optionThreeTitle
                          ? optionThreeImgSelected
                          : optionThreeImg,
                    ),
                    SizedBox(
                      height: h(context, 13),
                    ),
                    CustomText(
                      text: optionThreeTitle,
                      size: 12,
                      weight: FontWeight.w600,
                      color: controller == optionThreeTitle
                          ? kTertiaryColor
                          : kBlackBgColor,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
