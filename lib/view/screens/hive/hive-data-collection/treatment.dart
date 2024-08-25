import 'dart:convert';

import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/constants/shared_pref_keys.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/treatments_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/services/shared_preferences_services.dart';
import 'package:beekeep/view/screens/hive/hive-data-collection/checkbox_new_option.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_images.dart';
import '../../../../core/utils/utils.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/common_image_view_widget.dart';

class Treatment extends StatefulWidget {
  final HiveModel hiveModel;

  const Treatment({super.key, required this.hiveModel});

  @override
  State<Treatment> createState() => _TreatmentState();
}

// List<({String treatmentName, bool treated})> treatmentList = [
//   (treatmentName: 'Disease Spotted', treated: false),
//   (treatmentName: 'Oxalic Acid', treated: false),
//   (treatmentName: 'Api Guard', treated: false),
//   (treatmentName: 'AFB', treated: false),
//   (treatmentName: 'Apivar', treated: false),
//   (treatmentName: 'Formic Pro', treated: false),
//   (treatmentName: 'Mite Away', treated: false),
// ];

class _TreatmentState extends State<Treatment> {
  HiveDataController controller = Get.find();
  RxList<Meditation> treatmentList = [
    Meditation('Disease Spotted', false),
    Meditation('Oxalic Acid', false),
    Meditation('Api Guard', false),
    Meditation('AFB', false),
    Meditation('Apivar', false),
    Meditation('Formic Pro', false),
    Meditation('Mite Away', false),
  ].obs;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadTreatments();
  }

  List<String> selectedMeditations = [];

  saveHiveTreatments() async {
    TreatmentsModel treatmentsModel = TreatmentsModel(
        treatments: selectedMeditations,
        hiveId: widget.hiveModel.hiveId,
        apiaryId: widget.hiveModel.apiaryId,
        createdDate: DateTime.now(),
        treatmentsId: '');

    bool isDocAdded = await FirebaseCRUDServices.instance.addHiveTreatments(
        hiveId: widget.hiveModel.hiveId, data: treatmentsModel.toMap());

    if (isDocAdded) {
      controller.hiveTreatmentsModel.add(treatmentsModel);
      CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success", message: "Treatments Added Suucessfully");
    }
  }

  futureSaveTreatmentsList() async {
    List<String> jsonList = treatmentList
        .map((treatment) => json.encode(treatment.toJson()))
        .toList();

    print("futureSaveTreatmentsList = ${json.encode(treatmentList)}");

    await SharedPreferenceService.instance.saveSharedPreferenceString(
        key: SharedPrefKeys.hiveTreatments, value: json.encode(jsonList));
  }

  loadTreatments() async {
    String? treatments = await SharedPreferenceService.instance
        .getSharedPreferenceString(SharedPrefKeys.hiveTreatments);

    print("loadTreatments = ${treatments}");

    if(treatments!=null){
      List<dynamic> jsonList = json.decode(treatments);
      print("jsonList = $jsonList");
      treatmentList.value = jsonList.map((treatment) => Meditation.fromJson(json.decode(treatment))).toList();

    }


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
              await saveHiveTreatments();
              Utils.hideProgressDialog(context: context);
              Get.close(1);
            },
          ),
        ),
      ),
      body: Padding(
        padding: symmetric(context, vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: 'Select a medication or treatment',
              size: 14,
              weight: FontWeight.w400,
            ),
            SizedBox(
              height: h(context, 6),
            ),
            Obx(
                  () =>
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: treatmentList.length,
                    itemBuilder: (context, index) {
                      return Row(
                        children: [
                          Checkbox(
                              activeColor: kTertiaryColor,
                              value: treatmentList[index].treated,
                              onChanged: (value) {
                                // treatmentList[index].values.first = value!;
                                treatmentList[index].treated = value!;

                                setState(() {});
                                if (selectedMeditations
                                    .contains(
                                    treatmentList[index].treatmentName)) {
                                  selectedMeditations
                                      .remove(
                                      treatmentList[index].treatmentName);
                                } else {
                                  selectedMeditations
                                      .add(treatmentList[index].treatmentName);
                                }
                              }),
                          CustomText(
                            text: treatmentList[index].treatmentName,
                            size: 14,
                            weight: FontWeight.w400,
                          ),
                        ],
                      );
                    },
                  ),
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
                        await futureSaveTreatmentsList();
                      },
                      onAdd: (value) {
                        treatmentList.add(Meditation(value, false));
                        // setState(() {
                        //
                        // });
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
            ),
            SizedBox(
              height: h(context, 10),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Schedule treatment',
                    size: 16,
                    weight: FontWeight.w400,
                    color: kTertiaryColor,
                  ),
                  SizedBox(
                    width: w(context, 12),
                  ),
                  Icon(
                    Icons.add,
                    color: kTertiaryColor,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Meditation {
  final String treatmentName;
  bool treated;

  Meditation(this.treatmentName, this.treated);

  // Convert a Meditation object to a Map
  Map<String, dynamic> toJson() =>
      {
        'treatmentName': treatmentName,
        'treated': treated,
      };

  // Create a Meditation object from a Map
  factory Meditation.fromJson(Map<String, dynamic> json) {
    return Meditation(
      json['treatmentName'],
      json['treated'],
    );
  }
}
