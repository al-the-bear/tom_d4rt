// Particle-field home - example #10.
//
// State machine:
//   * `_field`        - current immutable Field. Replaced on every
//                       step / mode change / attractor move.
//   * `_paused`       - true at boot; tests drive the field via
//                       `btn-step` rather than the raw Ticker.
//   * `_ticker`       - raw `Ticker` created via
//                       `SingleTickerProviderStateMixin.createTicker`
//                       (per the spec, NOT via AnimationController).
//                       Started on play, stopped on pause.
//   * `_lastElapsedUs`- previous ticker callback timestamp in
//                       microseconds; subtracted to get dt.
//   * `_rng`          - Random(kParticleSeed) for reproducible
//                       seeding. Consumed by seedField on boot and
//                       on reset.
//
// Trail (`print(...)`) lines are stable, ASCII, and prefixed with
// `field.` so tests can scan them with a single matcher. Each
// step prints centroid + meanRadius - scalar observables that
// avoid dumping the full particle roster on every frame.
//
// ignore_for_file: avoid_print - the print() lines are the test trail.
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'field.dart';
import 'mode_selector.dart';
import 'particle_painter.dart';

class ParticleFieldHome extends StatefulWidget {
  const ParticleFieldHome({super.key});

  @override
  State<ParticleFieldHome> createState() => _ParticleFieldHomeState();
}

class _ParticleFieldHomeState extends State<ParticleFieldHome>
    with SingleTickerProviderStateMixin {
  late Field _field;
  bool _paused = true;
  Ticker? _ticker;
  int _lastElapsedUs = 0;
  late math.Random _rng;

  @override
  void initState() {
    super.initState();
    _rng = math.Random(kParticleSeed);
    _field = seedField(_rng, kParticleCount);
    print('field.init w=${kWorldW.round()} h=${kWorldH.round()} '
        'particles=${_field.particles.length} '
        'mode=${_field.mode.label} '
        'attractorX=${_field.attractorX.toStringAsFixed(1)} '
        'attractorY=${_field.attractorY.toStringAsFixed(1)}');
  }

  @override
  void dispose() {
    _ticker?.dispose();
    _ticker = null;
    super.dispose();
  }

  // -- Field mutation helpers ------------------------------------

  void _stepOnce() {
    final next = stepField(_field, kStepDt);
    setState(() {
      _field = next;
    });
    final c = centroid(_field.particles);
    final r = meanRadius(_field.particles, _field.attractorX, _field.attractorY);
    print('field.step dt=${kStepDt.toStringAsFixed(2)} '
        'mode=${_field.mode.label} '
        'centroidX=${c[0].toStringAsFixed(1)} '
        'centroidY=${c[1].toStringAsFixed(1)} '
        'meanR=${r.toStringAsFixed(1)}');
  }

  void _reset() {
    _rng = math.Random(kParticleSeed);
    setState(() {
      _field = seedField(_rng, kParticleCount);
    });
    print('field.reset particles=${_field.particles.length}');
  }

  void _setMode(FieldMode mode) {
    if (mode == _field.mode) return;
    setState(() {
      _field = _field.copyWith(mode: mode);
    });
    print('field.mode mode=${mode.label}');
  }

  void _setAttractor(double x, double y, {required String reason}) {
    if (x < 0.0 || x > kWorldW) return;
    if (y < 0.0 || y > kWorldH) return;
    setState(() {
      _field = _field.copyWith(attractorX: x, attractorY: y);
    });
    print('field.$reason x=${x.toStringAsFixed(1)} y=${y.toStringAsFixed(1)}');
  }

  // -- Auto-play (raw Ticker, not AnimationController) -----------

  void _togglePause() {
    setState(() {
      _paused = !_paused;
    });
    if (_paused) {
      _ticker?.stop();
      print('field.pause');
    } else {
      _ensureTicker();
      _lastElapsedUs = 0;
      _ticker!.start();
      print('field.play');
    }
  }

  void _ensureTicker() {
    _ticker ??= createTicker(_onFrame);
  }

  void _onFrame(Duration elapsed) {
    if (_paused || !mounted) return;
    final nowUs = elapsed.inMicroseconds;
    if (_lastElapsedUs == 0) {
      _lastElapsedUs = nowUs;
      return;
    }
    final dtUs = nowUs - _lastElapsedUs;
    _lastElapsedUs = nowUs;
    final dt = (dtUs / 1000000.0).clamp(0.0, 0.05);
    if (dt <= 0.0) return;
    final next = stepField(_field, dt);
    setState(() {
      _field = next;
    });
  }

  // -- Gesture / hover handling ----------------------------------

  void _onCanvasTap(TapDownDetails d, Size canvasSize) {
    final sx = kWorldW / canvasSize.width;
    final sy = kWorldH / canvasSize.height;
    _setAttractor(
      d.localPosition.dx * sx,
      d.localPosition.dy * sy,
      reason: 'tap',
    );
  }

  void _onCanvasHover(PointerHoverEvent e, Size canvasSize) {
    final sx = kWorldW / canvasSize.width;
    final sy = kWorldH / canvasSize.height;
    _setAttractor(
      e.localPosition.dx * sx,
      e.localPosition.dy * sy,
      reason: 'cursor',
    );
  }

  // -- Build -----------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Particle Field')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                aspectRatio: kWorldW / kWorldH,
                child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints c) {
                    final size = Size(c.maxWidth, c.maxHeight);
                    return MouseRegion(
                      key: const Key('field-mouse-region'),
                      onHover: (PointerHoverEvent e) {
                        _onCanvasHover(e, size);
                      },
                      child: GestureDetector(
                        key: const Key('field-canvas'),
                        behavior: HitTestBehavior.opaque,
                        onTapDown: (TapDownDetails d) {
                          _onCanvasTap(d, size);
                        },
                        child: CustomPaint(
                          size: size,
                          painter: ParticlePainter(
                            particles: _field.particles,
                            attractorX: _field.attractorX,
                            attractorY: _field.attractorY,
                            mode: _field.mode,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ModeSelector(mode: _field.mode, onChanged: _setMode),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      key: const Key('btn-play-pause'),
                      icon: Icon(_paused ? Icons.play_arrow : Icons.pause),
                      tooltip: _paused ? 'Play' : 'Pause',
                      onPressed: _togglePause,
                    ),
                    IconButton(
                      key: const Key('btn-step'),
                      icon: const Icon(Icons.skip_next),
                      tooltip: 'Step',
                      onPressed: _stepOnce,
                    ),
                    IconButton(
                      key: const Key('btn-reset'),
                      icon: const Icon(Icons.refresh),
                      tooltip: 'Reset',
                      onPressed: _reset,
                    ),
                    const SizedBox(width: 12),
                    Chip(
                      key: const Key('mode-chip'),
                      label: Text('mode ${_field.mode.label}'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
