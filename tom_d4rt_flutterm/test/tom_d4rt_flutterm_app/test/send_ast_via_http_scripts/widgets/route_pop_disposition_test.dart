// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RoutePopDisposition from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RoutePopDisposition test executing');
  print('=' * 50);

  // RoutePopDisposition indicates how a route should handle pop requests
  print('\nRoutePopDisposition Analysis:');
  print('  Type: enum');
  print('  Purpose: Return value for Route.willPop');
  print('  Used with: WillPopScope, back button handling');

  // Enumerate all values
  print('\nRoutePopDisposition values:');
  for (final value in RoutePopDisposition.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('RoutePopDisposition has ${RoutePopDisposition.values.length} values');

  // Test each value in detail
  print('\nDetailed Value Analysis:');

  // pop
  final pop = RoutePopDisposition.pop;
  print('\n1. RoutePopDisposition.pop:');
  print('   Name: ${pop.name}');
  print('   Index: ${pop.index}');
  print('   Effect: Pop the route');
  print('   Back button: Will pop current route');

  // doNotPop
  final doNotPop = RoutePopDisposition.doNotPop;
  print('\n2. RoutePopDisposition.doNotPop:');
  print('   Name: ${doNotPop.name}');
  print('   Index: ${doNotPop.index}');
  print('   Effect: Ignore the pop request');
  print('   Back button: Will be ignored');

  // bubble
  final bubble = RoutePopDisposition.bubble;
  print('\n3. RoutePopDisposition.bubble:');
  print('   Name: ${bubble.name}');
  print('   Index: ${bubble.index}');
  print('   Effect: Delegate to next level');
  print('   Back button: Handled by SystemNavigator');
  print('   Note: Usually closes the application');

  // First and last values
  print('\nBoundary Values:');
  final first = RoutePopDisposition.values.first;
  final last = RoutePopDisposition.values.last;
  print('  First: $first (index ${first.index})');
  print('  Last: $last (index ${last.index})');

  // Equality and comparison
  print('\nEquality Tests:');
  print('  pop == pop: ${pop == RoutePopDisposition.pop}');
  print('  pop == doNotPop: ${pop == doNotPop}');
  print('  bubble == bubble: ${bubble == RoutePopDisposition.bubble}');

  // Usage pattern
  print('\nUsage Pattern:');
  print('  Route.willPop returns Future<RoutePopDisposition>');
  print('  Or Route.popDisposition getter returns RoutePopDisposition');

  print('\n' + '=' * 50);
  print('RoutePopDisposition test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RoutePopDisposition Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Value count: ${RoutePopDisposition.values.length}'),
      Text('pop index: ${pop.index}'),
      Text('doNotPop index: ${doNotPop.index}'),
      Text('bubble index: ${bubble.index}'),
    ],
  );
}
