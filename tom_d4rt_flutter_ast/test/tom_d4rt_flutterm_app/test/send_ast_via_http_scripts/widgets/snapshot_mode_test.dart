import 'dart:math' as math;

import 'package:flutter/material.dart';

// Previously emitted 1 FE ("A RenderFlex overflowed by 14 pixels on
// the bottom") in the small-overflow sub-pocket of cluster Fa1/N1.
// Closed 2026-04-29 by re-sizing the AppBar slot: `_SmodeAppBar`
// preferred-height bumped from 72 → 88 to match the actual content
// (44 px `_SmodeShutterIndicator` + 38 px vertical Container
// padding), and the top padding shaved by 2 px to keep the visual
// proportions. FE drops to 0 in `hardly_relevant_classes_5_test`
// without altering the demo's appearance. The fa1 sentinel
// (`test/fa1_bisect_test.dart [fa1-2250-sentinel]`) now reports
// `snapshot_mode_test` at FE=0.

// ---------------------------------------------------------------------------
// SnapshotMode — Darkroom Gallery
// ---------------------------------------------------------------------------
// This hand-authored demo explores `SnapshotMode`, the enum that tells a
// `SnapshotWidget` how to behave when its subtree cannot be rasterized to an
// offscreen image. The three values — `permissive`, `normal`, `forced` —
// each produce a different outcome when the child contains content like a
// `BackdropFilter` that cannot be captured cleanly.
//
// The visual metaphor is a 1960s photography darkroom lit by an amber
// safelight: film strips, enlarger lenses, developing baths. Every panel in
// the gallery corresponds to one aspect of the enum: the hero reel animates
// the act of capturing a snapshot, the side-by-side cells show how each
// mode reacts to a filter-heavy child, and the comparison painter annotates
// the three film frames with plain-language meaning.
//
// This file is executed by the d4rt AST harness, so there is no `main()`
// and no `runApp()`. The top-level `build` function returns a MaterialApp.
// ---------------------------------------------------------------------------

// ---- Palette -------------------------------------------------------------

const Color _kSmodeAmber = Color(0xFFF6B93B);
const Color _kSmodeAmberDeep = Color(0xFFD4922A);
const Color _kSmodeAmberGlow = Color(0xFFFFD27A);
const Color _kSmodeCharcoal = Color(0xFF1E1E24);
const Color _kSmodeCharcoalSoft = Color(0xFF2A2A32);
const Color _kSmodeCharcoalDeep = Color(0xFF14141A);
const Color _kSmodeLens = Color(0xFFCBD3DA);
const Color _kSmodeLensDim = Color(0xFF8C939A);
const Color _kSmodeEmulsion = Color(0xFFEFE2C4);
const Color _kSmodeDanger = Color(0xFFE45E5E);
const Color _kSmodeSafe = Color(0xFF7FBE7A);
const Color _kSmodeWarn = Color(0xFFE6B85C);

// ---- Entry point --------------------------------------------------------

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'SnapshotMode — Darkroom Gallery',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _kSmodeCharcoal,
      colorScheme: const ColorScheme.dark(
        primary: _kSmodeAmber,
        secondary: _kSmodeAmberDeep,
        surface: _kSmodeCharcoalSoft,
      ),
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _kSmodeLens),
      ),
    ),
    home: const _SmodeGalleryHome(),
  );
}

// ===========================================================================
// Root scaffold
// ===========================================================================

class _SmodeGalleryHome extends StatefulWidget {
  const _SmodeGalleryHome();

  @override
  State<_SmodeGalleryHome> createState() => _SmodeGalleryHomeState();
}

class _SmodeGalleryHomeState extends State<_SmodeGalleryHome>
    with TickerProviderStateMixin {
  late final AnimationController _reelController;
  late final AnimationController _safelightController;
  late final AnimationController _pulseController;

  bool _allowSnapshotting = true;
  double _shaderLayers = 2.0;
  int _frameStripIndex = 0;
  int _selectedModeIndex = 0;

  @override
  void initState() {
    super.initState();
    _reelController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..repeat();
    _safelightController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: true);
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _reelController.dispose();
    _safelightController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _toggleSnapshotting(bool value) {
    setState(() {
      _allowSnapshotting = value;
    });
    debugPrint('[SnapshotMode demo] allowSnapshotting=$value');
  }

  void _onShaderLayersChanged(double value) {
    setState(() {
      _shaderLayers = value;
    });
  }

  void _onFrameStripTap(int index) {
    setState(() {
      _frameStripIndex = index;
    });
  }

  void _onModeTap(int index) {
    setState(() {
      _selectedModeIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _SmodeAppBar(
        pulse: _pulseController,
        safelight: _safelightController,
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
        children: <Widget>[
          _SmodeReelHero(controller: _reelController),
          const SizedBox(height: 24),
          _SmodeIntroCard(safelight: _safelightController),
          const SizedBox(height: 24),
          _SmodeGalleryRow(
            allowSnapshotting: _allowSnapshotting,
            shaderLayers: _shaderLayers,
            onToggle: _toggleSnapshotting,
          ),
          const SizedBox(height: 24),
          _SmodeModeComparisonPanel(
            selectedIndex: _selectedModeIndex,
            onTap: _onModeTap,
          ),
          const SizedBox(height: 24),
          _SmodeDiagnosticCard(),
          const SizedBox(height: 24),
          _SmodeStressTestRow(
            shaderLayers: _shaderLayers,
            onChanged: _onShaderLayersChanged,
          ),
          const SizedBox(height: 24),
          _SmodeFrameStrip(
            selectedIndex: _frameStripIndex,
            onTap: _onFrameStripTap,
          ),
          const SizedBox(height: 24),
          _SmodePitfallCard(),
          const SizedBox(height: 24),
          _SmodeFooter(),
        ],
      ),
    );
  }
}

// ===========================================================================
// App bar with safelight pulse
// ===========================================================================

class _SmodeAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _SmodeAppBar({
    required this.pulse,
    required this.safelight,
  });

  final AnimationController pulse;
  final AnimationController safelight;

  @override
  Size get preferredSize => const Size.fromHeight(88);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(<Listenable>[pulse, safelight]),
      builder: (BuildContext _, Widget? child) {
        final double glow = 0.35 + 0.25 * pulse.value;
        final double sway = math.sin(safelight.value * math.pi * 2) * 2.0;
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                _kSmodeCharcoalDeep,
                _kSmodeCharcoalSoft.withValues(alpha: 0.95),
              ],
            ),
            border: Border(
              bottom: BorderSide(
                color: _kSmodeAmber.withValues(alpha: 0.45),
                width: 1.2,
              ),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: _kSmodeAmber.withValues(alpha: glow * 0.3),
                blurRadius: 18,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          // The AppBar's preferredSize (88 px) holds the 44 px
          // `_SmodeShutterIndicator` plus 26 + 12 = 38 px of vertical
          // padding (sway adds at most 0.4 px). A 72 px slot was 14 px
          // short and produced the small-overflow FE; this padding +
          // height combination has no overflow.
          padding: EdgeInsets.fromLTRB(20, 26 + sway * 0.2, 20, 12),
          child: Row(
            children: <Widget>[
              _SmodeSafelightBadge(progress: pulse.value),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'SnapshotMode',
                    style: TextStyle(
                      color: _kSmodeAmberGlow,
                      fontSize: 20,
                      letterSpacing: 2.4,
                      fontWeight: FontWeight.w600,
                      shadows: <Shadow>[
                        Shadow(
                          color: _kSmodeAmber.withValues(alpha: glow),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'DARKROOM GALLERY · permissive · normal · forced',
                    style: TextStyle(
                      color: _kSmodeLensDim,
                      fontSize: 10,
                      letterSpacing: 1.8,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              _SmodeShutterIndicator(progress: pulse.value),
            ],
          ),
        );
      },
    );
  }
}

class _SmodeSafelightBadge extends StatelessWidget {
  const _SmodeSafelightBadge({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: CustomPaint(
        painter: _SmodeSafelightPainter(progress: progress),
      ),
    );
  }
}

class _SmodeSafelightPainter extends CustomPainter {
  _SmodeSafelightPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = Offset(size.width / 2, size.height / 2);
    final double r = size.shortestSide / 2;

    final Paint bulb = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          _kSmodeAmberGlow.withValues(alpha: 0.9),
          _kSmodeAmber.withValues(alpha: 0.5 + 0.4 * progress),
          _kSmodeAmberDeep.withValues(alpha: 0.2),
          _kSmodeCharcoal.withValues(alpha: 0.0),
        ],
        stops: const <double>[0.0, 0.45, 0.8, 1.0],
      ).createShader(Rect.fromCircle(center: c, radius: r));
    canvas.drawCircle(c, r, bulb);

    final Paint ring = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..color = _kSmodeAmber.withValues(alpha: 0.8);
    canvas.drawCircle(c, r * 0.7, ring);

    final Paint filament = Paint()
      ..color = _kSmodeAmberGlow.withValues(alpha: 0.6 + 0.4 * progress)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    for (int i = 0; i < 3; i++) {
      final double angle = progress * math.pi * 2 + i * (math.pi * 2 / 3);
      canvas.drawLine(
        c,
        c + Offset(math.cos(angle), math.sin(angle)) * r * 0.55,
        filament,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SmodeSafelightPainter old) =>
      old.progress != progress;
}

class _SmodeShutterIndicator extends StatelessWidget {
  const _SmodeShutterIndicator({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 44,
      child: CustomPaint(
        painter: _SmodeShutterPainter(progress: progress),
      ),
    );
  }
}

class _SmodeShutterPainter extends CustomPainter {
  _SmodeShutterPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = Offset(size.width / 2, size.height / 2);
    final double r = size.shortestSide / 2 - 2;

    final Paint frame = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..color = _kSmodeLens.withValues(alpha: 0.7);
    canvas.drawCircle(c, r, frame);

    final double openness = 0.25 + 0.6 * progress;
    final Paint blade = Paint()
      ..color = _kSmodeCharcoalDeep.withValues(alpha: 0.85)
      ..style = PaintingStyle.fill;
    for (int i = 0; i < 6; i++) {
      final double a = i * (math.pi / 3);
      final Path p = Path()
        ..moveTo(c.dx, c.dy)
        ..lineTo(
          c.dx + math.cos(a) * r,
          c.dy + math.sin(a) * r,
        )
        ..lineTo(
          c.dx + math.cos(a + math.pi / 3 * openness) * r,
          c.dy + math.sin(a + math.pi / 3 * openness) * r,
        )
        ..close();
      canvas.drawPath(p, blade);
    }

    final Paint pupil = Paint()
      ..color = _kSmodeAmberGlow.withValues(alpha: 0.85);
    canvas.drawCircle(c, r * 0.15 * openness, pupil);
  }

  @override
  bool shouldRepaint(covariant _SmodeShutterPainter old) =>
      old.progress != progress;
}

// ===========================================================================
// Reel hero — animated film reel with spools + perforations
// ===========================================================================

class _SmodeReelHero extends StatelessWidget {
  const _SmodeReelHero({required this.controller});

  final AnimationController controller;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.6,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: <Color>[
              _kSmodeCharcoalDeep,
              _kSmodeCharcoalSoft,
            ],
          ),
          border: Border.all(
            color: _kSmodeAmber.withValues(alpha: 0.35),
            width: 1.2,
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _kSmodeAmberDeep.withValues(alpha: 0.25),
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: AnimatedBuilder(
            animation: controller,
            builder: (BuildContext _, Widget? child) {
              return CustomPaint(
                painter: _SmodeReelPainter(progress: controller.value),
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      left: 22,
                      top: 20,
                      child: Text(
                        'CAPTURING',
                        style: TextStyle(
                          color: _kSmodeAmberGlow.withValues(alpha: 0.9),
                          fontSize: 12,
                          letterSpacing: 4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 22,
                      top: 36,
                      right: 22,
                      child: Text(
                        'SnapshotMode.values',
                        style: TextStyle(
                          color: _kSmodeLens.withValues(alpha: 0.95),
                          fontSize: 26,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                          shadows: <Shadow>[
                            Shadow(
                              color: _kSmodeAmber.withValues(alpha: 0.4),
                              blurRadius: 16,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 22,
                      bottom: 18,
                      right: 22,
                      child: Text(
                        'Three values · three behaviours · one captured frame',
                        style: TextStyle(
                          color: _kSmodeLensDim.withValues(alpha: 0.9),
                          fontSize: 12,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _SmodeReelPainter extends CustomPainter {
  _SmodeReelPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    _paintFilmStrip(canvas, size);
    _paintLeftReel(canvas, size);
    _paintRightReel(canvas, size);
    _paintAmberWash(canvas, size);
  }

  void _paintFilmStrip(Canvas canvas, Size size) {
    final double stripH = size.height * 0.32;
    final double stripY = size.height - stripH - 6;
    final Rect strip = Rect.fromLTWH(0, stripY, size.width, stripH);

    final Paint stripPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[
          Color(0xFF0B0B10),
          Color(0xFF1A1A22),
          Color(0xFF0B0B10),
        ],
      ).createShader(strip);
    canvas.drawRect(strip, stripPaint);

    final Paint perf = Paint()..color = _kSmodeCharcoalDeep;
    final double perfH = stripH * 0.18;
    const double perfW = 10.0;
    const double gap = 16.0;
    final double offset = -(progress * (perfW + gap)) % (perfW + gap);
    for (double x = offset - perfW; x < size.width; x += perfW + gap) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, stripY + 4, perfW, perfH),
          const Radius.circular(2),
        ),
        perf,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, stripY + stripH - perfH - 4, perfW, perfH),
          const Radius.circular(2),
        ),
        perf,
      );
    }

    final Paint frameLine = Paint()
      ..color = _kSmodeAmber.withValues(alpha: 0.35)
      ..strokeWidth = 1.0;
    final double cy = stripY + stripH / 2;
    canvas.drawLine(Offset(0, cy - 8), Offset(size.width, cy - 8), frameLine);
    canvas.drawLine(Offset(0, cy + 8), Offset(size.width, cy + 8), frameLine);

    const List<String> labels = <String>[
      'permissive',
      'normal',
      'forced',
      'permissive',
      'normal',
    ];
    final double frameW = size.width / 3.5;
    final double scroll = progress * frameW;
    for (int i = -1; i < 5; i++) {
      final double fx = i * frameW - scroll;
      final Rect frame = Rect.fromLTWH(
        fx + 6,
        stripY + perfH + 8,
        frameW - 12,
        stripH - perfH * 2 - 16,
      );
      canvas.drawRect(
        frame,
        Paint()
          ..color = _kSmodeEmulsion.withValues(alpha: 0.08),
      );
      canvas.drawRect(
        frame,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 0.8
          ..color = _kSmodeAmber.withValues(alpha: 0.45),
      );
      final int li = ((i % labels.length) + labels.length) % labels.length;
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[li],
          style: TextStyle(
            color: _kSmodeAmberGlow.withValues(alpha: 0.85),
            fontSize: 10,
            letterSpacing: 1.2,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: frame.width);
      tp.paint(
        canvas,
        Offset(
          frame.center.dx - tp.width / 2,
          frame.center.dy - tp.height / 2,
        ),
      );
    }
  }

  void _paintLeftReel(Canvas canvas, Size size) {
    final Offset c = Offset(size.width * 0.18, size.height * 0.42);
    final double r = size.height * 0.28;
    _paintReel(canvas, c, r, progress * math.pi * 2);
  }

  void _paintRightReel(Canvas canvas, Size size) {
    final Offset c = Offset(size.width * 0.82, size.height * 0.42);
    final double r = size.height * 0.28;
    _paintReel(canvas, c, r, -progress * math.pi * 2);
  }

  void _paintReel(Canvas canvas, Offset c, double r, double rot) {
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..color = _kSmodeCharcoalDeep
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..color = _kSmodeAmberDeep.withValues(alpha: 0.7)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.6,
    );
    canvas.drawCircle(
      c,
      r * 0.78,
      Paint()
        ..color = _kSmodeLensDim.withValues(alpha: 0.25)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8,
    );

    final Paint spoke = Paint()
      ..color = _kSmodeLens.withValues(alpha: 0.55)
      ..strokeWidth = 2.2
      ..strokeCap = StrokeCap.round;
    for (int i = 0; i < 6; i++) {
      final double a = rot + i * (math.pi / 3);
      canvas.drawLine(
        c + Offset(math.cos(a), math.sin(a)) * r * 0.18,
        c + Offset(math.cos(a), math.sin(a)) * r * 0.72,
        spoke,
      );
    }

    canvas.drawCircle(
      c,
      r * 0.18,
      Paint()..color = _kSmodeAmber.withValues(alpha: 0.85),
    );
    canvas.drawCircle(
      c,
      r * 0.08,
      Paint()..color = _kSmodeCharcoalDeep,
    );
  }

  void _paintAmberWash(Canvas canvas, Size size) {
    final Rect full = Offset.zero & size;
    final Paint wash = Paint()
      ..shader = RadialGradient(
        center: Alignment.topLeft,
        radius: 1.3,
        colors: <Color>[
          _kSmodeAmber.withValues(alpha: 0.10),
          _kSmodeAmber.withValues(alpha: 0.0),
        ],
      ).createShader(full);
    canvas.drawRect(full, wash);
  }

  @override
  bool shouldRepaint(covariant _SmodeReelPainter old) =>
      old.progress != progress;
}

// ===========================================================================
// Intro card
// ===========================================================================

class _SmodeIntroCard extends StatelessWidget {
  const _SmodeIntroCard({required this.safelight});

  final AnimationController safelight;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: safelight,
      builder: (BuildContext _, Widget? child) {
        final double t = safelight.value;
        return Container(
          decoration: BoxDecoration(
            color: _kSmodeCharcoalSoft,
            borderRadius: BorderRadius.circular(14),
            border: Border(
              left: BorderSide(
                color: _kSmodeAmber.withValues(alpha: 0.55 + 0.35 * t),
                width: 3,
              ),
              top: BorderSide(color: _kSmodeCharcoalDeep),
              right: BorderSide(color: _kSmodeCharcoalDeep),
              bottom: BorderSide(color: _kSmodeCharcoalDeep),
            ),
          ),
          padding: const EdgeInsets.fromLTRB(18, 16, 18, 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _SmodeLensIcon(tilt: t),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'What is SnapshotMode?',
                      style: TextStyle(
                        color: _kSmodeAmberGlow,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.6,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'SnapshotMode tells a SnapshotWidget what to do when '
                      'rasterising its subtree is not possible — for example '
                      'when the child draws a BackdropFilter, a platform view, '
                      'or any other effect that cannot be captured to an '
                      'offscreen image. Each value trades correctness against '
                      'performance differently.',
                      style: TextStyle(
                        color: _kSmodeLens,
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SmodeLensIcon extends StatelessWidget {
  const _SmodeLensIcon({required this.tilt});

  final double tilt;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 54,
      height: 54,
      child: CustomPaint(
        painter: _SmodeLensIconPainter(tilt: tilt),
      ),
    );
  }
}

class _SmodeLensIconPainter extends CustomPainter {
  _SmodeLensIconPainter({required this.tilt});

  final double tilt;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = Offset(size.width / 2, size.height / 2);
    final double r = size.shortestSide / 2 - 3;

    canvas.drawCircle(
      c,
      r,
      Paint()
        ..color = _kSmodeCharcoalDeep
        ..style = PaintingStyle.fill,
    );
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5
        ..color = _kSmodeLens.withValues(alpha: 0.9),
    );
    canvas.drawCircle(
      c,
      r * 0.78,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = _kSmodeLensDim.withValues(alpha: 0.8),
    );

    final Paint glass = Paint()
      ..shader = RadialGradient(
        center: Alignment(-0.3 + tilt * 0.6, -0.3),
        colors: <Color>[
          _kSmodeAmberGlow.withValues(alpha: 0.85),
          _kSmodeAmber.withValues(alpha: 0.35),
          _kSmodeCharcoalDeep.withValues(alpha: 0.9),
        ],
        stops: const <double>[0.0, 0.5, 1.0],
      ).createShader(Rect.fromCircle(center: c, radius: r * 0.6));
    canvas.drawCircle(c, r * 0.6, glass);

    final Paint highlight = Paint()
      ..color = _kSmodeAmberGlow.withValues(alpha: 0.6);
    canvas.drawCircle(
      c + Offset(-r * 0.25 + tilt * 0.12 * r, -r * 0.28),
      r * 0.1,
      highlight,
    );
  }

  @override
  bool shouldRepaint(covariant _SmodeLensIconPainter old) => old.tilt != tilt;
}

// ===========================================================================
// Gallery row — three side-by-side cells, one per SnapshotMode
// ===========================================================================

class _SmodeGalleryRow extends StatelessWidget {
  const _SmodeGalleryRow({
    required this.allowSnapshotting,
    required this.shaderLayers,
    required this.onToggle,
  });

  final bool allowSnapshotting;
  final double shaderLayers;
  final ValueChanged<bool> onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kSmodeCharcoalDeep),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(Icons.photo_camera_outlined, color: _kSmodeAmber),
              const SizedBox(width: 10),
              const Expanded(
                child: Text(
                  'Live gallery — three snapshot modes side by side',
                  style: TextStyle(
                    color: _kSmodeAmberGlow,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              _SmodeAllowSwitch(
                value: allowSnapshotting,
                onChanged: onToggle,
              ),
            ],
          ),
          const SizedBox(height: 12),
          LayoutBuilder(
            builder: (BuildContext _, BoxConstraints c) {
              final bool wide = c.maxWidth > 640;
              final List<Widget> cells = <Widget>[
                _SmodeGalleryCell(
                  title: 'permissive',
                  description: 'Snapshot when possible; fall back to live '
                      'painting when the child cannot be captured.',
                  accent: _kSmodeSafe,
                  allow: allowSnapshotting,
                  layers: shaderLayers,
                  icon: Icons.shield_outlined,
                ),
                _SmodeGalleryCell(
                  title: 'normal',
                  description: 'Snapshot when possible; assert in debug if '
                      'the child cannot be captured.',
                  accent: _kSmodeWarn,
                  allow: allowSnapshotting,
                  layers: shaderLayers,
                  icon: Icons.filter_center_focus,
                ),
                _SmodeGalleryCell(
                  title: 'forced',
                  description: 'Always snapshot, even if the result will be '
                      'visually wrong (garbage pixels).',
                  accent: _kSmodeDanger,
                  allow: allowSnapshotting,
                  layers: shaderLayers,
                  icon: Icons.warning_amber_rounded,
                ),
              ];
              if (wide) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(child: cells[0]),
                    const SizedBox(width: 10),
                    Expanded(child: cells[1]),
                    const SizedBox(width: 10),
                    Expanded(child: cells[2]),
                  ],
                );
              }
              return Column(
                children: <Widget>[
                  cells[0],
                  const SizedBox(height: 10),
                  cells[1],
                  const SizedBox(height: 10),
                  cells[2],
                ],
              );
            },
          ),
          const SizedBox(height: 10),
          Text(
            'Toggle the switch to stop snapshotting the children entirely '
            '(equivalent to SnapshotController.allowSnapshotting = false). '
            'With snapshotting off, all three cells render the same way.',
            style: TextStyle(
              color: _kSmodeLensDim.withValues(alpha: 0.95),
              fontSize: 11.5,
              height: 1.4,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmodeAllowSwitch extends StatelessWidget {
  const _SmodeAllowSwitch({
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
          value ? 'allowSnapshotting: true' : 'allowSnapshotting: false',
          style: TextStyle(
            color: value ? _kSmodeAmberGlow : _kSmodeLensDim,
            fontSize: 11,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(width: 8),
        Switch(
          value: value,
          activeThumbColor: _kSmodeAmber,
          inactiveThumbColor: _kSmodeLensDim,
          inactiveTrackColor: _kSmodeCharcoalDeep,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _SmodeGalleryCell extends StatelessWidget {
  const _SmodeGalleryCell({
    required this.title,
    required this.description,
    required this.accent,
    required this.allow,
    required this.layers,
    required this.icon,
  });

  final String title;
  final String description;
  final Color accent;
  final bool allow;
  final double layers;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _kSmodeCharcoalDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: accent.withValues(alpha: 0.6),
          width: 1.2,
        ),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(icon, color: accent, size: 18),
              const SizedBox(width: 8),
              Text(
                'SnapshotMode.$title',
                style: TextStyle(
                  color: accent,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.6,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 1.1,
            child: _SmodeSimulatedSnapshot(
              mode: title,
              accent: accent,
              allow: allow,
              layers: layers,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: const TextStyle(
              color: _kSmodeLens,
              fontSize: 11.5,
              height: 1.35,
            ),
          ),
          const SizedBox(height: 6),
          Row(
            children: <Widget>[
              _SmodeDot(color: allow ? accent : _kSmodeLensDim),
              const SizedBox(width: 6),
              Text(
                allow ? 'snapshotting active' : 'snapshotting disabled',
                style: TextStyle(
                  color: allow ? accent : _kSmodeLensDim,
                  fontSize: 10.5,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SmodeDot extends StatelessWidget {
  const _SmodeDot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: color.withValues(alpha: 0.8),
            blurRadius: 4,
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Simulated snapshot cell — a filter-rich composition with a rotated caption
// ===========================================================================

class _SmodeSimulatedSnapshot extends StatelessWidget {
  const _SmodeSimulatedSnapshot({
    required this.mode,
    required this.accent,
    required this.allow,
    required this.layers,
  });

  final String mode;
  final Color accent;
  final bool allow;
  final double layers;

  bool get _snapshotable => layers <= 2.5;

  @override
  Widget build(BuildContext context) {
    final bool willSnapshot = allow && _willSnapshot();
    final bool garbage = allow && mode == 'forced' && !_snapshotable;

    Widget child = _buildFilterChild();
    if (willSnapshot) {
      child = _wrapAsSnapshot(child, garbage: garbage);
    }

    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          child,
          Positioned(
            left: 6,
            top: 6,
            child: _SmodeSnapshotBadge(
              snapshot: willSnapshot,
              garbage: garbage,
              accent: accent,
            ),
          ),
        ],
      ),
    );
  }

  bool _willSnapshot() {
    switch (mode) {
      case 'permissive':
        return _snapshotable;
      case 'normal':
        return _snapshotable;
      case 'forced':
      default:
        return true;
    }
  }

  Widget _buildFilterChild() {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[
                Color(0xFF3A2E1A),
                Color(0xFF221B12),
                Color(0xFF0D0A07),
              ],
            ),
          ),
        ),
        for (int i = 0; i < layers.round(); i++)
          Positioned.fill(
            child: IgnorePointer(
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return RadialGradient(
                    center: Alignment(
                      -0.6 + i * 0.3,
                      -0.5 + i * 0.25,
                    ),
                    radius: 0.9,
                    colors: <Color>[
                      _kSmodeAmberGlow.withValues(alpha: 0.35 / (i + 1)),
                      _kSmodeAmber.withValues(alpha: 0.15 / (i + 1)),
                      const Color(0x00000000),
                    ],
                  ).createShader(bounds);
                },
                blendMode: BlendMode.plus,
                child: Container(color: _kSmodeCharcoalDeep),
              ),
            ),
          ),
        Center(
          child: Transform.rotate(
            angle: -math.pi / 18,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return const LinearGradient(
                  colors: <Color>[
                    _kSmodeAmberGlow,
                    _kSmodeAmber,
                    _kSmodeAmberDeep,
                  ],
                ).createShader(bounds);
              },
              child: Text(
                mode.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.2,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              '${layers.round()}× filter',
              style: TextStyle(
                color: _kSmodeLens.withValues(alpha: 0.8),
                fontSize: 9,
                letterSpacing: 1.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _wrapAsSnapshot(Widget child, {required bool garbage}) {
    // We visually *represent* the snapshot. The real SnapshotWidget would
    // rasterise the subtree; here we desaturate it and tint it amber to
    // make the capture obvious in the gallery.
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        ColorFiltered(
          colorFilter: const ColorFilter.matrix(<double>[
            0.7, 0.3, 0.0, 0.0, 12.0,
            0.5, 0.5, 0.0, 0.0, 6.0,
            0.2, 0.2, 0.3, 0.0, 0.0,
            0.0, 0.0, 0.0, 1.0, 0.0,
          ]),
          child: child,
        ),
        if (garbage)
          Positioned.fill(
            child: CustomPaint(
              painter: _SmodeGarbagePainter(),
            ),
          ),
      ],
    );
  }
}

class _SmodeGarbagePainter extends CustomPainter {
  _SmodeGarbagePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final math.Random rng = math.Random(17);
    for (int i = 0; i < 60; i++) {
      final double x = rng.nextDouble() * size.width;
      final double y = rng.nextDouble() * size.height;
      final Paint p = Paint()
        ..color = Color.fromARGB(
          120,
          rng.nextInt(256),
          rng.nextInt(256),
          rng.nextInt(256),
        );
      canvas.drawRect(
        Rect.fromLTWH(x, y, 8.0 + rng.nextDouble() * 14, 3),
        p,
      );
    }
    final Paint tear = Paint()
      ..color = _kSmodeDanger.withValues(alpha: 0.25);
    canvas.drawRect(Offset.zero & size, tear);
  }

  @override
  bool shouldRepaint(covariant _SmodeGarbagePainter oldDelegate) => false;
}

class _SmodeSnapshotBadge extends StatelessWidget {
  const _SmodeSnapshotBadge({
    required this.snapshot,
    required this.garbage,
    required this.accent,
  });

  final bool snapshot;
  final bool garbage;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final String label = garbage
        ? 'GARBAGE SNAPSHOT'
        : snapshot
            ? 'SNAPSHOT'
            : 'LIVE';
    final Color c = garbage ? _kSmodeDanger : (snapshot ? accent : _kSmodeLens);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalDeep.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: c.withValues(alpha: 0.8)),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: c,
          fontSize: 9,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

// ===========================================================================
// Mode comparison panel — three annotated film frames
// ===========================================================================

class _SmodeModeComparisonPanel extends StatelessWidget {
  const _SmodeModeComparisonPanel({
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    const List<_SmodeModeInfo> modes = <_SmodeModeInfo>[
      _SmodeModeInfo(
        name: 'permissive',
        summary: 'Snapshot if we can, otherwise paint live.',
        detail: 'The snapshot widget will try to rasterise the child. If '
            'the subtree contains a BackdropFilter, platform view, or other '
            'unsupported content, it gracefully skips the snapshot and '
            'paints the child live. This is the safest default.',
        color: _kSmodeSafe,
      ),
      _SmodeModeInfo(
        name: 'normal',
        summary: 'Snapshot if we can, assert in debug if we cannot.',
        detail: 'Identical to permissive at runtime in a release build, '
            'but in debug mode an assertion fires when the subtree cannot '
            'be captured. Useful for catching regressions where unsupported '
            'content accidentally slipped into a snapshot boundary.',
        color: _kSmodeWarn,
      ),
      _SmodeModeInfo(
        name: 'forced',
        summary: 'Always snapshot, even when the result is wrong.',
        detail: 'No matter what the subtree contains, a rasterisation is '
            'produced. If the content is not snapshotable the captured '
            'image may show garbage pixels, stale content or black boxes. '
            'Only use when you absolutely need a stable raster and accept '
            'the visual consequences.',
        color: _kSmodeDanger,
      ),
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kSmodeCharcoalDeep),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.view_carousel_outlined, color: _kSmodeAmber),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Mode comparison · tap a frame',
                  style: TextStyle(
                    color: _kSmodeAmberGlow,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AspectRatio(
            aspectRatio: 2.3,
            child: CustomPaint(
              painter: _SmodeComparisonPainter(
                modes: modes,
                selectedIndex: selectedIndex,
              ),
              child: LayoutBuilder(
                builder: (BuildContext _, BoxConstraints c) {
                  return Row(
                    children: <Widget>[
                      for (int i = 0; i < modes.length; i++)
                        Expanded(
                          child: GestureDetector(
                            onTap: () => onTap(i),
                            behavior: HitTestBehavior.opaque,
                            child: const SizedBox.expand(),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 14),
          _SmodeModeDetailPanel(info: modes[selectedIndex]),
        ],
      ),
    );
  }
}

class _SmodeModeInfo {
  const _SmodeModeInfo({
    required this.name,
    required this.summary,
    required this.detail,
    required this.color,
  });
  final String name;
  final String summary;
  final String detail;
  final Color color;
}

class _SmodeComparisonPainter extends CustomPainter {
  _SmodeComparisonPainter({
    required this.modes,
    required this.selectedIndex,
  });

  final List<_SmodeModeInfo> modes;
  final int selectedIndex;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: <Color>[_kSmodeCharcoalDeep, Color(0xFF181820)],
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bg);

    _paintPerforations(canvas, size);

    final double frameW = size.width / 3;
    for (int i = 0; i < modes.length; i++) {
      _paintFrame(canvas, size, i, frameW);
    }

    final Paint divider = Paint()
      ..color = _kSmodeAmber.withValues(alpha: 0.2)
      ..strokeWidth = 1.0;
    for (int i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(frameW * i, 8),
        Offset(frameW * i, size.height - 8),
        divider,
      );
    }
  }

  void _paintPerforations(Canvas canvas, Size size) {
    final Paint p = Paint()..color = _kSmodeCharcoalDeep;
    const double perfW = 10.0;
    const double gap = 14.0;
    for (double x = 6; x < size.width; x += perfW + gap) {
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, 4, perfW, 6),
          const Radius.circular(2),
        ),
        p,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(x, size.height - 10, perfW, 6),
          const Radius.circular(2),
        ),
        p,
      );
    }
  }

  void _paintFrame(Canvas canvas, Size size, int i, double frameW) {
    final bool selected = i == selectedIndex;
    final _SmodeModeInfo info = modes[i];
    final Rect frame = Rect.fromLTWH(
      frameW * i + 14,
      22,
      frameW - 28,
      size.height - 44,
    );
    final Paint bg = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          info.color.withValues(alpha: selected ? 0.35 : 0.15),
          _kSmodeCharcoalDeep,
        ],
      ).createShader(frame);
    canvas.drawRect(frame, bg);

    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = selected ? 2.0 : 1.0
      ..color = info.color.withValues(alpha: selected ? 1.0 : 0.55);
    canvas.drawRect(frame, border);

    final TextPainter name = TextPainter(
      text: TextSpan(
        text: info.name.toUpperCase(),
        style: TextStyle(
          color: info.color,
          fontSize: 15,
          fontWeight: FontWeight.w800,
          letterSpacing: 2.0,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: frame.width - 16);
    name.paint(
      canvas,
      Offset(frame.left + 10, frame.top + 10),
    );

    final TextPainter summary = TextPainter(
      text: TextSpan(
        text: info.summary,
        style: TextStyle(
          color: _kSmodeLens.withValues(alpha: selected ? 1.0 : 0.8),
          fontSize: 11.0,
          height: 1.35,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: frame.width - 16);
    summary.paint(
      canvas,
      Offset(frame.left + 10, frame.top + 32),
    );

    // Icon-ish glyph: small photograph with an overlay X when forced.
    final Offset glyphCenter = Offset(
      frame.center.dx,
      frame.bottom - 26,
    );
    canvas.drawRect(
      Rect.fromCenter(center: glyphCenter, width: 34, height: 22),
      Paint()..color = _kSmodeEmulsion.withValues(alpha: 0.15),
    );
    canvas.drawRect(
      Rect.fromCenter(center: glyphCenter, width: 34, height: 22),
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.8
        ..color = info.color.withValues(alpha: 0.8),
    );
    if (info.name == 'forced') {
      final Paint x = Paint()
        ..color = _kSmodeDanger.withValues(alpha: 0.9)
        ..strokeWidth = 1.4;
      canvas.drawLine(
        glyphCenter + const Offset(-16, -10),
        glyphCenter + const Offset(16, 10),
        x,
      );
      canvas.drawLine(
        glyphCenter + const Offset(-16, 10),
        glyphCenter + const Offset(16, -10),
        x,
      );
    } else if (info.name == 'normal') {
      canvas.drawCircle(
        glyphCenter,
        3,
        Paint()..color = info.color,
      );
    } else {
      canvas.drawCircle(
        glyphCenter,
        3,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2
          ..color = info.color,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _SmodeComparisonPainter old) =>
      old.selectedIndex != selectedIndex;
}

class _SmodeModeDetailPanel extends StatelessWidget {
  const _SmodeModeDetailPanel({required this.info});

  final _SmodeModeInfo info;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalDeep,
        borderRadius: BorderRadius.circular(8),
        border: Border(
          left: BorderSide(color: info.color, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _SmodeDot(color: info.color),
              const SizedBox(width: 8),
              Text(
                'SnapshotMode.${info.name}',
                style: TextStyle(
                  color: info.color,
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.8,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            info.detail,
            style: const TextStyle(
              color: _kSmodeLens,
              fontSize: 12,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Diagnostic card — quoted enum values with expansion
// ===========================================================================

class _SmodeDiagnosticCard extends StatefulWidget {
  @override
  State<_SmodeDiagnosticCard> createState() => _SmodeDiagnosticCardState();
}

class _SmodeDiagnosticCardState extends State<_SmodeDiagnosticCard> {
  final Set<int> _expanded = <int>{0};

  static const List<_SmodeQuote> _quotes = <_SmodeQuote>[
    _SmodeQuote(
      identifier: 'SnapshotMode.permissive',
      quote:
          '// The child is snapshotted, but only if the snapshot can be\n'
          '// taken without any problems. If the snapshot cannot be taken,\n'
          '// the child is rendered as normal without raising any errors.',
      notes:
          'This is the documented safe default. Use it when you do not '
          'fully control the subtree and want the widget to keep working '
          'even if someone nests a BackdropFilter inside it.',
      color: _kSmodeSafe,
    ),
    _SmodeQuote(
      identifier: 'SnapshotMode.normal',
      quote:
          '// The child is snapshotted, but an error is raised if the\n'
          '// child contains certain unsupported components (in debug).',
      notes:
          'Equivalent to permissive in release but surfaces the problem '
          'loudly during development so regressions are caught early.',
      color: _kSmodeWarn,
    ),
    _SmodeQuote(
      identifier: 'SnapshotMode.forced',
      quote:
          '// The child is snapshotted regardless of whether the\n'
          '// snapshot can be taken correctly. This may result in\n'
          '// visual corruption (garbage pixels) in the captured image.',
      notes:
          'Very rarely the right choice. Consider it a "do it anyway" '
          'override — typically only used in tightly controlled custom '
          'renderers where you know the subtree is safe.',
      color: _kSmodeDanger,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kSmodeCharcoalDeep),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.description_outlined, color: _kSmodeAmber),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Enum values — quoted from SnapshotMode',
                  style: TextStyle(
                    color: _kSmodeAmberGlow,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (int i = 0; i < _quotes.length; i++)
            _SmodeQuotePanel(
              quote: _quotes[i],
              expanded: _expanded.contains(i),
              onToggle: () {
                setState(() {
                  if (!_expanded.add(i)) {
                    _expanded.remove(i);
                  }
                });
              },
            ),
        ],
      ),
    );
  }
}

class _SmodeQuote {
  const _SmodeQuote({
    required this.identifier,
    required this.quote,
    required this.notes,
    required this.color,
  });
  final String identifier;
  final String quote;
  final String notes;
  final Color color;
}

class _SmodeQuotePanel extends StatelessWidget {
  const _SmodeQuotePanel({
    required this.quote,
    required this.expanded,
    required this.onToggle,
  });

  final _SmodeQuote quote;
  final bool expanded;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalDeep,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: quote.color.withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          InkWell(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8),
            ),
            onTap: onToggle,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
              child: Row(
                children: <Widget>[
                  _SmodeDot(color: quote.color),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      quote.identifier,
                      style: TextStyle(
                        color: quote.color,
                        fontSize: 13,
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ),
                  Icon(
                    expanded ? Icons.expand_less : Icons.expand_more,
                    color: quote.color,
                    size: 18,
                  ),
                ],
              ),
            ),
          ),
          if (expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0B0B12),
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(
                        color: quote.color.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Text(
                      quote.quote,
                      style: const TextStyle(
                        color: _kSmodeEmulsion,
                        fontSize: 11.5,
                        height: 1.45,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    quote.notes,
                    style: const TextStyle(
                      color: _kSmodeLens,
                      fontSize: 12,
                      height: 1.45,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Stress test row — slider controlling shader layers
// ===========================================================================

class _SmodeStressTestRow extends StatelessWidget {
  const _SmodeStressTestRow({
    required this.shaderLayers,
    required this.onChanged,
  });

  final double shaderLayers;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final int rounded = shaderLayers.round();
    final bool beyondCapture = rounded > 2;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kSmodeCharcoalDeep),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.tune, color: _kSmodeAmber),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Filter stress test · drag to add shader layers',
                  style: TextStyle(
                    color: _kSmodeAmberGlow,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: _kSmodeAmber,
              inactiveTrackColor: _kSmodeCharcoalDeep,
              thumbColor: _kSmodeAmberGlow,
              overlayColor: _kSmodeAmber.withValues(alpha: 0.2),
              valueIndicatorColor: _kSmodeAmberDeep,
              trackHeight: 4,
            ),
            child: Slider(
              min: 0,
              max: 5,
              divisions: 5,
              value: shaderLayers,
              label: '$rounded× layers',
              onChanged: onChanged,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: <Widget>[
              _SmodeStressOutcome(
                title: 'permissive',
                outcome: beyondCapture
                    ? 'falls back to live'
                    : 'snapshot',
                color: _kSmodeSafe,
              ),
              const SizedBox(width: 8),
              _SmodeStressOutcome(
                title: 'normal',
                outcome: beyondCapture
                    ? 'asserts in debug'
                    : 'snapshot',
                color: _kSmodeWarn,
              ),
              const SizedBox(width: 8),
              _SmodeStressOutcome(
                title: 'forced',
                outcome: beyondCapture
                    ? 'garbage snapshot'
                    : 'snapshot',
                color: _kSmodeDanger,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Threshold at ≥3 layers represents a subtree that the raster '
            'cache would refuse (for example because of a BackdropFilter). '
            'Watch how each mode responds differently once we cross it.',
            style: TextStyle(
              color: _kSmodeLensDim.withValues(alpha: 0.95),
              fontSize: 11.5,
              height: 1.4,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}

class _SmodeStressOutcome extends StatelessWidget {
  const _SmodeStressOutcome({
    required this.title,
    required this.outcome,
    required this.color,
  });

  final String title;
  final String outcome;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _kSmodeCharcoalDeep,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: color.withValues(alpha: 0.5)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 11.5,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              outcome,
              style: const TextStyle(
                color: _kSmodeLens,
                fontSize: 11,
                height: 1.35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ===========================================================================
// Frame strip — 9 frames showing live vs snapshot
// ===========================================================================

class _SmodeFrameStrip extends StatelessWidget {
  const _SmodeFrameStrip({
    required this.selectedIndex,
    required this.onTap,
  });

  final int selectedIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    const int totalFrames = 9;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _kSmodeCharcoalDeep),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.movie_filter_outlined, color: _kSmodeAmber),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Live vs snapshot · frame by frame',
                  style: TextStyle(
                    color: _kSmodeAmberGlow,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AspectRatio(
            aspectRatio: 4.2,
            child: CustomPaint(
              painter: _SmodeFramePainter(
                selectedIndex: selectedIndex,
                totalFrames: totalFrames,
              ),
              child: LayoutBuilder(
                builder: (BuildContext _, BoxConstraints c) {
                  return Row(
                    children: <Widget>[
                      for (int i = 0; i < totalFrames; i++)
                        Expanded(
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () => onTap(i),
                            child: const SizedBox.expand(),
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          _SmodeFrameCaption(index: selectedIndex),
        ],
      ),
    );
  }
}

class _SmodeFramePainter extends CustomPainter {
  _SmodeFramePainter({
    required this.selectedIndex,
    required this.totalFrames,
  });

  final int selectedIndex;
  final int totalFrames;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint bg = Paint()..color = _kSmodeCharcoalDeep;
    canvas.drawRect(Offset.zero & size, bg);

    // Top/bottom perforations.
    final Paint perf = Paint()..color = const Color(0xFF080810);
    const double perfW = 6.0;
    const double gap = 8.0;
    for (double x = 4; x < size.width; x += perfW + gap) {
      canvas.drawRect(Rect.fromLTWH(x, 2, perfW, 4), perf);
      canvas.drawRect(Rect.fromLTWH(x, size.height - 6, perfW, 4), perf);
    }

    final double frameW = size.width / totalFrames;
    for (int i = 0; i < totalFrames; i++) {
      _paintFrame(canvas, size, i, frameW);
    }
  }

  void _paintFrame(Canvas canvas, Size size, int i, double frameW) {
    final Rect frame = Rect.fromLTWH(
      frameW * i + 4,
      10,
      frameW - 8,
      size.height - 20,
    );
    final bool isLive = i < 3;
    final bool isSnapshot = i >= 3 && i < 6;
    final bool isGarbage = i >= 6;
    final bool selected = i == selectedIndex;

    final Color tint = isGarbage
        ? _kSmodeDanger
        : isSnapshot
            ? _kSmodeAmber
            : _kSmodeLens;

    final Paint bg = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          tint.withValues(alpha: selected ? 0.45 : 0.2),
          _kSmodeCharcoalDeep,
        ],
      ).createShader(frame);
    canvas.drawRect(frame, bg);

    // Subject — a stylised aperture that "ticks" across frames.
    final Offset center = frame.center;
    final double r = math.min(frame.width, frame.height) * 0.28;
    if (isLive) {
      // Live: aperture rotates and pulses smoothly, brightness varies.
      final double phase = i / 3.0;
      _paintAperture(
        canvas,
        center,
        r,
        rotation: phase * math.pi / 2,
        brightness: 0.6 + 0.4 * phase,
        tint: tint,
      );
    } else if (isSnapshot) {
      // Snapshot: identical frozen frame.
      _paintAperture(
        canvas,
        center,
        r,
        rotation: math.pi / 4,
        brightness: 0.85,
        tint: tint,
      );
    } else {
      // Garbage: random offsets + color tearing.
      _paintGarbageAperture(canvas, center, r, i);
    }

    final Paint border = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = selected ? 1.8 : 0.8
      ..color = tint.withValues(alpha: selected ? 1.0 : 0.55);
    canvas.drawRect(frame, border);

    // Frame number.
    final TextPainter num = TextPainter(
      text: TextSpan(
        text: '${i + 1}',
        style: TextStyle(
          color: tint.withValues(alpha: 0.9),
          fontSize: 9,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.8,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    num.paint(
      canvas,
      Offset(frame.left + 4, frame.top + 2),
    );

    // Label row at bottom.
    final String label = isGarbage
        ? 'GARBAGE'
        : isSnapshot
            ? 'SNAPSHOT'
            : 'LIVE';
    final TextPainter lp = TextPainter(
      text: TextSpan(
        text: label,
        style: TextStyle(
          color: tint,
          fontSize: 8,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: frame.width - 6);
    lp.paint(
      canvas,
      Offset(
        frame.center.dx - lp.width / 2,
        frame.bottom - lp.height - 3,
      ),
    );
  }

  void _paintAperture(
    Canvas canvas,
    Offset c,
    double r, {
    required double rotation,
    required double brightness,
    required Color tint,
  }) {
    canvas.drawCircle(
      c,
      r,
      Paint()..color = _kSmodeCharcoalDeep,
    );
    canvas.drawCircle(
      c,
      r,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0
        ..color = tint.withValues(alpha: brightness),
    );
    final Paint blade = Paint()
      ..color = tint.withValues(alpha: 0.35 + 0.4 * brightness);
    for (int i = 0; i < 5; i++) {
      final double a = rotation + i * (math.pi * 2 / 5);
      final Path p = Path()
        ..moveTo(c.dx, c.dy)
        ..lineTo(
          c.dx + math.cos(a) * r * 0.9,
          c.dy + math.sin(a) * r * 0.9,
        )
        ..lineTo(
          c.dx + math.cos(a + 0.6) * r * 0.45,
          c.dy + math.sin(a + 0.6) * r * 0.45,
        )
        ..close();
      canvas.drawPath(p, blade);
    }
    canvas.drawCircle(
      c,
      r * 0.18,
      Paint()..color = tint.withValues(alpha: brightness),
    );
  }

  void _paintGarbageAperture(Canvas canvas, Offset c, double r, int seed) {
    final math.Random rng = math.Random(seed * 97 + 3);
    for (int k = 0; k < 18; k++) {
      final double x = c.dx + (rng.nextDouble() - 0.5) * r * 2.2;
      final double y = c.dy + (rng.nextDouble() - 0.5) * r * 2.2;
      final Paint p = Paint()
        ..color = Color.fromARGB(
          180,
          rng.nextInt(256),
          rng.nextInt(256),
          rng.nextInt(256),
        );
      canvas.drawRect(
        Rect.fromCenter(
          center: Offset(x, y),
          width: 5 + rng.nextDouble() * 7,
          height: 2.5,
        ),
        p,
      );
    }
    canvas.drawCircle(
      c,
      r * 0.6,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.4
        ..color = _kSmodeDanger.withValues(alpha: 0.8),
    );
  }

  @override
  bool shouldRepaint(covariant _SmodeFramePainter old) =>
      old.selectedIndex != selectedIndex;
}

class _SmodeFrameCaption extends StatelessWidget {
  const _SmodeFrameCaption({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final String caption;
    final Color color;
    if (index < 3) {
      color = _kSmodeLens;
      caption = 'Frame ${index + 1} · LIVE — the widget repaints every tick. '
          'If the subtree is complex, each frame pays the full render cost.';
    } else if (index < 6) {
      color = _kSmodeAmber;
      caption = 'Frame ${index + 1} · SNAPSHOT — the widget paints a cached '
          'raster. The image is identical across frames until invalidation.';
    } else {
      color = _kSmodeDanger;
      caption = 'Frame ${index + 1} · GARBAGE — forced snapshot of an '
          'unsupported subtree. Pixels are unreliable and may flicker.';
    }
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalDeep,
        borderRadius: BorderRadius.circular(8),
        border: Border(left: BorderSide(color: color, width: 3)),
      ),
      child: Text(
        caption,
        style: const TextStyle(
          color: _kSmodeLens,
          fontSize: 12,
          height: 1.45,
        ),
      ),
    );
  }
}

// ===========================================================================
// Pitfall card — why forced is dangerous and permissive is usually right
// ===========================================================================

class _SmodePitfallCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: _kSmodeDanger.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: const <Widget>[
              Icon(Icons.report_problem_outlined, color: _kSmodeDanger),
              SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Pitfalls · why forced is dangerous',
                  style: TextStyle(
                    color: _kSmodeDanger,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SmodePitfallBullet(
            color: _kSmodeDanger,
            title: 'Forced can render garbage',
            detail: 'If the subtree contains a BackdropFilter, platform '
                'view, a shader that depends on scene content, or any '
                'effect the raster cache cannot reproduce, the resulting '
                'image can be full of stale or uninitialised pixels.',
          ),
          _SmodePitfallBullet(
            color: _kSmodeDanger,
            title: 'Forced hides the real problem',
            detail: 'Because forced never falls back to live painting, the '
                'visual regression silently appears instead of giving you '
                'the assertion that normal would.',
          ),
          _SmodePitfallBullet(
            color: _kSmodeWarn,
            title: 'Normal is great in debug',
            detail: 'Use it during development to catch accidentally '
                'captured backdrop filters. The assertion tells you exactly '
                'where the problem is.',
          ),
          _SmodePitfallBullet(
            color: _kSmodeSafe,
            title: 'Permissive is the usual answer',
            detail: 'Lets the widget opportunistically snapshot whenever '
                'it can and keeps behaving correctly when it cannot. '
                'Prefer this unless you have a specific reason.',
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: _kSmodeCharcoalDeep,
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: _kSmodeAmber.withValues(alpha: 0.4),
              ),
            ),
            child: const Text(
              'Rule of thumb: default to SnapshotMode.permissive. Reach '
              'for SnapshotMode.normal while developing to catch bad '
              'subtrees. Reserve SnapshotMode.forced for tightly '
              'controlled situations where you have measured that the '
              'captured image is correct.',
              style: TextStyle(
                color: _kSmodeEmulsion,
                fontSize: 12,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SmodePitfallBullet extends StatelessWidget {
  const _SmodePitfallBullet({
    required this.color,
    required this.title,
    required this.detail,
  });

  final Color color;
  final String title;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: _SmodeDot(color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: color,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  detail,
                  style: const TextStyle(
                    color: _kSmodeLens,
                    fontSize: 12,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ===========================================================================
// Footer — small signoff
// ===========================================================================

class _SmodeFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
      decoration: BoxDecoration(
        color: _kSmodeCharcoalDeep,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: <Widget>[
          SizedBox(
            width: 26,
            height: 26,
            child: CustomPaint(
              painter: _SmodeSafelightPainter(progress: 0.6),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Darkroom Gallery · an exploration of SnapshotMode — '
              'permissive, normal, forced.',
              style: TextStyle(
                color: _kSmodeLensDim.withValues(alpha: 0.9),
                fontSize: 11.5,
                height: 1.4,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          Text(
            '3 values',
            style: TextStyle(
              color: _kSmodeAmber.withValues(alpha: 0.9),
              fontSize: 11,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
