import 'package:flutter/material.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styling.dart';
import 'Custom_text_widget.dart';

class CustomMultiSelectDropDown extends StatelessWidget {
  CustomMultiSelectDropDown(
      {super.key, this.height = 50, this.hint = "Select"});
  final double height;
  final String hint;

  final MultiSelectController _controller = MultiSelectController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: h(context, height),
      child: Theme(
        data: ThemeData(primaryColor: kPrimaryColor),
        child: MultiSelectDropDown(
          hint: hint,
          borderRadius: h(context, 8),
          borderColor: kGreyColor,
          borderWidth: 1,
          clearIcon: const Icon(
            Icons.clear,
            color: kPrimaryColor,
            size: 16,
          ),
          controller: _controller,
          onOptionSelected: (options) {
            debugPrint(options.toString());
          },
          selectedItemBuilder: (p0, p1) {
            return Container(
              width: w(context, 120),
              height: h(context, 32),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3.2),
                color: kFullBlackBgColor,
              ),
              child: Center(
                child: CustomText(
                  text: p1.label,
                  color: kSecondaryColor,
                  weight: FontWeight.w500,
                  size: 13,
                ),
              ),
            );
          },
          options: const <ValueItem>[
            ValueItem(label: 'Option 1', value: '1'),
            ValueItem(label: 'Option 2', value: '2'),
            ValueItem(label: 'Option 3', value: '3'),
            ValueItem(label: 'Option 4', value: '4'),
            ValueItem(label: 'Option 5', value: '5'),
            ValueItem(label: 'Option 6', value: '6'),
          ],
          maxItems: 2,
          disabledOptions: const [ValueItem(label: 'Option 1', value: '1')],
          selectionType: SelectionType.multi,
          chipConfig: const ChipConfig(wrapType: WrapType.wrap),
          dropdownHeight: 300,
          optionTextStyle: const TextStyle(fontSize: 16),
          selectedOptionIcon: const Icon(Icons.check_circle),
          optionBuilder: (ctx, item, selected) {
            return ListTile(
                title: CustomText(
                  text: item.label,
                  size: 16,
                ),
                trailing: selected
                    ? const Icon(
                        Icons.check,
                        color: kPrimaryColor,
                      )
                    : null);
          },
        ),
      ),
    );
  }
}
