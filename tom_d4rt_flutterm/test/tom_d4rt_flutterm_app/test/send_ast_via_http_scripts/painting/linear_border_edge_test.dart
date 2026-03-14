// D4rt test script: Tests LinearBorderEdge from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LinearBorderEdge test executing');

  // Create LinearBorderEdge
  final edge = LinearBorderEdge(size: 0.5, alignment: 0.0);

  print('Created: ${edge.runtimeType}');

  // Test properties
  print('\nEdge properties:');
  print('size: ${edge.size}');
  print('alignment: ${edge.alignment}');

  // Size values
  print('\nSize meaning:');
  print('0.0 = no edge');
  print('0.5 = half the edge');
  print('1.0 = full edge');

  // Alignment values
  print('\nAlignment meaning:');
  print('-1.0 = start of edge');
  print('0.0 = center of edge');
  print('1.0 = end of edge');

  // Examples
  print('\nExamples:');
  final startEdge = LinearBorderEdge(size: 0.3, alignment: -1.0);
  print('Start third: size=0.3, alignment=-1.0');

  final centerEdge = LinearBorderEdge(size: 0.5, alignment: 0.0);
  print('Center half: size=0.5, alignment=0.0');

  final endEdge = LinearBorderEdge(size: 0.3, alignment: 1.0);
  print('End third: size=0.3, alignment=1.0');

  // Usage with LinearBorder
  print('\nUsage with LinearBorder:');
  print('LinearBorder(');
  print('  start: LinearBorderEdge(size: 0.5),');
  print('  end: LinearBorderEdge(size: 0.5),');
  print(')');

  // None constant
  print('\nNone constant:');
  print('LinearBorderEdge.none = size 0, no edge');

  print('\nLinearBorderEdge test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LinearBorderEdge Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Partial edge definition'),
      Text('size: ${edge.size} (0-1)'),
      Text('alignment: ${edge.alignment} (-1 to 1)'),
      Text('Used by: LinearBorder'),
    ],
  );
}
