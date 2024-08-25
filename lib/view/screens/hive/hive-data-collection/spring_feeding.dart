import 'dart:convert';

import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/constants/shared_pref_keys.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/spring_feeding_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/services/add_hive_data_service.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_images.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/common_image_view_widget.dart';
import 'checkbox_new_option.dart';

class SpringFeeding extends StatefulWidget {
  final HiveModel hiveModel;

  const SpringFeeding({super.key, required this.hiveModel});

  @override
  State<SpringFeeding> createState() => _SpringFeedingState();
}

class _SpringFeedingState extends State<SpringFeeding> {


  RxList<HiveFeeding> feedingList = [
    HiveFeeding('Pollen Patties', false),
    HiveFeeding('SuperFuel: Probiotic Fondant', false),
    HiveFeeding('Sugar syrup - 1:1', false),
  ].obs;

  List<String> selectedFeedings = [];

  loadListFromLocal() async {
    List? localList = await AddHiveDataService.instance.loadLocalList(
        prefsKey: SharedPrefKeys.hiveFeedings);

    if(localList!=null){
      feedingList.value = localList.map((value)=>HiveFeeding.fromJson(jsonDecode(value))).toList();
    }
  }


  saveSpringFeeding() async {
    SpringFeedingModel springFeedingModel = SpringFeedingModel(
        feedings: selectedFeedings,
        feedingsId: '',
        apiaryId: widget.hiveModel.apiaryId,
        hiveId: widget.hiveModel.hiveId,
        createdDate: DateTime.now());

    bool isDocAdded = await FirebaseCRUDServices.instance.saveHiveData(
        hiveId: widget.hiveModel.hiveId,
        data: springFeedingModel.toMap(),
        docIdName: 'feedingsId',
        subCollectionName: FirebaseConstants.hiveFeedingsCollection);

    if (isDocAdded) {
      Get
          .find<HiveDataController>()
          .hiveFeedingModels
          .add(springFeedingModel);
      CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success", message: "Successfully Added");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadListFromLocal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kGreybackgroundColor,
      appBar: AppBar(
        backgroundColor: kGreybackgroundColor,
        leading: Padding(
          padding: only(context, left: 20),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SizedBox(
              width: h(context, 29),
              height: w(context, 29),
              child: CommonImageView(
                imagePath: Assets.imagesBack,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: widget.hiveModel.hiveName,
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
        actions: [
          Padding(
            padding: only(context, right: 15),
            child: CommonImageView(
              imagePath: Assets.imagesSetting3,
              height: 24,
              width: 24,
            ),
          )
        ],
      ),
      bottomSheet: Container(
        color: kGreybackgroundColor,
        child: Padding(
          padding: symmetric(
            context,
            horizontal: 20,
            vertical: 10,
          ),
          child: CustomButton3(
            buttonText: "Save",
            onTap: () async {
              Utils.showProgressDialog(context: context);
              await saveSpringFeeding();
              Utils.hideProgressDialog(context: context);
              Get.close(1);
            },
          ),
        ),
      ),
      body: ListView(
        padding: symmetric(context, vertical: 20, horizontal: 20),
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text: 'Early Spring Feeding ',
                size: 14,
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              Obx(() =>
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: feedingList.length,
                    itemBuilder: (context, index) =>
                        Row(
                          children: [
                            Checkbox(
                                activeColor: kTertiaryColor,
                                value: feedingList[index].isFeeded,
                                onChanged: (value) {
                                  setState(() {
                                    feedingList[index].isFeeded = value!;
                                  });
                                  if (selectedFeedings.contains(
                                      feedingList[index].feedingName)) {
                                    selectedFeedings.remove(
                                        feedingList[index].feedingName);
                                  }
                                  else {
                                    selectedFeedings.add(
                                        feedingList[index].feedingName);
                                  }
                                }),
                            CustomText(
                              text: feedingList[index].feedingName,
                              size: 14,
                              weight: FontWeight.w400,
                            ),
                          ],
                        ),
                  )),

              SizedBox(
                height: h(context, 10),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CheckboxNewOption(
                        onAdd: (value) {
                          FocusScope.of(context).unfocus();
                          feedingList.add(HiveFeeding(value, false));
                          Get.back();
                        },
                        onFutureClicked: () {
                          AddHiveDataService.instance.saveListForFuture(
                              optionsList: feedingList,
                              prefsKey: SharedPrefKeys.hiveFeedings);
                        },

                      );
                    },
                  );
                },
                child: CustomText(
                  text: 'Create an option',
                  size: 14,
                  weight: FontWeight.w400,
                  color: kTertiaryColor,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

/// For Feeding List

class HiveFeeding {
  final String feedingName;
  bool isFeeded;

  HiveFeeding(this.feedingName, this.isFeeded);

  // Convert a HiveFeeding object to a Map (JSON)
  Map<String, dynamic> toJson() =>
      {
        'feedingName': feedingName,
        'isFeeded': isFeeded,
      };

  // Create a HiveFeeding object from a Map (JSON)
  factory HiveFeeding.fromJson(Map<String, dynamic> json) {
    return HiveFeeding(
      json['feedingName'],
      json['isFeeded'],
    );
  }
}

