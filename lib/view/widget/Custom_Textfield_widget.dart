// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api

import 'package:beekeep/constants/app_images.dart';
import 'package:beekeep/view/widget/common_image_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:textfield_tags/textfield_tags.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_styling.dart';

class CustomTextField extends StatefulWidget {
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final Function()? onTap;
  final TextEditingController? controller;
  final String hintText;
  final bool isIcon;
  final String? Function(String?)? validator;

  const CustomTextField({
    Key? key,
    this.onChanged,
    this.controller,
    required this.hintText,
    this.isIcon = true, this.onTap, this.readOnly = false, this.validator,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: only(
        context,
        // left: 16,
        // top: widget.isIcon ? 0 : 6,
        // bottom: widget.isIcon ? 0 : 6,
      ),
      child: TextFormField(
        validator: widget.validator,
        readOnly: widget.readOnly,
        onTap: widget.onTap,
        controller: widget.controller,
        onChanged: widget.onChanged,
        style: TextStyle(
          height: 2,
          color: kPrimaryColor,
          fontSize: f(context, 15),
        ),
        decoration: InputDecoration(
          filled: true,
         enabledBorder: OutlineInputBorder(
           borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
        color: kBorderColor,
            width: 1.0
        ),
      ),
        focusedBorder: InputBorder.none,
        disabledBorder: InputBorder.none,

          hintText: widget.hintText,
          hintStyle: TextStyle(
            color: kPrimaryColor.withOpacity(0.5),
            fontSize: f(context, 15),
            fontWeight: FontWeight.w500,
          ),
          suffixIcon: widget.isIcon
              ? Padding(
                  padding: all(context, 12),
                  child: CommonImageView(
                    imagePath: Assets.imagesCalendar,
                    fit: BoxFit.contain,
                    height: 20,
                    width: 20,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}

class CustomTextField2 extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String hintText;
  final bool isIcon,readOnly;
  final int? maxLines;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Function()? onTap;

  const CustomTextField2({
    Key? key,
    this.onChanged,
    this.controller,
    required this.hintText,
    this.isIcon = false, this.validator, this.readOnly=false, this.keyboardType, this.onTap, this.maxLines = 1, this.focusNode,
  }) : super(key: key);

  @override
  _CustomTextField2State createState() => _CustomTextField2State();
}

class _CustomTextField2State extends State<CustomTextField2> {
  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,

      maxLines: widget.maxLines,
      onTap: widget.onTap,
      keyboardType: widget.keyboardType,
      readOnly: widget.readOnly,
      validator: widget.validator,
      controller: widget.controller,
      onChanged: widget.onChanged,
      obscureText: widget.isIcon ? _isObscure : false,
      style: TextStyle(
        color: kPrimaryColor,
        fontSize: f(context, 15),
      ),
      decoration:  InputDecoration(
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
            color: kBorderColor,
            width: 1.0
        ),
      ),
      focusedBorder: InputBorder.none,
      disabledBorder: InputBorder.none,
        hintText: widget.hintText,
        hintStyle: TextStyle(
          color: kPrimaryColor.withOpacity(0.5),
          fontSize: f(context, 15),
          fontWeight: FontWeight.w500,
        ),
        suffixIcon: widget.isIcon
            ? IconButton(
                icon: Icon(
                  _isObscure ? Icons.visibility_off : Icons.visibility,
                ),
                iconSize: 18,
                onPressed: () {
                  setState(() {
                    _isObscure = !_isObscure;
                  });
                },
              )
            : null,
      ),
    );
  }
}

class CustomTextField3 extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String hintText;
  final bool isIcon,readOnly;
  final int maxLines;

  const CustomTextField3(
      {Key? key,
      this.onChanged,
      this.controller,
      required this.hintText,
      this.isIcon = false,
      this.maxLines = 1, this.readOnly=false})
      : super(key: key);

  @override
  State<CustomTextField3> createState() => _CustomTextField3State();
}

class _CustomTextField3State extends State<CustomTextField3> {
  bool _isObscure = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: w(context, double.maxFinite),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(h(context, 10)),
        border: Border.all(
          color: kBorderColor,
          width: w(context, 1),
        ),
        color: kSecondaryColor,
      ),
      child: Padding(
        padding: only(
          context,
          left: 16,
          top: widget.isIcon ? 0 : 6,
          bottom: widget.isIcon ? 0 : 6,
        ),
        child: TextField(
          readOnly: widget.readOnly,
          controller: widget.controller,
          onChanged: widget.onChanged,
          obscureText: widget.isIcon ? _isObscure : false,
          maxLines: widget.maxLines,
          style: TextStyle(
              color: kPrimaryColor,
              fontSize: f(context, 12),
              fontWeight: FontWeight.w400),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: widget.hintText,
            hintStyle: TextStyle(
              color: kPrimaryColor.withOpacity(0.5),
              fontSize: f(context, 12),
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: widget.isIcon
                ? IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                    ),
                    iconSize: 18,
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )
                : null,
          ),
        ),
      ),
    );
  }
}


class TagsTextField extends StatelessWidget {
  final StringTagController stringTagController;
  const TagsTextField({super.key, required this.stringTagController});

  @override
  Widget build(BuildContext context) {
    return TextFieldTags<String>(
      textfieldTagsController: stringTagController,
      // initialTags: _initialTags,
      textSeparators: const [' ', ','],
      letterCase: LetterCase.normal,
      validator: (String tag) {
        if (stringTagController.getTags!.contains(tag)) {
          return 'You\'ve already entered that';
        }
        return null;
      },
      inputFieldBuilder: (context, inputFieldValues) {
        return Container(
          color: kSecondaryColor,
          child: TextField(
            onTap: () {
              stringTagController.getFocusNode?.requestFocus();
            },
            controller: inputFieldValues.textEditingController,
            focusNode: inputFieldValues.focusNode,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: kBorderColor,
                  width: 1,
                ),
              ),
              focusedBorder:  OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: kBorderColor,
                  width: 1.0,
                ),
              ),
              // helperText: 'Enter Tag...',
              // helperStyle: const TextStyle(
              //   color: kTertiaryColor,
              // ),
              hintText: inputFieldValues.tags.isNotEmpty
                  ? ''
                  : "Enter tag...",
              errorText: inputFieldValues.error,
              prefixIconConstraints:
              BoxConstraints(maxWidth: Get.width * 0.8),
              prefixIcon: inputFieldValues.tags.isNotEmpty
                  ? SingleChildScrollView(
                controller: inputFieldValues.tagScrollController,
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 8,
                    bottom: 8,
                    left: 8,
                  ),
                  child: Wrap(
                      runSpacing: 4.0,
                      spacing: 4.0,
                      children:
                      inputFieldValues.tags.map((String tag) {
                        return Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            color:
                            kTertiaryColor,
                          ),
                          margin: const EdgeInsets.symmetric(
                              horizontal: 5.0),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 5.0),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              InkWell(
                                child: Text(
                                  '$tag',
                                  style: const TextStyle(
                                      color: Colors.white),
                                ),
                                onTap: () {
                                  //print("$tag selected");
                                },
                              ),
                              const SizedBox(width: 4.0),
                              InkWell(
                                child: const Icon(
                                  Icons.cancel,
                                  size: 14.0,
                                  color: Color.fromARGB(
                                      255, 233, 233, 233),
                                ),
                                onTap: () {
                                  inputFieldValues
                                      .onTagRemoved(tag);
                                },
                              )
                            ],
                          ),
                        );
                      }).toList()),
                ),
              )
                  : null,
            ),
            onChanged: inputFieldValues.onTagChanged,
            onSubmitted: inputFieldValues.onTagSubmitted,
          ),
        );
      },
    );
  }
}

