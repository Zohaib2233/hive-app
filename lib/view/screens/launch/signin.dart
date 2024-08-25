// ignore_for_file: prefer_const_constructors

import 'package:beekeep/controllers/authController/login_controller.dart';
import 'package:beekeep/core/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_Circle_CheckBox_Widget.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import 'forget_password.dart';
import 'register_options.dart';

class SignIn extends StatelessWidget {
   SignIn({super.key});

   GlobalKey<FormState> loginFormKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    var controller = Get.find<LoginController>();
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
      body: Form(
        key: loginFormKey,
        child: SingleChildScrollView(
          padding: symmetric(context, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h(context, 180),
              ),
              Row(
                children: [
                  CustomText(
                    text: "Hi, Welcome!",
                    size: 24,
                    weight: FontWeight.w600,
                  ),
                  SizedBox(
                    width: w(context, 8),
                  ),
                  CommonImageView(
                    imagePath: Assets.imagesHand,
                    fit: BoxFit.contain,
                    height: 30,
                    width: 30,
                  )
                ],
              ),
              SizedBox(
                height: h(context, 47),
              ),
              CustomText(
                text: "Email address",
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                validator: ValidationService.instance.emailValidator,
                controller: controller.emailController,
                hintText: "Your email",
                isIcon: false,
              ),
              SizedBox(
                height: h(context, 20),
              ),
              CustomText(
                text: "Password",
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                validator: ValidationService.instance.emptyValidator,
                controller: controller.passwordController,
                hintText: "Password",
              ),
              SizedBox(
                height: h(context, 30),
              ),
              Row(
                children: [
                  Obx(()=>CircleCheckbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) {
                        controller.rememberMe.value = !controller.rememberMe.value;
                      },
                    ),
                  ),
                  SizedBox(width: 12),
                  CustomText(
                    text: "Remember me",
                    size: 14,
                  ),
                  Spacer(),
                  CustomText(
                    text: "Forgot password?",
                    size: 14,
                    onTap: () {
                      Get.to(() => const ForgetPassword());
                    },
                  ),
                ],
              ),
              SizedBox(
                height: h(context, 40),
              ),
              CustomButton(
                buttonText: "Log In",
                onTap: () {
                  if(loginFormKey.currentState!.validate()){
                    controller.loginMethod(context: context);
                  }

                },
              ),
              SizedBox(
                height: h(context, 25),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: "Don’t have an account? ",
                    textAlign: TextAlign.center,
                    size: 14,
                  ),
                  CustomText(
                    text: "Register",
                    textAlign: TextAlign.center,
                    weight: FontWeight.w600,
                    size: 14,
                    onTap: () {
                      Get.offAll(() => const RegisterOptions());
                    },
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
