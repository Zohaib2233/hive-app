import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/utils/app_strings.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/services/firebaseServices/firebase_storage_service.dart';
import 'package:beekeep/services/image_picker_service.dart';
import 'package:beekeep/view/screens/profile/profile_view.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../core/global/instance_variables.dart';

class EditProfileController extends GetxController {
  RxString profileUrl = dummyProfile.obs;
  RxString imagePath = ''.obs;
  RxString phoneCode = ''.obs;

  TextEditingController nameController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    profileUrl.value = userModelGlobal.value.profilePicture;
    nameController.text = userModelGlobal.value.name;
    if(userModelGlobal.value.phoneNo.isNotEmpty){
      mobileNoController.text = userModelGlobal.value.phoneNo.split(' ')[1];
      phoneCode.value = userModelGlobal.value.phoneNo.split(' ')[0];
    }

    emailController.text = userModelGlobal.value.email;
    countryController.text = userModelGlobal.value.country;
    cityController.text = userModelGlobal.value.city;
    addressController.text = userModelGlobal.value.address;
    bioController.text = userModelGlobal.value.bio;
  }

  updateCountry({required Country country}) {
    phoneCode.value = country.phoneCode;
  }

  updateProfile({required BuildContext context}) async {
    print("Update Profile Called ${userModelGlobal.value.uid}");

    Utils.showProgressDialog(context: context);
    await FirebaseCRUDServices.instance.updateDocument(
        collectionPath: FirebaseConstants.userCollection,
        docId: FirebaseAuth.instance.currentUser!.uid,
        data: {
          'name': nameController.text.trim(),
          'phoneNo': '${phoneCode.value} ${mobileNoController.text.trim()}',
          'city': cityController.text.trim(),
          'country': countryController.text.trim(),
          'address': addressController.text.trim(),
          'bio': bioController.text.trim(),
        });

    if (imagePath.isNotEmpty) {
      print("Image path is not empty");
      String downloadUrl = await FirebaseStorageService.instance
          .uploadSingleImage(
          imgFilePath: imagePath.value, storageRef: 'profiles');
      if (downloadUrl.isNotEmpty) {
        print("Download Url is not empty $downloadUrl");
        await FirebaseCRUDServices.instance.updateDocument(
            collectionPath: FirebaseConstants.userCollection,
            docId: userModelGlobal.value.uid,
            data: {
              'profilePicture': downloadUrl,
            });
      }
    }

    print("Profile Updated");
    CustomSnackBars.instance.showSuccessSnackbar(
        title: "Success", message: "Profile Updated Successfully");
    Utils.hideProgressDialog(context: context);
    Get.off(()=>ProfileView());


  }

  selectImageFromCamera() async {
    Get.back();
    XFile? image = await ImagePickerService.instance.pickImageFromCamera();
    if (image != null) {
      imagePath.value = image.path;
    }
  }

  selectImageFromGallery() async {
    Get.back();
    XFile? image =
    await ImagePickerService.instance.pickSingleImageFromGallery();
    if (image != null) {
      imagePath.value = image.path;
    }
  }
}
