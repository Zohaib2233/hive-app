import 'dart:developer';

import 'package:beekeep/core/bindings/bindings.dart';
import 'package:beekeep/services/notificationService/local_notification_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/routes/routes.dart';
import 'config/theme/light_theme.dart';
import 'firebase_options.dart';


///Todo: Enable Swift on the iOS project, in ios/Podfile: for printing
/* target 'Runner' do
    use_frameworks!    # <-- Add this line*/


//for getting notifications when the app is in background and the user doesn't tap on the notification
@pragma('vm:entry-point')   //for getting background notifications in release mode also
Future<void> backgroundNotificationHandler(RemoteMessage message) async {
  print('Notification is: ${message.notification.toString()}');
  print("Message is (App is in background): ${message.data}");
  log('Notification is: ${message.notification!.title.toString()}');
  LocalNotificationService.instance.display(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  LocalNotificationService.instance.initialize();
  FirebaseMessaging.onBackgroundMessage(backgroundNotificationHandler);
  await LocalNotificationService.instance.pushNotifications();

  runApp(MyApp());
}

//DO NOT REMOVE Unless you find their usage.
String dummyImg =
    'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=764&q=80';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      initialBinding: InitialBinding(),
      title: 'Bee Keep',
      theme: LightTheme,
      themeMode: ThemeMode.light,
      initialRoute: AppLinks.Loading,
      getPages: AppRoutes.pages,
      defaultTransition: Transition.fadeIn,
    );
  }
}
