import 'package:cloud_firestore/cloud_firestore.dart';

class HiveEggModel {
  String hiveEggId;
  String hiveId;
  String apiaryId;
  bool eggSpotted;
  DateTime createdDate;

  HiveEggModel({
    required this.hiveEggId,
    required this.hiveId,
    required this.apiaryId,
    required this.eggSpotted,
    required this.createdDate,
  });

  // Factory method to create a HiveEggModel from a Firestore document
  factory HiveEggModel.fromMap(DocumentSnapshot doc) {
    Map data = doc.data() as Map<String, dynamic>;
    return HiveEggModel(
      hiveEggId: doc.id,
      hiveId: data['hiveId'] ?? '',
      apiaryId: data['apiaryId'] ?? '',
      eggSpotted: data['eggSpotted'] ?? false,
      createdDate: (data['createdDate'] as Timestamp).toDate(),
    );
  }

  // Method to convert a HiveEggModel to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'hiveEggId': hiveEggId,
      'hiveId': hiveId,
      'apiaryId': apiaryId,
      'eggSpotted': eggSpotted,
      'createdDate': createdDate,
    };
  }
}
