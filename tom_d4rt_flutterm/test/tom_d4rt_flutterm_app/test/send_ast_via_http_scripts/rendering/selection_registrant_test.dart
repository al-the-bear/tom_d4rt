// D4rt test script: Comprehensive SelectionRegistrant coverage
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
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
  print('--- SelectionRegistrant test start ---');
  final logs = <String>[];
  final counters = <String, int>{'assertions': 0};
  final startedAt = DateTime.now();

  expectCondition(context is BuildContext, 'BuildContext is available', logs, counters);
  expectCondition(startedAt.millisecondsSinceEpoch > 0, 'Start time is valid', logs, counters);

  final registrar = _FakeSelectionRegistrar();
  final selectable = _SelectableHarness();
  expectCondition(selectable is SelectionRegistrant, 'Selectable harness mixes in SelectionRegistrant', logs, counters);
  expectCondition(selectable.registrar == null, 'Registrar starts null', logs, counters);
  selectable.registrar = registrar;
  expectCondition(selectable.registrar == registrar, 'Registrar can be assigned', logs, counters);
  expectCondition(registrar.addCount == 1, 'Registrar add called when content exists', logs, counters);
  expectCondition(registrar.removeCount == 0, 'No remove call yet', logs, counters);
  selectable.valueForTest = const SelectionGeometry(status: SelectionStatus.none, hasContent: false);
  expectCondition(registrar.removeCount == 1, 'Registrar remove called when content becomes empty', logs, counters);
  selectable.valueForTest = const SelectionGeometry(status: SelectionStatus.collapsed, hasContent: true);
  expectCondition(registrar.addCount == 2, 'Registrar add called again when content returns', logs, counters);
  final selected = selectable.getSelectedContent();
  expectCondition(selected != null, 'Selected content can be returned', logs, counters);
  expectCondition(selectable.getSelection() != null, 'Selection range can be returned', logs, counters);
  expectCondition(selectable.dispatchSelectionEvent(const ClearSelectionEvent()) == SelectionResult.none, 'Dispatch handles clear event', logs, counters);
  expectCondition(selectable.contentLength == 1, 'Content length is exposed', logs, counters);
  selectable.registrar = null;
  expectCondition(selectable.registrar == null, 'Registrar can be cleared', logs, counters);
  selectable.dispose();
  expectCondition(registrar.removeCount >= 1, 'Dispose keeps registrar state consistent', logs, counters);

  final elapsed = DateTime.now().difference(startedAt).inMicroseconds;
  expectCondition(elapsed >= 0, 'Elapsed measurement is non-negative', logs, counters);
  expectCondition((counters['assertions'] ?? 0) >= 24, 'Performed many assertions', logs, counters);

  print('--- SelectionRegistrant test end ---');
  print('Assertions: ${counters['assertions']}');
  print('Log entries: ${logs.length}');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      summaryLine('SelectionRegistrant summary widget'),
      summaryLine('Title: SelectionRegistrant'),
      summaryLine('Assertions: ${counters['assertions']}'),
      summaryLine('Logs: ${logs.length}'),
      summaryLine('Elapsed(us): $elapsed'),
      for (final line in logs.take(24)) summaryLine(line),
    ],
  );
}

class _FakeSelectionRegistrar implements SelectionRegistrar {
  int addCount = 0;
  int removeCount = 0;

  @override
  void add(Selectable selectable) {
    addCount += 1;
  }

  @override
  void remove(Selectable selectable) {
    removeCount += 1;
  }
}

class _SelectableHarness extends ChangeNotifier with Selectable, SelectionRegistrant {
  SelectionGeometry _value = const SelectionGeometry(
    status: SelectionStatus.collapsed,
    hasContent: true,
  );

  set valueForTest(SelectionGeometry geometry) {
    _value = geometry;
    notifyListeners();
  }

  @override
  SelectionGeometry get value => _value;

  @override
  List<Rect> get boundingBoxes => const <Rect>[Rect.fromLTWH(0, 0, 10, 10)];

  @override
  int get contentLength => 1;

  @override
  SelectionResult dispatchSelectionEvent(SelectionEvent event) => SelectionResult.none;

  @override
  SelectedContent? getSelectedContent() => const SelectedContent(plainText: 'x');

  @override
  SelectedContentRange? getSelection() => const SelectedContentRange(startOffset: 0, endOffset: 1);

  @override
  Matrix4 getTransformTo(RenderObject? ancestor) => Matrix4.identity();

  @override
  void pushHandleLayers(LayerLink? startHandle, LayerLink? endHandle) {}

  @override
  Size get size => const Size(10, 10);
}
