// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ListWheelChildBuilderDelegate from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ListWheelChildBuilderDelegate test executing');
  print('=' * 50);

  // === Test ListWheelChildBuilderDelegate class ===
  print('\nListWheelChildBuilderDelegate supplies children using a builder');

  // Create a delegate with builder
  print('\n--- Testing ListWheelChildBuilderDelegate creation ---');
  final delegate = ListWheelChildBuilderDelegate(
    builder: (context, index) {
      if (index < 0 || index >= 10) return null;
      return Text('Item $index');
    },
    childCount: 10,
  );
  print('Created delegate with childCount: 10');
  print('delegate.runtimeType: ${delegate.runtimeType}');
  print('delegate.childCount: ${delegate.childCount}');

  // Test estimatedChildCount
  print('\n--- Testing estimatedChildCount ---');
  print('delegate.estimatedChildCount: ${delegate.estimatedChildCount}');

  // Test build method
  print('\n--- Testing build method ---');
  final child0 = delegate.build(context, 0);
  print('build(context, 0): $child0');
  print('build(context, 0) is Text: ${child0 is Text}');
  
  final child5 = delegate.build(context, 5);
  print('build(context, 5): $child5');
  
  final childNeg = delegate.build(context, -1);
  print('build(context, -1): $childNeg');
  
  final childOver = delegate.build(context, 15);
  print('build(context, 15): $childOver');

  // Test trueIndexOf (default implementation)
  print('\n--- Testing trueIndexOf ---');
  print('delegate.trueIndexOf(5): ${delegate.trueIndexOf(5)}');
  print('delegate.trueIndexOf(100): ${delegate.trueIndexOf(100)}');

  // Test without childCount
  print('\n--- Testing without childCount ---');
  final unboundedDelegate = ListWheelChildBuilderDelegate(
    builder: (context, index) => Text('Unbounded $index'),
  );
  print('Created unbounded delegate');
  print('unboundedDelegate.childCount: ${unboundedDelegate.childCount}');
  print('unboundedDelegate.estimatedChildCount: ${unboundedDelegate.estimatedChildCount}');

  // Test shouldRebuild
  print('\n--- Testing shouldRebuild ---');
  final delegate2 = ListWheelChildBuilderDelegate(
    builder: (context, index) => Text('Item $index'),
    childCount: 10,
  );
  print('shouldRebuild with different delegate: ${delegate.shouldRebuild(delegate2)}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('delegate is ListWheelChildDelegate: ${delegate is ListWheelChildDelegate}');

  print('\n' + '=' * 50);
  print('ListWheelChildBuilderDelegate test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ListWheelChildBuilderDelegate Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('childCount: ${delegate.childCount}'),
      Text('estimatedChildCount: ${delegate.estimatedChildCount}'),
      Text('Is ListWheelChildDelegate: ${delegate is ListWheelChildDelegate}'),
    ],
  );
}
