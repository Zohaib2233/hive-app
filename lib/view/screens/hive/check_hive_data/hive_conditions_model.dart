import 'package:cloud_firestore/cloud_firestore.dart';

class HiveConditionsModel {
  List<String> conditions;
  DateTime createdDate;
  String apiaryId;
  String hiveId;
  String conditionsId;

  HiveConditionsModel({
    required this.conditions,
    required this.createdDate,
    required this.apiaryId,
    required this.hiveId,
    required this.conditionsId,
  });

  // Factory method to create a HiveConditionsModel from a Firestore document
  factory HiveConditionsModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return HiveConditionsModel(
      conditions: List<String>.from(data['conditions']),
      createdDate: (data['createdDate'] as Timestamp).toDate(),
      apiaryId: data['apiaryId'] ?? '',
      hiveId: data['hiveId'] ?? '',
      conditionsId: doc.id, // Assuming the document ID is used as conditionsId
    );
  }

  // Method to convert a HiveConditionsModel to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'conditions': conditions,
      'createdDate': Timestamp.fromDate(createdDate),
      'apiaryId': apiaryId,
      'hiveId': hiveId,
      'conditionsId': conditionsId,
    };
  }
}
