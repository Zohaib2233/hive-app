import 'package:cloud_firestore/cloud_firestore.dart';

class PestManagementModel {
  List<String> pests;
  String pestsId;
  String hiveId;
  String apiaryId;
  DateTime createdDate;

  PestManagementModel({
    required this.pests,
    required this.pestsId,
    required this.hiveId,
    required this.apiaryId,
    required this.createdDate,
  });

  // Convert a PestManagementModel to a Map for JSON serialization
  Map<String, dynamic> toJson() => {
    'pests': pests,
    'pestsId': pestsId,
    'hiveId': hiveId,
    'apiaryId': apiaryId,
    'createdDate': createdDate.toIso8601String(),
  };

  // Create a PestManagementModel from a Map (JSON deserialization)
  factory PestManagementModel.fromJson(Map<String, dynamic> json) {
    return PestManagementModel(
      pests: List<String>.from(json['pests']),
      pestsId: json['pestsId'],
      hiveId: json['hiveId'],
      apiaryId: json['apiaryId'],
      createdDate: DateTime.parse(json['createdDate']),
    );
  }

  // Factory method to create a PestManagementModel from a Firestore document
  factory PestManagementModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return PestManagementModel(
      pests: List<String>.from(data['pests']),
      pestsId: doc.id,
      hiveId: data['hiveId'] ?? '',
      apiaryId: data['apiaryId'] ?? '',
      createdDate: (data['createdDate'] as Timestamp).toDate(),
    );
  }

  // Convert a PestManagementModel to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'pests': pests,
      'hiveId': hiveId,
      'apiaryId': apiaryId,
      'createdDate': Timestamp.fromDate(createdDate),
    };
  }
}
