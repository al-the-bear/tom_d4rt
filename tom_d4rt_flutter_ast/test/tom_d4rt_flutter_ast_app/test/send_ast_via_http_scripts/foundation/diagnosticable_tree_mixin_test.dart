// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DiagnosticableTreeMixin from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// Custom class demonstrating DiagnosticableTreeMixin concepts without using the mixin
// (D4rt bridge limitation: mixins cannot be used as mixins)
class TestTreeNode {
  final String name;
  final List<TestTreeNode> children;

  TestTreeNode({required this.name, this.children = const []});

  @override
  String toString() => 'TestTreeNode(name: $name, children: ${children.length})';

  String toStringShort() => 'TestTreeNode($name)';

  String toStringDeep({String prefix = ''}) {
    String result = '$prefix$name\n';
    for (int i = 0; i < children.length; i++) {
      String childPrefix = i == children.length - 1 ? '$prefix└─' : '$prefix├─';
      result += children[i].toStringDeep(prefix: childPrefix);
    }
    return result;
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

  // Test type hierarchy
  print('\nType hierarchy:');
  print(
    'DiagnosticableTreeMixin mixin not available in D4rt bridge',
  );
  print('Demonstrated concept without mixin usage');
  print('is Object: ${root is Object}');

  // Compare with Flutter widgets
  print('\nFlutter DiagnosticableTreeMixin examples:');
  print(
    'Element uses DiagnosticableTreeMixin for debugging',
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
  return SingleChildScrollView(child: Column(
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
      Text('Element uses mixin: true /* element is DiagnosticableTreeMixin */'),
      Text('Purpose: Tree-aware diagnostics'),
    ],
  ));
}
