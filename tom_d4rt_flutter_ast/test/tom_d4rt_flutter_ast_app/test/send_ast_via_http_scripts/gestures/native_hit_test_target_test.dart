// ignore_for_file: avoid_print
// D4rt test script: NativeHitTestTarget (gestures, Flutter 3.47).
//
// NativeHitTestTarget is an empty marker mixin: GestureBinding treats a hit
// test target that mixes it in as backed by a platform view. The script mixes
// it into a script class and checks the type relationship both ways.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class PlatformBackedTarget with NativeHitTestTarget {
  PlatformBackedTarget(this.label);

  final String label;
}

class PlainTarget {
  PlainTarget(this.label);

  final String label;
}

dynamic build(BuildContext context) {
  print('=== NativeHitTestTarget ===');
  final targets = <Object>[
    PlatformBackedTarget('map view'),
    PlainTarget('flutter box'),
    PlatformBackedTarget('web view'),
  ];
  final rows = <Widget>[];
  for (final target in targets) {
    final isNative = target is NativeHitTestTarget;
    final label = target is PlatformBackedTarget
        ? target.label
        : (target as PlainTarget).label;
    print('$label: native=$isNative');
    rows.add(
      ListTile(
        leading: Icon(isNative ? Icons.phone_iphone : Icons.widgets),
        title: Text(label),
        subtitle: Text(isNative ? 'NativeHitTestTarget' : 'Flutter target'),
      ),
    );
  }
  // Counted with `is`: `whereType<T>()` ignores T in the interpreter
  // (GEN-127, todo ghissues22).
  var nativeCount = 0;
  for (final target in targets) {
    if (target is NativeHitTestTarget) nativeCount++;
  }
  print('native targets: $nativeCount');

  return Column(
    children: [
      Text('native targets: $nativeCount of ${targets.length}'),
      ...rows,
    ],
  );
}
