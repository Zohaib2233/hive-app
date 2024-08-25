import 'package:beekeep/controllers/authController/register_controller.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class RegisterWithPhone extends StatefulWidget {
  const RegisterWithPhone({super.key});

  @override
  State<RegisterWithPhone> createState() => _RegisterWithPhoneState();
}

class _RegisterWithPhoneState extends State<RegisterWithPhone> {
  Country selectedCountry = Country.parse('Japan');
  bool _isSyncing = false;

  updateCountry(Country country) {
    setState(() {
      selectedCountry = country;
    });
  }

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
        padding: symmetric(context, horizontal: 20),
        child: SizedBox(
          height: h(context, double.maxFinite),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: h(context, 12),
              ),
              CustomText(
                text: 'Register',
                size: 24,
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: h(context, 15),
              ),
              CustomText(
                text:
                    'Please enter your country code and enter your phone number.',
                size: 16,
                color: const Color(0xff9D9D9D),
                weight: FontWeight.w400,
              ),
              SizedBox(
                height: h(context, 32),
              ),
              const Divider(),
              SizedBox(
                height: h(context, 50),
                child: GestureDetector(
                  onTap: () {
                    showCountryPicker(
                        context: context,
                        onSelect: (country) {
                          controller.updateCountry(country);
                          controller.update();
                          print("country.countryCode = ${country.phoneCode}");
                        });
                  },
                  child: Row(
                    children: [
                      Obx(
                        () => CustomText(
                          text: Country.parse(controller.countryName.value)
                              .flagEmoji,
                          size: 24,
                          weight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Obx(
                        () => CustomText(
                          text: controller.countryName.value,
                          size: 16,
                          weight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(),
              SizedBox(
                height: h(context, 50),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GetBuilder<RegisterController>(
                      builder: (RegisterController controller) {
                        return CustomText(
                          text: Country.parse(controller.countryName.value)
                              .phoneCode,
                          size: 16,
                          weight: FontWeight.w400,
                        );
                      },
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
                        keyboardType: TextInputType.number,
                        controller: controller.phoneNoController,
                        decoration: const InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(),
              Row(
                children: [
                  CustomText(
                    text: "Sync Contacts",
                    size: 16,
                  ),
                  const Spacer(),
                  Switch(
                    value: _isSyncing,
                    onChanged: (value) {
                      setState(() {
                        _isSyncing = value;
                      });
                    },
                    activeColor: kTertiaryColor,
                  ),
                ],
              ),
              SizedBox(
                height: h(context, 38),
              ),
              CustomButton3(
                buttonText: 'Continue',
                onTap: () {
                  controller.sendOTPOnPhone(context: context);
                  // Get.to(() => const OTPverfication());
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
