import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/honey_extraction_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/view/widget/Custom_Textfield_widget.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_images.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/common_image_view_widget.dart';

class HoneyExtraction extends StatefulWidget {
  final HiveModel hiveModel;

  const HoneyExtraction({super.key, required this.hiveModel});

  @override
  State<HoneyExtraction> createState() => _HoneyExtractionState();
}

class _HoneyExtractionState extends State<HoneyExtraction> {
  TextEditingController unitController = TextEditingController();
  double supersQuantity = 1;
  String honeyunit = 'KG';

  saveHoneyExtraction() async {
    HoneyExtractedModel model = HoneyExtractedModel(
        honeyQuantity: supersQuantity.toString(),
        honeyExtracted: '${unitController.text} $honeyunit',
        honeyExtractionId: '',
        hiveId: widget.hiveModel.hiveId,
        apiaryId: widget.hiveModel.apiaryId,
        createdDate: DateTime.now());

    bool isDocAdded = await FirebaseCRUDServices.instance.saveHiveData(
        hiveId: widget.hiveModel.hiveId,
        data: model.toMap(),
        docIdName: 'honeyExtractionId',
        subCollectionName: FirebaseConstants.hiveHoneyExtractionCollection);

    if (isDocAdded) {
      Get.find<HiveDataController>().hiveHoneyModels.add(model);
      CustomSnackBars.instance
          .showSuccessSnackbar(title: "Success", message: "Added Successfully");
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
              await saveHoneyExtraction();
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
              text: 'Honey Removal and Extraction',
              size: 14,
              weight: FontWeight.w600,
            ),
            SizedBox(
              height: h(context, 10),
            ),
            CustomText(
              text: 'Select the quantity of Supers removed or extracted.',
              size: 14,
              weight: FontWeight.w400,
            ),
            SizedBox(
              height: h(context, 10),
            ),
            Padding(
              padding: only(context, top: 6),
              child: Slider(
                thumbColor: kTertiaryColor,
                secondaryActiveColor: kTertiaryColor,
                activeColor: kTertiaryColor,
                value: supersQuantity,
                max: 10,
                divisions: 10,
                label: supersQuantity.round().toString(),
                onChanged: (double value) {
                  setState(() {
                    supersQuantity = value;
                  });
                },
              ),
            ),
            SizedBox(
              height: h(context, 10),
            ),
            CustomText(
              text: 'How much honey was extracted from hive',
              size: 14,
              weight: FontWeight.w400,
            ),
            SizedBox(
              height: h(context, 8),
            ),
            Row(
              children: [
                Expanded(
                    child:
                        CustomTextField2(
                          keyboardType: TextInputType.number,
                            controller: unitController,
                            hintText: supersQuantity.toString())),
                SizedBox(
                  width: w(context, 15),
                ),
                MultipleSelectionDropdown(
                    height: 50, width: w(context, 80), radius: h(context, 8))
              ],
            )
          ],
        ),
      ),
    );
  }
}

class MultipleSelectionDropdown extends StatefulWidget {
  final double height, width;
  final double radius;
  final Color background;
  final bool disableBorder;

  const MultipleSelectionDropdown({
    super.key,
    required this.height,
    required this.width,
    required this.radius,
    this.disableBorder = false,
    this.background = Colors.transparent,
  });

  @override
  // ignore: library_private_types_in_public_api
  _MultipleSelectionDropdownState createState() =>
      _MultipleSelectionDropdownState();
}

class _MultipleSelectionDropdownState extends State<MultipleSelectionDropdown> {
  String dropdownValue = unitsList.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(context, widget.width),
      height: h(context, widget.height),
      decoration: BoxDecoration(
        color: widget.background,
        border: widget.disableBorder ? null : Border.all(color: kGreyColor),
        borderRadius: BorderRadius.circular(
          h(context, widget.radius),
        ),
      ),
      child: Center(
        child: DropdownButton<String>(
          underline: Container(
            color: Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(
            h(context, widget.radius),
          ),
          dropdownColor: kSecondaryColor,
          isDense: true,
          value: dropdownValue,
          icon: const Icon(Icons.expand_more),
          elevation: 8,
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
              dropdownValue = value!;
            });
          },
          items: unitsList.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value.toString()),
            );
          }).toList(),
        ),
      ),
    );
  }
}

List<String> unitsList = ['Kg', 'lbs'];
