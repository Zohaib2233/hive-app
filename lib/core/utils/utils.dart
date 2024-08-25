import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Utils {
  static Future<DateTime?> createDatePicker(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        //get today's date
        firstDate: DateTime(1940),
        //DateTime.now() - not to allow to choose before today.
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      // print(pickedDate); //get the picked date in the format => 2022-07-04 00:00:00.000

      // String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);

      return pickedDate;
    } else {
      print("Date is not selected");
      return null;
    }
  }

  static String formatDatePicker(DateTime date) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(date);
    return formattedDate;
  }

  static String formatDateTimetoTime(DateTime time) {
    // Define the date format
    final dateFormat = DateFormat('h:mm a');

    // Format the DateTime object
    return dateFormat.format(time);
  }

  static void showProgressDialog({required BuildContext context}) {
    //showing progress indicator
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: Center(child: CircularProgressIndicator())));
  }

  static hideProgressDialog({required BuildContext context}) {
    Navigator.pop(context);
  }

  static String formatDateTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final weekDay = dateTime.weekday;

    if (dateTime.isAfter(today) && dateTime.isBefore(tomorrow)) {
      return 'Today';
    } else if (dateTime.isAfter(yesterday) && dateTime.isBefore(today)) {
      return 'Yesterday';
    } else if (dateTime.isAfter(today.subtract(Duration(days: weekDay))) &&
        dateTime.isBefore(today.add(Duration(days: 7 - weekDay)))) {
      return DateFormat('EEEE').format(dateTime); // Weekday name (e.g., Monday)
    } else {
      return DateFormat('dd MMM, yyyy').format(dateTime);
    }
  }

  static void showLogoutDialog(
      {Function()? onCancel,
      Function()? onConfirm,
      String titleText = "Logout",
      String middleText = "Are you sure you want to logout?"}) {
    Get.defaultDialog(
      backgroundColor: Colors.white,
      buttonColor: Colors.red,
      cancelTextColor: Colors.black,
      title: titleText,
      middleText: middleText,
      textCancel: "No",
      textConfirm: "Yes",
      confirmTextColor: Colors.white,
      onCancel: onCancel,
      onConfirm: onConfirm,
    );
  }

  static String formatDateWithTime(DateTime dateTime) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final tomorrow = DateTime(now.year, now.month, now.day + 1);
    final weekDay = dateTime.weekday;

    if (dateTime.isAfter(today) && dateTime.isBefore(tomorrow)) {
      return 'Today ${DateFormat('h:mm a').format(dateTime)}';
    } else if (dateTime.isAfter(yesterday) && dateTime.isBefore(today)) {
      return 'Yesterday ${DateFormat('h:mm a').format(dateTime)}';
    } else if (dateTime.isAfter(today.subtract(Duration(days: weekDay))) &&
        dateTime.isBefore(today.add(Duration(days: 7 - weekDay)))) {
      return DateFormat('EEEE h:mm a')
          .format(dateTime); // Weekday name (e.g., Monday)
    } else {
      return DateFormat('dd MMM, yyyy h:mm a').format(dateTime);
    }
  }
}
