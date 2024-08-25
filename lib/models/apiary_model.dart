import 'package:cloud_firestore/cloud_firestore.dart';

class ApiaryModel {
  String apiaryId;
  String apiaryName;
  String location;
  String hives;
  String sunExposer;
  String locationType;
  String ownerId;
  String ownerName;
  String phoneNo;
  String ownerAddress;
  String imageUrl;
  List<String> assignPeople;
  DateTime createdDate;
  Geo geo;


  ApiaryModel({
    required this.geo,
    required this.apiaryId,
    required this.apiaryName,
    required this.location,
    required this.hives,
    required this.sunExposer,
    required this.locationType,
    required this.ownerId,
    required this.ownerName,
    required this.phoneNo,
    required this.ownerAddress,
    required this.imageUrl,
    required this.assignPeople,
    required this.createdDate,
  });

  // Convert ApiaryModel to a map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'apiaryId': apiaryId,
      'apiaryName': apiaryName,
      'location': location,
      'hives': hives,
      'sunExposer': sunExposer,
      'locationType': locationType,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'phoneNo': phoneNo,
      'ownerAddress': ownerAddress,
      'imageUrl': imageUrl,
      'assignPeople': assignPeople,
      'createdDate': Timestamp.fromDate(createdDate),
      'geo':geo.toJson()
    };
  }

  // Create an ApiaryModel from a map (Firebase)
  factory ApiaryModel.fromMap(Map<String, dynamic> map) {
    return ApiaryModel(
      geo:  Geo.fromJson(map['geo']),
      apiaryId: map['apiaryId'] ?? '',
      apiaryName: map['apiaryName'] ?? '',
      location: map['location'] ?? '',
      hives: map['hives'] ?? '0',
      sunExposer: map['sunExposer'] ?? '',
      locationType: map['locationType'] ?? '',
      ownerId: map['ownerId'] ?? '',
      ownerName: map['ownerName'] ?? '',
      phoneNo: map['phoneNo'] ?? '',
      ownerAddress: map['ownerAddress'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      assignPeople: List<String>.from(map['assignPeople'] ?? []),
      createdDate: (map['createdDate'] as Timestamp).toDate(),
    );
  }
}

class Geo {
  Geo({
    required this.geohash,
    required this.geopoint,
  });

  factory Geo.fromJson(Map<String, dynamic> json) => Geo(
    geohash: json['geohash'] as String,
    geopoint: json['geopoint'] as GeoPoint,
  );

  final String geohash;
  final GeoPoint geopoint;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'geohash': geohash,
    'geopoint': geopoint,
  };
}
