import 'package:beekeep/constants/app_colors.dart';
import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/core/bindings/bindings.dart';
import 'package:beekeep/view/screens/apiary/add_apiary_one_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ApiaryHomeView extends StatelessWidget {
  const ApiaryHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Column(
            children: [],
          )),
          Positioned(
              bottom: h(context, 36),
              right: w(context, 20),
              child: FloatingActionButton(
                onPressed: () {
                  Get.to(() => const AddApiaryPartOne(), binding: AddApiaryBinding());
                },
                child: Icon(
                  Icons.add,
                  color: kPrimaryColor,
                ),
                shape: CircleBorder(),
                backgroundColor: kTertiaryColor,
              )),
        ],
      ),
    );
  }
}
