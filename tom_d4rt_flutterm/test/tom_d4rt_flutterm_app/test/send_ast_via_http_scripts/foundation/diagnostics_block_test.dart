// D4rt test script: Tests DiagnosticsBlock from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticsBlock test executing');

  final block = DiagnosticsBlock(
    name: 'test_block',
    properties: [StringProperty('key', 'value'), IntProperty('count', 42)],
    style: DiagnosticsTreeStyle.whitespace,
  );
  print('DiagnosticsBlock: ${block.runtimeType}');
  print('name: ${block.name}');
  print('style: ${block.style}');
  final props = block.getProperties();
  print('properties: ${props.length}');
  final children = block.getChildren();
  print('children: ${children.length}');
  print('toStringDeep lines: ${block.toStringDeep().split('\n').length}');

  print('DiagnosticsBlock test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('DiagnosticsBlock Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('properties: ${props.length}'),
    Text('children: ${children.length}'),
  ]);
}
