import 'package:cookie/main.dart';
import 'package:core/values/app_id.dart';
import 'package:core/values/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse details) {}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();
  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    _setTimeZone();
    await _setAndroid();

    await _initNotification();
  }

  void _setTimeZone(){
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
  }

  Future<void> _setAndroid() async{
    final androidImpl = _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl == null) return;
    await androidImpl.requestNotificationsPermission();
    await androidImpl.requestExactAlarmsPermission();
    const channel = AndroidNotificationChannel(
      AppID.notificationDefaultChannel, AppID.notificationDefaultChannelView,
      description: AppStrings.notificationDefaultChannelDescription,
      importance: Importance.high,
    );
    await androidImpl.createNotificationChannel(channel);
  }

  Future<void> _initNotification() async {
    const androidInit = AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInit = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    await _plugin.initialize(
      const InitializationSettings(
        android: androidInit,
        iOS:    iosInit,
      ),
      onDidReceiveNotificationResponse: (details) {
        _handleNotificationTap(details);
        debugPrint('[Foreground.Handler] payload: ${details.payload}');
      },
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
  }

  Future<void> show({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {

    const androidDetail = AndroidNotificationDetails(
      AppID.notificationDefaultChannel,
      AppID.notificationDefaultChannelView,
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetail = DarwinNotificationDetails();

    await _plugin.show(
      id,
      title,
      body,
      const NotificationDetails(android: androidDetail, iOS: iosDetail),
      payload: payload,
    );
  }

  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledAt,
  }) async {
    const androidDetail = AndroidNotificationDetails(
      AppID.notificationDefaultChannel,
      AppID.notificationDefaultChannelView,
    );
    const iosDetail = DarwinNotificationDetails();

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      scheduledAt,
      const NotificationDetails(android: androidDetail, iOS: iosDetail),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      payload: null,
    );
  }

  void _handleNotificationTap(NotificationResponse details) {
    final payload = details.payload;
    navigatorKey.currentState?.pushNamed('/notification', arguments: payload,);
  }
}
