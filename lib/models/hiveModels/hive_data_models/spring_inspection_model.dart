import 'package:cloud_firestore/cloud_firestore.dart';

class SpringInspectionModel {
  List<String> actions;
  String hiveId;
  String apiaryId;
  String actionsId;
  DateTime createdDate;

  SpringInspectionModel({
    required this.actions,
    required this.hiveId,
    required this.apiaryId,
    required this.actionsId,
    required this.createdDate,
  });

  // Factory method to create a SpringInspectionModel from a Firestore document
  factory SpringInspectionModel.fromJson(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return SpringInspectionModel(
      actions: List<String>.from(data['actions']),
      hiveId: data['hiveId'] ?? '',
      apiaryId: data['apiaryId'] ?? '',
      actionsId: doc.id,
      createdDate: (data['createdDate'] as Timestamp).toDate(),
    );
  }

  // Method to convert a SpringInspectionModel to a Firestore document
  Map<String, dynamic> toJson() {
    return {
      'actions': actions,
      'hiveId': hiveId,
      'apiaryId': apiaryId,
      'createdDate': Timestamp.fromDate(createdDate),
      'actionsId': actionsId,
    };
  }
}
