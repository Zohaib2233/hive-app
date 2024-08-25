import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/main.dart';
import 'package:beekeep/models/apiary_model.dart';
import 'package:beekeep/models/nucModels/nuc_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/services/firebaseServices/firebase_storage_service.dart';
import 'package:beekeep/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:textfield_tags/textfield_tags.dart';

class AddNucController extends GetxController {
  AddNucController(apiaryModel);
  RxString conditionController = 'Healthy'.obs;

  StringTagController stringTagController = StringTagController();
  TextEditingController hiveNameController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController honeySupersController = TextEditingController();
  TextEditingController temperatureController = TextEditingController();
  TextEditingController humidityController = TextEditingController();

  RxString imagePath = ''.obs;
  String imageUrl = dummyImg;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    // locationController.text = await GoogleMapsService.instance.getAddressThroughCurrentLoc();
    locationController.text = (Get.arguments as ApiaryModel).location;
  }

  selectImageFromGallery({bool isCamera = false}) async {

    XFile? file;

    if(isCamera==true){
      file =
      await ImagePickerService.instance.pickImageFromCamera();
    }

    else{
     file =
      await ImagePickerService.instance.pickSingleImageFromGallery();
    }



    if (file != null) {
      imagePath.value = file.path;
    }
    Get.back();
  }

  saveNucToDatabase({required String apiaryId}) async {
    if (imagePath.isNotEmpty) {
      imageUrl = await FirebaseStorageService.instance.uploadSingleImage(
          imgFilePath: imagePath.value, storageRef: 'NucsImages');
    }

    NucModel model = NucModel(
      createdDate: DateTime.now(),
        nucId: '',
        apiaryId: apiaryId,
        nucName: hiveNameController.text,
        nucLocation: locationController.text,
        honeySupers: honeySupersController.text,
        temperature: temperatureController.text,
        humidity: humidityController.text,
        condition: conditionController.value,
        imageUrl: imageUrl,
        tags: stringTagController.getTags ?? []);

    bool isDocAdded = await FirebaseCRUDServices.instance.createDocument2(
        collectionReference: FirebaseConstants.nucCollectionReference,
        docIdName: 'nucId',
        data: model.toMap());

    if (isDocAdded) {
      CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success", message: "Nuc Added Successfully");
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
