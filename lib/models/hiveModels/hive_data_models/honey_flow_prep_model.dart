import 'package:cloud_firestore/cloud_firestore.dart';

class HoneyFlowPrepModel {
  bool addHoneySuper;
  String honeySuperType;
  bool splitHive;
  List<String> preps;
  String hiveId;
  String apiaryId;
  DateTime createdDate;
  String prepsId;

  HoneyFlowPrepModel({
    required this.addHoneySuper,
    required this.honeySuperType,
    required this.splitHive,
    required this.preps,
    required this.hiveId,
    required this.apiaryId,
    required this.createdDate,
    required this.prepsId,
  });

  // Factory method to create a HoneyFlowPrepModel from a Firestore document
  factory HoneyFlowPrepModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return HoneyFlowPrepModel(
      addHoneySuper: data['addHoneySuper'],
      honeySuperType: data['honeySuperType'] ?? '',
      splitHive: data['splitHive'],
      preps: List<String>.from(data['preps']),
      hiveId: data['hiveId'] ?? '',
      apiaryId: data['apiaryId'] ?? '',
      createdDate: (data['createdDate'] as Timestamp).toDate(),
      prepsId: doc.id,
    );
  }

  // Method to convert a HoneyFlowPrepModel to a Firestore document
  Map<String, dynamic> toFirestore() {
    return {
      'addHoneySuper': addHoneySuper,
      'honeySuperType': honeySuperType,
      'splitHive': splitHive,
      'preps': preps,
      'hiveId': hiveId,
      'apiaryId': apiaryId,
      'createdDate': Timestamp.fromDate(createdDate),
      'prepsId': prepsId,
    };
  }
}
