

import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/queen_cell_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class QueenCellController extends GetxController {
  TextEditingController noOfQueenCell = TextEditingController();
  TextEditingController actionTaken = TextEditingController();
  TextEditingController featureTask = TextEditingController();

  RxBool queenCellsSpotted = false.obs;
  RxBool supersedured = false.obs;

  saveQueenCell({required String hiveId, required String apiaryId}) async {
    HiveQueenCellModel hiveQueenCellModel = HiveQueenCellModel(
        queenCellSpotted: queenCellsSpotted.value,
        noOfQueenCells: noOfQueenCell.text,
        supersedureCell: supersedured.value,
        action: actionTaken.text,
        featureTask: featureTask.text,
        hiveId: hiveId,
        apiaryId: apiaryId,
        queenCellId: '',
        createdDate: DateTime.now());

    bool isDocAdded = await FirebaseCRUDServices.instance
        .addQueenCell(hiveId: hiveId, data: hiveQueenCellModel.toMap());

    if (isDocAdded) {
      Get.find<HiveDataController>()
          .hiveQueenCellModels
          .add(hiveQueenCellModel);
      CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success", message: "Hive Queen Cells Added Successfully");
    } else {
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Failed", message: "Hive Queen Cell Not Added");
    }
  }
}
