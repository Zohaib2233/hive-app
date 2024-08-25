import 'package:beekeep/controllers/todocontroller/add_todo_controller.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/core/utils/validators.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/view/screens/Todo/select_assign_todo.dart';
import 'package:beekeep/view/screens/Todo/select_task_asignee.dart';
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

class AddToDo extends StatelessWidget {
  final HiveModel hiveModel;
  final bool isCreateTodo;

  AddToDo({super.key, required this.hiveModel, this.isCreateTodo=false});

  GlobalKey<FormState> taskFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {

    var controller = Get.put(AddTodoController(hiveModel));

    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: const Color(0xffF5F5F5),
        leading: Padding(
          padding: all(context, 15),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: CommonImageView(
              imagePath: Assets.imagesBack,
              height: 28,
              width: 28,
            ),
          ),
        ),
        title: CustomText(
          text: "Add To Do",
          size: 16,
          weight: FontWeight.w600,
        ),
      ),
      bottomSheet: Container(
        color: const Color(0xffF5F5F5),
        child: Padding(
          padding: symmetric(context, horizontal: 20, vertical: 10),
          child: CustomButton3(
            buttonText: "Add To Do",
            onTap: () async {
              if(taskFormKey.currentState!.validate()){
                await controller.createTask(context);
              }

            },
          ),
        ),
      ),
      body: ListView(
        padding: all(context, 20),
        children: [
          Form(
            key: taskFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(text: "Start Date"),
                SizedBox(
                  height: h(context, 6),
                ),
                CustomTextField(
                  validator: ValidationService.instance.dateSelectValidator,

                    controller: controller.startDateController,
                    readOnly: true,
                    onTap: () {
                      controller.selectStartData(context);
                    },
                    hintText: "Select Start Date"),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(text: "Due Date"),
                SizedBox(
                  height: h(context, 6),
                ),
                CustomTextField(
                  validator: ValidationService.instance.dateSelectValidator,
                  hintText: "Select Due Date",
                  controller: controller.endDateController,
                  readOnly: true,
                  onTap: () {
                    controller.selectEndData(context);
                  },
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(text: "Subject"),
                SizedBox(
                  height: h(context, 6),
                ),
                CustomTextField(
                  validator: ValidationService.instance.emptyValidator,
                  controller: controller.subjectController,
                  hintText: "Add Subject",
                  isIcon: false,
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(text: "Priority"),
                SizedBox(
                  height: h(context, 6),
                ),
                Obx(
                  () => CustomDropdown(
                    items: controller.priorityList,
                    selectedValue: controller.selectedPriority.value,
                    onChanged: (newValue) {
                      controller.selectedPriority.value = newValue;
                    },
                    hint: 'Select Priority',
                  ),
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(text: "Status"),
                SizedBox(
                  height: h(context, 6),
                ),
                //Todo: add this dropDown for editing todo
                /// Drop Down for Status
                // Obx(
                //   () => CustomDropdown(
                //     items: controller.statusList,
                //     selectedValue: controller.selectedStatus.value,
                //     onChanged: (newValue) {
                //       controller.selectedStatus.value = newValue;
                //     },
                //     hint: 'Select Status',
                //   ),
                // ),

                CustomTextField(hintText: "Incomplete", controller: controller.statusController,
                readOnly: true,
                isIcon: false,
                ),

                SizedBox(
                  height: h(context, 15),
                ),
                CustomText(text: "Assignee"),
                SizedBox(
                  height: h(context, 6),
                ),
                CustomTextField(
                  hintText: "Select Assignee",
                  isIcon: false,
                  readOnly: true,
                  controller: controller.assignController,
                  onTap: () {

                    if(isCreateTodo==false){
                      if (hiveModel.assigns.isNotEmpty) {
                        Get.to(() => SelectTaskAssignee());
                      } else {
                        CustomSnackBars.instance.showFailureSnackbar(
                            title: "",
                            message: "No Assignees were added in Apiary");
                      }
                    }
                    else{
                      Get.to(()=>SelectAssignTodo());
                    }


                  },
                ),
                SizedBox(
                  height: h(context, 15),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomText(
                      text: "Reminder",
                      size: 16,
                    ),
                    const Spacer(),
                    Obx(
                      () => Switch(
                        value: controller.reminder.value,
                        onChanged: (value) {
                          controller.reminder.value = value;
                        },
                        inactiveThumbColor: kSecondaryColor,
                        inactiveTrackColor: kDividerColor,
                        activeColor: kTertiaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: h(context, 24),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
