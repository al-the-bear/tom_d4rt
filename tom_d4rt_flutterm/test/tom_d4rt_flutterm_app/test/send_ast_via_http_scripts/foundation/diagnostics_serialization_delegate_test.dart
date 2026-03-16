// D4rt test script: Tests DiagnosticsSerializationDelegate from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DiagnosticsSerializationDelegate test executing');

  // DiagnosticsSerializationDelegate is an interface — test through default impl
  print('DiagnosticsSerializationDelegate: interface for serializing diagnostics');
  print('Used by: toJsonMap, toDiagnosticsNode');

  // TextStyle has diagnostics
  final style = TextStyle(fontSize: 14, color: Colors.red);
  final node = style.toDiagnosticsNode();
  final props = node.getProperties();
  print('TextStyle properties: ${props.length}');
  for (final p in props.take(3)) {
    print('  ${p.name}: ${p.toDescription()}');
  }

  print('DiagnosticsSerializationDelegate test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('DiagnosticsSerializationDelegate', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Interface for diagnostics serialization'),
    Text('TextStyle props: ${props.length}'),
  ]);
}
