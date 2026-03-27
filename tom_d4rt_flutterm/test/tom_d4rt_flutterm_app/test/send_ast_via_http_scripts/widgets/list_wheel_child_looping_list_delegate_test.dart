// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ListWheelChildLoopingListDelegate from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ListWheelChildLoopingListDelegate test executing');
  print('=' * 50);

  // === Test ListWheelChildLoopingListDelegate class ===
  print('\nListWheelChildLoopingListDelegate provides infinite looping children');

  // Create a delegate with children
  print('\n--- Testing creation ---');
  final children = [
    Text('One'),
    Text('Two'),
    Text('Three'),
  ];
  final delegate = ListWheelChildLoopingListDelegate(children: children);
  print('Created looping delegate with ${children.length} children');
  print('delegate.runtimeType: ${delegate.runtimeType}');
  print('delegate.children.length: ${delegate.children.length}');

  // Test estimatedChildCount
  print('\n--- Testing estimatedChildCount ---');
  print('delegate.estimatedChildCount: ${delegate.estimatedChildCount}');
  print('Returns null for infinite looping');

  // Test build method - looping behavior
  print('\n--- Testing build method with looping ---');
  final child0 = delegate.build(context, 0);
  print('build(context, 0): $child0');
  
  final child1 = delegate.build(context, 1);
  print('build(context, 1): $child1');
  
  final child3 = delegate.build(context, 3);
  print('build(context, 3): $child3');
  print('Index 3 loops back to index 0');
  
  final child5 = delegate.build(context, 5);
  print('build(context, 5): $child5');
  print('Index 5 loops to index 2');

  // Test negative indices
  print('\n--- Testing negative indices ---');
  final childNeg1 = delegate.build(context, -1);
  print('build(context, -1): $childNeg1');
  
  final childNeg3 = delegate.build(context, -3);
  print('build(context, -3): $childNeg3');

  // Test trueIndexOf - key feature for looping
  print('\n--- Testing trueIndexOf ---');
  print('trueIndexOf(0): ${delegate.trueIndexOf(0)}');
  print('trueIndexOf(3): ${delegate.trueIndexOf(3)}');
  print('trueIndexOf(5): ${delegate.trueIndexOf(5)}');
  print('trueIndexOf(10): ${delegate.trueIndexOf(10)}');
  print('trueIndexOf(-1): ${delegate.trueIndexOf(-1)}');
  print('trueIndexOf(-5): ${delegate.trueIndexOf(-5)}');

  // Test shouldRebuild
  print('\n--- Testing shouldRebuild ---');
  final delegate2 = ListWheelChildLoopingListDelegate(children: children);
  print('Same list: shouldRebuild = ${delegate.shouldRebuild(delegate2)}');

  // Test with empty list
  print('\n--- Testing edge case: empty list ---');
  final emptyDelegate = ListWheelChildLoopingListDelegate(children: []);
  print('Empty build(0): ${emptyDelegate.build(context, 0)}');

  print('\n' + '=' * 50);
  print('ListWheelChildLoopingListDelegate test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ListWheelChildLoopingListDelegate Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Children: ${delegate.children.length}'),
      Text('Estimated: ${delegate.estimatedChildCount ?? "null (infinite)"}'),
      Text('trueIndexOf(5): ${delegate.trueIndexOf(5)}'),
    ],
  );
}
