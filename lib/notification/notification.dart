import 'package:core/values/app_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:core/values/app_id.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse details) {
  // 백그라운드에서 알림을 탭했을 때 처리할 로직
  debugPrint('[Background.Handler] payload: ${details.payload}');
}

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    debugPrint('[NotificationService] init() start');

    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Seoul'));
    debugPrint('[NotificationService] timezones initialized');

    final androidImpl = _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>();
    if (androidImpl == null) {
      debugPrint('[NotificationService] ⚠️ Android impl is null');
      return;
    }

    final notifGranted = await androidImpl.requestNotificationsPermission();
    debugPrint('[NotificationService] requestNotificationsPermission → $notifGranted');
    if (notifGranted != true) {
      debugPrint('[NotificationService] ❌ 알림 권한 거부됨, 스케줄 예약 중단');
      return;
    }

    final alarmsGranted = await androidImpl.requestExactAlarmsPermission();
    debugPrint('[NotificationService] requestExactAlarmsPermission → $alarmsGranted');

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
        // 포그라운드에서 탭했을 때
        debugPrint('[Foreground.Handler] payload: ${details.payload}');
      },
      // 2) 톱레벨 함수로 바꿔 넘김
      onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
    );
    debugPrint('[NotificationService] plugin initialized');

    const channel = AndroidNotificationChannel(
      AppID.notificationDefaultChannel, AppID.notificationDefaultChannelView,
      description: AppStrings.notificationDefaultChannelDescription,
      importance: Importance.high,
    );
    await androidImpl?.createNotificationChannel(channel);
    debugPrint('[NotificationService] channel "${channel.id}" created');

    debugPrint('[NotificationService] init() complete');

    await _plugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  Future<void> show({
    required int id,
    required String title,
    required String body,
    String? payload,
  }) async {
    debugPrint('[NotificationService] show() → id:$id, title:$title, body:$body, payload:$payload');

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

    debugPrint('[NotificationService] show() completed');
  }

  Future<void> schedule({
    required int id,
    required String title,
    required String body,
    required tz.TZDateTime scheduledAt,
  }) async {
    debugPrint('[NotificationService] schedule() → id:$id, at:$scheduledAt');

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
      //matchDateTimeComponents: DateTimeComponents.time,
      payload: null,
    );

    debugPrint('[NotificationService] schedule() completed');
  }

  Future<void> scheduleAtDateTime({
    required int id,
    required String title,
    required String body,
    required DateTime scheduledAt,    // DateTime 그대로 받음
  }) async {
    debugPrint('[NotificationService] scheduleAtDateTime → $scheduledAt');

    // DateTime → TZDateTime 변환 (로컬 타임존 기준)
    final tzScheduled = tz.TZDateTime.from(scheduledAt, tz.local);

    const androidDetail = AndroidNotificationDetails(
      AppID.notificationDefaultChannel,
      AppID.notificationDefaultChannelView,
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetail = DarwinNotificationDetails();

    await _plugin.zonedSchedule(
      id,
      title,
      body,
      tzScheduled,
      const NotificationDetails(android: androidDetail, iOS: iosDetail),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      // 단발성이라면 이 줄은 빼세요:
      // matchDateTimeComponents: DateTimeComponents.time,
      payload: null,
    );

    debugPrint('[NotificationService] scheduleAtDateTime completed');
  }
}
