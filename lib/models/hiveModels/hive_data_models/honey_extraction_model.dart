import 'package:cloud_firestore/cloud_firestore.dart';

class HoneyExtractedModel {
  String honeyQuantity;
  String honeyExtracted;
  String honeyExtractionId;
  String hiveId;
  String apiaryId;
  DateTime createdDate;

  HoneyExtractedModel({
    required this.honeyQuantity,
    required this.honeyExtracted,
    required this.honeyExtractionId,
    required this.hiveId,
    required this.apiaryId,
    required this.createdDate,
  });

  // Factory method to create a HoneyExtractedModel from a Firestore document
  factory HoneyExtractedModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return HoneyExtractedModel(
      honeyQuantity: data['honeyQuantity'] ?? '',
      honeyExtracted: data['honeyExtracted'] ?? '',
      honeyExtractionId: doc.id, // Assuming the document ID is used as honeyExtractionId
      hiveId: data['hiveId'] ?? '',
      apiaryId: data['apiaryId'] ?? '',
      createdDate: (data['createdDate'] as Timestamp).toDate(),
    );
  }

  // Method to convert a HoneyExtractedModel to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'honeyQuantity': honeyQuantity,
      'honeyExtracted': honeyExtracted,
      'honeyExtractionId': honeyExtractionId,
      'hiveId': hiveId,
      'apiaryId': apiaryId,
      'createdDate': Timestamp.fromDate(createdDate),
    };
  }
}
