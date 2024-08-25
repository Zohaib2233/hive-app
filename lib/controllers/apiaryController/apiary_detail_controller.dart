import 'package:beekeep/services/pagination_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/constants/firebase_constants.dart';
import '../../models/hiveModels/hive_model.dart';
import '../../models/nucModels/nuc_model.dart';

class ApiaryDetailController extends GetxController {
  final String apiaryId;

  ApiaryDetailController(this.apiaryId);

  RxInt indexValue = 0.obs;
  ScrollController scrollController = ScrollController();

  RxList<NucModel> nucModels = <NucModel>[].obs;
  RxList<HiveModel> hiveModels = <HiveModel>[].obs;

  var isLoading = false.obs;
  var hasMore = true.obs;
  DocumentSnapshot? lastHiveDocument;
  final int pageSize = 1;

  DocumentSnapshot? lastNucDoc;

  @override
  void onInit() {
    super.onInit();
    scrollController.addListener(_scrollListener);
    fetchInitialNucs(apiaryId: apiaryId);
    getHives(apiaryId: apiaryId);
    // fetchNucs();
  }

  getHives({required String apiaryId}) async {
    var documents = await PaginationService.instance.getPaginateDoc(
        firebaseQuery: FirebaseConstants.hivesCollectionReference
            .where('apiaryId', isEqualTo: apiaryId)
            .orderBy('createdDate', descending: true),limit: 5);
    hiveModels.addAll(documents.$1
        .map((document) => HiveModel.fromDocument(document))
        .toList());

    lastHiveDocument = documents.$2;
  }

  getMoreHives({required String apiaryId}) async {
    var documents = await PaginationService.instance.getPaginateDoc(
        firebaseQuery: FirebaseConstants.hivesCollectionReference
            .where('apiaryId', isEqualTo: apiaryId)
            .orderBy('createdDate', descending: true),lastDocument: lastHiveDocument,limit: 5);
    if(documents.$2!=null){
      hiveModels.addAll(documents.$1
          .map((document) => HiveModel.fromDocument(document))
          .toList());
      lastHiveDocument = documents.$2;
    }



  }

  fetchInitialNucs({required String apiaryId}) {
    PaginationService.instance
        .fetchPaginateDoc(
            firebaseQuery: FirebaseConstants.nucCollectionReference
                .where('apiaryId', isEqualTo: apiaryId)
                .orderBy('createdDate', descending: true),
            limit: 10)
        .listen((documents) {
      nucModels.assignAll(
          documents.$1.map((document) => NucModel.fromMap(document)).toList());
      lastNucDoc = documents.$2;
    });
  }

  fetchMoreNucs({required String apiaryId}) {
    isLoading(true);
    PaginationService.instance
        .fetchPaginateDoc(
            firebaseQuery: FirebaseConstants.nucCollectionReference
                .where('apiaryId', isEqualTo: apiaryId)
                .orderBy('createdDate', descending: true),
            lastDocument: lastNucDoc,
            limit: 5)
        .listen((documents) {
      if (documents.$2 != null) {
        nucModels.addAll(documents.$1
            .map((document) => NucModel.fromMap(document))
            .toList());
        lastNucDoc = documents.$2;
      }

      isLoading(false);
    });
  }

  // void fetchNucs() async {
  //   if (isLoading.value || !hasMore.value) return;
  //   isLoading.value = true;
  //
  //   Query query = FirebaseConstants.nucCollectionReference
  //       .where('apiaryId', isEqualTo: apiaryId)
  //       .limit(pageSize);
  //
  //   if (lastDocument != null) {
  //     query = query.startAfterDocument(lastDocument!);
  //   }
  //
  //   QuerySnapshot querySnapshot = await query.get();
  //   if (querySnapshot.docs.isNotEmpty) {
  //     lastDocument = querySnapshot.docs.last;
  //     nucModels.addAll(
  //         querySnapshot.docs.map((doc) => NucModel.fromMap(doc)).toList());
  //   } else {
  //     hasMore.value = false;
  //   }
  //   isLoading.value = false;
  // }

  // void loadMore() {
  //   if (hasMore.value && !isLoading.value) {
  //     fetchNucs();
  //   }
  // }

  void _scrollListener() {
    if (scrollController.offset >= scrollController.position.maxScrollExtent &&
        !scrollController.position.outOfRange) {
      print("Reached the bottom of the list");
      // Reached the bottom of the list
    } else if (scrollController.offset <=
            scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      if (indexValue.value == 1) {
        fetchMoreNucs(apiaryId: apiaryId);
      }
      {
        getMoreHives(apiaryId: apiaryId);
      }
      // Reached the top of the list
      print("Reached the top of the list");
    }
  }
}
