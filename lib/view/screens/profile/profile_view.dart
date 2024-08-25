import 'package:beekeep/core/bindings/bindings.dart';
import 'package:beekeep/core/global/instance_variables.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import 'edit_profile_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    nameController.text = userModelGlobal.value.name;
    mobileNoController.text = userModelGlobal.value.phoneNo;
    emailController.text = userModelGlobal.value.email;
    countryController.text = userModelGlobal.value.country;
    cityController.text = userModelGlobal.value.city;
    addressController.text = userModelGlobal.value.address;
    bioController.text = userModelGlobal.value.bio;

    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreybackgroundColor,
      appBar: AppBar(
        backgroundColor: kGreybackgroundColor,
        leading: Padding(
          padding: only(context, left: 20),
          child: SizedBox(
            width: h(context, 29),
            height: w(context, 29),
            child: GestureDetector(
              onTap: () {
                Get.back();
              },
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
        actions: [
          GestureDetector(
            onTap: () {
              Get.to(() => EditProfileView(),binding: EditProfileBinding());
            },
            child: SizedBox(
              width: h(context, 24),
              height: w(context, 24),
              child: CommonImageView(
                imagePath: Assets.imagesEditProfile,
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(
            width: w(context, 20),
          )
        ],
      ),
      body: Padding(
        padding: symmetric(context, vertical: 20, horizontal: 20),
        child: SingleChildScrollView(
          child: Obx(()=>Column(
              children: [
               CommonImageView(
                  height: 130,
                  width: 150,
                  radius: 150,

                  url: userModelGlobal.value.profilePicture,
                ),


                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(
                  text: userModelGlobal.value.name,
                  size: 16,
                  weight: FontWeight.w600,
                  color: kFullBlackBgColor,
                ),
                CustomText(
                    text: userModelGlobal.value.email,
                    size: 10,
                    weight: FontWeight.w400,
                    color: kGreyColor,
                  ),

                SizedBox(
                  height: h(context, 30),
                ),
                CustomTextField2(
                  hintText: 'No name yet',
                  readOnly: true,
                  controller: nameController,
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomTextField2(
                  hintText: 'No mobile number yet',
                  readOnly: true,
                  controller: mobileNoController,
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomTextField2(
                  hintText: 'No email yet',
                  readOnly: true,
                  controller: emailController,
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomTextField2(
                  hintText: 'France',
                  readOnly: true,
                  controller: countryController,
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomTextField2(
                  hintText: 'No city yet',
                  readOnly: true,
                  controller: cityController,
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomTextField2(
                  hintText: 'No address yet',
                  readOnly: true,
                  controller: addressController,
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomTextField3(
                  hintText: 'No Bio yet',
                  readOnly: true,
                  maxLines: 7,
                  controller: bioController,
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
