import 'dart:convert';
import 'dart:developer';

import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/constants/shared_pref_keys.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/pest_management_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/services/add_hive_data_service.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/view/screens/hive/hive-data-collection/checkbox_new_option.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_images.dart';
import '../../../../core/utils/utils.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/common_image_view_widget.dart';

class PestManagement extends StatefulWidget {
  final HiveModel hiveModel;

  const PestManagement({super.key, required this.hiveModel});

  @override
  State<PestManagement> createState() => _PestManagementState();
}

class _PestManagementState extends State<PestManagement> {
  RxList<ManagePests> managePests = [
    ManagePests(pestName: 'Screened bottom board', isFound: false),
    ManagePests(pestName: 'Small hive beetle traps', isFound: false),
    ManagePests(pestName: 'Drone cell foundation', isFound: false),
  ].obs;


  List<String> selectedPests = [];

  loadPestsFromLocal() async {
    log("loadPestsFromLocal");
    List? localList = await AddHiveDataService.instance
        .loadLocalList(prefsKey: SharedPrefKeys.hivePestsManage);
    if (localList != null) {
      managePests.value = localList
          .map((pest) => ManagePests.fromJson(jsonDecode(pest)))
          .toList();
    }
  }

  saveFoundPests() async {
    PestManagementModel pestManagementModel = PestManagementModel(
        pests: selectedPests,
        pestsId: '',
        hiveId: widget.hiveModel.hiveId,
        apiaryId: widget.hiveModel.apiaryId,
        createdDate: DateTime.now());

    bool isDocAdded = await FirebaseCRUDServices.instance.saveHiveData(
        hiveId: widget.hiveModel.hiveId,
        data: pestManagementModel.toMap(),
        docIdName: 'pestsId',
        subCollectionName: FirebaseConstants.hivePestsCollection);

    if (isDocAdded) {
      Get
          .find<HiveDataController>()
          .hivePestsModels
          .add(pestManagementModel);
      CustomSnackBars.instance.showSuccessSnackbar(
          title: "Success", message: "Pests Added Successfully");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadPestsFromLocal();
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
              await saveFoundPests();
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
              text: 'Integrated Pest Management',
              size: 14,
              weight: FontWeight.w600,
            ),
            SizedBox(
              height: h(context, 8),
            ),
            CustomText(
              text: 'Select the items used ',
              size: 14,
              weight: FontWeight.w400,
            ),
            SizedBox(
              height: h(context, 6),
            ),
            Obx(
                  () =>
                  ListView.builder(
                      itemCount: managePests.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) =>
                          Row(
                            children: [
                              Checkbox(
                                  activeColor: kTertiaryColor,
                                  value: managePests[index].isFound,
                                  onChanged: (value) {
                                    setState(() {
                                      managePests[index].isFound = value!;
                                    });
                                    if (selectedPests.contains(
                                        managePests[index].pestName)) {
                                      selectedPests.remove(
                                          managePests[index].pestName);
                                    }
                                    else {
                                      selectedPests.add(
                                          managePests[index].pestName);
                                    }
                                  }),
                              CustomText(
                                text: managePests[index].pestName,
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
                            optionsList: managePests,
                            prefsKey: SharedPrefKeys.hivePestsManage);
                      },
                      onAdd: (value) {
                        managePests
                            .add(ManagePests(pestName: value, isFound: false));
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
      ),
    );
  }
}

class ManagePests {
  final String pestName;
  bool isFound;

  ManagePests({required this.pestName, required this.isFound});

  Map<String, dynamic> toJson() => {'pestName': pestName, 'isFound': isFound};

  factory ManagePests.fromJson(Map<String, dynamic> json) {
    return ManagePests(isFound: json['isFound'], pestName: json['pestName']);
  }
}
