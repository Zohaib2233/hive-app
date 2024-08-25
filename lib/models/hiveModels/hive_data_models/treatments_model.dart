import 'package:cloud_firestore/cloud_firestore.dart';

class TreatmentsModel {
  List<String> treatments;
  String hiveId;
  String apiaryId;
  DateTime createdDate;
  String treatmentsId;

  TreatmentsModel({
    required this.treatments,
    required this.hiveId,
    required this.apiaryId,
    required this.createdDate,
    required this.treatmentsId,
  });

  // Factory method to create a TreatmentsModel from a Firestore document
  factory TreatmentsModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TreatmentsModel(
      treatments: List<String>.from(data['treatments']),
      hiveId: data['hiveId'] ?? '',
      apiaryId: data['apiaryId'] ?? '',
      createdDate: (data['createdDate'] as Timestamp).toDate(),
      treatmentsId: doc.id,
    );
  }

  // Method to convert a TreatmentsModel to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'treatments': treatments,
      'hiveId': hiveId,
      'apiaryId': apiaryId,
      'createdDate': Timestamp.fromDate(createdDate),
      'treatmentsId': treatmentsId,
    };
  }
}
