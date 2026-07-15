import 'package:artriapp/utils/enums/days_of_week.dart';
import 'package:artriapp/utils/reminder_scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> notificationBackgroundHandler(NotificationResponse response) async {
}

class NotificationService {
  static const _channelId = 'artriapp_remedy_channel';
  static const _channelName = 'Lembretes de Medicamentos';
  static const _channelDescription = 'Notificações para lembrar de tomar os medicamentos';

  final ReminderScheduler _scheduler = ReminderScheduler();

  Future<void> init() async {
    tz_data.initializeTimeZones();

    const androidSettings = AndroidInitializationSettings('@mipmap/launcher_icon');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onDidReceiveNotificationResponse: notificationBackgroundHandler,
    );

    final androidPlugin = flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();

    await androidPlugin?.createNotificationChannel(
      const AndroidNotificationChannel(
        _channelId,
        _channelName,
        description: _channelDescription,
        importance: Importance.high,
        playSound: true,
        enableVibration: true,
      ),
    );

    await androidPlugin?.requestNotificationsPermission();
    await androidPlugin?.requestExactAlarmsPermission();
  }

  int _notificationId(int remedyId) => remedyId;

  Future<void> scheduleRemedyReminder({
    required int remedyId,
    required String remedyName,
    required String hour,
    List<DaysOfWeek> daysOfWeek = const [],
  }) async {
    final timeParts = hour.split(':');
    if (timeParts.length != 2) return;
    final hourInt = int.tryParse(timeParts[0]) ?? 0;
    final minuteInt = int.tryParse(timeParts[1]) ?? 0;

    final scheduledDate = _scheduler.calculateNextSchedule(
      hourInt: hourInt,
      minuteInt: minuteInt,
      daysOfWeek: daysOfWeek,
    );

    final androidDetails = AndroidNotificationDetails(
      _channelId,
      _channelName,
      channelDescription: _channelDescription,
      importance: Importance.high,
      priority: Priority.high,
      icon: '@mipmap/launcher_icon',
    );
    final iosDetails = DarwinNotificationDetails();
    final details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    final tzScheduledDate = tz.TZDateTime.from(scheduledDate, tz.local);

    await flutterLocalNotificationsPlugin.zonedSchedule(
      _notificationId(remedyId),
      'Hora do Medicamento',
      'Está na hora de tomar $remedyName',
      tzScheduledDate,
      details,
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
    );
  }

  Future<void> cancelReminder(int remedyId) async {
    await flutterLocalNotificationsPlugin.cancel(_notificationId(remedyId));
  }

  Future<void> cancelAllReminders() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> rescheduleAll(List<RemedyNotification> remedies) async {
    await cancelAllReminders();
    for (final r in remedies) {
      await scheduleRemedyReminder(
        remedyId: r.remedyId,
        remedyName: r.remedyName,
        hour: r.hour,
        daysOfWeek: r.daysOfWeek,
      );
    }
  }
}

class RemedyNotification {
  final int remedyId;
  final String remedyName;
  final String hour;
  final List<DaysOfWeek> daysOfWeek;

  const RemedyNotification({
    required this.remedyId,
    required this.remedyName,
    required this.hour,
    this.daysOfWeek = const [],
  });
}
