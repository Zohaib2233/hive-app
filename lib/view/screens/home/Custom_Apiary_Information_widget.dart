// ignore_for_file: prefer_const_constructors

import 'package:beekeep/core/bindings/bindings.dart';
import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/models/apiary_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/view/screens/bottombar/bottombar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../../core/utils/utils.dart';
import '../../widget/common_image_view_widget.dart';
import '../../widget/custom_text_widget.dart';
import '../../widget/my_text_widget.dart';

class ApiaryInformationWidget extends StatelessWidget {
  final ApiaryModel? apiaryModel;
  final bool isApiaryDetail;
  final String id;
  final String hives;
  final String location;
  final String status;
  final String weather;

  ApiaryInformationWidget({
    this.id = "147895",
    this.isApiaryDetail = false,
    this.hives = "10",
    this.location = "San Francisco, California",
    this.status = "Mixed",
    this.weather = "Sunny",
    Key? key,
    this.apiaryModel,
  }) : super(key: key);

  List<String> _images = [
    'https://images.unsplash.com/photo-1593642532842-98d0fd5ebc1a?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=2250&q=80',
    'https://images.unsplash.com/photo-1612594305265-86300a9a5b5b?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1000&q=80',
    'https://images.unsplash.com/photo-1612626256634-991e6e977fc1?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1712&q=80',
    'https://images.unsplash.com/photo-1593642702749-b7d2a804fbcf?ixid=MXwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=1400&q=80'
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      width: w(context, 500),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(
          h(context, 10),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: all(context, 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CommonImageView(
                  imagePath: Assets.imagesApiary1,
                  fit: BoxFit.contain,
                  height: 54,
                  width: 62,
                ),
                SizedBox(
                  width: w(context, 9),
                ),
                Padding(
                  padding: only(context, top: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomText(
                            text: apiaryModel?.apiaryName.capitalize ??
                                "Apiary 12",
                            size: 16,
                            weight: FontWeight.w600,
                          )
                        ],
                      ),
                      SizedBox(
                        height: h(context, 10),
                      ),
                      Row(
                        children: [
                          CustomText(
                            text: "ID:",
                            size: 14,
                            color: kTertiaryColor,
                          ),
                          SizedBox(
                            width: w(context, 4),
                          ),
                          CustomText(
                            text: id,
                            size: 14,
                          ),
                          SizedBox(
                            width: w(context, 25),
                          ),
                          CommonImageView(
                            imagePath: Assets.imagesMixed,
                            fit: BoxFit.contain,
                            height: 14,
                            width: 14,
                          ),
                          SizedBox(
                            width: w(context, 4),
                          ),
                          CustomText(
                            text: apiaryModel?.locationType ?? "Mixed",
                            size: 14,
                          ),
                          SizedBox(
                            width: w(context, 25),
                          ),
                          CommonImageView(
                            imagePath: Assets.imagesSunny,
                            fit: BoxFit.contain,
                            height: 14,
                            width: 14,
                          ),
                          SizedBox(
                            width: w(context, 4),
                          ),
                          CustomText(
                            text: apiaryModel?.sunExposer ?? "Sunny",
                            size: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Padding(
                    padding: only(context, right: 0),
                    child: PopupMenuButton(
                      padding: EdgeInsets.zero,
                      icon: CommonImageView(
                        imagePath: Assets.imagesSetting3,
                        height: 20,
                        width: 20,
                      ),
                      itemBuilder: (BuildContext context) => [
                        PopupMenuItem(
                            onTap: () {
                              Utils.showLogoutDialog(
                                  titleText: "Delete Apiary",
                                  middleText: "Do You want to delete Apiary?",
                                  onConfirm: () async {
                                    Get.back();

                                    Utils.showProgressDialog(context: context);
                                    bool isDeleted = await FirebaseCRUDServices
                                        .instance
                                        .deleteDocument(
                                            collectionPath: FirebaseConstants
                                                .apiariesCollection,
                                            docId: apiaryModel!.apiaryId);
                                    if (isDeleted) {

                                      Get.back();
                                      CustomSnackBars.instance
                                          .showSuccessSnackbar(
                                          title: "Success",
                                          message:
                                          "Apiary Deleted Successfully");
                                      if(isApiaryDetail){
                                        Get.offAll(()=>BottomNavBar(),binding: HomeBindings());
                                      }


                                    }
                                    else{
                                      Utils.hideProgressDialog(context: context);
                                      Get.back();
                                    }
                                  },
                                  onCancel: () {
                                    Get.back();
                                  });
                            },
                            padding: EdgeInsets.zero,
                            value: 6,
                            // row has two child icon and text.
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                MyText(
                                  paddingLeft: 10,
                                  text: 'Delete Apiary',
                                  size: 12,
                                  weight: FontWeight.w400,
                                  color: Colors.red,
                                ),
                              ],
                            )),
                      ],
                    ))
              ],
            ),
          ),
          DottedLine(
            direction: Axis.horizontal,
            alignment: WrapAlignment.center,
            lineLength: double.infinity,
            lineThickness: 1.0,
            dashLength: 4.0,
            dashColor: kTertiaryColor,
            dashRadius: 0.0,
            dashGapLength: 4.0,
            dashGapColor: kSecondaryColor,
            dashGapRadius: 0.0,
          ),
          Padding(
            padding: all(context, 13),
            child: Row(
              children: [
                SizedBox(
                  width: w(context, 5),
                ),
                CommonImageView(
                  imagePath: Assets.imagesMembers,
                  fit: BoxFit.contain,
                  height: 18,
                  width: 25,
                ),
                SizedBox(
                  width: w(context, 5),
                ),
                FlutterImageStack(
                  imageList: _images,
                  showTotalCount: false,
                  totalCount: 4,
                  itemRadius: 18,
                  itemBorderWidth: 3,
                ),
                SizedBox(
                  width: w(context, 15),
                ),
                CommonImageView(
                  imagePath: Assets.imagesHives,
                  fit: BoxFit.contain,
                  height: 18,
                  width: 25,
                ),
                SizedBox(
                  width: w(context, 5),
                ),
                CustomText(text: "${apiaryModel?.hives} Hives"),
                SizedBox(
                  width: w(context, 15),
                ),
                CommonImageView(
                  imagePath: Assets.imagesLocation,
                  fit: BoxFit.contain,
                  height: 18,
                  width: 25,
                ),
                SizedBox(
                  width: w(context, 10),
                ),
                Expanded(
                  child: CustomText(text: apiaryModel?.location ?? location),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
