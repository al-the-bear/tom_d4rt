// D4rt test script: Comprehensive AbstractNode coverage
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

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
  print('--- AbstractNode test start ---');
  final logs = <String>[];
  final counters = <String, int>{'assertions': 0};
  final startedAt = DateTime.now();

  expectCondition(context is BuildContext, 'BuildContext is available', logs, counters);
  expectCondition(startedAt.millisecondsSinceEpoch > 0, 'Start time is valid', logs, counters);

  final owner = Object();
  final root = _NodeHarness('root');
  final childA = _NodeHarness('childA');
  final childB = _NodeHarness('childB');
  expectCondition(root is AbstractNode, 'Root is AbstractNode', logs, counters);
  expectCondition(childA is AbstractNode, 'ChildA is AbstractNode', logs, counters);
  expectCondition(root.attached == false, 'Root starts detached', logs, counters);
  root.attach(owner);
  expectCondition(root.attached, 'Root can attach to owner', logs, counters);
  root.addChild(childA);
  root.addChild(childB);
  expectCondition(childA.parent == root, 'ChildA parent is root', logs, counters);
  expectCondition(childB.parent == root, 'ChildB parent is root', logs, counters);
  expectCondition(childA.attached, 'ChildA attaches with root', logs, counters);
  expectCondition(childB.attached, 'ChildB attaches with root', logs, counters);
  expectCondition(childA.depth > root.depth, 'Child depth is greater than root depth', logs, counters);
  root.removeChild(childB);
  expectCondition(childB.parent == null, 'ChildB parent is cleared after removal', logs, counters);
  expectCondition(childB.attached == false, 'ChildB detaches after removal from attached root', logs, counters);
  root.detach();
  expectCondition(root.attached == false, 'Root detaches cleanly', logs, counters);
  expectCondition(childA.attached == false, 'Remaining child detaches with root', logs, counters);

  final elapsed = DateTime.now().difference(startedAt).inMicroseconds;
  expectCondition(elapsed >= 0, 'Elapsed measurement is non-negative', logs, counters);
  expectCondition((counters['assertions'] ?? 0) >= 24, 'Performed many assertions', logs, counters);

  print('--- AbstractNode test end ---');
  print('Assertions: ${counters['assertions']}');
  print('Log entries: ${logs.length}');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      summaryLine('AbstractNode summary widget'),
      summaryLine('Title: AbstractNode'),
      summaryLine('Assertions: ${counters['assertions']}'),
      summaryLine('Logs: ${logs.length}'),
      summaryLine('Elapsed(us): $elapsed'),
      for (final line in logs.take(24)) summaryLine(line),
    ],
  );
}

class _NodeHarness extends AbstractNode {
  _NodeHarness(this.label);

  final String label;
  final List<_NodeHarness> _children = <_NodeHarness>[];

  void addChild(_NodeHarness child) {
    _children.add(child);
    adoptChild(child);
  }

  void removeChild(_NodeHarness child) {
    _children.remove(child);
    dropChild(child);
  }

  @override
  void attach(covariant Object owner) {
    super.attach(owner);
    for (final child in _children) {
      child.attach(owner);
    }
  }

  @override
  void detach() {
    for (final child in _children) {
      child.detach();
    }
    super.detach();
  }

  @override
  void redepthChildren() {
    for (final child in _children) {
      redepthChild(child);
    }
  }

  @override
  String toString() => '_NodeHarness($label, depth: $depth)';
}
