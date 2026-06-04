// Stroke model — one continuous pen-down → pen-up drag.
//
// Each stroke owns a growable buffer of `Offset` samples collected
// from `GestureDetector.onPanStart` (one initial point) and
// `onPanUpdate` (one per fired event). When the user lifts the
// pointer, the host pushes the stroke into the completed-strokes
// list and the painter renders the whole history every frame.
//
// Strokes are intentionally cheap value-ish objects — no IDs, no
// timestamps — because the host's setState-driven `CustomPainter`
// rebuild re-renders every stroke each frame. If/when the sample
// grows to thousands of strokes, the natural next step is to bake
// completed strokes into a `Picture` once and only repaint the
// in-progress one.
import 'package:flutter/material.dart';

class Stroke {
  /// Brush colour for the entire stroke. Strokes always have a
  /// single colour — switching swatches mid-drag would require
  /// splitting the stroke at the switch point, which the UX
  /// doesn't support.
  final Color color;

  /// Brush width in logical pixels.
  final double width;

  /// Pointer samples in screen-local coordinates. The buffer is
  /// mutable because `onPanUpdate` appends points while the stroke
  /// is still in-progress; once the host commits the stroke to its
  /// history list, callers must treat the buffer as read-only.
  final List<Offset> points;

  Stroke({
    required this.color,
    required this.width,
    List<Offset>? initialPoints,
  }) : points = initialPoints != null
            ? List<Offset>.from(initialPoints)
            : <Offset>[];

  /// Append a new sample to the buffer. Called from `onPanUpdate`.
  void addPoint(Offset p) {
    points.add(p);
  }

  /// Number of point samples in the stroke.
  int get length => points.length;

  /// True when the stroke has zero samples — should not happen in
  /// normal use, but the painter guards against it for safety.
  bool get isEmpty => points.isEmpty;

  /// Inverse of [isEmpty].
  bool get isNotEmpty => points.isNotEmpty;
}
