import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationService {
  static NotificationService _instance;

  NotificationService._internal() {
    _instance = this;
  }

  factory NotificationService() => _instance ?? NotificationService._internal();

  Future<void> initNotification(FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var androidInitializeSettings =
    AndroidInitializationSettings('ic_launcher');
    var initializationSettings =
    InitializationSettings(android: androidInitializeSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          if (payload != null) {
            print('notification payload: $payload');
          }
          selectNotificationSubject.add(payload ?? 'Empty');
        });
  }
}