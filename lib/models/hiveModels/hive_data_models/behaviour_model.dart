import 'package:cloud_firestore/cloud_firestore.dart';

class HiveBehaviorModel {
  final String hiveBehaviorId;
  final String hiveId;
  final String apiaryId;
  final DateTime createdDate;
  final String behavior;
  final String behaviorPoints;
  final String image;

  HiveBehaviorModel({
    required this.hiveBehaviorId,
    required this.hiveId,
    required this.apiaryId,
    required this.createdDate,
    required this.behavior,
    required this.behaviorPoints,
    required this.image,
  });

  factory HiveBehaviorModel.fromMap(Map<String, dynamic> map) {
    return HiveBehaviorModel(
      hiveBehaviorId: map['hiveBehaviorId'] as String,
      hiveId: map['hiveId'] as String,
      apiaryId: map['apiaryId'] as String,
      createdDate: (map['createdDate'] as Timestamp).toDate(),
      behavior: map['behavior'] as String,
      behaviorPoints: map['behaviorPoints'] as String,
      image: map['image'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hiveBehaviorId': hiveBehaviorId,
      'hiveId': hiveId,
      'apiaryId': apiaryId,
      'createdDate': createdDate,
      'behavior': behavior,
      'behaviorPoints': behaviorPoints,
      'image': image,
    };
  }
}
