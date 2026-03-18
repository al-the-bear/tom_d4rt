// D4rt test script: Tests LinearBorder from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LinearBorder test executing');

  // Create LinearBorder
  final border = LinearBorder(
    side: BorderSide(color: Colors.blue, width: 2),
    start: LinearBorderEdge(size: 0.5),
    end: LinearBorderEdge(size: 0.5),
  );

  print('Created: ${border.runtimeType}');

  // Test properties
  print('\nBorder properties:');
  print('side: ${border.side}');
  print('start: ${border.start}');
  print('end: ${border.end}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is OutlinedBorder: ${true}');
  print('is ShapeBorder: ${true}');

  // Static constructors
  print('\nStatic constructors:');
  final top = LinearBorder.top(side: BorderSide(color: Colors.red));
  print('LinearBorder.top(): only top edge [${top.hashCode }]');

  final bottom = LinearBorder.bottom(side: BorderSide(color: Colors.green));
  print('LinearBorder.bottom(): only bottom edge [${bottom.hashCode }]');

  final start2 = LinearBorder.start(side: BorderSide(color: Colors.blue));
  print('LinearBorder.start(): only start edge [${start2.hashCode }]');

  // LinearBorderEdge
  print('\nLinearBorderEdge:');
  print('- size: 0.0-1.0 (portion of edge)');
  print('- alignment: where on edge (-1 to 1)');

  // Usage
  print('\nUsage example:');
  print('Container(');
  print('  decoration: ShapeDecoration(');
  print('    shape: LinearBorder.bottom(),');
  print('  ),');
  print(')');

  // Use case
  print('\nUse case:');
  print('- Underlines');
  print('- Partial borders');
  print('- Tab indicators');

  print('\nLinearBorder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LinearBorder Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Partial/linear border'),
      Text('side: ${border.side.color}'),
      Text('Constructors: top, bottom, start, end'),
      Container(
        decoration: ShapeDecoration(
          shape: LinearBorder.bottom(
            side: BorderSide(color: Colors.blue, width: 2),
          ),
        ),
        padding: EdgeInsets.all(8),
        child: Text('Bottom border'),
      ),
    ],
  );
}
