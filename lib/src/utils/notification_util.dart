
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:h2o_keeper/generated/l10n.dart';
import 'package:h2o_keeper/src/models/charts_item.dart';
import 'package:h2o_keeper/src/utils/cache_util.dart';
import 'package:h2o_keeper/src/utils/time_ext.dart';
import 'package:intl/intl.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationUtil {
  static final _shared = NotificationUtil._internal();
  NotificationUtil._internal();
  factory NotificationUtil() => _shared;

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

  register() async {
    var initializationSettingsIOS = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) {
      },
    );

    var initializationSettings = InitializationSettings(
      iOS: initializationSettingsIOS,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    await _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>()?.requestPermissions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  appendReminder(String item) async {
    final formatter =DateFormat("yyy-MM-dd HH:mm");
    final s = DateTime.now().dateString;
    final date = formatter.parse("$s $item");
    final nowDate = DateTime.now();
    int duration = 0;
    // 当前时间已过
    if(date.compareTo(nowDate) < 0) {
      duration = 3600 * 24 - calculateTotalSecondsDifference(date, nowDate);
    } else {
      duration = calculateTotalSecondsDifference(nowDate, date);
    }

    var iOSPlatformChannelSpecifics = const DarwinNotificationDetails(
      presentAlert: true,
      presentSound: true,
    );
    var platformChannelSpecifics = NotificationDetails(
      iOS: iOSPlatformChannelSpecifics,
    );

    final id = date.minute + date.hour * 60 ;

    tz.initializeTimeZones();
    final time = tz.TZDateTime.from(nowDate.add(Duration(seconds: duration)), tz.local);
    final title = S.current.tip;
    final body = S.current.noti;

    await _flutterLocalNotificationsPlugin.cancel(id);

    final isOn = await CacheUtil().getWeekMode();
    // 如果是周末并且开了周末模式就不添加该本地通知了
    if (isOn && nowDate.isWeekend) {
      return;
    }

    await _flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        time,
        platformChannelSpecifics,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  removeReminder(String item) async {
    final formatter =DateFormat("yyy-MM-dd HH:mm");
    final s = DateTime.now().dateString;
    final date = formatter.parse("$s $item");
    final id = date.second + date.minute * 60 ;
    await _flutterLocalNotificationsPlugin.cancel(id);
  }

  int calculateTotalSecondsDifference(DateTime dateTime1, DateTime dateTime2) {
    // 将 DateTime 转换为 Unix 时间戳（秒）
    int unixTimestamp1 = dateTime1.millisecondsSinceEpoch ~/ 1000;
    int unixTimestamp2 = dateTime2.millisecondsSinceEpoch ~/ 1000;

    // 计算总秒数差
    int totalSecondsDifference = unixTimestamp2 - unixTimestamp1;

    return totalSecondsDifference;
  }

}
