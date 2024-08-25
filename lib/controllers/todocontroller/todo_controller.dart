import 'package:beekeep/core/constants/firebase_constants.dart';
import 'package:beekeep/core/enums/task_status.dart';
import 'package:beekeep/models/tasksModel/task_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class TodoController extends GetxController {
  RxList<TasksModel> incompleteTodo = <TasksModel>[].obs;
  RxList<TasksModel> completeTodo = <TasksModel>[].obs;
  RxList<TasksModel> processingTodo = <TasksModel>[].obs;
  RxList<TasksModel> dueTodo = <TasksModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    streamIncompleteTodo();
    fetchCompleteTodo();
    fetchProcessingTodo();
    fetchDueTodo();
  }

  /// Stream only Incomplete that when new task or t'odo created its initial status would be incomplete

  Rx<TaskStatus> tabBarValue = TaskStatus.complete.obs;

  List<TaskStatus> taskValue = [
    TaskStatus.complete,
    TaskStatus.incomplete,
    TaskStatus.due,
    TaskStatus.processing,
  ];

  streamIncompleteTodo() async {

    FirebaseConstants.tasksCollectionReference
        .where('status', isEqualTo: TaskStatus.incomplete.name)
        .where(Filter.or(
            Filter('assignee',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid),
            Filter('createdBy',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)))
        .snapshots()
        .listen((snapshots) {
      List<TasksModel> tempModels = [];
      for (DocumentSnapshot snapshot in snapshots.docs) {
        tempModels.add(TasksModel.fromMap(snapshot));
      }
      incompleteTodo.assignAll(tempModels);
    });
  }

  fetchCompleteTodo() async {
    QuerySnapshot snapshots = await FirebaseConstants.tasksCollectionReference
        .where('status', isEqualTo: TaskStatus.complete.name)
        .where(Filter.or(
            Filter('assignee',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid),
            Filter('createdBy',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)))
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      completeTodo.add(TasksModel.fromMap(snapshot));
    }
  }

  fetchProcessingTodo() async {
    QuerySnapshot snapshots = await FirebaseConstants.tasksCollectionReference
        .where('status', isEqualTo: TaskStatus.processing.name)
        .where(Filter.or(
            Filter('assignee',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid),
            Filter('createdBy',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)))
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      processingTodo.add(TasksModel.fromMap(snapshot));
    }
  }

  fetchDueTodo() async {
    QuerySnapshot snapshots = await FirebaseConstants.tasksCollectionReference
        .where('status', isEqualTo: TaskStatus.due.name)
        .where(Filter.or(
            Filter('assignee',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid),
            Filter('createdBy',
                isEqualTo: FirebaseAuth.instance.currentUser!.uid)))
        .get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      dueTodo.add(TasksModel.fromMap(snapshot));
    }
  }
}
