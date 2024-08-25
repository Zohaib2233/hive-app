import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/models/hiveModels/hive_data_models/queen_model.dart';
import 'package:beekeep/view/screens/hive/check_hive_data/custom_small_images_widget.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/hive_data_controller/hive_data_controller.dart';
import '../../../../core/utils/utils.dart';

class CheckQueen extends StatefulWidget {
  const CheckQueen({super.key});

  @override
  State<CheckQueen> createState() => _CheckQueenState();
}

class _CheckQueenState extends State<CheckQueen> {
  double behaviorValue = 0;
  String behavior = 'Calm';
  var controller = Get.find<HiveDataController>();
  @override
  Widget build(BuildContext context) {

    print("Hives Queen Model ${controller.hiveQueenModels.length}");
    return Padding(
      padding: symmetric(context, vertical: 20),
      child: Obx(()=>controller.hiveQueenModels.isEmpty?Container(

      ):Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(controller.hiveQueenModels.length, (index) {
            return QueenWidget(hiveQueenModel: controller.hiveQueenModels[index]);
          }),
        ),
      ),
    );
  }
}

class QueenWidget extends StatelessWidget {
  const QueenWidget(
      {super.key, required this.hiveQueenModel});

  final HiveQueenModel hiveQueenModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: Utils.formatDateTime(hiveQueenModel.createdDate),
          size: 10,
          weight: FontWeight.w400,
          color: kFullBlackBgColor,
        ),
        SizedBox(
          height: h(context, 10),
        ),
        Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(h(context, 7))),
            height: h(context, 240),
            width: double.maxFinite,
            child: Padding(
              padding: symmetric(context, vertical: 10, horizontal: 10),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomText(
                      text: 'Queen Spotted',
                      size: 10,
                      weight: FontWeight.w400,
                      color: kFullBlackBgColor,
                    ),
                    const Spacer(),
                    CustomText(
                      text: 'Edit',
                      size: 10,
                      weight: FontWeight.w400,
                      color: kTertiaryColor,
                    ),
                  ],
                ),
                SizedBox(
                  height: h(context, 6),
                ),
                CustomText(
                  text: hiveQueenModel.queenSpotted,
                  size: 14,
                  weight: FontWeight.w600,
                  color: kFullBlackBgColor,
                ),
                SizedBox(
                  height: h(context, 8),
                ),
                CustomText(
                  text: 'Queen Marked',
                  size: 10,
                  weight: FontWeight.w400,
                  color: kFullBlackBgColor,
                ),
                SizedBox(
                  height: h(context, 6),
                ),
                CustomText(
                  text: hiveQueenModel.queenMarked,
                  size: 14,
                  weight: FontWeight.w600,
                  color: kFullBlackBgColor,
                ),
                SizedBox(
                  height: h(context, 8),
                ),
                CustomText(text: "Queen Color",size: 10,),
              Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(int.parse(hiveQueenModel.color)),
                  ),),
                CustomText(
                  text: 'Images',
                  size: 10,
                  weight: FontWeight.w400,
                  color: kFullBlackBgColor,
                ),
                SizedBox(
                  height: h(context, 10),
                ),
              SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      CustomSmallImageWidget(imgUrl: hiveQueenModel.imgUrl,),

                    ],
                  ),
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
