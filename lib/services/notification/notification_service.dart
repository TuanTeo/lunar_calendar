import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lunar_calendar/services/notification/schedule_event.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:flutter_timezone/flutter_timezone.dart';

import '../../data/event/event_default_data.dart';
import '../../utils/event_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../viet_calendar/viet_calendar.dart';

const String ANDROID_CHANNEL_ID = "channelId";
const String ANDROID_CHANNEL_NAME = "channelName";
const Importance ANDROID_IMPROTANCE = Importance.max;

class NotificationService {

  bool _notificationsEnabled = false;

  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> isAndroidPermissionGranted() async {
    if (Platform.isAndroid) {
      final bool granted = await notificationsPlugin
              .resolvePlatformSpecificImplementation<
                  AndroidFlutterLocalNotificationsPlugin>()
              ?.areNotificationsEnabled() ??
          false;


      _notificationsEnabled = granted;
    }
  }

  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await notificationsPlugin
          .resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      await notificationsPlugin
          .resolvePlatformSpecificImplementation<
          MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
    } else if (Platform.isAndroid) {
      final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
      notificationsPlugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      final bool? grantedNotificationPermission =
      await androidImplementation?.requestNotificationsPermission();

      _notificationsEnabled = grantedNotificationPermission ?? false;
    }
  }

  Future<void> initNotification(BuildContext context) async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (int id, String? title, String? body, String? payload) async {}
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS
    );

    await notificationsPlugin.initialize(
        initializationSettings,
        onDidReceiveNotificationResponse: (details) {
          zonedScheduleNotification(context, ScheduleEvent().nearestEventDay());
        },
    );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
          ANDROID_CHANNEL_ID,
          ANDROID_CHANNEL_NAME,
          importance: ANDROID_IMPROTANCE
      ),
      iOS: DarwinNotificationDetails()
    );
  }

  Future showNotification({
    int id = 0, String? title, String? body, String? payload}) async {
    return notificationsPlugin.show(id, title, body, await notificationDetails());
  }

  Future<void> zonedScheduleNotification(BuildContext context, DateTime eventDate) async {
    var lunarDay = VietCalendar.convertSolar2Lunar(
        eventDate.day, eventDate.month, eventDate.year, VietCalendar.TIME_ZONE);

    var notificationBody = _getNotificationBody(context, eventDate);

    var notificationTitle = 'Ngày mai ${eventDate.day}/${eventDate.month} (${lunarDay[0]}/${lunarDay[1]} âm lịch)';

    eventDate = eventDate.subtract(const Duration(days: 1));
    tz.TZDateTime scheduledDate = tz.TZDateTime(
        tz.local, eventDate.year, eventDate.month, eventDate.day, 10);

    await notificationsPlugin.zonedSchedule(
        0,
        notificationTitle,
        notificationBody,
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 10)),
        // scheduledDate,
        const NotificationDetails(
            android: AndroidNotificationDetails(
                ANDROID_CHANNEL_ID,
                ANDROID_CHANNEL_NAME,
                importance: ANDROID_IMPROTANCE)
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> configureLocalTimeZone() async {
    if (kIsWeb || Platform.isLinux) {
      return;
    }
    tz.initializeTimeZones();
    final String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
  }

  _getNotificationBody(BuildContext context, DateTime eventDate) {
    var isEventDay = EventUtils.isEventDay(eventDate);
    var solarEvents = isEventDay[1];
    var lunarEvents = isEventDay[2];

    var result = '';
    if (solarEvents.isNotEmpty) {
      for (var element in solarEvents) {
        result += '${AppLocalizations.of(context).event(listDefaultEvent[element].name)}\n';
      }
    }

    if (lunarEvents.isNotEmpty) {
      for (var element in lunarEvents) {
        result += '${AppLocalizations.of(context).event(listDefaultEvent[element].name)}\n';
      }
    }

    return result;
  }
}