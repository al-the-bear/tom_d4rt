// D4rt test script: Tests FittedSizes from painting
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('FittedSizes test executing');

  // Create FittedSizes
  final sizes = FittedSizes(Size(100, 80), Size(200, 160));

  print('Created: ${sizes.runtimeType}');

  // Test properties
  print('\nSize properties:');
  print('source: ${sizes.source}');
  print('destination: ${sizes.destination}');

  // Using applyBoxFit
  print('\nUsing applyBoxFit:');
  final inputSize = Size(400, 300);
  final outputSize = Size(200, 200);

  // Different BoxFit values
  print('\nBoxFit.contain:');
  final contain = applyBoxFit(BoxFit.contain, inputSize, outputSize);
  print('source: ${contain.source}');
  print('destination: ${contain.destination}');

  print('\nBoxFit.cover:');
  final cover = applyBoxFit(BoxFit.cover, inputSize, outputSize);
  print('source: ${cover.source}');
  print('destination: ${cover.destination}');

  print('\nBoxFit.fill:');
  final fill = applyBoxFit(BoxFit.fill, inputSize, outputSize);
  print('source: ${fill.source}');
  print('destination: ${fill.destination}');

  // Explain FittedSizes
  print('\nFittedSizes purpose:');
  print('- Result of fitting calculation');
  print('- source: area of input to use');
  print('- destination: area in output');
  print('- Used with BoxFit');

  // BoxFit values
  print('\nBoxFit values:');
  print('- contain: fit inside, preserve ratio');
  print('- cover: fill completely, may crop');
  print('- fill: stretch to fill');
  print('- fitWidth/fitHeight: fit one dimension');

  print('\nFittedSizes test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'FittedSizes Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Box fitting result'),
      Text('source: ${contain.source}'),
      Text('destination: ${contain.destination}'),
      Text('Used by: FittedBox'),
    ],
  );
}
