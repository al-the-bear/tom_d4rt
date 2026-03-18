// D4rt test script: Tests TransformProperty from painting
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TransformProperty test executing');

  // Create Matrix4
  final matrix = Matrix4.identity();
  matrix.rotateZ(0.5);
  matrix.translate(10.0, 20.0);

  // Create TransformProperty
  final prop = TransformProperty('transform', matrix);

  print('Created: ${prop.runtimeType}');

  // Test properties
  print('\nProperty info:');
  print('name: ${prop.name}');
  print('value type: ${prop.value?.runtimeType}');

  // To string
  print('\ntoString:');
  print(prop.toDescription());

  // Type hierarchy
  print('\nType hierarchy:');
  print('DiagnosticsProperty<T> (abstract)');
  print('  └── TransformProperty');
  print('is DiagnosticsProperty: ${prop is DiagnosticsProperty}');

  // Purpose
  print('\nPurpose:');
  print('- Formats Matrix4 for debugging');
  print('- Shows readable transform info');
  print('- Used in widget inspector');

  // Other matrix properties
  print('\nMatrix4 data:');
  print('- 4x4 = 16 values');
  print('- TransformProperty formats nicely');

  // Usage in debugFillProperties
  print('\nUsage:');
  print('debugFillProperties(props) {');
  print('  props.add(TransformProperty(');
  print('    "transform", _transform));');
  print('}');

  print('\nTransformProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TransformProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Matrix4 diagnostic property'),
      Text('Formats transforms for debug'),
      Text('Used by: widget inspector'),
    ],
  );
}
