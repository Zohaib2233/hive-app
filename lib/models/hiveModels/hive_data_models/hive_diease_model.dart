import 'package:cloud_firestore/cloud_firestore.dart';

class HiveDiseaseModel {
  bool diseaseFound;
  String diseaseName;
  String diseaseId;
  String hiveId;
  String apiaryId;
  DateTime createdDate;

  HiveDiseaseModel({
    required this.diseaseFound,
    required this.diseaseName,
    required this.diseaseId,
    required this.hiveId,
    required this.apiaryId,
    required this.createdDate,
  });

  // Factory method to create a HiveDiseaseModel from a Firestore document
  factory HiveDiseaseModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return HiveDiseaseModel(
      diseaseFound: data['diseaseFound'] ?? false,
      diseaseName: data['diseaseName'] ?? '',
      diseaseId: doc.id, // Assuming the document ID is used as diseaseId
      hiveId: data['hiveId'] ?? '',
      apiaryId: data['apiaryId'] ?? '',
      createdDate: (data['createdDate'] as Timestamp).toDate(),
    );
  }

  // Method to convert a HiveDiseaseModel to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'diseaseFound': diseaseFound,
      'diseaseName': diseaseName,
      'diseaseId': diseaseId,
      'hiveId': hiveId,
      'apiaryId': apiaryId,
      'createdDate': Timestamp.fromDate(createdDate),
    };
  }
}
