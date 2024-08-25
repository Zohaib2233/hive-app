import 'dart:developer';

import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../core/constants/firebase_constants.dart';
import '../../core/utils/snackbar.dart';

class FirebaseAuthService {
  FirebaseAuthService._privateConstructor();

  //singleton instance variable
  static FirebaseAuthService? _instance;

  //This code ensures that the singleton instance is created only when it's accessed for the first time.
  //Subsequent calls to ValidationService.instance will return the same instance that was created before.

  //getter to access the singleton instance
  static FirebaseAuthService get instance {
    _instance ??= FirebaseAuthService._privateConstructor();
    return _instance!;
  }

  Future<(User?, GoogleSignInAccount?, bool)> authWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      // TODO: Use the `credential` to sign in with Firebase.
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (FirebaseAuth.instance.currentUser == null) {
        return (null, null, false);
      }

      if (FirebaseAuth.instance.currentUser != null) {
        User user = FirebaseAuth.instance.currentUser!;

        //checking if the user's account already exists on firebase
        bool isExist = await FirebaseCRUDServices.instance.isDocExist(
            collectionReference: FirebaseConstants.userCollectionReference,
            docId: user.uid);

        return (user, googleUser, isExist);
      }
    } on FirebaseAuthException catch (e) {
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

      return (null, null, false);
    } on FirebaseException catch (e) {
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

      return (null, null, false);
    } catch (e) {
      log("This was the exception while signing up: $e");

      return (null, null, false);
    }

    return (null, null, false);
  }

  //signing up user with email and password
  Future<User?> signUpUsingEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await FirebaseConstants.auth
          .createUserWithEmailAndPassword(email: email, password: password);
      if (FirebaseAuth.instance.currentUser != null) {
        User user = FirebaseAuth.instance.currentUser!;

        return user;
      }
      if (FirebaseAuth.instance.currentUser == null) {
        return null;
      }
    } on FirebaseAuthException catch (e) {
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

      return null;
    } on FirebaseException catch (e) {
      //showing failure snackbar
      CustomSnackBars.instance.showFailureSnackbar(
          title: 'Authentication Error', message: '${e.message}');

      return null;
    } catch (e) {
      log("This was the exception while signing up: $e");

      return null;
    }

    return null;
  }

  sendPasswordResetEmail({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      await Future.delayed(
          Duration(seconds: 2),
              () => CustomSnackBars.instance.showSuccessSnackbar(
              title: 'Email sent',
              message: 'An email has been sent to you to reset your password'));
      // timerButtonVisible.value = false;
      // timer = Timer.periodic(Duration(seconds: 1), (val) {
      //   if (timerCount.value == 0) {
      //     timer?.cancel();
      //     timerButtonVisible.value = true;
      //     timerCount.value = 30;
      //     // Get.back();
      //   } else {
      //     timerCount.value--;
      //   }
      // });
    } on FirebaseAuthException catch (e) {
      print(e.message);
      CustomSnackBars.instance.showFailureSnackbar(title: 'Error', message: e.message.toString());
    }
  }

//method to check if the user's account already exists on firebase
// Future<bool> isAlreadyExist({required String uid}) async {
//   bool isExist = await FirebaseCRUDService.instance
//       .isDocExist(collectionReference: usersCollection, docId: uid);
//
//   return isExist;
// }
}
