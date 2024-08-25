import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/global/instance_variables.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/services/googleMap/google_map.dart';
import 'package:beekeep/services/notificationService/local_notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../models/apiary_model.dart';

class HomeController extends GetxController {
  var apiaries = <ApiaryModel>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchApiaries();
    Position? position = await GoogleMapsService.instance.getUserLocation();
    print(
        "home controller init = ${position?.longitude} ${position?.latitude}");
    currentLat.value = position?.latitude ?? 50.5;
    currentLng.value = position?.longitude ?? 30.51;

    String? deviceToken =
        await LocalNotificationService.instance.getDeviceToken();

    if (deviceToken != null) {
      await FirebaseCRUDServices.instance.updateDocument(
          collectionPath: FirebaseConstants.userCollection,
          docId: userModelGlobal.value.uid,
          data: {"deviceTokenID": deviceToken});
    }
  }

  void fetchApiaries() {
    apiaries.bindStream(apiaryStream());
  }

  Stream<List<ApiaryModel>> apiaryStream() {
    return FirebaseConstants.apiaryCollectionReference
        .where('ownerId', isEqualTo: userModelGlobal.value.uid)
        .orderBy('createdDate', descending: true)
        .snapshots()
        .map((QuerySnapshot query) {
      List<ApiaryModel> apiaryList = [];
      List<Geo> geos = [];
      for (var apiary in query.docs) {
        ApiaryModel apiaryModel =
            ApiaryModel.fromMap(apiary.data() as Map<String, dynamic>);
        geos.add(apiaryModel.geo);
        apiaryList.add(apiaryModel);
      }
      // apiariesGlobalGeos.value = geos;
      apiariesGlobal.value = apiaryList;
      return apiaryList;
    });
  }
}
