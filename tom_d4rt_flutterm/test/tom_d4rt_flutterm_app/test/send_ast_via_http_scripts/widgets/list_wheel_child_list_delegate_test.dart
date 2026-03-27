// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ListWheelChildListDelegate from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ListWheelChildListDelegate test executing');
  print('=' * 50);

  // === Test ListWheelChildListDelegate class ===
  print('\nListWheelChildListDelegate supplies children from an explicit list');

  // Create a delegate with children
  print('\n--- Testing ListWheelChildListDelegate creation ---');
  final children = [
    Text('Apple'),
    Text('Banana'),
    Text('Cherry'),
    Text('Date'),
    Text('Elderberry'),
  ];
  final delegate = ListWheelChildListDelegate(children: children);
  print('Created delegate with ${children.length} children');
  print('delegate.runtimeType: ${delegate.runtimeType}');
  print('delegate.children.length: ${delegate.children.length}');

  // Test estimatedChildCount
  print('\n--- Testing estimatedChildCount ---');
  print('delegate.estimatedChildCount: ${delegate.estimatedChildCount}');

  // Test build method
  print('\n--- Testing build method ---');
  final child0 = delegate.build(context, 0);
  print('build(context, 0): $child0');
  
  final child2 = delegate.build(context, 2);
  print('build(context, 2): $child2');
  
  final childNeg = delegate.build(context, -1);
  print('build(context, -1): $childNeg');
  
  final childOver = delegate.build(context, 10);
  print('build(context, 10): $childOver');

  // Test trueIndexOf
  print('\n--- Testing trueIndexOf ---');
  print('delegate.trueIndexOf(0): ${delegate.trueIndexOf(0)}');
  print('delegate.trueIndexOf(3): ${delegate.trueIndexOf(3)}');
  print('delegate.trueIndexOf(100): ${delegate.trueIndexOf(100)}');

  // Test shouldRebuild
  print('\n--- Testing shouldRebuild ---');
  final delegate2 = ListWheelChildListDelegate(children: children);
  print('Same children list: shouldRebuild = ${delegate.shouldRebuild(delegate2)}');
  
  final delegate3 = ListWheelChildListDelegate(children: [Text('X')]);
  print('Different children: shouldRebuild = ${delegate.shouldRebuild(delegate3)}');

  // Test with empty list
  print('\n--- Testing with empty list ---');
  final emptyDelegate = ListWheelChildListDelegate(children: []);
  print('Empty delegate.estimatedChildCount: ${emptyDelegate.estimatedChildCount}');
  print('Empty delegate.build(context, 0): ${emptyDelegate.build(context, 0)}');

  // Test inheritance
  print('\n--- Testing inheritance ---');
  print('delegate is ListWheelChildDelegate: ${delegate is ListWheelChildDelegate}');

  print('\n' + '=' * 50);
  print('ListWheelChildListDelegate test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ListWheelChildListDelegate Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Children count: ${delegate.children.length}'),
      Text('Estimated: ${delegate.estimatedChildCount}'),
      Text('Is ListWheelChildDelegate: true'),
    ],
  );
}
