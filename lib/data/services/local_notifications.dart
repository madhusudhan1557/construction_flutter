import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  final FlutterLocalNotificationsPlugin _localNotificationService =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("@drawable/ic_launcher");
    const InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
    );

    await _localNotificationService.initialize(settings);
  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails andoidNotificationDetails =
        AndroidNotificationDetails(
      "channel_id",
      "channel_name",
      channelDescription: 'description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );
    return const NotificationDetails(android: andoidNotificationDetails);
  }

  Future<void> showNotification(
      {required int id, required String title, required String body}) async {
    NotificationDetails details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }
}
