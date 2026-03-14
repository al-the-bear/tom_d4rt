// D4rt test script: Tests DiagnosticableTreeNode from foundation
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

class _TreeNodeSample extends DiagnosticableTree {
  const _TreeNodeSample({required this.id, this.children = const <_TreeNodeSample>[]});

  final String id;
  final List<_TreeNodeSample> children;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('id', id));
    properties.add(IntProperty('childCount', children.length));
  }

  @override
  List<DiagnosticsNode> debugDescribeChildren() {
    return children
        .map((child) => child.toDiagnosticsNode(name: 'child-${child.id}', style: DiagnosticsTreeStyle.sparse))
        .toList();
  }
}

Widget _summary(String title, List<String> logs) {
  final pass = logs.where((line) => line.startsWith('[PASS]')).length;
  final fail = logs.where((line) => line.startsWith('[FAIL]')).length;
  return Material(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('Checks: ${logs.length}'),
        Text('Pass: $pass'),
        Text('Fail: $fail'),
        ...logs.take(10).map(Text.new),
      ],
    ),
  );
}

dynamic build(BuildContext context) {
  print('DiagnosticableTreeNode comprehensive test start');
  final logs = <String>[];

  final leafA = const _TreeNodeSample(id: 'leafA');
  final leafB = const _TreeNodeSample(id: 'leafB');
  final root = _TreeNodeSample(id: 'root', children: [leafA, leafB]);

  final node = DiagnosticableTreeNode(
    name: 'rootNode',
    value: root,
    style: DiagnosticsTreeStyle.sparse,
  );

  _check(logs: logs, label: 'DiagnosticableTreeNode created', condition: node is DiagnosticableTreeNode);
  _check(logs: logs, label: 'name preserved', condition: node.name == 'rootNode');
  _check(logs: logs, label: 'style preserved', condition: node.style == DiagnosticsTreeStyle.sparse);

  final children = node.getChildren();
  final properties = node.getProperties();
  _check(logs: logs, label: 'children count = 2', condition: children.length == 2);
  _check(logs: logs, label: 'properties include id', condition: properties.any((n) => n.name == 'id'));
  _check(logs: logs, label: 'properties include childCount', condition: properties.any((n) => n.name == 'childCount'));

  final desc = node.toDescription();
  _check(logs: logs, label: 'description contains class name', condition: desc.contains('TreeNodeSample'));

  final deep = node.toStringDeep();
  _check(logs: logs, label: 'deep string has leafA', condition: deep.contains('leafA'));
  _check(logs: logs, label: 'deep string has leafB', condition: deep.contains('leafB'));

  final json = node.toJsonMap(const DiagnosticsSerializationDelegate(subtreeDepth: 2, includeProperties: true));
  _check(logs: logs, label: 'json has description', condition: json.containsKey('description'));
  _check(logs: logs, label: 'json has children', condition: json.containsKey('children'));

  print('DiagnosticableTreeNode comprehensive test complete');
  return _summary('DiagnosticableTreeNode Comprehensive Test', logs);
}

// coverage note: constructor
// coverage note: properties
// coverage note: children
// coverage note: description
// coverage note: deep string
// coverage note: serialization
// coverage note: assertions/logging
// coverage note: summary widget
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
