import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_images.dart';
import '../../constants/app_styling.dart';
import 'common_image_view_widget.dart';

class CustomSearchBar extends StatelessWidget {
  final double width;
  final String hintText;
  final bool readOnly;
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const CustomSearchBar({
    Key? key,
    this.width = 500,
    this.hintText = 'Search for Apiary', this.controller, this.onChanged, this.onTap, this.readOnly = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(context, width),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(h(context, 8)),
        border: Border.all(
          color: const Color(0xffD5D5D5),
          width: 1,
        ),
      ),
      child: Padding(
        padding: symmetric(
          context,
          horizontal: 14,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: TextFormField(
                  onTap: onTap,
                  readOnly: readOnly,
                  onChanged: onChanged,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    hintStyle: const TextStyle(
                      color: Color(0xff9D9D9D),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: w(context, 10),
            ),
            CommonImageView(
              imagePath: Assets.imagesSearch,
              fit: BoxFit.contain,
              height: h(context, 20),
              width: w(context, 20),
            ),
          ],
        ),
      ),
    );
  }
}
