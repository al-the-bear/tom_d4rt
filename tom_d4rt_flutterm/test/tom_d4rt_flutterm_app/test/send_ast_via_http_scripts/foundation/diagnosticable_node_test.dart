// D4rt test script: Tests DiagnosticableNode from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticableNode test executing');

  // Use a real Diagnosticable — TextStyle
  final style = TextStyle(fontSize: 16.0, color: Colors.blue);
  final node = DiagnosticableNode<TextStyle>(name: 'textStyle', value: style, style: DiagnosticsTreeStyle.dense);
  print('DiagnosticableNode: ${node.runtimeType}');
  print('name: ${node.name}');
  print('style: ${node.style}');
  print('value: ${node.value}');

  final props = node.getProperties();
  print('properties count: ${props.length}');

  print('DiagnosticableNode test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('DiagnosticableNode Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Wraps: TextStyle'),
    Text('Properties: ${props.length}'),
  ]);
}
