import 'package:beekeep/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HiveModel {
  String hiveImage;
  String hiveName;
  String location;
  String apiaryName;
  String honeySuper;
  String temperature;
  String humidity;
  String condition;
  String apiaryId;
  String hiveId;
  String ownerId;
  DateTime createdDate;
  List<String> assigns;
  List<String> tags;

  HiveModel(
      {required this.hiveName,
        required this.assigns,
        required this.tags,
        required this.hiveImage,
      required this.location,
      required this.honeySuper,
      required this.temperature,
      required this.humidity,
      required this.condition,
      required this.apiaryId,
      required this.hiveId,
      required this.ownerId,
      required this.createdDate,
      required this.apiaryName});

  // Convert a HiveModel into a Map. The keys must correspond to the names of the fields in Firestore.
  Map<String, dynamic> toMap() {
    return {
      'hiveImage':hiveImage,
      'hiveName': hiveName,
      'location': location,
      'honeySuper': honeySuper,
      'temperature': temperature,
      'humidity': humidity,
      'condition': condition,
      'apiaryId': apiaryId,
      'hiveId': hiveId,
      'ownerId': ownerId,
      'createdDate': createdDate,
      'apiaryName': apiaryName,
      'assigns':assigns,
      'tags':tags
    };
  }

  // Create a HiveModel from a Firestore DocumentSnapshot
  factory HiveModel.fromDocument(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return HiveModel(
        hiveImage: data.containsKey('hiveImage')?data['hiveImage']:dummyImg,
      assigns: data.containsKey('assigns')?List<String>.from(data['assigns'] as List):[],
      tags: data.containsKey('tags')?List<String>.from(data['tags'] as List):[],
      hiveName: data['hiveName'] ?? '',
      location: data['location'] ?? '',
      honeySuper: data['honeySuper'] ?? '',
      temperature: data['temperature'] ?? '',
      humidity: data['humidity'] ?? '',
      condition: data['condition'] ?? '',
      apiaryId: data['apiaryId'] ?? '',
      hiveId: data['hiveId'] ?? '',
      ownerId: data['ownerId'] ?? '',
      createdDate: data.containsKey('createdDate')
          ? (data['createdDate'] as Timestamp).toDate()
          : DateTime.now(),
      apiaryName: data.containsKey('apiaryName') ? data['apiaryName'] : '',
    );
  }
}
