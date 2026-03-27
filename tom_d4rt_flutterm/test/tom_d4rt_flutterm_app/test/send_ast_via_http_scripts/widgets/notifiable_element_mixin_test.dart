// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests NotifiableElementMixin from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NotifiableElementMixin test executing');
  print('=' * 50);

  // === Test NotifiableElementMixin mixin ===
  print('\nNotifiableElementMixin handles notifications on Element');

  // Describe NotifiableElementMixin
  print('\n--- Understanding NotifiableElementMixin ---');
  print('Mixin for Element classes');
  print('Provides onNotification callback mechanism');
  print('Used by NotificationListener implementation');

  // Key method: onNotification
  print('\n--- Key method: onNotification ---');
  print('bool onNotification(Notification notification)');
  print('Returns true if notification was handled');
  print('Returns false to continue bubbling');

  // Test via NotificationListener
  print('\n--- Testing via NotificationListener ---');
  var handled = false;
  final listener = NotificationListener<ScrollNotification>(
    onNotification: (notification) {
      handled = true;
      print('Received ScrollNotification');
      return true;
    },
    child: ListView(
      children: [Text('Item 1'), Text('Item 2')],
    ),
  );
  print('Created NotificationListener');
  print('listener.runtimeType: ${listener.runtimeType}');

  // Element implements mixin
  print('\n--- Element implementation ---');
  print('NotificationListener creates Element with mixin');
  print('_NotificationElement uses NotifiableElementMixin');

  // Notification bubbling
  print('\n--- Notification bubbling ---');
  print('1. Child dispatches notification');
  print('2. Notification bubbles up tree');
  print('3. Each NotifiableElementMixin.onNotification called');
  print('4. First returning true stops bubbling');

  // Test nested listeners
  print('\n--- Testing nested listeners ---');
  final nested = NotificationListener<ScrollNotification>(
    onNotification: (n) {
      print('Outer listener');
      return false; // Continue bubbling
    },
    child: NotificationListener<ScrollNotification>(
      onNotification: (n) {
        print('Inner listener');
        return true; // Stop bubbling
      },
      child: ListView(children: [Text('Content')]),
    ),
  );
  print('Created nested NotificationListeners');

  // Common notification types
  print('\n--- Common notification types ---');
  print('ScrollNotification, SizeChangedLayoutNotification');
  print('LayoutChangedNotification, KeepAliveNotification');

  print('\n' + '=' * 50);
  print('NotifiableElementMixin test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'NotifiableElementMixin Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Purpose: Handle notifications on Element'),
      Text('Key method: onNotification'),
      SizedBox(height: 50, child: listener),
    ],
  );
}
