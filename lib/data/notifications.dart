import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:quote_generator/data/quote_repo.dart';

import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import '../models/QuateModel.dart';

class NotificationsService {
  final _localnotification = FlutterLocalNotificationsPlugin();
  Future<void> intitializeNotification() async {
    tz.initializeTimeZones();
// final location = await FlutterNativeTimezone.getLocalTimezone();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    const AndroidInitializationSettings androidIntialiseSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    DarwinInitializationSettings iosInitialiseSettings =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: _onDidReceiveLocalNotification);

    final InitializationSettings settings = InitializationSettings(
        android: androidIntialiseSettings, iOS: iosInitialiseSettings);
    await _localnotification.initialize(settings,
        onDidReceiveNotificationResponse: _onDidReceiveNotificationResponse);
  }

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id: $id');
  }

  void _onDidReceiveNotificationResponse(NotificationResponse details) {
    print('Payload ${details.payload}');
  }

  NotificationDetails _notificationDetail() {
    const AndroidNotificationDetails _androidNotificationDetail =
        AndroidNotificationDetails(
      'channelId',
      'channelName',
      channelDescription: 'Description',
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
    );
    const DarwinNotificationDetails _iosNotificationDetail =
        DarwinNotificationDetails();
    return const NotificationDetails(
        android: _androidNotificationDetail, iOS: _iosNotificationDetail);
  }

  Future<void> showNotification() async {
    final detail = _notificationDetail();
    QuotModel quotemodel = await QuoteRepo.getQuote('/random');
    final title = quotemodel.author;
    final body = quotemodel.quote;
    const id = 0;
    await _localnotification.show(id, title, body, detail);
  }

  Future<void> showScheduleNotification() async {
    final detail = _notificationDetail();
    QuotModel quotemodel = await QuoteRepo.getQuote('/random');
    final title = quotemodel.author;
    final body = quotemodel.quote;
    const id = 1;

    await _localnotification.zonedSchedule(
      id,
      title,
      body,
      _dailyTime(const TimeOfDay(
        hour: 8,
        minute: 0,
      )),
      detail,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
    );
  }

  static tz.TZDateTime _dailyTime(TimeOfDay time) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );
    return scheduleDate.isBefore(now)
        ? scheduleDate.add(const Duration(days: 1))
        : scheduleDate;
  }
}
