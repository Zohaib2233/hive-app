import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/models/notifications/notification_model.dart';
import 'package:beekeep/services/pagination_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pdf/widgets.dart';

class NotificationViewController extends GetxController {
  RxList<NotificationModel> notificationModels = <NotificationModel>[].obs;

  DocumentSnapshot? lastDocument;

  ScrollController scrollController = ScrollController();

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchNotifications();
  }

  // streamNotifications() {
  //
  //
  //
  //   FirebaseFirestore.instance
  //       .collection(FirebaseConstants.notificationCollection)
  //       .where('sentTo', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .orderBy('date')
  //       .snapshots()
  //       .map((notifications) {
  //
  //
  //
  //
  //   });
  // }

  fetchNotifications() {
    PaginationService.instance.fetchPaginateDoc(
      lastDocument: lastDocument,
        limit: 12,
        firebaseQuery: FirebaseFirestore.instance
            .collection(FirebaseConstants.notificationCollection)
            .where('sentTo', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .orderBy("date",descending: true)).listen((notifications) {
      if (notifications.$1.isNotEmpty) {
        notificationModels.assignAll(notifications.$1.map((document) =>
            NotificationModel.fromJson(document.data() as Map<String,dynamic>)).toList());
            }
      if(notifications.$2!=null){

        lastDocument = notifications.$2;

      }

        });
  }


  void scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {

      print("Reached the bottom of the list");
      fetchNotifications();
      // Reached the bottom of the list
    } else if (scrollController.offset <=
        scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {


      // Reached the top of the list
      print("Reached the top of the list");
    }
  }



}
