import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_storage/get_storage.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseApi {

  final box = GetStorage();

  final _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Future<void> initNotifications() async {
    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      provisional: false,
      sound: true,
    );
    print('settings state ${settings.authorizationStatus}');
    final fCMToken = await _firebaseMessaging.getToken();
    print("Token FCM $fCMToken");
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else  if(settings.authorizationStatus == AuthorizationStatus.denied){
      print('Denied');
      // await openPhoneSettings(settings);
    }
    else  if(settings.authorizationStatus == AuthorizationStatus.notDetermined){
      print('notDetermined');
      await _firebaseMessaging.requestPermission(
        alert: true,
        badge: true,
        provisional: false,
        sound: true,
      );
    }
    else  if(settings.authorizationStatus == AuthorizationStatus.provisional){
      print('provisional');
    }
    //storing in local
    box.write('deviceToken', fCMToken.toString());
    String deviceToken = box.read('deviceToken');
    debugPrint("Device token ${deviceToken.toString()}");
    FirebaseMessaging.onMessage.listen(handleMessage);
  }

  localNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iosInitializationSettings =
    const DarwinInitializationSettings();
    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> openPhoneSettings(NotificationSettings settings) async {
    if (settings.authorizationStatus == AuthorizationStatus.denied) {
      bool isOpened = await openAppSettings();
      if (isOpened) {
        print("Phone settings opened");
      } else {
        print("Could not open phone settings");
      }
    }
  }

  Future<void> showNotification(String? title, String? body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id', // Replace with your own channel ID
      'channel_name', // Replace with your own channel name
      importance: Importance.max,
      priority: Priority.high,
    );
    const DarwinNotificationDetails iosPlatformChannelSpecifics =
    DarwinNotificationDetails(
    ); // Provide iOS-specific settings here

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iosPlatformChannelSpecifics
    );
    int uniqueNotificationId = 0;
    await flutterLocalNotificationsPlugin.show(
      uniqueNotificationId, // Notification ID, must be unique for each notification
      title ?? "test", // Notification title
      body ?? "test", // Notification body
      platformChannelSpecifics,
    );
  }


  Future<void> handleMessage(RemoteMessage message) async {
    print("Message received ${message.notification?.title.toString()}");
    if (message.notification!.title!.isNotEmpty &&
        message.notification!.body!.isNotEmpty) {
      print("Title ${message.notification?.title.toString()}");
      print("Body ${message.notification?.body.toString()}");
      showNotification(message.notification?.title.toString(),
          message.notification?.body.toString());
    }
  }
}
