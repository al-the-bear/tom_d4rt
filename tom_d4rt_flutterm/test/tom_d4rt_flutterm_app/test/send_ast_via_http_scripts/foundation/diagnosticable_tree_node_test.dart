// D4rt test script: Tests DiagnosticableTreeNode from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticableTreeNode test executing');

  // Text widget is a DiagnosticableTree
  final widget = Text('hello');
  final node = DiagnosticableTreeNode(name: 'widget', value: widget, style: DiagnosticsTreeStyle.sparse);
  print('DiagnosticableTreeNode: ${node.runtimeType}');
  print('name: ${node.name}');
  print('style: ${node.style}');

  final children = node.getChildren();
  print('children: ${children.length}');
  final props = node.getProperties();
  print('properties: ${props.length}');

  print('DiagnosticableTreeNode test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('DiagnosticableTreeNode Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Wraps a widget tree node'),
    Text('Children: ${children.length}'),
    Text('Properties: ${props.length}'),
  ]);
}
