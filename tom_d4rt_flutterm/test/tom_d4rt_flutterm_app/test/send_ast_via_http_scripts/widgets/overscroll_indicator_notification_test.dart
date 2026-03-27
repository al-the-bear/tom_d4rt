// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OverscrollIndicatorNotification from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OverscrollIndicatorNotification test executing');
  print('=' * 50);

  // === Test OverscrollIndicatorNotification class ===
  print('\nOverscrollIndicatorNotification signals overscroll indicator');

  // Create OverscrollIndicatorNotification
  print('\n--- Testing creation ---');
  final notificationLeading = OverscrollIndicatorNotification(leading: true);
  print('Created OverscrollIndicatorNotification(leading: true)');
  print('notificationLeading.leading: ${notificationLeading.leading}');

  final notificationTrailing = OverscrollIndicatorNotification(leading: false);
  print('Created OverscrollIndicatorNotification(leading: false)');
  print('notificationTrailing.leading: ${notificationTrailing.leading}');

  // Test leading property
  print('\n--- Testing leading property ---');
  print('leading: true = top/left edge');
  print('leading: false = bottom/right edge');

  // Test paintOffset property
  print('\n--- Testing paintOffset ---');
  print('notificationLeading.paintOffset: ${notificationLeading.paintOffset}');
  notificationLeading.paintOffset = 50.0;
  print('After setting to 50.0: ${notificationLeading.paintOffset}');
  print('Moves glow away from edge');

  // Test accepted property
  print('\n--- Testing accepted ---');
  print('notificationLeading.accepted: ${notificationLeading.accepted}');
  print('Default is true (indicator will show)');

  // Test disallowIndicator
  print('\n--- Testing disallowIndicator ---');
  notificationLeading.disallowIndicator();
  print('After disallowIndicator()');
  print('accepted: ${notificationLeading.accepted}');
  print('Prevents indicator from showing');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('notificationLeading is Notification: ${notificationLeading is Notification}');

  // Test with NotificationListener
  print('\n--- Testing with NotificationListener ---');
  final listener = NotificationListener<OverscrollIndicatorNotification>(
    onNotification: (notification) {
      print('Received on ${notification.leading ? "leading" : "trailing"} edge');
      notification.disallowIndicator(); // Prevent glow
      return true;
    },
    child: ListView(children: [Text('Content')]),
  );
  print('Created NotificationListener to intercept');

  // Usage pattern
  print('\n--- Usage pattern ---');
  print('Intercept to disable overscroll glow');
  print('Or adjust paintOffset for positioning');

  print('\n' + '=' * 50);
  print('OverscrollIndicatorNotification test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'OverscrollIndicatorNotification Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('leading (true): ${notificationTrailing.leading == false}'),
      Text('paintOffset: ${notificationTrailing.paintOffset}'),
      Text('disallowIndicator(): prevents glow'),
    ],
  );
}
