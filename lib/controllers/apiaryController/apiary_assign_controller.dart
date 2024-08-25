import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';

class ApiaryAssignController extends GetxController {
  TextEditingController searchEditingController = TextEditingController();
  RxList<UserModel> searchResults = <UserModel>[].obs;

  RxBool isLoading = false.obs;
  RxBool hasMore = true.obs;
  DocumentSnapshot? lastDocument;
  final int itemsPerPage = 10;

  ScrollController scrollController = ScrollController();

  // List<UserModel> searchUsers = [];

  List<String> selectedUsers = [];

  void searchUsers(String query) async {
    isLoading.value = true;

    lastDocument = null;
    hasMore.value = true;

    await fetchUsers(query);
  }

  Future<void> fetchUsers(String query) async {
    searchResults.clear();
    if (!hasMore.value) {
      return;
    }

    Query q = FirebaseConstants.userCollectionReference;

    if (lastDocument != null) {
      q = q.startAfterDocument(lastDocument!);
    }

    q = q
        .where(Filter.or(
            Filter.and(Filter('email', isGreaterThanOrEqualTo: query),
                Filter('email', isLessThan: '$query\uf8ff')),
            Filter.and(Filter('phoneNo', isGreaterThanOrEqualTo: query),
            Filter('phoneNo', isLessThan: '$query\uf8ff'))))
        .limit(10);

    QuerySnapshot results = await q.get();

    if (results.docs.isEmpty) {
      hasMore.value = false;
      isLoading.value = false;
      return;
    }

    lastDocument = results.docs.last;
    for (DocumentSnapshot doc in results.docs) {
      searchResults.add(UserModel.fromJson(doc));
    }
    // searchResults.addAll(results.docs);
    isLoading.value = false;
  }

  void loadMore() async {
    await fetchUsers(searchEditingController.text);
  }

  selectUser(UserModel userModel) {
    if (selectedUsers.contains(userModel.uid)) {
      selectedUsers.remove(userModel.uid);
    } else {
      selectedUsers.add(userModel.uid);
    }
    update();
  }
}
