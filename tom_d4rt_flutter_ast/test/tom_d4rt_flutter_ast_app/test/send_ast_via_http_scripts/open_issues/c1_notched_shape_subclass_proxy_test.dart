// Reproduces C.1 — no auto-synthesized interface proxy for `NotchedShape` (U5).
//
// A script subclass of the bridged abstract base `NotchedShape` passed to
// `BottomAppBar.shape` cannot cross to native code because no interface proxy is
// registered for it.
//
// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class _RectNotchedShape extends NotchedShape {
  const _RectNotchedShape();
  @override
  Path getOuterPath(Rect host, Rect? guest) => Path()..addRect(host);
}

dynamic build(BuildContext context) {
  return Scaffold(
    bottomNavigationBar: const BottomAppBar(
      shape: _RectNotchedShape(),
      child: SizedBox(height: 50),
    ),
    body: const SizedBox.shrink(),
  );
}
