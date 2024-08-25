import 'package:beekeep/core/global/instance_variables.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/user_model.dart';
import 'package:beekeep/services/chattingService/chatting_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/constants/firebase_constants.dart';

class ChatroomViewController extends GetxController {

  TextEditingController chatRoomNameController = TextEditingController();
  TextEditingController searchUserController = TextEditingController();


  RxList<UserModel> selectedUsers = <UserModel>[].obs;
  var searchResults = <DocumentSnapshot>[].obs;


  Future<void> searchUsers(String query) async {
    if(query.isEmpty){
      searchResults.clear();
    }
    print("Searchuser called");
    final QuerySnapshot searchQuerySnapshot = await FirebaseConstants
        .userCollectionReference
        .where(Filter.or(Filter('phoneNo', isGreaterThanOrEqualTo: query),
        Filter('email', isGreaterThanOrEqualTo: query))).where(
        'uid', isNotEqualTo: userModelGlobal.value.uid)
        .get();



    searchResults.value = [
      ...searchQuerySnapshot.docs,
      // ...emailQuerySnapshot.docs,
    ];
  }

  createChatRoom({required BuildContext context}) async {
    Utils.showProgressDialog(context: context);
    bool docCreated = await ChattingService.instance.createGroupChatThread(

        groupName: chatRoomNameController.text,
        participants: [userModelGlobal.value.uid, ...selectedUsers.map((user) => user.uid).toList()]);

    if(docCreated){
      CustomSnackBars.instance.showSuccessSnackbar(title: "Success", message: "Group Created Successfully");
      Utils.hideProgressDialog(context: context);
      Get.close(1);
    }
    else{
      Utils.hideProgressDialog(context: context);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    chatRoomNameController.dispose();
    searchUserController.dispose();
  }


}