import 'package:cloud_firestore/cloud_firestore.dart';

class HiveQueenModel {
  final String hiveId;
  final String apiaryId;
  final String hiveQueenId;
  final String queenSpotted;
  final String queenMarked;
  final String color;
  final String imgUrl;
  final DateTime createdDate;

  HiveQueenModel({
    required this.hiveId,
    required this.apiaryId,
    required this.hiveQueenId,
    required this.queenSpotted,
    required this.queenMarked,
    required this.color,
    required this.imgUrl,
    required this.createdDate
  });

  factory HiveQueenModel.fromMap(DocumentSnapshot snapshot) {
    Map map = snapshot.data() as Map<String,dynamic>;
    return HiveQueenModel(
      hiveId: map['hiveId'] as String,
      apiaryId: map['apiaryId'] as String,
      hiveQueenId: map['hiveQueenId'] as String,
      queenSpotted: map['queenSpotted'] as String,
      queenMarked: map['queenMarked'] as String,
      color: map['color'] as String,
      imgUrl: map['imgUrl'] as String,
        createdDate:map.containsKey('createdDate')?(map['createdDate'] as Timestamp).toDate():DateTime.now()
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'hiveId': hiveId,
      'apiaryId': apiaryId,
      'hiveQueenId': hiveQueenId,
      'queenSpotted': queenSpotted,
      'queenMarked': queenMarked,
      'color': color,
      'imgUrl': imgUrl,
      'createdDate':createdDate
    };
  }
}
