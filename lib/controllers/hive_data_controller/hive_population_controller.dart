import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/hive_population_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:get/get.dart';

class HivePopulationController extends GetxController {
  RxString population = 'Low'.obs;
  RxDouble populationValue = 0.0.obs;

  changePopulation(value) {
    population.value = value;
  }

  changePopulationValue(value) {
    populationValue.value = value;
  }

  Future<bool> savePopulation(
      {required String hiveId, required String apiaryId}) async {
    HivePopulationModel hivePopulationModel = HivePopulationModel(
        population: population.value,
        populationValue: populationValue.value.toString(),
        populationId: '',
        hiveId: hiveId,
        apiaryId: apiaryId,
        createdDate: DateTime.now());

    bool isDocAdded = await FirebaseCRUDServices.instance
        .addHivePopulation(hiveId: hiveId, data: hivePopulationModel.toMap());

    if (isDocAdded) {
      Get
          .find<HiveDataController>()
          .hivePopulationModels
          .add(hivePopulationModel);
      CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success", message: "Hive Population Added");
    }
    else {
      CustomSnackBars.instance.showFailureSnackbar(title: "Failed",
          message: "Hive Population not added please check Internet");
    }

    return isDocAdded;
  }
}
