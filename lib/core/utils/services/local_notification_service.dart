import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

class LocalNotificationService {
  LocalNotificationService();
  DateTime dateTime = DateTime.now();

  final _localNotificationService = FlutterLocalNotificationsPlugin();

  final BehaviorSubject<String?> onNotificationClick = BehaviorSubject();

  Future<void> intialize() async {
    tz.initializeTimeZones();

    const AndroidInitializationSettings androidInitializationSettings =
    AndroidInitializationSettings('drawable/ic_stat_android');


    IOSInitializationSettings iosInitializationSettings =
    IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    final InitializationSettings settings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );


  }

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails('channel_id', 'channel_name',
        channelDescription: 'description',
        importance: Importance.max,
        priority: Priority.max,
        icon: "@mipmap/todo",
        playSound: true);

    const IOSNotificationDetails iosNotificationDetails =
    IOSNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details);
  }


  tz.TZDateTime _nextInstanceOfTenAM(
      var hour, var minutes ,var date) {
    print(date);
    var datTime = DateTime.parse(date);
    print(datTime.year);
    print(datTime.month);
    print(datTime.day);

    TimeOfDay _startTime = TimeOfDay(hour:minutes,minute: hour);
    print(_startTime);



    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      _startTime.hour-2,
      _startTime.minute,
      now.second+3,
      now.millisecond,
      now.microsecond,



    );



    final tz.TZDateTime scheduledDate =
    tz.TZDateTime.from(
      scheduleDate.add(Duration(seconds: 1)),
      tz.local,
    );



    print(scheduledDate);
    print(scheduleDate);






    return scheduledDate;




  }

  /// Set right date and time for notifications
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );
    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    return scheduleDate;
  }

  Future<void> showScheduledNotification(
      {required int id,
        required String title,
        required String body,
        required var seconds,
        required var minute,
        required var date}) async {
    final details = await _notificationDetails();
    await _localNotificationService.zonedSchedule(
        id,
        title,
        body,
        _nextInstanceOfTenAM(minute, seconds , date),
        details,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        payload: 'Ths s the data'
    );
  }


  Future<void> showNotificationWithPayload(
      {required int id,
        required String title,
        required String body,
        required String payload}) async {
    final details = await _notificationDetails();
    await _localNotificationService.show(id, title, body, details,
        payload: payload);
  }

  void onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) {
    print('id $id');
  }
  tz.TZDateTime nextInstanceOfTenAM(
      int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print('now = $now');


    final tz.TZDateTime fd = tz.TZDateTime.from(DateTime.now(), tz.local);

    tz.TZDateTime scheduledDate =
    tz.TZDateTime(tz.local, fd.year, fd.month, fd.day, hour, minutes);
    print('scheduledDate = $scheduledDate');









    print('next scheduledDate = $scheduledDate');

    return scheduledDate;
  }




}