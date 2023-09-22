



import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomNotification {

  static Future initializeNotification (FlutterLocalNotificationsPlugin notificationsPlugin) async {
    const androidInitialize = AndroidInitializationSettings("mipmap/ic_launcher");
    const initializationSetting = InitializationSettings(android: androidInitialize);

    await notificationsPlugin.initialize(initializationSetting);
  }


  static Future showNotification(String title,String body, FlutterLocalNotificationsPlugin notificationsPlugin) async {

    AndroidNotificationDetails androidNotificationDetails =
    const AndroidNotificationDetails("channelId", "channelName",playSound: true,importance: Importance.max,priority: Priority.high);

    var notificationDetails = NotificationDetails(android: androidNotificationDetails);

    await notificationsPlugin.show(0, title, body, notificationDetails);
  }

}