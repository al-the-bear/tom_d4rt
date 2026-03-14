// D4rt test script: Tests DiagnosticableTreeMixin from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Custom class implementing DiagnosticableTreeMixin
class TestTreeNode with DiagnosticableTreeMixin {
  final String name;
  final List<TestTreeNode> children;

  TestTreeNode({required this.name, this.children = const []});

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(IntProperty('childCount', children.length));
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    return children.map((c) => c.toDiagnosticsNode(name: c.name)).toList();
  }
}

dynamic build(BuildContext context) {
  print('DiagnosticableTreeMixin test executing');
  print('=' * 50);

  // Create tree structure
  final leaf1 = TestTreeNode(name: 'Leaf1');
  final leaf2 = TestTreeNode(name: 'Leaf2');
  final leaf3 = TestTreeNode(name: 'Leaf3');
  final branch1 = TestTreeNode(name: 'Branch1', children: [leaf1, leaf2]);
  final branch2 = TestTreeNode(name: 'Branch2', children: [leaf3]);
  final root = TestTreeNode(name: 'Root', children: [branch1, branch2]);

  print('\nTree structure created:');
  print('Root -> Branch1 -> [Leaf1, Leaf2]');
  print('Root -> Branch2 -> [Leaf3]');

  // Test basic properties
  print('\nRoot node:');
  print('runtimeType: ${root.runtimeType}');
  print('name: ${root.name}');
  print('children.length: ${root.children.length}');

  // Test toString methods
  print('\ntoString methods:');
  print('toString(): ${root.toString()}');
  print('toStringShort(): ${root.toStringShort()}');

  // Test toStringDeep() - shows full tree
  print('\ntoStringDeep():');
  final deepString = root.toStringDeep();
  print(deepString);

  // Test toStringShallow()
  print('\ntoStringShallow():');
  final shallowString = root.toStringShallow();
  print(shallowString);

  // Test toDiagnosticsNode()
  print('\ntoDiagnosticsNode():');
  final node = root.toDiagnosticsNode();
  print('node.runtimeType: ${node.runtimeType}');
  print('node.name: ${node.name}');
  print('node.style: ${node.style}');

  // Get children diagnostics
  print('\nChildren diagnostics:');
  final childNodes = root.debugDescribeChildren();
  print('childNodes.length: ${childNodes.length}');
  for (final child in childNodes) {
    print('  - ${child.name}: ${child.value?.runtimeType}');
  }

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is DiagnosticableTreeMixin: ${root is DiagnosticableTreeMixin}');
  print('is Diagnosticable: ${root is Diagnosticable}');
  print('is Object: ${root is Object}');

  // Compare with Flutter widgets
  print('\nFlutter DiagnosticableTreeMixin examples:');
  final element = Builder(builder: (ctx) => Container()).createElement();
  print(
    'Element is DiagnosticableTreeMixin: ${element is DiagnosticableTreeMixin}',
  );

  // Explain purpose
  print('\nDiagnosticableTreeMixin purpose:');
  print('- Extends Diagnosticable with tree functionality');
  print('- Provides debugDescribeChildren() for child nodes');
  print('- toStringDeep() shows entire tree structure');
  print('- Used by Elements, RenderObjects for debugging');
  print('- Enables Flutter DevTools tree inspection');

  print('\n' + '=' * 50);
  print('DiagnosticableTreeMixin test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DiagnosticableTreeMixin Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: mixin'),
      Text('Root: ${root.name}'),
      Text('Children: ${root.children.length}'),
      Text('Element uses mixin: ${element is DiagnosticableTreeMixin}'),
      Text('Purpose: Tree-aware diagnostics'),
    ],
  );
}
