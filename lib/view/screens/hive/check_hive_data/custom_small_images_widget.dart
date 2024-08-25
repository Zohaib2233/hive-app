import 'package:beekeep/constants/app_styling.dart';
import 'package:beekeep/core/utils/app_strings.dart';
import 'package:beekeep/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';

class CustomSmallImageWidget extends StatelessWidget {
  const CustomSmallImageWidget(
      {super.key, this.imgUrl});
  final String? imgUrl;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: symmetric(context, horizontal: 4),
      child: CommonImageView(
        width: 55,
        height: 55,
        url: imgUrl??dummyProfile,
        fit: BoxFit.cover,
      ),
    );
  }
}
