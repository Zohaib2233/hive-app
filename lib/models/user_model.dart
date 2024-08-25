import 'package:cloud_firestore/cloud_firestore.dart';


class UserModel {
  final String name;
  final String email;
  final String phoneNo;

  final String uid;
  final String profilePicture;
  final String deviceTokenID;
  final String bio;
  final String city; // New field: city
  final String country; // New field: country
  final String address; // New field: address

  final bool activeNow;
  final bool notificationOn;
  final Map<String, dynamic> userActiveAddress;

  // Constructor
  UserModel({
    required this.name,
    required this.email,
    required this.phoneNo,
    required this.uid,
    required this.profilePicture,
    required this.deviceTokenID,
    required this.bio,
    required this.city, // New field: city
    required this.country, // New field: country
    required this.address, // New field: address
    required this.activeNow,
    required this.notificationOn,
    required this.userActiveAddress,
  });

  // Factory methods to create UserModel from JSON
  factory UserModel.fromJson(DocumentSnapshot json) {
    return UserModel(
      phoneNo: json['phoneNo'],
      name: json['name'] ?? '',
      email: json['email'],
      uid: json['uid'],
      profilePicture: json['profilePicture'],
      deviceTokenID: json['deviceTokenID'],
      bio: json['bio'],
      city: json['city'] ?? '', // Parse city from JSON
      country: json['country'] ?? '', // Parse country from JSON
      address: json['address'] ?? '', // Parse address from JSON
      activeNow: json['activeNow'],
      notificationOn: json['notificationOn'],
      userActiveAddress: json['userActiveAddress'] ?? {},
    );
  }

  factory UserModel.fromJson2(Map<String, dynamic> json) {
    return UserModel(
      phoneNo: json['phoneNo'],
      name: json['name'] ?? '',
      email: json['email'],
      uid: json['uid'],
      profilePicture: json['profilePicture'],
      deviceTokenID: json['deviceTokenID'],
      bio: json['bio'],
      city: json['city'] ?? '', // Parse city from JSON
      country: json['country'] ?? '', // Parse country from JSON
      address: json['address'] ?? '', // Parse address from JSON
      activeNow: json['activeNow'],
      notificationOn: json['notificationOn'],
      userActiveAddress: json['userActiveAddress'] ?? {},
    );
  }

  // Method to convert UserModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phoneNo': phoneNo,
      'uid': uid,
      'profilePicture': profilePicture,
      'deviceTokenID': deviceTokenID,
      'bio': bio,
      'city': city, // Include city in JSON
      'country': country, // Include country in JSON
      'address': address, // Include address in JSON
      'activeNow': activeNow,
      'notificationOn': notificationOn,
      'userActiveAddress': userActiveAddress,
    };
  }
}


//
// /// An entity of `geo` field of Cloud Firestore location document.
// class Geo {
//   Geo({
//     required this.geohash,
//     required this.geopoint,
//   });
//
//   factory Geo.fromJson(Map<String, dynamic> json) => Geo(
//     geohash: json['geohash'] as String,
//     geopoint: json['geopoint'] as GeoPoint,
//   );
//
//   final String geohash;
//   final GeoPoint geopoint;
//
//   Map<String, dynamic> toJson() => <String, dynamic>{
//     'geohash': geohash,
//     'geopoint': geopoint,
//   };
// }
