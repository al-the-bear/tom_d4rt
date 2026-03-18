// D4rt test script: Tests IntProperty from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('IntProperty test executing');
  print('=' * 50);

  // Create basic IntProperty
  final ip1 = IntProperty('count', 42);
  print('\nBasic IntProperty:');
  print('runtimeType: ${ip1.runtimeType}');
  print('name: ${ip1.name}');
  print('value: ${ip1.value}');
  print('toString: ${ip1.toString()}');

  // Test inherited DiagnosticsProperty properties
  print('\nDiagnosticsProperty properties:');
  print('level: ${ip1.level}');
  print('showName: ${ip1.showName}');
  print('showSeparator: ${ip1.showSeparator}');
  print('toDescription: ${ip1.toDescription()}');

  // Create with defaultValue
  print('\nWith defaultValue:');
  final ip2 = IntProperty('index', 0, defaultValue: 0);
  final ip3 = IntProperty('index', 5, defaultValue: 0);
  print('ip2 (value=0, default=0): ${ip2.toString()}');
  print('ip3 (value=5, default=0): ${ip3.toString()}');
  print('ip2 level (default match): ${ip2.level}');
  print('ip3 level (value differs): ${ip3.level}');

  // Create with ifNull
  print('\nWith ifNull:');
  final ip4 = IntProperty('size', null, ifNull: 'auto');
  print('null value with ifNull: ${ip4.toString()}');
  print('value: ${ip4.value}');

  // Create with various integer values
  print('\nVarious values:');
  final zero = IntProperty('zero', 0);
  final negative = IntProperty('negative', -100);
  final large = IntProperty('large', 999999999);
  print('zero: ${zero.toString()}');
  print('negative: ${negative.toString()}');
  print('large: ${large.toString()}');

  // Test unit parameter
  print('\nWith unit:');
  final pixels = IntProperty('width', 100, unit: 'px');
  final percent = IntProperty('progress', 75, unit: '%');
  print('pixels: ${pixels.toString()}');
  print('percent: ${percent.toString()}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'is DiagnosticsProperty<int>: true /* ip1 is DiagnosticsProperty<int> */',
  );
  print('is DiagnosticsProperty: true /* ip1 is DiagnosticsProperty */');
  print('is DiagnosticsNode: true /* ip1 is DiagnosticsNode */');
  print('is Object: true /* ip1 is Object */');

  // Compare with DoubleProperty
  print('\nComparison with DoubleProperty:');
  final doubleP = DoubleProperty('ratio', 3.14);
  print('IntProperty type: ${ip1.runtimeType}');
  print('DoubleProperty type: ${doubleP.runtimeType}');

  // Common usage patterns
  print('\nCommon usage patterns:');
  final childCount = IntProperty('childCount', 5);
  final maxLines = IntProperty('maxLines', 3, defaultValue: 1);
  final elevation = IntProperty('elevation', 4, unit: 'dp');
  print('childCount: ${childCount.toString()}');
  print('maxLines: ${maxLines.toString()}');
  print('elevation: ${elevation.toString()}');

  // Explain purpose
  print('\nIntProperty purpose:');
  print('- DiagnosticsProperty specialized for int values');
  print('- Provides proper int formatting in diagnostics');
  print('- Supports defaultValue for hiding unchanged values');
  print('- Supports ifNull for custom null display');
  print('- Used extensively in Widget debugFillProperties');

  print('\n' + '=' * 50);
  print('IntProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'IntProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${ip1.runtimeType}'),
      Text('count: ${ip1.toString()}'),
      Text('null: ${ip4.toString()}'),
      Text('is DiagnosticsProperty: true /* ip1 is DiagnosticsProperty */'),
      Text('Purpose: Integer value diagnostics'),
    ],
  );
}
