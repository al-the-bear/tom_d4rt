// ignore_for_file: avoid_print
// D4rt test script: Tests NavigatorState access from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('NavigatorState test executing');

  // Access NavigatorState via Navigator.of(context)
  final nav = Navigator.of(context);
  print('NavigatorState obtained: ${nav.runtimeType}');
  print('Navigator canPop: ${nav.canPop()}');

  // Check that the navigator is mounted
  print('Navigator mounted: ${nav.mounted}');

  // Access the overlay if available
  final overlay = nav.overlay;
  print('Navigator overlay: ${overlay?.runtimeType}');

  // Test Navigator.maybeOf (should return same state)
  final maybeNav = Navigator.maybeOf(context);
  print('Navigator.maybeOf: ${maybeNav?.runtimeType}');
  print('Same instance: ${identical(nav, maybeNav)}');

  // Check default route name
  print('Navigator.defaultRouteName: ${Navigator.defaultRouteName}');

  // Don't push/pop — it would leave the test page and break the test harness
  // Just verify the state is accessible and has expected properties

  return Container(
    padding: EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('NavigatorState test passed'),
        Text('runtimeType: ${nav.runtimeType}'),
        Text('canPop: ${nav.canPop()}'),
        Text('mounted: ${nav.mounted}'),
        Text('overlay: ${overlay?.runtimeType}'),
        Text('maybeOf identical: ${identical(nav, maybeNav)}'),
      ],
    ),
  );
}
