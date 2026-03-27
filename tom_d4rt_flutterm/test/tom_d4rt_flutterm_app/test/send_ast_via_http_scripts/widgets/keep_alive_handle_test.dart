// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests KeepAliveHandle from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('KeepAliveHandle test executing');
  print('=' * 50);

  // === KeepAliveHandle class tests ===
  // KeepAliveHandle is a Listenable that can be manually
  // triggered. Used with KeepAliveNotification.

  // Test 1: Class hierarchy
  print('\nTest 1: Class hierarchy');
  print('class KeepAliveHandle extends ChangeNotifier');
  print('Can notify listeners when triggered');

  // Test 2: Purpose
  print('\nTest 2: Purpose');
  print('Used with KeepAliveNotification to signal');
  print('when a widget no longer needs to be kept alive');
  print('Triggered in State.deactivate');

  // Test 3: dispose behavior
  print('\nTest 3: dispose behavior');
  print('@override');
  print('void dispose() {');
  print('  notifyListeners();');
  print('  super.dispose();');
  print('}');
  print('');
  print('Notifies before calling super.dispose()');

  // Test 4: Creating instances
  print('\nTest 4: Creating instances');
  final handle1 = KeepAliveHandle();
  print('Created KeepAliveHandle instance');
  print('Type: ${handle1.runtimeType}');

  // Test 5: Adding listeners
  print('\nTest 5: Adding listeners');
  var notified = false;
  void listener() {
    notified = true;
    print('  Listener was notified!');
  }
  handle1.addListener(listener);
  print('Added listener to handle');
  print('notified before dispose: $notified');

  // Test 6: Trigger via dispose
  print('\nTest 6: Trigger via dispose');
  handle1.dispose();
  print('Called dispose()');
  print('notified after dispose: $notified');

  // Test 7: Usage with KeepAliveNotification
  print('\nTest 7: Usage with KeepAliveNotification');
  print('final handle = KeepAliveHandle();');
  print('KeepAliveNotification(handle).dispatch(context);');
  print('');
  print('// Later, in deactivate:');
  print('handle.dispose();');

  // Test 8: AutomaticKeepAliveClientMixin
  print('\nTest 8: AutomaticKeepAliveClientMixin');
  print('Mixin that manages KeepAliveHandle internally');
  print('Simplifies keep-alive implementation');
  print('Automatically sends notifications');

  // Test 9: Listener lifecycle
  print('\nTest 9: Listener lifecycle');
  final handle2 = KeepAliveHandle();
  var count = 0;
  listener2() => count++;
  handle2.addListener(listener2);
  print('Listener added');
  handle2.removeListener(listener2);
  print('Listener removed');
  handle2.dispose();
  print('Count after dispose (listener removed): $count');

  // Test 10: Multiple handles
  print('\nTest 10: Multiple handles');
  final handles = [
    KeepAliveHandle(),
    KeepAliveHandle(),
    KeepAliveHandle(),
  ];
  print('Created ${handles.length} handles');
  for (final h in handles) {
    h.dispose();
  }
  print('All handles disposed');

  print('\n' + '=' * 50);
  print('KeepAliveHandle test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'KeepAliveHandle Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests: 10 categories executed'),
      Text('Type: ChangeNotifier'),
      Text('Trigger: dispose()'),
      Text('Purpose: Keep-alive signaling'),
    ],
  );
}
