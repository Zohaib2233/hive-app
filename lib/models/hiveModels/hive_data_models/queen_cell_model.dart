import 'package:cloud_firestore/cloud_firestore.dart';

class HiveQueenCellModel {
  bool queenCellSpotted;
  String noOfQueenCells;
  bool supersedureCell;
  String action;
  String featureTask;
  String hiveId;
  String apiaryId;
  String queenCellId;
  DateTime createdDate;

  HiveQueenCellModel({
    required this.queenCellSpotted,
    required this.noOfQueenCells,
    required this.supersedureCell,
    required this.action,
    required this.featureTask,
    required this.hiveId,
    required this.apiaryId,
    required this.queenCellId,
    required this.createdDate,
  });

  // Factory method to create a HiveQueenCellModel from a Firestore document
  factory HiveQueenCellModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return HiveQueenCellModel(
      queenCellSpotted: data['queenCellSpotted'] ?? false,
      noOfQueenCells: data['noOfQueenCells'] ?? '',
      supersedureCell: data['supersedureCell'] ?? false,
      action: data['action'] ?? '',
      featureTask: data['featureTask'] ?? '',
      hiveId: data['hiveId'] ?? '',
      apiaryId: data['apiaryId'] ?? '',
      queenCellId: doc.id,
      createdDate: (data['createdDate'] as Timestamp).toDate(),
    );
  }

  // Method to convert a HiveQueenCellModel to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'queenCellSpotted': queenCellSpotted,
      'noOfQueenCells': noOfQueenCells,
      'supersedureCell': supersedureCell,
      'action': action,
      'featureTask': featureTask,
      'hiveId': hiveId,
      'apiaryId': apiaryId,
      'queenCellId': queenCellId,
      'createdDate': Timestamp.fromDate(createdDate),
    };
  }
}
