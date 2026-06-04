// Model + math for the cubic-Bezier editor.
//
// The four control points are stored as normalised `Offset`s in
// `[0, 1] × [0, 1]` so the painter and the gesture math don't have
// to know the canvas size. The `Home` widget converts the
// pointer's screen position into the same normalised space before
// calling `setPoint`.
//
// The class is a [ChangeNotifier]; `Home` rebuilds via
// `AnimatedBuilder` whenever any field changes. Every mutation
// emits a `bezier.*` trail line so the tests can inspect the
// transition without having to scrape the rendered widget tree.
//
// ignore_for_file: avoid_print
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart' show Offset;

class BezierModel extends ChangeNotifier {
  /// The four control points, p0..p3, each in normalised
  /// `[0, 1] × [0, 1]` space.
  late List<Offset> points;

  /// Number of straight segments used to approximate the curve in
  /// the painter overlay. The smooth `Path.cubicTo` always
  /// renders; this `resolution` drives the "sampled" polyline so
  /// the user can see the effect of changing the slider.
  int resolution = 16;

  /// When `true` the painter draws the control polygon and the
  /// construction circles at each handle. When `false` only the
  /// smooth curve and the four draggable circles are visible.
  bool showConstruction = true;

  /// Animation progress in `[0, 1]` driving the preview dot along
  /// the curve. `0` means the dot sits at `p0`, `1` at `p3`. Set
  /// by the `AnimationController` listener in `Home`.
  double previewT = 0.0;

  BezierModel() {
    points = <Offset>[
      const Offset(0.1, 0.5),
      const Offset(0.3, 0.1),
      const Offset(0.7, 0.9),
      const Offset(0.9, 0.5),
    ];
    print('bezier.init points=${points.length} resolution=$resolution '
        'construction=$showConstruction');
  }

  /// Update control point [i] to the supplied normalised offset.
  /// Out-of-range values are clamped to `[0, 1]` so the handles
  /// can never leave the editor area.
  void setPoint(int i, Offset p) {
    if (i < 0 || i >= points.length) return;
    final double cx = p.dx.clamp(0.0, 1.0).toDouble();
    final double cy = p.dy.clamp(0.0, 1.0).toDouble();
    points[i] = Offset(cx, cy);
    print('bezier.point i=$i x=${cx.toStringAsFixed(2)} '
        'y=${cy.toStringAsFixed(2)}');
    notifyListeners();
  }

  /// Set the sampling resolution. Clamped to `[2, 64]` so the
  /// painter never has to handle degenerate cases.
  void setResolution(int r) {
    final int v = r.clamp(2, 64);
    if (v == resolution) return;
    resolution = v;
    print('bezier.resolution=$resolution');
    notifyListeners();
  }

  /// Toggle the construction overlay.
  void setShowConstruction(bool v) {
    if (v == showConstruction) return;
    showConstruction = v;
    print('bezier.toggle=$showConstruction');
    notifyListeners();
  }

  /// Update the preview progress and notify. Called on every tick
  /// of the play animation; emits a trail line only on the
  /// boundary values (`0` and `1`) to keep test output manageable.
  void setPreviewT(double t) {
    final double v = t.clamp(0.0, 1.0).toDouble();
    if (v == previewT) return;
    previewT = v;
    if (v == 0.0 || v == 1.0) {
      print('bezier.preview t=${v.toStringAsFixed(2)}');
    }
    notifyListeners();
  }

  /// Cubic-Bezier point at parameter [t] in normalised coords.
  /// Used by both the painter (to draw the preview dot and the
  /// resolution-driven polyline) and by tests as an oracle.
  Offset pointAt(double t) {
    final double mt = 1.0 - t;
    final double a = mt * mt * mt;
    final double b = 3.0 * mt * mt * t;
    final double c = 3.0 * mt * t * t;
    final double d = t * t * t;
    final Offset p0 = points[0];
    final Offset p1 = points[1];
    final Offset p2 = points[2];
    final Offset p3 = points[3];
    return Offset(
      a * p0.dx + b * p1.dx + c * p2.dx + d * p3.dx,
      a * p0.dy + b * p1.dy + c * p2.dy + d * p3.dy,
    );
  }
}
