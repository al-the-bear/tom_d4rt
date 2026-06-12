// Host-owned controller for the optimized particle field.
//
// THE OPTIMIZATION (particle-field freeze §"Optimized-script rewrite plan"):
// the original sample drives the canvas with `MouseRegion onHover → setState →
// full interpreted rebuild on every mouse move`. Under the d4rt interpreter
// each `setState` re-interprets the entire `build()` (thousands of
// `Environment`s / closures per frame), and that sustained allocation refills
// old-gen until the major GC stalls — the freeze.
//
// Here the mutable simulation lives in **`ValueNotifier`s owned by this
// controller, not in the widget tree**:
//   * `field`  — the live `Field` snapshot. Drives the painter directly via
//                `CustomPainter(repaint: field)`, so a tick / hover repaints
//                the canvas with **zero widget rebuild** (only the interpreted
//                `paint()` re-runs).
//   * `mode`   — mirrors `field.value.mode`, but only fires on an actual mode
//                change, so the (tiny) mode controls rebuild on mode changes
//                rather than every physics frame.
//   * `paused` — drives the play/pause icon via a `ValueListenableBuilder`.
//
// The page widget tree references these notifiers and is interpreted exactly
// once; nothing re-interprets it per frame.
//
// ignore_for_file: avoid_print — the print() lines are the run/test trail.
import 'dart:math' as math;
import 'dart:ui' show Offset, Size;

import 'package:flutter/foundation.dart';
import 'package:flutter/scheduler.dart';

import 'field.dart';

class FieldController {
  final TickerProvider vsync;
  final ValueNotifier<Field> field;
  final ValueNotifier<FieldMode> mode = ValueNotifier<FieldMode>(FieldMode.attract);
  final ValueNotifier<bool> paused = ValueNotifier<bool>(true);
  math.Random _rng;
  Ticker? _ticker;
  int _lastElapsedUs = 0;

  FieldController._(this.vsync, this.field, this._rng);

  factory FieldController({required TickerProvider vsync}) {
    final rng = math.Random(kParticleSeed);
    final field = ValueNotifier<Field>(seedField(rng, kParticleCount));
    final c = FieldController._(vsync, field, rng);
    final f = field.value;
    print('field.init w=${kWorldW.round()} h=${kWorldH.round()} '
        'particles=${f.particles.length} '
        'mode=${f.mode.label} '
        'attractorX=${f.attractorX.toStringAsFixed(1)} '
        'attractorY=${f.attractorY.toStringAsFixed(1)}');
    return c;
  }

  void dispose() {
    _ticker?.dispose();
    _ticker = null;
    field.dispose();
    mode.dispose();
    paused.dispose();
  }

  // -- Field mutation helpers ------------------------------------

  void stepOnce() {
    final next = stepField(field.value, kStepDt);
    field.value = next;
    final c = centroid(next.particles);
    final r = meanRadius(next.particles, next.attractorX, next.attractorY);
    print('field.step dt=${kStepDt.toStringAsFixed(2)} '
        'mode=${next.mode.label} '
        'centroidX=${c[0].toStringAsFixed(1)} '
        'centroidY=${c[1].toStringAsFixed(1)} '
        'meanR=${r.toStringAsFixed(1)}');
  }

  void reset() {
    _rng = math.Random(kParticleSeed);
    final next = seedField(_rng, kParticleCount);
    field.value = next;
    mode.value = next.mode;
    print('field.reset particles=${next.particles.length}');
  }

  void setMode(FieldMode m) {
    if (m == field.value.mode) return;
    field.value = field.value.copyWith(mode: m);
    mode.value = m;
    print('field.mode mode=${m.label}');
  }

  void setAttractor(double x, double y, String reason) {
    if (x < 0.0 || x > kWorldW) return;
    if (y < 0.0 || y > kWorldH) return;
    field.value = field.value.copyWith(attractorX: x, attractorY: y);
    print('field.$reason x=${x.toStringAsFixed(1)} y=${y.toStringAsFixed(1)}');
  }

  void setAttractorFromCanvas(Offset local, Size canvasSize, String reason) {
    if (canvasSize.width <= 0 || canvasSize.height <= 0) return;
    final sx = kWorldW / canvasSize.width;
    final sy = kWorldH / canvasSize.height;
    setAttractor(local.dx * sx, local.dy * sy, reason);
  }

  // -- Auto-play (raw Ticker, not AnimationController) -----------

  void togglePause() {
    final next = !paused.value;
    paused.value = next;
    if (next) {
      _ticker?.stop();
      print('field.pause');
    } else {
      _ticker ??= vsync.createTicker(_onFrame);
      _lastElapsedUs = 0;
      _ticker!.start();
      print('field.play');
    }
  }

  void _onFrame(Duration elapsed) {
    if (paused.value) return;
    final nowUs = elapsed.inMicroseconds;
    if (_lastElapsedUs == 0) {
      _lastElapsedUs = nowUs;
      return;
    }
    final dtUs = nowUs - _lastElapsedUs;
    _lastElapsedUs = nowUs;
    final dt = (dtUs / 1000000.0).clamp(0.0, 0.05);
    if (dt <= 0.0) return;
    field.value = stepField(field.value, dt);
  }
}
