import 'package:beekeep/controllers/apiaryController/apiary_detail_controller.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/global/instance_variables.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/apiary_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../main.dart';
import '../../services/firebaseServices/firebase_storage_service.dart';
import '../../services/image_picker_service.dart';

class AddHiveController extends GetxController {
  TextEditingController hiveNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController honeySupersController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController humidityController = TextEditingController();
  RxString conditionController = 'Healthy'.obs;

  StringTagController stringTagController = StringTagController();



  RxString imagePath = ''.obs;
  String imageUrl = dummyImg;

  selectImageFromGallery() async {
    XFile? file =
        await ImagePickerService.instance.pickSingleImageFromGallery();

    if (file != null) {
      imagePath.value = file.path;
    }
    Get.back();
  }

  Future<bool> addHiveToFireStore(
      {required ApiaryModel apiaryModel, required BuildContext context}) async {
    Utils.showProgressDialog(context: context);

    if (imagePath.isNotEmpty) {
      imageUrl = await FirebaseStorageService.instance.uploadSingleImage(
          imgFilePath: imagePath.value, storageRef: 'NucsImages');
    }

    String docId = FirebaseCRUDServices.instance.getCollectionId(
        collectionReference: FirebaseConstants.hivesCollectionReference);

    HiveModel hiveModel = HiveModel(
        tags: stringTagController.getTags ?? [],
        hiveName: hiveNameController.text,
        assigns: apiaryModel.assignPeople,
        location: locationController.text,
        honeySuper: honeySupersController.text,
        temperature: temperatureController.text,
        humidity: humidityController.text,
        condition: conditionController.value,
        apiaryId: apiaryModel.apiaryId,
        apiaryName: apiaryModel.apiaryName,
        hiveId: docId,
        ownerId: userModelGlobal.value.uid,
        createdDate: DateTime.now(),
        hiveImage: imageUrl.isEmpty?dummyImg:imageUrl);
    bool isDocAdded = await FirebaseCRUDServices.instance.createDocument(
        collectionReference: FirebaseConstants.hivesCollectionReference,
        docId: docId,
        data: hiveModel.toMap());

    if (isDocAdded) {

      Get.find<ApiaryDetailController>().hiveModels.insert(0, hiveModel);
      // hivesMemoizer = AsyncMemoizer<
      //     (List<QueryDocumentSnapshot<Object?>>, DocumentSnapshot<Object?>?)>();
      Utils.hideProgressDialog(context: context);

      return true;
    } else {
      Utils.hideProgressDialog(context: context);
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    hiveNameController.dispose();
    locationController.dispose();
    honeySupersController.dispose();
    temperatureController.dispose();
    humidityController.dispose();
  }
}
