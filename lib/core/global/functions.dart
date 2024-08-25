import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/user_model.dart';
import 'instance_variables.dart';

Future<void> getUserDataStream({required String userId}) async {
  //getting user's data stream

  print("Get Stream Data");
  FirebaseFirestore.instance
      .collection('users')
      .doc(userId)
      .snapshots()
      .listen((event) {
    print(event);

    //binding that user's data stream into an observable UserModel object

    userModelGlobal.value = UserModel.fromJson(event);

    // log("User first name from model is: ${userModel.value.firstName}");
  });
}