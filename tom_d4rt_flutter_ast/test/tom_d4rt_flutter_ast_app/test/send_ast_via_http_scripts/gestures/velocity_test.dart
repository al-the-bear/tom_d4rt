// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
import 'package:flutter/material.dart';

// =============================================================================
// Velocity — Deep Visual Demo
// -----------------------------------------------------------------------------
// `Velocity` (from package:flutter/gestures.dart, re-exported by material.dart)
// is the immutable value class that describes a 2-D pointer velocity in logical
// pixels per second. It is the cleaned-up sibling of `VelocityEstimate`: the
// VelocityTracker first produces an estimate (with a confidence and the time
// window it covered), and a `Velocity` is the simplified handoff that you see
// at the gesture API surface — most famously on `DragEndDetails.velocity`.
//
// API at a glance:
//   • Velocity({required Offset pixelsPerSecond})
//   • static const Velocity zero        → pixelsPerSecond == Offset.zero
//   • Offset pixelsPerSecond            — the velocity vector
//   • Velocity clampMagnitude(double minValue, double maxValue)
//   • Velocity operator +(Velocity other)
//   • Velocity operator -(Velocity other)
//   • Velocity operator -() (unary negate)
//   • bool operator ==                  — equality is by pixelsPerSecond
//   • int hashCode                      — folds pixelsPerSecond
//   • String toString()                 — 'Velocity(dx, dy)'
//
// This file is a single `dynamic build(BuildContext)` returning a MaterialApp
// containing a tall, scrollable, fully static visual essay about the type.
// There is no setState, no AnimationController, no Future, Stream or Timer.
// CustomPaint draws arrows, axis crosses and clamping rings; all maths is
// done at declaration time with hand-rolled helpers (no dart:math import).
// =============================================================================

// -----------------------------------------------------------------------------
// PALETTE — All colour constants live here.
// -----------------------------------------------------------------------------
const Color _bg0 = Color(0xFF0B0F1F);
const Color _bg1 = Color(0xFF111733);
const Color _bg2 = Color(0xFF1A2148);
const Color _surface = Color(0xFF1F2750);
const Color _surfaceAlt = Color(0xFF28315F);
const Color _surfaceDeep = Color(0xFF161C3D);
const Color _ink = Color(0xFFEDF1FF);
const Color _inkSoft = Color(0xFFB9C2DD);
const Color _inkMute = Color(0xFF858EAE);
const Color _grid = Color(0xFF2D3666);
const Color _gridSoft = Color(0xFF202855);

const Color _vel = Color(0xFF7CE7FF); // primary cyan — Velocity itself
const Color _est = Color(0xFFB698FF); // violet — VelocityEstimate
const Color _zero = Color(0xFF6FA0FF); // royal blue — zero vector
const Color _clamp = Color(0xFFFFC36F); // amber — clamping
const Color _addOp = Color(0xFF8CFFB9); // mint — addition
const Color _subOp = Color(0xFFFF9CC2); // pink — subtraction
const Color _drag = Color(0xFFFFE17C); // light amber — DragEndDetails
const Color _track = Color(0xFFB3F5C6); // green — VelocityTracker

const Color _danger = Color(0xFFFF6878);
const Color _warn = Color(0xFFFFB454);
const Color _ok = Color(0xFF44E0A1);

// -----------------------------------------------------------------------------
// TINY MATH HELPERS — implemented without dart:math because the file's only
// import is package:flutter/material.dart.
// -----------------------------------------------------------------------------
double _absD(double v) => v < 0 ? -v : v;

double _sqrtNewton(double v) {
  if (v <= 0) return 0;
  double x = v;
  for (int i = 0; i < 24; i++) {
    x = 0.5 * (x + v / x);
  }
  return x;
}

double _magnitude(Offset o) => _sqrtNewton(o.dx * o.dx + o.dy * o.dy);

Offset _scale(Offset o, double s) => Offset(o.dx * s, o.dy * s);

Offset _clampMagnitudeOffset(Offset o, double minV, double maxV) {
  final double m = _magnitude(o);
  if (m <= 0) return Offset.zero;
  if (m < minV) return _scale(o, minV / m);
  if (m > maxV) return _scale(o, maxV / m);
  return o;
}

String _fix(double v, [int frac = 1]) {
  final bool neg = v < 0;
  double a = neg ? -v : v;
  final int mult = frac == 0
      ? 1
      : frac == 1
          ? 10
          : frac == 2
              ? 100
              : 1000;
  final int rounded = (a * mult + 0.5).floor();
  final String whole = (rounded ~/ mult).toString();
  if (frac == 0) return neg ? '-$whole' : whole;
  final int fracPart = rounded % mult;
  final String fracStr = fracPart.toString().padLeft(frac, '0');
  return neg ? '-$whole.$fracStr' : '$whole.$fracStr';
}

String _vec(Offset o) => '(${_fix(o.dx)}, ${_fix(o.dy)})';

// =============================================================================
// SAMPLE VELOCITIES
// =============================================================================
class _VSample {
  const _VSample({
    required this.label,
    required this.subtitle,
    required this.pixelsPerSecond,
    required this.tint,
    required this.glyph,
  });
  final String label;
  final String subtitle;
  final Offset pixelsPerSecond;
  final Color tint;
  final String glyph;
}

const List<_VSample> _kSamples = <_VSample>[
  _VSample(
    label: 'Idle pointer',
    subtitle: 'No movement — Velocity.zero',
    pixelsPerSecond: Offset.zero,
    tint: _zero,
    glyph: '·',
  ),
  _VSample(
    label: 'Gentle horizontal pan',
    subtitle: 'Reading-pace drag, mostly +x',
    pixelsPerSecond: Offset(220, 8),
    tint: _ok,
    glyph: '→',
  ),
  _VSample(
    label: 'Vertical scroll',
    subtitle: 'List flick downward',
    pixelsPerSecond: Offset(0, 1450),
    tint: _vel,
    glyph: '↓',
  ),
  _VSample(
    label: 'Quick swipe up',
    subtitle: 'Bottom sheet expand',
    pixelsPerSecond: Offset(20, -1850),
    tint: _addOp,
    glyph: '↑',
  ),
  _VSample(
    label: 'Fling left',
    subtitle: 'Aggressive page-back gesture',
    pixelsPerSecond: Offset(-2600, 70),
    tint: _est,
    glyph: '⇐',
  ),
  _VSample(
    label: 'Diagonal swipe',
    subtitle: 'Stamp-style flick',
    pixelsPerSecond: Offset(1300, -900),
    tint: _clamp,
    glyph: '↗',
  ),
  _VSample(
    label: 'Tiny jitter',
    subtitle: 'Sub-pixel noise on touch up',
    pixelsPerSecond: Offset(-7, 4),
    tint: _inkMute,
    glyph: '~',
  ),
  _VSample(
    label: 'Maxed-out fling',
    subtitle: 'Extreme stylus throw',
    pixelsPerSecond: Offset(4500, -3200),
    tint: _drag,
    glyph: '↟',
  ),
];

// =============================================================================
// ENTRY POINT
// =============================================================================
dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Velocity Deep Demo',
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
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 64),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _HeroSection(),
              SizedBox(height: 30),
              _AnatomySection(),
              SizedBox(height: 30),
              _ZeroSection(),
              SizedBox(height: 30),
              _VectorGallerySection(),
              SizedBox(height: 30),
              _ClampMagnitudeSection(),
              SizedBox(height: 30),
              _ClampRulesSection(),
              SizedBox(height: 30),
              _OperatorSection(),
              SizedBox(height: 30),
              _EqualitySection(),
              SizedBox(height: 30),
              _VelocityVsEstimateSection(),
              SizedBox(height: 30),
              _IntegrationStorySection(),
              SizedBox(height: 30),
              _PitfallsSection(),
              SizedBox(height: 30),
              _CheatsheetSection(),
              SizedBox(height: 16),
              _FooterSection(),
            ],
          ),
        ),
      ),
    ),
  );
}

// =============================================================================
// SHARED CARD CHROME
// =============================================================================
class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.tint,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
    required this.child,
  });
  final Color tint;
  final String eyebrow;
  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_surface, _surfaceDeep],
        ),
        border: Border.all(color: _grid),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.32),
            blurRadius: 22,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: tint.withValues(alpha: 0.08),
            blurRadius: 30,
            offset: Offset.zero,
          ),
        ],
      ),
      // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #35, P1):
      // The card chrome used `Row(crossAxisAlignment: CrossAxisAlignment.stretch,
      // [Container(width:6 strip), Expanded(content)])` inside
      // `SingleChildScrollView > Column(stretch)`. The scroll view passes
      // infinite vertical max, so the stretching Row gave the strip Container
      // infinite tight height — `RenderConstrainedBox.layout()` then threw
      // "BoxConstraints forces an infinite height". Wrapping the Row in
      // `IntrinsicHeight` bounds the Row's height to the content column's
      // intrinsic height; the strip then stretches to that finite height.
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                width: 6,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: <Color>[
                      tint.withValues(alpha: 0.85),
                      tint.withValues(alpha: 0.25),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(22, 22, 22, 22),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      _SectionHeader(
                        tint: tint,
                        eyebrow: eyebrow,
                        title: title,
                        subtitle: subtitle,
                      ),
                      const SizedBox(height: 18),
                      child,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.tint,
    required this.eyebrow,
    required this.title,
    required this.subtitle,
  });
  final Color tint;
  final String eyebrow;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: tint.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: tint.withValues(alpha: 0.55)),
          ),
          child: Text(
            'V',
            style: TextStyle(
              color: tint,
              fontWeight: FontWeight.w800,
              fontSize: 16,
              letterSpacing: 0.4,
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                eyebrow.toUpperCase(),
                style: TextStyle(
                  color: tint,
                  fontSize: 11,
                  letterSpacing: 1.6,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  color: _ink,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: _inkSoft,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BulletList extends StatelessWidget {
  const _BulletList({required this.tint, required this.items});
  final Color tint;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        for (final String text in items)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 6),
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: tint,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    text,
                    style: const TextStyle(color: _inkSoft, fontSize: 13, height: 1.5),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CodeLine extends StatelessWidget {
  const _CodeLine(this.text, {this.indent = 0, this.tint});
  final String text;
  final int indent;
  final Color? tint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 14.0 * indent, top: 1, bottom: 1),
      child: Text(
        text,
        style: TextStyle(
          color: tint ?? _ink,
          fontSize: 12.5,
          fontFamily: 'monospace',
          height: 1.55,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 1 — HERO
// =============================================================================
class _HeroSection extends StatelessWidget {
  const _HeroSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 26, 24, 28),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_bg2, _bg1, _surface],
          stops: <double>[0.0, 0.55, 1.0],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: _vel.withValues(alpha: 0.18),
            blurRadius: 38,
            offset: const Offset(0, 18),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 30,
            offset: const Offset(0, 14),
          ),
        ],
        border: Border.all(color: _grid),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _vel.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _vel.withValues(alpha: 0.55)),
                ),
                child: Text(
                  'package:flutter/gestures.dart',
                  style: TextStyle(
                    color: _vel,
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: _track.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: _track.withValues(alpha: 0.5)),
                ),
                child: Text(
                  '@immutable value type',
                  style: TextStyle(
                    color: _track,
                    fontSize: 11,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ShaderMask(
            shaderCallback: (Rect r) => const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[_vel, _est, _clamp],
            ).createShader(r),
            child: const Text(
              'Velocity',
              style: TextStyle(
                color: Colors.white,
                fontSize: 56,
                fontWeight: FontWeight.w900,
                height: 1.0,
                letterSpacing: -1.5,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'A 2-D pointer velocity, in logical pixels per second.',
            style: TextStyle(color: _ink, fontSize: 18, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          const Text(
            'Velocity is the small immutable value object that flutter/gestures hands you '
            'when a drag ends or a fling completes. It carries a single Offset — '
            'pixelsPerSecond — describing how fast and in which direction the pointer '
            'was travelling at the end of the gesture. It is what fling animations, '
            'page-snaps and dismiss thresholds branch on, and it is how the framework '
            'collapses the richer VelocityEstimate into a compact, comparable handoff.',
            style: TextStyle(color: _inkSoft, fontSize: 14, height: 1.55),
          ),
          const SizedBox(height: 22),
          Row(
            children: const <Widget>[
              Expanded(child: _HeroStat(tint: _vel, label: 'Fields', value: '1', sub: 'pixelsPerSecond')),
              SizedBox(width: 12),
              Expanded(child: _HeroStat(tint: _clamp, label: 'Helpers', value: '1', sub: 'clampMagnitude')),
              SizedBox(width: 12),
              Expanded(child: _HeroStat(tint: _addOp, label: 'Operators', value: '4', sub: '+  -  -()  ==')),
              SizedBox(width: 12),
              Expanded(child: _HeroStat(tint: _zero, label: 'Constants', value: '1', sub: 'Velocity.zero')),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroStat extends StatelessWidget {
  const _HeroStat({required this.tint, required this.label, required this.value, required this.sub});
  final Color tint;
  final String label;
  final String value;
  final String sub;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
      decoration: BoxDecoration(
        color: _surfaceDeep.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tint.withValues(alpha: 0.4)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tint.withValues(alpha: 0.12),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: tint,
              fontSize: 10,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(color: _ink, fontSize: 26, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(sub, style: const TextStyle(color: _inkMute, fontSize: 11)),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 2 — ANATOMY
// =============================================================================
class _AnatomySection extends StatelessWidget {
  const _AnatomySection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      tint: _vel,
      eyebrow: 'Anatomy',
      title: 'One field, one Offset',
      subtitle: 'The entire shape of Velocity, drawn out and labelled.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: _surfaceDeep,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _grid),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _CodeLine('class Velocity {', tint: _vel),
                _CodeLine('  const Velocity({required this.pixelsPerSecond});', indent: 1),
                _CodeLine('  static const Velocity zero =', indent: 1),
                _CodeLine('      Velocity(pixelsPerSecond: Offset.zero);', indent: 2),
                _CodeLine('  final Offset pixelsPerSecond; // logical px / second', indent: 1, tint: _vel),
                _CodeLine('  Velocity clampMagnitude(double minValue, double maxValue);', indent: 1, tint: _clamp),
                _CodeLine('  Velocity operator +(Velocity other);', indent: 1, tint: _addOp),
                _CodeLine('  Velocity operator -(Velocity other);', indent: 1, tint: _subOp),
                _CodeLine('  Velocity operator -(); // unary negate', indent: 1, tint: _subOp),
                _CodeLine('}'),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Expanded(
                flex: 5,
                child: _AnatomyField(
                  tint: _vel,
                  name: 'pixelsPerSecond',
                  type: 'Offset',
                  description:
                      'The velocity vector. dx is horizontal speed (positive = right), '
                      'dy is vertical speed (positive = down, matching screen coordinates). '
                      'Units are logical pixels per second.',
                  example: 'Offset(1450.0, -200.0)',
                ),
              ),
              SizedBox(width: 14),
              Expanded(
                flex: 4,
                child: _AnatomyField(
                  tint: _zero,
                  name: 'Velocity.zero',
                  type: 'static const',
                  description:
                      'The canonical "no motion" velocity. Cheap to compare against and the '
                      'usual sentinel returned when a tracker has not seen enough samples.',
                  example: 'Velocity(pixelsPerSecond: Offset.zero)',
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            height: 220,
            decoration: BoxDecoration(
              color: _surfaceDeep,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _grid),
            ),
            child: CustomPaint(
              painter: _AnatomyPainter(),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'The diagram above shows pixelsPerSecond as a 2-D vector. dx pushes along '
            'the screen X axis; dy pushes along the screen Y axis. Their hypotenuse is '
            'the magnitude that clampMagnitude operates on.',
            style: TextStyle(color: _inkSoft, fontSize: 12.5, height: 1.5),
          ),
        ],
      ),
    );
  }
}

class _AnatomyField extends StatelessWidget {
  const _AnatomyField({
    required this.tint,
    required this.name,
    required this.type,
    required this.description,
    required this.example,
  });
  final Color tint;
  final String name;
  final String type;
  final String description;
  final String example;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surfaceDeep,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tint.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tint.withValues(alpha: 0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                name,
                style: TextStyle(color: tint, fontSize: 14, fontWeight: FontWeight.w800),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  type,
                  style: TextStyle(color: tint, fontSize: 10.5, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(description, style: const TextStyle(color: _inkSoft, fontSize: 12.5, height: 1.45)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _bg0,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: _grid),
            ),
            child: Text(
              example,
              style: TextStyle(
                color: tint.withValues(alpha: 0.95),
                fontSize: 12,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AnatomyPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint grid = Paint()
      ..color = _gridSoft
      ..strokeWidth = 1;
    final Paint axis = Paint()
      ..color = _grid
      ..strokeWidth = 1.5;

    const double step = 24;
    for (double x = 0; x < size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), grid);
    }
    for (double y = 0; y < size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }

    final Offset origin = Offset(size.width * 0.18, size.height * 0.78);
    canvas.drawLine(Offset(0, origin.dy), Offset(size.width, origin.dy), axis);
    canvas.drawLine(Offset(origin.dx, 0), Offset(origin.dx, size.height), axis);

    final Offset tip = Offset(origin.dx + 220, origin.dy - 120);
    final Paint vec = Paint()
      ..color = _vel
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(origin, tip, vec);
    _drawArrowHead(canvas, origin, tip, _vel);

    final Paint dxP = Paint()
      ..color = _addOp
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(origin, Offset(tip.dx, origin.dy), dxP);
    final Paint dyP = Paint()
      ..color = _clamp
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(Offset(tip.dx, origin.dy), tip, dyP);

    _label(canvas, 'origin', origin + const Offset(-44, 8), _inkMute);
    _label(canvas, 'pixelsPerSecond', tip + const Offset(8, -16), _vel);
    _label(canvas, 'dx (+x → right)', Offset(origin.dx + 70, origin.dy + 8), _addOp);
    _label(canvas, 'dy (+y ↓ down)', Offset(tip.dx + 8, origin.dy - 60), _clamp);
    _label(canvas, '|v| = √(dx² + dy²)', Offset(origin.dx + 80, origin.dy - 90), _ink);

    canvas.drawCircle(origin, 4, Paint()..color = _ink);
    canvas.drawCircle(tip, 4, Paint()..color = _vel);
  }

  void _drawArrowHead(Canvas canvas, Offset from, Offset to, Color color) {
    final double dx = to.dx - from.dx;
    final double dy = to.dy - from.dy;
    final double len = _sqrtNewton(dx * dx + dy * dy);
    if (len <= 0) return;
    final double ux = dx / len;
    final double uy = dy / len;
    const double s = 10;
    final Offset left = Offset(to.dx - ux * s - uy * (s * 0.55), to.dy - uy * s + ux * (s * 0.55));
    final Offset right = Offset(to.dx - ux * s + uy * (s * 0.55), to.dy - uy * s - ux * (s * 0.55));
    final Path p = Path()
      ..moveTo(to.dx, to.dy)
      ..lineTo(left.dx, left.dy)
      ..lineTo(right.dx, right.dy)
      ..close();
    canvas.drawPath(p, Paint()..color = color);
  }

  void _label(Canvas canvas, String text, Offset at, Color color) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, at);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// SECTION 3 — Velocity.zero
// =============================================================================
class _ZeroSection extends StatelessWidget {
  const _ZeroSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      tint: _zero,
      eyebrow: 'Constants',
      title: 'Velocity.zero — the canonical no-motion sentinel',
      subtitle: 'Why a single shared instance is more useful than it looks.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 5,
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: _surfaceDeep,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _zero.withValues(alpha: 0.4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const <Widget>[
                      Text(
                        'Velocity.zero',
                        style: TextStyle(
                          color: _zero,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                          fontFamily: 'monospace',
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        '== Velocity(pixelsPerSecond: Offset.zero)',
                        style: TextStyle(color: _inkSoft, fontSize: 12.5, fontFamily: 'monospace'),
                      ),
                      SizedBox(height: 14),
                      Text(
                        'Returned when a VelocityTracker has too few samples or when the '
                        'fitted polynomial is degenerate. Many gesture recognisers also '
                        'fall back to it on an early gesture cancel. Always safe to use '
                        'as a default and as the right-hand side of `==` checks.',
                        style: TextStyle(color: _inkSoft, fontSize: 13, height: 1.5),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                flex: 4,
                child: Container(
                  height: 170,
                  decoration: BoxDecoration(
                    color: _surfaceDeep,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: _grid),
                  ),
                  child: CustomPaint(painter: _ZeroDotPainter(), size: Size.infinite),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _BulletList(
            tint: _zero,
            items: const <String>[
              'It is `static const`, so identity comparisons against it are constant time.',
              'Equality with any `Velocity` whose pixelsPerSecond is `Offset.zero` is true — `Velocity` overrides `==`.',
              'Adding `Velocity.zero` to any other Velocity returns a value equal to the original.',
              'Subtracting any Velocity from itself yields a value equal to `Velocity.zero`.',
              '`Velocity.zero.clampMagnitude(min, max)` is `Velocity.zero` regardless of the bounds.',
            ],
          ),
        ],
      ),
    );
  }
}

class _ZeroDotPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = Offset(size.width / 2, size.height / 2);
    for (int i = 6; i >= 1; i--) {
      canvas.drawCircle(
        c,
        i * 14.0,
        Paint()
          ..color = _zero.withValues(alpha: 0.05 + i * 0.02)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }
    canvas.drawCircle(c, 6, Paint()..color = _zero);
    final TextPainter tp = TextPainter(
      text: const TextSpan(
        text: '|v| = 0',
        style: TextStyle(color: _ink, fontSize: 13, fontWeight: FontWeight.w700),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(c.dx + 14, c.dy - 8));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =============================================================================
// SECTION 4 — VECTOR GALLERY
// -----------------------------------------------------------------------------
// Each card draws one of the sample velocities as an arrow inside a fixed-scale
// canvas, with a magnitude label. The shared scale lets the eye compare the
// relative size of the velocities at a glance.
// =============================================================================
class _VectorGallerySection extends StatelessWidget {
  const _VectorGallerySection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      tint: _vel,
      eyebrow: 'Gallery',
      title: 'Eight velocities, drawn to the same scale',
      subtitle: 'Reading directions and magnitudes off real-world gestures.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'The arrow length is proportional to |pixelsPerSecond|; long arrows are flings, '
            'short arrows are pans, and the centred dot is Velocity.zero. The cyan halo behind '
            'each arrow shows the magnitude rendered as a circle around the origin.',
            style: TextStyle(color: _inkSoft, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 16),
          _GalleryGrid(samples: _kSamples),
          const SizedBox(height: 14),
          _GalleryLegend(),
        ],
      ),
    );
  }
}

class _GalleryGrid extends StatelessWidget {
  const _GalleryGrid({required this.samples});
  final List<_VSample> samples;

  @override
  Widget build(BuildContext context) {
    final List<Widget> rows = <Widget>[];
    for (int i = 0; i < samples.length; i += 2) {
      final _VSample a = samples[i];
      final _VSample? b = i + 1 < samples.length ? samples[i + 1] : null;
      rows.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #35, P1):
          // Same `Row(crossAxisAlignment: stretch)` inside unbounded-height
          // parent pattern as `_SectionCard`. Wrapping the Row in
          // `IntrinsicHeight` equalises the two gallery cards in the pair
          // to the taller card's intrinsic height without unbounded
          // propagation.
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(child: _GalleryCard(sample: a)),
                const SizedBox(width: 12),
                Expanded(child: b == null ? const SizedBox.shrink() : _GalleryCard(sample: b)),
              ],
            ),
          ),
        ),
      );
    }
    return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: rows);
  }
}

class _GalleryCard extends StatelessWidget {
  const _GalleryCard({required this.sample});
  final _VSample sample;

  @override
  Widget build(BuildContext context) {
    final double mag = _magnitude(sample.pixelsPerSecond);
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surfaceDeep,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: sample.tint.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: sample.tint.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: sample.tint.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: sample.tint.withValues(alpha: 0.5)),
                ),
                child: Text(
                  sample.glyph,
                  style: TextStyle(color: sample.tint, fontSize: 13, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      sample.label,
                      style: const TextStyle(color: _ink, fontSize: 13.5, fontWeight: FontWeight.w700),
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
          const SizedBox(height: 10),
          SizedBox(
            height: 130,
            child: CustomPaint(
              painter: _ArrowPainter(velocity: sample.pixelsPerSecond, tint: sample.tint),
              size: Size.infinite,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: <Widget>[
              _Pill(text: 'dx ${_fix(sample.pixelsPerSecond.dx)}', tint: _addOp),
              _Pill(text: 'dy ${_fix(sample.pixelsPerSecond.dy)}', tint: _clamp),
              _Pill(text: '|v| ${_fix(mag)}', tint: sample.tint),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.tint});
  final String text;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: tint.withValues(alpha: 0.45)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: tint,
          fontSize: 11,
          fontWeight: FontWeight.w700,
          fontFamily: 'monospace',
        ),
      ),
    );
  }
}

class _ArrowPainter extends CustomPainter {
  _ArrowPainter({required this.velocity, required this.tint});
  final Offset velocity;
  final Color tint;

  static const double _refMax = 5500; // matches 'Maxed-out fling' magnitude.

  @override
  void paint(Canvas canvas, Size size) {
    final Offset c = Offset(size.width / 2, size.height / 2);
    final double r = (size.width < size.height ? size.width : size.height) * 0.42;

    // Halo rings.
    for (int i = 4; i >= 1; i--) {
      canvas.drawCircle(
        c,
        r * i / 4,
        Paint()
          ..color = tint.withValues(alpha: 0.05 + i * 0.012)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1,
      );
    }

    // Cross axes.
    final Paint axis = Paint()
      ..color = _grid
      ..strokeWidth = 1;
    canvas.drawLine(Offset(c.dx - r, c.dy), Offset(c.dx + r, c.dy), axis);
    canvas.drawLine(Offset(c.dx, c.dy - r), Offset(c.dx, c.dy + r), axis);

    // Magnitude ring for this sample.
    final double mag = _magnitude(velocity);
    final double ringR = mag <= 0 ? 0 : (mag / _refMax).clamp(0.0, 1.0) * r;
    if (ringR > 0) {
      canvas.drawCircle(
        c,
        ringR,
        Paint()
          ..color = tint.withValues(alpha: 0.18)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.6,
      );
    }

    if (mag <= 0) {
      canvas.drawCircle(c, 5, Paint()..color = tint);
      return;
    }

    // Arrow tip.
    final double scale = ringR / mag;
    final Offset tip = Offset(c.dx + velocity.dx * scale, c.dy + velocity.dy * scale);
    final Paint shaft = Paint()
      ..color = tint
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;
    canvas.drawLine(c, tip, shaft);

    // Arrow head.
    final double dx = tip.dx - c.dx;
    final double dy = tip.dy - c.dy;
    final double len = _sqrtNewton(dx * dx + dy * dy);
    if (len > 0) {
      final double ux = dx / len;
      final double uy = dy / len;
      const double s = 9;
      final Offset l = Offset(tip.dx - ux * s - uy * (s * 0.55), tip.dy - uy * s + ux * (s * 0.55));
      final Offset rArr = Offset(tip.dx - ux * s + uy * (s * 0.55), tip.dy - uy * s - ux * (s * 0.55));
      final Path p = Path()
        ..moveTo(tip.dx, tip.dy)
        ..lineTo(l.dx, l.dy)
        ..lineTo(rArr.dx, rArr.dy)
        ..close();
      canvas.drawPath(p, Paint()..color = tint);
    }

    canvas.drawCircle(c, 3, Paint()..color = _ink);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _GalleryLegend extends StatelessWidget {
  const _GalleryLegend();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _surfaceDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _grid),
      ),
      child: Wrap(
        spacing: 18,
        runSpacing: 6,
        children: const <Widget>[
          _LegendDot(color: _addOp, label: 'dx component'),
          _LegendDot(color: _clamp, label: 'dy component'),
          _LegendDot(color: _vel, label: 'magnitude ring'),
          _LegendDot(color: _zero, label: 'origin / Velocity.zero'),
        ],
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.color, required this.label});
  final Color color;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: _inkSoft, fontSize: 12)),
      ],
    );
  }
}

// =============================================================================
// SECTION 5 — clampMagnitude TABLE
// -----------------------------------------------------------------------------
// `clampMagnitude(min, max)` rescales the velocity so that |v| lies inside
// [min, max] inclusive, preserving direction. Each table row shows an input
// vector, its magnitude, the chosen bounds, and the resulting clamped vector.
// =============================================================================
class _ClampRow {
  const _ClampRow({
    required this.label,
    required this.input,
    required this.min,
    required this.max,
    required this.note,
  });
  final String label;
  final Offset input;
  final double min;
  final double max;
  final String note;
}

const List<_ClampRow> _kClampRows = <_ClampRow>[
  _ClampRow(
    label: 'Below floor',
    input: Offset(60, 80),
    min: 200,
    max: 4000,
    note: '|v| = 100, scaled UP to 200 (preserves direction).',
  ),
  _ClampRow(
    label: 'Inside band',
    input: Offset(300, 400),
    min: 200,
    max: 4000,
    note: '|v| = 500, already in [200, 4000]; returned unchanged.',
  ),
  _ClampRow(
    label: 'Above ceiling',
    input: Offset(3000, 4000),
    min: 200,
    max: 4000,
    note: '|v| = 5000, scaled DOWN to 4000 along the same direction.',
  ),
  _ClampRow(
    label: 'Tiny jitter',
    input: Offset(-7, 4),
    min: 50,
    max: 4000,
    note: 'Sub-50 noise lifted to the floor — useful for fling thresholds.',
  ),
  _ClampRow(
    label: 'Vertical-only',
    input: Offset(0, 6500),
    min: 0,
    max: 3000,
    note: 'Pure dy, scaled to the cap; dx stays 0.',
  ),
  _ClampRow(
    label: 'Pure horizontal',
    input: Offset(-2400, 0),
    min: 500,
    max: 1800,
    note: 'Sign of dx preserved (negative) while magnitude is reduced.',
  ),
  _ClampRow(
    label: 'Diagonal cap',
    input: Offset(1300, -900),
    min: 0,
    max: 1000,
    note: '|v| ≈ 1581, both components shrink proportionally.',
  ),
  _ClampRow(
    label: 'Already zero',
    input: Offset.zero,
    min: 50,
    max: 4000,
    note: 'Velocity.zero passes through; the floor cannot conjure a direction.',
  ),
];

class _ClampMagnitudeSection extends StatelessWidget {
  const _ClampMagnitudeSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      tint: _clamp,
      eyebrow: 'clampMagnitude',
      title: 'Constraining |v| while keeping the direction',
      subtitle: 'Eight representative inputs and what clampMagnitude returns.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'clampMagnitude(min, max) returns a new Velocity whose pixelsPerSecond is the '
            'input rescaled so |v| ∈ [min, max]. Vectors below the floor are stretched out, '
            'vectors above the ceiling are pulled in, and anything already inside the band is '
            'returned unchanged. The direction (the sign and ratio of dx and dy) is preserved.',
            style: TextStyle(color: _inkSoft, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              color: _surfaceDeep,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _grid),
            ),
            child: Column(
              children: <Widget>[
                _ClampHeaderRow(),
                for (int i = 0; i < _kClampRows.length; i++)
                  _ClampDataRow(row: _kClampRows[i], even: i.isEven),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ClampHeaderRow extends StatelessWidget {
  const _ClampHeaderRow();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _surfaceAlt.withValues(alpha: 0.55),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(flex: 4, child: _ClampHeadCell('Case')),
          Expanded(flex: 5, child: _ClampHeadCell('Input v')),
          Expanded(flex: 3, child: _ClampHeadCell('|v|')),
          Expanded(flex: 4, child: _ClampHeadCell('[min, max]')),
          Expanded(flex: 5, child: _ClampHeadCell('Result')),
          Expanded(flex: 3, child: _ClampHeadCell('|result|')),
        ],
      ),
    );
  }
}

class _ClampHeadCell extends StatelessWidget {
  const _ClampHeadCell(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        color: _inkSoft,
        fontSize: 10.5,
        letterSpacing: 1.4,
        fontWeight: FontWeight.w800,
      ),
    );
  }
}

class _ClampDataRow extends StatelessWidget {
  const _ClampDataRow({required this.row, required this.even});
  final _ClampRow row;
  final bool even;

  @override
  Widget build(BuildContext context) {
    final double mIn = _magnitude(row.input);
    final Offset out = _clampMagnitudeOffset(row.input, row.min, row.max);
    final double mOut = _magnitude(out);
    final bool unchanged = (out.dx == row.input.dx) && (out.dy == row.input.dy);
    final Color resultTint = unchanged
        ? _ok
        : (mIn < row.min ? _addOp : (mIn > row.max ? _danger : _ok));
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: even ? _surfaceDeep : _surface.withValues(alpha: 0.45),
        border: Border(top: BorderSide(color: _grid.withValues(alpha: 0.6))),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Text(
                  row.label,
                  style: const TextStyle(
                    color: _ink,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  _vec(row.input),
                  style: const TextStyle(
                    color: _inkSoft,
                    fontSize: 12.5,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  _fix(mIn),
                  style: const TextStyle(
                    color: _inkSoft,
                    fontSize: 12.5,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  '[${_fix(row.min, 0)}, ${_fix(row.max, 0)}]',
                  style: const TextStyle(
                    color: _clamp,
                    fontSize: 12,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: Text(
                  _vec(out),
                  style: TextStyle(
                    color: resultTint,
                    fontSize: 12.5,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  _fix(mOut),
                  style: TextStyle(
                    color: resultTint,
                    fontSize: 12.5,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Padding(
            padding: const EdgeInsets.only(left: 2, top: 2),
            child: Text(
              row.note,
              style: const TextStyle(color: _inkMute, fontSize: 11.5, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 6 — clampMagnitude RULES
// =============================================================================
class _ClampRulesSection extends StatelessWidget {
  const _ClampRulesSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      tint: _clamp,
      eyebrow: 'Rules',
      title: 'How clampMagnitude actually behaves',
      subtitle: 'Edge cases and invariants worth memorising.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _RuleCard(
                  tint: _addOp,
                  title: 'Stretch',
                  body:
                      'If |v| < min and |v| > 0, the vector is scaled by min/|v|. '
                      'Direction is preserved; magnitude becomes exactly min.',
                  formula: 'v * (min / |v|)',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RuleCard(
                  tint: _ok,
                  title: 'Pass-through',
                  body:
                      'If min ≤ |v| ≤ max, the input is returned unchanged. '
                      'No allocation surprises; equality holds.',
                  formula: 'v',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _RuleCard(
                  tint: _danger,
                  title: 'Shrink',
                  body:
                      'If |v| > max, the vector is scaled by max/|v|. '
                      'Direction is preserved; magnitude becomes exactly max.',
                  formula: 'v * (max / |v|)',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _surfaceDeep,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _clamp.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Edge cases',
                  style: TextStyle(color: _clamp, fontSize: 13, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 8),
                _RuleBullet('|v| == 0 is fixed: clamping returns Velocity.zero regardless of min — there is no canonical direction to stretch.'),
                _RuleBullet('min and max must satisfy min <= max in callers; the framework asserts this in debug builds.'),
                _RuleBullet('Negative bounds are not meaningful for magnitudes, but the math still preserves direction.'),
                _RuleBullet('clampMagnitude allocates a new Velocity only when scaling actually occurs.'),
                _RuleBullet('Repeated clamping with the same bounds is idempotent: clamp(clamp(v, a, b), a, b) == clamp(v, a, b).'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleCard extends StatelessWidget {
  const _RuleCard({
    required this.tint,
    required this.title,
    required this.body,
    required this.formula,
  });
  final Color tint;
  final String title;
  final String body;
  final String formula;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surfaceDeep,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tint.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tint.withValues(alpha: 0.10),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: tint,
              fontSize: 11,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 8),
          Text(body, style: const TextStyle(color: _ink, fontSize: 13, height: 1.45)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _bg0,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: tint.withValues(alpha: 0.4)),
            ),
            child: Text(
              formula,
              style: TextStyle(
                color: tint,
                fontSize: 12.5,
                fontFamily: 'monospace',
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RuleBullet extends StatelessWidget {
  const _RuleBullet(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(top: 6),
            width: 6,
            height: 6,
            decoration: const BoxDecoration(
              color: _clamp,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: _inkSoft, fontSize: 12.5, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 7 — OPERATORS
// =============================================================================
class _OpRow {
  const _OpRow({required this.label, required this.a, required this.b, required this.op});
  final String label;
  final Offset a;
  final Offset b;
  final String op; // '+', '-', '-a' (unary)
}

const List<_OpRow> _kOpRows = <_OpRow>[
  _OpRow(label: 'Combining two horizontal flings', a: Offset(800, 0), b: Offset(400, 0), op: '+'),
  _OpRow(label: 'Cancelling a horizontal pull-back', a: Offset(1200, 0), b: Offset(-500, 0), op: '+'),
  _OpRow(label: 'Net diagonal motion', a: Offset(900, -700), b: Offset(200, -300), op: '+'),
  _OpRow(label: 'Subtracting reference velocity', a: Offset(1500, 200), b: Offset(500, 200), op: '-'),
  _OpRow(label: 'Difference between two flings', a: Offset(2400, -800), b: Offset(2400, 0), op: '-'),
  _OpRow(label: 'Negating a velocity', a: Offset(1300, -900), b: Offset.zero, op: '-a'),
];

class _OperatorSection extends StatelessWidget {
  const _OperatorSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      tint: _addOp,
      eyebrow: 'Operators',
      title: 'Adding, subtracting and negating velocities',
      subtitle: 'Componentwise math wrapped behind familiar operator syntax.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Velocity overrides three operators. `+` and `-` are componentwise on '
            'pixelsPerSecond; unary `-` flips both signs. The result is always a fresh '
            'Velocity instance — Velocity is immutable so there is no in-place form.',
            style: TextStyle(color: _inkSoft, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: _OpFormulaCard(
                  tint: _addOp,
                  symbol: '+',
                  title: 'Addition',
                  rule: 'Velocity(a + b) where + is the Offset componentwise sum.',
                  example: 'Velocity(pixelsPerSecond: a + b)',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _OpFormulaCard(
                  tint: _subOp,
                  symbol: '-',
                  title: 'Subtraction',
                  rule: 'Velocity(a - b) — useful for relative-velocity diffs.',
                  example: 'Velocity(pixelsPerSecond: a - b)',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _OpFormulaCard(
                  tint: _est,
                  symbol: '-a',
                  title: 'Negation',
                  rule: 'Unary minus flips dx and dy. Same magnitude, opposite direction.',
                  example: 'Velocity(pixelsPerSecond: -a)',
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            decoration: BoxDecoration(
              color: _surfaceDeep,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _grid),
            ),
            child: Column(
              children: <Widget>[
                _OpHeader(),
                for (int i = 0; i < _kOpRows.length; i++)
                  _OpDataRow(row: _kOpRows[i], even: i.isEven),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OpFormulaCard extends StatelessWidget {
  const _OpFormulaCard({
    required this.tint,
    required this.symbol,
    required this.title,
    required this.rule,
    required this.example,
  });
  final Color tint;
  final String symbol;
  final String title;
  final String rule;
  final String example;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surfaceDeep,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tint.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: tint.withValues(alpha: 0.55)),
                ),
                child: Text(
                  symbol,
                  style: TextStyle(color: tint, fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(color: _ink, fontSize: 14, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(rule, style: const TextStyle(color: _inkSoft, fontSize: 12.5, height: 1.45)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _bg0,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: tint.withValues(alpha: 0.4)),
            ),
            child: Text(
              example,
              style: TextStyle(color: tint, fontSize: 11.5, fontFamily: 'monospace', fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

class _OpHeader extends StatelessWidget {
  const _OpHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: _surfaceAlt.withValues(alpha: 0.55),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(14)),
      ),
      child: Row(
        children: const <Widget>[
          Expanded(flex: 5, child: _ClampHeadCell('Scenario')),
          Expanded(flex: 4, child: _ClampHeadCell('a')),
          Expanded(flex: 2, child: _ClampHeadCell('Op')),
          Expanded(flex: 4, child: _ClampHeadCell('b')),
          Expanded(flex: 4, child: _ClampHeadCell('Result')),
        ],
      ),
    );
  }
}

class _OpDataRow extends StatelessWidget {
  const _OpDataRow({required this.row, required this.even});
  final _OpRow row;
  final bool even;

  Offset _result() {
    switch (row.op) {
      case '+':
        return row.a + row.b;
      case '-':
        return row.a - row.b;
      case '-a':
        return -row.a;
    }
    return Offset.zero;
  }

  Color _opTint() {
    switch (row.op) {
      case '+':
        return _addOp;
      case '-':
        return _subOp;
      case '-a':
        return _est;
    }
    return _ink;
  }

  String _opGlyph() {
    switch (row.op) {
      case '+':
        return '+';
      case '-':
        return '-';
      case '-a':
        return '−a';
    }
    return '?';
  }

  @override
  Widget build(BuildContext context) {
    final Offset r = _result();
    final Color tint = _opTint();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: even ? _surfaceDeep : _surface.withValues(alpha: 0.45),
        border: Border(top: BorderSide(color: _grid.withValues(alpha: 0.6))),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: Text(
              row.label,
              style: const TextStyle(color: _ink, fontSize: 13, fontWeight: FontWeight.w700),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              _vec(row.a),
              style: const TextStyle(color: _inkSoft, fontSize: 12.5, fontFamily: 'monospace'),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: tint.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(color: tint.withValues(alpha: 0.5)),
                ),
                child: Text(
                  _opGlyph(),
                  style: TextStyle(color: tint, fontSize: 12, fontWeight: FontWeight.w800, fontFamily: 'monospace'),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              row.op == '-a' ? '—' : _vec(row.b),
              style: const TextStyle(color: _inkSoft, fontSize: 12.5, fontFamily: 'monospace'),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              _vec(r),
              style: TextStyle(color: tint, fontSize: 12.5, fontFamily: 'monospace', fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 8 — EQUALITY & HASHCODE
// =============================================================================
class _EqualitySection extends StatelessWidget {
  const _EqualitySection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      tint: _ok,
      eyebrow: 'Identity',
      title: 'Equality is value-based; hashCode folds the Offset',
      subtitle: 'Velocity overrides == and hashCode so it can live in sets and maps.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _surfaceDeep,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _grid),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                _CodeLine('// Conceptually:'),
                _CodeLine('@override'),
                _CodeLine('bool operator ==(Object other) =>'),
                _CodeLine('    other is Velocity && other.pixelsPerSecond == pixelsPerSecond;', indent: 1),
                // D4RT-SCRIPT-WORKAROUND (framework_error_fix_plan #35, P-empty-text):
                // Original source had a blank `_CodeLine('')` separator here.
                // Under the d4rt interpreter, a `Text('')` inside this Column
                // (descendant of `IntrinsicHeight > Row(stretch)` from
                // `_SectionCard`) blows up a downstream `RenderFlex.layout()`
                // with "BoxConstraints forces an infinite height" — the
                // empty-Text intrinsic path computes an unbounded height
                // under that constraint chain. Replace the empty separator
                // with a fixed-height SizedBox to preserve the gap without
                // exercising the Text intrinsic path. The underlying
                // interpreter bug is tracked in interpreter_unfixable.md.
                SizedBox(height: 14),
                _CodeLine('@override'),
                _CodeLine('int get hashCode => Object.hash(pixelsPerSecond.dx, pixelsPerSecond.dy);'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _BulletList(
            tint: _ok,
            items: const <String>[
              'Two Velocity instances with the same dx and dy are equal — the constructor identity is irrelevant.',
              'Velocity.zero == Velocity(pixelsPerSecond: Offset.zero) is true.',
              'NaN handling follows Offset: NaN != NaN, so a velocity carrying NaN is not equal to itself.',
              'Use Velocity in HashSet / HashMap freely; hashCode mirrors equality.',
              '`toString()` returns "Velocity(dx, dy)" — handy in widget inspector and debug logs.',
            ],
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 9 — Velocity vs VelocityEstimate
// =============================================================================
class _VelocityVsEstimateSection extends StatelessWidget {
  const _VelocityVsEstimateSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      tint: _est,
      eyebrow: 'Sibling',
      title: 'Velocity vs VelocityEstimate — when to reach for which',
      subtitle: 'Two related types in flutter/gestures, one richer than the other.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A `VelocityEstimate` is what the tracker actually fits: a velocity vector plus a '
            'confidence and the time window the samples covered. A `Velocity` is the simplified '
            'value the gesture API hands to consumers — the framework strips away the metadata '
            'that the application layer almost never needs.',
            style: TextStyle(color: _inkSoft, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(child: _CompareCard(
                tint: _vel,
                title: 'Velocity',
                role: 'Public API surface',
                fields: const <String>['pixelsPerSecond : Offset'],
                where: const <String>[
                  'DragEndDetails.velocity',
                  'TapDragEndDetails.velocity',
                  'Fling animation seeding (BallisticScrollSimulation)',
                ],
                strengths: const <String>[
                  'Compact; cheap to copy and compare',
                  'Has clampMagnitude and arithmetic operators',
                  'Has a canonical .zero',
                ],
                gaps: const <String>[
                  'No confidence — caller cannot tell good fits from bad',
                  'No duration / displacement context',
                ],
              )),
              const SizedBox(width: 12),
              Expanded(child: _CompareCard(
                tint: _est,
                title: 'VelocityEstimate',
                role: 'Tracker output',
                fields: const <String>[
                  'pixelsPerSecond : Offset',
                  'confidence : double  (0..1)',
                  'duration : Duration',
                  'offset : Offset',
                ],
                where: const <String>[
                  'VelocityTracker.getVelocityEstimate()',
                  'IOSScrollViewFlingVelocityTracker',
                  'Custom recognisers that gate on confidence',
                ],
                strengths: const <String>[
                  'Carries fit quality (confidence)',
                  'Knows the time window and total displacement',
                  'Suited to debugging tracker behaviour',
                ],
                gaps: const <String>[
                  'No clampMagnitude / operators',
                  'Heavier; more allocation pressure than Velocity',
                ],
              )),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _surfaceDeep,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _est.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Conversion in practice',
                  style: TextStyle(color: _est, fontSize: 13, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 8),
                _CodeLine('VelocityTracker tracker = VelocityTracker.withKind(PointerDeviceKind.touch);'),
                _CodeLine('// ...feed pointer samples...'),
                _CodeLine('VelocityEstimate? estimate = tracker.getVelocityEstimate();', tint: _est),
                _CodeLine('Velocity velocity = estimate == null'),
                _CodeLine('    ? Velocity.zero', indent: 1, tint: _zero),
                _CodeLine('    : Velocity(pixelsPerSecond: estimate.pixelsPerSecond);', indent: 1, tint: _vel),
                _CodeLine('// Velocity == the public summary; VelocityEstimate stays internal.'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CompareCard extends StatelessWidget {
  const _CompareCard({
    required this.tint,
    required this.title,
    required this.role,
    required this.fields,
    required this.where,
    required this.strengths,
    required this.gaps,
  });
  final Color tint;
  final String title;
  final String role;
  final List<String> fields;
  final List<String> where;
  final List<String> strengths;
  final List<String> gaps;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _surfaceDeep,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: tint.withValues(alpha: 0.45)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tint.withValues(alpha: 0.10),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: tint, fontSize: 16, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 2),
          Text(
            role.toUpperCase(),
            style: TextStyle(
              color: tint.withValues(alpha: 0.75),
              fontSize: 10,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          _MiniSection(label: 'Fields', tint: tint, items: fields, mono: true),
          _MiniSection(label: 'Lives in', tint: tint, items: where),
          _MiniSection(label: 'Strengths', tint: _ok, items: strengths),
          _MiniSection(label: 'Gaps', tint: _danger, items: gaps),
        ],
      ),
    );
  }
}

class _MiniSection extends StatelessWidget {
  const _MiniSection({
    required this.label,
    required this.tint,
    required this.items,
    this.mono = false,
  });
  final String label;
  final Color tint;
  final List<String> items;
  final bool mono;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            label.toUpperCase(),
            style: TextStyle(
              color: tint,
              fontSize: 10,
              letterSpacing: 1.3,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 6),
          for (final String i in items)
            Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 6),
                    width: 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: tint.withValues(alpha: 0.7),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      i,
                      style: TextStyle(
                        color: _inkSoft,
                        fontSize: 12.5,
                        height: 1.45,
                        fontFamily: mono ? 'monospace' : null,
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
// SECTION 10 — INTEGRATION STORY (VelocityTracker → Velocity → DragEndDetails)
// =============================================================================
class _IntegrationStorySection extends StatelessWidget {
  const _IntegrationStorySection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      tint: _drag,
      eyebrow: 'Integration',
      title: 'From pointer samples to DragEndDetails.velocity',
      subtitle: 'How Velocity is produced and where you actually consume it.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'A drag gesture is a pipeline of typed values. Pointer events feed a VelocityTracker; '
            'the tracker fits a polynomial and emits a VelocityEstimate; the recogniser collapses '
            'that estimate into a Velocity and packs it into a DragEndDetails for the application '
            'callback. Each box below is a real flutter/gestures type.',
            style: TextStyle(color: _inkSoft, fontSize: 13, height: 1.5),
          ),
          const SizedBox(height: 18),
          _Pipeline(),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: _surfaceDeep,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(color: _drag.withValues(alpha: 0.4)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const <Widget>[
                Text(
                  'Concrete handler',
                  style: TextStyle(color: _drag, fontSize: 13, fontWeight: FontWeight.w800),
                ),
                SizedBox(height: 8),
                _CodeLine('GestureDetector('),
                _CodeLine('  onHorizontalDragEnd: (DragEndDetails details) {', indent: 1),
                _CodeLine('    final Velocity v = details.velocity; // ← here it is', indent: 2, tint: _vel),
                _CodeLine('    final Velocity safe = v.clampMagnitude(50, 4000);', indent: 2, tint: _clamp),
                _CodeLine('    if (safe.pixelsPerSecond.dx > 1500) _dismissPage();', indent: 2),
                _CodeLine('    else if (safe.pixelsPerSecond.dx < -1500) _goBack();', indent: 2),
                _CodeLine('    else _settleToRestPosition();', indent: 2),
                _CodeLine('  },', indent: 1),
                _CodeLine('  child: ...,', indent: 1),
                _CodeLine(');'),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _BulletList(
            tint: _drag,
            items: const <String>[
              'DragEndDetails.velocity is non-null and defaults to Velocity.zero if no estimate could be produced.',
              'TapDragEndDetails.velocity has the same semantics — both end-details types share the value type.',
              'Scroll views and Dismissible compute their fling thresholds against the magnitude of this Velocity.',
              'Custom recognisers should clamp before threshold-comparing to avoid pathological huge magnitudes.',
            ],
          ),
        ],
      ),
    );
  }
}

class _Pipeline extends StatelessWidget {
  const _Pipeline();

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(child: _PipelineNode(tint: _track, title: 'PointerEvent', sub: 'each touch sample (position, time)', kind: 'input')),
        _PipelineArrow(label: 'addPosition()'),
        Expanded(child: _PipelineNode(tint: _track, title: 'VelocityTracker', sub: 'least-squares polynomial fit', kind: 'process')),
        _PipelineArrow(label: 'getVelocityEstimate()'),
        Expanded(child: _PipelineNode(tint: _est, title: 'VelocityEstimate', sub: 'pixels/s + confidence + window', kind: 'process')),
        _PipelineArrow(label: 'simplify'),
        Expanded(child: _PipelineNode(tint: _vel, title: 'Velocity', sub: 'pixelsPerSecond only', kind: 'output')),
        _PipelineArrow(label: 'pack'),
        Expanded(child: _PipelineNode(tint: _drag, title: 'DragEndDetails', sub: '.velocity surfaced to your callback', kind: 'output')),
      ],
    );
  }
}

class _PipelineNode extends StatelessWidget {
  const _PipelineNode({required this.tint, required this.title, required this.sub, required this.kind});
  final Color tint;
  final String title;
  final String sub;
  final String kind;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
      height: 110,
      decoration: BoxDecoration(
        color: _surfaceDeep,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: tint.withValues(alpha: 0.55)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: tint.withValues(alpha: 0.12),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            kind.toUpperCase(),
            style: TextStyle(
              color: tint,
              fontSize: 9.5,
              letterSpacing: 1.4,
              fontWeight: FontWeight.w800,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(color: _ink, fontSize: 12.5, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: Text(
              sub,
              style: const TextStyle(color: _inkSoft, fontSize: 11, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }
}

class _PipelineArrow extends StatelessWidget {
  const _PipelineArrow({required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 110,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: _inkMute, fontSize: 9.5, height: 1.2),
          ),
          const SizedBox(height: 4),
          const Icon(Icons.arrow_forward_rounded, color: _inkSoft, size: 18),
        ],
      ),
    );
  }
}

// =============================================================================
// SECTION 11 — PITFALLS
// =============================================================================
class _Pitfall {
  const _Pitfall({
    required this.title,
    required this.body,
    required this.fix,
    required this.tint,
  });
  final String title;
  final String body;
  final String fix;
  final Color tint;
}

const List<_Pitfall> _kPitfalls = <_Pitfall>[
  _Pitfall(
    tint: _danger,
    title: 'Confusing magnitude with a single component',
    body:
        'A horizontal fling can have |v| that looks tiny if you only look at dy, '
        'and vice versa. Threshold tests against dx alone miss diagonal swipes; '
        'against |v| they over-trigger on near-vertical motions when you only '
        'care about a horizontal dismiss.',
    fix:
        'Decide up-front whether your gesture is axis-locked. For axis-locked '
        'gestures compare the relevant component (e.g. velocity.pixelsPerSecond.dx). '
        'For omnidirectional flings compare the magnitude.',
  ),
  _Pitfall(
    tint: _warn,
    title: 'Forgetting that +y points DOWN',
    body:
        'Screen coordinates put +y at the bottom, so an upward swipe has '
        'dy < 0. Treating "swipe up" as "dy > 0" is the most common sign bug '
        'in gesture code.',
    fix:
        'Write the comparison in terms of the gesture intent: '
        'final bool swipingUp = velocity.pixelsPerSecond.dy < -threshold;.',
  ),
  _Pitfall(
    tint: _warn,
    title: 'Skipping clampMagnitude before easing',
    body:
        'Pathologically fast pointer events (palm rejection edge cases, simulator '
        'replays) can produce magnitudes of tens of thousands of px/s. Feeding those '
        'directly into a fling animation leads to overshoot, wrap-around or stutter.',
    fix:
        'Always clampMagnitude with a sane band before plugging the velocity '
        'into ScrollSimulation, AnimationController.fling or your own physics.',
  ),
  _Pitfall(
    tint: _danger,
    title: 'Treating "low magnitude" as "no fling"',
    body:
        'A confidence-zero estimate may still produce a non-zero Velocity. '
        'Conversely, a real fling can have |v| barely above your threshold and '
        'still feel intentional to the user.',
    fix:
        'Combine the magnitude test with hysteresis (different thresholds for '
        'arming and triggering). Where confidence matters, work with VelocityEstimate '
        'directly instead of the simplified Velocity.',
  ),
  _Pitfall(
    tint: _warn,
    title: 'Mutating an Offset thinking the Velocity changed',
    body:
        'Velocity is immutable; pixelsPerSecond is final. Modifying a local Offset '
        'variable that you obtained from a Velocity does NOT alter that Velocity.',
    fix:
        'Build a new Velocity when you want a different value: '
        'Velocity(pixelsPerSecond: oldV.pixelsPerSecond + Offset(0, -100)).',
  ),
  _Pitfall(
    tint: _danger,
    title: 'Comparing Velocity by identity (`identical`)',
    body:
        'Two Velocity instances with the same pixelsPerSecond may not be identical; '
        'the framework allocates fresh Velocity values on most code paths.',
    fix:
        'Use `==` (which is value-based) and not `identical()`. The hashCode '
        'override makes the type safe to use as a key.',
  ),
];

class _PitfallsSection extends StatelessWidget {
  const _PitfallsSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      tint: _danger,
      eyebrow: 'Pitfalls',
      title: 'Six mistakes that quietly ruin gesture handlers',
      subtitle: 'Each one comes with a precise framing and a one-line fix.',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final _Pitfall p in _kPitfalls)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _PitfallCard(p: p),
            ),
        ],
      ),
    );
  }
}

class _PitfallCard extends StatelessWidget {
  const _PitfallCard({required this.p});
  final _Pitfall p;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: _surfaceDeep,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: p.tint.withValues(alpha: 0.45)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: p.tint.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(999),
                  border: Border.all(color: p.tint.withValues(alpha: 0.5)),
                ),
                child: Text(
                  'pitfall',
                  style: TextStyle(
                    color: p.tint,
                    fontSize: 10.5,
                    letterSpacing: 1.3,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  p.title,
                  style: const TextStyle(color: _ink, fontSize: 14, fontWeight: FontWeight.w800),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(p.body, style: const TextStyle(color: _inkSoft, fontSize: 12.5, height: 1.5)),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 10),
            decoration: BoxDecoration(
              color: _bg0,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: _ok.withValues(alpha: 0.4)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 2, right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _ok.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    'fix',
                    style: TextStyle(
                      color: _ok,
                      fontSize: 10,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    p.fix,
                    style: const TextStyle(color: _inkSoft, fontSize: 12.5, height: 1.5),
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
// SECTION 12 — CHEATSHEET
// =============================================================================
class _Cheat {
  const _Cheat({required this.lhs, required this.rhs, required this.tint});
  final String lhs;
  final String rhs;
  final Color tint;
}

const List<_Cheat> _kCheats = <_Cheat>[
  _Cheat(lhs: 'Velocity.zero', rhs: 'Canonical no-motion sentinel', tint: _zero),
  _Cheat(lhs: 'v.pixelsPerSecond', rhs: 'The Offset, dx in px/s, dy in px/s', tint: _vel),
  _Cheat(lhs: 'v.pixelsPerSecond.distance', rhs: 'Magnitude in px/s', tint: _vel),
  _Cheat(lhs: 'v.clampMagnitude(min, max)', rhs: 'Rescale to [min, max]; preserves direction', tint: _clamp),
  _Cheat(lhs: 'a + b', rhs: 'Componentwise sum into a new Velocity', tint: _addOp),
  _Cheat(lhs: 'a - b', rhs: 'Componentwise difference', tint: _subOp),
  _Cheat(lhs: '-a', rhs: 'Negate dx and dy (same magnitude, opposite direction)', tint: _est),
  _Cheat(lhs: 'a == b', rhs: 'Value equality based on pixelsPerSecond', tint: _ok),
  _Cheat(lhs: 'details.velocity', rhs: 'On DragEndDetails / TapDragEndDetails', tint: _drag),
  _Cheat(lhs: 'tracker.getVelocityEstimate()', rhs: 'Returns the richer VelocityEstimate', tint: _est),
];

class _CheatsheetSection extends StatelessWidget {
  const _CheatsheetSection();

  @override
  Widget build(BuildContext context) {
    return _SectionCard(
      tint: _vel,
      eyebrow: 'Cheatsheet',
      title: 'Everything you actually use, in one place',
      subtitle: 'Quick reference — left column is what you type, right column is what it does.',
      child: Container(
        decoration: BoxDecoration(
          color: _surfaceDeep,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: _grid),
        ),
        child: Column(
          children: <Widget>[
            for (int i = 0; i < _kCheats.length; i++)
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                decoration: BoxDecoration(
                  border: i == 0
                      ? null
                      : Border(top: BorderSide(color: _grid.withValues(alpha: 0.6))),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      width: 8,
                      height: 24,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        color: _kCheats[i].tint,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Text(
                        _kCheats[i].lhs,
                        style: TextStyle(
                          color: _kCheats[i].tint,
                          fontSize: 12.5,
                          fontFamily: 'monospace',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Text(
                        _kCheats[i].rhs,
                        style: const TextStyle(color: _inkSoft, fontSize: 12.5, height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// =============================================================================
// SECTION 13 — FOOTER
// =============================================================================
class _FooterSection extends StatelessWidget {
  const _FooterSection();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[_surface, _surfaceDeep],
        ),
        border: Border.all(color: _grid),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.32),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: const BoxDecoration(color: _vel, shape: BoxShape.circle),
          ),
          const SizedBox(width: 10),
          const Expanded(
            child: Text(
              'Velocity — small, immutable, ubiquitous. Wherever a Flutter gesture ends, a Velocity is waiting on the details.',
              style: TextStyle(color: _inkSoft, fontSize: 12.5, height: 1.5),
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: _vel.withValues(alpha: 0.14),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(color: _vel.withValues(alpha: 0.5)),
            ),
            child: const Text(
              'gestures/velocity.dart',
              style: TextStyle(
                color: _vel,
                fontSize: 10.5,
                letterSpacing: 1.2,
                fontWeight: FontWeight.w800,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
