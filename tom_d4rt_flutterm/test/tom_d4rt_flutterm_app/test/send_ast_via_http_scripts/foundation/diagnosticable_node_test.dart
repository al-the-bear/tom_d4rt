// D4rt test script: Tests DiagnosticableNode from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticableNode test executing');
  print('=' * 50);

  // Create DiagnosticableNode wrapping TextStyle
  final style = TextStyle(fontSize: 16.0, color: Colors.blue);
  final node1 = DiagnosticableNode<TextStyle>(
    name: 'textStyle',
    value: style,
    style: DiagnosticsTreeStyle.dense,
  );
  print('\nDiagnosticableNode<TextStyle>:');
  print('runtimeType: ${node1.runtimeType}');
  print('name: ${node1.name}');
  print('value: ${node1.value}');
  print('value.runtimeType: ${node1.value?.runtimeType}');
  print('style: ${node1.style}');

  // Test getProperties()
  print('\ngetProperties():');
  final props = node1.getProperties();
  print('properties count: ${props.length}');
  for (final prop in props.take(3)) {
    print('  - ${prop.name}: ${prop.toDescription()}');
  }

  // Test getChildren()
  print('\ngetChildren():');
  final children = node1.getChildren();
  print('children count: ${children.length}');

  // Create with different styles
  print('\nDifferent DiagnosticsTreeStyle:');
  final sparseNode = DiagnosticableNode<TextStyle>(
    name: 'sparse',
    value: style,
    style: DiagnosticsTreeStyle.sparse,
  );
  final flatNode = DiagnosticableNode<TextStyle>(
    name: 'flat',
    value: style,
    style: DiagnosticsTreeStyle.flat,
  );
  final singleLineNode = DiagnosticableNode<TextStyle>(
    name: 'singleLine',
    value: style,
    style: DiagnosticsTreeStyle.singleLine,
  );
  print('sparse style: ${sparseNode.style}');
  print('flat style: ${flatNode.style}');
  print('singleLine style: ${singleLineNode.style}');

  // Create with different Diagnosticable types
  print('\nDifferent Diagnosticable types:');
  final boxDec = BoxDecoration(color: Colors.red);
  final boxNode = DiagnosticableNode<BoxDecoration>(
    name: 'decoration',
    value: boxDec,
    style: DiagnosticsTreeStyle.dense,
  );
  print('BoxDecoration node name: ${boxNode.name}');
  print('BoxDecoration properties: ${boxNode.getProperties().length}');

  final borderNode = DiagnosticableNode<Border>(
    name: 'border',
    value: Border.all(color: Colors.black, width: 2),
    style: DiagnosticsTreeStyle.dense,
  );
  print('Border node name: ${borderNode.name}');
  print('Border properties: ${borderNode.getProperties().length}');

  // Test with null value
  print('\nWith null value:');
  final nullNode = DiagnosticableNode<TextStyle>(
    name: 'nullStyle',
    value: null,
    style: DiagnosticsTreeStyle.dense,
  );
  print('value == null: ${nullNode.value == null}');
  print('properties: ${nullNode.getProperties().length}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is DiagnosticsNode: ${node1 is DiagnosticsNode}');
  print('is Object: ${node1 is Object}');

  // Test inherited DiagnosticsNode properties
  print('\nInherited DiagnosticsNode properties:');
  print('showName: ${node1.showName}');
  print('showSeparator: ${node1.showSeparator}');
  print('level: ${node1.level}');

  // Explain purpose
  print('\nDiagnosticableNode purpose:');
  print('- DiagnosticsNode that wraps a Diagnosticable value');
  print('- Automatically extracts properties via debugFillProperties');
  print('- Used for widget tree inspection in DevTools');
  print('- Supports various DiagnosticsTreeStyle options');
  print('- getProperties() returns property diagnostics');

  print('\n' + '=' * 50);
  print('DiagnosticableNode test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DiagnosticableNode Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${node1.runtimeType}'),
      Text('name: ${node1.name}'),
      Text('properties: ${props.length}'),
      Text('style: ${node1.style}'),
      Text('Purpose: Wrap Diagnosticable in node'),
    ],
  );
}
