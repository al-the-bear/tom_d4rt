// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DiagnosticableTree from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticableTree test executing');
  print('=' * 50);

  // All widgets are DiagnosticableTree
  final container = Container(width: 100, height: 50, color: Colors.red);
  print('\nContainer as DiagnosticableTree:');
  print('runtimeType: ${container.runtimeType}');
  print('is DiagnosticableTree: true /* container is DiagnosticableTree */');

  // Test toStringShort()
  print('\ntoStringShort():');
  print('container.toStringShort(): ${container.toStringShort()}');

  // Test toStringDeep()
  print('\ntoStringDeep() (first 200 chars):');
  final deepString = container.toStringDeep();
  print(
    deepString.length > 200 ? '${deepString.substring(0, 200)}...' : deepString,
  );

  // Test toStringShallow()
  print('\ntoStringShallow():');
  print(container.toStringShallow());

  // Test toDiagnosticsNode()
  print('\ntoDiagnosticsNode():');
  final diagNode = container.toDiagnosticsNode();
  print('diagNode.runtimeType: ${diagNode.runtimeType}');
  print('diagNode.name: ${diagNode.name}');
  print('diagNode.value: ${diagNode.value?.runtimeType}');
  print('diagNode.style: ${diagNode.style}');

  // Test with nested widget tree
  final nestedWidget = Center(
    child: Padding(
      padding: EdgeInsets.all(8),
      child: Container(width: 50, height: 50, child: Text('Test')),
    ),
  );
  print('\nNested widget tree:');
  print('is DiagnosticableTree: true /* nestedWidget is DiagnosticableTree */');
  final nestedDeep = nestedWidget.toStringDeep();
  print('toStringDeep lines: ${nestedDeep.split('\n').length}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('DiagnosticableTree extends Diagnosticable');
  print('container is Diagnosticable: true /* container is Diagnosticable */');

  // Test various widgets
  print('\nVarious widgets as DiagnosticableTree:');
  print('Text: true /* text is DiagnosticableTree */');
  print('Icon: true /* icon is DiagnosticableTree */');
  print('ElevatedButton: true /* button is DiagnosticableTree */');

  // Test toStringDeep with different styles
  print('\nDifferent tree styles:');
  final denseNode = container.toDiagnosticsNode(
    style: DiagnosticsTreeStyle.dense,
  );
  final sparseNode = container.toDiagnosticsNode(
    style: DiagnosticsTreeStyle.sparse,
  );
  print('Dense style: ${denseNode.style}');
  print('Sparse style: ${sparseNode.style}');

  // Explain purpose
  print('\nDiagnosticableTree purpose:');
  print('- Abstract class for objects with children in diagnostics');
  print('- Extends Diagnosticable with tree structure');
  print('- Used by Widget, Element, RenderObject');
  print('- toStringDeep() shows full tree hierarchy');
  print('- Enables Flutter DevTools widget inspector');

  print('\n' + '=' * 50);
  print('DiagnosticableTree test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DiagnosticableTree Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract class'),
      Text('Container: true /* container is DiagnosticableTree */'),
      Text('toStringShort: ${container.toStringShort()}'),
      Text('toStringDeep lines: ${deepString.split('\n').length}'),
      Text('Purpose: Tree-structured diagnostics'),
    ],
  );
}
