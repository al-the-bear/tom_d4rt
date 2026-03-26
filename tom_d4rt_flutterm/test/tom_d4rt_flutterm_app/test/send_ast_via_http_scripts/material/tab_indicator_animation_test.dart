// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TabIndicatorAnimation from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TabIndicatorAnimation test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nTabIndicatorAnimation values:');
  for (final value in TabIndicatorAnimation.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('TabIndicatorAnimation has ${TabIndicatorAnimation.values.length} values');

  // First and last
  final first = TabIndicatorAnimation.values.first;
  final last = TabIndicatorAnimation.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('linear: ${TabIndicatorAnimation.linear.name} (index ${TabIndicatorAnimation.linear.index})');
  print('elastic: ${TabIndicatorAnimation.elastic.name} (index ${TabIndicatorAnimation.elastic.index})');

  // Usage description
  print('\nUsage context:');
  print('linear: Indicator moves linearly between tabs');
  print('  Standard animation with constant velocity');
  print('  Classic Material Design tab indicator behavior');
  print('elastic: Indicator stretches and snaps between tabs');
  print('  Material 3 style animation with elastic effect');
  print('  Indicator widens during transition then contracts');

  // Equality
  print('\nEquality tests:');
  print('linear == linear: ${TabIndicatorAnimation.linear == TabIndicatorAnimation.linear}');
  print('linear == elastic: ${TabIndicatorAnimation.linear == TabIndicatorAnimation.elastic}');
  print('identical: ${identical(TabIndicatorAnimation.linear, TabIndicatorAnimation.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is TabIndicatorAnimation: ${first is TabIndicatorAnimation}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in TabIndicatorAnimation.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Usage with TabBar
  print('\nTabBar integration:');
  for (final animation in TabIndicatorAnimation.values) {
    print('  TabIndicatorAnimation.${animation.name} can be passed to TabBar.indicatorAnimation');
  }

  // Comparison of behaviors
  print('\nAnimation behavior comparison:');
  print('  linear: width stays constant during transition');
  print('  elastic: width changes during transition');
  print('  linear: position interpolates evenly');
  print('  elastic: position uses spring-like curve');

  // Indexed iteration
  print('\nIndexed iteration:');
  for (var i = 0; i < TabIndicatorAnimation.values.length; i++) {
    final v = TabIndicatorAnimation.values[i];
    print('  [$i] ${v.name} (index=${v.index})');
  }

  // Collection operations
  print('\nCollection operations:');
  final reversed = TabIndicatorAnimation.values.reversed.toList();
  print('  Reversed: ${reversed.map((v) => v.name).join(', ')}');
  print('  Contains linear: ${TabIndicatorAnimation.values.contains(TabIndicatorAnimation.linear)}');
  print('  IndexOf elastic: ${TabIndicatorAnimation.values.indexOf(TabIndicatorAnimation.elastic)}');

  print('\n' + '=' * 50);
  print('TabIndicatorAnimation test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TabIndicatorAnimation Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${TabIndicatorAnimation.values.length}'),
      for (final v in TabIndicatorAnimation.values)
        Text('  ${v.name} (${v.index})'),
      Text('TabBar: all animations supported'),
    ],
  );
}
