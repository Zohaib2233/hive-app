import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseConstants {
  static const String userCollection = 'users';
  static  CollectionReference userCollectionReference = FirebaseFirestore.instance.collection('users');
  static  CollectionReference apiaryCollectionReference = FirebaseFirestore.instance.collection('apiaries');
  static  CollectionReference hivesCollectionReference = FirebaseFirestore.instance.collection('hives');
  static  CollectionReference nucCollectionReference = FirebaseFirestore.instance.collection('nucs');
  static  CollectionReference tasksCollectionReference = FirebaseFirestore.instance.collection('tasks');


  static const String chatRoomsCollection = 'chatRooms';
  static const String apiariesCollection = 'apiaries';
  static const String messagesCollection = 'messages';
  static const String notificationCollection = 'notifications';
  static const String hivesCollection = 'hives';
  static const String hivesBehaviorCollection = 'hivesBehavior';
  static const String hivesQueenCollection = 'hivesQueen';
  static const String broodPatternCollection = 'broodPattern';
  static const String hiveDiseaseCollection = 'hiveDisease';
  static const String hiveEggCollection = 'hiveEgg';
  static const String hiveDevCollection = 'hiveDevelopment';
  static const String hivePopulationCollection = 'hivePopulation';
  static const String hiveQueenCellCollection = 'hiveQueenCells';
  static const String hiveTreatmentsCollection = 'hiveTreatments';
  static const String hivePestsCollection = 'hivePests';
  static const String hiveInspectionCollection = 'hiveInspection';
  static const String hiveFeedingsCollection = 'hiveFeedings';
  static const String hivePrepsCollection = 'hiveFlowPrep';
  static const String hiveConditionsCollection = 'hiveConditions';
  static const String hiveHoneyExtractionCollection = 'hiveHoney';

  static FirebaseAuth auth = FirebaseAuth.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;
}