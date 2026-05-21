// Particle burst rendered on win.
//
// A short-lived ticker (~1.6s) spawns N particles at the centre of
// the painter, applies gravity each frame, and repaints. When the
// life is exhausted the `onComplete` callback fires so the host can
// remove the overlay. All drawing happens through a `CustomPainter`
// — no nested widgets, no animations on individual particles.
//
// ignore_for_file: avoid_print — the print() lines are the test trail.
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ConfettiBurst extends StatefulWidget {
  final double width;
  final double height;
  final int particleCount;
  final VoidCallback onComplete;

  const ConfettiBurst({
    super.key,
    required this.width,
    required this.height,
    required this.onComplete,
    this.particleCount = 36,
  });

  @override
  State<ConfettiBurst> createState() => _ConfettiBurstState();
}

class _ConfettiBurstState extends State<ConfettiBurst>
    with SingleTickerProviderStateMixin {
  Ticker? _ticker;
  int _lastUs = 0;
  double _life = 0.0;
  static const double _maxLife = 1.6;
  List<_Particle> _particles = <_Particle>[];
  bool _done = false;

  @override
  void initState() {
    super.initState();
    final math.Random rng = math.Random(7);
    final List<_Particle> list = <_Particle>[];
    final double cx = widget.width / 2.0;
    final double cy = widget.height / 2.0;
    for (int i = 0; i < widget.particleCount; i = i + 1) {
      final double angle = rng.nextDouble() * math.pi * 2.0;
      final double speed = 120.0 + rng.nextDouble() * 220.0;
      list.add(_Particle(
        x: cx,
        y: cy,
        vx: math.cos(angle) * speed,
        vy: math.sin(angle) * speed - 100.0,
        color: _palette[rng.nextInt(_palette.length)],
        size: 4.0 + rng.nextDouble() * 4.0,
      ));
    }
    _particles = list;
    print('confetti.start particles=${list.length}');
    _ticker = createTicker(_onFrame)..start();
  }

  @override
  void dispose() {
    _ticker?.dispose();
    _ticker = null;
    super.dispose();
  }

  void _onFrame(Duration elapsed) {
    if (!mounted || _done) return;
    final int nowUs = elapsed.inMicroseconds;
    if (_lastUs == 0) {
      _lastUs = nowUs;
      return;
    }
    final double dt = ((nowUs - _lastUs) / 1000000.0).clamp(0.0, 0.05);
    _lastUs = nowUs;
    _life = _life + dt;
    const double gravity = 480.0;
    final List<_Particle> next = <_Particle>[];
    for (int i = 0; i < _particles.length; i = i + 1) {
      final _Particle p = _particles[i];
      next.add(_Particle(
        x: p.x + p.vx * dt,
        y: p.y + p.vy * dt,
        vx: p.vx * 0.985,
        vy: p.vy + gravity * dt,
        color: p.color,
        size: p.size,
      ));
    }
    setState(() {
      _particles = next;
    });
    if (_life >= _maxLife) {
      _done = true;
      _ticker?.stop();
      print('confetti.end');
      widget.onComplete();
    }
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        key: const Key('confetti'),
        size: Size(widget.width, widget.height),
        painter: _ConfettiPainter(
          particles: _particles,
          alpha: (1.0 - (_life / _maxLife)).clamp(0.0, 1.0),
        ),
      ),
    );
  }
}

class _Particle {
  final double x;
  final double y;
  final double vx;
  final double vy;
  final Color color;
  final double size;

  const _Particle({
    required this.x,
    required this.y,
    required this.vx,
    required this.vy,
    required this.color,
    required this.size,
  });
}

const List<Color> _palette = <Color>[
  Color(0xFFE53935),
  Color(0xFFFFB300),
  Color(0xFF43A047),
  Color(0xFF1E88E5),
  Color(0xFF8E24AA),
  Color(0xFF00ACC1),
];

class _ConfettiPainter extends CustomPainter {
  final List<_Particle> particles;
  final double alpha;

  const _ConfettiPainter({required this.particles, required this.alpha});

  @override
  void paint(Canvas canvas, Size size) {
    for (int i = 0; i < particles.length; i = i + 1) {
      final _Particle p = particles[i];
      final Paint paint = Paint()
        ..color = p.color.withValues(alpha: alpha);
      canvas.drawCircle(Offset(p.x, p.y), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ConfettiPainter old) {
    if (!identical(old.particles, particles)) return true;
    if (old.alpha != alpha) return true;
    return false;
  }
}
