import 'dart:io';

import 'package:beekeep/controllers/apiaryController/add_nuc_controller.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/apiary_model.dart';
import 'package:beekeep/services/image_picker_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_Textfield_widget.dart';
import '../../widget/Custom_button_widget.dart';
import '../../widget/Custom_drop_down_widget.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import '../../widget/custom_scroll_view_effect_widget.dart';

class AddNucBasicDetail extends StatelessWidget {
  final ApiaryModel apiaryModel;
  const AddNucBasicDetail({super.key, required this.apiaryModel});

  @override
  Widget build(BuildContext context) {
    AddNucController controller = Get.find();
    return Scaffold(
      backgroundColor: kGreybackgroundColor,
      appBar: AppBar(
        backgroundColor: kGreybackgroundColor,
        leading: Padding(
          padding: only(context, left: 20),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SizedBox(
              width: h(context, 29),
              height: w(context, 29),
              child: CommonImageView(
                imagePath: Assets.imagesBack,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ),
        centerTitle: true,
        title: CustomText(
          text: 'Add Nuc',
          size: 16,
          weight: FontWeight.w600,
          color: kFullBlackBgColor,
        ),
        leadingWidth: w(context, 50),
      ),
      body: SizedBox(
        height: double.maxFinite,
        child: Padding(
          padding: symmetric(context, vertical: 20, horizontal: 20),
          child: SpaceBetweenScrollView(
            footer: Padding(
              padding: all(context, 20),
              child: Column(
                children: [
                  CustomButton(
                    borderRadius: 8,
                    buttonText: "Add Nuc",
                    onTap: () async {
                      FocusScope.of(context).unfocus();


                      Utils.showProgressDialog(context: context);
                      await controller.saveNucToDatabase(apiaryId: apiaryModel.apiaryId);
                      Utils.hideProgressDialog(context: context);

                      Get.close(1);

                    },
                  ),
                ],
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Name',
                  size: 14,
                ),
                SizedBox(
                  height: h(context, 6),
                ),
             CustomTextField2(
                  hintText: 'Enter name',
                  controller: controller.hiveNameController,
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(
                  text: 'Location',
                  size: 14,
                ),
                SizedBox(
                  height: h(context, 6),
                ),
                CustomTextField2(
                  hintText: 'Enter location',
                  controller: controller.locationController,
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(
                  text: 'Tags',
                  size: 14,
                ),
                SizedBox(
                  height: h(context, 6),
                ),
                TagsTextField(stringTagController: controller.stringTagController),

                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(
                  text: 'Honey Supers',
                  size: 14,
                ),
                SizedBox(
                  height: h(context, 6),
                ),
                CustomTextField2(
                  keyboardType: TextInputType.number,
                  controller: controller.honeySupersController,
                  hintText: '10',
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(
                  text: 'Temperature in C',
                  size: 14,
                ),
                SizedBox(
                  height: h(context, 6),
                ),
               CustomTextField2(
                  keyboardType: TextInputType.number,
                  controller: controller.temperatureController,
                  hintText: 'Enter temperature',
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(
                  text: 'Humidity',
                  size: 14,
                ),
                SizedBox(
                  height: h(context, 6),
                ),
               CustomTextField2(
                  controller: controller.humidityController,
                  hintText: 'Enter humidity',
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(
                  text: 'Condition',
                  size: 14,
                ),
                SizedBox(
                  height: h(context, 6),
                ),
                Obx(
                  () => CustomDropdown(
                      items: const ['Healthy', 'Unhealthy'],
                      selectedValue: controller.conditionController.value,
                      onChanged: (value) {
                        controller.conditionController.value = value;
                      },
                      hint: 'Healthy'),
                ),
                const SizedBox(
                  height: 15,
                ),
                GestureDetector(
                  onTap: (){
                    ImagePickerService.instance.openProfilePickerBottomSheet(context: context, onCameraPick: (){

                    }, onGalleryPick:() async {
                      await controller.selectImageFromGallery();
                    });
                  },
                  child: Container(
                    height: h(context, 162),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white),
                    child: Obx(
                        ()=>controller.imagePath.isNotEmpty?
                        CommonImageView(
                          file: File(controller.imagePath.value),
                          fit: BoxFit.cover,
                          height: double.maxFinite,
                          width: double.maxFinite,
                        ):

                        Center(
                        child: Column(mainAxisSize: MainAxisSize.min, children: [
                          CommonImageView(
                            imagePath: Assets.imagesCloud,
                            width: w(context, 55),
                            height: h(context, 37),
                            fit: BoxFit.contain,
                          ),
                          SizedBox(
                            height: h(context, 22),
                          ),
                          CustomText(
                            text: 'Upload image here',
                            size: 12,
                            weight: FontWeight.w300,
                            color: kFullBlackBgColor,
                          ),
                        ]),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

///
// import 'package:flutter/material.dart';
// import 'package:textfield_tags/textfield_tags.dart';

/*
 * String Tags
 */

// //String Tags with Multiline
// class StringMultilineTags extends StatefulWidget {
//   const StringMultilineTags({Key? key}) : super(key: key);
//
//   @override
//   State<StringMultilineTags> createState() => _StringMultilineTagsState();
// }
//
// class _StringMultilineTagsState extends State<StringMultilineTags> {
//   late double _distanceToField;
//   late StringTagController _stringTagController;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _distanceToField = MediaQuery.of(context).size.width;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _stringTagController = StringTagController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _stringTagController.dispose();
//   }
//
//   static const List<String> _initialTags = <String>[
//     'yaml',
//     'gradle',
//     'c',
//     'c++',
//     'java',
//     'python',
//     'javascript',
//     'sql',
//     'html',
//     'css',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 74, 137, 92),
//         centerTitle: true,
//         title: const Text(
//           'String Tag Multiline Demo',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Column(
//           children: [
//             TextFieldTags<String>(
//               textfieldTagsController: _stringTagController,
//               initialTags: _initialTags,
//               textSeparators: const [' ', ','],
//               letterCase: LetterCase.normal,
//               validator: (String tag) {
//                 if (tag == 'php') {
//                   return 'No, please just no';
//                 } else if (_stringTagController.getTags!.contains(tag)) {
//                   return 'You\'ve already entered that';
//                 }
//                 return null;
//               },
//               inputFieldBuilder: (context, inputFieldValues) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: TextField(
//                     onTap: () {
//                       _stringTagController.getFocusNode?.requestFocus();
//                     },
//                     controller: inputFieldValues.textEditingController,
//                     focusNode: inputFieldValues.focusNode,
//                     decoration: InputDecoration(
//                       isDense: true,
//                       border: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color.fromARGB(255, 74, 137, 92),
//                           width: 3.0,
//                         ),
//                       ),
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color.fromARGB(255, 74, 137, 92),
//                           width: 3.0,
//                         ),
//                       ),
//                       helperText: 'Enter language...',
//                       helperStyle: const TextStyle(
//                         color: Color.fromARGB(255, 74, 137, 92),
//                       ),
//                       hintText: inputFieldValues.tags.isNotEmpty
//                           ? ''
//                           : "Enter tag...",
//                       errorText: inputFieldValues.error,
//                       prefixIconConstraints:
//                       BoxConstraints(maxWidth: _distanceToField * 0.8),
//                       prefixIcon: inputFieldValues.tags.isNotEmpty
//                           ? SingleChildScrollView(
//                         controller: inputFieldValues.tagScrollController,
//                         scrollDirection: Axis.vertical,
//                         child: Padding(
//                           padding: const EdgeInsets.only(
//                             top: 8,
//                             bottom: 8,
//                             left: 8,
//                           ),
//                           child: Wrap(
//                               runSpacing: 4.0,
//                               spacing: 4.0,
//                               children:
//                               inputFieldValues.tags.map((String tag) {
//                                 return Container(
//                                   decoration: const BoxDecoration(
//                                     borderRadius: BorderRadius.all(
//                                       Radius.circular(20.0),
//                                     ),
//                                     color:
//                                     Color.fromARGB(255, 74, 137, 92),
//                                   ),
//                                   margin: const EdgeInsets.symmetric(
//                                       horizontal: 5.0),
//                                   padding: const EdgeInsets.symmetric(
//                                       horizontal: 10.0, vertical: 5.0),
//                                   child: Row(
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.start,
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       InkWell(
//                                         child: Text(
//                                           '#$tag',
//                                           style: const TextStyle(
//                                               color: Colors.white),
//                                         ),
//                                         onTap: () {
//                                           //print("$tag selected");
//                                         },
//                                       ),
//                                       const SizedBox(width: 4.0),
//                                       InkWell(
//                                         child: const Icon(
//                                           Icons.cancel,
//                                           size: 14.0,
//                                           color: Color.fromARGB(
//                                               255, 233, 233, 233),
//                                         ),
//                                         onTap: () {
//                                           inputFieldValues
//                                               .onTagRemoved(tag);
//                                         },
//                                       )
//                                     ],
//                                   ),
//                                 );
//                               }).toList()),
//                         ),
//                       )
//                           : null,
//                     ),
//                     onChanged: inputFieldValues.onTagChanged,
//                     onSubmitted: inputFieldValues.onTagSubmitted,
//                   ),
//                 );
//               },
//             ),
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                   const Color.fromARGB(255, 74, 137, 92),
//                 ),
//               ),
//               onPressed: () {
//                 _stringTagController.clearTags();
//               },
//               child: const Text(
//                 'CLEAR TAGS',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// //String Tags with AutoComplete
// class StringAutoCompleteTags extends StatefulWidget {
//   const StringAutoCompleteTags({Key? key}) : super(key: key);
//
//   @override
//   State<StringAutoCompleteTags> createState() => _StringAutoCompleteTagsState();
// }
//
// class _StringAutoCompleteTagsState extends State<StringAutoCompleteTags> {
//   late double _distanceToField;
//   late StringTagController _stringTagController;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _distanceToField = MediaQuery.of(context).size.width;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _stringTagController = StringTagController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _stringTagController.dispose();
//   }
//
//   static const List<String> _initialTags = <String>[
//     'c',
//     'c++',
//     'java',
//     'json',
//     'python',
//     'javascript',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 74, 137, 92),
//         centerTitle: true,
//         title: const Text(
//           'String Tag Autocomplete Demo...',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Column(
//           children: [
//             Autocomplete<String>(
//               optionsViewBuilder: (context, onSelected, options) {
//                 return Container(
//                   margin: const EdgeInsets.symmetric(
//                       horizontal: 10.0, vertical: 4.0),
//                   child: Align(
//                     alignment: Alignment.topCenter,
//                     child: Material(
//                       elevation: 4.0,
//                       child: ConstrainedBox(
//                         constraints: const BoxConstraints(maxHeight: 200),
//                         child: ListView.builder(
//                           shrinkWrap: true,
//                           itemCount: options.length,
//                           itemBuilder: (BuildContext context, int index) {
//                             final String option = options.elementAt(index);
//                             return TextButton(
//                               onPressed: () {
//                                 onSelected(option);
//                               },
//                               child: Align(
//                                 alignment: Alignment.centerLeft,
//                                 child: Text(
//                                   '#$option',
//                                   textAlign: TextAlign.left,
//                                   style: const TextStyle(
//                                     color: Color.fromARGB(255, 74, 137, 92),
//                                   ),
//                                 ),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ),
//                   ),
//                 );
//               },
//               optionsBuilder: (TextEditingValue textEditingValue) {
//                 if (textEditingValue.text == '') {
//                   return const Iterable<String>.empty();
//                 }
//                 return _initialTags.where((String option) {
//                   return option.contains(textEditingValue.text.toLowerCase());
//                 });
//               },
//               onSelected: (String selectedTag) {
//                 _stringTagController.onTagSubmitted(selectedTag);
//               },
//               fieldViewBuilder: (context, textEditingController, focusNode,
//                   onFieldSubmitted) {
//                 return TextFieldTags<String>(
//                   textEditingController: textEditingController,
//                   focusNode: focusNode,
//                   textfieldTagsController: _stringTagController,
//                   initialTags: const [
//                     'yaml',
//                     'gradle',
//                   ],
//                   textSeparators: const [' ', ','],
//                   letterCase: LetterCase.normal,
//                   validator: (String tag) {
//                     if (tag == 'php') {
//                       return 'No, please just no';
//                     } else if (_stringTagController.getTags!.contains(tag)) {
//                       return 'You\'ve already entered that';
//                     }
//                     return null;
//                   },
//                   inputFieldBuilder: (context, inputFieldValues) {
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                       child: TextField(
//                         controller: inputFieldValues.textEditingController,
//                         focusNode: inputFieldValues.focusNode,
//                         decoration: InputDecoration(
//                           isDense: true,
//                           border: const OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color.fromARGB(255, 74, 137, 92),
//                               width: 3.0,
//                             ),
//                           ),
//                           focusedBorder: const OutlineInputBorder(
//                             borderSide: BorderSide(
//                               color: Color.fromARGB(255, 74, 137, 92),
//                               width: 3.0,
//                             ),
//                           ),
//                           helperText: 'Enter language...',
//                           helperStyle: const TextStyle(
//                             color: Color.fromARGB(255, 74, 137, 92),
//                           ),
//                           hintText: inputFieldValues.tags.isNotEmpty
//                               ? ''
//                               : "Enter tag...",
//                           errorText: inputFieldValues.error,
//                           prefixIconConstraints:
//                           BoxConstraints(maxWidth: _distanceToField * 0.74),
//                           prefixIcon: inputFieldValues.tags.isNotEmpty
//                               ? SingleChildScrollView(
//                             controller:
//                             inputFieldValues.tagScrollController,
//                             scrollDirection: Axis.horizontal,
//                             child: Row(
//                                 children: inputFieldValues.tags
//                                     .map((String tag) {
//                                   return Container(
//                                     decoration: const BoxDecoration(
//                                       borderRadius: BorderRadius.all(
//                                         Radius.circular(20.0),
//                                       ),
//                                       color: Color.fromARGB(255, 74, 137, 92),
//                                     ),
//                                     margin:
//                                     const EdgeInsets.only(right: 10.0),
//                                     padding: const EdgeInsets.symmetric(
//                                         horizontal: 10.0, vertical: 4.0),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         InkWell(
//                                           child: Text(
//                                             '#$tag',
//                                             style: const TextStyle(
//                                                 color: Colors.white),
//                                           ),
//                                           onTap: () {
//                                             //print("$tag selected");
//                                           },
//                                         ),
//                                         const SizedBox(width: 4.0),
//                                         InkWell(
//                                           child: const Icon(
//                                             Icons.cancel,
//                                             size: 14.0,
//                                             color: Color.fromARGB(
//                                                 255, 233, 233, 233),
//                                           ),
//                                           onTap: () {
//                                             inputFieldValues
//                                                 .onTagRemoved(tag);
//                                           },
//                                         )
//                                       ],
//                                     ),
//                                   );
//                                 }).toList()),
//                           )
//                               : null,
//                         ),
//                         onChanged: inputFieldValues.onTagChanged,
//                         onSubmitted: inputFieldValues.onTagSubmitted,
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                   const Color.fromARGB(255, 74, 137, 92),
//                 ),
//               ),
//               onPressed: () {
//                 _stringTagController.clearTags();
//               },
//               child: const Text(
//                 'CLEAR TAGS',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
///

// //String Tags
// class AddNucBasicDetail extends StatefulWidget {
//   const AddNucBasicDetail({Key? key}) : super(key: key);
//
//   @override
//   State<AddNucBasicDetail> createState() => _StringTagsState();
// }

// class _StringTagsState extends State<AddNucBasicDetail> {
//   late double _distanceToField;
//   late StringTagController _stringTagController;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     _distanceToField = MediaQuery.of(context).size.width;
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     _stringTagController = StringTagController();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _stringTagController.dispose();
//   }
//
//   static const List<String> _pickLanguage = <String>[
//     'c',
//     'c++',
//     'java',
//     'python',
//     'javascript',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromARGB(255, 74, 137, 92),
//         centerTitle: true,
//         title: const Text(
//           'String Tag Demo...',
//           style: TextStyle(
//             color: Colors.white,
//             fontSize: 18.0,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(vertical: 8.0),
//         child: Column(
//           children: [
//             TextFieldTags<String>(
//               textfieldTagsController: _stringTagController,
//               initialTags: _pickLanguage,
//               textSeparators: const [' ', ','],
//               letterCase: LetterCase.normal,
//               validator: (String tag) {
//                 if (tag == 'php') {
//                   return 'No, please just no';
//                 } else if (_stringTagController.getTags!.contains(tag)) {
//                   return 'You\'ve already entered that';
//                 }
//                 return null;
//               },
//               inputFieldBuilder: (context, inputFieldValues) {
//                 return Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 10.0),
//                   child: TextField(
//                     controller: inputFieldValues.textEditingController,
//                     focusNode: inputFieldValues.focusNode,
//                     decoration: InputDecoration(
//                       isDense: true,
//                       border: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color.fromARGB(255, 74, 137, 92),
//                           width: 3.0,
//                         ),
//                       ),
//                       focusedBorder: const OutlineInputBorder(
//                         borderSide: BorderSide(
//                           color: Color.fromARGB(255, 74, 137, 92),
//                           width: 3.0,
//                         ),
//                       ),
//                       helperText: 'Enter tag...',
//                       helperStyle: const TextStyle(
//                         color: Color.fromARGB(255, 74, 137, 92),
//                       ),
//                       hintText: inputFieldValues.tags.isNotEmpty
//                           ? ''
//                           : "Enter tag...",
//                       errorText: inputFieldValues.error,
//                       prefixIconConstraints:
//                       BoxConstraints(maxWidth: _distanceToField * 0.75),
//                       prefixIcon: inputFieldValues.tags.isNotEmpty
//                           ? SingleChildScrollView(
//                         controller: inputFieldValues.tagScrollController,
//                         scrollDirection: Axis.horizontal,
//                         child: Row(
//                             children:
//                             inputFieldValues.tags.map((String tag) {
//                               return Container(
//                                 decoration: const BoxDecoration(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(20.0),
//                                   ),
//                                   color: Color.fromARGB(255, 74, 137, 92),
//                                 ),
//                                 margin: const EdgeInsets.only(right: 10.0),
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 10.0, vertical: 4.0),
//                                 child: Row(
//                                   mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     InkWell(
//                                       child: Text(
//                                         '#$tag',
//                                         style: const TextStyle(
//                                             color: Colors.white),
//                                       ),
//                                       onTap: () {
//                                         //print("$tag selected");
//                                       },
//                                     ),
//                                     const SizedBox(width: 4.0),
//                                     InkWell(
//                                       child: const Icon(
//                                         Icons.cancel,
//                                         size: 14.0,
//                                         color: Color.fromARGB(
//                                             255, 233, 233, 233),
//                                       ),
//                                       onTap: () {
//                                         inputFieldValues.onTagRemoved(tag);
//                                       },
//                                     )
//                                   ],
//                                 ),
//                               );
//                             }).toList()),
//                       )
//                           : null,
//                     ),
//                     onChanged: inputFieldValues.onTagChanged,
//                     onSubmitted: inputFieldValues.onTagSubmitted,
//                   ),
//                 );
//               },
//             ),
//             ElevatedButton(
//               style: ButtonStyle(
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                   const Color.fromARGB(255, 74, 137, 92),
//                 ),
//               ),
//               onPressed: () {
//                 _stringTagController.clearTags();
//               },
//               child: const Text(
//                 'CLEAR TAGS',
//                 style: TextStyle(color: Colors.white),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }