// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Widget base class from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Widget test executing');
  print('=' * 50);

  // Widget is the base class for all widgets
  print('Widget overview:');
  print('  - Abstract base class');
  print('  - Extends DiagnosticableTree');
  print('  - All Flutter widgets extend this');
  print('  - Immutable configuration objects');

  // Test with concrete widgets
  print('\nTesting with concrete widgets:');
  const text = Text('Hello');
  print('  Text widget: $text');
  print('  runtimeType: ${text.runtimeType}');
  print('  key: ${text.key}');
  print('  toStringShort: ${text.toStringShort()}');

  // Key property
  print('\nTesting key property:');
  const withKey = Text('Hello', key: Key('greeting'));
  print('  With key: ${withKey.key}');
  print('  toStringShort: ${withKey.toStringShort()}');
  
  const withoutKey = Text('World');
  print('  Without key: ${withoutKey.key}');

  // Widget.canUpdate static method
  print('\nTesting Widget.canUpdate:');
  const text1 = Text('Hello');
  const text2 = Text('World');
  const text3 = Text('Hello', key: Key('a'));
  const text4 = Text('Hello', key: Key('b'));
  final container = Container();

  print('  canUpdate(text1, text2) same type, no keys: ${Widget.canUpdate(text1, text2)}');
  print('  canUpdate(text1, text3) no key vs key: ${Widget.canUpdate(text1, text3)}');
  print('  canUpdate(text3, text4) different keys: ${Widget.canUpdate(text3, text4)}');
  print('  canUpdate(text1, container) different types: ${Widget.canUpdate(text1, container)}');

  // Same key, same type
  const textA = Text('A', key: Key('same'));
  const textB = Text('B', key: Key('same'));
  print('  canUpdate(textA, textB) same key: ${Widget.canUpdate(textA, textB)}');

  // createElement
  print('\nWidget.createElement:');
  print('  - Abstract method');
  print('  - Creates Element for this widget');
  print('  - StatelessWidget creates StatelessElement');
  print('  - StatefulWidget creates StatefulElement');

  // Immutability
  print('\nWidget immutability:');
  print('  - @immutable annotation');
  print('  - All fields must be final');
  print('  - Enables rebuild optimization');
  print('  - Widget identity via == (Object.==)');

  // Operator ==
  print('\nOperator ==:');
  print('  text1 == text1: ${text1 == text1}');
  print('  text1 == text2: ${text1 == text2}');
  print('  identical(text1, text1): ${identical(text1, text1)}');

  print('\n' + '=' * 50);
  print('Widget test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Widget Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract base class'),
      Text('Key: canUpdate uses runtimeType + key'),
      Text('Method: createElement()'),
    ],
  );
}
