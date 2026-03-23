// ignore_for_file: avoid_print
// D4rt test script: Tests AttributedStringProperty from semantics
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AttributedStringProperty test executing');
  print('=' * 50);

  // AttributedStringProperty for diagnostics
  print('\nAttributedStringProperty:');
  print('Diagnostics property for AttributedString');
  print('Displays attributed text in debug output');

  // Create AttributedString first
  final attrString = AttributedString(
    'Hello World',
    attributes: [SpellOutStringAttribute(range: TextRange(start: 0, end: 5))],
  );

  // Create property
  final property = AttributedStringProperty('label', attrString);
  print('\nProperty created:');
  print('name: ${property.name}');
  print('value: ${property.value}');

  // Extends DiagnosticsProperty
  print('\nExtends DiagnosticsProperty<AttributedString>:');
  print('is DiagnosticsProperty: true /* property is DiagnosticsProperty */');

  // toString output
  print('\ntoString output:');
  print('${property.toString()}');

  // Value access
  print('\nValue access:');
  print('string: ${property.value?.string}');
  print('attributes: ${property.value?.attributes.length}');

  // Usage in diagnostics
  print('\nUsage in debugFillProperties:');
  print('@override');
  print('void debugFillProperties(DiagnosticPropertiesBuilder p) {');
  print('  super.debugFillProperties(p);');
  print('  p.add(AttributedStringProperty(');
  print('    "label",');
  print('    attributedLabel,');
  print('  ));');
  print('}');

  // When to use
  print('\nWhen to use:');
  print('- Debugging semantics nodes');
  print('- Inspecting attributed labels');
  print('- Widget inspector integration');
  print('- Accessibility debugging');

  // Null handling
  final nullProperty = AttributedStringProperty('nullLabel', null);
  print('\nNull value handling:');
  print('null property: ${nullProperty.value}');

  // Type hierarchy
  print('\nType hierarchy:');
  print('DiagnosticsProperty<AttributedString>');
  print('  \u2514\u2500 AttributedStringProperty');

  // Explain purpose
  print('\nAttributedStringProperty purpose:');
  print('- Diagnostics for AttributedString');
  print('- Debug output formatting');
  print('- Widget inspector display');
  print('- Accessibility debugging');
  print('- Extends DiagnosticsProperty');

  print('\n' + '=' * 50);
  print('AttributedStringProperty test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AttributedStringProperty Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Name: ${property.name}'),
      Text('String: ${property.value?.string}'),
      Text('Extends: DiagnosticsProperty'),
      Text('Purpose: Diagnostics output'),
    ],
  );
}
