import 'package:cloud_firestore/cloud_firestore.dart';

class BroodPatternModel {
  final String broodPatternId;
  final String broodPattern;
  final DateTime createdTime;
  final String hiveId;
  final String apiaryId;

  BroodPatternModel({
    required this.broodPatternId,
    required this.broodPattern,
    required this.createdTime,
    required this.hiveId,
    required this.apiaryId,
  });

  factory BroodPatternModel.fromMap(Map<String, dynamic> map) {
    return BroodPatternModel(
      broodPatternId: map['broodPatternId'] as String,
      broodPattern: map['broodPattern'] as String,
      createdTime: (map['createdTime'] as Timestamp).toDate(),
      hiveId: map['hiveId'] as String,
      apiaryId: map['apiaryId'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'broodPatternId': broodPatternId,
      'broodPattern': broodPattern,
      'createdTime': createdTime,
      'hiveId': hiveId,
      'apiaryId': apiaryId,
    };
  }
}
