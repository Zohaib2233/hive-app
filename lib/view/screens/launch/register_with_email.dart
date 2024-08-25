// ignore_for_file: prefer_const_constructors

import 'package:beekeep/controllers/authController/register_controller.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/validators.dart';
import 'package:beekeep/view/screens/launch/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_Circle_CheckBox_Widget.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class RegisterWithEmail extends StatelessWidget {
  RegisterWithEmail({super.key});
  final GlobalKey<FormState> registerWithEmailFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<RegisterController>();


    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xffF5F5F5),
        leading: Padding(
          padding: all(context, 15),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: CommonImageView(
              imagePath: Assets.imagesBack,
              height: 28,
              width: 28,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: registerWithEmailFormKey,
          child: ListView(
            children: [
              SizedBox(
                height: h(context, 82),
              ),
              CustomText(
                text: "Sign up",
                size: 24,
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text: "Please Enter your details to continue",
                color: const Color(0xff9D9D9D),
                size: 16,
              ),
              SizedBox(
                height: h(context, 46),
              ),
              CustomText(
                text: "Email",
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                validator: ValidationService.instance.emailValidator,
                controller: controller.emailController,
                hintText: "example@gmail.com",
                isIcon: false,
              ),
              SizedBox(
                height: h(context, 20),
              ),
              CustomText(
                text: "Create a password",
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                validator: ValidationService.instance.validatePassword,
                controller: controller.passwordController,
                hintText: "must be 8 characters",
              ),
              SizedBox(
                height: h(context, 20),
              ),
              CustomText(
                text: "Confirm password",
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                validator: (value) {
                  return ValidationService.instance.validateMatchPassword(
                      value!, controller.passwordController.text);
                },
                controller: controller.againPasswordController,
                hintText: "repeat password",
              ),
              SizedBox(
                height: h(context, 30),
              ),
              Row(
                children: [
                  Obx(
                    () => CircleCheckbox(
                      value: controller.termAndCondition.value,
                      onChanged: (value) {
                        controller.termAndCondition.value = value!;
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  CustomText(
                    text: "I accept the terms and privacy policy",
                    size: 14,
                  ),
                ],
              ),
              SizedBox(
                height: h(context, 40),
              ),
              CustomButton3(
                buttonText: "Register",
                onTap: () {
                  if(registerWithEmailFormKey.currentState!.validate()){
                    if (controller.termAndCondition.isTrue) {
                      controller.signupWithEmail(context: context);
                    } else {
                      CustomSnackBars.instance.showFailureSnackbar(
                          title: "Failed",
                          message: "Please Accept the Terms and privacy policy");
                    }
                  }


                  // if(registerWithEmailFormKey.currentState!.validate()){
                  //   print("Validated");
                  // }
                },
              ),
              SizedBox(
                height: h(context, 15),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Already have an account? ",
                    textAlign: TextAlign.center,
                    size: 14,
                  ),
                  GestureDetector(
                    onTap: (){
                      Get.off(()=>SignIn());
                    },
                    child: CustomText(
                      text: "Login",
                      textAlign: TextAlign.center,
                      weight: FontWeight.w600,
                      color: kTertiaryColor,
                      size: 14,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
