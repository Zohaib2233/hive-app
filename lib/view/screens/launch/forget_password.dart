import 'package:beekeep/core/utils/validators.dart';
import 'package:beekeep/services/firebaseServices/firebase_auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../../core/utils/utils.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  GlobalKey<FormState> forgetPasswordKey = GlobalKey();
  TextEditingController forgetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {


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
        key: forgetPasswordKey,
        child: Padding(
          padding: symmetric(context, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h(context, 12),
              ),
              CustomText(
                text: 'Forget Password',
                size: 24,
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text:
                    'Don’t worry! It happens. Please enter the email associated with your account.',
                size: 16,
                color: const Color(0xff9D9D9D),
                weight: FontWeight.w400,
              ),
              SizedBox(
                height: h(context, 40),
              ),
              CustomText(
                text: "Email address",
                size: 14,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              CustomTextField2(
                controller: forgetPasswordController,
                validator: ValidationService.instance.emailValidator,
                hintText: "Enter your email address",
                isIcon: false,
              ),
              SizedBox(
                height: h(context, 45),
              ),
              CustomButton(
                buttonText: "Send code",
                onTap: () async {
                  if(forgetPasswordKey.currentState!.validate()){
                    Utils.showProgressDialog(context: context);
                    await FirebaseAuthService.instance.sendPasswordResetEmail(
                        email: forgetPasswordController.text);
                  }
                  Utils.hideProgressDialog(context: context);


                  // Get.to(() => const ForgetOTP());
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
