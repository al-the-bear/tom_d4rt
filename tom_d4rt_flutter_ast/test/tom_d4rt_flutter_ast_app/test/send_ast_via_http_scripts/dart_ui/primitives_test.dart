// D4rt test script: Deep Demo - dart:ui Primitives Atlas
// A comprehensive, manually authored visual tour of the low-level rendering
// primitives in dart:ui: Color, Offset, Size, Rect, RRect, Radius, Paint,
// Path, BlendMode, Gradient (dart:ui), ImageFilter, ColorFilter, MaskFilter.
//
// The intent is to show each primitive multiple ways:
//   1. Constructed in many shapes / via factory constructors.
//   2. Manipulated using operators (+, -, *, &, |, etc.) where defined.
//   3. Probed via properties (width, height, dx, dy, center, ...).
//   4. Rendered onto a Canvas via dedicated CustomPainter classes so the
//      reader can SEE what the primitive means visually.
//
// The script is interpreted by D4rt via the SendTestRunner harness.

import 'dart:math' as math;
import 'dart:ui' as ui;

import 'package:flutter/material.dart';

// ============================================================================
// PALETTE
// ============================================================================
// A small set of named colours used across all sections, so the demo has a
// cohesive look despite touching many different primitives.

const Color kInk = Color(0xFF1B1F23);
const Color kPaper = Color(0xFFF6F7FB);
const Color kCanvasBg = Color(0xFFFBFCFE);
const Color kBorderSoft = Color(0xFFE3E7EF);
const Color kTextMuted = Color(0xFF5A6675);
const Color kAccentBlue = Color(0xFF3563E9);
const Color kAccentPink = Color(0xFFE94586);
const Color kAccentLime = Color(0xFF7BD13B);
const Color kAccentSun = Color(0xFFFFB020);
const Color kAccentTeal = Color(0xFF00B7C2);
const Color kAccentPlum = Color(0xFF8A5BFF);
const Color kBandRed = Color(0xFFFF5252);
const Color kBandOrange = Color(0xFFFF9800);
const Color kBandYellow = Color(0xFFFFEB3B);
const Color kBandGreen = Color(0xFF4CAF50);
const Color kBandBlue = Color(0xFF2196F3);
const Color kBandIndigo = Color(0xFF3F51B5);
const Color kBandViolet = Color(0xFF9C27B0);

// ============================================================================
// BUILD ROOT
// ============================================================================

dynamic build(BuildContext context) {
  return Scaffold(
    backgroundColor: kPaper,
    body: SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _Hero(),
            const SizedBox(height: 24.0),
            _IntroCard(),
            const SizedBox(height: 28.0),
            _SectionDivider(label: 'I  -  Color', accent: kAccentBlue),
            const SizedBox(height: 16.0),
            _ColorSection(),
            const SizedBox(height: 28.0),
            _SectionDivider(label: 'II  -  Offset', accent: kAccentPink),
            const SizedBox(height: 16.0),
            _OffsetSection(),
            const SizedBox(height: 28.0),
            _SectionDivider(label: 'III  -  Size', accent: kAccentLime),
            const SizedBox(height: 16.0),
            _SizeSection(),
            const SizedBox(height: 28.0),
            _SectionDivider(label: 'IV  -  Rect', accent: kAccentSun),
            const SizedBox(height: 16.0),
            _RectSection(),
            const SizedBox(height: 28.0),
            _SectionDivider(label: 'V  -  Radius & RRect', accent: kAccentTeal),
            const SizedBox(height: 16.0),
            _RRectSection(),
            const SizedBox(height: 28.0),
            _SectionDivider(label: 'VI  -  Paint', accent: kAccentPlum),
            const SizedBox(height: 16.0),
            _PaintSection(),
            const SizedBox(height: 28.0),
            _SectionDivider(label: 'VII  -  Path', accent: kBandIndigo),
            const SizedBox(height: 16.0),
            _PathSection(),
            const SizedBox(height: 28.0),
            _SectionDivider(label: 'VIII  -  BlendMode', accent: kBandRed),
            const SizedBox(height: 16.0),
            _BlendModeSection(),
            const SizedBox(height: 28.0),
            _SectionDivider(label: 'IX  -  Gradient', accent: kBandOrange),
            const SizedBox(height: 16.0),
            _GradientSection(),
            const SizedBox(height: 28.0),
            _SectionDivider(label: 'X  -  Filters', accent: kBandViolet),
            const SizedBox(height: 16.0),
            _FilterSection(),
            const SizedBox(height: 28.0),
            _SectionDivider(label: 'XI  -  Glossary', accent: kInk),
            const SizedBox(height: 16.0),
            _GlossarySection(),
            const SizedBox(height: 28.0),
            _Footer(),
          ],
        ),
      ),
    ),
  );
}

// ============================================================================
// COMMON BUILDING BLOCKS
// ============================================================================

class _Hero extends StatelessWidget {
  const _Hero();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 28.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[Color(0xFF11203A), Color(0xFF3563E9)],
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: const Color(0xFF11203A).withValues(alpha: 0.25),
            blurRadius: 24.0,
            offset: const Offset(0.0, 12.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Text(
                  'dart:ui  -  deep demo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                    letterSpacing: 1.2,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 4.0,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Text(
                  '13 primitives',
                  style: TextStyle(color: Colors.white70, fontSize: 11.0),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18.0),
          const Text(
            'Primitives Atlas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30.0,
              fontWeight: FontWeight.w800,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 6.0),
          Text(
            'Color, Offset, Size, Rect, RRect, Radius, Paint, Path, '
            'BlendMode, Gradient, ImageFilter, ColorFilter, MaskFilter',
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.78),
              fontSize: 13.5,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 16.0),
          Row(
            children: <Widget>[
              _heroStat('sections', '11'),
              const SizedBox(width: 10.0),
              _heroStat('painters', '14'),
              const SizedBox(width: 10.0),
              _heroStat('canvas ops', 'many'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroStat(String label, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withValues(alpha: 0.7),
              fontSize: 10.0,
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroCard extends StatelessWidget {
  const _IntroCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: kBorderSoft),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'About this script',
            style: TextStyle(
              fontSize: 15.0,
              fontWeight: FontWeight.w700,
              color: kInk,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            'Every section below introduces one primitive from dart:ui, '
            'lists the constructors and operators that matter, then renders '
            'a small playground via CustomPaint so the meaning is visible. '
            'No animations, no I/O - just shape, colour, and geometry.',
            style: TextStyle(
              fontSize: 13.0,
              height: 1.55,
              color: kTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionDivider extends StatelessWidget {
  const _SectionDivider({required this.label, required this.accent});

  final String label;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(width: 6.0, height: 22.0, color: accent),
        const SizedBox(width: 10.0),
        Text(
          label,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w800,
            color: kInk,
            letterSpacing: -0.3,
          ),
        ),
        const SizedBox(width: 10.0),
        Expanded(
          child: Container(
            height: 1.0,
            color: accent.withValues(alpha: 0.18),
          ),
        ),
      ],
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.title, required this.subtitle, required this.child});

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: kBorderSoft),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: kInk.withValues(alpha: 0.04),
            blurRadius: 12.0,
            offset: const Offset(0.0, 4.0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              fontSize: 14.5,
              fontWeight: FontWeight.w700,
              color: kInk,
            ),
          ),
          const SizedBox(height: 4.0),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 12.0, color: kTextMuted, height: 1.4),
          ),
          const SizedBox(height: 14.0),
          child,
        ],
      ),
    );
  }
}

class _CodeChip extends StatelessWidget {
  const _CodeChip(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F8),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: kBorderSoft),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11.0,
          color: kInk,
        ),
      ),
    );
  }
}

// ============================================================================
// SECTION V  -  RADIUS & RRECT
// ============================================================================

class _RRectSection extends StatelessWidget {
  const _RRectSection();

  @override
  Widget build(BuildContext context) {
    const Radius r0 = Radius.zero;
    const Radius r1 = Radius.circular(12.0);
    const Radius r2 = Radius.elliptical(24.0, 8.0);

    final List<List<String>> facts = <List<String>>[
      <String>['Radius.zero', '${r0.x}, ${r0.y}'],
      <String>['Radius.circular(12)', '${r1.x}, ${r1.y}'],
      <String>['Radius.elliptical(24, 8)', '${r2.x}, ${r2.y}'],
      <String>['r1 + r2', '${(r1 + r2).x}, ${(r1 + r2).y}'],
      <String>['r2 * 2', '${(r2 * 2.0).x}, ${(r2 * 2.0).y}'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Card(
          title: 'Radius arithmetic',
          subtitle: 'Radius supports +, -, *, / and unary -.',
          child: Column(
            children: List<Widget>.generate(facts.length, (int i) {
              final List<String> f = facts[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 6.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: i.isEven ? const Color(0xFFF7F8FC) : Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: kBorderSoft),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 200.0,
                      child: Text(
                        f[0],
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.0,
                          color: kInk,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        f[1],
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.0,
                          color: kAccentTeal,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'RRect grid',
          subtitle:
              'Twelve rounded rectangles. Same base Rect, different Radius. '
              'Uses RRect.fromRectAndRadius and RRect.fromRectAndCorners.',
          child: SizedBox(
            height: 280.0,
            child: CustomPaint(
              painter: _RRectGridPainter(),
              size: const Size(double.infinity, 280.0),
            ),
          ),
        ),
      ],
    );
  }
}

class _RRectGridPainter extends CustomPainter {
  const _RRectGridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const int cols = 4;
    const int rows = 3;
    final double cellW = size.width / cols;
    final double cellH = size.height / rows;
    final List<double> radii = <double>[
      0.0, 4.0, 8.0, 12.0,
      16.0, 22.0, 30.0, 40.0,
      // Last row: asymmetric corners
      -1.0, -2.0, -3.0, -4.0,
    ];
    for (int i = 0; i < radii.length; i++) {
      final int col = i % cols;
      final int row = i ~/ cols;
      final Rect cell = Rect.fromLTWH(
        col * cellW + 10.0,
        row * cellH + 10.0,
        cellW - 20.0,
        cellH - 20.0,
      );
      final Color fill = Color.lerp(kAccentTeal, kAccentPlum, i / 11.0)!;
      RRect rrect;
      if (radii[i] >= 0.0) {
        rrect = RRect.fromRectAndRadius(cell, Radius.circular(radii[i]));
      } else {
        // Asymmetric corner demo for the last row.
        final int variant = (-radii[i]).toInt();
        switch (variant) {
          case 1:
            rrect = RRect.fromRectAndCorners(
              cell,
              topLeft: const Radius.circular(28.0),
              bottomRight: const Radius.circular(28.0),
            );
            break;
          case 2:
            rrect = RRect.fromRectAndCorners(
              cell,
              topRight: const Radius.circular(28.0),
              bottomLeft: const Radius.circular(28.0),
            );
            break;
          case 3:
            rrect = RRect.fromRectAndCorners(
              cell,
              topLeft: const Radius.elliptical(40.0, 16.0),
              bottomRight: const Radius.elliptical(40.0, 16.0),
            );
            break;
          default:
            rrect = RRect.fromRectAndCorners(
              cell,
              topLeft: const Radius.circular(40.0),
              topRight: const Radius.circular(4.0),
              bottomLeft: const Radius.circular(4.0),
              bottomRight: const Radius.circular(40.0),
            );
        }
      }
      canvas.drawRRect(rrect, Paint()..color = fill.withValues(alpha: 0.85));
      canvas.drawRRect(
        rrect,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = kInk.withValues(alpha: 0.15)
          ..strokeWidth = 1.0,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: radii[i] >= 0.0 ? 'r=${radii[i].toInt()}' : 'asym',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 11.0,
            fontWeight: FontWeight.w700,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(
        canvas,
        Offset(
          cell.left + 8.0,
          cell.top + 8.0,
        ),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// SECTION VI  -  PAINT
// ============================================================================

class _PaintSection extends StatelessWidget {
  const _PaintSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Card(
          title: 'Stroke vs fill',
          subtitle:
              'PaintingStyle.fill and PaintingStyle.stroke change how a Paint '
              'renders the same shape.',
          child: SizedBox(
            height: 160.0,
            child: CustomPaint(
              painter: _PaintStylePainter(),
              size: const Size(double.infinity, 160.0),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'StrokeCap and StrokeJoin',
          subtitle:
              'Three caps (butt, round, square) and three joins '
              '(miter, round, bevel) on identical paths.',
          child: SizedBox(
            height: 220.0,
            child: CustomPaint(
              painter: _StrokeStylesPainter(),
              size: const Size(double.infinity, 220.0),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'Stroke widths',
          subtitle: 'Eight progressively thicker strokes; same colour, same path.',
          child: SizedBox(
            height: 160.0,
            child: CustomPaint(
              painter: _StrokeWidthPainter(),
              size: const Size(double.infinity, 160.0),
            ),
          ),
        ),
      ],
    );
  }
}

class _PaintStylePainter extends CustomPainter {
  const _PaintStylePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double cellW = size.width / 3.0;
    const double cy = 80.0;
    final List<String> labels = <String>['fill', 'stroke', 'stroke + fill'];
    for (int i = 0; i < 3; i++) {
      final Offset center = Offset(cellW * i + cellW / 2.0, cy);
      final Rect rect = Rect.fromCenter(center: center, width: 90.0, height: 90.0);
      switch (i) {
        case 0:
          canvas.drawRect(rect, Paint()..color = kAccentPlum);
          break;
        case 1:
          canvas.drawRect(
            rect,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4.0
              ..color = kAccentPlum,
          );
          break;
        case 2:
          canvas.drawRect(
            rect,
            Paint()..color = kAccentPlum.withValues(alpha: 0.35),
          );
          canvas.drawRect(
            rect,
            Paint()
              ..style = PaintingStyle.stroke
              ..strokeWidth = 4.0
              ..color = kAccentPlum,
          );
          break;
      }
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(
            color: kInk,
            fontSize: 12.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(center.dx - tp.width / 2.0, center.dy + 60.0));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StrokeStylesPainter extends CustomPainter {
  const _StrokeStylesPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final List<StrokeCap> caps = <StrokeCap>[
      StrokeCap.butt,
      StrokeCap.round,
      StrokeCap.square,
    ];
    final List<String> capLabels = <String>['butt', 'round', 'square'];
    final List<StrokeJoin> joins = <StrokeJoin>[
      StrokeJoin.miter,
      StrokeJoin.round,
      StrokeJoin.bevel,
    ];
    final List<String> joinLabels = <String>['miter', 'round', 'bevel'];

    final double col = size.width / 3.0;

    // Top row: caps.
    for (int i = 0; i < caps.length; i++) {
      final double x = col * i + col / 2.0;
      final Paint p = Paint()
        ..color = kAccentPlum
        ..strokeWidth = 16.0
        ..strokeCap = caps[i];
      canvas.drawLine(Offset(x - 30.0, 50.0), Offset(x + 30.0, 50.0), p);
      _label(canvas, capLabels[i], Offset(x, 78.0));
    }
    // Bottom row: joins (chevrons).
    for (int i = 0; i < joins.length; i++) {
      final double x = col * i + col / 2.0;
      final Paint p = Paint()
        ..color = kAccentTeal
        ..style = PaintingStyle.stroke
        ..strokeWidth = 10.0
        ..strokeJoin = joins[i];
      final Path path = Path()
        ..moveTo(x - 30.0, 170.0)
        ..lineTo(x, 130.0)
        ..lineTo(x + 30.0, 170.0);
      canvas.drawPath(path, p);
      _label(canvas, joinLabels[i], Offset(x, 195.0));
    }
  }

  static void _label(Canvas canvas, String text, Offset pos) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: kInk, fontSize: 11.0),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(pos.dx - tp.width / 2.0, pos.dy));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StrokeWidthPainter extends CustomPainter {
  const _StrokeWidthPainter();

  @override
  void paint(Canvas canvas, Size size) {
    const int n = 8;
    final double rowH = size.height / (n + 1);
    for (int i = 0; i < n; i++) {
      final double width = 1.0 + i * 2.5;
      final double y = rowH * (i + 1);
      final Paint p = Paint()
        ..color = Color.lerp(kAccentBlue, kAccentPlum, i / (n - 1))!
        ..strokeWidth = width
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(Offset(20.0, y), Offset(size.width - 60.0, y), p);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: '${width.toStringAsFixed(1)}px',
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 10.0,
            color: kTextMuted,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(size.width - 50.0, y - tp.height / 2.0));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// SECTION VII  -  PATH
// ============================================================================

class _PathSection extends StatelessWidget {
  const _PathSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Card(
          title: 'Building paths',
          subtitle:
              'moveTo, lineTo, quadraticBezierTo, cubicTo, arcTo, addOval, '
              'addRect, addPolygon, close.',
          child: SizedBox(
            height: 240.0,
            child: CustomPaint(
              painter: _PathBuilderPainter(),
              size: const Size(double.infinity, 240.0),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'Path combine ops',
          subtitle:
              'Path.combine with union, intersect, difference and xor on two '
              'overlapping circles.',
          child: SizedBox(
            height: 200.0,
            child: CustomPaint(
              painter: _PathCombinePainter(),
              size: const Size(double.infinity, 200.0),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'Star polygons',
          subtitle: 'Six star shapes built with alternating inner/outer radii.',
          child: SizedBox(
            height: 180.0,
            child: CustomPaint(
              painter: _StarPainter(),
              size: const Size(double.infinity, 180.0),
            ),
          ),
        ),
      ],
    );
  }
}

class _PathBuilderPainter extends CustomPainter {
  const _PathBuilderPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double cellW = size.width / 4.0;
    const double cy = 110.0;

    // 1. lineTo polyline.
    {
      final Offset c = Offset(cellW * 0.5, cy);
      final Path p = Path()
        ..moveTo(c.dx - 40.0, c.dy + 30.0)
        ..lineTo(c.dx - 20.0, c.dy - 30.0)
        ..lineTo(c.dx, c.dy + 10.0)
        ..lineTo(c.dx + 20.0, c.dy - 20.0)
        ..lineTo(c.dx + 40.0, c.dy + 30.0);
      canvas.drawPath(
        p,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0
          ..color = kAccentBlue,
      );
      _caption(canvas, 'lineTo', Offset(c.dx, cy + 60.0));
    }
    // 2. Quadratic.
    {
      final Offset c = Offset(cellW * 1.5, cy);
      final Path p = Path()
        ..moveTo(c.dx - 40.0, c.dy + 20.0)
        ..quadraticBezierTo(c.dx, c.dy - 60.0, c.dx + 40.0, c.dy + 20.0);
      canvas.drawPath(
        p,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0
          ..color = kAccentPink,
      );
      _caption(canvas, 'quadraticBezierTo', Offset(c.dx, cy + 60.0));
    }
    // 3. Cubic.
    {
      final Offset c = Offset(cellW * 2.5, cy);
      final Path p = Path()
        ..moveTo(c.dx - 50.0, c.dy + 20.0)
        ..cubicTo(c.dx - 30.0, c.dy - 80.0, c.dx + 30.0, c.dy + 80.0,
            c.dx + 50.0, c.dy - 20.0);
      canvas.drawPath(
        p,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3.0
          ..color = kAccentLime,
      );
      _caption(canvas, 'cubicTo', Offset(c.dx, cy + 60.0));
    }
    // 4. addPolygon + close.
    {
      final Offset c = Offset(cellW * 3.5, cy);
      final Path p = Path()
        ..addPolygon(<Offset>[
          Offset(c.dx, c.dy - 40.0),
          Offset(c.dx + 38.0, c.dy - 12.0),
          Offset(c.dx + 24.0, c.dy + 34.0),
          Offset(c.dx - 24.0, c.dy + 34.0),
          Offset(c.dx - 38.0, c.dy - 12.0),
        ], true);
      canvas.drawPath(
        p,
        Paint()..color = kAccentSun.withValues(alpha: 0.75),
      );
      canvas.drawPath(
        p,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2.0
          ..color = kInk,
      );
      _caption(canvas, 'addPolygon', Offset(c.dx, cy + 60.0));
    }
  }

  static void _caption(Canvas canvas, String text, Offset pos) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(color: kTextMuted, fontSize: 11.0),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(pos.dx - tp.width / 2.0, pos.dy));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PathCombinePainter extends CustomPainter {
  const _PathCombinePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final List<PathOperation> ops = <PathOperation>[
      PathOperation.union,
      PathOperation.intersect,
      PathOperation.difference,
      PathOperation.xor,
    ];
    final List<String> labels = <String>['union', 'intersect', 'difference', 'xor'];
    final double cellW = size.width / ops.length;
    const double cy = 90.0;
    for (int i = 0; i < ops.length; i++) {
      final Offset center = Offset(cellW * i + cellW / 2.0, cy);
      final Path a = Path()
        ..addOval(Rect.fromCircle(center: center.translate(-14.0, 0.0), radius: 32.0));
      final Path b = Path()
        ..addOval(Rect.fromCircle(center: center.translate(14.0, 0.0), radius: 32.0));
      final Path combined = Path.combine(ops[i], a, b);
      canvas.drawPath(
        combined,
        Paint()..color = kBandIndigo.withValues(alpha: 0.85),
      );
      canvas.drawPath(
        a,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..color = kInk.withValues(alpha: 0.4),
      );
      canvas.drawPath(
        b,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..color = kInk.withValues(alpha: 0.4),
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: labels[i],
          style: const TextStyle(color: kInk, fontSize: 11.0),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(center.dx - tp.width / 2.0, cy + 55.0));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _StarPainter extends CustomPainter {
  const _StarPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final List<int> pointCounts = <int>[3, 4, 5, 6, 8, 12];
    final double cellW = size.width / pointCounts.length;
    const double cy = 80.0;
    for (int i = 0; i < pointCounts.length; i++) {
      final Offset center = Offset(cellW * i + cellW / 2.0, cy);
      final Path star = _buildStar(center, 40.0, 18.0, pointCounts[i]);
      canvas.drawPath(
        star,
        Paint()
          ..color = Color.lerp(kAccentSun, kAccentPink, i / (pointCounts.length - 1))!,
      );
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: '${pointCounts[i]} pts',
          style: const TextStyle(color: kInk, fontSize: 10.0),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(center.dx - tp.width / 2.0, cy + 55.0));
    }
  }

  static Path _buildStar(Offset center, double outer, double inner, int points) {
    final Path path = Path();
    final int total = points * 2;
    for (int i = 0; i < total; i++) {
      final double angle = (i / total) * math.pi * 2.0 - math.pi / 2.0;
      final double r = i.isEven ? outer : inner;
      final Offset pt = center + Offset(math.cos(angle), math.sin(angle)) * r;
      if (i == 0) {
        path.moveTo(pt.dx, pt.dy);
      } else {
        path.lineTo(pt.dx, pt.dy);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// SECTION VIII  -  BLENDMODE
// ============================================================================

class _BlendModeSection extends StatelessWidget {
  const _BlendModeSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Card(
          title: 'BlendMode atlas',
          subtitle:
              'Sixteen common BlendMode values compositing a magenta circle '
              'over a cyan square against a soft background.',
          child: SizedBox(
            height: 520.0,
            child: CustomPaint(
              painter: _BlendModePainter(),
              size: const Size(double.infinity, 520.0),
            ),
          ),
        ),
      ],
    );
  }
}

class _BlendModePainter extends CustomPainter {
  const _BlendModePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final List<BlendMode> modes = <BlendMode>[
      BlendMode.srcOver,
      BlendMode.multiply,
      BlendMode.screen,
      BlendMode.overlay,
      BlendMode.darken,
      BlendMode.lighten,
      BlendMode.colorDodge,
      BlendMode.colorBurn,
      BlendMode.hardLight,
      BlendMode.softLight,
      BlendMode.difference,
      BlendMode.exclusion,
      BlendMode.plus,
      BlendMode.modulate,
      BlendMode.xor,
      BlendMode.dstATop,
    ];
    const int cols = 4;
    final double cellW = size.width / cols;
    final double cellH = size.height / 4.0;
    for (int i = 0; i < modes.length; i++) {
      final int col = i % cols;
      final int row = i ~/ cols;
      final Rect cell = Rect.fromLTWH(
        col * cellW + 6.0,
        row * cellH + 6.0,
        cellW - 12.0,
        cellH - 12.0,
      );
      // Background.
      canvas.drawRect(
        cell,
        Paint()..color = const Color(0xFFF2F4FB),
      );
      // Layer A (cyan square).
      final Rect a = Rect.fromLTWH(
        cell.left + cell.width * 0.18,
        cell.top + cell.height * 0.20,
        cell.width * 0.50,
        cell.height * 0.50,
      );
      // Save layer so blend modes apply within the cell.
      canvas.saveLayer(cell, Paint());
      canvas.drawRect(a, Paint()..color = const Color(0xFF00BCD4));
      // Layer B (magenta circle) blended over A.
      canvas.drawCircle(
        Offset(
          cell.left + cell.width * 0.55,
          cell.top + cell.height * 0.55,
        ),
        cell.shortestSide * 0.28,
        Paint()
          ..color = const Color(0xFFE91E63)
          ..blendMode = modes[i],
      );
      canvas.restore();
      // Label.
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: _blendModeName(modes[i]),
          style: const TextStyle(
            color: kInk,
            fontSize: 10.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout(maxWidth: cell.width - 8.0);
      tp.paint(canvas, Offset(cell.left + 6.0, cell.bottom - tp.height - 4.0));
      canvas.drawRect(
        cell,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = kBorderSoft
          ..strokeWidth = 1.0,
      );
    }
  }

  static String _blendModeName(BlendMode mode) {
    final String full = mode.toString();
    final int dot = full.indexOf('.');
    return dot == -1 ? full : full.substring(dot + 1);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// SECTION IX  -  GRADIENT
// ============================================================================

class _GradientSection extends StatelessWidget {
  const _GradientSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Card(
          title: 'dart:ui Gradient shaders',
          subtitle:
              'Gradient.linear, Gradient.radial and Gradient.sweep used as '
              'shaders on a Paint.',
          child: SizedBox(
            height: 240.0,
            child: CustomPaint(
              painter: _GradientPainter(),
              size: const Size(double.infinity, 240.0),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'Material Gradient widgets',
          subtitle: 'Same gradients drawn via LinearGradient / RadialGradient.',
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            children: <Widget>[
              _gradientCard(
                const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[kAccentBlue, kAccentPink],
                ),
                'linear  topLeft -> bottomRight',
              ),
              _gradientCard(
                const LinearGradient(
                  colors: <Color>[kAccentLime, kAccentTeal, kAccentPlum],
                  stops: <double>[0.0, 0.5, 1.0],
                ),
                'linear  3 stops',
              ),
              _gradientCard(
                const RadialGradient(
                  colors: <Color>[Colors.white, kAccentBlue],
                  radius: 0.7,
                ),
                'radial  centre highlight',
              ),
              _gradientCard(
                const SweepGradient(
                  colors: <Color>[
                    kBandRed,
                    kBandOrange,
                    kBandYellow,
                    kBandGreen,
                    kBandBlue,
                    kBandIndigo,
                    kBandViolet,
                    kBandRed,
                  ],
                ),
                'sweep  rainbow',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _gradientCard(Gradient gradient, String label) {
    return Column(
      children: <Widget>[
        Container(
          width: 150.0,
          height: 90.0,
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: kBorderSoft),
          ),
        ),
        const SizedBox(height: 4.0),
        SizedBox(
          width: 150.0,
          child: Text(
            label,
            style: const TextStyle(fontSize: 10.0, color: kTextMuted),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}

class _GradientPainter extends CustomPainter {
  const _GradientPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double cellW = size.width / 3.0;
    const double cellH = 200.0;
    const double pad = 14.0;

    // Linear.
    {
      final Rect rect = Rect.fromLTWH(pad, pad, cellW - pad * 2.0, cellH - pad * 2.0);
      final ui.Gradient g = ui.Gradient.linear(
        rect.topLeft,
        rect.bottomRight,
        <Color>[kAccentBlue, kAccentPink, kAccentSun],
        <double>[0.0, 0.5, 1.0],
      );
      canvas.drawRect(rect, Paint()..shader = g);
      _label(canvas, 'Gradient.linear', Offset(rect.center.dx, rect.bottom + 8.0));
    }
    // Radial.
    {
      final Rect rect = Rect.fromLTWH(cellW + pad, pad, cellW - pad * 2.0, cellH - pad * 2.0);
      final ui.Gradient g = ui.Gradient.radial(
        rect.center,
        rect.shortestSide / 2.0,
        <Color>[Colors.white, kAccentTeal, kInk],
        <double>[0.0, 0.6, 1.0],
      );
      canvas.drawRect(rect, Paint()..shader = g);
      _label(canvas, 'Gradient.radial', Offset(rect.center.dx, rect.bottom + 8.0));
    }
    // Sweep.
    {
      final Rect rect = Rect.fromLTWH(cellW * 2.0 + pad, pad, cellW - pad * 2.0, cellH - pad * 2.0);
      final ui.Gradient g = ui.Gradient.sweep(
        rect.center,
        <Color>[
          kBandRed,
          kBandYellow,
          kBandGreen,
          kBandBlue,
          kBandViolet,
          kBandRed,
        ],
        <double>[0.0, 0.2, 0.4, 0.6, 0.8, 1.0],
      );
      canvas.drawCircle(rect.center, rect.shortestSide / 2.0, Paint()..shader = g);
      _label(canvas, 'Gradient.sweep', Offset(rect.center.dx, rect.bottom + 8.0));
    }
  }

  static void _label(Canvas canvas, String text, Offset pos) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: text,
        style: const TextStyle(
          color: kInk,
          fontSize: 11.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(pos.dx - tp.width / 2.0, pos.dy));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// SECTION X  -  FILTERS
// ============================================================================

class _FilterSection extends StatelessWidget {
  const _FilterSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Card(
          title: 'ColorFilter on Paint',
          subtitle:
              'ColorFilter.mode, ColorFilter.matrix and ColorFilter.linearToSrgbGamma '
              'applied to coloured rectangles.',
          child: SizedBox(
            height: 160.0,
            child: CustomPaint(
              painter: _ColorFilterPainter(),
              size: const Size(double.infinity, 160.0),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'MaskFilter blur',
          subtitle:
              'MaskFilter.blur(BlurStyle.normal, sigma) on circles with '
              'increasing sigma.',
          child: SizedBox(
            height: 140.0,
            child: CustomPaint(
              painter: _MaskFilterPainter(),
              size: const Size(double.infinity, 140.0),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'ImageFilter via BackdropFilter',
          subtitle:
              'ImageFilter.blur applied through a BackdropFilter widget over '
              'a colourful background.',
          child: SizedBox(
            height: 200.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Stack(
                children: <Widget>[
                  // Bright underlay.
                  Positioned.fill(
                    child: CustomPaint(painter: _UnderlayPainter()),
                  ),
                  // Blurred strip in the middle.
                  Positioned(
                    left: 0.0,
                    right: 0.0,
                    top: 60.0,
                    height: 80.0,
                    child: BackdropFilter(
                      filter: ui.ImageFilter.blur(sigmaX: 8.0, sigmaY: 8.0),
                      child: Container(
                        color: Colors.white.withValues(alpha: 0.15),
                        alignment: Alignment.center,
                        child: const Text(
                          'BackdropFilter  -  ImageFilter.blur(8, 8)',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12.0,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ColorFilterPainter extends CustomPainter {
  const _ColorFilterPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double col = size.width / 4.0;
    const double cy = 70.0;

    // 1. No filter.
    _swatch(canvas, Offset(col * 0.5, cy), kAccentBlue, null, 'none');
    // 2. ColorFilter.mode srcIn red.
    _swatch(
      canvas,
      Offset(col * 1.5, cy),
      kAccentBlue,
      const ColorFilter.mode(Color(0xFFE53935), BlendMode.srcIn),
      'mode srcIn',
    );
    // 3. Grayscale via matrix.
    _swatch(
      canvas,
      Offset(col * 2.5, cy),
      kAccentBlue,
      const ColorFilter.matrix(<double>[
        0.2126, 0.7152, 0.0722, 0.0, 0.0,
        0.2126, 0.7152, 0.0722, 0.0, 0.0,
        0.2126, 0.7152, 0.0722, 0.0, 0.0,
        0.0, 0.0, 0.0, 1.0, 0.0,
      ]),
      'matrix gray',
    );
    // 4. Invert.
    _swatch(
      canvas,
      Offset(col * 3.5, cy),
      kAccentBlue,
      const ColorFilter.matrix(<double>[
        -1.0, 0.0, 0.0, 0.0, 255.0,
        0.0, -1.0, 0.0, 0.0, 255.0,
        0.0, 0.0, -1.0, 0.0, 255.0,
        0.0, 0.0, 0.0, 1.0, 0.0,
      ]),
      'matrix invert',
    );
  }

  static void _swatch(Canvas canvas, Offset center, Color base, ColorFilter? cf, String label) {
    final Paint p = Paint()..color = base;
    if (cf != null) {
      p.colorFilter = cf;
    }
    final Rect rect = Rect.fromCenter(center: center, width: 70.0, height: 70.0);
    canvas.drawRect(rect, p);
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(color: kInk, fontSize: 11.0),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(center.dx - tp.width / 2.0, center.dy + 50.0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MaskFilterPainter extends CustomPainter {
  const _MaskFilterPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final List<double> sigmas = <double>[0.0, 1.5, 4.0, 8.0, 14.0];
    final double col = size.width / sigmas.length;
    const double cy = 60.0;
    for (int i = 0; i < sigmas.length; i++) {
      final Paint p = Paint()..color = kAccentPlum;
      if (sigmas[i] > 0.0) {
        p.maskFilter = MaskFilter.blur(BlurStyle.normal, sigmas[i]);
      }
      canvas.drawCircle(Offset(col * i + col / 2.0, cy), 22.0, p);
      final TextPainter tp = TextPainter(
        text: TextSpan(
          text: 'sigma ${sigmas[i].toStringAsFixed(1)}',
          style: const TextStyle(color: kInk, fontSize: 10.0),
        ),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, Offset(col * i + col / 2.0 - tp.width / 2.0, cy + 38.0));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _UnderlayPainter extends CustomPainter {
  const _UnderlayPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final List<Color> colours = <Color>[
      kBandRed,
      kBandOrange,
      kBandYellow,
      kBandGreen,
      kBandBlue,
      kBandIndigo,
      kBandViolet,
    ];
    final double colW = size.width / colours.length;
    for (int i = 0; i < colours.length; i++) {
      canvas.drawRect(
        Rect.fromLTWH(i * colW, 0.0, colW, size.height),
        Paint()..color = colours[i],
      );
    }
    // Random-ish dots so the blur is visible.
    final Paint dot = Paint()..color = Colors.white.withValues(alpha: 0.7);
    for (int i = 0; i < 24; i++) {
      final double x = (i * 31.0) % size.width;
      final double y = (i * 47.0) % size.height;
      canvas.drawCircle(Offset(x, y), 6.0, dot);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// SECTION XI  -  GLOSSARY
// ============================================================================

class _GlossarySection extends StatelessWidget {
  const _GlossarySection();

  @override
  Widget build(BuildContext context) {
    final List<List<String>> entries = <List<String>>[
      <String>[
        'Color',
        '32-bit ARGB value plus channel and alpha helpers. Use withValues to '
            'change channels non-destructively.',
      ],
      <String>[
        'Offset',
        'A 2D vector with dx/dy. Supports vector arithmetic and polar '
            'properties (distance, direction).',
      ],
      <String>[
        'Size',
        '2D extent with width/height. Many factory constructors plus '
            'aspectRatio, shortestSide and longestSide.',
      ],
      <String>[
        'Rect',
        'Axis-aligned rectangle, identified by left/top/right/bottom. Rich '
            'set of derived geometry getters.',
      ],
      <String>[
        'Radius',
        'A pair (x, y) describing a corner radius - circular when x == y.',
      ],
      <String>[
        'RRect',
        'Rectangle with per-corner Radius. Built via fromRectAndRadius or '
            'fromRectAndCorners.',
      ],
      <String>[
        'Paint',
        'How a shape is drawn: color, style, strokeWidth, strokeCap, '
            'strokeJoin, blendMode, shader, colorFilter, maskFilter.',
      ],
      <String>[
        'Path',
        'A composable shape: lines, beziers, arcs, polygons and combinations.',
      ],
      <String>[
        'BlendMode',
        'How a Paint composites against the destination. Porter-Duff and '
            'creative modes both supported.',
      ],
      <String>[
        'Gradient (dart:ui)',
        'A Shader factory: linear, radial, sweep. Used via Paint.shader.',
      ],
      <String>[
        'ImageFilter',
        'A pixel filter applied during compositing - e.g. blur or matrix.',
      ],
      <String>[
        'ColorFilter',
        'Per-pixel colour transform: mode, matrix, srgb / linear conversions.',
      ],
      <String>[
        'MaskFilter',
        'A filter applied to the shape mask before drawing - typically a blur.',
      ],
    ];
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(color: kBorderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List<Widget>.generate(entries.length, (int i) {
          final List<String> e = entries[i];
          return Container(
            margin: const EdgeInsets.only(bottom: 12.0),
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFF7F8FC),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      width: 28.0,
                      height: 28.0,
                      decoration: BoxDecoration(
                        color: Color.lerp(
                          kAccentBlue,
                          kAccentPink,
                          i / (entries.length - 1),
                        ),
                        borderRadius: BorderRadius.circular(7.0),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        '${i + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      e[0],
                      style: const TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w700,
                        color: kInk,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6.0),
                Text(
                  e[1],
                  style: const TextStyle(
                    fontSize: 12.5,
                    height: 1.45,
                    color: kTextMuted,
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}

// ============================================================================
// SECTION I  -  COLOR
// ============================================================================

class _ColorSection extends StatelessWidget {
  const _ColorSection();

  @override
  Widget build(BuildContext context) {
    // Construct the same blue via several different constructors.
    const Color cHex = Color(0xFF3563E9);
    final Color cArgb = const Color.fromARGB(255, 53, 99, 233);
    final Color cRgbo = const Color.fromRGBO(53, 99, 233, 1.0);

    // Component access.
    final List<Map<String, dynamic>> channels = <Map<String, dynamic>>[
      <String, dynamic>{'name': 'alpha', 'value': (cHex.a * 255.0).round()},
      <String, dynamic>{'name': 'red', 'value': (cHex.r * 255.0).round()},
      <String, dynamic>{'name': 'green', 'value': (cHex.g * 255.0).round()},
      <String, dynamic>{'name': 'blue', 'value': (cHex.b * 255.0).round()},
    ];

    // Lerp ramp blue -> pink in 12 stops, using List.generate to capture
    // each i in its own closure.
    final List<Color> ramp = List<Color>.generate(12, (int i) {
      final double t = i / 11.0;
      return Color.lerp(kAccentBlue, kAccentPink, t) ?? kAccentBlue;
    });

    // Alpha ramp using withValues.
    final List<Color> alphaRamp = List<Color>.generate(10, (int i) {
      final double a = i / 9.0;
      return kInk.withValues(alpha: a);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Card(
          title: 'Constructors yield equal colour',
          subtitle:
              'Color(0xFF3563E9), Color.fromARGB and Color.fromRGBO all '
              'produce the same 32-bit ARGB value.',
          child: Row(
            children: <Widget>[
              _swatch(cHex, 'hex'),
              const SizedBox(width: 10.0),
              _swatch(cArgb, 'fromARGB'),
              const SizedBox(width: 10.0),
              _swatch(cRgbo, 'fromRGBO'),
              const SizedBox(width: 16.0),
              Expanded(
                child: Wrap(
                  spacing: 6.0,
                  runSpacing: 6.0,
                  children: <Widget>[
                    _CodeChip('value: 0x${cHex.toARGB32().toRadixString(16).toUpperCase()}'),
                    _CodeChip('opacity: ${cHex.a.toStringAsFixed(2)}'),
                    _CodeChip('equal: ${cHex == cArgb && cArgb == cRgbo}'),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'Channels',
          subtitle: 'alpha, red, green, blue accessors return 0-255 ints.',
          child: Row(
            children: List<Widget>.generate(channels.length, (int i) {
              final Map<String, dynamic> ch = channels[i];
              final Color paint = <Color>[
                kInk,
                kBandRed,
                kBandGreen,
                kBandBlue,
              ][i];
              return Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: i == channels.length - 1 ? 0.0 : 8.0),
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: paint.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: paint.withValues(alpha: 0.35)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        ch['name'] as String,
                        style: TextStyle(
                          fontSize: 11.0,
                          color: paint,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 2.0),
                      Text(
                        '${ch['value']}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w800,
                          color: kInk,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'Color.lerp ramp',
          subtitle: '12 interpolated stops between two accents.',
          child: Container(
            height: 36.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: kBorderSoft),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: List<Widget>.generate(ramp.length, (int i) {
                return Expanded(child: Container(color: ramp[i]));
              }),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'withValues(alpha:) ramp',
          subtitle: 'New, non-deprecated API. Replaces withOpacity.',
          child: Container(
            height: 36.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: kBorderSoft),
            ),
            clipBehavior: Clip.antiAlias,
            child: Row(
              children: List<Widget>.generate(alphaRamp.length, (int i) {
                return Expanded(child: Container(color: alphaRamp[i]));
              }),
            ),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'HSL-ish hue wheel',
          subtitle: 'Built from Color.fromARGB using sin/cos; 24 sectors.',
          child: SizedBox(
            height: 220.0,
            child: CustomPaint(
              painter: _HueWheelPainter(),
              size: const Size(double.infinity, 220.0),
            ),
          ),
        ),
      ],
    );
  }

  Widget _swatch(Color c, String label) {
    return Column(
      children: <Widget>[
        Container(
          width: 56.0,
          height: 56.0,
          decoration: BoxDecoration(
            color: c,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: kBorderSoft),
          ),
        ),
        const SizedBox(height: 6.0),
        Text(
          label,
          style: const TextStyle(fontSize: 11.0, color: kTextMuted),
        ),
      ],
    );
  }
}

class _HueWheelPainter extends CustomPainter {
  const _HueWheelPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final double radius = math.min(size.width, size.height) / 2.0 - 8.0;
    const int sectors = 24;
    for (int i = 0; i < sectors; i++) {
      final double start = (i / sectors) * math.pi * 2.0 - math.pi / 2.0;
      final double sweep = (math.pi * 2.0) / sectors;
      final double hue = i / sectors;
      // Naive HSL->RGB.
      final int r = (((math.sin(hue * math.pi * 2.0) + 1.0) / 2.0) * 255.0).round();
      final int g = (((math.sin(hue * math.pi * 2.0 + 2.0) + 1.0) / 2.0) * 255.0).round();
      final int b = (((math.sin(hue * math.pi * 2.0 + 4.0) + 1.0) / 2.0) * 255.0).round();
      final Paint paint = Paint()..color = Color.fromARGB(255, r, g, b);
      final Path wedge = Path()
        ..moveTo(center.dx, center.dy)
        ..arcTo(
          Rect.fromCircle(center: center, radius: radius),
          start,
          sweep,
          false,
        )
        ..close();
      canvas.drawPath(wedge, paint);
    }
    // White centre disc to evoke a colour wheel hub.
    canvas.drawCircle(center, radius * 0.35, Paint()..color = Colors.white);
    canvas.drawCircle(
      center,
      radius * 0.35,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = 2.0
        ..color = kBorderSoft,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// SECTION II  -  OFFSET
// ============================================================================

class _OffsetSection extends StatelessWidget {
  const _OffsetSection();

  @override
  Widget build(BuildContext context) {
    const Offset a = Offset(40.0, 20.0);
    const Offset b = Offset(15.0, 35.0);
    final Offset sum = a + b;
    final Offset diff = a - b;
    final Offset scaled = a * 2.0;
    final Offset half = a / 2.0;
    final double distance = a.distance;
    final double direction = a.direction;

    final List<List<String>> rows = <List<String>>[
      <String>['a', '${a.dx}, ${a.dy}'],
      <String>['b', '${b.dx}, ${b.dy}'],
      <String>['a + b', '${sum.dx}, ${sum.dy}'],
      <String>['a - b', '${diff.dx}, ${diff.dy}'],
      <String>['a * 2', '${scaled.dx}, ${scaled.dy}'],
      <String>['a / 2', '${half.dx}, ${half.dy}'],
      <String>['a.distance', distance.toStringAsFixed(3)],
      <String>['a.direction', direction.toStringAsFixed(3)],
      <String>['Offset.zero', '${Offset.zero.dx}, ${Offset.zero.dy}'],
      <String>['Offset.infinite.isInfinite', '${Offset.infinite.isInfinite}'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Card(
          title: 'Vector arithmetic',
          subtitle:
              'Offset overloads +, -, *, /, % and unary -. distance and '
              'direction give polar form.',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List<Widget>.generate(rows.length, (int i) {
              final List<String> r = rows[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 6.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: i.isEven ? const Color(0xFFF7F8FC) : Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: kBorderSoft),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 170.0,
                      child: Text(
                        r[0],
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.0,
                          color: kInk,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        r[1],
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.0,
                          color: kAccentPink,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'Polar plot',
          subtitle:
              '36 offsets fanned around a centre using Offset(cos*r, sin*r). '
              'Lines drawn with canvas.drawLine.',
          child: SizedBox(
            height: 240.0,
            child: CustomPaint(
              painter: _PolarOffsetPainter(),
              size: const Size(double.infinity, 240.0),
            ),
          ),
        ),
      ],
    );
  }
}

class _PolarOffsetPainter extends CustomPainter {
  const _PolarOffsetPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2.0, size.height / 2.0);
    final double maxR = math.min(size.width, size.height) / 2.0 - 10.0;
    // Axes.
    final Paint axis = Paint()
      ..color = kBorderSoft
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(0.0, center.dy), Offset(size.width, center.dy), axis);
    canvas.drawLine(Offset(center.dx, 0.0), Offset(center.dx, size.height), axis);
    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(
        center,
        maxR * (i / 4.0),
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.0
          ..color = kBorderSoft.withValues(alpha: 0.7),
      );
    }
    const int spokes = 36;
    for (int i = 0; i < spokes; i++) {
      final double angle = (i / spokes) * math.pi * 2.0;
      final double r = maxR * (0.4 + 0.6 * ((i % 6) / 5.0));
      // The expressive bit: building Offsets via cos/sin and using +.
      final Offset tip = center + Offset(math.cos(angle), math.sin(angle)) * r;
      final Paint p = Paint()
        ..color = Color.lerp(kAccentBlue, kAccentPink, i / spokes)!
        ..strokeWidth = 2.0
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(center, tip, p);
      canvas.drawCircle(tip, 3.0, Paint()..color = p.color);
    }
    canvas.drawCircle(center, 4.0, Paint()..color = kInk);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ============================================================================
// SECTION III  -  SIZE
// ============================================================================

class _SizeSection extends StatelessWidget {
  const _SizeSection();

  @override
  Widget build(BuildContext context) {
    const Size s1 = Size(120.0, 80.0);
    final Size s2 = const Size.square(64.0);
    final Size s3 = const Size.fromWidth(200.0);
    final Size s4 = const Size.fromHeight(48.0);
    final Size s5 = const Size.fromRadius(40.0);
    final Size shrunk = s1 / 2.0;
    final Size grown = s1 * 1.5;

    final List<List<String>> facts = <List<String>>[
      <String>['Size(120, 80)', 'aspectRatio = ${s1.aspectRatio.toStringAsFixed(3)}'],
      <String>['Size.square(64)', 'shortestSide = ${s2.shortestSide}'],
      <String>['Size.fromWidth(200)', 'height isInfinite = ${s3.height.isInfinite}'],
      <String>['Size.fromHeight(48)', 'width isInfinite = ${s4.width.isInfinite}'],
      <String>['Size.fromRadius(40)', 'longestSide = ${s5.longestSide}'],
      <String>['s1 / 2', '${shrunk.width} x ${shrunk.height}'],
      <String>['s1 * 1.5', '${grown.width} x ${grown.height}'],
      <String>['Size.zero.isEmpty', '${Size.zero.isEmpty}'],
    ];

    final List<Size> ladder = <Size>[
      const Size(20.0, 20.0),
      const Size(40.0, 30.0),
      const Size(60.0, 40.0),
      const Size(80.0, 50.0),
      const Size(100.0, 60.0),
      const Size(120.0, 70.0),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Card(
          title: 'Factory constructors and properties',
          subtitle: 'Size has many named constructors and rich derived getters.',
          child: Column(
            children: List<Widget>.generate(facts.length, (int i) {
              final List<String> f = facts[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 6.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                decoration: BoxDecoration(
                  color: i.isEven ? const Color(0xFFF7F8FC) : Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: kBorderSoft),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 200.0,
                      child: Text(
                        f[0],
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.0,
                          color: kInk,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        f[1],
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12.0,
                          color: kAccentLime,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'Size ladder',
          subtitle: 'Six rectangles whose width and height step up together.',
          child: Wrap(
            spacing: 10.0,
            runSpacing: 10.0,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: List<Widget>.generate(ladder.length, (int i) {
              final Size sz = ladder[i];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: sz.width,
                    height: sz.height,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: <Color>[
                          kAccentLime.withValues(alpha: 0.85),
                          kAccentTeal.withValues(alpha: 0.85),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    '${sz.width.toInt()}x${sz.height.toInt()}',
                    style: const TextStyle(fontSize: 10.0, color: kTextMuted),
                  ),
                ],
              );
            }),
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// SECTION IV  -  RECT
// ============================================================================

class _RectSection extends StatelessWidget {
  const _RectSection();

  @override
  Widget build(BuildContext context) {
    final Rect a = const Rect.fromLTWH(20.0, 20.0, 120.0, 80.0);
    final Rect b = Rect.fromLTRB(50.0, 40.0, 200.0, 140.0);
    final Rect circle = Rect.fromCircle(center: const Offset(100.0, 100.0), radius: 50.0);
    final Rect center = Rect.fromCenter(
      center: const Offset(120.0, 120.0),
      width: 100.0,
      height: 60.0,
    );
    final Rect points = Rect.fromPoints(const Offset(20.0, 20.0), const Offset(100.0, 90.0));
    final Rect inflated = a.inflate(10.0);
    final Rect deflated = a.deflate(10.0);
    final Rect intersect = a.intersect(b);
    final Rect union = a.expandToInclude(b);
    final Rect shifted = a.shift(const Offset(20.0, 10.0));

    final List<List<String>> facts = <List<String>>[
      <String>['a.center', '${a.center.dx}, ${a.center.dy}'],
      <String>['a.size', '${a.size.width} x ${a.size.height}'],
      <String>['a.topLeft', '${a.topLeft.dx}, ${a.topLeft.dy}'],
      <String>['a.bottomRight', '${a.bottomRight.dx}, ${a.bottomRight.dy}'],
      <String>['a.shortestSide', '${a.shortestSide}'],
      <String>['a.longestSide', '${a.longestSide}'],
      <String>['a.contains(center)', '${a.contains(a.center)}'],
      <String>['a.overlaps(b)', '${a.overlaps(b)}'],
      <String>['fromCircle.size', '${circle.size.width} x ${circle.size.height}'],
      <String>['fromCenter.topLeft', '${center.topLeft.dx}, ${center.topLeft.dy}'],
      <String>['fromPoints.width', '${points.width}'],
      <String>['inflate(10).size', '${inflated.size.width} x ${inflated.size.height}'],
      <String>['deflate(10).size', '${deflated.size.width} x ${deflated.size.height}'],
      <String>['intersect(b).size', '${intersect.size.width} x ${intersect.size.height}'],
      <String>['union(b).size', '${union.size.width} x ${union.size.height}'],
      <String>['shift(20,10).topLeft', '${shifted.topLeft.dx}, ${shifted.topLeft.dy}'],
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _Card(
          title: 'Constructors and derived geometry',
          subtitle: 'Rect.fromLTWH, fromLTRB, fromCircle, fromCenter, fromPoints.',
          child: Column(
            children: List<Widget>.generate(facts.length, (int i) {
              final List<String> f = facts[i];
              return Container(
                margin: const EdgeInsets.only(bottom: 4.0),
                padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                decoration: BoxDecoration(
                  color: i.isEven ? const Color(0xFFF7F8FC) : Colors.white,
                  borderRadius: BorderRadius.circular(6.0),
                  border: Border.all(color: kBorderSoft),
                ),
                child: Row(
                  children: <Widget>[
                    SizedBox(
                      width: 200.0,
                      child: Text(
                        f[0],
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          color: kInk,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        f[1],
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 11.5,
                          color: kAccentSun,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
        const SizedBox(height: 14.0),
        _Card(
          title: 'Rect operations playground',
          subtitle:
              'Two source rectangles, then inflate, deflate, intersect, union '
              'rendered side by side.',
          child: SizedBox(
            height: 280.0,
            child: CustomPaint(
              painter: _RectOpsPainter(),
              size: const Size(double.infinity, 280.0),
            ),
          ),
        ),
      ],
    );
  }
}

class _RectOpsPainter extends CustomPainter {
  const _RectOpsPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final double cellW = size.width / 3.0;
    const double cellH = 140.0;

    void drawCell(
      double col,
      double row,
      String label,
      void Function(Canvas, Rect) painter,
    ) {
      final Rect cell = Rect.fromLTWH(col * cellW + 8.0, row * cellH + 8.0,
          cellW - 16.0, cellH - 16.0);
      canvas.drawRect(
        cell,
        Paint()..color = kCanvasBg,
      );
      canvas.drawRect(
        cell,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = kBorderSoft
          ..strokeWidth = 1.0,
      );
      painter(canvas, cell);
      _drawCellLabel(canvas, cell, label);
    }

    drawCell(0, 0, 'A and B', (Canvas c, Rect cell) {
      final Rect a = _localRect(cell, 0.10, 0.20, 0.45, 0.55);
      final Rect b = _localRect(cell, 0.40, 0.35, 0.85, 0.85);
      c.drawRect(a, Paint()..color = kAccentBlue.withValues(alpha: 0.45));
      c.drawRect(b, Paint()..color = kAccentPink.withValues(alpha: 0.45));
    });
    drawCell(1, 0, 'A.inflate(8)', (Canvas c, Rect cell) {
      final Rect a = _localRect(cell, 0.25, 0.30, 0.65, 0.75);
      c.drawRect(
        a.inflate(8.0),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = kAccentSun
          ..strokeWidth = 2.0,
      );
      c.drawRect(a, Paint()..color = kAccentBlue.withValues(alpha: 0.45));
    });
    drawCell(2, 0, 'A.deflate(8)', (Canvas c, Rect cell) {
      final Rect a = _localRect(cell, 0.20, 0.25, 0.75, 0.80);
      c.drawRect(a, Paint()..color = kAccentBlue.withValues(alpha: 0.45));
      c.drawRect(
        a.deflate(8.0),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = kAccentSun
          ..strokeWidth = 2.0,
      );
    });
    drawCell(0, 1, 'A.intersect(B)', (Canvas c, Rect cell) {
      final Rect a = _localRect(cell, 0.10, 0.20, 0.55, 0.65);
      final Rect b = _localRect(cell, 0.40, 0.45, 0.85, 0.85);
      c.drawRect(a, Paint()..color = kAccentBlue.withValues(alpha: 0.30));
      c.drawRect(b, Paint()..color = kAccentPink.withValues(alpha: 0.30));
      c.drawRect(a.intersect(b), Paint()..color = kAccentPlum);
    });
    drawCell(1, 1, 'A.union(B)', (Canvas c, Rect cell) {
      final Rect a = _localRect(cell, 0.10, 0.20, 0.50, 0.55);
      final Rect b = _localRect(cell, 0.45, 0.50, 0.85, 0.85);
      c.drawRect(
        a.expandToInclude(b),
        Paint()
          ..style = PaintingStyle.stroke
          ..color = kAccentSun
          ..strokeWidth = 2.0,
      );
      c.drawRect(a, Paint()..color = kAccentBlue.withValues(alpha: 0.45));
      c.drawRect(b, Paint()..color = kAccentPink.withValues(alpha: 0.45));
    });
    drawCell(2, 1, 'shift + scale', (Canvas c, Rect cell) {
      final Rect a = _localRect(cell, 0.10, 0.20, 0.45, 0.55);
      c.drawRect(a, Paint()..color = kAccentBlue.withValues(alpha: 0.35));
      c.drawRect(
        a.shift(const Offset(20.0, 15.0)),
        Paint()..color = kAccentTeal.withValues(alpha: 0.55),
      );
    });
  }

  static Rect _localRect(Rect cell, double l, double t, double r, double b) {
    return Rect.fromLTRB(
      cell.left + cell.width * l,
      cell.top + cell.height * t,
      cell.left + cell.width * r,
      cell.top + cell.height * b,
    );
  }

  static void _drawCellLabel(Canvas canvas, Rect cell, String label) {
    final TextPainter tp = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: kInk,
          fontSize: 10.0,
          fontWeight: FontWeight.w600,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: cell.width - 8.0);
    tp.paint(canvas, Offset(cell.left + 6.0, cell.top + 4.0));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: kInk,
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'end of atlas',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 6.0),
          Text(
            'Every shape above was drawn through dart:ui primitives. '
            'Same primitives back every Flutter widget you have ever seen.',
            style: TextStyle(color: Colors.white70, fontSize: 12.0, height: 1.5),
          ),
        ],
      ),
    );
  }
}
