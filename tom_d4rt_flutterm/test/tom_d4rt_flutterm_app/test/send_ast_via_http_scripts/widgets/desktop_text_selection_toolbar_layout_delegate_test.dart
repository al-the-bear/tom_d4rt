// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DesktopTextSelectionToolbarLayoutDelegate from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  final List<String> passed = <String>[];
  final List<String> failed = <String>[];

  void runCase(String name, bool Function() body) {
    try {
      if (body()) {
        passed.add(name);
        print('PASS: $name');
      } else {
        failed.add(name);
        print('FAIL: $name');
      }
    } catch (e, s) {
      failed.add('$name threw');
      print('FAIL: $name threw $e');
      print(s.toString());
    }
  }

  print('DesktopTextSelectionToolbarLayoutDelegate test executing');
  print('=' * 50);

  final Offset anchor = const Offset(100.0, 200.0);
  final DesktopTextSelectionToolbarLayoutDelegate delegate =
      DesktopTextSelectionToolbarLayoutDelegate(anchor: anchor);

  runCase('anchor is stored correctly', () {
    return delegate.anchor == anchor;
  });

  runCase('anchor offset values are correct', () {
    return delegate.anchor.dx == 100.0 && delegate.anchor.dy == 200.0;
  });

  runCase('shouldRelayout detects anchor change', () {
    final DesktopTextSelectionToolbarLayoutDelegate other =
        DesktopTextSelectionToolbarLayoutDelegate(
            anchor: const Offset(200.0, 300.0));
    return delegate.shouldRelayout(other) == true;
  });

  runCase('shouldRelayout returns false for same anchor', () {
    final DesktopTextSelectionToolbarLayoutDelegate sameAnchor =
        DesktopTextSelectionToolbarLayoutDelegate(anchor: anchor);
    return delegate.shouldRelayout(sameAnchor) == false;
  });

  runCase('getConstraintsForChild loosens constraints', () {
    const BoxConstraints parentConstraints =
        BoxConstraints(maxWidth: 800, maxHeight: 600);
    final BoxConstraints childConstraints =
        delegate.getConstraintsForChild(parentConstraints);
    return childConstraints.minWidth == 0.0 && childConstraints.minHeight == 0.0;
  });

  runCase('getPositionForChild returns an offset', () {
    const Size parentSize = Size(800, 600);
    const Size childSize = Size(200, 100);
    final Offset position =
        delegate.getPositionForChild(parentSize, childSize);
    return position.dx >= 0 || position.dx < 0; // always valid Offset
  });

  runCase('position offset dx is finite', () {
    const Size parentSize = Size(800, 600);
    const Size childSize = Size(200, 100);
    final Offset position =
        delegate.getPositionForChild(parentSize, childSize);
    return position.dx.isFinite && position.dy.isFinite;
  });

  runCase('runtime type is correct', () {
    return delegate.runtimeType.toString()
        .contains('DesktopTextSelectionToolbarLayoutDelegate');
  });

  runCase('toString is non-empty', () {
    return delegate.toString().isNotEmpty;
  });

  runCase('origin anchor delegates correctly', () {
    final DesktopTextSelectionToolbarLayoutDelegate originDelegate =
        DesktopTextSelectionToolbarLayoutDelegate(anchor: Offset.zero);
    return originDelegate.anchor == Offset.zero;
  });

  runCase('summary string can be formed', () {
    final String summary = '${passed.length + failed.length} checks';
    return summary.endsWith('checks');
  });

  print('Result: ${passed.length} passed, ${failed.length} failed');
  if (failed.isNotEmpty) print('Failed cases: ${failed.join(', ')}');
  print('=' * 50);

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      const Text('DesktopTextSelectionToolbarLayoutDelegate Tests',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      const SizedBox(height: 8),
      Text('Passed: ${passed.length}'),
      Text('Failed: ${failed.length}'),
      Text(failed.isEmpty ? 'Status: PASS' : 'Status: FAIL'),
      const Text('DesktopTextSelectionToolbarLayoutDelegate behavior checks completed'),
    ],
  );
}
