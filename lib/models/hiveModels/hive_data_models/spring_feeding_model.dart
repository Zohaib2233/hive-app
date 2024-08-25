import 'package:cloud_firestore/cloud_firestore.dart';

class SpringFeedingModel {
  List<String> feedings;
  String feedingsId;
  String apiaryId;
  String hiveId;
  DateTime createdDate;

  SpringFeedingModel({
    required this.feedings,
    required this.feedingsId,
    required this.apiaryId,
    required this.hiveId,
    required this.createdDate,
  });

  // Factory method to create a SpringFeedingModel from a Firestore document
  factory SpringFeedingModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return SpringFeedingModel(
      feedings: List<String>.from(data['feedings']),
      feedingsId: doc.id,
      apiaryId: data['apiaryId'] ?? '',
      hiveId: data['hiveId'] ?? '',
      createdDate: (data['createdDate'] as Timestamp).toDate(),
    );
  }

  // Method to convert a SpringFeedingModel to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'feedings': feedings,
      'apiaryId': apiaryId,
      'hiveId': hiveId,
      'createdDate': Timestamp.fromDate(createdDate),
      'feedingsId': feedingsId,
    };
  }
}
