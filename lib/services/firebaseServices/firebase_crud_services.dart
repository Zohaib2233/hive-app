import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../core/constants/firebase_constants.dart';
import '../../core/utils/app_strings.dart';
import '../../core/utils/snackbar.dart';
import '../../models/notifications/notification_model.dart';
import '../../models/user_model.dart';

class FirebaseCRUDServices {
  FirebaseCRUDServices._privateConstructor();

  //singleton instance variable
  static FirebaseCRUDServices? _instance;

  //This code ensures that the singleton instance is created only when it's accessed for the first time.
  //Subsequent calls to FirebaseCRUDService.instance will return the same instance that was created before.

  //getter to access the singleton instance
  static FirebaseCRUDServices get instance {
    _instance ??= FirebaseCRUDServices._privateConstructor();
    return _instance!;
  }

  /// check if the document exists in Firestore
  Future<bool> isDocExist(
      {required CollectionReference collectionReference,
      required String docId}) async {
    try {
      DocumentSnapshot documentSnapshot =
          await collectionReference.doc(docId).get();

      if (documentSnapshot.exists) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      log("This was the exception while reading document from Firestore: $e");

      return false;
    } catch (e) {
      log("This was the exception while reading document from Firestore: $e");

      return false;
    }
  }

  /// check if the document exists in Firestore
  Future<bool> isDocExistByUsername(
      {required String collectionString, required String username}) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await FirebaseFirestore.instance
              .collection(FirebaseConstants.userCollection)
              .where('username', isEqualTo: username)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } on FirebaseException catch (e) {
      log("This was the exception while reading document from Firestore: $e");

      return false;
    } catch (e) {
      log("This was the exception while reading document from Firestore: $e");

      return false;
    }
  }

  String getCollectionId({required CollectionReference collectionReference}) {
    DocumentReference reference = collectionReference.doc();
    return reference.id;
  }

  /// Create Document
  Future<bool> createDocument(
      {required CollectionReference collectionReference,
      required String docId,
      required Map<String, dynamic> data}) async {
    try {
      await collectionReference.doc(docId).set(data);

      //returning true to indicate that the document is created
      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      log("This was the exception while creating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  /// Create Document and update Id
  Future<bool> createDocument2(
      {required CollectionReference collectionReference,
        required String docIdName,
        required Map<String, dynamic> data}) async {
    try {
      DocumentReference document = collectionReference.doc();

      await document.set(data);
      await document.update({docIdName:document.id});

      //returning true to indicate that the document is created
      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      log("This was the exception while creating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  Future<DocumentSnapshot?> readSingleDoc({required CollectionReference collectionReference, required String docId}) async{
    try{
      DocumentSnapshot snapshot = await collectionReference.doc(docId).get();
      return snapshot;

    }on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return null;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return null;
    }




  }

  Stream<List<UserModel>> readAllUserDoc() {
    List<UserModel> userModels = [];
    // QuerySnapshot<Map<String,dynamic>> snapshots = await FirebaseConstants.fireStore
    //     .collection(FirebaseConstants.userCollection)
    //     .get();
    //
    // for(DocumentSnapshot snapshot in snapshots.docs){
    //   userModels.add(UserModel.fromJson(snapshot));
    //
    // }
    print("==========readAllUserDoc=========");

    return FirebaseConstants.fireStore
        .collection(FirebaseConstants.userCollection)
        .snapshots()
        .map((snapshots) {
      return snapshots.docs.map((e) => UserModel.fromJson(e)).toList();
    });
    // return userModels;
  }

  /// Update Document
  Future<bool> updateDocument(
      {required String collectionPath,
      required String docId,
      required Map<String, dynamic> data}) async {
    try {
      await FirebaseConstants.fireStore
          .collection(collectionPath)
          .doc(docId)
          .update(data);

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  Future<bool> deleteDocument({
    required String collectionPath,
    required String docId,
  }) async {
    try {
      await FirebaseConstants.fireStore
          .collection(collectionPath)
          .doc(docId)
          .delete();

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  /// Hive Data

  Future<bool> addHiveBehavior(
      {required String hiveId, required Map data}) async {
    try {
      DocumentReference reference = FirebaseConstants.hivesCollectionReference
          .doc(hiveId)
          .collection(FirebaseConstants.hivesBehaviorCollection)
          .doc();

      await reference.set(data);

      await reference.update({'hiveBehaviorId': reference.id});

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  Future<bool> addHiveQueen({required String hiveId, required Map data}) async {
    try {
      DocumentReference reference = FirebaseConstants.hivesCollectionReference
          .doc(hiveId)
          .collection(FirebaseConstants.hivesQueenCollection)
          .doc();

      await reference.set(data);

      await reference.update({'hiveQueenId': reference.id});

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  Future<bool> addHiveBroodPattern(
      {required String hiveId, required Map data}) async {
    try {
      DocumentReference reference = FirebaseConstants.hivesCollectionReference
          .doc(hiveId)
          .collection(FirebaseConstants.broodPatternCollection)
          .doc();

      await reference.set(data);

      await reference.update({'broodPatternId': reference.id});

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  Future<bool> addHiveEgg({required String hiveId, required Map data}) async {
    try {
      DocumentReference reference = FirebaseConstants.hivesCollectionReference
          .doc(hiveId)
          .collection(FirebaseConstants.hiveEggCollection)
          .doc();

      await reference.set(data);

      await reference.update({'hiveEggId': reference.id});

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  /// Add Hive Development
  Future<bool> addHiveDev({required String hiveId, required Map data}) async {
    try {
      DocumentReference reference = FirebaseConstants.hivesCollectionReference
          .doc(hiveId)
          .collection(FirebaseConstants.hiveDevCollection)
          .doc();

      await reference.set(data);

      await reference.update({'hiveDevId': reference.id});

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  /// Add Population

  Future<bool> addHivePopulation(
      {required String hiveId, required Map data}) async {
    try {
      DocumentReference reference = FirebaseConstants.hivesCollectionReference
          .doc(hiveId)
          .collection(FirebaseConstants.hivePopulationCollection)
          .doc();

      await reference.set(data);

      await reference.update({'populationId': reference.id});

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  /// Queen Cell
  Future<bool> addQueenCell({required String hiveId, required Map data}) async {
    try {
      DocumentReference reference = FirebaseConstants.hivesCollectionReference
          .doc(hiveId)
          .collection(FirebaseConstants.hiveQueenCellCollection)
          .doc();

      await reference.set(data);

      await reference.update({'queenCellId': reference.id});

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  /// Treatment
  Future<bool> addHiveTreatments(
      {required String hiveId, required Map data}) async {
    try {
      DocumentReference reference = FirebaseConstants.hivesCollectionReference
          .doc(hiveId)
          .collection(FirebaseConstants.hiveTreatmentsCollection)
          .doc();

      await reference.set(data);

      await reference.update({'treatmentsId': reference.id});

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  saveHiveData(
      {required String hiveId,
      required Map<String, dynamic> data,
      required String docIdName,
      required String subCollectionName}) async {
    try {
      DocumentReference reference = FirebaseConstants.hivesCollectionReference
          .doc(hiveId)
          .collection(subCollectionName)
          .doc();

      await reference.set(data);

      await reference.update({docIdName: reference.id});

      return true;
    } on FirebaseException catch (e) {
      //getting firebase error message
      final errorMessage = getFirestoreErrorMessage(e);

      //showing failure snackbar
      CustomSnackBars.instance
          .showFailureSnackbar(title: "Error", message: errorMessage);

      //returning false to indicate that the document was not created
      return false;
    } catch (e) {
      print("This was the exception while updating document on Firestore: $e");

      //returning false to indicate that the document was not created
      return false;
    }
  }

  /* --------- Notifications -------------------*/

  Future saveNotificationToFirestore(
      {required String title,
      required String body,
      required String sentBy,
      required String sentTo,
      required String type,
      DateTime? time,
      DateTime? date}) async {
    try {
      DocumentReference reference =
          FirebaseFirestore.instance.collection('notifications').doc();

      print("**********************reference $reference");

      await reference.set(NotificationModel(
              title: title,
              body: body,
              sentBy: sentBy,
              sentTo: sentTo,
              type: type,
              time: time,
              date: date,
              notId: reference.id)
          .toJson());
    } catch (e) {
      throw Exception(e);
    }
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> streamNotifications(userId) {
    return FirebaseFirestore.instance
        .collection(FirebaseConstants.notificationCollection)
        .where(Filter.and(Filter('sentTo', isEqualTo: userId),
            Filter('type', isNotEqualTo: AppStrings.notificationMessage)))
        // .where('sentTo', isEqualTo: userId).where('type',isNotEqualTo: AppStrings.notificationMessage)
        .orderBy('time', descending: true)
        .snapshots();
  }

  /// Method to get a user-friendly message from FirebaseException
  String getFirestoreErrorMessage(FirebaseException e) {
    switch (e.code) {
      case 'cancelled':
        return 'The operation was cancelled.';
      case 'unknown':
        return 'An unknown error occurred.';
      case 'invalid-argument':
        return 'Invalid argument provided.';
      case 'deadline-exceeded':
        return 'The deadline was exceeded, please try again.';
      case 'not-found':
        return 'Requested document was not found.';
      case 'already-exists':
        return 'The document already exists.';
      case 'permission-denied':
        return 'You do not have permission to execute this operation.';
      case 'resource-exhausted':
        return 'Resource limit has been exceeded.';
      case 'failed-precondition':
        return 'The operation failed due to a precondition.';
      case 'aborted':
        return 'The operation was aborted, please try again.';
      case 'out-of-range':
        return 'The operation was out of range.';
      case 'unimplemented':
        return 'This operation is not implemented or supported yet.';
      case 'internal':
        return 'Internal error occurred.';
      case 'unavailable':
        return 'The service is currently unavailable, please try again later.';
      case 'data-loss':
        return 'Data loss occurred, please try again.';
      case 'unauthenticated':
        return 'You are not authenticated, please login and try again.';
      default:
        return 'An unexpected error occurred, please try again.';
    }
  }
}
