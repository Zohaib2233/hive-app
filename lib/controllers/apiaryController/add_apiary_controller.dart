import 'package:beekeep/controllers/apiaryController/apiary_assign_controller.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/global/instance_variables.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/models/apiary_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/services/firebaseServices/firebase_storage_service.dart';
import 'package:beekeep/services/googleMap/google_map.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import '../../core/utils/utils.dart';

class AddApiaryController extends GetxController {
  TextEditingController apiaryNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController hivesController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Future<void> onInit() async {

    // TODO: implement onInit
    super.onInit();

    // LocationPermission permission = await Geolocator.requestPermission();
    // if(permission==LocationPermission.whileInUse || permission==LocationPermission.always){
    //
    // }
    // else{
    //   await Geolocator.openLocationSettings();
    // }

    Position? position = await GoogleMapsService.instance.getUserLocation();
    List<Placemark> placeMarks = await placemarkFromCoordinates(
        position?.latitude ?? 39, position?.longitude ?? 34);
    // addressController.text = '${placeMarks[0].street}, ${placeMarks[0].subLocality}';
    // locationController.text = '${placeMarks[0].street}, ${placeMarks[0].subLocality}';

    ownerNameController.text = userModelGlobal.value.name;
    phoneNoController.text = userModelGlobal.value.phoneNo;
    addressController.text = userModelGlobal.value.address;
  }

  var assignController = Get.put(ApiaryAssignController(), permanent: true);

  RxString sunExposer = 'Sunny'.obs;
  RxString locationType = 'Rural'.obs;

  RxString imagePath = ''.obs;
  RxString imageDownloadUrl = ''.obs;

  RxDouble apiaryLat = 50.5.obs;
  RxDouble apiaryLong = 30.1.obs;

  void updateLocationTypes(String value) {
    locationType.value = value;
  }

  void updateSunExposure(String value) {
    sunExposer.value = value;
  }

  selectImage() async {
    imagePath.value =
        await FirebaseStorageService.instance.pickImageFromGallery();
  }

  addApiaryToFirebase({required BuildContext context}) async {
    Utils.showProgressDialog(context: context);
    if (imagePath.isNotEmpty) {
      imageDownloadUrl.value = await FirebaseStorageService.instance
          .uploadSingleImage(
              imgFilePath: imagePath.value, storageRef: 'apiaryImages');
    }

    final GeoFirePoint geoFirePoint =
        GeoFirePoint(GeoPoint(apiaryLat.value, apiaryLong.value));

    String docId = FirebaseCRUDServices.instance.getCollectionId(
        collectionReference: FirebaseConstants.apiaryCollectionReference);

    bool docCreated = await FirebaseCRUDServices.instance.createDocument(
        collectionReference: FirebaseConstants.apiaryCollectionReference,
        docId: docId,
        data: ApiaryModel(
                apiaryId: docId,
                apiaryName: apiaryNameController.text.toLowerCase(),
                location: locationController.text,
                hives: hivesController.text,
                sunExposer: sunExposer.value,
                locationType: locationType.value,
                ownerId: userModelGlobal.value.uid,
                ownerName: ownerNameController.text,
                phoneNo: phoneNoController.text,
                ownerAddress: addressController.text,
                imageUrl: imageDownloadUrl.value,
                assignPeople: assignController.selectedUsers,
                createdDate: DateTime.now(),
                geo: Geo.fromJson(geoFirePoint.data))
            .toMap());

    if (docCreated) {
      CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success", message: "Apiray Added Successfully");
    }

    Utils.hideProgressDialog(context: context);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    apiaryNameController.dispose();
    locationController.dispose();
    hivesController.dispose();
    ownerNameController.dispose();
    phoneNoController.dispose();
    addressController.dispose();
  }
}
