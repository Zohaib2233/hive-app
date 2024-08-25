import 'package:beekeep/controllers/todocontroller/todo_controller.dart';
import 'package:beekeep/core/enums/task_status.dart';
import 'package:beekeep/core/utils/utils.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/view/screens/Todo/Add_todo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_images.dart';
import '../../../constants/app_styling.dart';
import '../../widget/Custom_text_widget.dart';
import '../../widget/common_image_view_widget.dart';
import 'Custom_Todo_Status_widget.dart';

class Todo extends StatelessWidget {
  const Todo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    TodoController controller = Get.find();
    controller.tabBarValue.value = TaskStatus.complete;
    return Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffF5F5F5),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CommonImageView(
                imagePath: Assets.imagesMenuicon,
                fit: BoxFit.contain,
                width: 25,
                height: 19,
              ),
              CustomText(
                text: "To Do",
                size: 16,
                weight: FontWeight.w600,
              ),
              Row(
                children: [
                  CommonImageView(
                    imagePath: Assets.imagesBell,
                    fit: BoxFit.contain,
                    width: 36,
                    height: 136,
                  ),
                  SizedBox(width: w(context, 6)),
                  CommonImageView(
                    imagePath: Assets.imagesMsg,
                    fit: BoxFit.contain,
                    width: 36,
                    height: 136,
                  ),
                ],
              ),
            ],
          ),
          bottom: AppBar(
            backgroundColor: const Color(0xffF5F5F5),
            title: Column(
              children: [
                ToggleSwitch(
                  minWidth: w(context, 90),
                  cornerRadius: h(context, 7),
                  customWidths: [
                    w(context, 100),
                    w(context, 110),
                    w(context, 70),
                    w(context, 110)
                  ],
                  activeBgColors: const [
                    [kTertiaryColor],
                    [kTertiaryColor],
                    [kTertiaryColor],
                    [kTertiaryColor],
                  ],
                  activeFgColor: kSecondaryColor,
                  inactiveBgColor: kSecondaryColor,
                  inactiveFgColor: const Color(0xff666666),
                  initialLabelIndex: 0,
                  totalSwitches: 4,
                  labels: const [
                    'Completed',
                    'Incomplete',
                    'Due',
                    'Processing'
                  ],
                  radiusStyle: true,
                  onToggle: (index) {
                    controller.tabBarValue.value = controller.taskValue[index!];

                    // controller.tabBarValue.value = index!;
                  },
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            HiveModel hiveModel = HiveModel(hiveName: '',
                assigns: [],
                tags: [],
                hiveImage: '',
                location: '',
                honeySuper: '',
                temperature: '',
                humidity: '',
                condition: '',
                apiaryId: '',
                hiveId: '',
                ownerId: '',
                createdDate: DateTime.now(),
                apiaryName: '');

            Get.to(() => AddToDo(hiveModel: hiveModel,isCreateTodo: true
              ,));
          },
          backgroundColor: kTertiaryColor,
          child: const Icon(
            Icons.add,
            color: kPrimaryColor,
          ),
        ),
        body: Obx(
              () =>
              Padding(
                  padding: EdgeInsets.all(20),
                  child: controller.tabBarValue.value == TaskStatus.complete
                      ? CompleteTasks(controller: controller)
                      : controller.tabBarValue.value == TaskStatus.incomplete
                      ? IncompleteTasks(controller: controller)
                      : controller.tabBarValue.value == TaskStatus.processing
                      ? ProcessingTasks(controller: controller)
                      : DueTasks(controller: controller)),
        ));
  }
}

/// Tab Bar Tasks

class IncompleteTasks extends StatelessWidget {
  final TodoController controller;

  const IncompleteTasks({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          ListView.builder(
            itemCount: controller.incompleteTodo.length,
            itemBuilder: (context, index) =>
                CustomToDoStatus(
                  subject: controller.incompleteTodo[index].subject,
                    startDate: Utils.formatDateTime(
                        controller.incompleteTodo[index].startDate),
                    endDate:
                    Utils.formatDateTime(
                        controller.incompleteTodo[index].dueDate),
                    priority: controller.incompleteTodo[index].priority,
                    status: controller.incompleteTodo[index].status),
          ),
    );
  }
}

class CompleteTasks extends StatelessWidget {
  final TodoController controller;

  const CompleteTasks({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          ListView.builder(
            itemCount: controller.completeTodo.length,
            itemBuilder: (context, index) =>
                CustomToDoStatus(
                  subject: controller.incompleteTodo[index].subject,
                    startDate:
                    Utils.formatDateTime(
                        controller.completeTodo[index].startDate),
                    endDate:
                    Utils.formatDateTime(
                        controller.completeTodo[index].dueDate),
                    priority: controller.completeTodo[index].priority,
                    status: controller.completeTodo[index].status),
          ),
    );
  }
}

class ProcessingTasks extends StatelessWidget {
  final TodoController controller;

  const ProcessingTasks({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          ListView.builder(
            itemCount: controller.processingTodo.length,
            itemBuilder: (context, index) =>
                CustomToDoStatus(
                  subject: controller.incompleteTodo[index].subject,
                    startDate: Utils.formatDateTime(
                        controller.processingTodo[index].startDate),
                    endDate:
                    Utils.formatDateTime(
                        controller.processingTodo[index].dueDate),
                    priority: controller.processingTodo[index].priority,
                    status: controller.processingTodo[index].status),
          ),
    );
  }
}

class DueTasks extends StatelessWidget {
  final TodoController controller;

  const DueTasks({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(
          () =>
          ListView.builder(
            itemCount: controller.dueTodo.length,
            itemBuilder: (context, index) =>
                CustomToDoStatus(
                  subject: controller.incompleteTodo[index].subject,
                    startDate:
                    Utils.formatDateTime(controller.dueTodo[index].startDate),
                    endDate: Utils.formatDateTime(
                        controller.dueTodo[index].dueDate),
                    priority: controller.dueTodo[index].priority,
                    status: controller.dueTodo[index].status),
          ),
    );
  }
}
