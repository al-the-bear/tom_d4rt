// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OverscrollNotification from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OverscrollNotification test executing');
  print('=' * 50);

  // === Test OverscrollNotification class ===
  print('\nOverscrollNotification signals scroll beyond bounds');

  // Describe OverscrollNotification
  print('\n--- Understanding OverscrollNotification ---');
  print('Extends ScrollNotification');
  print('Sent when scrollable overscrolls');
  print('Contains overscroll amount and velocity');

  // Key properties
  print('\n--- Key properties ---');
  print('overscroll: double - pixels beyond bounds');
  print('  Negative = start, Positive = end');
  print('velocity: double - speed when overscrolled');
  print('  Typically 0 for touch, positive for ballistic');
  print('dragDetails: DragUpdateDetails? - if drag caused it');

  // Test with NotificationListener
  print('\n--- Testing with NotificationListener ---');
  var lastOverscroll = 0.0;
  var lastVelocity = 0.0;
  final listener = NotificationListener<OverscrollNotification>(
    onNotification: (notification) {
      lastOverscroll = notification.overscroll;
      lastVelocity = notification.velocity;
      print('Overscroll: ${notification.overscroll.toStringAsFixed(1)}');
      print('Velocity: ${notification.velocity.toStringAsFixed(1)}');
      print('Has dragDetails: ${notification.dragDetails != null}');
      return false; // Don't consume
    },
    child: ListView.builder(
      physics: BouncingScrollPhysics(),
      itemCount: 5,
      itemBuilder: (ctx, i) => ListTile(title: Text('Item $i')),
    ),
  );
  print('Created NotificationListener');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('Extends ScrollNotification');
  print('Has metrics, context properties');

  // Comparison with other notifications
  print('\n--- Scroll notification types ---');
  print('ScrollStartNotification: scroll began');
  print('ScrollUpdateNotification: scroll position changed');
  print('OverscrollNotification: scrolled beyond bounds');
  print('ScrollEndNotification: scroll ended');

  // Use cases
  print('\n--- Use cases ---');
  print('Pull-to-refresh implementation');
  print('Custom overscroll effects');
  print('Analytics for user behavior');

  print('\n' + '=' * 50);
  print('OverscrollNotification test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'OverscrollNotification Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Key: overscroll amount'),
      Text('Key: velocity'),
      SizedBox(height: 100, child: listener),
    ],
  );
}
