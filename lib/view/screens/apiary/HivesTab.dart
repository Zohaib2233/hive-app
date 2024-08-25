import 'package:flutter/material.dart';

import '../../../constants/app_styling.dart';

class HiveTab extends StatelessWidget {
  const HiveTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(
      //   shape: CircleBorder(),
      //   onPressed: () {
      //     Get.to(() => const ());
      //   },
      //   backgroundColor: kTertiaryColor,
      //   child: const Icon(
      //     Icons.add,
      //     color: kPrimaryColor,
      //   ),
      // ),
      body: Column(
        children: [
          // const CustomHiveWidget(),
          SizedBox(
            height: h(context, 15),
          ),
          // const CustomHiveWidget(),
          SizedBox(
            height: h(context, 15),
          ),
          // const CustomHiveWidget(),
        ],
      ),
    );
  }
}
