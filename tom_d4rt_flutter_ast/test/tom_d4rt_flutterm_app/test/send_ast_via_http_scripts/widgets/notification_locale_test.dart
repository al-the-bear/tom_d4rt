// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NotificationListener, SizeChangedLayoutNotifier,
// LayoutChangedNotification, WidgetsLocalizations
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Notification/Localizations test executing');

  // ========== SizeChangedLayoutNotifier ==========
  print('--- SizeChangedLayoutNotifier Tests ---');
  final notifier = SizeChangedLayoutNotifier(
    child: Container(width: 100, height: 100, color: Colors.blue),
  );
  print('SizeChangedLayoutNotifier created: $notifier');

  // ========== WidgetsLocalizations ==========
  print('--- WidgetsLocalizations Tests ---');
  final locale = Localizations.localeOf(context);
  print('Current locale: $locale');

  // DefaultWidgetsLocalizations
  final defaultLoc = DefaultWidgetsLocalizations();
  print('DefaultWidgetsLocalizations created');
  print('  textDirection: ${defaultLoc.textDirection}');

  // ========== NotificationListener ==========
  print('--- NotificationListener Tests ---');
  final listener = NotificationListener<SizeChangedLayoutNotification>(
    onNotification: (notification) {
      print('  Size changed notification received');
      return true;
    },
    child: SizeChangedLayoutNotifier(child: Text('Monitored widget')),
  );
  print('NotificationListener created: $listener');

  // ========== KeepAlive ==========
  print('--- KeepAlive Tests ---');
  final keepAlive = KeepAlive(keepAlive: true, child: Text('Kept alive'));
  print('KeepAlive created: keepAlive=${keepAlive.keepAlive}');

  // ========== WidgetsApp ==========
  print('--- WidgetsApp concepts ---');
  print('WidgetsBinding exists');

  print('All notification/localizations tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: NotificationListener<SizeChangedLayoutNotification>(
        onNotification: (notification) {
          return true;
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Notification/Localizations Test',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              ),
              SizedBox(height: 16.0),
              SizeChangedLayoutNotifier(
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.blue.shade100,
                  child: Center(child: Text('Notifier')),
                ),
              ),
              SizedBox(height: 8.0),
              Text('Locale: ${Localizations.localeOf(context)}'),
            ],
          ),
        ),
      ),
    ),
  );
}
