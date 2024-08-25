import 'dart:convert';

import 'package:beekeep/services/shared_preferences_services.dart';



class AddHiveDataService {

  AddHiveDataService._privateConstructor();

  //singleton instance variable
  static AddHiveDataService? _instance;


  static AddHiveDataService get instance {
    _instance ??= AddHiveDataService._privateConstructor();
    return _instance!;
  }


  saveListForFuture({required List optionsList, required String prefsKey}) async {
    List<String> jsonList = optionsList
        .map((list) => json.encode(list.toJson()))
        .toList();

    print("futureSaveList = ${json.encode(optionsList)}");

    await SharedPreferenceService.instance.saveSharedPreferenceString(
        key: prefsKey, value: json.encode(jsonList));
  }

 Future<List?> loadLocalList({required String prefsKey}) async {
    String? localList = await SharedPreferenceService.instance
        .getSharedPreferenceString(prefsKey);

    print("loadLocalList = $localList");

    if(localList!=null){
      List<dynamic> jsonList = json.decode(localList);
      print("jsonList = $jsonList");
      return jsonList;

      // treatmentList.value = jsonList.map((treatment) => Meditation.fromJson(json.decode(treatment))).toList();

    }
    else{
      return null;
    }


  }


}