


import 'package:cloud_firestore/cloud_firestore.dart';

class TasksModel {
  String createdBy;
  DateTime startDate;
  DateTime dueDate;
  String subject;
  String priority;
  String status;
  String assignee;
  String taskId;
  String? apiaryId;
  String? hiveId;
  DateTime createdDate;
  bool reminder;

  TasksModel({
    required this.createdBy,
    required this.startDate,
    required this.dueDate,
    required this.subject,
    required this.priority,
    required this.status,
    required this.assignee,
    required this.taskId,
    this.apiaryId,
    this.hiveId,
    required this.createdDate,
    required this.reminder,
  });

  // Factory method to create a TaskModels from a Firestore document
  factory TasksModel.fromMap(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return TasksModel(
        createdBy: data.containsKey('createdBy')?data['createdBy']:'',
      startDate: (data['startDate'] as Timestamp).toDate(),
      dueDate: (data['dueDate'] as Timestamp).toDate(),
      subject: data['subject'] ?? '',
      priority: data['priority'] ?? '',
      status: data['status'] ?? '',
      assignee: data['assignee'] ?? '',
      taskId: data['taskId'] ?? '',
      apiaryId: data['apiaryId'],
      hiveId: data['hiveId'],
      createdDate: (data['createdDate'] as Timestamp).toDate(),
      reminder: data['reminder'] ?? false,
    );
  }

  // Method to convert a TaskModels to a Firestore document
  Map<String, dynamic> toMap() {
    return {
      'createdBy':createdBy,
      'startDate': Timestamp.fromDate(startDate),
      'dueDate': Timestamp.fromDate(dueDate),
      'subject': subject,
      'priority': priority,
      'status': status,
      'assignee': assignee,
      'taskId': taskId,
      'apiaryId': apiaryId,
      'hiveId': hiveId,
      'createdDate': Timestamp.fromDate(createdDate),
      'reminder': reminder,
    };
  }
}
