import 'dart:convert';

import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/constants/shared_pref_keys.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/services/add_hive_data_service.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/view/screens/hive/check_hive_data/hive_conditions_model.dart';
import 'package:beekeep/view/screens/hive/hive-data-collection/checkbox_new_option.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_images.dart';
import '../../../../core/utils/utils.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/common_image_view_widget.dart';

class HiveCondition extends StatefulWidget {
  final HiveModel hiveModel;

  const HiveCondition({super.key, required this.hiveModel});

  @override
  State<HiveCondition> createState() => _HiveConditionState();
}

class _HiveConditionState extends State<HiveCondition> {
  RxList<Conditions> hiveConditions = [
    Conditions('Normal', false),
    Conditions('Normal Odor', false),
    Conditions('Brace Comb', false),
    Conditions('Foul Odor', false),
    Conditions('Damaged Boxes or frames', false),
  ].obs;

  List<String> selectedConditions = [];

  loadLocalList() async {
    List? localList = await AddHiveDataService.instance
        .loadLocalList(prefsKey: SharedPrefKeys.hiveConditions);

    if (localList != null) {
      hiveConditions.clear();
      // localList.forEach((list){
      //   Conditions conditions = Conditions.fromJson(jsonDecode(list));
      //   hiveConditions.add(Conditions(conditions.hiveCondition, false));
      // });

      /// Load all cinditions into hiveCondition with false values
      hiveConditions.value =
          localList.map((list) => Conditions(jsonDecode(list)['hiveCondition'],false))
              .toList();
    }
  }

  saveHiveConditions() async {
    HiveConditionsModel model = HiveConditionsModel(
        conditionsId: '',
        conditions: selectedConditions,
        createdDate: DateTime.now(),
        apiaryId: widget.hiveModel.apiaryId,
        hiveId: widget.hiveModel.hiveId);

    bool isDocAdded = await FirebaseCRUDServices.instance.saveHiveData(
        hiveId: widget.hiveModel.hiveId,
        data: model.toMap(),
        docIdName: 'conditionsId',
        subCollectionName: FirebaseConstants.hiveConditionsCollection);

    if (isDocAdded) {
      Get
          .find<HiveDataController>()
          .hiveConditionModels
          .add(model);
      CustomSnackBars.instance
          .showSuccessSnackbar(title: "Success", message: "Successfully Added");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadLocalList();
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
              await saveHiveConditions();
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
                text: 'Hive Condition',
                size: 14,
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              Obx(() =>
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: hiveConditions.length,
                    itemBuilder: (context, index) =>
                        Row(
                          children: [
                            Checkbox(
                                activeColor: kTertiaryColor,
                                value: hiveConditions[index].isSelected,
                                onChanged: (value) {
                                  setState(() {
                                    hiveConditions[index].isSelected = value!;
                                  });
                                  if (selectedConditions.contains(
                                      hiveConditions[index].hiveCondition)) {
                                    selectedConditions.remove(
                                        hiveConditions[index].hiveCondition);
                                  } else {
                                    selectedConditions
                                        .add(
                                        hiveConditions[index].hiveCondition);
                                  }
                                }),
                            CustomText(
                              text: hiveConditions[index].hiveCondition,
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
                        onFutureClicked: () async {
                         await  AddHiveDataService.instance.saveListForFuture(
                              optionsList: hiveConditions,
                              prefsKey: SharedPrefKeys.hiveConditions);
                        },
                        onAdd: (value) {
                          FocusScope.of(context).unfocus();
                          hiveConditions.add(Conditions(value, false));
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

class Conditions {
  final String hiveCondition;
  bool isSelected;

  Conditions(this.hiveCondition, this.isSelected);

  // Convert a Conditions object to a Map (JSON)
  Map<String, dynamic> toJson() =>
      {
        'hiveCondition': hiveCondition,
        'isSelected': isSelected,
      };

  // Create a Conditions object from a Map (JSON)
  factory Conditions.fromJson(Map<String, dynamic> json) {
    return Conditions(
      json['hiveCondition'],
      json['isSelected'],
    );
  }
}
