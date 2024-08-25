import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_images.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/models/apiary_model.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/models/nucModels/nuc_model.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:beekeep/view/widget/common_image_view_widget.dart';
import 'package:dotted_dashed_line/dotted_dashed_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../screens/qr_code_page/qr_code_page.dart';
import 'my_text_widget.dart';

class CustomHiveWidget extends StatelessWidget {
  final HiveModel? hiveModel;
  final NucModel? nucModel;
  final ApiaryModel? apiaryModel;
  final bool isContainMenu;
  const CustomHiveWidget({super.key, this.hiveModel, this.apiaryModel, this.nucModel,this.isContainMenu=false});

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(h(context, 10))),
      child: Padding(
        padding: symmetric(context, vertical: 8, horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CommonImageView(
                  height: 52,
                  width: 58,
                  radius: 100,
                  url: nucModel!=null?nucModel!.imageUrl:hiveModel!.hiveImage,
                ),
                Spacer(),
                if(isContainMenu)
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
                              Get.to(() => QRCodePage(
                                hiveModel: hiveModel!,
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
                    ))
              ],
            ),
            SizedBox(
              height: h(context, 9),
            ),
            Row(
              children: [
                CustomText(
                  text: nucModel!=null?nucModel!.nucName:hiveModel?.hiveName??'Hive 1 SA, CA',
                  size: 16,
                  weight: FontWeight.w600,
                ),
                SizedBox(
                  width: w(context, 6),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: kTertiaryColor.withOpacity(0.11),
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: symmetric(context, horizontal: 13, vertical: 4),
                    child: CustomText(
                      text: '124567',
                      size: 12,
                      weight: FontWeight.w400,
                      color: kTertiaryColor,
                    ),
                  ),
                ),
                SizedBox(
                  width: w(context, 6),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Color(0xff019750).withOpacity(0.11),
                      borderRadius: BorderRadius.circular(4)),
                  child: Padding(
                    padding: symmetric(context, horizontal: 13, vertical: 4),
                    child: CustomText(
                      text: nucModel!=null?nucModel!.condition:hiveModel?.condition??'Healthy',
                      size: 12,
                      weight: FontWeight.w400,
                      color: Color(0xff019750),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: h(context, 9),
            ),
            CustomText(
              text: nucModel!=null?nucModel!.nucLocation:hiveModel?.location??'San Francisco, California',
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 9),
            ),
            CustomText(
              text: '${nucModel!=null?nucModel!.honeySupers:hiveModel?.honeySuper??'10' } Frames',
              size: 12,
              weight: FontWeight.w400,
              color: kGreyColor,
            ),
            SizedBox(
              height: h(context, 5),
            ),
            if(nucModel!=null)
                Row(

                  children: List.generate(nucModel!.tags.length, (index) =>
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: kTertiaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: symmetric(context, horizontal: 6, vertical: 6),
                          child: CustomText(
                            text: nucModel!.tags[index],
                            size: 10,
                            weight: FontWeight.w400,
                            color: kFullBlackBgColor,
                          ),
                        ),
                      ),)

                ),

            if(hiveModel!=null)
              Row(

                  children: List.generate(hiveModel!.tags.length, (index) =>
                      Container(
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                            color: kTertiaryColor.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(4)),
                        child: Padding(
                          padding: symmetric(context, horizontal: 6, vertical: 6),
                          child: CustomText(
                            text: hiveModel!.tags[index],
                            size: 10,
                            weight: FontWeight.w400,
                            color: kFullBlackBgColor,
                          ),
                        ),
                      ),)

              ),

            SizedBox(
              height: h(context, 10),
            ),
            DottedDashedLine(
              height: 1,
              width: double.maxFinite,
              axis: Axis.horizontal,
              dashColor: kTertiaryColor,
            ),
            SizedBox(
              height: h(context, 10),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        CommonImageView(
                          width: 20,
                          height: 20,
                          fit: BoxFit.contain,
                          imagePath: Assets.imagesTemperature,
                        ),
                        SizedBox(
                          width: w(context, 6),
                        ),
                        CustomText(
                          text: 'Temperature',
                          size: 12,
                          weight: FontWeight.w400,
                          color: kFullBlackBgColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h(context, 8),
                    ),
                    CustomText(
                      text: nucModel!=null?nucModel!.temperature:hiveModel?.temperature??'25',
                      size: 14,
                      weight: FontWeight.w600,
                      color: kFullBlackBgColor,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        CommonImageView(
                          width: 20,
                          height: 20,
                          imagePath: Assets.imagesApiary,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          width: w(context, 6),
                        ),
                        CustomText(
                          text: 'Apiary',
                          size: 12,
                          weight: FontWeight.w400,
                          color: kFullBlackBgColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h(context, 8),
                    ),
                    CustomText(
                      text: apiaryModel?.apiaryName??'Apiary 12',
                      size: 14,
                      weight: FontWeight.w600,
                      color: kFullBlackBgColor,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        CommonImageView(
                          width: 20,
                          height: 20,
                          imagePath: Assets.imagesHumidity,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(
                          width: w(context, 6),
                        ),
                        CustomText(
                          text: 'Humidity',
                          size: 12,
                          weight: FontWeight.w400,
                          color: kFullBlackBgColor,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: h(context, 8),
                    ),
                    CustomText(
                      text: '${hiveModel?.humidity??'50'} %',
                      size: 14,
                      weight: FontWeight.w600,
                      color: kFullBlackBgColor,
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
