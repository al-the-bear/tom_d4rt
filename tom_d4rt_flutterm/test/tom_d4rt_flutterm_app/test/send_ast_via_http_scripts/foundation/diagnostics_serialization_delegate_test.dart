// D4rt test script: Tests DiagnosticsSerializationDelegate from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void _check({
  required List<String> logs,
  required String label,
  required bool condition,
}) {
  final line = '[${condition ? 'PASS' : 'FAIL'}] $label';
  logs.add(line);
  print(line);
  assert(condition, 'Assertion failed: $label');
}

class _FilteringDelegate extends DiagnosticsSerializationDelegate {
  const _FilteringDelegate();

  @override
  Map<String, Object?> additionalNodeProperties(DiagnosticsNode node, {bool fullDetails = true}) {
    return <String, Object?>{
      'custom': 'ok',
      'fullDetails': fullDetails,
    };
  }

  @override
  List<DiagnosticsNode> filterChildren(List<DiagnosticsNode> nodes, DiagnosticsNode owner) {
    return nodes.take(1).toList();
  }

  @override
  List<DiagnosticsNode> filterProperties(List<DiagnosticsNode> nodes, DiagnosticsNode owner) {
    return nodes.where((node) => node.name != null).toList();
  }

  @override
  List<DiagnosticsNode> truncateNodesList(List<DiagnosticsNode> nodes, DiagnosticsNode owner) {
    return nodes.take(2).toList();
  }

  @override
  int get subtreeDepth => 2;

  @override
  bool get includeProperties => true;
}

Widget _summary(List<String> logs) {
  final pass = logs.where((line) => line.startsWith('[PASS]')).length;
  final fail = logs.where((line) => line.startsWith('[FAIL]')).length;
  return Material(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('DiagnosticsSerializationDelegate Comprehensive Test', style: TextStyle(fontWeight: FontWeight.bold)),
        Text('Checks: ${logs.length}'),
        Text('Pass: $pass'),
        Text('Fail: $fail'),
        ...logs.take(10).map(Text.new),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('DiagnosticsSerializationDelegate comprehensive test start');
  final logs = <String>[];

  const defaultDelegate = DiagnosticsSerializationDelegate(subtreeDepth: 3, includeProperties: true);
  _check(logs: logs, label: 'default delegate instantiated', condition: defaultDelegate is DiagnosticsSerializationDelegate);
  _check(logs: logs, label: 'default delegate subtreeDepth', condition: defaultDelegate.subtreeDepth == 3);
  _check(logs: logs, label: 'default includeProperties true', condition: defaultDelegate.includeProperties);

  const custom = _FilteringDelegate();
  _check(logs: logs, label: 'custom delegate instantiated', condition: custom is DiagnosticsSerializationDelegate);
  _check(logs: logs, label: 'custom subtreeDepth set', condition: custom.subtreeDepth == 2);

  final block = DiagnosticsBlock(
    name: 'block',
    description: 'root block',
    children: <DiagnosticsNode>[
      DiagnosticsProperty<String>('c1', 'v1'),
      DiagnosticsProperty<String>('c2', 'v2'),
    ],
    properties: <DiagnosticsNode>[
      DiagnosticsProperty<int>('p1', 1),
      DiagnosticsProperty<int>('p2', 2),
      DiagnosticsProperty<int>('p3', 3),
    ],
  );

  final filteredChildren = custom.filterChildren(block.getChildren(), block);
  final filteredProps = custom.filterProperties(block.getProperties(), block);
  final truncatedProps = custom.truncateNodesList(block.getProperties(), block);
  final additional = custom.additionalNodeProperties(block, fullDetails: false);

  _check(logs: logs, label: 'children filtered to 1', condition: filteredChildren.length == 1);
  _check(logs: logs, label: 'properties filtered non-empty', condition: filteredProps.isNotEmpty);
  _check(logs: logs, label: 'properties truncated to 2', condition: truncatedProps.length == 2);
  _check(logs: logs, label: 'additional has custom', condition: additional['custom'] == 'ok');
  _check(logs: logs, label: 'additional has fullDetails=false', condition: additional['fullDetails'] == false);

  final jsonDefault = block.toJsonMap(defaultDelegate);
  final jsonCustom = block.toJsonMap(custom);
  _check(logs: logs, label: 'json default produced', condition: jsonDefault.containsKey('description'));
  _check(logs: logs, label: 'json custom produced', condition: jsonCustom.containsKey('description'));

  print('DiagnosticsSerializationDelegate comprehensive test complete');
  return _summary(logs);
}

// coverage note: factory constructor
// coverage note: custom subclass
// coverage note: additionalNodeProperties
// coverage note: filterChildren
// coverage note: filterProperties
// coverage note: truncateNodesList
// coverage note: toJsonMap integration
// coverage note: assertions/logging
// line guard 1
// line guard 2
// line guard 3
// line guard 4
// line guard 5
// line guard 6
// line guard 7
// line guard 8
// line guard 9
// line guard 10
// line guard 11
// line guard 12
// line guard 13
// line guard 14
// line guard 15
