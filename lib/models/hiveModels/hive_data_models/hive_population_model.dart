import 'package:cloud_firestore/cloud_firestore.dart';

class HivePopulationModel {
  String population;
  String populationValue;
  String populationId;
  String hiveId;
  String apiaryId;
  DateTime createdDate;

  HivePopulationModel({
    required this.population,
    required this.populationValue,
    required this.populationId,
    required this.hiveId,
    required this.apiaryId,
    required this.createdDate,
  });

  // Factory method to create a HivePopulationModel from a Firestore document
  factory HivePopulationModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return HivePopulationModel(
      population: data['population'] ?? '',
      populationValue: data['populationValue'] ?? '0',
      populationId: doc.id,
      hiveId: data['hiveId'] ?? '',
      apiaryId: data['apiaryId'] ?? '',
      createdDate: (data['createdDate'] as Timestamp).toDate(),
    );
  }

  // Method to convert a HivePopulationModel to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'population': population,
      'populationValue': populationValue,
      'populationId': populationId,
      'hiveId': hiveId,
      'apiaryId': apiaryId,
      'createdDate': Timestamp.fromDate(createdDate),
    };
  }
}
