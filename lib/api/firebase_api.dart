import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:frs_mobile/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive/hive.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
}

class FirebaseApi {
  static final _firebaseMessaging = FirebaseMessaging.instance;
  static final flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initNotifications() async {
    await _firebaseMessaging.requestPermission();
    final FCMToken = await _firebaseMessaging.getToken();
    print('code: $FCMToken');

    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    final url =
        Uri.parse('http://fashionrental.online:8080/notification/register');

    // int? accountID = AuthProvider.userModel?.accountID;
    var box = await Hive.openBox('userBox');
    int? accountId = box.get('user') != null
        ? UserModel.fromJson(json.decode(box.get('user'))).accountID
        : null;
    // print('accountid: $accountID');
    print('accountid: $accountId');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          // 'accountID': accountID,
          'accountID': accountId,
          'fcm': FCMToken,
        }),
      );
      print('Response: ${response.body}');
    } catch (e) {
      print(e);
      print('error: $e');
    }
    await _checkAndCreateNotificationChannel();
  }

  static Future<void> _checkAndCreateNotificationChannel() async {
    const channelId = 'high_importance_channel';
    final existingChannels = await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()!
        .getNotificationChannels();

    if (existingChannels!.isEmpty ||
        !existingChannels.any((channel) => channel.id == channelId)) {
      final AndroidNotificationChannel channel = AndroidNotificationChannel(
        channelId,
        'High Importance Notifications',
        description: 'This channel is used for important notifications.',
        importance: Importance.high,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }
  }

  static void showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    final AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
    if (notification != null && android != null) {
      flutterLocalNotificationsPlugin.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            channel.id,
            channel.name,
            channelDescription: channel.description,
            icon: '@mipmap/launcher_icon',
          ),
        ),
      );
    }
  }

  static Future<List<dynamic>> getNotifications(int accountID) async {
    final url =
        Uri.parse('http://fashionrental.online:8080/notification/$accountID');

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load notifications');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
      throw Exception('Failed to load notifications');
    }
  }

  static Future<void> readNotification(int accountID) async {
    final url =
        Uri.parse('http://fashionrental.online:8080/notification/$accountID');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        print('Notification marked as read successfully');
      } else {
        throw Exception('Failed to mark notification as read');
      }
    } catch (e) {
      print('Error marking notification as read: $e');
      throw Exception('Failed to mark notification as read');
    }
  }
}
