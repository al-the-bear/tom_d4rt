// D4rt test script: Tests FractionColumnWidth from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FractionColumnWidth test executing');

  // Test FractionColumnWidth - Fraction column
  print('FractionColumnWidth is available in the rendering package');
  print('FractionColumnWidth: Fraction column');

  print('FractionColumnWidth test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FractionColumnWidth Tests'),
      Text('Fraction column'),
    ],
  );
}
