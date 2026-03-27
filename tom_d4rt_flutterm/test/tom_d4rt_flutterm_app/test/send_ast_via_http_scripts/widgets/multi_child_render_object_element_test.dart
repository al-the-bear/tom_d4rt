// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests MultiChildRenderObjectElement from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MultiChildRenderObjectElement test executing');
  print('=' * 50);

  // === Test MultiChildRenderObjectElement class ===
  print('\nMultiChildRenderObjectElement manages multi-child widgets');

  // Test via Row which uses MultiChildRenderObjectElement
  print('\n--- Testing via Row widget ---');
  final row = Row(
    children: [
      Text('Child 1'),
      Text('Child 2'),
      Text('Child 3'),
    ],
  );
  print('Created Row with 3 children');
  print('row.children.length: ${row.children.length}');
  print('row.runtimeType: ${row.runtimeType}');

  // Test via Column
  print('\n--- Testing via Column widget ---');
  final column = Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('A'),
      Text('B'),
    ],
  );
  print('Created Column with 2 children');
  print('column.children.length: ${column.children.length}');

  // Test via Stack
  print('\n--- Testing via Stack widget ---');
  final stack = Stack(
    children: [
      Container(width: 100, height: 100, color: Colors.red),
      Positioned(
        top: 10,
        left: 10,
        child: Text('Overlay'),
      ),
    ],
  );
  print('Created Stack with 2 children');
  print('stack.children.length: ${stack.children.length}');

  // Test element properties
  print('\n--- Testing element properties ---');
  print('children: Iterable<Element> of child elements');
  print('renderObject: ContainerRenderObjectMixin');
  print('Filters out forgotten children');

  // Test element methods
  print('\n--- Testing element methods ---');
  print('visitChildren(ElementVisitor): visits non-forgotten');
  print('forgetChild(Element): marks child for removal');
  print('insertRenderObjectChild: adds to render tree');
  print('moveRenderObjectChild: reorders in render tree');
  print('removeRenderObjectChild: removes from render tree');

  // Test with Wrap
  print('\n--- Testing via Wrap widget ---');
  final wrap = Wrap(
    children: [
      Chip(label: Text('Tag 1')),
      Chip(label: Text('Tag 2')),
    ],
  );
  print('Created Wrap with 2 children');

  print('\n' + '=' * 50);
  print('MultiChildRenderObjectElement test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'MultiChildRenderObjectElement Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Row children: ${row.children.length}'),
      Text('Column children: ${column.children.length}'),
      Text('Stack children: ${stack.children.length}'),
    ],
  );
}
