// D4rt test script: Tests ColorProperty from painting
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ColorProperty test executing');

  // Create ColorProperty
  final property = ColorProperty('backgroundColor', Colors.blue);

  print('Created: ${property.runtimeType}');

  // Test properties
  print('\nProperty values:');
  print('name: ${property.name}');
  print('value: ${property.value}');

  // Test toString
  print('\ntoStringDeep:');
  print(property.toDescription());

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is DiagnosticsProperty: ${property is DiagnosticsProperty}');

  // With null value
  print('\nWith null value:');
  final nullProp = ColorProperty('color', null);
  print('null value: ${nullProp.value}');

  // With default value
  print('\nWith default value:');
  final withDefault = ColorProperty(
    'color',
    Colors.red,
    defaultValue: Colors.red,
  );
  print('value: ${withDefault.value}');
  print('isFiltered (matches default): may be filtered in output');

  // Explain purpose
  print('\nColorProperty purpose:');
  print('- Diagnostic output for colors');
  print('- Used in debugFillProperties');
  print('- Shows hex color values');
  print('- Part of diagnostics system');

  // Usage example
  print('\nUsage in debugFillProperties:');
  print('properties.add(ColorProperty("color", color));');

  print('\nColorProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ColorProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Diagnostics for colors'),
      Text('name: ${property.name}'),
      Text('value: ${property.value}'),
      Container(width: 20, height: 20, color: property.value),
    ],
  );
}
