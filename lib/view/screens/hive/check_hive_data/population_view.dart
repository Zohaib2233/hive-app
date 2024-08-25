import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/controllers/hive_data_controller/hive_data_controller.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/view/widget/Custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckPopulation extends StatefulWidget {
  const CheckPopulation({super.key});

  @override
  State<CheckPopulation> createState() => _CheckPopulationState();
}

class _CheckPopulationState extends State<CheckPopulation> {
  @override
  Widget build(BuildContext context) {
    HiveDataController controller = Get.find();
    return Padding(
      padding: symmetric(context, vertical: 20),
      child: Obx(()=>controller.hivePopulationModels.isEmpty?Container(): SizedBox(
             // height: Get.height - 560,
        height: double.maxFinite,
          child: ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,



            itemCount: controller.hivePopulationModels.length,
            itemBuilder: (context, index) => PopulationWidget(
                populationScore: controller.hivePopulationModels[index].populationValue,
                population: controller.hivePopulationModels[index].population,
                dateTime: controller.hivePopulationModels[index].createdDate),
          ),
        ),
      ),
    );
  }
}

class PopulationWidget extends StatelessWidget {
  const PopulationWidget(
      {super.key,
      required this.populationScore,
      required this.population,
      required this.dateTime});

  final String population;
  final String populationScore;
  final DateTime dateTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          text: Utils.formatDateTime(dateTime),
          size: 10,
          weight: FontWeight.w400,
          color: kFullBlackBgColor,
        ),
        Card(
          elevation: 5,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(h(context, 7))),
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
                          text: 'Population Point',
                          size: 10,
                          weight: FontWeight.w400,
                          color: kFullBlackBgColor,
                        ),
                        Spacer(),
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
                      text: populationScore.toString(),
                      size: 14,
                      weight: FontWeight.w600,
                      color: kFullBlackBgColor,
                    ),
                    SizedBox(
                      height: h(context, 8),
                    ),
                    CustomText(
                      text: 'Population',
                      size: 10,
                      weight: FontWeight.w400,
                      color: kFullBlackBgColor,
                    ),
                    SizedBox(
                      height: h(context, 6),
                    ),
                    CustomText(
                      text: population.toString(),
                      size: 14,
                      weight: FontWeight.w600,
                      color: kFullBlackBgColor,
                    ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}
