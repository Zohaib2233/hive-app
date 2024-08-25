import 'dart:developer';

import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/behaviour_model.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/brood_pattern_model.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/hive_development_model.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/hive_diease_model.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/hive_egg_model.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/hive_population_model.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/honey_extraction_model.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/honey_flow_prep_model.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/pest_management_model.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/queen_model.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/spring_feeding_model.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/spring_inspection_model.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/treatments_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/view/screens/hive/check_hive_data/hive_conditions_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/hiveModels/hive_data_models/queen_cell_model.dart';

class HiveDataController extends GetxController {
  HiveDataController(HiveModel hiveModel);

  HiveModel hiveModel = Get.arguments;
  RxList<HiveBehaviorModel> hiveBehaviorModels = <HiveBehaviorModel>[].obs;
  RxList<HiveQueenModel> hiveQueenModels = <HiveQueenModel>[].obs;
  RxList<BroodPatternModel> broodPatternModels = <BroodPatternModel>[].obs;
  RxList<HiveEggModel> hiveEggModels = <HiveEggModel>[].obs;
  RxList<HiveDevelopmentModel> hiveDevModels = <HiveDevelopmentModel>[].obs;
  RxList<HivePopulationModel> hivePopulationModels = <HivePopulationModel>[].obs;
  RxList<HiveQueenCellModel> hiveQueenCellModels = <HiveQueenCellModel>[].obs;
  RxList<TreatmentsModel> hiveTreatmentsModel = <TreatmentsModel>[].obs;
  RxList<PestManagementModel> hivePestsModels = <PestManagementModel>[].obs;
  RxList<SpringInspectionModel> hiveInspectionModels = <SpringInspectionModel>[].obs;
  RxList<SpringFeedingModel> hiveFeedingModels = <SpringFeedingModel>[].obs;
  RxList<HoneyFlowPrepModel> hivePrepModels = <HoneyFlowPrepModel>[].obs;
  RxList<HiveConditionsModel> hiveConditionModels = <HiveConditionsModel>[].obs;
  RxList<HoneyExtractedModel> hiveHoneyModels = <HoneyExtractedModel>[].obs;
  RxList<HiveDiseaseModel> hiveDiseaseModels = <HiveDiseaseModel>[].obs;


  RxBool isConditionsLoading = false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    listenHiveBehavior();
    listenHiveQueen();
    getHiveBroodPattern();
    getHiveEgg();
    getHiveDev();
    getHivePopulation();
    getQueenCells();
    getHiveTreatments();
    getHivePests();
    getHiveInspections();
    getHiveFeedings();
    getHiveHoneyPrep();
    getHiveConditions();
    getHiveHoney();
    getHiveDisease();
  }

  listenHiveBehavior() async {
    log("listenHiveBehavior");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hivesBehaviorCollection).orderBy('createdDate',descending: true)
        .get();
    for (DocumentSnapshot snapshot in snapshots.docs) {
      hiveBehaviorModels.add(
          HiveBehaviorModel.fromMap(snapshot.data() as Map<String, dynamic>));
    }

  }

  listenHiveQueen() async {
    log("listenHiveQueen");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hivesQueenCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hiveQueenModels
          .add(HiveQueenModel.fromMap(snapshot));
    }

  }

  getHiveBroodPattern() async {
    log("getHiveBroodPattern");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.broodPatternCollection).orderBy('createdTime',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      broodPatternModels.add(
          BroodPatternModel.fromMap(snapshot.data() as Map<String, dynamic>));
    }
  }

  /// Hive Egg
  getHiveEgg() async {
    log("getHiveEgg");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hiveEggCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hiveEggModels.add(
          HiveEggModel.fromMap(snapshot));
    }
  }

  /// Hive Development

  getHiveDev() async {
    log("getHiveEgg");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hiveDevCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hiveDevModels.add(
          HiveDevelopmentModel.fromMap(snapshot));
    }
  }

  /// Hive Population

getHivePopulation() async {
    log("getHiveEgg");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hivePopulationCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hivePopulationModels.add(
          HivePopulationModel.fromMap(snapshot));
    }
  }


  /// Hive Queen Cells

  getQueenCells() async {
    log("getQueenCells");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hiveQueenCellCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hiveQueenCellModels.add(
          HiveQueenCellModel.fromMap(snapshot));
    }
  }

  /// Hive Treatments Cells

  getHiveTreatments() async {
    log("getQueenCells");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hiveTreatmentsCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hiveTreatmentsModel.add(
          TreatmentsModel.fromMap(snapshot));
    }
  }

  /// Hive Pests Management

  getHivePests() async {
    log("getHivePests");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hivePestsCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hivePestsModels.add(
          PestManagementModel.fromMap(snapshot));
    }
  }

  /// Hive Inspection

  getHiveInspections() async {
    log("getHivePests");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hiveInspectionCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hiveInspectionModels.add(
          SpringInspectionModel.fromJson(snapshot));
    }
  }

  /// Hive Feeding

  getHiveFeedings() async {
    log("getHiveFeedings");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hiveFeedingsCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hiveFeedingModels.add(
          SpringFeedingModel.fromMap(snapshot));
    }
  }



  /// Hive Honey Flow Prep

  getHiveHoneyPrep() async {
    log("getHiveHoneyPrep");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hivePrepsCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hivePrepModels.add(
          HoneyFlowPrepModel.fromFirestore(snapshot));
    }
  }

  /// Hive Honey Flow Prep

  getHiveConditions() async {
    isConditionsLoading(true);
    log("getHiveConditions");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hiveConditionsCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hiveConditionModels.add(
          HiveConditionsModel.fromMap(snapshot));
    }

    isConditionsLoading(false);
  }

  /// Hive Honey Flow Prep

  getHiveHoney() async {
    isConditionsLoading(true);
    log("getHiveConditions");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hiveHoneyExtractionCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hiveHoneyModels.add(
          HoneyExtractedModel.fromMap(snapshot));
    }

    isConditionsLoading(false);
  }


  getHiveDisease() async {
    isConditionsLoading(true);
    log("getHiveDisease");
    QuerySnapshot<Map<String, dynamic>> snapshots = await FirebaseConstants
        .hivesCollectionReference
        .doc(hiveModel.hiveId)
        .collection(FirebaseConstants.hiveDiseaseCollection).orderBy('createdDate',descending: true)
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      hiveDiseaseModels.add(
          HiveDiseaseModel.fromMap(snapshot));
    }

    isConditionsLoading(false);
  }
}
