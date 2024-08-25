import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/enums/task_status.dart';
import 'package:beekeep/core/global/instance_variables.dart';
import 'package:beekeep/core/utils/snackbar.dart';
import 'package:beekeep/models/hiveModels/hive_model.dart';
import 'package:beekeep/models/tasksModel/task_model.dart';
import 'package:beekeep/models/user_model.dart';
import 'package:beekeep/services/firebaseServices/firebase_crud_services.dart';
import 'package:beekeep/services/notificationService/local_notification_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../core/utils/utils.dart';

class AddTodoController extends GetxController {
  final HiveModel hiveModel;

  AddTodoController(this.hiveModel);

  late DateTime taskStartTime;
  late DateTime taskDueTime;

  TextEditingController startDateController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController subjectController = TextEditingController();

  TextEditingController statusController = TextEditingController();

  TextEditingController assignController = TextEditingController();

  late UserModel selectedAssign;
  String assigneeId = '';

  RxList<UserModel> assignsModel = <UserModel>[].obs;

  RxString selectedPriority = 'Low'.obs;
  RxString selectedStatus = TaskStatus.incomplete.name.obs;
  List<String> priorityList = ['Low', 'Medium', 'High'];
  List<String> statusList = [
    TaskStatus.incomplete.name,
    TaskStatus.processing.name,
    TaskStatus.complete.name
  ];

  RxBool reminder = false.obs;

  @override
  Future<void> onInit() async {
    print("init called add Todo");

    statusController.text = selectedStatus.value.capitalize!;

    super.onInit();
    if (hiveModel.assigns.isNotEmpty) {
      for (String userId in hiveModel.assigns) {
        print("userId = $userId");
        DocumentSnapshot? snapshot = await FirebaseCRUDServices.instance
            .readSingleDoc(
            collectionReference: FirebaseConstants.userCollectionReference,
            docId: userId);
        if (snapshot != null) {
          assignsModel.add(UserModel.fromJson(snapshot));
        }
      }
    }
  }

  selectStartData(BuildContext context) async {
    DateTime? startTime = await Utils.createDatePicker(context);
    if (startTime != null) {
      taskStartTime = startTime;
      startDateController.text = Utils.formatDatePicker(startTime);
    }
  }

  selectEndData(BuildContext context) async {
    DateTime? dueTime = await Utils.createDatePicker(context);
    if (dueTime != null) {
      taskDueTime = dueTime;
      endDateController.text = Utils.formatDatePicker(dueTime);
    }
  }

  createTask(BuildContext context) async {
    if (assigneeId.isNotEmpty) {
      Utils.showProgressDialog(context: context);
      TasksModel tasksModel = TasksModel(
          apiaryId: hiveModel.apiaryId,
          hiveId: hiveModel.hiveId,
          createdBy: userModelGlobal.value.uid,
          startDate: taskStartTime,
          dueDate: taskDueTime,
          subject: subjectController.text,
          priority: selectedPriority.value,
          status: selectedStatus.value,
          assignee: assigneeId,
          taskId: '',
          createdDate: DateTime.now(),
          reminder: reminder.value);

      bool isDocAdded = await FirebaseCRUDServices.instance.createDocument2(
          collectionReference: FirebaseConstants.tasksCollectionReference,
          docIdName: 'taskId',
          data: tasksModel.toMap());
      if (isDocAdded) {
        LocalNotificationService.instance.sendFCMNotification(
            deviceToken: selectedAssign.deviceTokenID,
            title: "Task Assign",
            body: "Task has been assign to you",
            type: NotificationStatus.task.name,
            sentBy: userModelGlobal.value.uid,
            sentTo: selectedAssign.uid,
            savedToFirestore: true);


        CustomSnackBars.instance.showSuccessSnackbar(
            title: "Success", message: "Task Created Successfully");
        Utils.hideProgressDialog(context: context);
        Get.close(1);
      }
    } else {
      CustomSnackBars.instance.showFailureSnackbar(
          title: "Failed", message: "Please Select Assignee");
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    startDateController.dispose();
    endDateController.dispose();
    subjectController.dispose();
  }
}
