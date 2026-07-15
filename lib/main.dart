import 'package:artriapp/services/notification_service.dart';
import 'package:artriapp/views/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  await NotificationService.instance.init();

  runApp(App());
}
