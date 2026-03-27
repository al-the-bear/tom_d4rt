// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MultiChildRenderObjectWidget from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiChildRenderObjectWidget test executing');
  print('=' * 50);

  // === Test MultiChildRenderObjectWidget class ===
  print('\nMultiChildRenderObjectWidget is base for multi-child widgets');

  // Test via Row (extends MultiChildRenderObjectWidget)
  print('\n--- Testing via Row ---');
  final row = Row(
    children: [
      Text('One'),
      Text('Two'),
      Text('Three'),
    ],
  );
  print('Created Row (MultiChildRenderObjectWidget)');
  print('row.children.length: ${row.children.length}');
  print('row is MultiChildRenderObjectWidget: ${row is MultiChildRenderObjectWidget}');

  // Test via Column
  print('\n--- Testing via Column ---');
  final column = Column(
    mainAxisSize: MainAxisSize.min,
    children: [Text('A'), Text('B')],
  );
  print('column is MultiChildRenderObjectWidget: ${column is MultiChildRenderObjectWidget}');
  print('column.children: ${column.children}');

  // Test via Stack
  print('\n--- Testing via Stack ---');
  final stack = Stack(
    children: [
      Container(color: Colors.blue),
      Center(child: Text('Center')),
    ],
  );
  print('stack is MultiChildRenderObjectWidget: ${stack is MultiChildRenderObjectWidget}');

  // Test via Flex
  print('\n--- Testing via Flex ---');
  final flex = Flex(
    direction: Axis.horizontal,
    children: [Text('Flex child')],
  );
  print('flex is MultiChildRenderObjectWidget: ${flex is MultiChildRenderObjectWidget}');

  // Test children property
  print('\n--- Testing children property ---');
  print('Children should have Keys for mutation');
  print('Widget is immutable - create new list');

  // Test immutability requirement
  print('\n--- Testing immutability ---');
  print('Do NOT mutate children list directly');
  print('Always create a new list object');
  print('Use toList() for copies');

  // Test via Wrap
  print('\n--- Testing via Wrap ---');
  final wrap = Wrap(
    spacing: 8,
    children: [Text('A'), Text('B'), Text('C')],
  );
  print('wrap.children.length: ${wrap.children.length}');

  // Test via Flow
  print('\n--- Testing via Flow ---');
  print('Flow also extends MultiChildRenderObjectWidget');

  print('\n' + '=' * 50);
  print('MultiChildRenderObjectWidget test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MultiChildRenderObjectWidget Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Row is MCROW: ${row is MultiChildRenderObjectWidget}'),
      Text('Column is MCROW: ${column is MultiChildRenderObjectWidget}'),
      Text('Stack is MCROW: ${stack is MultiChildRenderObjectWidget}'),
    ],
  );
}
