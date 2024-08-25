import 'dart:io';

import 'package:beekeep/controllers/profileController/edit_profile_controller.dart';
import 'package:beekeep/core/global/instance_variables.dart';
import 'package:beekeep/services/image_picker_service.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(EditProfileController());
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
          text: 'Profile',
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),
      body: Padding(
        padding: symmetric(context, vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h(context, 120),
                child: Center(
                  child: Stack(
                    children: [
                      // SizedBox(
                      //   width: w(context, 120),
                      //   height: h(context, 120),
                      //   child: const CircleAvatar(
                      //     backgroundImage: AssetImage(Assets.imagesProfile),
                      //   ),
                      // ),

                      Obx(
                        () => controller.imagePath.isEmpty
                            ? CommonImageView(
                                height: 100,
                                width: 110,
                                radius: 150,
                                url: userModelGlobal.value.profilePicture,
                              )
                            : CommonImageView(
                                height: 100,
                                width: 110,
                                radius: 150,
                                file: File(controller.imagePath.value),
                              ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: w(context, 80),
                        child: GestureDetector(
                          onTap: () {
                            ImagePickerService.instance
                                .openProfilePickerBottomSheet(
                                    context: context,
                                    onCameraPick:
                                        controller.selectImageFromCamera,
                                    onGalleryPick: controller.selectImageFromGallery);
                          },
                          child: CommonImageView(
                            imagePath: Assets.imagesCamera,
                            fit: BoxFit.contain,
                            width: 32,
                            height: 32,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: h(context, 45),
              ),
              CustomText(
                text: 'Name',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                controller: controller.nameController,
                hintText: 'No name yet',
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Phone Number',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              Container(
                width: w(context, 400),
                height: h(context, 50),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(h(context, 8)),
                  border: Border.all(
                    color: kBorderColor,
                    width: w(context, 1),
                  ),
                  color: kSecondaryColor,
                ),
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCountryPicker(
                            context: context,
                            onSelect: (country) {
                              controller.updateCountry( country: country);
                              // controller.update();
                              print(
                                  "country.countryCode = ${country.phoneCode}");
                            });
                      },
                      child: Obx(()=>SizedBox(
                        width: 30,
                        child: CustomText(
                            text: controller.phoneCode.value,
                            size: 16,
                            weight: FontWeight.w400,
                          ),
                      ),
                      ),
                    ),
                    SizedBox(
                      width: f(context, 12),
                    ),
                    Container(
                      height: h(context, 24),
                      width: 1,
                      color: Colors.grey,
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: TextField(
                        controller: controller.mobileNoController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // SizedBox(
              //   height: h(context, 6),
              // ),
              // CustomTextField2(
              //   controller: controller.mobileNoController,
              //   hintText: 'No mobile number yet',
              // ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Country',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                controller: controller.countryController,
                hintText: 'France',
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'City',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                controller: controller.cityController,
                hintText: 'No city yet',
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Address',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                controller: controller.addressController,
                hintText: 'No address yet',
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: 'Bio',
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField3(
                controller: controller.bioController,
                hintText: 'No Bio yet',
                maxLines: 7,
              ),
              SizedBox(
                height: h(context, 70),
              ),
              CustomButton(
                borderRadius: 8,
                buttonText: "Update Profile",
                onTap: () async{
                  await controller.updateProfile(context: context);

                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
