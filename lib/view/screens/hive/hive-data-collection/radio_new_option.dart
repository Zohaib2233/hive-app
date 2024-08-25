import 'package:beekeep/view/widget/Custom_Textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_styling.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/Custom_text_widget.dart';

class RadioButtonNewOption extends StatefulWidget {
  const RadioButtonNewOption({Key? key}) : super(key: key);

  @override
  State<RadioButtonNewOption> createState() => _RadioButtonNewOptionState();
}

class _RadioButtonNewOptionState extends State<RadioButtonNewOption> {
  bool futureUse = true;
  int subOptions = 3;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: AlertDialog(

        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Center(
          child: CustomText(
            text: 'Create New Option',
            size: 16,
            weight: FontWeight.w600,
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              text: 'Option name',
              size: 14,
              weight: FontWeight.w400,
            ),
            SizedBox(height: h(context, 8)),
            CustomTextField2(hintText: 'Enter option name'),
            _buildOptionList(),
            SizedBox(height: h(context, 8)),
            _buildAddSubtractButtons(),
            SizedBox(height: h(context, 8)),
            _buildFutureUseCheckbox(),
            SizedBox(height: h(context, 8)),
            _buildAddOptionButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionList() {
    return SizedBox(
      height: h(context, 250),
      width: w(context, 400),
      child: ListView.builder(
        shrinkWrap: false,
        itemCount: subOptions,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                text: 'Sub-option ${index+1} Name',
                size: 14,
                weight: FontWeight.w400,
              ),
              SizedBox(height: h(context, 8)),
              CustomTextField2(hintText: 'Enter option name'),
              SizedBox(height: h(context, 8)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildAddSubtractButtons() {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              subOptions = subOptions + 1;
            });
          },
          child: Row(
            children: [
              CustomText(
                text: 'Add',
                size: 14,
                weight: FontWeight.w400,
                color: kTertiaryColor,
              ),
              SizedBox(width: w(context, 8)),
              Icon(
                Icons.add,
                size: h(context, 18),
                color: kTertiaryColor,
              )
            ],
          ),
        ),
        SizedBox(width: w(context, 16)),
        GestureDetector(
          onTap: () {
            setState(() {
              if (subOptions > 0) {
                subOptions = subOptions - 1;
              }
            });
          },
          child: Row(
            children: [
              CustomText(
                text: 'Subtract',
                size: 14,
                weight: FontWeight.w400,
                color: kTertiaryColor,
              ),
              SizedBox(width: w(context, 8)),
              Icon(
                Icons.remove,
                size: h(context, 18),
                color: kTertiaryColor,
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFutureUseCheckbox() {
    return Row(
      children: [
        Checkbox(
          activeColor: kTertiaryColor,
          value: futureUse,
          onChanged: (value) {
            setState(() {
              futureUse = value ?? false;
            });
          },
        ),
        CustomText(
          text: 'Use this option for future',
          size: 14,
          weight: FontWeight.w400,
        ),
      ],
    );
  }

  Widget _buildAddOptionButton() {
    return CustomButton(
      borderRadius: 8,
      buttonText: "Add option",
      onTap: () {
        Get.back();
      },
    );
  }
}
