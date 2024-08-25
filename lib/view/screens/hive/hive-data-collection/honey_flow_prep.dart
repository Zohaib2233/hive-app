import 'dart:convert';

import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/constants/shared_pref_keys.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/honey_flow_prep_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/services/add_hive_data_service.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_images.dart';
import '../../../../core/utils/utils.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/common_image_view_widget.dart';
import 'checkbox_new_option.dart';

class HoneyFlowPreps extends StatefulWidget {
  final HiveModel hiveModel;

  const HoneyFlowPreps({super.key, required this.hiveModel});

  @override
  State<HoneyFlowPreps> createState() => _HoneyFlowPrepsState();
}

class _HoneyFlowPrepsState extends State<HoneyFlowPreps> {
  bool addHoneySupers = false;
  String supersDepth = 'Deep';
  bool splitHive = false;

  RxList<HoneyPrep> honeyPrepList = <HoneyPrep>[
    HoneyPrep('Add Queen Excluder', false),
    HoneyPrep('Add inner Cover', false),
    HoneyPrep('Add Feeder', false),
    HoneyPrep('Add Pollen Traps', false),
  ].obs;

  List<String> selectedPrep = [];

  saveHoneyPrep() async {
    HoneyFlowPrepModel model = HoneyFlowPrepModel(
        addHoneySuper: addHoneySupers,
        honeySuperType: supersDepth,
        splitHive: splitHive,
        preps: selectedPrep,
        hiveId: widget.hiveModel.hiveId,
        apiaryId: widget.hiveModel.apiaryId,
        createdDate: DateTime.now(),
        prepsId: '');

    bool isDocAdded = await FirebaseCRUDServices.instance.saveHiveData(
        hiveId: widget.hiveModel.hiveId,
        data: model.toFirestore(),
        docIdName: 'prepsId',
        subCollectionName: FirebaseConstants.hivePrepsCollection);

    if (isDocAdded) {
      Get
          .find<HiveDataController>()
          .hivePrepModels
          .add(model);
      CustomSnackBars.instance
          .showSuccessSnackbar(title: "Success", message: "Added Successfully");
    }
  }

  loadLocalList() async {
    List? localList = await AddHiveDataService.instance
        .loadLocalList(prefsKey: SharedPrefKeys.hivePreps);

    if (localList != null) {
      honeyPrepList.value = localList
          .map((value) => HoneyPrep.fromJson(jsonDecode(value)))
          .toList();
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
              await saveHoneyPrep();
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
                text: 'Honey flow preparation',
                size: 14,
                weight: FontWeight.w600,
              ),
              SizedBox(
                height: h(context, 6),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          activeColor: kTertiaryColor,
                          value: addHoneySupers,
                          onChanged: (value) {
                            setState(() {
                              addHoneySupers = value!;
                            });
                          }),
                      CustomText(
                        text: 'Add Honey Supers',
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Radio(
                              activeColor: kTertiaryColor,
                              value: 'Deep',
                              groupValue: supersDepth,
                              onChanged: (value) {
                                setState(() {
                                  supersDepth = value!;
                                });
                              }),
                          CustomText(
                            text: 'Deep',
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              activeColor: kTertiaryColor,
                              value: 'Medium',
                              groupValue: supersDepth,
                              onChanged: (value) {
                                setState(() {
                                  supersDepth = value!;
                                });
                              }),
                          CustomText(
                            text: 'Medium',
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Radio(
                              activeColor: kTertiaryColor,
                              value: 'Shallow',
                              groupValue: supersDepth,
                              onChanged: (value) {
                                setState(() {
                                  supersDepth = value!;
                                });
                              }),
                          CustomText(
                            text: 'Shallow',
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                          activeColor: kTertiaryColor,
                          value: splitHive,
                          onChanged: (value) {
                            setState(() {
                              splitHive = value!;
                            });
                          }),
                      CustomText(
                        text: 'Split Hive',
                        size: 14,
                        weight: FontWeight.w400,
                      ),
                    ],
                  ),
                  Padding(
                    padding: only(context, left: 16, top: 8, bottom: 8),
                    child: Container(
                      width: w(context, 150),
                      height: h(context, 34),
                      decoration: BoxDecoration(
                          color: kTertiaryColor,
                          borderRadius: BorderRadius.circular(h(context, 4))),
                      child: Center(
                        child: Row(mainAxisSize: MainAxisSize.min, children: [
                          CommonImageView(
                            imagePath: Assets.imagesSmallScanner,
                            width: w(context, 24),
                            height: h(context, 24),
                          ),
                          SizedBox(
                            width: w(context, 8),
                          ),
                          CustomText(
                            text: 'Scan New Hive',
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ]),
                      ),
                    ),
                  ),
                  Obx(
                        () =>
                        ListView.builder(
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Checkbox(
                                    activeColor: kTertiaryColor,
                                    value: honeyPrepList[index].isSelected,
                                    onChanged: (value) {
                                      setState(() {
                                        honeyPrepList[index].isSelected =
                                        value!;
                                      });
                                      if (selectedPrep
                                          .contains(
                                          honeyPrepList[index].prep)) {
                                        selectedPrep
                                            .remove(honeyPrepList[index].prep);
                                      } else {
                                        selectedPrep.add(
                                            honeyPrepList[index].prep);
                                      }
                                    }),
                                CustomText(
                                  text: honeyPrepList[index].prep,
                                  size: 14,
                                  weight: FontWeight.w400,
                                ),
                              ],
                            );
                          },
                          itemCount: honeyPrepList.length,
                        ),
                  ),
                ],
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
                              optionsList: honeyPrepList,
                              prefsKey: SharedPrefKeys.hivePreps);
                        },
                        onAdd: (value) {
                          FocusScope.of(context).unfocus();
                          honeyPrepList.add(HoneyPrep(value, false));
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

class HoneyPrep {
  final String prep;
  bool isSelected;

  HoneyPrep(this.prep, this.isSelected);

  // Convert a HoneyPrep object to a Map (JSON)
  Map<String, dynamic> toJson() =>
      {
        'prep': prep,
        'isSelected': isSelected,
      };

  // Create a HoneyPrep object from a Map (JSON)
  factory HoneyPrep.fromJson(Map<String, dynamic> json) {
    return HoneyPrep(
      json['prep'],
      json['isSelected'],
    );
  }
}
