import 'package:beekeep/controllers/authController/register_controller.dart';
import 'package:beekeep/core/bindings/bindings.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/view/screens/bottombar/bottombar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../core/constants/firebase_constants.dart';
import '../../core/constants/shared_pref_keys.dart';
import '../../core/global/functions.dart';
import '../../core/utils/snackbar.dart';
import '../../services/shared_preferences_services.dart';

class LoginController extends GetxController{

  RxBool rememberMe = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future loginMethod({required BuildContext context}) async {
    UserCredential? userCredential;

    try {
      Utils.showProgressDialog(context: context);

      userCredential = await FirebaseConstants.auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);



      print("userCredential = $userCredential");
      if (userCredential.user!.uid.isNotEmpty) {
        await getUserDataStream(userId: userCredential.user!.uid);
        if (rememberMe.value == true) {
          await SharedPreferenceService.instance.saveSharedPreferenceBool(
              key: SharedPrefKeys.loggedIn, value: rememberMe.value);
        }
        CustomSnackBars.instance
            .customSnackBar(message: "Login Successfully", color: kGreenColor);
        Utils.hideProgressDialog(context: context);
        Get.delete<RegisterController>();
        Get.delete<LoginController>();
        Get.offAll(() => BottomNavBar(),binding: HomeBindings());
      }
    } on FirebaseAuthException catch (e) {
     Utils.hideProgressDialog(context: context);
      print("Error $e");
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Login Failed", message: e.message.toString());
    }
  }


}