// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NavigationNotification from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigationNotification test executing');
  print('=' * 50);

  // === Test NavigationNotification class ===
  print('\nNavigationNotification signals navigation changes');

  // Create a NavigationNotification with canHandlePop = true
  print('\n--- Testing creation with canHandlePop = true ---');
  final notifTrue = NavigationNotification(canHandlePop: true);
  print('Created NavigationNotification(canHandlePop: true)');
  print('notifTrue.canHandlePop: ${notifTrue.canHandlePop}');
  print('notifTrue.runtimeType: ${notifTrue.runtimeType}');

  // Create with canHandlePop = false
  print('\n--- Testing creation with canHandlePop = false ---');
  final notifFalse = NavigationNotification(canHandlePop: false);
  print('Created NavigationNotification(canHandlePop: false)');
  print('notifFalse.canHandlePop: ${notifFalse.canHandlePop}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('notifTrue is Notification: ${notifTrue is Notification}');

  // Test toString
  print('\n--- Testing toString ---');
  print('notifTrue.toString(): ${notifTrue.toString()}');
  print('notifFalse.toString(): ${notifFalse.toString()}');

  // Test dispatch method
  print('\n--- Testing dispatch method ---');
  print('dispatch(BuildContext?) bubbles notification up');
  print('Inherited from Notification base class');

  // Test with NotificationListener
  print('\n--- Testing with NotificationListener ---');
  var receivedCount = 0;
  final listener = NotificationListener<NavigationNotification>(
    onNotification: (notification) {
      receivedCount++;
      print('Received: canHandlePop=${notification.canHandlePop}');
      return true; // Stop bubbling
    },
    child: Builder(
      builder: (ctx) {
        print('Can dispatch from nested context');
        return Text('Navigation test');
      },
    ),
  );
  print('Created NotificationListener for NavigationNotification');

  // Usage context
  print('\n--- Usage context ---');
  print('Sent by Navigator when navigation state changes');
  print('Used by AppBar back button visibility');
  print('canHandlePop: true means route can be popped');

  print('\n' + '=' * 50);
  print('NavigationNotification test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NavigationNotification Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('canHandlePop (true): ${notifTrue.canHandlePop}'),
      Text('canHandlePop (false): ${notifFalse.canHandlePop}'),
      Text('Is Notification: ${notifTrue is Notification}'),
      listener,
    ],
  );
}
