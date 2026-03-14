// Comprehensive D4rt test script
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';

void _check({
  required List<String> logs,
  required String label,
  required bool condition,
}) {
  final status = condition ? 'PASS' : 'FAIL';
  final line = '[$status] $label';
  logs.add(line);
  print(line);
  assert(condition, 'Assertion failed: $label');
}

Widget _summaryWidget({
  required String title,
  required List<String> logs,
  required int passCount,
  required int failCount,
}) {
  return Material(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text('Checks: ${logs.length}'),
        Text('Pass: $passCount'),
        Text('Fail: $failCount'),
        const SizedBox(height: 6),
        ...logs.take(10).map(Text.new),
      ],
    ),
  );
}


class _SelectableProbe extends ChangeNotifier with Selectable {
  SelectionGeometry _value = const SelectionGeometry(status: SelectionStatus.none, hasContent: true);
  List<Rect> _boxes = const [Rect.fromLTWH(0, 0, 40, 18)];

  @override
  SelectionGeometry get value => _value;

  set value(SelectionGeometry next) {
    _value = next;
    notifyListeners();
  }

  @override
  Matrix4 getTransformTo(RenderObject? ancestor) => Matrix4.identity();

  @override
  Size get size => const Size(40, 18);

  @override
  List<Rect> get boundingBoxes => _boxes;

  @override
  void pushHandleLayers(LayerLink? startHandle, LayerLink? endHandle) {
    print('pushHandleLayers called: start=$startHandle end=$endHandle');
  }

  @override
  SelectedContent? getSelectedContent() => const SelectedContent(plainText: 'hello selectable');

  @override
  SelectedContentRange? getSelection() => const SelectedContentRange(startOffset: 0, endOffset: 5);

  @override
  SelectionResult dispatchSelectionEvent(SelectionEvent event) {
    _value = const SelectionGeometry(status: SelectionStatus.finalized, hasContent: true);
    notifyListeners();
    return SelectionResult.end;
  }

  @override
  int get contentLength => 16;
}

dynamic build(BuildContext context) {
  print('Selectable comprehensive test start');
  final logs = <String>[];
  var pass = 0;
  var fail = 0;

  final selectable = _SelectableProbe();
  _check(logs: logs, label: 'probe instantiated', condition: selectable is Selectable);

  var listenerCount = 0;
  selectable.addListener(() {
    listenerCount++;
  });

  _check(logs: logs, label: 'contentLength exposed', condition: selectable.contentLength == 16);
  _check(logs: logs, label: 'initial hasContent true', condition: selectable.value.hasContent);
  _check(logs: logs, label: 'bounding box exists', condition: selectable.boundingBoxes.isNotEmpty);

  final content = selectable.getSelectedContent();
  final selection = selectable.getSelection();
  _check(logs: logs, label: 'selected content available', condition: content?.plainText.contains('selectable') ?? false);
  _check(logs: logs, label: 'selection range available', condition: selection?.startOffset == 0 && selection?.endOffset == 5);

  final result = selectable.dispatchSelectionEvent(const ClearSelectionEvent());
  _check(logs: logs, label: 'dispatch returns SelectionResult', condition: result == SelectionResult.end);
  _check(logs: logs, label: 'listener triggered', condition: listenerCount >= 1);
  _check(logs: logs, label: 'status updated to finalized', condition: selectable.value.status == SelectionStatus.finalized);

  selectable.pushHandleLayers(LayerLink(), LayerLink());
  _check(logs: logs, label: 'pushHandleLayers callable', condition: true);

  final matrix = selectable.getTransformTo(null);
  _check(logs: logs, label: 'transform is identity matrix', condition: matrix.isIdentity());

  selectable.dispose();
  _check(logs: logs, label: 'dispose callable', condition: true);

  for (final line in logs) {
    if (line.contains('[PASS]')) {
      pass++;
    } else {
      fail++;
    }
  }

  print('Selectable comprehensive test finished: pass=$pass fail=$fail');
  return _summaryWidget(
    title: 'Selectable Comprehensive Test',
    logs: logs,
    passCount: pass,
    failCount: fail,
  );
}
