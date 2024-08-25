import 'package:cloud_firestore/cloud_firestore.dart';

class HiveDevelopmentModel {
  bool stagesSeen;
  String detail;
  String detailType;
  List<String> images;
  String hiveId;
  String apiaryId;
  String hiveDevId;
  DateTime createdDate;

  HiveDevelopmentModel({
    required this.stagesSeen,
    required this.detail,
    required this.detailType,
    required this.images,
    required this.hiveId,
    required this.apiaryId,
    required this.hiveDevId,
    required this.createdDate,
  });

  // Factory method to create a HiveDevelopmentModel from a Firestore document
  factory HiveDevelopmentModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return HiveDevelopmentModel(
      stagesSeen: data['stagesSeen'] ?? false,
      detail: data['detail'] ?? '',
      detailType: data['detailType'] ?? '',
      images: List<String>.from(data['images'] ?? []),
      hiveId: data['hiveId'] ?? '',
      apiaryId: data['apiaryId'] ?? '',
      hiveDevId: doc.id,
      createdDate: (data['createdDate'] as Timestamp).toDate(),
    );
  }

  // Method to convert a HiveDevelopmentModel to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'stagesSeen': stagesSeen,
      'hiveDevId':hiveDevId,
      'detail': detail,
      'detailType': detailType,
      'images': images,
      'hiveId': hiveId,
      'apiaryId': apiaryId,
      'createdDate': Timestamp.fromDate(createdDate),
    };
  }
}
