import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_divider_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';

class CustomChatTile extends StatelessWidget {
  final String name;
  final String message;
  final String imageUrl;
  final int total;
  final void Function()? onTap;

  const CustomChatTile({
    Key? key,
    this.onTap,
    required this.name,
    required this.message,
    required this.imageUrl,
    required this.total,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonImageView(
                url: imageUrl,
                fit: BoxFit.contain,
                height: 60,
                width: 60,
              ),
              SizedBox(
                width: w(context, 12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: h(context, 5),
                  ),
                  CustomText(
                    text: name,
                    size: 14,
                    weight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: h(context, 15),
                  ),
                  CustomText(
                    text: message,
                  ),
                ],
              ),
              const Spacer(),


              // Container(
              //   height: h(context, 20),
              //   width: w(context, 20),
              //   decoration: BoxDecoration(
              //     color: kTertiaryColor,
              //     borderRadius: BorderRadius.circular(
              //       h(context, 30),
              //     ),
              //   ),
              //   child: Center(
              //     child: CustomText(
              //       text: total.toString(),
              //       color: kSecondaryColor,
              //     ),
              //   ),
              // )
            ],
          ),
        ),
        CustomDivider(
          color: kGreyColor,
          thickness: 0.5,
        ),
      ],
    );
  }
}
