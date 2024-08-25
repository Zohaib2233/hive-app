import 'package:beekeep/models/apiary_model.dart';
import 'package:beekeep/view/screens/apiary/apiary_details.dart';
import 'package:beekeep/view/screens/qr_code_page/qr_code_page.dart';
import 'package:beekeep/view/widget/my_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../../models/hiveModels/hive_model.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import '../../widget/custom_hive_widget.dart';
import '../../widget/custom_scroll_view_effect_widget.dart';
import 'check_hive_data/behavior_view.dart';
import 'check_hive_data/brood_pattern_view.dart';
import 'check_hive_data/development_view.dart';
import 'check_hive_data/disease_view.dart';
import 'check_hive_data/eggs_view.dart';
import 'check_hive_data/hive_condition_view.dart';
import 'check_hive_data/honey_extraction_view.dart';
import 'check_hive_data/honey_flow_prep_view.dart';
import 'check_hive_data/pest_management_view.dart';
import 'check_hive_data/population_view.dart';
import 'check_hive_data/queen_cells_view.dart';
import 'check_hive_data/queen_view.dart';
import 'check_hive_data/spring_feeding_view.dart';
import 'check_hive_data/spring_inspection_view.dart';
import 'check_hive_data/treatment_view.dart';
import 'hive-data-collection/behavior.dart';
import 'hive-data-collection/brood_pattern.dart';
import 'hive-data-collection/development.dart';
import 'hive-data-collection/disease.dart';
import 'hive-data-collection/eggs.dart';
import 'hive-data-collection/hive_condition.dart';
import 'hive-data-collection/honey_extraction.dart';
import 'hive-data-collection/honey_flow_prep.dart';
import 'hive-data-collection/pest_management.dart';
import 'hive-data-collection/population.dart';
import 'hive-data-collection/queen.dart';
import 'hive-data-collection/queen_cells.dart';
import 'hive-data-collection/spring_feeding.dart';
import 'hive-data-collection/spring_inspection.dart';
import 'hive-data-collection/treatment.dart';

class CheckHiveDataView extends StatefulWidget {
  final bool isResultScreen;
  final HiveModel hiveModel;
  final ApiaryModel apiaryModel;

  const CheckHiveDataView(
      {super.key, required this.hiveModel, required this.apiaryModel, this.isResultScreen = false});

  @override
  State<CheckHiveDataView> createState() => _CheckHiveDataViewState();
}

class _CheckHiveDataViewState extends State<CheckHiveDataView> {
  String selectedIndex = 'Behavior';

  final List<String> menuItems = [
    'Behavior',
    'Queen',
    'Brood Pattern',
    'Eggs',
    'Development',
    'Population',
    'Queen Cells',
    'Disease/Pests',
    'Treatment',
    'Pest Management',
    'Spring Inspection',
    'Spring Feeding',
    'Honey Flow Preps',
    'Hive Conditions',
    'Honey Extraction'
  ];

  void updateMenu(String value) {
    setState(() {
      selectedIndex = value;
    });
  }

  void navigateToSelectedScreen() {
    switch (selectedIndex) {
      case 'Behavior':
        Get.to(() => Behavior(
              hiveModel: widget.hiveModel,
            ));
        break;
      case 'Queen':
        Get.to(() => Queen(
              hiveModel: widget.hiveModel,
            ));
        break;
      case 'Brood Pattern':
        Get.to(() => BroodPattern(hiveModel: widget.hiveModel));
        break;
      case 'Eggs':
        Get.to(() => Eggs(
              hiveModel: widget.hiveModel,
            ));
        break;
      case 'Development':
        Get.to(() => Development(
              hiveModel: widget.hiveModel,
            ));
        break;
      case 'Population':
        Get.to(() => Population(hiveModel: widget.hiveModel));
        break;
      case 'Queen Cells':
        Get.to(() => QueenCells(
              hiveModel: widget.hiveModel,
            ));
        break;
      case 'Disease/Pests':
        Get.to(() => Disease(
              hiveModel: widget.hiveModel,
            ));
        break;
      case 'Treatment':
        Get.to(() => Treatment(
              hiveModel: widget.hiveModel,
            ));
        break;
      case 'Pest Management':
        Get.to(() => PestManagement(hiveModel: widget.hiveModel));
        break;
      case 'Spring Inspection':
        Get.to(() => SpringInspection(hiveModel: widget.hiveModel));
        break;
      case 'Spring Feeding':
        Get.to(() => SpringFeeding(hiveModel: widget.hiveModel));
        break;
      case 'Honey Flow Preps':
        Get.to(() => HoneyFlowPreps(hiveModel: widget.hiveModel));
        break;
      case 'Hive Conditions':
        Get.to(() => HiveCondition(hiveModel: widget.hiveModel));
        break;
      case 'Honey Extraction':
        Get.to(() => HoneyExtraction(hiveModel: widget.hiveModel));
        break;
      default:
        Get.to(() => Behavior(
              hiveModel: widget.hiveModel,
            ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:

      widget.isResultScreen==false?Padding(
        padding: only(context, bottom: 20, right: 20, left: 20),
        child: CustomButton(
          borderRadius: 8,
          buttonText: "Add",
          onTap: navigateToSelectedScreen,
        ),
      ):SizedBox.shrink(),
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
          widget.isResultScreen==false?Padding(
              padding: only(context, right: 15),
              child: PopupMenuButton(
                padding: EdgeInsets.zero,
                icon: CommonImageView(
                  imagePath: Assets.imagesSetting3,
                  height: 24,
                  width: 24,
                ),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                      onTap: () {
                        Get.to(() => QRCodePage(
                              hiveModel: widget.hiveModel,
                            ));
                      },
                      padding: EdgeInsets.zero,
                      value: 1,
                      // row has two child icon and text.
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            paddingLeft: 10,
                            paddingBottom: 10,
                            text: 'QR Code',
                            size: 12,
                            weight: FontWeight.w400,
                          ),
                          Divider(
                            thickness: 1,
                            color: kBlackColor.withOpacity(0.4),
                            height: 2,
                          )
                        ],
                      )),
                  PopupMenuItem(
                      onTap: () {},
                      padding: EdgeInsets.zero,
                      value: 2,
                      // row has two child icon and text.
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            paddingLeft: 10,
                            paddingBottom: 10,
                            text: 'Show Tasks',
                            size: 12,
                            weight: FontWeight.w400,
                          ),
                          Divider(
                            thickness: 1,
                            color: kBlackColor.withOpacity(0.4),
                            height: 2,
                          )
                        ],
                      )),
                  // PopupMenuItem(
                  //     onTap: () {},
                  //     padding: EdgeInsets.zero,
                  //     value: 3,
                  //     // row has two child icon and text.
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         MyText(
                  //           paddingLeft: 10,
                  //           paddingBottom: 10,
                  //           text: 'Export',
                  //           size: 12,
                  //           weight: FontWeight.w400,
                  //         ),
                  //         Divider(
                  //           thickness: 1,
                  //           color: kBlackColor.withOpacity(0.4),
                  //           height: 2,
                  //         )
                  //       ],
                  //     )),
                  // PopupMenuItem(
                  //     onTap: () {},
                  //     padding: EdgeInsets.zero,
                  //     value: 4,
                  //     // row has two child icon and text.
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         MyText(
                  //           paddingLeft: 10,
                  //           paddingBottom: 10,
                  //           text: 'Download',
                  //           size: 12,
                  //           weight: FontWeight.w400,
                  //         ),
                  //         Divider(
                  //           thickness: 1,
                  //           color: kBlackColor.withOpacity(0.4),
                  //           height: 2,
                  //         )
                  //       ],
                  //     )),
                  PopupMenuItem(
                      onTap: () {},
                      padding: EdgeInsets.zero,
                      value: 5,
                      // row has two child icon and text.
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            paddingLeft: 10,
                            paddingBottom: 10,
                            text: 'Move',
                            size: 12,
                            weight: FontWeight.w400,
                          ),
                          Divider(
                            thickness: 1,
                            color: kBlackColor.withOpacity(0.4),
                            height: 2,
                          )
                        ],
                      )),
                  PopupMenuItem(
                      onTap: () {},
                      padding: EdgeInsets.zero,
                      value: 6,
                      // row has two child icon and text.
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MyText(
                            paddingLeft: 10,
                            text: 'Delete hive',
                            size: 12,
                            weight: FontWeight.w400,
                            color: Colors.red,
                          ),
                        ],
                      )),
                ],
              )):SizedBox.shrink()
        ],
      ),
      body: SpaceBetweenScrollView(
        footer: Container(),
        child: Padding(
          padding: symmetric(context, horizontal: 20, vertical: 10),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            CustomHiveWidget(
              hiveModel: widget.hiveModel,
              apiaryModel: widget.apiaryModel,
            ),
            SizedBox(
              height: h(context, 15),
            ),
            if(widget.isResultScreen==true)
            GestureDetector(
              onTap: (){
                Get.off(()=>ApiaryDetailsView(apiaryModel: widget.apiaryModel));
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyText(text: "Go to Parent Apiary",size: 12,weight: FontWeight.w400,),
                    Image.asset(Assets.imagesArrowRightGrey,height: 24,width: 24,)
                  ],
                ),
              ),
            ),
            SizedBox(
              height: h(context, 15),
            ),
            Container(
              color: Colors.white,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: symmetric(context, vertical: 4),
                  child: Row(
                    children: menuItems.map((item) {
                      return buildMenu(
                          title: item,
                          controller: selectedIndex,
                          onTap: updateMenu);
                    }).toList(),
                  ),
                ),
              ),
            ),
            if (selectedIndex == 'Behavior') const CheckBehavior(),
            if (selectedIndex == 'Queen') const CheckQueen(),
            if (selectedIndex == 'Brood Pattern') const CheckBroodPattern(),
            if (selectedIndex == 'Eggs') const CheckEggs(),
            if (selectedIndex == 'Development') const CheckDevelopment(),
            if (selectedIndex == 'Population') CheckPopulation(),
            if (selectedIndex == 'Queen Cells') const CheckQueenCells(),
            if (selectedIndex == 'Disease/Pests') const CheckDisease(),
            if (selectedIndex == 'Treatment') const CheckTreatment(),
            if (selectedIndex == 'Pest Management') const CheckPestManagement(),
            if (selectedIndex == 'Spring Inspection')
              const CheckSpringInspection(),
            if (selectedIndex == 'Spring Feeding') const CheckSpringFeeding(),
            if (selectedIndex == 'Honey Flow Preps')
              const CheckHoneyFlowPreps(),
            if (selectedIndex == 'Hive Conditions') const CheckHiveCondition(),
            if (selectedIndex == 'Honey Extraction')
              const CheckHoneyExtraction(),
          ]),
        ),
      ),
    );
  }

  Widget buildMenu({
    required String title,
    required String controller,
    required void Function(String value) onTap,
  }) {
    return GestureDetector(
      onTap: () {
        onTap(title);
      },
      child: Container(
        decoration: BoxDecoration(
          color: controller == title ? kTertiaryColor : Colors.white,
          borderRadius: BorderRadius.circular(h(context, 7)),
        ),
        child: Padding(
          padding: symmetric(context, vertical: 15, horizontal: 18),
          child: CustomText(
            text: title,
            color: controller == title ? Colors.white : kGreyColor,
            size: 12,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
