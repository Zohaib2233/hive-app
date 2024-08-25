import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/hive_development_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/services/firebaseServices/firebase_storage_service.dart';
import 'package:beekeep/services/image_picker_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'hive_data_controller.dart';

class HiveDevelopmentController extends GetxController {
  RxList<XFile> images = <XFile>[].obs;
  List<String> imagesPath = [];
  RxBool development = false.obs;
  TextEditingController explainController = TextEditingController();

  selectImages() async {
    images.value =
        await ImagePickerService.instance.pickMultiImagesFromGallery();
  }

  changeDevValue(value) {
    development.value = value;
  }

 Future<bool> saveHiveDev({required String hiveId, required String apiaryId}) async {
    if (images.isNotEmpty) {
      // for (var file in images) {
      //   imagesPath.add(file.path);
      // }
      List<String> imagesUrls = await FirebaseStorageService.instance
          .uploadMultipleImages(
              imagesPaths: images, storageRef: 'hiveDevImages');

      HiveDevelopmentModel hiveDevelopmentModel = HiveDevelopmentModel(
          stagesSeen: development.value,
          detail: explainController.text,
          detailType: 'text',
          images: imagesUrls,
          hiveId: hiveId,
          apiaryId: apiaryId,
          hiveDevId: '',
          createdDate: DateTime.now());

      bool isDocAdded = await FirebaseCRUDServices.instance
          .addHiveDev(hiveId: hiveId, data: hiveDevelopmentModel.toMap());

      Get.find<HiveDataController>().hiveDevModels.add(hiveDevelopmentModel);


      return isDocAdded;
    }
    else{
      CustomSnackBars.instance.showFailureSnackbar(title: "Images", message: "Please Select images");
      return false;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    explainController.dispose();
  }
}
