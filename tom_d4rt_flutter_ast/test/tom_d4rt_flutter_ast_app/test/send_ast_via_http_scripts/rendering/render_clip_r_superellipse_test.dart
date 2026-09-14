// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
import 'dart:math' as math;

import 'package:flutter/material.dart';

// =============================================================================
// RenderClipRSuperellipse — deep, hand-authored demo
// -----------------------------------------------------------------------------
// RenderClipRSuperellipse is the render object that backs the ClipRSuperellipse
// widget (Flutter SDK). It clips its child to a *rounded superellipse* — a
// shape closely related to Apple's "squircle" used for iOS app icons. A
// superellipse is the level set |x/a|^n + |y/b|^n = 1. For n = 2 we have an
// ellipse; for n = ∞ we have a rectangle. A rounded superellipse blends a
// superellipse profile with a corner radius, so it interpolates smoothly
// between an ellipse, a squircle (n ≈ 4–5), and a rounded rectangle.
//
// Render object source:
//   packages/flutter/lib/src/rendering/proxy_box.dart →
//     class RenderClipRSuperellipse extends _RenderCustomClip<RSuperellipse>
//
// Widget source:
//   packages/flutter/lib/src/widgets/basic.dart →
//     class ClipRSuperellipse extends SingleChildRenderObjectWidget
//
// This demo:
//   * verifies ClipRSuperellipse renders correctly across border radii
//   * compares it against ClipRect / ClipRRect / ClipOval / ClipPath
//   * provides a hand-rolled CustomClipper<Path> to draw a *true* superellipse
//     (the Lamé curve) so we can show the underlying math, while
//     ClipRSuperellipse itself uses the rounded-superellipse SDK primitive.
//
// Harness contract: a single top-level `build(BuildContext)` returning a
// MaterialApp, no main / runApp / testWidgets.
// =============================================================================

dynamic build(BuildContext context) {
  print('=== RenderClipRSuperellipse Deep Demo (harness build) ===');
  return const _RClipRSuperellipseDemoApp();
}

class _RClipRSuperellipseDemoApp extends StatelessWidget {
  const _RClipRSuperellipseDemoApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RenderClipRSuperellipse Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.indigo,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('RenderClipRSuperellipse — Deep Demo'),
          backgroundColor: const Color(0xFF1F2A44),
          foregroundColor: Colors.white,
        ),
        backgroundColor: const Color(0xFFF3F4FB),
        body: const SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(16, 16, 16, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _Section1HeroIntro(),
                SizedBox(height: 24),
                _Section2SquircleEquation(),
                SizedBox(height: 24),
                _Section3NExponentSlider(),
                SizedBox(height: 24),
                _Section4BorderRadiusSlider(),
                SizedBox(height: 24),
                _Section5SquircleGallery(),
                SizedBox(height: 24),
                _Section6AnimatedMorph(),
                SizedBox(height: 24),
                _Section7ClipComparison(),
                SizedBox(height: 24),
                _Section8AppIconStyle(),
                SizedBox(height: 24),
                _Section9PerformanceCard(),
                SizedBox(height: 24),
                _Section10RealLifeRecipes(),
                SizedBox(height: 24),
                _Section11DecisionCard(),
                SizedBox(height: 24),
                _Section12ReferenceTable(),
                SizedBox(height: 24),
                _Section13Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Shared helpers
// -----------------------------------------------------------------------------

class _SectionShell extends StatelessWidget {
  const _SectionShell({
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.background,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Color accent;
  final Color background;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: accent.withOpacity(0.25), width: 1.5),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: accent.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 28,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 13,
              fontStyle: FontStyle.italic,
              color: accent.withOpacity(0.85),
            ),
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}

class _Caption extends StatelessWidget {
  const _Caption(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 12.5,
          color: Color(0xFF445175),
          height: 1.35,
        ),
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.text, required this.color});
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withOpacity(0.4)),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w700,
          fontSize: 11.5,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// Custom clipper: parametric superellipse (Lamé curve)
// -----------------------------------------------------------------------------

/// Clips to a true superellipse defined by |x/a|^n + |y/b|^n = 1.
///
/// We rasterize the parametric form so the path is well-defined for all n:
///
///   x(t) = a * sign(cos t) * |cos t|^(2/n)
///   y(t) = b * sign(sin t) * |sin t|^(2/n)
///
/// for t ∈ [0, 2π).
class _SuperellipseClipper extends CustomClipper<Path> {
  _SuperellipseClipper({required this.n});

  /// The superellipse exponent. n=2 is an ellipse, n=∞ is a rectangle.
  /// Apple's iOS app icon uses n ≈ 4.5–5 (the squircle).
  final double n;

  /// Number of samples around the curve. 180 looks smooth.
  static const int samples = 180;

  @override
  Path getClip(Size size) {
    final double a = size.width / 2;
    final double b = size.height / 2;
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final Path path = Path();
    final double exponent = 2.0 / n;
    for (int i = 0; i <= samples; i++) {
      final double t = (i / samples) * 2 * math.pi;
      final double cosT = math.cos(t);
      final double sinT = math.sin(t);
      final double x =
          a * _signed(cosT) * math.pow(cosT.abs(), exponent).toDouble();
      final double y =
          b * _signed(sinT) * math.pow(sinT.abs(), exponent).toDouble();
      if (i == 0) {
        path.moveTo(cx + x, cy + y);
      } else {
        path.lineTo(cx + x, cy + y);
      }
    }
    path.close();
    return path;
  }

  static double _signed(double v) => v < 0 ? -1.0 : 1.0;

  @override
  bool shouldReclip(covariant _SuperellipseClipper oldClipper) {
    return oldClipper.n != n;
  }
}

// -----------------------------------------------------------------------------
// Custom painter: superellipse curve diagram
// -----------------------------------------------------------------------------

class _SuperellipseFamilyPainter extends CustomPainter {
  _SuperellipseFamilyPainter({required this.exponents, required this.colors});

  final List<double> exponents;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double a = size.width * 0.42;
    final double b = size.height * 0.42;

    // Axes
    final Paint axes = Paint()
      ..color = const Color(0x33333355)
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), axes);
    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), axes);

    for (int k = 0; k < exponents.length; k++) {
      final double n = exponents[k];
      final Path path = Path();
      const int samples = 240;
      for (int i = 0; i <= samples; i++) {
        final double t = (i / samples) * 2 * math.pi;
        final double cosT = math.cos(t);
        final double sinT = math.sin(t);
        final double exponent = 2.0 / n;
        final double sx = cosT < 0 ? -1.0 : 1.0;
        final double sy = sinT < 0 ? -1.0 : 1.0;
        final double x = a * sx * math.pow(cosT.abs(), exponent).toDouble();
        final double y = b * sy * math.pow(sinT.abs(), exponent).toDouble();
        if (i == 0) {
          path.moveTo(cx + x, cy + y);
        } else {
          path.lineTo(cx + x, cy + y);
        }
      }
      path.close();
      final Paint stroke = Paint()
        ..color = colors[k % colors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.4;
      canvas.drawPath(path, stroke);

      // Label.
      final TextSpan span = TextSpan(
        text: 'n=${n.toStringAsFixed(n == n.roundToDouble() ? 0 : 1)}',
        style: TextStyle(
          color: colors[k % colors.length],
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      );
      final TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(8 + k * 38.0, 8));
    }
  }

  @override
  bool shouldRepaint(covariant _SuperellipseFamilyPainter old) {
    return old.exponents != exponents || old.colors != colors;
  }
}

class _ShapeQuartetPainter extends CustomPainter {
  const _ShapeQuartetPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width / 4;
    final double h = size.height;
    final List<Color> colors = <Color>[
      const Color(0xFFE57373),
      const Color(0xFF81C784),
      const Color(0xFF64B5F6),
      const Color(0xFFBA68C8),
    ];
    final List<String> labels = <String>['rect', 'rrect', 'ellipse', 'squircle'];

    for (int i = 0; i < 4; i++) {
      final Rect r = Rect.fromLTWH(i * w + 8, 8, w - 16, h - 32);
      final Paint fill = Paint()..color = colors[i].withOpacity(0.85);
      switch (i) {
        case 0:
          canvas.drawRect(r, fill);
          break;
        case 1:
          canvas.drawRRect(
            RRect.fromRectAndRadius(r, const Radius.circular(18)),
            fill,
          );
          break;
        case 2:
          canvas.drawOval(r, fill);
          break;
        case 3:
          final Path p = Path();
          const int samples = 200;
          final double a = r.width / 2;
          final double b = r.height / 2;
          final double cx = r.center.dx;
          final double cy = r.center.dy;
          const double n = 4.5;
          const double exp2n = 2.0 / n;
          for (int j = 0; j <= samples; j++) {
            final double t = (j / samples) * 2 * math.pi;
            final double cosT = math.cos(t);
            final double sinT = math.sin(t);
            final double sx = cosT < 0 ? -1.0 : 1.0;
            final double sy = sinT < 0 ? -1.0 : 1.0;
            final double x =
                a * sx * math.pow(cosT.abs(), exp2n).toDouble();
            final double y =
                b * sy * math.pow(sinT.abs(), exp2n).toDouble();
            if (j == 0) {
              p.moveTo(cx + x, cy + y);
            } else {
              p.lineTo(cx + x, cy + y);
            }
          }
          p.close();
          canvas.drawPath(p, fill);
          break;
      }
      final TextSpan span = TextSpan(
        text: labels[i],
        style: const TextStyle(
          color: Color(0xFF263238),
          fontSize: 11,
          fontWeight: FontWeight.w700,
        ),
      );
      final TextPainter tp = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
      );
      tp.layout();
      tp.paint(canvas, Offset(i * w + (w - tp.width) / 2, h - 22));
    }
  }

  @override
  bool shouldRepaint(covariant _ShapeQuartetPainter old) => false;
}

class _AnimatedSuperellipsePainter extends CustomPainter {
  _AnimatedSuperellipsePainter({
    required this.animation,
    required this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    // Map animation 0..1 → n in [2.0, 8.0] then back; ping-pong.
    final double t = animation.value;
    final double phase = t < 0.5 ? t * 2 : (1 - t) * 2;
    final double n = 2.0 + phase * 6.0;

    final double a = size.width * 0.45;
    final double b = size.height * 0.45;
    final double cx = size.width / 2;
    final double cy = size.height / 2;

    final Path path = Path();
    const int samples = 220;
    final double exponent = 2.0 / n;
    for (int i = 0; i <= samples; i++) {
      final double tt = (i / samples) * 2 * math.pi;
      final double cosT = math.cos(tt);
      final double sinT = math.sin(tt);
      final double sx = cosT < 0 ? -1.0 : 1.0;
      final double sy = sinT < 0 ? -1.0 : 1.0;
      final double x = a * sx * math.pow(cosT.abs(), exponent).toDouble();
      final double y = b * sy * math.pow(sinT.abs(), exponent).toDouble();
      if (i == 0) {
        path.moveTo(cx + x, cy + y);
      } else {
        path.lineTo(cx + x, cy + y);
      }
    }
    path.close();
    final Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, paint);

    final TextSpan span = TextSpan(
      text: 'n = ${n.toStringAsFixed(2)}',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 13,
        fontWeight: FontWeight.w800,
      ),
    );
    final TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(cx - tp.width / 2, cy - tp.height / 2));
  }

  @override
  bool shouldRepaint(covariant _AnimatedSuperellipsePainter old) {
    return old.animation != animation || old.color != color;
  }
}

class _CurveSinglePainter extends CustomPainter {
  const _CurveSinglePainter({required this.n, required this.color});
  final double n;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final double cx = size.width / 2;
    final double cy = size.height / 2;
    final double a = size.width * 0.42;
    final double b = size.height * 0.42;

    final Paint axes = Paint()
      ..color = const Color(0x55333355)
      ..strokeWidth = 1;
    canvas.drawLine(Offset(0, cy), Offset(size.width, cy), axes);
    canvas.drawLine(Offset(cx, 0), Offset(cx, size.height), axes);

    final Path path = Path();
    const int samples = 260;
    final double exponent = 2.0 / n;
    for (int i = 0; i <= samples; i++) {
      final double t = (i / samples) * 2 * math.pi;
      final double cosT = math.cos(t);
      final double sinT = math.sin(t);
      final double sx = cosT < 0 ? -1.0 : 1.0;
      final double sy = sinT < 0 ? -1.0 : 1.0;
      final double x = a * sx * math.pow(cosT.abs(), exponent).toDouble();
      final double y = b * sy * math.pow(sinT.abs(), exponent).toDouble();
      if (i == 0) {
        path.moveTo(cx + x, cy + y);
      } else {
        path.lineTo(cx + x, cy + y);
      }
    }
    path.close();

    final Paint fill = Paint()
      ..color = color.withOpacity(0.20)
      ..style = PaintingStyle.fill;
    canvas.drawPath(path, fill);

    final Paint stroke = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.6;
    canvas.drawPath(path, stroke);

    final TextSpan span = TextSpan(
      text: 'n = ${n.toStringAsFixed(2)}',
      style: TextStyle(
        color: color,
        fontSize: 12,
        fontWeight: FontWeight.w700,
      ),
    );
    final TextPainter tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
    );
    tp.layout();
    tp.paint(canvas, Offset(8, 8));
  }

  @override
  bool shouldRepaint(covariant _CurveSinglePainter old) {
    return old.n != n || old.color != color;
  }
}

// =============================================================================
// Section 1 — Hero intro: rect vs rrect vs ellipse vs squircle
// =============================================================================

class _Section1HeroIntro extends StatelessWidget {
  const _Section1HeroIntro();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '1 · Hero — four shapes, same bounding box',
      subtitle:
          'Rect, RRect, Ellipse and Squircle laid side by side. The squircle is what '
          'ClipRSuperellipse produces: the corners do not bend like a circle, they '
          'bend like a Lamé curve.',
      accent: const Color(0xFF1F2A44),
      background: const Color(0xFFFFFFFF),
      child: StatefulBuilder(
        builder: (BuildContext ctx, void Function(void Function()) setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 130,
                child: CustomPaint(
                  painter: const _ShapeQuartetPainter(),
                  child: const SizedBox.expand(),
                ),
              ),
              const SizedBox(height: 14),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: const <Widget>[
                  _Pill(text: 'rect = corners 90°', color: Color(0xFFE57373)),
                  _Pill(text: 'rrect = circular arcs', color: Color(0xFF81C784)),
                  _Pill(text: 'ellipse = n=2', color: Color(0xFF64B5F6)),
                  _Pill(text: 'squircle = n≈4.5', color: Color(0xFFBA68C8)),
                ],
              ),
              const _Caption(
                'A rounded rectangle uses circular arcs. A *rounded superellipse* '
                '(what ClipRSuperellipse renders) uses arcs of a Lamé curve, so '
                'the curvature changes continuously from the side into the corner '
                '— there is no abrupt curvature jump where straight meets arc.',
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFFF7F8FC),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'In SwiftUI this is RoundedRectangle(cornerRadius:_, style: '
                  '.continuous). In Flutter we get the same thing via '
                  'ClipRSuperellipse → RenderClipRSuperellipse.',
                  style: TextStyle(fontSize: 12, color: Color(0xFF445175)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
// Section 2 — The squircle equation
// =============================================================================

class _Section2SquircleEquation extends StatelessWidget {
  const _Section2SquircleEquation();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '2 · The squircle equation',
      subtitle:
          '|x/a|ⁿ + |y/b|ⁿ = 1. Move n and the shape morphs from circle (n=2) '
          'to soft squircle (n=4) to almost-rectangle (n=8+).',
      accent: const Color(0xFF6A1B9A),
      background: const Color(0xFFFAF4FE),
      child: StatefulBuilder(
        builder: (BuildContext ctx, void Function(void Function()) setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1E5FA),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  'A *superellipse* is the level set of a Lp-norm. The case n=2 '
                  'is a Euclidean circle/ellipse. As n grows, the curve flattens '
                  'against the bounding box edges and stays almost straight, '
                  'rounding sharply only near the corners. The squircle (Apple '
                  'app icons) sits around n ≈ 4.5–5: it has visibly straight '
                  'sides yet *no* curvature discontinuity.',
                  style: TextStyle(fontSize: 12.5, color: Color(0xFF4A148C)),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                height: 200,
                child: CustomPaint(
                  painter: _SuperellipseFamilyPainter(
                    exponents: const <double>[2, 3, 4, 5, 8],
                    colors: const <Color>[
                      Color(0xFFE91E63),
                      Color(0xFFFF9800),
                      Color(0xFF4CAF50),
                      Color(0xFF03A9F4),
                      Color(0xFF673AB7),
                    ],
                  ),
                  child: const SizedBox.expand(),
                ),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 6,
                children: const <Widget>[
                  _Pill(text: 'n=2 → ellipse', color: Color(0xFFE91E63)),
                  _Pill(text: 'n=3 → soft', color: Color(0xFFFF9800)),
                  _Pill(text: 'n=4 → squircle', color: Color(0xFF4CAF50)),
                  _Pill(text: 'n=5 → iOS-ish', color: Color(0xFF03A9F4)),
                  _Pill(text: 'n=8 → near rect', color: Color(0xFF673AB7)),
                ],
              ),
              const _Caption(
                'The painter samples the parametric form '
                'x = a·sign(cos t)·|cos t|^(2/n), y = b·sign(sin t)·|sin t|^(2/n) '
                'for t ∈ [0, 2π) — same math _SuperellipseClipper uses to clip.',
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
// Section 3 — n-exponent slider
// =============================================================================

class _Section3NExponentSlider extends StatefulWidget {
  const _Section3NExponentSlider();

  @override
  State<_Section3NExponentSlider> createState() =>
      _Section3NExponentSliderState();
}

class _Section3NExponentSliderState extends State<_Section3NExponentSlider> {
  double _n = 4.5;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '3 · The n-exponent slider',
      subtitle:
          'Drag n and watch a real ClipPath(_SuperellipseClipper(n)) clip the '
          'gradient on the left, while the diagram on the right plots the '
          'underlying Lamé curve.',
      accent: const Color(0xFF00897B),
      background: const Color(0xFFE9F7F4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: ClipPath(
                    clipper: _SuperellipseClipper(n: _n),
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: <Color>[
                            Color(0xFF00C9A7),
                            Color(0xFF26C6DA),
                            Color(0xFF7E57C2),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'n = ${_n.toStringAsFixed(2)}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: AspectRatio(
                  aspectRatio: 1.0,
                  child: CustomPaint(
                    painter: _CurveSinglePainter(
                      n: _n,
                      color: const Color(0xFF00897B),
                    ),
                    child: const SizedBox.expand(),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: <Widget>[
              const Text('2.0', style: TextStyle(fontSize: 11)),
              Expanded(
                child: Slider(
                  value: _n,
                  min: 2.0,
                  max: 10.0,
                  divisions: 80,
                  label: _n.toStringAsFixed(2),
                  activeColor: const Color(0xFF00897B),
                  onChanged: (double v) => setState(() => _n = v),
                ),
              ),
              const Text('10.0', style: TextStyle(fontSize: 11)),
            ],
          ),
          Wrap(
            spacing: 8,
            runSpacing: 6,
            children: <Widget>[
              for (final double preset in const <double>[2, 3, 4, 4.5, 5, 6, 8])
                ActionChip(
                  label: Text('n=${preset.toString()}'),
                  onPressed: () => setState(() => _n = preset),
                  backgroundColor: const Color(0xFFB2DFDB),
                ),
            ],
          ),
          const _Caption(
            'Note: at n=2 the left tile is a perfect ellipse; at n→∞ it would '
            'fill the bounding box. ClipRSuperellipse picks a fixed shape '
            'matching iOS continuous corners — to *interactively* explore the '
            'family we use a custom CustomClipper<Path> here.',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 4 — Border radius slider with ClipRSuperellipse
// =============================================================================

class _Section4BorderRadiusSlider extends StatefulWidget {
  const _Section4BorderRadiusSlider();

  @override
  State<_Section4BorderRadiusSlider> createState() =>
      _Section4BorderRadiusSliderState();
}

class _Section4BorderRadiusSliderState
    extends State<_Section4BorderRadiusSlider> {
  double _radius = 32;

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '4 · Border-radius slider (real ClipRSuperellipse)',
      subtitle:
          'ClipRSuperellipse interpolates between a square (radius 0) and a '
          'pill / squircle as the border radius grows. Compared with ClipRRect, '
          'corners blend smoother into the sides.',
      accent: const Color(0xFFEF6C00),
      background: const Color(0xFFFFF4E6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    const Text(
                      'ClipRSuperellipse',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRSuperellipse(
                        borderRadius: BorderRadius.circular(_radius),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFFFFB300),
                                Color(0xFFFF7043),
                                Color(0xFFD81B60),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'r=${_radius.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  children: <Widget>[
                    const Text(
                      'ClipRRect (circular)',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 6),
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(_radius),
                        child: Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: <Color>[
                                Color(0xFF66BB6A),
                                Color(0xFF26A69A),
                                Color(0xFF42A5F5),
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'r=${_radius.toStringAsFixed(0)}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: <Widget>[
              const Text('0', style: TextStyle(fontSize: 11)),
              Expanded(
                child: Slider(
                  value: _radius,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: _radius.toStringAsFixed(0),
                  activeColor: const Color(0xFFEF6C00),
                  onChanged: (double v) => setState(() => _radius = v),
                ),
              ),
              const Text('100', style: TextStyle(fontSize: 11)),
            ],
          ),
          const _Caption(
            'At small radii the two clippers are almost indistinguishable. As '
            'radius grows past ~30% of width, the squircle on the left keeps '
            'visibly straight sides while ClipRRect rounds aggressively.',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 5 — Gallery of squircle widgets
// =============================================================================

class _Section5SquircleGallery extends StatelessWidget {
  const _Section5SquircleGallery();

  @override
  Widget build(BuildContext context) {
    final List<_GalleryEntry> entries = <_GalleryEntry>[
      _GalleryEntry(
        n: 2.0,
        title: 'Ellipse',
        gradient: const <Color>[Color(0xFFEF5350), Color(0xFFEC407A)],
      ),
      _GalleryEntry(
        n: 3.0,
        title: 'Soft squircle',
        gradient: const <Color>[Color(0xFFAB47BC), Color(0xFF7E57C2)],
      ),
      _GalleryEntry(
        n: 4.0,
        title: 'Squircle',
        gradient: const <Color>[Color(0xFF42A5F5), Color(0xFF26C6DA)],
      ),
      _GalleryEntry(
        n: 4.5,
        title: 'iOS app icon',
        gradient: const <Color>[Color(0xFF26A69A), Color(0xFF66BB6A)],
      ),
      _GalleryEntry(
        n: 6.0,
        title: 'Sharp squircle',
        gradient: const <Color>[Color(0xFFFFA726), Color(0xFFFFEB3B)],
      ),
      _GalleryEntry(
        n: 8.0,
        title: 'Near rectangle',
        gradient: const <Color>[Color(0xFF8D6E63), Color(0xFFBCAAA4)],
      ),
    ];

    return _SectionShell(
      title: '5 · Gallery — six clipped tiles',
      subtitle:
          'Each tile uses _SuperellipseClipper(n) at a different exponent. The '
          'caption shows whether the result reads as ellipse, squircle or near '
          'rectangle.',
      accent: const Color(0xFFC2185B),
      background: const Color(0xFFFFF3F8),
      child: StatefulBuilder(
        builder: (BuildContext ctx, void Function(void Function()) setState) {
          return GridView.count(
            crossAxisCount: 3,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
            children: <Widget>[
              for (final _GalleryEntry e in entries)
                Column(
                  children: <Widget>[
                    Expanded(
                      child: ClipPath(
                        clipper: _SuperellipseClipper(n: e.n),
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: e.gradient,
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            'n=${e.n}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      e.title,
                      style: const TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
            ],
          );
        },
      ),
    );
  }
}

class _GalleryEntry {
  const _GalleryEntry({
    required this.n,
    required this.title,
    required this.gradient,
  });
  final double n;
  final String title;
  final List<Color> gradient;
}

// =============================================================================
// Section 6 — Animated squircle morph
// =============================================================================

class _Section6AnimatedMorph extends StatefulWidget {
  const _Section6AnimatedMorph();

  @override
  State<_Section6AnimatedMorph> createState() => _Section6AnimatedMorphState();
}

class _Section6AnimatedMorphState extends State<_Section6AnimatedMorph>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctl;

  @override
  void initState() {
    super.initState();
    _ctl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '6 · Animated morph',
      subtitle:
          'AnimationController sweeps n from 2 → 8 → 2 in a 4-second loop. The '
          'painter uses super(repaint: animation) so we only repaint the canvas, '
          'not the whole subtree.',
      accent: const Color(0xFF1565C0),
      background: const Color(0xFFE6F0FB),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16 / 7,
            child: CustomPaint(
              painter: _AnimatedSuperellipsePainter(
                animation: _ctl,
                color: const Color(0xFF1565C0),
              ),
              child: const SizedBox.expand(),
            ),
          ),
          const SizedBox(height: 10),
          const _Caption(
            'In a real production widget you would back this animation with '
            'ClipRSuperellipse(borderRadius: …) inside an AnimatedBuilder, but '
            'because ClipRSuperellipse exposes radius (not n) we use a custom '
            'painter to demonstrate the *exponent* axis.',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 7 — Comparison panel
// =============================================================================

class _Section7ClipComparison extends StatelessWidget {
  const _Section7ClipComparison();

  @override
  Widget build(BuildContext context) {
    final Widget gradientChild = Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            Color(0xFFFFCC80),
            Color(0xFFEF5350),
            Color(0xFF8E24AA),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        'Clip',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    );

    return _SectionShell(
      title: '7 · ClipRect / ClipRRect / ClipOval / ClipRSuperellipse',
      subtitle:
          'Same gradient child, four different clip widgets. The caption '
          'highlights when each one is the right tool.',
      accent: const Color(0xFF455A64),
      background: const Color(0xFFECEFF1),
      child: StatefulBuilder(
        builder: (BuildContext ctx, void Function(void Function()) setState) {
          return Column(
            children: <Widget>[
              GridView.count(
                crossAxisCount: 4,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.9,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: ClipRect(child: gradientChild),
                      ),
                      const Text('ClipRect', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: gradientChild,
                        ),
                      ),
                      const Text('ClipRRect', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: ClipOval(child: gradientChild),
                      ),
                      const Text('ClipOval', style: TextStyle(fontSize: 11)),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Expanded(
                        child: ClipRSuperellipse(
                          borderRadius: BorderRadius.circular(28),
                          child: gradientChild,
                        ),
                      ),
                      const Text('ClipRSuperellipse',
                          style: TextStyle(fontSize: 10.5)),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFCFD8DC)),
                ),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'When to use which',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF263238),
                      ),
                    ),
                    SizedBox(height: 6),
                    Text('• ClipRect — strictly rectangular bounds.',
                        style: TextStyle(fontSize: 12)),
                    Text('• ClipRRect — typical rounded rect, circular arcs.',
                        style: TextStyle(fontSize: 12)),
                    Text('• ClipOval — perfect ellipse / circle.',
                        style: TextStyle(fontSize: 12)),
                    Text(
                      '• ClipRSuperellipse — iOS-style continuous corners; '
                      'use when the radius is a substantial fraction of the '
                      'shorter side and you want zero curvature jump.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
// Section 8 — iOS app-icon style
// =============================================================================

class _Section8AppIconStyle extends StatelessWidget {
  const _Section8AppIconStyle();

  @override
  Widget build(BuildContext context) {
    final List<_FakeIcon> icons = <_FakeIcon>[
      _FakeIcon(
        bg: const <Color>[Color(0xFF42A5F5), Color(0xFF1976D2)],
        icon: Icons.message,
        label: 'Messages',
      ),
      _FakeIcon(
        bg: const <Color>[Color(0xFFFFA726), Color(0xFFEF6C00)],
        icon: Icons.calendar_today,
        label: 'Calendar',
      ),
      _FakeIcon(
        bg: const <Color>[Color(0xFFEF5350), Color(0xFFC62828)],
        icon: Icons.music_note,
        label: 'Music',
      ),
      _FakeIcon(
        bg: const <Color>[Color(0xFF66BB6A), Color(0xFF2E7D32)],
        icon: Icons.notes,
        label: 'Notes',
      ),
      _FakeIcon(
        bg: const <Color>[Color(0xFFAB47BC), Color(0xFF6A1B9A)],
        icon: Icons.camera_alt,
        label: 'Camera',
      ),
      _FakeIcon(
        bg: const <Color>[Color(0xFF26C6DA), Color(0xFF00838F)],
        icon: Icons.cloud,
        label: 'Weather',
      ),
    ];

    return _SectionShell(
      title: '8 · iOS app-icon style',
      subtitle:
          'iOS app icons live around n ≈ 4.5–5. Below: six fake icons clipped '
          'with ClipRSuperellipse and a ~22% radius — a credible Springboard '
          'lookalike.',
      accent: const Color(0xFF455A64),
      background: const Color(0xFFFAFAFA),
      child: GridView.count(
        crossAxisCount: 3,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.85,
        children: <Widget>[
          for (final _FakeIcon i in icons)
            Column(
              children: <Widget>[
                Expanded(
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: ClipRSuperellipse(
                      borderRadius: BorderRadius.circular(22),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: i.bg,
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Icon(i.icon, color: Colors.white, size: 36),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(i.label, style: const TextStyle(fontSize: 11)),
              ],
            ),
        ],
      ),
    );
  }
}

class _FakeIcon {
  const _FakeIcon({
    required this.bg,
    required this.icon,
    required this.label,
  });
  final List<Color> bg;
  final IconData icon;
  final String label;
}

// =============================================================================
// Section 9 — Performance card
// =============================================================================

class _Section9PerformanceCard extends StatelessWidget {
  const _Section9PerformanceCard();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '9 · Performance notes',
      subtitle:
          'How RenderClipRSuperellipse fits into the render tree and what to '
          'avoid in lists and scroll views.',
      accent: const Color(0xFFB71C1C),
      background: const Color(0xFFFFEBEE),
      child: StatefulBuilder(
        builder: (BuildContext ctx, void Function(void Function()) setState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Text(
                'Clip behaviors',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFB71C1C),
                ),
              ),
              SizedBox(height: 6),
              Text(
                '• Clip.hardEdge — fastest, no AA, jagged on diagonals.\n'
                '• Clip.antiAlias — default; smooth edges, cheap.\n'
                '• Clip.antiAliasWithSaveLayer — uses an offscreen layer; '
                'lets the child blend correctly when it has its own opacity '
                'or save layers, but doubles the pixel work.\n'
                '• Clip.none — disables the clip but keeps the render object, '
                'useful only for transient flicker reasons.',
                style: TextStyle(fontSize: 12.5, height: 1.4),
              ),
              SizedBox(height: 12),
              Text(
                'Rules of thumb',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFFB71C1C),
                ),
              ),
              SizedBox(height: 6),
              Text(
                '• Prefer ShapeDecoration / Material(shape:) over a clip when '
                'you only need the silhouette of the *background*. A clip '
                'forces the engine to mask pixels; a decoration just paints.\n'
                '• Avoid ClipPath with a complex CustomClipper on every list '
                'item — recomputing 200 sample paths per frame is wasteful. '
                'Cache the path or use a const clipper instance.\n'
                '• ClipRSuperellipse delegates to RSuperellipse in the '
                'engine, so it is cheaper than a fully custom Path.\n'
                '• Avoid Clip.antiAliasWithSaveLayer unless you have a '
                'concrete blending bug — save layers are expensive.',
                style: TextStyle(fontSize: 12.5, height: 1.4),
              ),
            ],
          );
        },
      ),
    );
  }
}

// =============================================================================
// Section 10 — Real-life recipes
// =============================================================================

class _Section10RealLifeRecipes extends StatelessWidget {
  const _Section10RealLifeRecipes();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '10 · Real-life recipes',
      subtitle:
          'Three small but realistic UI snippets — avatar, hero card, action '
          'button — all using ClipRSuperellipse so corners feel iOS-correct.',
      accent: const Color(0xFF2E7D32),
      background: const Color(0xFFE9F5EA),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Recipe 1: avatar.
          Row(
            children: <Widget>[
              ClipRSuperellipse(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFF66BB6A), Color(0xFF1B5E20)],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'TK',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Squircle avatar',
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    Text(
                      'A 60×60 squircle reads as “a person” without looking '
                      'like a circular profile photo. Useful for chat bubbles '
                      'where corners must align with surrounding cards.',
                      style: TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Recipe 2: hero card.
          ClipRSuperellipse(
            borderRadius: BorderRadius.circular(28),
            child: Container(
              height: 130,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[
                    Color(0xFF80CBC4),
                    Color(0xFF26A69A),
                    Color(0xFF00897B),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: const EdgeInsets.all(20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Squircle hero card',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '“Continuous” corners blend smoothly with the gradient '
                    'edge — no visible curvature jump.',
                    style: TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Recipe 3: action button.
          Row(
            children: <Widget>[
              ClipRSuperellipse(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[Color(0xFF1B5E20), Color(0xFF2E7D32)],
                    ),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Confirm',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              ClipRSuperellipse(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: const Color(0xFF2E7D32)),
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      color: Color(0xFF1B5E20),
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const _Caption(
            'For the buttons: prefer Material(shape: …, color: …) in '
            'production so ink ripples follow the squircle silhouette.',
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// Section 11 — Decision card
// =============================================================================

class _Section11DecisionCard extends StatelessWidget {
  const _Section11DecisionCard();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '11 · Decision card — which clipper / which shape?',
      subtitle:
          'A quick chooser between ClipRSuperellipse, ClipRRect with high '
          'radius, and ShapeBorder + Material.',
      accent: const Color(0xFF4527A0),
      background: const Color(0xFFEDE7F6),
      child: Column(
        children: <Widget>[
          _decisionRow(
            'You want iOS-style continuous corners on a card or icon',
            'ClipRSuperellipse(borderRadius: BorderRadius.circular(R))',
            const Color(0xFF4527A0),
          ),
          _decisionRow(
            'You only need a soft rounded rectangle, performance critical',
            'ClipRRect(borderRadius: BorderRadius.circular(R))',
            const Color(0xFF4527A0),
          ),
          _decisionRow(
            'You need ink ripples to follow the silhouette',
            'Material(shape: ContinuousRectangleBorder(borderRadius: ...))',
            const Color(0xFF4527A0),
          ),
          _decisionRow(
            'You need a *true* superellipse (custom n)',
            'ClipPath(clipper: _SuperellipseClipper(n: …))',
            const Color(0xFF4527A0),
          ),
          _decisionRow(
            'You only need to paint the silhouette (no clipping)',
            'Container(decoration: ShapeDecoration(shape: ...))',
            const Color(0xFF4527A0),
          ),
        ],
      ),
    );
  }

  Widget _decisionRow(String when, String pick, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.lightbulb, color: color, size: 18),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  when,
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 12.5,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  pick,
                  style: TextStyle(
                    color: color,
                    fontFamily: 'monospace',
                    fontSize: 12,
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
// Section 12 — Reference table of n values
// =============================================================================

class _Section12ReferenceTable extends StatelessWidget {
  const _Section12ReferenceTable();

  @override
  Widget build(BuildContext context) {
    final List<_NRef> rows = <_NRef>[
      _NRef(n: 2.0, label: 'Ellipse / circle', note: 'Pure Euclidean.'),
      _NRef(n: 2.5, label: 'Soft', note: 'Slightly squared ellipse.'),
      _NRef(n: 3.0, label: 'Soft squircle', note: 'Used in some Android UIs.'),
      _NRef(n: 4.0, label: 'Squircle', note: 'Lamé\'s original squircle.'),
      _NRef(n: 4.5, label: 'iOS app icon', note: 'SwiftUI .continuous default.'),
      _NRef(n: 5.0, label: 'Sharper iOS', note: 'Some Apple buttons.'),
      _NRef(n: 6.0, label: 'Tight squircle', note: 'Reads as “rounded square”.'),
      _NRef(n: 8.0, label: 'Near-rect', note: 'Almost imperceptible curve.'),
      _NRef(n: 16.0, label: 'Effectively rect', note: 'Edge AA only.'),
    ];

    return _SectionShell(
      title: '12 · Reference table of n values',
      subtitle:
          'A cheat-sheet of common n exponents and what they look like. Use '
          'with the slider in section 3 for a live cross-reference.',
      accent: const Color(0xFF37474F),
      background: const Color(0xFFFFFFFF),
      child: Column(
        children: <Widget>[
          for (final _NRef r in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: ClipPath(
                      clipper: _SuperellipseClipper(n: r.n),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: <Color>[
                              Color(0xFF455A64),
                              Color(0xFF263238),
                            ],
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          r.n.toStringAsFixed(1),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          r.label,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          r.note,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF445175),
                          ),
                        ),
                      ],
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

class _NRef {
  const _NRef({required this.n, required this.label, required this.note});
  final double n;
  final String label;
  final String note;
}

// =============================================================================
// Section 13 — Footer / references
// =============================================================================

class _Section13Footer extends StatelessWidget {
  const _Section13Footer();

  @override
  Widget build(BuildContext context) {
    return _SectionShell(
      title: '13 · References',
      subtitle: 'Where to dig deeper into superellipses and Flutter clipping.',
      accent: const Color(0xFF263238),
      background: const Color(0xFFF5F5F5),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Flutter SDK',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 4),
          Text(
            '• packages/flutter/lib/src/widgets/basic.dart → ClipRSuperellipse\n'
            '• packages/flutter/lib/src/rendering/proxy_box.dart → '
            'RenderClipRSuperellipse, _RenderCustomClip<RSuperellipse>\n'
            '• dart:ui → RSuperellipse (engine geometry primitive).',
            style: TextStyle(fontSize: 12, height: 1.4),
          ),
          SizedBox(height: 10),
          Text(
            'Math',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 4),
          Text(
            '• Lamé curve, also called a superellipse (Piet Hein, 1959).\n'
            '• Squircle: a special case with n = 4.\n'
            '• SwiftUI: RoundedRectangle(cornerRadius:_, style: .continuous) '
            'is the same family as ClipRSuperellipse with matching radius.',
            style: TextStyle(fontSize: 12, height: 1.4),
          ),
          SizedBox(height: 10),
          Text(
            'See also in this demo',
            style: TextStyle(fontWeight: FontWeight.w800),
          ),
          SizedBox(height: 4),
          Text(
            '• Section 3 — interactive n slider.\n'
            '• Section 4 — interactive border-radius slider over real '
            'ClipRSuperellipse.\n'
            '• Section 8 — fake iOS Springboard with ClipRSuperellipse.',
            style: TextStyle(fontSize: 12, height: 1.4),
          ),
        ],
      ),
    );
  }
}

// =============================================================================
// End of file.
// =============================================================================
