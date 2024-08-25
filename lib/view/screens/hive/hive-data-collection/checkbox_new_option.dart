import 'package:beekeep/view/widget/Custom_Textfield_widget.dart';
import 'package:flutter/material.dart';

import '../../../../constants/app_colors.dart';
import '../../../../constants/app_styling.dart';
import '../../../widget/Custom_button_widget.dart';
import '../../../widget/Custom_text_widget.dart';

class CheckboxNewOption extends StatefulWidget {
  final bool? futureUse;
  final void Function(String value)? onAdd;
  final void Function()? onFutureClicked;
  const CheckboxNewOption({super.key, this.onAdd, this.futureUse=false, this.onFutureClicked});

  @override
  State<CheckboxNewOption> createState() => _CheckboxNewOptionState();
}

class _CheckboxNewOptionState extends State<CheckboxNewOption> {
  late  bool futureUse;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    futureUse = widget.futureUse!;
  }

  TextEditingController optionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
            text: 'Option Name',
            size: 14,
            weight: FontWeight.w400,
          ),
          SizedBox(
            height: h(context, 8),
          ),
          CustomTextField2(hintText: 'Enter option name',
          controller: optionController,),
          Row(
            children: [
              Checkbox(
                  activeColor: kTertiaryColor,
                  value: futureUse,
                  onChanged: (value) {
                    setState(() {
                      futureUse = value!;
                    });

                  }),
              CustomText(
                text: 'Use this option for future',
                size: 14,
                weight: FontWeight.w400,
              ),
            ],
          ),
          SizedBox(
            height: h(context, 8),
          ),
          CustomButton(
            borderRadius: 8,
            buttonText: "Add option",
            onTap: (){
              widget.onAdd!(optionController.text);
              print("Future Saved =  $futureUse ");
              if(futureUse){
                print("FutureSaved Called");
                widget.onFutureClicked!();
              }
            }
          ),
        ],
      ),
    );
  }
}
