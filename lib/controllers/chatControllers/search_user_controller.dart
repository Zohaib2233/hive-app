import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchUserController extends GetxController {

  RxInt selectedUserIndex = (0 - 1).obs;
  late UserModel selectedUserModel;
  var searchResults = <DocumentSnapshot>[].obs;
  final TextEditingController searchController = TextEditingController();

  Future<void> searchUsers(String query) async {
    final QuerySnapshot searchQuerySnapshot = await FirebaseConstants
        .userCollectionReference
        .where(Filter.or(Filter('phoneNo', isEqualTo: query),
        Filter('email', isEqualTo: query)))
        .get();

    final QuerySnapshot emailQuerySnapshot = await FirebaseConstants
        .userCollectionReference
        .where('email', isEqualTo: query)
        .get();

    searchResults.value = [
      ...searchQuerySnapshot.docs,
      // ...emailQuerySnapshot.docs,
    ];
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
  }

}
