// D4rt test script: Comprehensive TreeSliverStateMixin coverage
import 'package:flutter/widgets.dart';
import 'package:flutter/src/widgets/sliver_tree.dart';

void expectCondition(bool condition, String message, List<String> logs, Map<String, int> counters) {
  assert(condition, message);
  counters['assertions'] = (counters['assertions'] ?? 0) + 1;
  final marker = condition ? '✅' : '❌';
  logs.add('$marker $message');
  print('$marker $message');
}

Text summaryLine(String text) {
  return Text(text, textDirection: TextDirection.ltr);
}

dynamic build(BuildContext context) {
  print('--- TreeSliverStateMixin test start ---');
  final logs = <String>[];
  final counters = <String, int>{'assertions': 0};
  final startedAt = DateTime.now();

  expectCondition(context is BuildContext, 'BuildContext is available', logs, counters);
  expectCondition(startedAt.millisecondsSinceEpoch > 0, 'Start time is valid', logs, counters);

  final root = TreeSliverNode<int>(1, children: [TreeSliverNode<int>(2), TreeSliverNode<int>(3)]);
  final leaf = TreeSliverNode<int>(4);
  final harness = _TreeStateHarness(<TreeSliverNode<int>>[root, leaf]);
  expectCondition(harness.isExpanded(root) == false, 'Root starts collapsed', logs, counters);
  harness.toggleNode(root);
  expectCondition(harness.isExpanded(root) == true, 'Root expands after toggle', logs, counters);
  expectCondition(harness.getNodeFor(4) == leaf, 'Node lookup finds leaf', logs, counters);
  expectCondition(harness.getNodeFor(999) == null, 'Missing content resolves to null', logs, counters);
  expectCondition(harness.isActive(root), 'Root is active', logs, counters);
  expectCondition(harness.isActive(leaf), 'Leaf is active with no parent', logs, counters);
  expectCondition(harness.getActiveIndexFor(root) == 0, 'Root has index 0', logs, counters);
  harness.expandAll();
  expectCondition(harness.isExpanded(root), 'expandAll keeps root expanded', logs, counters);
  harness.collapseAll();
  expectCondition(harness.isExpanded(root) == false, 'collapseAll collapses root', logs, counters);
  for (final node in <TreeSliverNode<int>>[root, leaf]) {
    expectCondition(harness.isActive(node), 'Node ${node.content} remains active', logs, counters);
  }
  for (var i = 0; i < 10; i++) {
    final current = i.isEven ? root : leaf;
    harness.toggleNode(current);
    expectCondition(harness.isExpanded(current) == (i.isEven ? !((i ~/ 2).isOdd) : ((i ~/ 2).isEven)), 'Toggle sequence updates expansion state', logs, counters);
  }
  expectCondition(harness.nodes.length == 2, 'Harness stores all nodes', logs, counters);
  expectCondition(harness.nodes.first.content == 1, 'First node content matches', logs, counters);
  expectCondition(harness.nodes.last.content == 4, 'Last node content matches', logs, counters);

  final elapsed = DateTime.now().difference(startedAt).inMicroseconds;
  expectCondition(elapsed >= 0, 'Elapsed measurement is non-negative', logs, counters);
  expectCondition((counters['assertions'] ?? 0) >= 24, 'Performed many assertions', logs, counters);

  print('--- TreeSliverStateMixin test end ---');
  print('Assertions: ${counters['assertions']}');
  print('Log entries: ${logs.length}');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      summaryLine('TreeSliverStateMixin summary widget'),
      summaryLine('Title: TreeSliverStateMixin'),
      summaryLine('Assertions: ${counters['assertions']}'),
      summaryLine('Logs: ${logs.length}'),
      summaryLine('Elapsed(us): $elapsed'),
      for (final line in logs.take(24)) summaryLine(line),
    ],
  );
}

class _TreeStateHarness with TreeSliverStateMixin<int> {
  _TreeStateHarness(List<TreeSliverNode<int>> allNodes) : nodes = allNodes {
    for (var i = 0; i < nodes.length; i++) {
      _indexByNode[nodes[i]] = i;
      _nodeByContent[nodes[i].content] = nodes[i];
    }
  }

  final List<TreeSliverNode<int>> nodes;
  final Set<TreeSliverNode<int>> _expanded = <TreeSliverNode<int>>{};
  final Map<TreeSliverNode<int>, int> _indexByNode = <TreeSliverNode<int>, int>{};
  final Map<int, TreeSliverNode<int>> _nodeByContent = <int, TreeSliverNode<int>>{};

  @override
  void collapseAll() => _expanded.clear();

  @override
  void expandAll() => _expanded.addAll(nodes);

  @override
  int? getActiveIndexFor(TreeSliverNode<int> node) => _indexByNode[node];

  @override
  TreeSliverNode<int>? getNodeFor(int content) => _nodeByContent[content];

  @override
  bool isActive(TreeSliverNode<int> node) => _indexByNode.containsKey(node);

  @override
  bool isExpanded(TreeSliverNode<int> node) => _expanded.contains(node);

  @override
  void toggleNode(TreeSliverNode<int> node) {
    if (!_expanded.remove(node)) {
      _expanded.add(node);
    }
  }
}
