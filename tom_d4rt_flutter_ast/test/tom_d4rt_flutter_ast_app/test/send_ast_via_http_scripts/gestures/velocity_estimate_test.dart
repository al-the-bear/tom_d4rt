// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:math' as math;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

// =============================================================================
// VelocityEstimate — Deep Visual Demo
// -----------------------------------------------------------------------------
// VelocityEstimate is the value class produced by VelocityTracker.getVelocity()
// (and friends) describing an estimated pointer velocity in flutter/gestures.
//
// Fields:
//   • pixelsPerSecond : Offset    — estimated velocity vector (logical px/s)
//   • confidence      : double    — 0.0..1.0 estimate quality
//   • duration        : Duration  — time window covered by the samples
//   • offset          : Offset    — total displacement during that window
//
// This demo file is purely declarative: a single `dynamic build(BuildContext)`
// renders a tall scrolling MaterialApp with ten+ visually distinct sections.
// All visual richness is hand-authored (no controllers, no async, no future,
// no listeners, no runApp). CustomPaint is used to draw arrow plots and
// confidence halos. Six+ gradients and six+ box shadows decorate the cards.
// =============================================================================

// -----------------------------------------------------------------------------
// PALETTE — central place to keep colour constants. Used throughout.
// -----------------------------------------------------------------------------
const Color _bg0 = Color(0xFF0E1320);
const Color _bg1 = Color(0xFF161D32);
const Color _bg2 = Color(0xFF1F2742);
const Color _surface = Color(0xFF22294A);
const Color _surfaceAlt = Color(0xFF2C3458);
const Color _ink = Color(0xFFEAF0FF);
const Color _inkSoft = Color(0xFFB7C0DB);
const Color _inkMute = Color(0xFF8C95B6);
const Color _accentA = Color(0xFF6FE3FF); // cyan
const Color _accentB = Color(0xFFB388FF); // violet
const Color _accentC = Color(0xFF82FFB3); // mint
const Color _accentD = Color(0xFFFFD082); // amber
const Color _accentE = Color(0xFFFF7AA2); // pink
const Color _danger = Color(0xFFFF5C6E);
const Color _warn = Color(0xFFFFB454);
const Color _ok = Color(0xFF44E0A1);

// =============================================================================
// ENTRY POINT — exactly one `dynamic build(BuildContext context)` returning a
// MaterialApp. The whole demo lives inside the home Scaffold body.
// =============================================================================
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'VelocityEstimate Deep Demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _bg0,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _ink, fontSize: 14, height: 1.45),
        bodySmall: TextStyle(color: _inkSoft, fontSize: 12, height: 1.4),
        titleLarge: TextStyle(color: _ink, fontWeight: FontWeight.w700),
        titleMedium: TextStyle(color: _ink, fontWeight: FontWeight.w600),
        labelLarge: TextStyle(color: _ink, fontWeight: FontWeight.w600),
      ),
    ),
    home: Scaffold(
      backgroundColor: _bg0,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _HeroSection(),
              SizedBox(height: 28),
              _AnatomySection(),
              SizedBox(height: 28),
              _GallerySection(),
              SizedBox(height: 28),
              _ConfidenceSection(),
              SizedBox(height: 28),
              _VelocityVsEstimateSection(),
              SizedBox(height: 28),
              _WhenItMattersSection(),
              SizedBox(height: 28),
              _ConstructionSection(),
              SizedBox(height: 28),
              _LimitationsSection(),
              SizedBox(height: 28),
              _UnitsSection(),
              SizedBox(height: 28),
              _NotesSection(),
              SizedBox(height: 16),
              _Footer(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SAMPLE DATA — hand-crafted VelocityEstimate-shaped records. These are not
// constructed via the real constructor (we simulate the four fields locally so
// the demo stays declarative), but each entry mirrors what flutter/gestures
// would emit for the described user action.
// =============================================================================
class _Sample {
  const _Sample({
    required this.label,
    required this.subtitle,
    required this.pixelsPerSecond,
    required this.confidence,
    required this.duration,
    required this.offset,
    required this.tint,
  });
  final String label;
  final String subtitle;
  final Offset pixelsPerSecond;
  final double confidence;
  final Duration duration;
  final Offset offset;
  final Color tint;
}

// A small registry of samples reused by multiple sections.
const List<_Sample> _kSamples = <_Sample>[
  _Sample(
    label: 'Slow drag',
    subtitle: 'User pans content, no fling',
    pixelsPerSecond: Offset(180, 0),
    confidence: 0.95,
    duration: Duration(milliseconds: 220),
    offset: Offset(40, 1),
    tint: _accentC,
  ),
  _Sample(
    label: 'Fast fling left',
    subtitle: 'Page-snap dismiss to the left',
    pixelsPerSecond: Offset(-2400, 60),
    confidence: 0.88,
    duration: Duration(milliseconds: 95),
    offset: Offset(-220, 6),
    tint: _accentA,
  ),
  _Sample(
    label: 'Diagonal swipe',
    subtitle: 'Gesture across both axes',
    pixelsPerSecond: Offset(1500, -1100),
    confidence: 0.82,
    duration: Duration(milliseconds: 140),
    offset: Offset(190, -150),
    tint: _accentB,
  ),
  _Sample(
    label: 'Scroll fling',
    subtitle: 'Long vertical list flick',
    pixelsPerSecond: Offset(0, -3400),
    confidence: 0.93,
    duration: Duration(milliseconds: 110),
    offset: Offset(2, -360),
    tint: _accentD,
  ),
  _Sample(
    label: 'Pull to refresh',
    subtitle: 'Slow downward pull',
    pixelsPerSecond: Offset(20, 720),
    confidence: 0.78,
    duration: Duration(milliseconds: 260),
    offset: Offset(8, 180),
    tint: _ok,
  ),
  _Sample(
    label: 'Jittery flick',
    subtitle: 'Noisy contact, low confidence',
    pixelsPerSecond: Offset(900, -260),
    confidence: 0.34,
    duration: Duration(milliseconds: 70),
    offset: Offset(60, -18),
    tint: _accentE,
  ),
  _Sample(
    label: 'Stationary press',
    subtitle: 'Long-press release with no motion',
    pixelsPerSecond: Offset(0, 0),
    confidence: 0.20,
    duration: Duration(milliseconds: 480),
    offset: Offset(0, 0),
    tint: _warn,
  ),
];

// =============================================================================
// HERO — the headline section. A vector arrow with confidence halo and a
// duration label, plus the section copy beside it.
// =============================================================================
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    const _Sample hero = _Sample(
      label: 'Hero estimate',
      subtitle: 'Fast diagonal fling',
      pixelsPerSecond: Offset(2200, -1450),
      confidence: 0.86,
      duration: Duration(milliseconds: 120),
      offset: Offset(228, -160),
      tint: _accentA,
    );
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_bg2, _bg1, _surface],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _accentA.withValues(alpha: 0.18),
            blurRadius: 32,
            spreadRadius: -4,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 28,
            offset: const Offset(0, 18),
          ),
        ],
        border: Border.all(color: _accentA.withValues(alpha: 0.25), width: 1),
      ),
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints c) {
          final bool wide = c.maxWidth > 720;
          final Widget canvas = SizedBox(
            height: 240,
            child: CustomPaint(
              painter: _HeroArrowPainter(sample: hero),
            ),
          );
          final Widget copy = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const _Pill(text: 'flutter/gestures', tone: _accentB),
              const SizedBox(height: 14),
              const Text(
                'VelocityEstimate',
                style: TextStyle(
                  color: _ink,
                  fontSize: 36,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'A snapshot of the currently estimated pointer velocity, with '
                'a confidence score and the time window it was computed over. '
                'Intermediate consumers (page snappers, pull-to-refresh, '
                'dismissibles) read it before the gesture even ends.',
                style: TextStyle(color: _inkSoft, fontSize: 14, height: 1.55),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const <Widget>[
                  _Pill(text: 'pixelsPerSecond', tone: _accentA),
                  _Pill(text: 'confidence', tone: _accentC),
                  _Pill(text: 'duration', tone: _accentD),
                  _Pill(text: 'offset', tone: _accentE),
                ],
              ),
            ],
          );
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(flex: 5, child: copy),
                const SizedBox(width: 24),
                Expanded(flex: 4, child: canvas),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[copy, const SizedBox(height: 20), canvas],
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// _HeroArrowPainter — draws the headline arrow with halo, faint grid, axis
// labels, and a duration ribbon. All state comes from the constructor.
// -----------------------------------------------------------------------------
class _HeroArrowPainter extends CustomPainter {
  const _HeroArrowPainter({required this.sample});

  final _Sample sample;

  @override
  void paint(Canvas canvas, Size size) {
    final Rect frame = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[Color(0xFF0F1730), Color(0xFF1A2340)],
      ).createShader(frame);
    canvas.drawRRect(
      RRect.fromRectAndRadius(frame, const Radius.circular(14)),
      bg,
    );

    // grid
    final Paint grid = Paint()
      ..color = _ink.withValues(alpha: 0.06)
      ..strokeWidth = 1;
    for (int i = 1; i < 10; i++) {
      final double x = size.width * i / 10;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (int i = 1; i < 6; i++) {
      final double y = size.height * i / 6;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    // origin in the centre
    final Offset origin = Offset(size.width * 0.5, size.height * 0.55);

    // scale velocity vector to fit the frame
    final double maxR = math.min(size.width, size.height) * 0.42;
    final double mag = sample.pixelsPerSecond.distance;
    final double scale = mag == 0 ? 0 : maxR / mag;
    final Offset tip = origin + sample.pixelsPerSecond * scale;

    // confidence halo around the tip
    final double haloR = 28 + 36 * sample.confidence;
    final Paint halo = Paint()
      ..shader = RadialGradient(
        colors: <Color>[
          sample.tint.withValues(alpha: 0.55 * sample.confidence + 0.05),
          sample.tint.withValues(alpha: 0.0),
        ],
      ).createShader(Rect.fromCircle(center: tip, radius: haloR));
    canvas.drawCircle(tip, haloR, halo);

    // arrow shaft
    final Paint shaft = Paint()
      ..color = sample.tint
      ..strokeWidth = 4
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(origin, tip, shaft);

    // arrow head
    _drawArrowHead(canvas, origin, tip, sample.tint, 14);

    // origin dot
    final Paint dot = Paint()..color = _ink;
    canvas.drawCircle(origin, 4, dot);

    // duration ribbon
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text:
            '${sample.duration.inMilliseconds} ms • '
            '${sample.pixelsPerSecond.distance.toStringAsFixed(0)} px/s',
        style: const TextStyle(color: _ink, fontSize: 12, fontWeight: FontWeight.w600),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    final Rect ribbon = Rect.fromLTWH(
      12,
      12,
      tp.width + 16,
      tp.height + 8,
    );
    final Paint ribbonBg = Paint()
      ..color = _surfaceAlt.withValues(alpha: 0.85);
    canvas.drawRRect(
      RRect.fromRectAndRadius(ribbon, const Radius.circular(8)),
      ribbonBg,
    );
    tp.paint(canvas, ribbon.topLeft + const Offset(8, 4));

    // confidence bar bottom
    final Rect barOuter = Rect.fromLTWH(
      12,
      size.height - 22,
      size.width - 24,
      10,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(barOuter, const Radius.circular(5)),
      Paint()..color = _ink.withValues(alpha: 0.08),
    );
    final Rect barFill = Rect.fromLTWH(
      barOuter.left,
      barOuter.top,
      barOuter.width * sample.confidence,
      barOuter.height,
    );
    final Paint barPaint = Paint()
      ..shader = LinearGradient(
        colors: <Color>[sample.tint.withValues(alpha: 0.6), sample.tint],
      ).createShader(barFill);
    canvas.drawRRect(
      RRect.fromRectAndRadius(barFill, const Radius.circular(5)),
      barPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _HeroArrowPainter oldDelegate) =>
      oldDelegate.sample != sample;
}

void _drawArrowHead(Canvas canvas, Offset from, Offset to, Color color, double headSize) {
  final double dx = to.dx - from.dx;
  final double dy = to.dy - from.dy;
  final double angle = math.atan2(dy, dx);
  final Path p = Path();
  p.moveTo(to.dx, to.dy);
  p.lineTo(
    to.dx - headSize * math.cos(angle - math.pi / 7),
    to.dy - headSize * math.sin(angle - math.pi / 7),
  );
  p.lineTo(
    to.dx - headSize * 0.6 * math.cos(angle),
    to.dy - headSize * 0.6 * math.sin(angle),
  );
  p.lineTo(
    to.dx - headSize * math.cos(angle + math.pi / 7),
    to.dy - headSize * math.sin(angle + math.pi / 7),
  );
  p.close();
  canvas.drawPath(p, Paint()..color = color);
}

// =============================================================================
// ANATOMY — labelled boxes for each of the four fields. Includes units and
// short explanatory copy.
// =============================================================================
class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Anatomy',
      title: 'The four fields, up close',
      subtitle:
          'Every VelocityEstimate carries the same payload. Each value has a '
          'precise unit and lifecycle — knowing them prevents the classic '
          '"why is my fling 100x off" bug.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints c) {
          final int cols = c.maxWidth > 880 ? 4 : (c.maxWidth > 520 ? 2 : 1);
          return _Grid(
            cols: cols,
            spacing: 14,
            children: const <Widget>[
              _AnatomyTile(
                tone: _accentA,
                glyph: '→',
                title: 'pixelsPerSecond',
                type: 'Offset',
                unit: 'logical px / s',
                copy:
                    'Velocity vector at the end of the sample window. dx is '
                    'horizontal, dy is vertical. May be (0,0) when the pointer '
                    'has stopped moving entirely.',
              ),
              _AnatomyTile(
                tone: _accentC,
                glyph: '◐',
                title: 'confidence',
                type: 'double',
                unit: '0.0 .. 1.0',
                copy:
                    'How well the regression fits the captured samples. Below '
                    '~0.5, treat the estimate as unreliable and prefer fall-back '
                    'behaviour rather than launching a fling.',
              ),
              _AnatomyTile(
                tone: _accentD,
                glyph: '⏱',
                title: 'duration',
                type: 'Duration',
                unit: 'milliseconds',
                copy:
                    'Time span of the samples used to compute the estimate. '
                    'Short windows (<50 ms) often yield twitchy, low-confidence '
                    'velocities — be sceptical of them.',
              ),
              _AnatomyTile(
                tone: _accentE,
                glyph: '↔',
                title: 'offset',
                type: 'Offset',
                unit: 'logical px',
                copy:
                    'Displacement that occurred during the sample window. '
                    'Useful for sanity-checking the estimate (offset/duration ≈ '
                    'pixelsPerSecond when motion was steady).',
              ),
            ],
          );
        },
      ),
    );
  }
}

class _AnatomyTile extends StatelessWidget {
  const _AnatomyTile({
    required this.tone,
    required this.glyph,
    required this.title,
    required this.type,
    required this.unit,
    required this.copy,
  });

  final Color tone;
  final String glyph;
  final String title;
  final String type;
  final String unit;
  final String copy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _surface,
            _surfaceAlt.withValues(alpha: 0.85),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tone.withValues(alpha: 0.45), width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tone.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  glyph,
                  style: TextStyle(
                    color: tone,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      type,
                      style: TextStyle(
                        color: tone,
                        fontFamily: 'monospace',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: _bg0.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              'unit  •  $unit',
              style: const TextStyle(
                color: _inkSoft,
                fontFamily: 'monospace',
                fontSize: 11,
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            copy,
            style: const TextStyle(
              color: _inkSoft,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// GALLERY — concrete VelocityEstimate samples. Each has a CustomPaint arrow
// plot plus a small data table.
// =============================================================================
class _GallerySection extends StatelessWidget {
  const _GallerySection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Gallery',
      title: 'Seven gestures, seven estimates',
      subtitle:
          'Hand-crafted samples covering common interactions. The arrow plot '
          'is scaled per-card so even tiny velocities stay readable.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints c) {
          final int cols = c.maxWidth > 980 ? 3 : (c.maxWidth > 620 ? 2 : 1);
          return _Grid(
            cols: cols,
            spacing: 16,
            children: <Widget>[
              for (final _Sample s in _kSamples) _GalleryCard(sample: s),
            ],
          );
        },
      ),
    );
  }
}

class _GalleryCard extends StatelessWidget {
  const _GalleryCard({required this.sample});
  final _Sample sample;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _surface,
            sample.tint.withValues(alpha: 0.10),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: sample.tint.withValues(alpha: 0.35), width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.32),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 8,
                height: 28,
                decoration: BoxDecoration(
                  color: sample.tint,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      sample.label,
                      style: const TextStyle(
                        color: _ink,
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      sample.subtitle,
                      style: const TextStyle(color: _inkMute, fontSize: 11.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AspectRatio(
            aspectRatio: 1.6,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: CustomPaint(
                painter: _SampleArrowPainter(sample: sample),
              ),
            ),
          ),
          const SizedBox(height: 10),
          _DataRow(
            k: 'pixelsPerSecond',
            v: '(${sample.pixelsPerSecond.dx.toStringAsFixed(0)}, '
                '${sample.pixelsPerSecond.dy.toStringAsFixed(0)})',
            tone: _accentA,
          ),
          _DataRow(
            k: 'confidence',
            v: sample.confidence.toStringAsFixed(2),
            tone: _accentC,
          ),
          _DataRow(
            k: 'duration',
            v: '${sample.duration.inMilliseconds} ms',
            tone: _accentD,
          ),
          _DataRow(
            k: 'offset',
            v: '(${sample.offset.dx.toStringAsFixed(0)}, '
                '${sample.offset.dy.toStringAsFixed(0)})',
            tone: _accentE,
          ),
        ],
      ),
    );
  }
}

class _DataRow extends StatelessWidget {
  const _DataRow({required this.k, required this.v, required this.tone});
  final String k;
  final String v;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: tone,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              k,
              style: const TextStyle(
                color: _inkSoft,
                fontFamily: 'monospace',
                fontSize: 11.5,
              ),
            ),
          ),
          Text(
            v,
            style: const TextStyle(
              color: _ink,
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// _SampleArrowPainter — per-card visualisation. Includes a translucent
// origin-to-offset trail (drawn lightly) plus the velocity arrow on top.
// -----------------------------------------------------------------------------
class _SampleArrowPainter extends CustomPainter {
  const _SampleArrowPainter({required this.sample});
  final _Sample sample;

  @override
  void paint(Canvas canvas, Size size) {
    // background gradient fill
    final Rect r = Offset.zero & size;
    final Paint bg = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          _bg1,
          _bg2.withValues(alpha: 0.85),
        ],
      ).createShader(r);
    canvas.drawRect(r, bg);

    // crosshair
    final Paint cross = Paint()
      ..color = _ink.withValues(alpha: 0.08)
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(0, size.height * 0.55),
      Offset(size.width, size.height * 0.55),
      cross,
    );
    canvas.drawLine(
      Offset(size.width * 0.5, 0),
      Offset(size.width * 0.5, size.height),
      cross,
    );

    final Offset origin = Offset(size.width * 0.5, size.height * 0.55);

    final double maxR = math.min(size.width, size.height) * 0.42;
    final double mag = sample.pixelsPerSecond.distance;
    final double scale = mag == 0 ? 0 : maxR / mag;
    final Offset tip = origin + sample.pixelsPerSecond * scale;

    // offset trail (sample.offset rendered as a faint dashed line)
    final double offMag = sample.offset.distance;
    if (offMag > 0) {
      final double offScale = maxR * 0.65 / offMag;
      final Offset trailEnd = origin + sample.offset * offScale;
      final Paint trail = Paint()
        ..color = sample.tint.withValues(alpha: 0.35)
        ..strokeWidth = 2
        ..strokeCap = StrokeCap.round;
      _drawDashed(canvas, origin, trailEnd, trail, 4, 4);
      canvas.drawCircle(
        trailEnd,
        3,
        Paint()..color = sample.tint.withValues(alpha: 0.5),
      );
    }

    // confidence halo
    if (mag > 0) {
      final double haloR = 14 + 28 * sample.confidence;
      final Paint halo = Paint()
        ..shader = RadialGradient(
          colors: <Color>[
            sample.tint.withValues(alpha: 0.5 * sample.confidence + 0.05),
            sample.tint.withValues(alpha: 0.0),
          ],
        ).createShader(Rect.fromCircle(center: tip, radius: haloR));
      canvas.drawCircle(tip, haloR, halo);
    }

    // arrow shaft
    if (mag > 0) {
      final Paint shaft = Paint()
        ..color = sample.tint
        ..strokeWidth = 3
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(origin, tip, shaft);
      _drawArrowHead(canvas, origin, tip, sample.tint, 10);
    } else {
      // stationary glyph
      canvas.drawCircle(
        origin,
        12,
        Paint()
          ..color = sample.tint.withValues(alpha: 0.3)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2,
      );
    }

    // origin dot
    canvas.drawCircle(origin, 3, Paint()..color = _ink);
  }

  @override
  bool shouldRepaint(covariant _SampleArrowPainter oldDelegate) =>
      oldDelegate.sample != sample;
}

void _drawDashed(
  Canvas canvas,
  Offset from,
  Offset to,
  Paint paint,
  double dash,
  double gap,
) {
  final double dx = to.dx - from.dx;
  final double dy = to.dy - from.dy;
  final double total = math.sqrt(dx * dx + dy * dy);
  if (total == 0) return;
  final double ux = dx / total;
  final double uy = dy / total;
  double drawn = 0;
  bool draw = true;
  Offset cur = from;
  while (drawn < total) {
    final double step = math.min(draw ? dash : gap, total - drawn);
    final Offset next = Offset(cur.dx + ux * step, cur.dy + uy * step);
    if (draw) canvas.drawLine(cur, next, paint);
    cur = next;
    drawn += step;
    draw = !draw;
  }
}

// =============================================================================
// CONFIDENCE — gauges showing five canonical confidence bands and how to
// interpret them.
// =============================================================================
class _ConfidenceSection extends StatelessWidget {
  const _ConfidenceSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Confidence',
      title: 'Reading the certainty score',
      subtitle:
          'Confidence is a regression-fit quality. Use it as a gating signal: '
          'when it is low, pretend the gesture had no velocity at all.',
      child: Column(
        children: <Widget>[
          LayoutBuilder(
            builder: (BuildContext ctx, BoxConstraints c) {
              final int cols = c.maxWidth > 880 ? 5 : (c.maxWidth > 580 ? 3 : 2);
              return _Grid(
                cols: cols,
                spacing: 12,
                children: const <Widget>[
                  _ConfidenceCard(
                    value: 0.10,
                    label: 'Discard',
                    copy: 'Treat as no velocity. Snap back, do not fling.',
                    tone: _danger,
                  ),
                  _ConfidenceCard(
                    value: 0.35,
                    label: 'Suspicious',
                    copy: 'Cap magnitude or reject. Likely noisy contact.',
                    tone: _warn,
                  ),
                  _ConfidenceCard(
                    value: 0.60,
                    label: 'Acceptable',
                    copy: 'Use, but blend with prior estimate when chaining.',
                    tone: _accentD,
                  ),
                  _ConfidenceCard(
                    value: 0.82,
                    label: 'Strong',
                    copy: 'Use directly for fling and snap decisions.',
                    tone: _accentC,
                  ),
                  _ConfidenceCard(
                    value: 0.96,
                    label: 'Pristine',
                    copy: 'Smooth motion, ample samples — full trust.',
                    tone: _ok,
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _surface,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: _accentB.withValues(alpha: 0.35)),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[
                  _surface,
                  _accentB.withValues(alpha: 0.10),
                ],
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: _accentB.withValues(alpha: 0.18),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: const Text(
              'Rule of thumb: if confidence < 0.5, set pixelsPerSecond to '
              'Offset.zero before passing it on. The ScrollPhysics defaults '
              'in Flutter already do this — your custom gesture code should '
              'too.',
              style: TextStyle(color: _inkSoft, fontSize: 13, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

class _ConfidenceCard extends StatelessWidget {
  const _ConfidenceCard({
    required this.value,
    required this.label,
    required this.copy,
    required this.tone,
  });
  final double value;
  final String label;
  final String copy;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tone.withValues(alpha: 0.4)),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            _surface,
            tone.withValues(alpha: 0.08),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tone.withValues(alpha: 0.16),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 90,
            child: CustomPaint(
              painter: _GaugePainter(value: value, tone: tone),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: tone,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            copy,
            style: const TextStyle(
              color: _inkSoft,
              fontSize: 11.5,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  const _GaugePainter({required this.value, required this.tone});
  final double value;
  final Color tone;

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height);
    final double radius = math.min(size.width, size.height * 2) / 2 - 6;
    final Rect arc = Rect.fromCircle(center: center, radius: radius);
    const double start = math.pi;
    const double sweep = math.pi;

    // background arc
    canvas.drawArc(
      arc,
      start,
      sweep,
      false,
      Paint()
        ..color = _ink.withValues(alpha: 0.10)
        ..strokeWidth = 12
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    // foreground arc
    canvas.drawArc(
      arc,
      start,
      sweep * value,
      false,
      Paint()
        ..shader = SweepGradient(
          startAngle: start,
          endAngle: start + sweep,
          colors: <Color>[
            tone.withValues(alpha: 0.4),
            tone,
          ],
        ).createShader(arc)
        ..strokeWidth = 12
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round,
    );

    // value text
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: value.toStringAsFixed(2),
        style: TextStyle(
          color: tone,
          fontSize: 22,
          fontWeight: FontWeight.w800,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2, center.dy - tp.height - 2));
  }

  @override
  bool shouldRepaint(covariant _GaugePainter oldDelegate) =>
      oldDelegate.value != value || oldDelegate.tone != tone;
}

// =============================================================================
// VELOCITY VS ESTIMATE — two-column comparison card.
// =============================================================================
class _VelocityVsEstimateSection extends StatelessWidget {
  const _VelocityVsEstimateSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Compare',
      title: 'Velocity vs VelocityEstimate',
      subtitle:
          'Both come from VelocityTracker. Velocity is the final drag-end '
          'value; VelocityEstimate is the richer, intermediate snapshot.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints c) {
          final bool wide = c.maxWidth > 720;
          final Widget left = _ComparePanel(
            tone: _accentA,
            title: 'Velocity',
            kind: 'final value',
            bullets: const <String>[
              'Returned by getVelocity() at gesture end',
              'Single field: pixelsPerSecond',
              'No confidence — caller must trust it',
              'Used by ScrollPhysics for fling simulations',
            ],
          );
          final Widget right = _ComparePanel(
            tone: _accentB,
            title: 'VelocityEstimate',
            kind: 'partial / live',
            bullets: const <String>[
              'Returned by getVelocityEstimate(), can be null',
              'Four fields including confidence + duration',
              'Available before the user lifts their finger',
              'Lets a recogniser decide threshold-based behaviour live',
            ],
          );
          if (wide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: left),
                const SizedBox(width: 14),
                Expanded(child: right),
              ],
            );
          }
          return Column(
            children: <Widget>[left, const SizedBox(height: 14), right],
          );
        },
      ),
    );
  }
}

class _ComparePanel extends StatelessWidget {
  const _ComparePanel({
    required this.tone,
    required this.title,
    required this.kind,
    required this.bullets,
  });
  final Color tone;
  final String title;
  final String kind;
  final List<String> bullets;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _surface,
            tone.withValues(alpha: 0.12),
          ],
        ),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tone.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tone.withValues(alpha: 0.20),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  kind,
                  style: TextStyle(
                    color: tone,
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: _ink,
              fontSize: 22,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 12),
          for (final String b in bullets)
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 5, right: 8),
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: BoxDecoration(
                        color: tone,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      b,
                      style: const TextStyle(
                        color: _inkSoft,
                        fontSize: 13,
                        height: 1.45,
                      ),
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

// =============================================================================
// WHEN IT MATTERS — scenarios where you want the partial estimate live.
// =============================================================================
class _WhenItMattersSection extends StatelessWidget {
  const _WhenItMattersSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'In practice',
      title: 'When the live estimate matters',
      subtitle:
          'Not every interaction needs a final velocity. These three want it '
          'before the gesture ends so they can commit early.',
      child: LayoutBuilder(
        builder: (BuildContext ctx, BoxConstraints c) {
          final int cols = c.maxWidth > 880 ? 3 : 1;
          return _Grid(
            cols: cols,
            spacing: 14,
            children: <Widget>[
              _ScenarioCard(
                tone: _ok,
                emoji: '↻',
                title: 'Pull to refresh',
                threshold: 'velocity.dy > 600 px/s',
                copy:
                    'Trigger refresh as soon as the user is clearly pulling '
                    'down with intent — no need to wait for finger release. '
                    'Confidence guards against a stationary thumb.',
                illustration: const _PullToRefreshIllustration(),
              ),
              _ScenarioCard(
                tone: _accentE,
                emoji: '✕',
                title: 'Swipe to dismiss',
                threshold: '|velocity.dx| > 1500 px/s',
                copy:
                    'A fast horizontal flick should dismiss even if the offset '
                    'has not crossed 50% of the tile width. The estimate makes '
                    'this decision possible mid-drag.',
                illustration: const _SwipeIllustration(),
              ),
              _ScenarioCard(
                tone: _accentB,
                emoji: '◧',
                title: 'Page snap calculation',
                threshold: 'velocity.dx ≷ 0 chooses page',
                copy:
                    'PageView decides next vs previous page partly from the '
                    'live estimate, weighted by confidence to reject jitter.',
                illustration: const _PageSnapIllustration(),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _ScenarioCard extends StatelessWidget {
  const _ScenarioCard({
    required this.tone,
    required this.emoji,
    required this.title,
    required this.threshold,
    required this.copy,
    required this.illustration,
  });
  final Color tone;
  final String emoji;
  final String title;
  final String threshold;
  final String copy;
  final Widget illustration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tone.withValues(alpha: 0.4)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _surface,
            tone.withValues(alpha: 0.10),
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tone.withValues(alpha: 0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tone.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  emoji,
                  style: TextStyle(
                    fontSize: 20,
                    color: tone,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AspectRatio(aspectRatio: 2.4, child: illustration),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _bg0.withValues(alpha: 0.55),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              threshold,
              style: TextStyle(
                color: tone,
                fontFamily: 'monospace',
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            copy,
            style: const TextStyle(
              color: _inkSoft,
              fontSize: 12.5,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}

// Three small illustrations — drawn as static widgets, no painters needed.
class _PullToRefreshIllustration extends StatelessWidget {
  const _PullToRefreshIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[
            _ok.withValues(alpha: 0.20),
            _ok.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 12,
            child: Container(
              width: 60,
              height: 8,
              decoration: BoxDecoration(
                color: _ok.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          const Icon(Icons.south_rounded, color: _ok, size: 32),
        ],
      ),
    );
  }
}

class _SwipeIllustration extends StatelessWidget {
  const _SwipeIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            _accentE.withValues(alpha: 0.05),
            _accentE.withValues(alpha: 0.30),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 40,
              height: 24,
              decoration: BoxDecoration(
                color: _accentE.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 6),
            const Icon(Icons.east_rounded, color: _accentE, size: 22),
            const SizedBox(width: 6),
            const Icon(Icons.east_rounded, color: _accentE, size: 18),
          ],
        ),
      ),
    );
  }
}

class _PageSnapIllustration extends StatelessWidget {
  const _PageSnapIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            _accentB.withValues(alpha: 0.20),
            _accentB.withValues(alpha: 0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 22,
              height: 36,
              decoration: BoxDecoration(
                color: _accentB.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: _accentB.withValues(alpha: 0.7),
                borderRadius: BorderRadius.circular(4),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: _accentB.withValues(alpha: 0.45),
                    blurRadius: 12,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 22,
              height: 36,
              decoration: BoxDecoration(
                color: _accentB.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// CONSTRUCTION — code-style listings of `const VelocityEstimate(...)` for the
// gallery cases.
// =============================================================================
class _ConstructionSection extends StatelessWidget {
  const _ConstructionSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Construction',
      title: 'How each sample is written in code',
      subtitle:
          'VelocityEstimate has a const constructor with named parameters. '
          'These literals would compile against package:flutter/gestures.dart.',
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: _bg1,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _accentA.withValues(alpha: 0.25)),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              _bg1,
              _accentA.withValues(alpha: 0.06),
            ],
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _accentA.withValues(alpha: 0.10),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            for (final _Sample s in _kSamples) _CodeBlock(sample: s),
          ],
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  const _CodeBlock({required this.sample});
  final _Sample sample;

  @override
  Widget build(BuildContext context) {
    final String code = '// ${sample.label} — ${sample.subtitle}\n'
        'const VelocityEstimate(\n'
        '  pixelsPerSecond: Offset(${sample.pixelsPerSecond.dx.toStringAsFixed(1)}, '
        '${sample.pixelsPerSecond.dy.toStringAsFixed(1)}),\n'
        '  confidence: ${sample.confidence.toStringAsFixed(2)},\n'
        '  duration: Duration(milliseconds: ${sample.duration.inMilliseconds}),\n'
        '  offset: Offset(${sample.offset.dx.toStringAsFixed(1)}, '
        '${sample.offset.dy.toStringAsFixed(1)}),\n'
        ');';
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _bg0.withValues(alpha: 0.65),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: sample.tint.withValues(alpha: 0.35)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 12, top: 2),
            width: 4,
            height: 64,
            decoration: BoxDecoration(
              color: sample.tint,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Expanded(
            child: Text(
              code,
              style: TextStyle(
                color: _ink.withValues(alpha: 0.92),
                fontFamily: 'monospace',
                fontSize: 12,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// LIMITATIONS — warning callouts.
// =============================================================================
class _LimitationsSection extends StatelessWidget {
  const _LimitationsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Limitations',
      title: 'Edge cases to guard against',
      subtitle:
          'VelocityTracker can occasionally produce surprising estimates. '
          'Defensive code keeps your fling animations from going wild.',
      child: Column(
        children: const <Widget>[
          _Callout(
            tone: _danger,
            title: 'confidence may be NaN',
            copy:
                'When the regression cannot be solved (degenerate sample set), '
                'confidence comes back as NaN. Always test with .isFinite '
                'before treating the value as numeric.',
          ),
          SizedBox(height: 10),
          _Callout(
            tone: _warn,
            title: 'duration of zero',
            copy:
                'A burst of co-located samples can produce duration == 0. '
                'Dividing the offset by it for sanity-check explodes — guard.',
          ),
          SizedBox(height: 10),
          _Callout(
            tone: _accentD,
            title: 'Unbounded magnitude',
            copy:
                'Very short windows can yield enormous pixelsPerSecond. The '
                'flutter framework clamps fling velocity in ScrollPhysics; '
                'when you simulate yourself, clamp explicitly.',
          ),
          SizedBox(height: 10),
          _Callout(
            tone: _accentE,
            title: 'Stale across pointer changes',
            copy:
                'Once a different pointer takes over (multi-touch handoff), '
                'the previous tracker is conceptually invalid. Always tie a '
                'tracker to a single pointer ID.',
          ),
          SizedBox(height: 10),
          _Callout(
            tone: _accentB,
            title: 'Null estimate',
            copy:
                'getVelocityEstimate() returns nullable. A few samples are '
                'needed before the regression has anything to say — handle '
                'the null path before reading fields.',
          ),
        ],
      ),
    );
  }
}

class _Callout extends StatelessWidget {
  const _Callout({
    required this.tone,
    required this.title,
    required this.copy,
  });
  final Color tone;
  final String title;
  final String copy;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surface,
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: tone, width: 4),
          top: BorderSide(color: tone.withValues(alpha: 0.25)),
          right: BorderSide(color: tone.withValues(alpha: 0.25)),
          bottom: BorderSide(color: tone.withValues(alpha: 0.25)),
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: <Color>[
            tone.withValues(alpha: 0.15),
            _surface,
          ],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tone.withValues(alpha: 0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 28,
            height: 28,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withValues(alpha: 0.20),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '!',
              style: TextStyle(
                color: tone,
                fontSize: 18,
                fontWeight: FontWeight.w900,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: tone,
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  copy,
                  style: const TextStyle(
                    color: _inkSoft,
                    fontSize: 12.5,
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

// =============================================================================
// UNITS — quick reference card. Logical pixels / second, not physical.
// =============================================================================
class _UnitsSection extends StatelessWidget {
  const _UnitsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Units',
      title: 'Logical pixels per second',
      subtitle:
          'Always logical (devicePixelRatio-independent). On a 3x display, '
          '1500 px/s is 4500 physical px/s — which is also 1500 logical px/s.',
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[_bg2, _surfaceAlt],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _accentC.withValues(alpha: 0.30)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _accentC.withValues(alpha: 0.16),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const _UnitRow(label: 'Slow drag', value: '~  150 px/s'),
            const _UnitRow(label: 'Comfortable scroll', value: '~  900 px/s'),
            const _UnitRow(label: 'Quick flick', value: '~ 2000 px/s'),
            const _UnitRow(label: 'Fast fling', value: '~ 4000 px/s'),
            const _UnitRow(label: 'Hardware maximum', value: '> 8000 px/s (rare)'),
            _UnitRow(
              label: 'kMinFlingVelocity (flutter/gestures)',
              value: '${kMinFlingVelocity.toStringAsFixed(0)} px/s',
            ),
            _UnitRow(
              label: 'kMaxFlingVelocity (flutter/gestures)',
              value: '${kMaxFlingVelocity.toStringAsFixed(0)} px/s',
            ),
          ],
        ),
      ),
    );
  }
}

class _UnitRow extends StatelessWidget {
  const _UnitRow({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: _accentC,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: _inkSoft, fontSize: 13),
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              color: _ink,
              fontFamily: 'monospace',
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// NOTES — closing list of "inputs to gesture decisions in real apps".
// =============================================================================
class _NotesSection extends StatelessWidget {
  const _NotesSection();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      eyebrow: 'Wrap up',
      title: 'Inputs to a gesture decision in real apps',
      subtitle:
          'A real recogniser blends VelocityEstimate with surrounding state. '
          'These are the typical signals you weigh together.',
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              _surface,
              _accentD.withValues(alpha: 0.10),
            ],
          ),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _accentD.withValues(alpha: 0.35)),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: _accentD.withValues(alpha: 0.18),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const <Widget>[
            _NoteLine(idx: '01', text: 'Current pixelsPerSecond magnitude'),
            _NoteLine(idx: '02', text: 'Direction (sign of dx, sign of dy)'),
            _NoteLine(idx: '03', text: 'Confidence — gate or weight by it'),
            _NoteLine(idx: '04', text: 'Sample window duration'),
            _NoteLine(idx: '05', text: 'Total displacement so far'),
            _NoteLine(idx: '06', text: 'Distance to nearest snap target'),
            _NoteLine(idx: '07', text: 'Whether the pointer is still down'),
            _NoteLine(idx: '08', text: 'Cumulative time since gesture start'),
            _NoteLine(idx: '09', text: 'Other recognisers in the arena'),
            _NoteLine(idx: '10', text: 'Platform tunables (kMinFlingVelocity)'),
          ],
        ),
      ),
    );
  }
}

class _NoteLine extends StatelessWidget {
  const _NoteLine({required this.idx, required this.text});
  final String idx;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: <Widget>[
          Container(
            width: 30,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _accentD.withValues(alpha: 0.18),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              idx,
              style: const TextStyle(
                color: _accentD,
                fontFamily: 'monospace',
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: _inkSoft, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// FOOTER
// =============================================================================
class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: _bg1,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: _ink.withValues(alpha: 0.06)),
      ),
      child: const Row(
        children: <Widget>[
          Icon(Icons.swipe_rounded, color: _accentA, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'flutter/gestures • VelocityEstimate value class • '
              'pixelsPerSecond / confidence / duration / offset',
              style: TextStyle(color: _inkMute, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SHARED PRIMITIVES — small reusable widgets.
// =============================================================================
class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: _bg1,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _ink.withValues(alpha: 0.06)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.30),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              _Pill(text: eyebrow, tone: _accentA),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
              color: _ink,
              fontSize: 24,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: const TextStyle(
              color: _inkSoft,
              fontSize: 13,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.tone});
  final String text;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: tone.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: tone.withValues(alpha: 0.45)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: tone,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

// _Grid — simple manual grid that wraps children in fixed-column rows.
class _Grid extends StatelessWidget {
  const _Grid({
    required this.cols,
    required this.spacing,
    required this.children,
  });

  final int cols;
  final double spacing;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < children.length; i += cols) {
      final List<Widget> rowKids = <Widget>[];
      for (int j = 0; j < cols; j++) {
        if (j > 0) rowKids.add(SizedBox(width: spacing));
        if (i + j < children.length) {
          rowKids.add(Expanded(child: children[i + j]));
        } else {
          rowKids.add(const Expanded(child: SizedBox.shrink()));
        }
      }
      if (rows.isNotEmpty) {
        rows.add(SizedBox(height: spacing));
      }
      rows.add(
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: rowKids,
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: rows,
    );
  }
}

// =============================================================================
// END OF FILE
// =============================================================================
