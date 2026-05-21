// Bouncing-balls home — example #9.
//
// State machine:
//   * `_world`        — current World (balls + gravity + elasticity).
//                       Replaced (not mutated) on every step so the
//                       painter can use identity checks.
//   * `_nextId`       — strictly-increasing ball id. Used for the
//                       `Ball.id`-based equality.
//   * `_paused`       — true at boot; tests drive the world via
//                       `btn-step` instead of the auto-play ticker.
//   * `_ticker`       — AnimationController(vsync: this, duration:
//                       1h).repeat() used as a Ticker-style update
//                       loop. `addListener` measures real-time dt
//                       and applies that to `stepWorld`.
//   * `_rng`          — Random(kBallSeed) for reproducible spawn
//                       positions; consumed by `btn-spawn`.
//   * `_lastFrameMs`  — wall-clock anchor for the auto-play dt
//                       calculation. Reset every play.
//
// Trail (`print(...)`) lines are stable, ASCII, and prefixed with
// `physics.` so the test can scan them with a single matcher.
//
// ignore_for_file: avoid_print — the print() lines are the test trail.
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'ball_painter.dart';
import 'physics_controls.dart';
import 'world.dart';

class BouncingBallsHome extends StatefulWidget {
  const BouncingBallsHome({super.key});

  @override
  State<BouncingBallsHome> createState() => _BouncingBallsHomeState();
}

class _BouncingBallsHomeState extends State<BouncingBallsHome>
    with SingleTickerProviderStateMixin {
  World _world = const World(
    balls: <Ball>[],
    gravity: kDefaultGravity,
    elasticity: kDefaultElasticity,
  );
  int _nextId = 0;
  bool _paused = true;
  late math.Random _rng;
  AnimationController? _ticker;
  int _lastFrameMs = 0;

  @override
  void initState() {
    super.initState();
    _rng = math.Random(kBallSeed);
    print('physics.init w=${kWorldW.round()} h=${kWorldH.round()} '
        'balls=${_world.balls.length} '
        'gravity=${_world.gravity.round()} '
        'elasticity=${_world.elasticity.toStringAsFixed(2)}');
  }

  @override
  void dispose() {
    _ticker?.dispose();
    _ticker = null;
    super.dispose();
  }

  // ── World mutation helpers ─────────────────────────────────────

  void _stepOnce() {
    final next = stepWorld(_world, kStepDt);
    setState(() {
      _world = next;
    });
    print('physics.step dt=${kStepDt.toStringAsFixed(2)} '
        'balls=${_world.balls.length} '
        'topY=${_world.topY.toStringAsFixed(1)}');
  }

  void _spawn() {
    final id = _nextId;
    _nextId += 1;
    final ball = spawnBall(id, _rng.nextDouble(), _rng.nextDouble());
    final next = List<Ball>.from(_world.balls);
    next.add(ball);
    setState(() {
      _world = _world.copyWith(balls: next);
    });
    print('physics.spawn id=$id x=${ball.x.toStringAsFixed(1)} '
        'y=${ball.y.toStringAsFixed(1)} '
        'vx=${ball.vx.toStringAsFixed(1)} '
        'vy=${ball.vy.toStringAsFixed(1)} '
        'balls=${_world.balls.length}');
  }

  void _clear() {
    setState(() {
      _world = _world.copyWith(balls: const <Ball>[]);
    });
    _nextId = 0;
    _rng = math.Random(kBallSeed);
    print('physics.clear balls=${_world.balls.length}');
  }

  void _onGravityChanged(double g) {
    setState(() {
      _world = _world.copyWith(gravity: g);
    });
    print('physics.gravity g=${g.round()}');
  }

  void _onElasticityChanged(double e) {
    setState(() {
      _world = _world.copyWith(elasticity: e);
    });
    print('physics.elasticity e=${e.toStringAsFixed(2)}');
  }

  // ── Auto-play (AnimationController-driven) ─────────────────────

  void _togglePause() {
    setState(() {
      _paused = !_paused;
    });
    if (_paused) {
      _ticker?.stop();
      print('physics.pause');
    } else {
      _ensureTicker();
      _lastFrameMs = DateTime.now().millisecondsSinceEpoch;
      _ticker!.repeat();
      print('physics.play');
    }
  }

  void _ensureTicker() {
    if (_ticker != null) return;
    _ticker = AnimationController(
      vsync: this,
      duration: const Duration(hours: 1),
    );
    _ticker!.addListener(_onFrame);
  }

  void _onFrame() {
    if (_paused || !mounted) return;
    final now = DateTime.now().millisecondsSinceEpoch;
    final dtMs = now - _lastFrameMs;
    _lastFrameMs = now;
    // Cap dt so a paused-then-resumed loop doesn't fast-forward.
    final dt = (dtMs / 1000.0).clamp(0.0, 0.05);
    if (dt <= 0.0) return;
    final next = stepWorld(_world, dt);
    setState(() {
      _world = next;
    });
  }

  // ── Gesture handling ───────────────────────────────────────────

  void _onCanvasTap(TapDownDetails d, Size canvasSize) {
    final sx = kWorldW / canvasSize.width;
    final sy = kWorldH / canvasSize.height;
    final worldX = d.localPosition.dx * sx;
    final worldY = d.localPosition.dy * sy;
    if (worldX < 0.0 || worldX > kWorldW) return;
    if (worldY < 0.0 || worldY > kWorldH) return;
    final id = _nextId;
    _nextId += 1;
    final ball = Ball(
      id: id,
      x: worldX,
      y: worldY,
      vx: (_rng.nextDouble() - 0.5) * 160.0,
      vy: 0.0,
      radius: kBallRadius,
      colorIndex: id % kPaletteSize,
    );
    final next = List<Ball>.from(_world.balls);
    next.add(ball);
    setState(() {
      _world = _world.copyWith(balls: next);
    });
    print('physics.tap id=$id x=${worldX.toStringAsFixed(1)} '
        'y=${worldY.toStringAsFixed(1)} '
        'balls=${_world.balls.length}');
  }

  // ── Build ──────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bouncing Balls')),
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
                    return GestureDetector(
                      key: const Key('balls-canvas'),
                      behavior: HitTestBehavior.opaque,
                      onTapDown: (TapDownDetails d) {
                        _onCanvasTap(d, size);
                      },
                      child: CustomPaint(
                        size: size,
                        painter: BallPainter(balls: _world.balls),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          PhysicsControls(
            paused: _paused,
            ballCount: _world.balls.length,
            gravity: _world.gravity,
            elasticity: _world.elasticity,
            onPlayPause: _togglePause,
            onStep: _stepOnce,
            onSpawn: _spawn,
            onClear: _clear,
            onGravityChanged: _onGravityChanged,
            onElasticityChanged: _onElasticityChanged,
          ),
        ],
      ),
    );
  }
}
