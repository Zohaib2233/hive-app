import 'package:async/async.dart';
import 'package:beekeep/core/utils/app_strings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../models/apiary_model.dart';
import '../../models/user_model.dart';


// Rx<UserModel> userModelGlobal = UserModel(
//         name: '',
//         username: '',
//         email: '',
//         phoneNo: '',
//         dob: '',
//         uid: '',
//         profilePicture: '',
//         deviceTokenID: '',
//         bio: '',
//         followerCount: 0,
//         followingCount: 0,
//         joinAt: DateTime.now(),
//         activeNow: false,
//         coverPhoto: '',
//         blockAccounts: [],
//         notificationOn: false,
//         mentionTags: '',
//         isPublic: false,
//         isOfficialVerified: false,
//         location: '',
//         lastSeen: DateTime.now(),
//         loginWith: '')
//     .obs;

Rx<UserModel> userModelGlobal = UserModel(
    name: '',
    email: '',
    phoneNo: '',
    city: '',
    country: '',
    address: '',
    uid: '',
    profilePicture: dummyProfile,
    deviceTokenID: '',
    bio: '',
    activeNow: false,
    notificationOn: false,
    userActiveAddress: {}).obs;

RxList<ApiaryModel> apiariesGlobal = <ApiaryModel>[].obs;
RxDouble currentLat = 50.5.obs;
RxDouble currentLng = 30.51.obs;


AsyncMemoizer<(List<QueryDocumentSnapshot<Object?>>, DocumentSnapshot<Object?>?)> hivesMemoizer = AsyncMemoizer<(List<QueryDocumentSnapshot<Object?>>, DocumentSnapshot<Object?>?)>();
