import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final storage = new FlutterSecureStorage();

class NotificationAPI {
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future _notificationDetails() async {
    return NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channel name',
        importance: Importance.max,
        channelShowBadge: true,
        onlyAlertOnce: true,
        channelDescription: 'channel description',
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future init({onSelectNotification}) async {
    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = IOSInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);

//whenapps gone

    final details = await _notifications.getNotificationAppLaunchDetails();
    if (details != null && details.didNotificationLaunchApp) {
      onNotifications.add(details.payload);
      onSelectNotification(details.payload);
    }

    await _notifications.initialize(
      settings,
      onSelectNotification: (
        payload,
      ) async {
        onNotifications.add(payload);
        onSelectNotification(payload);
      },
    );
  }

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );

  static Future showScheduledNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required scheduledDate,
  }) async {
    return _notifications.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(scheduledDate, tz.local),
      await _notificationDetails(),
      payload: payload,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static void cancelAll() => _notifications.cancelAll();
  static void cancel(int id) => _notifications.cancel(id);
}

Future setLocalReminder() async {
  List reminderRSP = [];
  List reminderset = [];

  DateTime now = DateTime.now();
  var token = await storage.read(key: 'token');

  var url = Uri.parse("https://webino.id/api/reminder");
  var response = await http.get(
    url,
    headers: {
      'Authorization': 'Bearer $token',
      "Accept": "Application/json",
    },
  );
  var reminderSetRSP = jsonDecode(response.body);
  reminderRSP = reminderSetRSP['data'];
  if (reminderRSP.length > 0) {
    reminderRSP.forEach((element) {
      if ((now.isBefore(DateTime.tryParse(element['tgl'])!)) == true) {
        reminderset.add(element);
      }
    });
    reminderset.forEach((element) {
      Map a = element;
      a.remove("kota");
      a.remove("tanggal_acara");
      element = a;
      return element;
    });
    //  int localID = 0;

    reminderset.forEach((element) {
      int reminderID = element['id'] * 10;

      if (element['notification_1'] != null) {
        var localID = reminderID + 1;

        var body1 = element['product_name'];
        var dateParse1 = DateTime.tryParse(element['notification_1']);
        String? paylord = jsonEncode(element);
        if ((now.isBefore(dateParse1!)) == true)
          NotificationAPI.showScheduledNotification(
            id: localID,
            title: 'Reminder - Yuk, Jangan Lewatkan Acara pilihanmu',
            body: body1,
            payload: paylord,
            scheduledDate: dateParse1,
          );
      }
      if (element['notification_2'] != null) {
        var localID = reminderID + 2;
        var body2 = element['product_name'];
        String? paylord = jsonEncode(element);
        var dateParse2 = DateTime.tryParse(element['notification_2']);
        if ((now.isBefore(dateParse2!)) == true)
          NotificationAPI.showScheduledNotification(
            id: localID,
            title: 'Reminder - Yuk, Jangan Lewatkan Acara pilihanmu',
            body: body2,
            payload: paylord,
            scheduledDate: dateParse2,
          );
      }
      if (element['notification_3'] != null) {
        var localID = reminderID + 3;
        var body3 = element['product_name'];
        String? paylord = jsonEncode(element);
        var dateParse3 = DateTime.tryParse(element['notification_3']);
        if ((now.isBefore(dateParse3!)) == true)
          NotificationAPI.showScheduledNotification(
            id: localID,
            title: 'Reminder - Yuk, Jangan Lewatkan Acara pilihanmu',
            body: body3,
            payload: paylord,
            scheduledDate: dateParse3,
          );
      }
    });

    return "Local set";
  } else {
    return "";
  }
}
