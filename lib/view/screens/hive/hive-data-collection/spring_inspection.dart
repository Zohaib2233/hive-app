import 'dart:convert';

import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/constants/shared_pref_keys.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/spring_inspection_model.dart';
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

class SpringInspection extends StatefulWidget {
  final HiveModel hiveModel;

  const SpringInspection({super.key, required this.hiveModel});

  @override
  State<SpringInspection> createState() => _SpringInspectionState();
}

class _SpringInspectionState extends State<SpringInspection> {
  RxList<HiveSpringInspection> inspectionsList = [
    HiveSpringInspection('Check brood boxes', false),
    HiveSpringInspection('Reverse brood boxes', false),
    HiveSpringInspection('Clean bottom board', false),
  ].obs;

  List<String> selectedActions = [];

  saveSpringInspection() async {
    SpringInspectionModel springInspectionModel = SpringInspectionModel(
        actions: selectedActions,
        hiveId: widget.hiveModel.hiveId,
        apiaryId: widget.hiveModel.apiaryId,
        actionsId: '',
        createdDate: DateTime.now());

    bool isDocAdded = await FirebaseCRUDServices.instance.saveHiveData(
        hiveId: widget.hiveModel.hiveId,
        data: springInspectionModel.toJson(),
        docIdName: 'actionsId',
        subCollectionName: FirebaseConstants.hiveInspectionCollection);

    if (isDocAdded) {
      Get.find<HiveDataController>()
          .hiveInspectionModels
          .add(springInspectionModel);
      CustomSnackBars.instance
          .showSuccessSnackbar(title: "Success", message: "Added Successfully");
    }
  }

  loadListFromLocal() async {
    List? localList = await AddHiveDataService.instance
        .loadLocalList(prefsKey: SharedPrefKeys.hiveInspection);
    if (localList != null) {
      inspectionsList.value = localList
          .map((inspection) =>
              HiveSpringInspection.fromJson(jsonDecode(inspection)))
          .toList();
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
              await saveSpringInspection();
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
                text: 'Early Spring Inspection ',
                size: 14,
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              Obx(()=>ListView.builder(
                    shrinkWrap: true,
                    itemCount: inspectionsList.length,
                    itemBuilder: (context, index) => Row(
                          children: [
                            Checkbox(
                                activeColor: kTertiaryColor,
                                value: inspectionsList[index].actionPerformed,
                                onChanged: (value) {
                                  setState(() {
                                    inspectionsList[index].actionPerformed =
                                        value!;
                                  });
                                  if (selectedActions
                                      .contains(inspectionsList[index].action)) {
                                    selectedActions
                                        .remove(inspectionsList[index].action);
                                  } else {
                                    selectedActions
                                        .add(inspectionsList[index].action);
                                  }
                                }),
                            CustomText(
                              text: inspectionsList[index].action,
                              size: 14,
                              weight: FontWeight.w400,
                            ),
                          ],
                        )),
              ),
              SizedBox(
                height: h(context, 10),
              ),
              TextButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return CheckboxNewOption(
                        onFutureClicked: () async {
                          await AddHiveDataService.instance.saveListForFuture(
                              optionsList: inspectionsList,
                              prefsKey: SharedPrefKeys.hiveInspection);
                        },
                        onAdd: (value) {
                          FocusScope.of(context).unfocus();
                          inspectionsList
                              .add(HiveSpringInspection(value, false));
                          Get.back();
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

class HiveSpringInspection {
  final String action;
  bool actionPerformed;

  HiveSpringInspection(this.action, this.actionPerformed);

  // Convert a HiveSpringInspection object to a Map
  Map<String, dynamic> toJson() => {
        'action': action,
        'actionPerformed': actionPerformed,
      };

  // Create a HiveSpringInspection object from a Map
  factory HiveSpringInspection.fromJson(Map<String, dynamic> json) {
    return HiveSpringInspection(
      json['action'],
      json['actionPerformed'],
    );
  }
}
