// Drawing pad — entry #5 from `doc/example_app_plan.md`.
//
// Single-stroke sketchpad: a `CustomPainter` canvas that
// accumulates strokes from finger / mouse drags. Toolbar exposes
// six colour swatches, a brush-size slider, and undo / redo /
// clear. Strokes are stored as `List<Offset>` and re-rendered on
// every frame.
//
// Exercises:
//   * `CustomPainter.paint` + `shouldRepaint`
//   * `GestureDetector.onPanStart` / `onPanUpdate` / `onPanEnd`
//   * Undo / redo / clear via a bounded list pair
//   * `Slider` callback driving the brush width
//   * `GestureDetector`-backed colour-swatch grid (no Material
//     `Chip` / `RadioListTile` so the picker remains pure layout)
import 'package:flutter/material.dart';

import 'home.dart';

Widget build(BuildContext context) {
  return MaterialApp(
    title: 'Drawing Pad',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal,
        brightness: Brightness.light,
      ),
    ),
    home: const DrawingPadHome(),
  );
}
