// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableRouteFuture from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableRouteFuture test executing');
  print('=' * 50);

  // RestorableRouteFuture manages route futures
  print('RestorableRouteFuture<T>:');
  print('Purpose: Manage and restore route navigation futures');
  print('Extends: RestorableProperty<String?>');
  print('');

  // Constructor
  print('Constructor parameters:');
  print('  navigatorFinder: NavigatorFinderCallback');
  print('    - Finds Navigator from context');
  print('    - Default uses Navigator.of(context)');
  print('');
  print('  onPresent: RoutePresentationCallback');
  print('    - Required: Pushes route to navigator');
  print('    - Must use restorable push methods');
  print('');
  print('  onComplete: RouteCompletionCallback<T>?');
  print('    - Optional: Called when route completes');
  print('    - Receives route return value');
  print('');

  // Key methods
  print('Key methods:');
  print('  void present([Object? arguments])');
  print('    - Shows route via onPresent callback');
  print('    - Arguments passed to route builder');
  print('');
  print('  bool get isPresent');
  print('    - True while route is showing');
  print('');
  print('  Route<T>? get route');
  print('    - The current route object');
  print('');

  // Serialization
  print('Serialization:');
  print('  Stores: route.restorationScopeId.value');
  print('  Restores: Finds route by ID in navigator');
  print('');

  // Restoration behavior
  print('Restoration behavior:');
  print('  1. Route ID stored in restoration data');
  print('  2. On restore, finds route by ID');
  print('  3. Re-hooks onComplete callback');
  print('  4. Route continues from restored state');
  print('');

  // Use case
  print('Typical use case:');
  print('  - Dialog returning a value');
  print('  - Form pushing details page');
  print('  - Navigation with expected result');
  print('');

  // Type info
  print('Type information:');
  final placeholder = RestorableRouteFuture<String>(
    onPresent: (navigator, arguments) => '',
  );
  print('is RestorableProperty: ${placeholder is RestorableProperty}');
  placeholder.dispose();

  print('\n' + '=' * 50);
  print('RestorableRouteFuture test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableRouteFuture Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Manages route navigation futures'),
      Text('Uses restorable push methods'),
      Text('Handles route result callbacks'),
    ],
  );
}
