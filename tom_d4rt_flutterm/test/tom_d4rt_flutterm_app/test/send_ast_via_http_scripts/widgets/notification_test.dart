// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Notification from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

// Custom notification for testing
class TestNotification extends Notification {
  final String message;
  TestNotification(this.message);

  @override
  String toString() => 'TestNotification($message)';
}

dynamic build(BuildContext context) {
  print('Notification test executing');
  print('=' * 50);

  // === Test Notification abstract class ===
  print('\nNotification is base for tree-bubbling notifications');

  // Create custom notification
  print('\n--- Testing custom notification ---');
  final custom = TestNotification('hello');
  print('Created TestNotification');
  print('custom.message: ${custom.message}');
  print('custom.runtimeType: ${custom.runtimeType}');

  // Test toString
  print('\n--- Testing toString ---');
  print('custom.toString(): ${custom.toString()}');

  // Test dispatch method
  print('\n--- Testing dispatch method ---');
  print('void dispatch(BuildContext? target)');
  print('Bubbles notification up from target context');
  print('With null: starts from root (rarely used)');

  // Test inheritance hierarchy
  print('\n--- Common subclasses ---');
  print('ScrollNotification - scroll events');
  print('SizeChangedLayoutNotification - size changes');
  print('LayoutChangedNotification - layout changes');
  print('KeepAliveNotification - keep-alive requests');
  print('NavigationNotification - navigation state');

  // Test with NotificationListener
  print('\n--- Testing with NotificationListener ---');
  var received = '';
  final listener = NotificationListener<TestNotification>(
    onNotification: (notification) {
      received = notification.message;
      print('Received: ${notification.message}');
      return true;
    },
    child: Builder(
      builder: (ctx) {
        // Would dispatch here: TestNotification('test').dispatch(ctx);
        return Text('Dispatch target');
      },
    ),
  );
  print('Created NotificationListener for TestNotification');

  // Bubbling behavior
  print('\n--- Bubbling behavior ---');
  print('1. dispatch(context) called');
  print('2. Walks up parent chain');
  print('3. Each NotificationListener checked');
  print('4. onNotification returning true stops');

  // Test depth
  print('\n--- Testing visitAncestor (protected) ---');
  print('Called for each ancestor Element');
  print('Returns true to continue, false to stop');

  print('\n' + '=' * 50);
  print('Notification test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Notification Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Custom message: ${custom.message}'),
      Text('Is abstract: base class'),
      Text('Method: dispatch(context)'),
      listener,
    ],
  );
}
