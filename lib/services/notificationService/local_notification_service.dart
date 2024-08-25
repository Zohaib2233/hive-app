//local notification service class
import 'dart:convert';
import 'dart:developer';

import 'package:app_settings/app_settings.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;


import '../../core/utils/snackbar.dart';
import '../firebaseServices/firebase_crud_services.dart';



class LocalNotificationService {

  LocalNotificationService._privateConstructor();

  //singleton instance variable
  static LocalNotificationService? _instance;


  //getter to access the singleton instance
  static LocalNotificationService get instance {
    _instance ??= LocalNotificationService._privateConstructor();
    return _instance!;
  }


  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

   final firebaseMessaging = FirebaseMessaging.instance;

  //method to initialize the initialization settings
   Future<void> initialize() async {
    await requestNotificationPermission();
    //initializing settings for android
    InitializationSettings initializationSettings = InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    );

    //we are getting details variable from the payload parameter of the notificationsPlugin.show() method
    notificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("Key of the map is: ${details.payload}");
      },
    );

    getDeviceToken();
  }

  requestNotificationPermission() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      AppSettings.openAppSettings();
    }
  }

  //getting device token for FCM
 Future<String?> getDeviceToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print("Device token := $token");
    return token;
  }

  //method to display push notification on top of screen
   void display(RemoteMessage message) async {
    try {
      //getting a unique id
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      //creating notification details channel
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails("general", "general",
              importance: Importance.max, priority: Priority.max));

      //displaying heads up notification
      await notificationsPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: message.data['type']);
    } on Exception catch (e) {
      print(
          "This exception occured while getting notification: $e Push Notification Exception");
    }
  }

  // A function to send the notification to the user upon messaging the other user
   Future<void> sendFCMNotification({
    required String deviceToken,
    required String title,
    required String body,
    required String type,
    required String sentBy,
    required String sentTo,
    required bool savedToFirestore
  }) async {
     print("Send Method Called");
    //in header we put the server key of the firebase console that is used for this project
     String accessToken = await getAccessToken();

     print("Access Tokennn = $accessToken");
     String projectId = "hive-task";
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      };
      var request = http.Request(
          'POST', Uri.parse('https://fcm.googleapis.com/v1/projects/$projectId/messages:send'));




      request.body = json.encode(
          {
        "message":
          {
            "token": deviceToken,
            "notification": {"title": title, "body": body},
            "data": {"type": type, "sentBy": sentBy, "sentTo": sentTo}
          }
        }
      );
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        print("************ Notification has been send**********");
        if(savedToFirestore){
          await FirebaseCRUDServices.instance.saveNotificationToFirestore(

              title: title,
              body: body,
              sentBy: sentBy,
              sentTo: sentTo,
              type: type);
        }

        //showSuccessSnackbar(title: 'Success', msg: '${response.statusCode}');
      } else {
        CustomSnackBars.instance.showFailureSnackbar(
            title: 'Error sending FCM notification',
             message: '${response.statusCode}');
      }
    } catch (e) {
      print("Exception ****** $e *******");
      // Utils.showFailureSnackbar(
      //     title: 'Error sending FCM notification', msg: '$e');
    }
  }


 //Handle Message
 void handleMessage({required BuildContext context ,required RemoteMessage message}){
     if(message.data['type']=='general'){
       // Get.to(()=>TripsScreen());
     }



 }

  //method to listen to firebase push notifications
//adding push notifications
  Future<void> pushNotifications() async {
    //for onMessage to work properly
    //to get the notification message when the app is in terminated state
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        print("Notification got from the terminated state: ${message.data}");
        // Get.to(() => HostProfile());
      }
    });

    //works only if the app is in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //displaying push notification via local notification package
      print("Message is (App is in foreground): ${message.data}");
      //adding new notification data to notification models list
      // Get.find<NotificationController>().addNewNotification(message: message);
      log('Notification is: ${message.notification!.title.toString()}');
      /// Display Notification
      display(message);
    });

    //works only when the app is in background but opened and the user taps on the notification
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print("Message is (App is in background and user tapped): ${message.data}");
      //adding new notification data to notification models list
      // Get.find<NotificationController>().addNewNotification(message: message);
      // Get.to(() => HostProfile());
    });
  }

  static String firebaseMessagingScope = "https://www.googleapis.com/auth/firebase.messaging";


  /// Generate Service Account Private Key
  Future<String> getAccessToken() async {

    /// Generate Service Key through Project Setting => Service Account => Generate New Private Key
    /// Copy Map from that file

    var serviceAccountKey =   {

      "type": "service_account",
      "project_id": "hive-task",
      "private_key_id": "547a3b02b6e09ff956df6b3c72b71e97530321d7",
      "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCaGU7i2litAwxn\ny1Ra5p7qGaMIT8q/5c8gZhMTDq6O8E4BaQ0HVl6/gHsNilyZZlmhGYzBAyNcqIot\nxGfnUJlyucPNYoAuvg7YNDXKkZCafH+Yf+ry6f6/HQ0+6Id9FhSy+MkzVha24gMC\nUc+D+QGk/FHCaqfQhGsiW1S3XSD99GZ9Ia7B64Rr1JYCPcMYNu3nKkzSsc773KTm\nSn3IkzlnTGqtl+OMN67AL72YgXOMMTs+LK6X4FPkBp7w1rc5yQd4s6PaUo2gyxbS\nxYk+LH5/yZUQOhL0A6ypB0IULaz1YZED5CQvSBaZilsgfk40Lw+F8EmJYHy8Epju\nf+sgJN2NAgMBAAECggEAHV0ruVIqmiNN0px+AUlXaFwEw1FzHOCVeMLCqTu/uxij\nAKVMOIT2jo7Uw/aE4S1N8IMeHWxz6VTrab+2ne8volswKru1mdKZIQ1H38cfszR8\nmuprMqkwpCnMy5tDMCyMOrNqIZhqwSQttxwwSyFgtRfom3+35SXKhXQ6XyuFnSaQ\nxBg3ClsCYBmulk6H8nw1CkFI8n1Q8sgAF5NHEBYjA7Y//Evvfi+QQ4SO13OOniL/\nDX8oMWTqhHGedEgiFR3KU9eU9MxqKxcAul95Dbrammir6pTO00sul8JL1DuCh0pe\nmi01i3E5hu4X+u+LFSWNT07nL/7n0bteUfN/9WT34QKBgQDMW+j/legSqmUJCf5Q\nf566yEPuRkIqGlfrhJ9y+UQEbBWoUy4gVhDonVzC0AmAuTrb8Qvmjzxt6qzXLME1\nvPiuvaaOFE5lnM3XQk3/RPc0BSya3ZtAVtamCv24Seja8rL8FfC34R7qaLmgAyOg\nl0Dw6Epkr9lqKbrvqebfWod8bQKBgQDBCgrRyzMTJjQvobPfh2MplY2hBFdX7Lec\nbgwX2vGa8AFxEUdKznxJpw2e48kw2yOmudtkgO1+Fit9bWlLUshfoD67uQB45TYS\nJUb7mhVM1LuLmqebyq3R6OhyC9bLoQko9CqABHM/UtYnoc9MUx/5hnbP9TmxDHaF\nk8pKzeHxoQKBgC6CIFXChQ1ycAoNly40zSgPGb6piLdSRX4ZMbyV1A/5lTg4rf+3\n9qMp5QmFFRSRkz6o7h9rq8IMLYfO7K3RMvt5t+UP5AOmGwaJVXzp8iSJpOwd0Q5k\ndPdW+wUs9OyXXXqXd7AxcLrCWLR84mfS5HmvM/cUOjO6CYwvq5ZbYQhFAoGBAK2m\n5gLCA6knRezPTys29Ip1AZomeJgc1zN+f5x6FbvmSbW38GUoCQCMqaEUkmlDyPdz\n3Bu2K26wbOEBKqZayuvTEHv4uacHsrNyGz+85YpfGHNGZZ6tHd5l4ayuX8SAkefo\ndc8Bsdb2IrY2RnAHmwzx3DHJDOPrLTeOsnzGZonhAoGAW6mLLZkg3nSMwKt7PRy+\nl8vF1TpM7z2v/uevUrAv5hafZPkbFHFbRaGFmrMhzrlMMhSz/tVMhmIab/1PnypV\nE7/uH7ceOzQM4j0+O8Nb6tKCrohCZdfvb4pThomh6TR/7orDuVuLYsChYph1QoY4\nP1oshEmhEOY+8H8AD6NOpwQ=\n-----END PRIVATE KEY-----\n",
      "client_email": "firebase-adminsdk-jjx5d@hive-task.iam.gserviceaccount.com",
      "client_id": "116545670347669462051",
      "auth_uri": "https://accounts.google.com/o/oauth2/auth",
      "token_uri": "https://oauth2.googleapis.com/token",
      "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
      "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-jjx5d%40hive-task.iam.gserviceaccount.com",
      "universe_domain": "googleapis.com"


    };

     
     final client = await clientViaServiceAccount(ServiceAccountCredentials.fromJson(
       serviceAccountKey
     ), [firebaseMessagingScope]);

     final accessToken = client.credentials.accessToken.data;

     return accessToken;

  }

}
