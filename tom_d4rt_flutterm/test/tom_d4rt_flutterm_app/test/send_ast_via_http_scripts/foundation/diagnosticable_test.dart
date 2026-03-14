// D4rt test script: Tests Diagnosticable mixin from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Custom class implementing Diagnosticable
class TestDiagnosticable with Diagnosticable {
  final String name;
  final int value;

  TestDiagnosticable({required this.name, required this.value});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(IntProperty('value', value));
  }
}

dynamic build(BuildContext context) {
  print('Diagnosticable test executing');
  print('=' * 50);

  // Create instance of class with Diagnosticable mixin
  final testObj = TestDiagnosticable(name: 'TestObject', value: 42);
  print('\nTestDiagnosticable created:');
  print('runtimeType: ${testObj.runtimeType}');
  print('name: ${testObj.name}');
  print('value: ${testObj.value}');

  // Test toString() method from Diagnosticable
  print('\ntoString() methods:');
  print('toString(): ${testObj.toString()}');
  print('toStringShort(): ${testObj.toStringShort()}');

  // Test toStringDeep()
  print('\ntoStringDeep():');
  final deepString = testObj.toStringDeep();
  print(deepString);

  // Test toStringShallow()
  print('\ntoStringShallow():');
  final shallowString = testObj.toStringShallow();
  print(shallowString);

  // Test toDiagnosticsNode()
  print('\ntoDiagnosticsNode():');
  final node = testObj.toDiagnosticsNode();
  print('node.runtimeType: ${node.runtimeType}');
  print('node.name: ${node.name}');
  print('node.value: ${node.value}');
  print('node.style: ${node.style}');

  // Test with named node
  print('\nNamed toDiagnosticsNode:');
  final namedNode = testObj.toDiagnosticsNode(
    name: 'myObject',
    style: DiagnosticsTreeStyle.dense,
  );
  print('namedNode.name: ${namedNode.name}');
  print('namedNode.style: ${namedNode.style}');

  // Test type hierarchy
  print('\nType checks:');
  print('is Diagnosticable: ${testObj is Diagnosticable}');
  print('is Object: ${testObj is Object}');

  // Use built-in Flutter Diagnosticable classes
  print('\nFlutter Diagnosticable examples:');
  final boxDecoration = BoxDecoration(color: Colors.blue);
  print('BoxDecoration toString: ${boxDecoration.toString()}');
  print('BoxDecoration is Diagnosticable: ${boxDecoration is Diagnosticable}');

  final textStyle = TextStyle(fontSize: 16, color: Colors.red);
  print('TextStyle toString: ${textStyle.toString()}');
  print('TextStyle is Diagnosticable: ${textStyle is Diagnosticable}');

  // Explain purpose
  print('\nDiagnosticable purpose:');
  print('- Mixin that provides debugging methods');
  print('- Enables toString(), toStringDeep(), toStringShallow()');
  print('- Allows toDiagnosticsNode() for tree representation');
  print('- Override debugFillProperties() to add custom properties');
  print('- Used extensively in Flutter for debugging');

  print('\n' + '=' * 50);
  print('Diagnosticable test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'Diagnosticable Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('Custom class: ${testObj.runtimeType}'),
      Text('toString: ${testObj.toStringShort()}'),
      Text('BoxDecoration: ${boxDecoration is Diagnosticable}'),
      Text('Purpose: Debugging support mixin'),
    ],
  );
}
