import 'package:beekeep/core/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_styling.dart';
import '../../../../controllers/hive_data_controller/hive_data_controller.dart';
import '../../../../models/hiveModels/hive_data_models/behaviour_model.dart';
import '../../../widget/Custom_text_widget.dart';
import 'custom_small_images_widget.dart';

class CheckBehavior extends StatefulWidget {
  const CheckBehavior({super.key});

  @override
  State<CheckBehavior> createState() => _CheckBehaviorState();
}

class _CheckBehaviorState extends State<CheckBehavior> {
  var controller = Get.find<HiveDataController>();
  double behaviorValue = 0;
  String behavior = 'Calm';

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: symmetric(context, vertical: 20),
        child:Obx(()=>controller.hiveBehaviorModels.isEmpty?Container():Column(
            children: List.generate(controller.hiveBehaviorModels.length, (index){
              return BehaviorWidget(hiveBehaviorModel: controller.hiveBehaviorModels[index],);
            }).toList(),
          ),
        )

        );
  }
}

class BehaviorWidget extends StatelessWidget {
  const BehaviorWidget(
      {super.key, required this.hiveBehaviorModel});



  final HiveBehaviorModel hiveBehaviorModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: symmetric(context, horizontal: 10),
            child: CustomText(
              text: Utils.formatDateTime(hiveBehaviorModel.createdDate),
              size: 10,
              weight: FontWeight.w400,
              color: kFullBlackBgColor,
            ),
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
              height: h(context, 205),
              width: double.maxFinite,
              child: Padding(
                padding: symmetric(context, vertical: 10, horizontal: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            text: 'Honey Bee Behavior',
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
                        text: hiveBehaviorModel.behavior,
                        size: 14,
                        weight: FontWeight.w600,
                        color: kFullBlackBgColor,
                      ),
                      SizedBox(
                        height: h(context, 8),
                      ),
                      CustomText(
                        text: 'Behavior Points',
                        size: 10,
                        weight: FontWeight.w400,
                        color: kFullBlackBgColor,
                      ),
                      SizedBox(
                        height: h(context, 6),
                      ),
                      CustomText(
                        text: hiveBehaviorModel.behaviorPoints,
                        size: 14,
                        weight: FontWeight.w600,
                        color: kFullBlackBgColor,
                      ),
                      SizedBox(
                        height: h(context, 8),
                      ),
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
                            CustomSmallImageWidget(imgUrl: hiveBehaviorModel.image,),
                          ],
                        ),
                      )
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
