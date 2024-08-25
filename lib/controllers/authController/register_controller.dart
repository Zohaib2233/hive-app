import 'dart:developer';

import 'package:beekeep/core/bindings/bindings.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/utils/app_strings.dart';
import 'package:beekeep/models/user_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_auth_service.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/view/screens/bottombar/bottombar.dart';
import 'package:beekeep/view/screens/launch/OTP_Verfication.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/constants/shared_pref_keys.dart';
import '../../core/global/functions.dart';
import '../../core/utils/snackbar.dart';
import '../../core/utils/utils.dart';
import '../../services/shared_preferences_services.dart';

class RegisterController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController againPasswordController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  RxString countryName = 'Japan'.obs;
  RxString phoneCode = ''.obs;
  RxString combineNumber = ''.obs;

  RxBool termAndCondition = false.obs;

  signupWithEmail({required BuildContext context}) async {

    // User? user = await FirebaseAuthService.instance.signUpUsingEmailAndPassword(
    //     email: emailController.text.trim(), password: passwordController.text);
    try {
      Utils.showProgressDialog(context: context);
      await FirebaseConstants.auth
          .createUserWithEmailAndPassword(email: emailController.text.trim(), password: passwordController.text);
      if (FirebaseAuth.instance.currentUser != null) {
        User user = FirebaseAuth.instance.currentUser!;

        if (user != null) {
          bool docCreated = await FirebaseCRUDServices.instance.createDocument(
              collectionReference: FirebaseConstants.userCollectionReference,
              docId: user.uid,
              data: UserModel(
                  name: '',
                  email: emailController.text.trim(),
                  phoneNo: '',
                  city: '',
                  country: '',
                  address: '',
                  uid: user.uid,
                  profilePicture: dummyProfile,
                  deviceTokenID: '',
                  bio: '',
                  activeNow: true,
                  notificationOn: true,
                  userActiveAddress: {}).toJson());

          if (docCreated) {
            Utils.hideProgressDialog(context: context);
            await getUserDataStream(userId: user.uid);
            Get.delete<RegisterController>();
            Get.offAll(() => BottomNavBar(), binding: HomeBindings());
          } else {
            Utils.hideProgressDialog(context: context);
            CustomSnackBars.instance
                .showFailureSnackbar(title: "Failed", message: "Not Signup");
          }
        }
      }
      if (FirebaseAuth.instance.currentUser == null) {
        Utils.hideProgressDialog(context: context);

      }
    } on FirebaseAuthException catch (e) {
      Utils.hideProgressDialog(context: context);
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

    } on FirebaseException catch (e) {
      Utils.hideProgressDialog(context: context);
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');


    } catch (e) {
      Utils.hideProgressDialog(context: context);
      log("This was the exception while signing up: $e");
    }



  }

  updateCountry(Country country) {
    countryName.value = country.name;
    phoneCode.value = country.phoneCode;
  }

  combinePhoneNumber() {
    combineNumber.value = '${phoneCode.value}${phoneNoController.text}';
  }

  sendOTPOnPhone({required BuildContext context}) async {
    combinePhoneNumber();
    Utils.showProgressDialog(context: context);
    if (phoneNoController.text.isNotEmpty) {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+${combineNumber.value}',
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {
            // Handle verification failure
            print('Verification failed: ${e.message}');
            // Get.back();
            CustomSnackBars.instance
                .showFailureSnackbar(title: 'Error', message: e.message!);
          },
          codeSent: (String verificationId, int? resendToken) {
            // Handle code sent to the user's phone
            print(verificationId);
            Get.back();
            Get.to(() => OTPverfication(
                  verificationId: verificationId,
                ));
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            // Handle timeout
            // Get.back();
            print('Code auto-retrieval timeout');
          },
        );
      } on FirebaseException catch (e) {
        Get.back();
        CustomSnackBars.instance
            .showFailureSnackbar(title: 'Error', message: e.message!);
      } catch (e) {
        Get.back();
        CustomSnackBars.instance
            .showFailureSnackbar(title: 'Error', message: e.toString());
      }
    } else {
      Get.back();
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Enter Phone Number", message: "Please Enter Phone Number");
    }
  }

  Future verifyCode(
      {required verficationId,
      required smsCode,
      required BuildContext context}) async {
    try {
      Utils.showProgressDialog(context: context);
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: verficationId, smsCode: smsCode));

      if (userCredential != null) {
        bool docCreated = await FirebaseCRUDServices.instance.createDocument(
            collectionReference: FirebaseConstants.userCollectionReference,
            docId: userCredential.user!.uid,
            data: UserModel(
                name: '',
                email: '',
                city: '',
                country: '',
                address: '',
                phoneNo: userCredential.user!.phoneNumber.toString(),
                uid: userCredential.user!.uid,
                profilePicture: dummyProfile,
                deviceTokenID: '',
                bio: '',
                activeNow: false,
                notificationOn: true,
                userActiveAddress: {}).toJson());
        CustomSnackBars.instance.showSuccessSnackbar(
            title: "Success", message: "You Succeesfully Registered");

        if (docCreated) {
          getUserDataStream(userId: FirebaseAuth.instance.currentUser!.uid);
          await SharedPreferenceService.instance.saveSharedPreferenceBool(
              key: SharedPrefKeys.loggedIn, value: true);
          Get.back();
          Get.offAll(() => const BottomNavBar(), binding: HomeBindings());
        } else {
          Get.back();
        }
      }
    } on FirebaseException catch (e) {
      // isLoading(false);
      Get.back();
      log(e.message!);
      CustomSnackBars.instance
          .showFailureSnackbar(title: 'Error', message: e.message!);
    } catch (e) {
      // isLoading(false);
      Get.back();
      log(e.toString());
      CustomSnackBars.instance
          .showFailureSnackbar(title: 'Error', message: e.toString());
    }
  }

  //method to create user account using google auth
  Future<void> registerUserWithGoogleAuth(
      {required BuildContext context}) async {
    Utils.showProgressDialog(context: context);
    //showing progress dialog


    //creating user account
    //(Firebase user,google user credentials,is user already exist on Firestore)
    (User?, GoogleSignInAccount?, bool) googleUser =
        await FirebaseAuthService.instance.authWithGoogle();

    //checking if the account creation was successful
    if (googleUser.$1 != null &&
        googleUser.$2 != null &&
        googleUser.$3 == false) {
      //getting userId
      String userId = FirebaseAuth.instance.currentUser!.uid;

      UserModel userModel = UserModel(
        name: googleUser.$2?.displayName ?? '',
        email: googleUser.$2?.email ?? '',
        phoneNo: '',
        uid: userId,
        profilePicture: dummyProfile,
        deviceTokenID: '',
        bio: '',
        activeNow: true,
        notificationOn: true,
        userActiveAddress: {},
        city: '',
        country: '',
        address: '',
      );
      //initializing user model

      //uploading user info to firestore
      bool isDocCreated = await FirebaseCRUDServices.instance.createDocument(
        collectionReference: FirebaseConstants.userCollectionReference,
        docId: userId,
        data: userModel.toJson(),
      );

      //popping progress indicator
      // Navigator.pop(context);

      if (isDocCreated) {
        SharedPreferenceService.instance.saveSharedPreferenceBool(
            key: SharedPrefKeys.loggedIn, value: true);



        CustomSnackBars.instance.showSuccessSnackbar(
            title: "Success", message: "Account created successfully!");

        //navigating to UploadDocuments page
        Get.back();
        getUserDataStream(userId: userId);
        Get.offAll(
          () => BottomNavBar(),binding: HomeBindings()
        );
      }
    } else if (googleUser.$1 != null &&
        googleUser.$2 != null &&
        googleUser.$3 == true) {
      //popping progress indicator
      // Navigator.pop(context);

      //getting user id
      String userId = FirebaseAuth.instance.currentUser!.uid;

      //storing remember me setting
      // await LocalStorageService.instance
      //     .write(key: "isRememberMe", value: true);

      await googleSignInWithAlreadyAccount(uid: userId);
      Get.back();
    } else if (googleUser.$1 == null &&
        googleUser.$2 == null &&
        googleUser.$3 == false) {
      Get.back();
      //popping progress indicator

      CustomSnackBars.instance.showFailureSnackbar(
          title: "Failure", message: "Something went wrong, please try again!");
    }
  }

  Future<void> googleSignInWithAlreadyAccount({required String uid}) async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);

    if (FirebaseAuth.instance.currentUser != null) {
      SharedPreferenceService.instance
          .saveSharedPreferenceBool(key: SharedPrefKeys.loggedIn, value: true);

      getUserDataStream(userId: FirebaseAuth.instance.currentUser!.uid);

      //popping progress indicator

      //showing success snackbar
      CustomSnackBars.instance.showSuccessSnackbar(
          title: 'Success', message: 'Authenticated successfully');

      //fetching user data
      getUserDataStream(userId: uid);

      //navigating user accordingly (if he has not filled any additional info)

      Get.offAll(
        () => BottomNavBar(),binding: HomeBindings()
      );
    } else {
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Error', message: 'Something went wrong, please try again');
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    againPasswordController.dispose();

    phoneNoController.dispose();
    otpController.dispose();
  }
}
