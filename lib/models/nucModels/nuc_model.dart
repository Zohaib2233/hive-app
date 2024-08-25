import 'package:cloud_firestore/cloud_firestore.dart';

class NucModel {
  String nucId;
  String apiaryId;
  String nucName;
  String nucLocation;
  String honeySupers;
  String temperature;
  String humidity;
  String condition;
  String imageUrl;
  DateTime createdDate;
  List<String> tags;

  NucModel({
    required this.createdDate,
    required this.nucId,
    required this.apiaryId,
    required this.nucName,
    required this.nucLocation,
    required this.honeySupers,
    required this.temperature,
    required this.humidity,
    required this.condition,
    required this.imageUrl,
    required this.tags,
  });

  // Factory method to create a NucModel from a Firestore document
  factory NucModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return NucModel(
      nucId: doc.id,
      apiaryId: data['apiaryId'] ?? '',
      createdDate :data.containsKey('createdDate')?(data['createdDate'] as Timestamp).toDate():DateTime.now(),
      nucName: data['nucName'] ?? '',
      nucLocation: data['nucLocation'] ?? '',
      honeySupers: data['honeySupers'] ?? '',
      temperature: data['temperature'] ?? '',
      humidity: data['humidity'] ?? '',
      condition: data['condition'] ?? '',
      imageUrl: data['imageUrl'] ?? '',
      tags: List<String>.from(data['tags'] ?? []),
    );
  }

  // Method to convert a NucModel to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'nucId': nucId,
      'apiaryId': apiaryId,
      'nucName': nucName,
      'nucLocation': nucLocation,
      'honeySupers': honeySupers,
      'temperature': temperature,
      'humidity': humidity,
      'condition': condition,
      'imageUrl': imageUrl,
      'createdDate':createdDate,
      'tags': tags,
    };
  }
}
