// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, dead_code, unused_element, deprecated_member_use, unnecessary_import, no_leading_underscores_for_local_identifiers

import 'dart:ui' as ui;
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// =====================================================================
// dart:ui Path Metrics — A hand-authored deep demo
//
// This file teaches the per-distance traversal API for paths:
//
//   Path           - A geometric description of one or more sub-paths
//                    (contours). It is the source of all geometry.
//   PathMetrics    - A one-shot iterable returned from `path.computeMetrics()`.
//                    Each element corresponds to one closed/open contour
//                    of the originating path.
//   PathMetric     - One contour's metric record: it exposes
//                       .length                  (arc length of the contour)
//                       .isClosed                (true iff the contour was closed)
//                       .getTangentForOffset(d)  (sample position+direction
//                                                 at arc-distance d in [0, length])
//                       .extractPath(start, end) (return a sub-path covering
//                                                 the requested arc range)
//                       .contourIndex            (0-based contour index)
//   Tangent        - The result of getTangentForOffset, exposing
//                       .position                (an Offset on the contour)
//                       .vector                  (a unit Offset along travel)
//                       .angle                   (atan2(-vy, vx) in radians)
//
// In this demo we construct real Path objects, call .computeMetrics(),
// and read length / tangents / extracted sub-paths at static build-time.
// The visual output is then assembled from Stack-positioned dots,
// rectangles and Transform.rotate arrows — never a CustomPainter
// subclass — so that the script runs unchanged inside D4rt.
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: const Color(0xFF0D1424),
      appBar: AppBar(
        title: const Text('dart:ui Path Metrics'),
        backgroundColor: const Color(0xFF101A33),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _heroBanner(),
            const SizedBox(height: 28),
            _section1Anatomy(),
            const SizedBox(height: 28),
            _section2LengthSampler(),
            const SizedBox(height: 28),
            _section3TangentGrid(),
            const SizedBox(height: 28),
            _section4MultiContour(),
            const SizedBox(height: 28),
            _section5ExtractPath(),
            const SizedBox(height: 28),
            _section6Recipes(),
            const SizedBox(height: 28),
            _section7Footguns(),
            const SizedBox(height: 28),
            _section8Comparison(),
            const SizedBox(height: 28),
            _section9ApiTable(),
            const SizedBox(height: 28),
            _footer(),
          ],
        ),
      ),
    ),
  );
}

// =====================================================================
// COLOUR PALETTE
// =====================================================================

const Color _kBg = Color(0xFF0D1424);
const Color _kPanel = Color(0xFF142035);
const Color _kPanelLight = Color(0xFF1B2C49);
const Color _kInk = Color(0xFFE7ECF7);
const Color _kInkDim = Color(0xFFA9B6CC);
const Color _kInkFaint = Color(0xFF6F7C95);
const Color _kAccent = Color(0xFF5BA9FF);
const Color _kAccent2 = Color(0xFF8C7CFF);
const Color _kAccent3 = Color(0xFF35D9C5);
const Color _kAccent4 = Color(0xFFFFB454);
const Color _kAccent5 = Color(0xFFFF6B95);
const Color _kAccent6 = Color(0xFF7BE26B);
const Color _kWarn = Color(0xFFFFB454);
const Color _kError = Color(0xFFFF6B6B);
const Color _kOk = Color(0xFF7BE26B);

// =====================================================================
// HERO BANNER
// =====================================================================

Widget _heroBanner() {
  return Container(
    padding: const EdgeInsets.all(28),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF1B2C49),
          Color(0xFF253A5C),
          Color(0xFF2E2A5A),
        ],
      ),
      borderRadius: BorderRadius.circular(20),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x665BA9FF),
          blurRadius: 28,
          offset: Offset(0, 8),
        ),
        BoxShadow(
          color: Color(0x338C7CFF),
          blurRadius: 60,
          offset: Offset(0, 0),
        ),
      ],
      border: Border.all(color: Color(0x335BA9FF)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: <Color>[Color(0xFF5BA9FF), Color(0xFF8C7CFF)],
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Color(0x885BA9FF),
                    blurRadius: 18,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  '∮',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    'Walking a Path by Arc-Length',
                    style: TextStyle(
                      color: _kInk,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Path · PathMetrics · PathMetric · Tangent',
                    style: TextStyle(
                      color: _kAccent,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 18),
        const Text(
          'A Path object stores commands (moveTo, lineTo, curves) but does '
          'not in itself know how long it is or where the point at one-third '
          'of the way along sits. That information is computed on demand by '
          'PathMetrics, which flattens each contour into a measurable curve. '
          'Once you hold a PathMetric, you can ask for tangents at arc-distances, '
          'extract sub-segments, or distribute equally-spaced markers along '
          'curved geometry — the building blocks of dashed strokes, marching '
          'ants, "draw-on" reveals and label-along-path layouts.',
          style: TextStyle(
            color: _kInkDim,
            fontSize: 14,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 18),
        Row(
          children: <Widget>[
            _heroPill('one-shot iterable', _kAccent),
            const SizedBox(width: 10),
            _heroPill('per-contour', _kAccent2),
            const SizedBox(width: 10),
            _heroPill('arc-length parameterised', _kAccent3),
            const SizedBox(width: 10),
            _heroPill('GPU-free geometry', _kAccent4),
          ],
        ),
      ],
    ),
  );
}

Widget _heroPill(String text, Color colour) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.15),
      borderRadius: BorderRadius.circular(999),
      border: Border.all(color: colour.withOpacity(0.45)),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: colour,
        fontSize: 11,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

// =====================================================================
// SHARED PRIMITIVES
// =====================================================================

Widget _sectionFrame({
  required String number,
  required String title,
  required String subtitle,
  required List<Color> headerGradient,
  required List<String> paragraphs,
  required List<Widget> body,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _kPanel,
      borderRadius: BorderRadius.circular(20),
      border: Border.all(color: Color(0x22FFFFFF)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Color(0x66000000),
          blurRadius: 24,
          offset: Offset(0, 8),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: headerGradient,
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white.withOpacity(0.4)),
                ),
                child: Center(
                  child: Text(
                    number,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.6,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (final String p in paragraphs) ...<Widget>[
                Text(
                  p,
                  style: const TextStyle(
                    color: _kInkDim,
                    fontSize: 13.5,
                    height: 1.6,
                  ),
                ),
                const SizedBox(height: 12),
              ],
              const SizedBox(height: 6),
              ...body,
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _label(String text, Color colour) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
    decoration: BoxDecoration(
      color: colour.withOpacity(0.18),
      border: Border.all(color: colour.withOpacity(0.55)),
      borderRadius: BorderRadius.circular(6),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: colour,
        fontSize: 10,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    ),
  );
}

Widget _miniCode(String code, {Color? glow}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    decoration: BoxDecoration(
      color: Color(0xFF0A1426),
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: (glow ?? _kAccent).withOpacity(0.35)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: (glow ?? _kAccent).withOpacity(0.14),
          blurRadius: 14,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Text(
      code,
      style: const TextStyle(
        color: _kInk,
        fontFamily: 'monospace',
        fontSize: 12,
        height: 1.55,
      ),
    ),
  );
}

Widget _dot(double size, Color colour, {double glow = 0.55}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: colour,
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: colour.withOpacity(glow),
          blurRadius: 8,
          offset: Offset(0, 0),
        ),
      ],
    ),
  );
}

Widget _arrow(double length, double thickness, Color colour) {
  // A simple arrow drawn with two stacked Containers — a shaft and a head.
  return SizedBox(
    width: length,
    height: thickness * 3,
    child: Stack(
      alignment: Alignment.centerLeft,
      children: <Widget>[
        Positioned(
          left: 0,
          right: thickness * 2,
          top: thickness,
          child: Container(
            height: thickness,
            decoration: BoxDecoration(
              color: colour,
              borderRadius: BorderRadius.circular(thickness / 2),
            ),
          ),
        ),
        Positioned(
          right: 0,
          child: Transform.rotate(
            angle: math.pi / 4,
            child: Container(
              width: thickness * 2,
              height: thickness * 2,
              decoration: BoxDecoration(
                color: colour,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(thickness / 2),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// Iterate PathMetrics using its iterator (no for-in over BridgedInstance).
List<ui.PathMetric> _collectMetrics(ui.Path path) {
  final List<ui.PathMetric> out = <ui.PathMetric>[];
  final ui.PathMetrics metrics = path.computeMetrics();
  final Iterator<ui.PathMetric> it = metrics.iterator;
  while (it.moveNext()) {
    out.add(it.current);
  }
  return out;
}

// Sample N tangents at evenly spaced fractions in [0, 1) of length.
List<ui.Tangent> _sampleTangents(ui.PathMetric metric, int n) {
  final List<ui.Tangent> out = <ui.Tangent>[];
  final double L = metric.length;
  for (int i = 0; i < n; i++) {
    final double t = i / n;
    final ui.Tangent? tan = metric.getTangentForOffset(t * L);
    if (tan != null) {
      out.add(tan);
    }
  }
  return out;
}

// Sample N positions at fractions in [0, 1] (inclusive) for rendering.
List<Offset> _samplePositions(ui.PathMetric metric, int n) {
  final List<Offset> out = <Offset>[];
  final double L = metric.length;
  for (int i = 0; i <= n; i++) {
    final double t = i / n;
    final ui.Tangent? tan = metric.getTangentForOffset(t * L);
    if (tan != null) {
      out.add(tan.position);
    }
  }
  return out;
}

// =====================================================================
// SECTION 1 — ANATOMY
// =====================================================================

Widget _section1Anatomy() {
  // Build a Path with three sub-paths so the diagram corresponds to a
  // genuine PathMetrics traversal: a rectangle, an open arc, and a
  // closed circle.
  final ui.Path demo = ui.Path();
  demo.addRect(const Rect.fromLTWH(0, 0, 60, 30));
  demo.moveTo(80, 0);
  demo.quadraticBezierTo(120, 50, 160, 0);
  demo.addOval(const Rect.fromLTWH(180, 0, 40, 40));

  final List<ui.PathMetric> metrics = _collectMetrics(demo);

  return _sectionFrame(
    number: '1',
    title: 'Anatomy of a Metric Walk',
    subtitle: 'Path → PathMetrics → PathMetric → Tangent',
    headerGradient: <Color>[Color(0xFF1F4068), Color(0xFF265B82)],
    paragraphs: <String>[
      'A Path is a recording of drawing commands. It can have many sub-paths '
          '(contours), each started by an implicit moveTo. computeMetrics() returns '
          'a PathMetrics — a one-shot iterable in which each PathMetric corresponds '
          'to exactly one contour and exposes the geometric measurements you actually '
          'need to do per-distance work.',
      'Iteration produces PathMetric records in the order the contours were added. '
          'Each record carries a contourIndex, a length in logical pixels, and an '
          'isClosed flag — and exposes getTangentForOffset(d), which returns a '
          'Tangent (position + unit vector + angle) for any d in [0, length].',
      'The diagram below shows the conceptual flow: one Path contains three '
          'contours; computeMetrics() yields three PathMetric records; each record '
          'can be queried for tangents and extractPath sub-segments. The lengths '
          'reported on the right are read directly from the live metrics.',
    ],
    body: <Widget>[
      _anatomyDiagram(metrics),
      const SizedBox(height: 18),
      _miniCode(
        'final ui.Path p = ui.Path()\n'
        '  ..addRect(rect)\n'
        '  ..moveTo(80, 0)..quadraticBezierTo(120, 50, 160, 0)\n'
        '  ..addOval(ovalRect);\n'
        '\n'
        'final ui.PathMetrics ms = p.computeMetrics();\n'
        'final Iterator<ui.PathMetric> it = ms.iterator;\n'
        'while (it.moveNext()) {\n'
        '  final ui.PathMetric m = it.current;\n'
        '  // m.length, m.isClosed, m.getTangentForOffset(d), m.extractPath(a, b)\n'
        '}',
      ),
    ],
  );
}

Widget _anatomyDiagram(List<ui.PathMetric> metrics) {
  // 3-column flow: Path → PathMetrics → PathMetric (one row per contour)
  final List<Color> rowColours = <Color>[_kAccent, _kAccent2, _kAccent3, _kAccent4, _kAccent5];
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: _kPanelLight,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Color(0x22FFFFFF)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Column A — the Path
        Expanded(
          flex: 3,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _label('Path', _kAccent),
              const SizedBox(height: 8),
              const Text(
                'Source geometry',
                style: TextStyle(color: _kInk, fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              Container(
                height: 92,
                decoration: BoxDecoration(
                  color: _kBg,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Color(0x22FFFFFF)),
                ),
                child: Stack(
                  children: <Widget>[
                    // sub-path 1 (rectangle outline)
                    Positioned(
                      left: 12,
                      top: 18,
                      child: Container(
                        width: 60,
                        height: 30,
                        decoration: BoxDecoration(
                          border: Border.all(color: _kAccent, width: 2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ),
                    // sub-path 2 (quad bezier — approximated by dots)
                    ..._dotsAlongQuad(
                      const Offset(90, 60),
                      const Offset(120, 18),
                      const Offset(150, 60),
                      _kAccent2,
                      14,
                    ),
                    // sub-path 3 (circle outline)
                    Positioned(
                      left: 168,
                      top: 28,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: _kAccent3, width: 2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '3 sub-paths · ordered',
                style: TextStyle(color: _kInkFaint, fontSize: 11),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        // arrow
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: _arrow(36, 2, _kInkFaint),
        ),
        const SizedBox(width: 8),
        // Column B — PathMetrics
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _label('PathMetrics', _kAccent2),
              const SizedBox(height: 8),
              const Text(
                'One-shot iterable',
                style: TextStyle(color: _kInk, fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              for (int i = 0; i < metrics.length; i++) ...<Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: rowColours[i % rowColours.length].withOpacity(0.12),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: rowColours[i % rowColours.length].withOpacity(0.55)),
                  ),
                  child: Row(
                    children: <Widget>[
                      _dot(8, rowColours[i % rowColours.length]),
                      const SizedBox(width: 8),
                      Text(
                        'metric #${metrics[i].contourIndex}',
                        style: TextStyle(
                          color: rowColours[i % rowColours.length],
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              const SizedBox(height: 4),
              const Text(
                'iterator.moveNext()',
                style: TextStyle(color: _kInkFaint, fontSize: 11, fontFamily: 'monospace'),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Padding(
          padding: const EdgeInsets.only(top: 60),
          child: _arrow(36, 2, _kInkFaint),
        ),
        const SizedBox(width: 8),
        // Column C — PathMetric details
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _label('PathMetric', _kAccent3),
              const SizedBox(height: 8),
              const Text(
                'Per-contour facts',
                style: TextStyle(color: _kInk, fontSize: 13, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),
              for (int i = 0; i < metrics.length; i++) ...<Widget>[
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: _kBg,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: rowColours[i % rowColours.length].withOpacity(0.45)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          _dot(8, rowColours[i % rowColours.length]),
                          const SizedBox(width: 6),
                          Text(
                            '#${metrics[i].contourIndex}',
                            style: TextStyle(
                              color: rowColours[i % rowColours.length],
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            metrics[i].isClosed ? 'closed' : 'open',
                            style: TextStyle(
                              color: metrics[i].isClosed ? _kOk : _kWarn,
                              fontSize: 10,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'length = ${metrics[i].length.toStringAsFixed(2)} px',
                        style: const TextStyle(
                          color: _kInkDim,
                          fontSize: 11,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    ),
  );
}

List<Widget> _dotsAlongQuad(
  Offset a,
  Offset b,
  Offset c,
  Color colour,
  int n,
) {
  // Approximate a quadratic Bézier at parametric t in [0, 1] for the
  // anatomy diagram. (Used only for the flow diagram, not for the
  // PathMetric demos themselves.)
  final List<Widget> out = <Widget>[];
  for (int i = 0; i <= n; i++) {
    final double t = i / n;
    final double u = 1 - t;
    final double x = u * u * a.dx + 2 * u * t * b.dx + t * t * c.dx;
    final double y = u * u * a.dy + 2 * u * t * b.dy + t * t * c.dy;
    out.add(Positioned(
      left: x - 2,
      top: y - 2,
      child: _dot(4, colour),
    ));
  }
  return out;
}

// =====================================================================
// SECTION 2 — LENGTH SAMPLER
// =====================================================================

Widget _section2LengthSampler() {
  // Build five distinct paths and read their .length from PathMetrics.
  // The bar widths are then derived from those lengths.

  // 1. Straight line
  final ui.Path p1 = ui.Path()
    ..moveTo(0, 0)
    ..lineTo(160, 0);

  // 2. Quarter-arc: arcTo on a 120x120 oval, sweeping 90 degrees.
  final ui.Path p2 = ui.Path()
    ..addArc(
      const Rect.fromLTWH(0, 0, 240, 240),
      0,
      math.pi / 2,
    );

  // 3. Quadratic bezier
  final ui.Path p3 = ui.Path()
    ..moveTo(0, 0)
    ..quadraticBezierTo(80, 120, 200, 0);

  // 4. Cubic bezier (S-curve)
  final ui.Path p4 = ui.Path()
    ..moveTo(0, 60)
    ..cubicTo(80, -40, 140, 160, 240, 60);

  // 5. Rounded rectangle (closed)
  final ui.Path p5 = ui.Path()
    ..addRRect(
      RRect.fromRectAndRadius(
        const Rect.fromLTWH(0, 0, 200, 100),
        const Radius.circular(28),
      ),
    );

  // 6. Polygon (closed) — pentagon
  final ui.Path p6 = ui.Path();
  for (int i = 0; i < 5; i++) {
    final double a = -math.pi / 2 + i * (math.pi * 2 / 5);
    final double x = 80 + 70 * math.cos(a);
    final double y = 80 + 70 * math.sin(a);
    if (i == 0) {
      p6.moveTo(x, y);
    } else {
      p6.lineTo(x, y);
    }
  }
  p6.close();

  final List<_LengthRow> rows = <_LengthRow>[
    _LengthRow('straight line',     'lineTo',                p1, _kAccent),
    _LengthRow('quarter arc',       'addArc 90°',            p2, _kAccent2),
    _LengthRow('quadratic bezier',  'quadraticBezierTo',     p3, _kAccent3),
    _LengthRow('cubic bezier',      'cubicTo',               p4, _kAccent4),
    _LengthRow('rounded rectangle', 'addRRect (closed)',     p5, _kAccent5),
    _LengthRow('regular pentagon',  'lineTo×5 + close',      p6, _kAccent6),
  ];

  // Resolve metrics + length for each row.
  final List<double> lengths = <double>[];
  final List<bool> closed = <bool>[];
  double maxLength = 1.0;
  for (final _LengthRow r in rows) {
    final List<ui.PathMetric> ms = _collectMetrics(r.path);
    double total = 0;
    bool isClosed = false;
    for (final ui.PathMetric m in ms) {
      total += m.length;
      if (m.isClosed) isClosed = true;
    }
    lengths.add(total);
    closed.add(isClosed);
    if (total > maxLength) maxLength = total;
  }

  return _sectionFrame(
    number: '2',
    title: 'Length Sampler',
    subtitle: 'PathMetric.length across five geometries',
    headerGradient: <Color>[Color(0xFF1F4068), Color(0xFF1F6855)],
    paragraphs: <String>[
      'PathMetric.length reports the arc-length of one contour in logical pixels. '
          'Engine implementations flatten curves into many tiny line segments and '
          'sum their Euclidean lengths, so even a high-curvature cubic resolves '
          'to a deterministic scalar suitable for animation timing.',
      'Below, six different paths are constructed and their lengths read from '
          'live PathMetric records. The coloured bars are scaled relative to the '
          'longest contour in the set — so you can immediately see how a quarter '
          'arc on a 240×240 box compares to a 200-pixel straight line, and why a '
          'cubic Bézier can be much longer than the bounding rectangle suggests.',
      'For paths with multiple contours we sum the per-metric lengths. The '
          'closed flag in the badge is true if any contour reports isClosed; this '
          'is a convention we choose for this gallery — there is no single '
          'whole-path "isClosed" property in the API.',
    ],
    body: <Widget>[
      for (int i = 0; i < rows.length; i++)
        _lengthBarRow(rows[i], lengths[i], closed[i], maxLength),
      const SizedBox(height: 8),
      _miniCode(
        'final List<ui.PathMetric> ms = _collectMetrics(path);\n'
        'double total = 0;\n'
        'for (final ui.PathMetric m in ms) {\n'
        '  total += m.length;\n'
        '}\n',
        glow: _kAccent3,
      ),
    ],
  );
}

class _LengthRow {
  final String name;
  final String code;
  final ui.Path path;
  final Color colour;
  const _LengthRow(this.name, this.code, this.path, this.colour);
}

Widget _lengthBarRow(_LengthRow row, double length, bool isClosed, double maxLength) {
  final double w = (length / maxLength).clamp(0.02, 1.0);
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kPanelLight,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: row.colour.withOpacity(0.35)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _dot(10, row.colour),
            const SizedBox(width: 10),
            Text(
              row.name,
              style: const TextStyle(
                color: _kInk,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(width: 10),
            _label(row.code, row.colour),
            const Spacer(),
            _label(isClosed ? 'closed' : 'open', isClosed ? _kOk : _kWarn),
            const SizedBox(width: 8),
            Text(
              '${length.toStringAsFixed(1)} px',
              style: const TextStyle(
                color: _kInk,
                fontSize: 13,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints c) {
            final double barW = c.maxWidth;
            return Stack(
              children: <Widget>[
                Container(
                  width: barW,
                  height: 14,
                  decoration: BoxDecoration(
                    color: Color(0xFF0A1426),
                    borderRadius: BorderRadius.circular(7),
                  ),
                ),
                Container(
                  width: barW * w,
                  height: 14,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: <Color>[
                        row.colour.withOpacity(0.65),
                        row.colour,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(7),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: row.colour.withOpacity(0.5),
                        blurRadius: 10,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 3 — TANGENT DIRECTION GRID
// =====================================================================

Widget _section3TangentGrid() {
  // Build a circle path centred in a 260x260 region. Sample many points
  // for the visible curve, then sample 12 evenly-spaced tangents to
  // overlay rotated arrows.
  final double size = 260;
  final double cx = size / 2;
  final double cy = size / 2;
  final double r = 100;

  final ui.Path circle = ui.Path()
    ..addOval(Rect.fromCircle(center: Offset(cx, cy), radius: r));

  final List<ui.PathMetric> ms = _collectMetrics(circle);
  final ui.PathMetric m = ms.first;
  // Many dots — visible curve.
  final List<Offset> curve = _samplePositions(m, 96);
  // Twelve tangent samples — overlaid arrows.
  final List<ui.Tangent> tangents = _sampleTangents(m, 12);

  // A second example: a sine-wave open path so we can show that
  // tangent angle changes sign across inflections.
  final ui.Path sine = ui.Path()..moveTo(0, 60);
  for (int i = 1; i <= 80; i++) {
    final double x = i * 3.0;
    final double y = 60 + 40 * math.sin(i * 0.18);
    sine.lineTo(x, y);
  }
  final List<ui.PathMetric> sineM = _collectMetrics(sine);
  final ui.PathMetric sm = sineM.first;
  final List<Offset> sineCurve = _samplePositions(sm, 120);
  final List<ui.Tangent> sineTangents = _sampleTangents(sm, 14);

  return _sectionFrame(
    number: '3',
    title: 'Tangents Around a Curve',
    subtitle: 'getTangentForOffset → position + angle',
    headerGradient: <Color>[Color(0xFF482F7A), Color(0xFF7A4FA8)],
    paragraphs: <String>[
      'getTangentForOffset(d) takes a single arc-distance and returns a Tangent: '
          'a point on the contour and a unit vector pointing in the direction of '
          'forward travel. The Tangent.angle convenience returns atan2(-vy, vx), '
          'because Flutter\'s Y axis points down — using that convention lets you '
          'feed the angle straight into Transform.rotate without sign hacks.',
      'Below, the small dots trace the actual curve sampled at 96 fractions of '
          'arc-length. The brighter arrows are 12 evenly spaced tangents — each '
          'rendered as a Transform.rotate around its sample point. The arrows '
          'always point along the contour\'s travel direction, which on a circle '
          'sweeps cleanly through 2π.',
      'The second example is an open sine-wave polyline. Tangent angles ramp up '
          'and down as the curve undulates, and the markers stay perfectly aligned '
          'with the line because the angles are read from the same metric used to '
          'plot the dots.',
    ],
    body: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _tangentSurface(
            size: size,
            curveDots: curve,
            tangents: tangents,
            label: 'circle (closed)',
            badge: '${m.length.toStringAsFixed(1)} px · 12 samples',
            colour: _kAccent2,
            arrowColour: _kAccent3,
          ),
          const SizedBox(width: 18),
          Expanded(
            child: _tangentLegend(tangents),
          ),
        ],
      ),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kPanelLight,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Color(0x33FFFFFF)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _label('open path', _kWarn),
                const SizedBox(width: 8),
                Text(
                  'sine wave · ${sm.length.toStringAsFixed(1)} px',
                  style: const TextStyle(
                    color: _kInk,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 130,
              child: Stack(
                children: <Widget>[
                  for (final Offset o in sineCurve)
                    Positioned(
                      left: o.dx,
                      top: o.dy,
                      child: _dot(2.5, _kAccent),
                    ),
                  for (final ui.Tangent t in sineTangents)
                    Positioned(
                      left: t.position.dx - 14,
                      top: t.position.dy - 4,
                      child: Transform.rotate(
                        angle: -t.angle,
                        child: _arrow(28, 1.5, _kAccent4),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      _miniCode(
        'final ui.PathMetric m = path.computeMetrics().iterator..moveNext();\n'
        '// repeated samples at evenly spaced fractions of m.length\n'
        'for (int i = 0; i < 12; i++) {\n'
        '  final double d = (i / 12) * m.length;\n'
        '  final ui.Tangent? t = m.getTangentForOffset(d);\n'
        '  if (t != null) place(t.position, angle: t.angle);\n'
        '}',
        glow: _kAccent2,
      ),
    ],
  );
}

Widget _tangentSurface({
  required double size,
  required List<Offset> curveDots,
  required List<ui.Tangent> tangents,
  required String label,
  required String badge,
  required Color colour,
  required Color arrowColour,
}) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: _kBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: colour.withOpacity(0.35)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: colour.withOpacity(0.18),
          blurRadius: 18,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Stack(
      children: <Widget>[
        // dots along the curve
        for (final Offset o in curveDots)
          Positioned(
            left: o.dx - 1.5,
            top: o.dy - 1.5,
            child: _dot(3, colour, glow: 0.35),
          ),
        // tangent samples
        for (int i = 0; i < tangents.length; i++) ...<Widget>[
          // sample point itself
          Positioned(
            left: tangents[i].position.dx - 4,
            top: tangents[i].position.dy - 4,
            child: _dot(8, arrowColour),
          ),
          // little rotated arrow
          Positioned(
            left: tangents[i].position.dx - 18,
            top: tangents[i].position.dy - 4,
            child: Transform.rotate(
              angle: -tangents[i].angle,
              child: _arrow(36, 2, arrowColour),
            ),
          ),
        ],
        Positioned(
          left: 10,
          top: 10,
          child: _label(label, colour),
        ),
        Positioned(
          left: 10,
          bottom: 10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xCC0A1426),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Color(0x44FFFFFF)),
            ),
            child: Text(
              badge,
              style: const TextStyle(
                color: _kInk,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _tangentLegend(List<ui.Tangent> tangents) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kPanelLight,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Color(0x33FFFFFF)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Sample report',
          style: TextStyle(
            color: _kInk,
            fontSize: 13,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        for (int i = 0; i < tangents.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: Row(
              children: <Widget>[
                Text(
                  '#${i.toString().padLeft(2, '0')}',
                  style: const TextStyle(
                    color: _kInkFaint,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '(${tangents[i].position.dx.toStringAsFixed(0)},'
                  '${tangents[i].position.dy.toStringAsFixed(0)})',
                  style: const TextStyle(
                    color: _kInkDim,
                    fontSize: 11,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  '${(tangents[i].angle * 180 / math.pi).toStringAsFixed(0)}°',
                  style: const TextStyle(
                    color: _kAccent3,
                    fontSize: 11,
                    fontFamily: 'monospace',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 4 — MULTI-CONTOUR WALK
// =====================================================================

Widget _section4MultiContour() {
  // Construct a single Path with three sub-paths so PathMetrics yields
  // three separate PathMetric records.
  final ui.Path multi = ui.Path();
  multi.addRect(const Rect.fromLTWH(0, 0, 110, 60)); // rectangle (closed)
  multi.addOval(const Rect.fromLTWH(140, 0, 60, 60)); // circle (closed)
  multi.moveTo(220, 0);
  multi.lineTo(280, 60);
  multi.lineTo(340, 0);
  multi.close(); // triangle (closed via close)

  // Plus an explicitly-open contour: a polyline with no .close().
  multi.moveTo(0, 90);
  multi.lineTo(100, 110);
  multi.lineTo(200, 90);
  multi.lineTo(300, 110);
  // (intentionally no close)

  final List<ui.PathMetric> metrics = _collectMetrics(multi);

  // Sample dots for each metric so we can render each contour in
  // its own colour as proof that they are independent.
  final List<List<Offset>> dotSets = <List<Offset>>[];
  for (final ui.PathMetric m in metrics) {
    dotSets.add(_samplePositions(m, 64));
  }

  final List<Color> contourColours = <Color>[
    _kAccent, _kAccent2, _kAccent3, _kAccent4, _kAccent5, _kAccent6,
  ];

  return _sectionFrame(
    number: '4',
    title: 'Walking Multiple Contours',
    subtitle: 'computeMetrics() yields one PathMetric per sub-path',
    headerGradient: <Color>[Color(0xFF305C44), Color(0xFF1F6855)],
    paragraphs: <String>[
      'A single Path can carry an arbitrary number of contours — every moveTo '
          'starts a new one, and shape helpers like addRect, addOval, addPolygon '
          'each push their own contour. PathMetrics returns one PathMetric per '
          'contour, in insertion order, with .contourIndex matching that order.',
      'This is the foundation for things like compound shapes (think text glyphs '
          'where the holes are separate contours), or for paths assembled from '
          'multiple primitives. Crucially, isClosed is per-contour: the rectangle, '
          'circle and triangle below are closed, while the trailing polyline is '
          'open even though it lives in the same Path.',
      'The visual on the right plots each contour in its own colour by sampling '
          'positions from that contour\'s metric. The list on the left summarises '
          'each metric record: contourIndex, isClosed, and length read straight '
          'from the live API.',
    ],
    body: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 5,
            child: _multiContourList(metrics, contourColours),
          ),
          const SizedBox(width: 18),
          Expanded(
            flex: 6,
            child: _multiContourSurface(dotSets, contourColours, metrics),
          ),
        ],
      ),
      const SizedBox(height: 12),
      _miniCode(
        'final ui.Path p = ui.Path()\n'
        '  ..addRect(rectA)\n'
        '  ..addOval(rectB)\n'
        '  ..moveTo(...)..lineTo(...)..lineTo(...)..close()\n'
        '  ..moveTo(...)..lineTo(...);\n'
        '\n'
        'final Iterator<ui.PathMetric> it = p.computeMetrics().iterator;\n'
        'while (it.moveNext()) {\n'
        '  final ui.PathMetric m = it.current;\n'
        '  print("#" + m.contourIndex.toString() + " closed=" + m.isClosed.toString());\n'
        '}',
        glow: _kAccent3,
      ),
    ],
  );
}

Widget _multiContourList(List<ui.PathMetric> metrics, List<Color> colours) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      for (int i = 0; i < metrics.length; i++)
        Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: _kPanelLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: colours[i % colours.length].withOpacity(0.45)),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 28,
                height: 28,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colours[i % colours.length].withOpacity(0.18),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colours[i % colours.length]),
                ),
                child: Text(
                  '${metrics[i].contourIndex}',
                  style: TextStyle(
                    color: colours[i % colours.length],
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'contour #${metrics[i].contourIndex}',
                      style: const TextStyle(
                        color: _kInk,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'length = ${metrics[i].length.toStringAsFixed(2)} px',
                      style: const TextStyle(
                        color: _kInkDim,
                        fontSize: 11,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ),
              ),
              _label(
                metrics[i].isClosed ? 'closed' : 'open',
                metrics[i].isClosed ? _kOk : _kWarn,
              ),
            ],
          ),
        ),
    ],
  );
}

Widget _multiContourSurface(
  List<List<Offset>> dotSets,
  List<Color> colours,
  List<ui.PathMetric> metrics,
) {
  return Container(
    height: 160,
    decoration: BoxDecoration(
      color: _kBg,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: Color(0x33FFFFFF)),
    ),
    padding: const EdgeInsets.all(12),
    child: Stack(
      children: <Widget>[
        for (int i = 0; i < dotSets.length; i++)
          for (final Offset o in dotSets[i])
            Positioned(
              left: o.dx,
              top: o.dy,
              child: _dot(3, colours[i % colours.length], glow: 0.45),
            ),
        Positioned(
          right: 8,
          top: 8,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xCC0A1426),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(color: Color(0x44FFFFFF)),
            ),
            child: Text(
              '${metrics.length} contours',
              style: const TextStyle(
                color: _kInk,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 5 — extractPath
// =====================================================================

Widget _section5ExtractPath() {
  // A long sinusoid: extract three sub-segments and compare lengths.
  final ui.Path full = ui.Path()..moveTo(0, 60);
  for (int i = 1; i <= 100; i++) {
    final double x = i * 3.0;
    final double y = 60 + 38 * math.sin(i * 0.16);
    full.lineTo(x, y);
  }

  final List<ui.PathMetric> ms = _collectMetrics(full);
  final ui.PathMetric m = ms.first;
  final double L = m.length;

  // Three sub-ranges expressed as fractions of total length.
  final List<List<double>> ranges = <List<double>>[
    <double>[0.00, 0.25],
    <double>[0.35, 0.65],
    <double>[0.75, 1.00],
  ];
  final List<Color> rangeColours = <Color>[_kAccent, _kAccent4, _kAccent5];

  // For each range, compute extractPath and re-measure to confirm.
  final List<double> subLengths = <double>[];
  final List<List<Offset>> subDots = <List<Offset>>[];
  for (final List<double> rg in ranges) {
    final ui.Path sub = m.extractPath(rg[0] * L, rg[1] * L);
    final List<ui.PathMetric> sm = _collectMetrics(sub);
    if (sm.isEmpty) {
      subLengths.add(0);
      subDots.add(<Offset>[]);
    } else {
      subLengths.add(sm.first.length);
      subDots.add(_samplePositions(sm.first, 60));
    }
  }

  // Full curve dots for backdrop
  final List<Offset> fullDots = _samplePositions(m, 160);

  return _sectionFrame(
    number: '5',
    title: 'Carving with extractPath',
    subtitle: 'PathMetric.extractPath(start, end)',
    headerGradient: <Color>[Color(0xFF6E4B1F), Color(0xFFA0641F)],
    paragraphs: <String>[
      'extractPath(start, end) returns a brand new Path covering the requested '
          'arc-distance range of one contour. Both arguments are in the same '
          'units as .length, and they must satisfy 0 ≤ start ≤ end ≤ length.',
      'This is exactly the operation behind animated "draw on stroke" effects — '
          'pass start = 0 and end = t * length where t ramps from 0 to 1 over '
          'time, and you get a Path that grows along the contour. Because the '
          'returned Path is just another Path, you can call computeMetrics on '
          'it and confirm that its length equals end − start (give or take the '
          'engine\'s flattening tolerance).',
      'The backdrop dots below trace the full contour. The three coloured '
          'overlays are extracted sub-paths at fractions [0, .25], [.35, .65] '
          'and [.75, 1.0] of the full length. The bar chart on the right '
          'compares the originally requested length to the actually-measured '
          'length of each extract.',
    ],
    body: <Widget>[
      Container(
        height: 160,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: _kBg,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Color(0x33FFFFFF)),
        ),
        child: Stack(
          children: <Widget>[
            for (final Offset o in fullDots)
              Positioned(
                left: o.dx,
                top: o.dy,
                child: _dot(2, _kInkFaint, glow: 0.2),
              ),
            for (int i = 0; i < subDots.length; i++)
              for (final Offset o in subDots[i])
                Positioned(
                  left: o.dx - 1,
                  top: o.dy - 1,
                  child: _dot(4, rangeColours[i]),
                ),
            Positioned(
              left: 10,
              top: 10,
              child: _label('full · ${L.toStringAsFixed(1)} px', _kInkFaint),
            ),
          ],
        ),
      ),
      const SizedBox(height: 14),
      for (int i = 0; i < ranges.length; i++)
        _extractCompareRow(ranges[i], L, subLengths[i], rangeColours[i]),
      const SizedBox(height: 8),
      _miniCode(
        'final ui.Path sub = metric.extractPath(start, end);\n'
        'final ui.PathMetric subMetric =\n'
        '    sub.computeMetrics().iterator..moveNext();\n'
        '// subMetric.length ≈ end - start\n',
        glow: _kAccent4,
      ),
    ],
  );
}

Widget _extractCompareRow(List<double> range, double totalLength, double measured, Color colour) {
  final double requested = (range[1] - range[0]) * totalLength;
  final double maxL = totalLength;
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: _kPanelLight,
      borderRadius: BorderRadius.circular(10),
      border: Border.all(color: colour.withOpacity(0.45)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            _dot(8, colour),
            const SizedBox(width: 8),
            Text(
              'extractPath(${(range[0] * totalLength).toStringAsFixed(1)}, '
              '${(range[1] * totalLength).toStringAsFixed(1)})',
              style: const TextStyle(
                color: _kInk,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
            const Spacer(),
            Text(
              'requested ${requested.toStringAsFixed(1)} · measured ${measured.toStringAsFixed(1)}',
              style: const TextStyle(
                color: _kInkDim,
                fontSize: 11,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LayoutBuilder(
          builder: (BuildContext context, BoxConstraints c) {
            final double w = c.maxWidth;
            return Stack(
              children: <Widget>[
                Container(
                  width: w,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Color(0xFF0A1426),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Container(
                  width: w * (requested / maxL).clamp(0.0, 1.0),
                  height: 10,
                  decoration: BoxDecoration(
                    color: colour.withOpacity(0.45),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                Container(
                  width: w * (measured / maxL).clamp(0.0, 1.0),
                  height: 10,
                  decoration: BoxDecoration(
                    color: colour,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 6 — RECIPE GALLERY
// =====================================================================

Widget _section6Recipes() {
  return _sectionFrame(
    number: '6',
    title: 'Recipe Gallery',
    subtitle: 'Practical patterns built on PathMetrics',
    headerGradient: <Color>[Color(0xFF7A2F66), Color(0xFFA84F8B)],
    paragraphs: <String>[
      'Once you have a Tangent at any arc-distance, a flood of UI tricks become '
          'one-liners. Below are four hand-built static reductions of the most '
          'common patterns: each uses a real path, a real PathMetric, and real '
          'tangent samples — only the time variable has been frozen.',
      'These are the building blocks for animated borders, "draw on" reveals, '
          'distributing labels along curves, and computing equal-arc tick marks. '
          'In a real app you\'d take the same data and feed a varying t into '
          'extractPath or getTangentForOffset on every frame; here we render the '
          'final state for clarity.',
      'Notice how each recipe leans on a different facet of the API: one needs '
          'extractPath to build dashes, another reads positions only, a third '
          'reads positions+angles to align text, and the fourth distributes '
          'markers proportionally to length.',
    ],
    body: <Widget>[
      _recipe1DashedBorder(),
      const SizedBox(height: 12),
      _recipe2DrawOn(),
      const SizedBox(height: 12),
      _recipe3LabelAlong(),
      const SizedBox(height: 12),
      _recipe4EqualTicks(),
    ],
  );
}

Widget _recipeFrame({
  required String title,
  required String prose,
  required Widget visual,
  required Color colour,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kPanelLight,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: colour.withOpacity(0.4)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: colour.withOpacity(0.18),
          blurRadius: 14,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _label(title, colour),
              const SizedBox(height: 10),
              Text(
                prose,
                style: const TextStyle(
                  color: _kInkDim,
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(flex: 5, child: visual),
      ],
    ),
  );
}

Widget _recipe1DashedBorder() {
  // A rounded rectangle border made of dashes via repeated extractPath.
  final ui.Path frame = ui.Path()
    ..addRRect(RRect.fromRectAndRadius(
      const Rect.fromLTWH(8, 8, 264, 110),
      const Radius.circular(20),
    ));
  final ui.PathMetric m = _collectMetrics(frame).first;
  final double L = m.length;
  final double dash = 14;
  final double gap = 8;
  final List<List<Offset>> dashSegments = <List<Offset>>[];
  double d = 0;
  while (d < L) {
    final double end = (d + dash).clamp(0.0, L);
    final ui.Path sub = m.extractPath(d, end);
    final List<ui.PathMetric> sm = _collectMetrics(sub);
    if (sm.isNotEmpty) {
      dashSegments.add(_samplePositions(sm.first, 8));
    }
    d += dash + gap;
  }

  return _recipeFrame(
    title: 'animated dashed border',
    prose:
        'Walk the contour in (dash + gap) steps and call extractPath(d, d + dash) '
        'for each. The resulting Paths can be stroked or — as here — sampled into '
        'dot segments. Time-varying offset modulus (dash + gap) gives marching ants.',
    visual: Container(
      height: 130,
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0x33FFFFFF)),
      ),
      child: Stack(
        children: <Widget>[
          for (final List<Offset> seg in dashSegments)
            for (final Offset o in seg)
              Positioned(
                left: o.dx,
                top: o.dy,
                child: _dot(3, _kAccent3),
              ),
        ],
      ),
    ),
    colour: _kAccent3,
  );
}

Widget _recipe2DrawOn() {
  // A spiral being progressively revealed using extractPath(0, t * length).
  final ui.Path spiral = ui.Path()..moveTo(140, 70);
  for (int i = 1; i <= 240; i++) {
    final double t = i / 240;
    final double a = t * math.pi * 5.5;
    final double r = t * 60;
    final double x = 140 + r * math.cos(a);
    final double y = 70 + r * math.sin(a);
    spiral.lineTo(x, y);
  }
  final ui.PathMetric m = _collectMetrics(spiral).first;
  final double L = m.length;
  final double t = 0.62; // a frozen "now"
  final ui.Path drawn = m.extractPath(0, t * L);
  final List<ui.PathMetric> dm = _collectMetrics(drawn);
  final List<Offset> drawnDots = dm.isNotEmpty ? _samplePositions(dm.first, 160) : <Offset>[];
  final List<Offset> fullDots = _samplePositions(m, 240);

  return _recipeFrame(
    title: 'draw-on stroke effect',
    prose:
        'Holding extractPath(0, t × length) for t in [0, 1] grows a Path along the '
        'contour. Pair it with a stroked Paint and an AnimationController and you '
        'have signature-style reveals or animated icons.',
    visual: Container(
      height: 150,
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0x33FFFFFF)),
      ),
      child: Stack(
        children: <Widget>[
          for (final Offset o in fullDots)
            Positioned(
              left: o.dx,
              top: o.dy,
              child: _dot(2, _kInkFaint, glow: 0.15),
            ),
          for (final Offset o in drawnDots)
            Positioned(
              left: o.dx - 1,
              top: o.dy - 1,
              child: _dot(3.5, _kAccent2),
            ),
          Positioned(
            right: 8,
            top: 8,
            child: _label('t = ${t.toStringAsFixed(2)}', _kAccent2),
          ),
        ],
      ),
    ),
    colour: _kAccent2,
  );
}

Widget _recipe3LabelAlong() {
  // A wavy path with letters placed along it using getTangentForOffset.
  final ui.Path wave = ui.Path()..moveTo(10, 60);
  for (int i = 1; i <= 100; i++) {
    final double x = 10 + i * 2.6;
    final double y = 60 + 24 * math.sin(i * 0.16);
    wave.lineTo(x, y);
  }
  final ui.PathMetric m = _collectMetrics(wave).first;
  final double L = m.length;
  const String label = 'PATH METRICS';
  final List<Widget> letters = <Widget>[];
  for (int i = 0; i < label.length; i++) {
    final double frac = (i + 0.5) / label.length;
    final ui.Tangent? tan = m.getTangentForOffset(frac * L * 0.95);
    if (tan != null) {
      letters.add(Positioned(
        left: tan.position.dx - 6,
        top: tan.position.dy - 10,
        child: Transform.rotate(
          angle: -tan.angle,
          child: Text(
            label[i],
            style: const TextStyle(
              color: _kAccent4,
              fontSize: 14,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
      ));
    }
  }
  final List<Offset> waveDots = _samplePositions(m, 140);

  return _recipeFrame(
    title: 'label along a path',
    prose:
        'For each character, ask the metric for a tangent at a different fraction '
        'of length. Use the tangent\'s position to place the glyph and its angle to '
        'rotate it. Reading is preserved because each letter follows the local '
        'direction of travel, not a fixed axis.',
    visual: Container(
      height: 140,
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0x33FFFFFF)),
      ),
      child: Stack(
        children: <Widget>[
          for (final Offset o in waveDots)
            Positioned(
              left: o.dx,
              top: o.dy,
              child: _dot(2, _kInkFaint, glow: 0.2),
            ),
          ...letters,
        ],
      ),
    ),
    colour: _kAccent4,
  );
}

Widget _recipe4EqualTicks() {
  // Two paths of different lengths, each receives 12 equal-arc tick marks.
  final ui.Path arc1 = ui.Path()
    ..addArc(const Rect.fromLTWH(0, 0, 280, 120), math.pi, math.pi);
  final ui.Path arc2 = ui.Path()
    ..moveTo(0, 30)
    ..quadraticBezierTo(140, -30, 280, 60);

  final ui.PathMetric m1 = _collectMetrics(arc1).first;
  final ui.PathMetric m2 = _collectMetrics(arc2).first;

  // 12 evenly spaced ticks per path, with their tangent angle to draw little
  // perpendicular bars.
  List<Widget> _ticks(ui.PathMetric m, Color colour) {
    final List<Widget> out = <Widget>[];
    final double L = m.length;
    for (int i = 0; i <= 12; i++) {
      final double d = (i / 12) * L;
      final ui.Tangent? t = m.getTangentForOffset(d);
      if (t == null) continue;
      out.add(Positioned(
        left: t.position.dx - 8,
        top: t.position.dy - 1,
        child: Transform.rotate(
          angle: -t.angle + math.pi / 2,
          child: Container(
            width: 16,
            height: 2,
            decoration: BoxDecoration(
              color: colour,
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
      ));
    }
    return out;
  }

  return _recipeFrame(
    title: 'equal-arc-length ticks',
    prose:
        'Distributing N markers at i × length / N gives equal arc-length spacing — '
        'a clean way to mark progress on a non-linear path. Read the tangent at each '
        'tick to orient the marker perpendicular to the curve.',
    visual: Container(
      height: 160,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0x33FFFFFF)),
      ),
      child: Stack(
        children: <Widget>[
          for (final Offset o in _samplePositions(m1, 120))
            Positioned(
              left: o.dx,
              top: o.dy,
              child: _dot(2, _kInkFaint, glow: 0.18),
            ),
          ..._ticks(m1, _kAccent5),
          for (final Offset o in _samplePositions(m2, 120))
            Positioned(
              left: o.dx,
              top: o.dy + 10,
              child: _dot(2, _kInkFaint, glow: 0.18),
            ),
          ..._ticks(m2, _kAccent6),
        ],
      ),
    ),
    colour: _kAccent5,
  );
}

// =====================================================================
// SECTION 7 — FOOTGUNS
// =====================================================================

Widget _section7Footguns() {
  return _sectionFrame(
    number: '7',
    title: 'Footguns & Pitfalls',
    subtitle: 'Common mistakes around PathMetrics',
    headerGradient: <Color>[Color(0xFF7A1F1F), Color(0xFFA8463A)],
    paragraphs: <String>[
      'PathMetrics is a small API but it has sharp edges. The three pitfalls '
          'below catch most newcomers. Each is paired with a small visual showing '
          'the symptom — usually empty output, an exception, or a misleading flag.',
      'Internalising these once will save you hours of debugging later: forgetting '
          'one-shot semantics, going outside the [0, length] domain, and treating '
          'isClosed as a property of the whole Path are the top three.',
      'In production code we recommend wrapping the iterator in your own helper '
          '(like _collectMetrics in this file) so consumers never need to think '
          'about reusability — they just receive a List<PathMetric>.',
    ],
    body: <Widget>[
      _footgun1(),
      const SizedBox(height: 12),
      _footgun2(),
      const SizedBox(height: 12),
      _footgun3(),
    ],
  );
}

Widget _footgunFrame({
  required String tag,
  required String title,
  required String prose,
  required Widget visual,
}) {
  return Container(
    padding: const EdgeInsets.all(14),
    decoration: BoxDecoration(
      color: _kPanelLight,
      borderRadius: BorderRadius.circular(14),
      border: Border.all(color: _kError.withOpacity(0.45)),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: _kError.withOpacity(0.16),
          blurRadius: 14,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 36,
          height: 36,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _kError.withOpacity(0.18),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _kError.withOpacity(0.7)),
          ),
          child: const Text(
            '!',
            style: TextStyle(
              color: _kError,
              fontWeight: FontWeight.w800,
              fontSize: 22,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  _label(tag, _kError),
                  const SizedBox(width: 8),
                  Text(
                    title,
                    style: const TextStyle(
                      color: _kInk,
                      fontSize: 13.5,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                prose,
                style: const TextStyle(
                  color: _kInkDim,
                  fontSize: 12.5,
                  height: 1.55,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 14),
        Expanded(flex: 4, child: visual),
      ],
    ),
  );
}

Widget _footgun1() {
  // Demonstrate one-shot iteration: a metrics object iterated to completion
  // yields nothing on a second iterator call.
  final ui.Path p = ui.Path()..addRect(const Rect.fromLTWH(0, 0, 80, 40));
  final ui.PathMetrics ms = p.computeMetrics();
  final List<int> firstPass = <int>[];
  final Iterator<ui.PathMetric> a = ms.iterator;
  while (a.moveNext()) {
    firstPass.add(a.current.contourIndex);
  }
  final List<int> secondPass = <int>[];
  // Calling .iterator on the same PathMetrics again is *not* guaranteed
  // to restart traversal — engines treat it as one-shot.
  final Iterator<ui.PathMetric> b = ms.iterator;
  while (b.moveNext()) {
    secondPass.add(b.current.contourIndex);
  }

  return _footgunFrame(
    tag: '#1',
    title: 'PathMetrics is one-shot',
    prose:
        'computeMetrics() returns a PathMetrics that you should iterate exactly '
        'once. Re-iterating is undefined; if you need a second pass, store the '
        'metrics in a List<PathMetric> on the first walk (as _collectMetrics does '
        'in this file) or call computeMetrics() again on the source Path.',
    visual: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0x33FFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              _label('1st pass', _kOk),
              const SizedBox(width: 8),
              Text(
                firstPass.toString(),
                style: const TextStyle(
                  color: _kInk,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: <Widget>[
              _label('2nd pass', _kError),
              const SizedBox(width: 8),
              Text(
                secondPass.isEmpty ? '[] (empty)' : secondPass.toString(),
                style: const TextStyle(
                  color: _kInk,
                  fontFamily: 'monospace',
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _footgun2() {
  // Out-of-range tangent — getTangentForOffset returns null outside [0, length].
  final ui.Path p = ui.Path()
    ..moveTo(0, 0)
    ..lineTo(120, 0);
  final ui.PathMetric m = _collectMetrics(p).first;
  final ui.Tangent? inRange = m.getTangentForOffset(60);
  final ui.Tangent? negative = m.getTangentForOffset(-1);
  final ui.Tangent? tooFar = m.getTangentForOffset(m.length + 50);

  String fmt(ui.Tangent? t) {
    if (t == null) return 'null';
    return '(${t.position.dx.toStringAsFixed(0)},${t.position.dy.toStringAsFixed(0)})';
  }

  return _footgunFrame(
    tag: '#2',
    title: 'Tangent offsets must be in [0, length]',
    prose:
        'Asking for a tangent below 0 or above length is undefined — the engine '
        'often returns null or the endpoint, depending on the platform. Always '
        'clamp distances to [0, m.length] before sampling.',
    visual: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0x33FFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'length = ${m.length.toStringAsFixed(1)} px',
            style: const TextStyle(
              color: _kInkDim,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 8),
          _kvRow('d = 60', fmt(inRange), _kOk),
          _kvRow('d = -1', fmt(negative), _kError),
          _kvRow('d = length+50', fmt(tooFar), _kError),
        ],
      ),
    ),
  );
}

Widget _kvRow(String k, String v, Color colour) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 110,
          child: Text(
            k,
            style: const TextStyle(
              color: _kInkDim,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ),
        Text(
          v,
          style: TextStyle(
            color: colour,
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    ),
  );
}

Widget _footgun3() {
  // isClosed is per-contour: a path with one open and one closed contour
  // doesn't have a single answer.
  final ui.Path mixed = ui.Path();
  mixed.addRect(const Rect.fromLTWH(0, 0, 60, 40)); // closed
  mixed.moveTo(80, 0);
  mixed.lineTo(180, 40); // open
  final List<ui.PathMetric> ms = _collectMetrics(mixed);

  return _footgunFrame(
    tag: '#3',
    title: 'isClosed is per-contour, not per-Path',
    prose:
        'There is no Path.isClosed property. Each PathMetric has its own isClosed '
        'flag that reflects whether its contour was closed (via close() or a '
        'closed shape helper). Mixed-state paths are common — you must walk '
        'the metrics to see them all.',
    visual: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: _kBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color(0x33FFFFFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (final ui.PathMetric m in ms)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: <Widget>[
                  Text(
                    'contour #${m.contourIndex}',
                    style: const TextStyle(
                      color: _kInkDim,
                      fontFamily: 'monospace',
                      fontSize: 11,
                    ),
                  ),
                  const SizedBox(width: 10),
                  _label(
                    m.isClosed ? 'closed' : 'open',
                    m.isClosed ? _kOk : _kWarn,
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}

// =====================================================================
// SECTION 8 — COMPARISON: PATH METRICS vs Path.contains
// =====================================================================

Widget _section8Comparison() {
  // Build a star-like path. Walk it with PathMetrics for the left side,
  // hit-test it with Path.contains for the right side.
  final ui.Path star = ui.Path();
  for (int i = 0; i < 10; i++) {
    final double a = -math.pi / 2 + i * (math.pi / 5);
    final double r = (i % 2 == 0) ? 70.0 : 30.0;
    final double x = 100 + r * math.cos(a);
    final double y = 90 + r * math.sin(a);
    if (i == 0) {
      star.moveTo(x, y);
    } else {
      star.lineTo(x, y);
    }
  }
  star.close();

  final ui.PathMetric m = _collectMetrics(star).first;
  final List<Offset> walk = _samplePositions(m, 200);

  // Hit-test grid for the right side
  final List<List<bool>> hits = <List<bool>>[];
  const int cols = 28;
  const int rows = 16;
  for (int r = 0; r < rows; r++) {
    final List<bool> row = <bool>[];
    for (int c = 0; c < cols; c++) {
      final double x = 8 + c * 7.0;
      final double y = 12 + r * 11.0;
      row.add(star.contains(Offset(x, y)));
    }
    hits.add(row);
  }

  return _sectionFrame(
    number: '8',
    title: 'Traversal vs Hit-Testing',
    subtitle: 'PathMetrics walks the boundary · contains() probes the interior',
    headerGradient: <Color>[Color(0xFF1F4068), Color(0xFF482F7A)],
    paragraphs: <String>[
      'PathMetrics and Path.contains answer fundamentally different questions. '
          'PathMetrics gives you the boundary as a 1-D arc, parameterised by length. '
          'contains() classifies arbitrary 2-D points against that boundary using '
          'the path\'s fill rule.',
      'In practice you choose between them based on the question: "where on the '
          'edge is one-third of the way?" → metrics. "is this tap inside the '
          'shape?" → contains. The two are complementary; mixing them lets you '
          'do things like "place a marker on the closest edge point", which uses '
          'both APIs together.',
      'Below the same star path is rendered twice. The left visual plots dots '
          'sampled at evenly spaced arc-distances — every point lies on the boundary. '
          'The right visual is a coarse 28×16 grid where each cell is shaded if '
          'Path.contains returned true at that position.',
    ],
    body: <Widget>[
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: _comparisonCard(
              title: 'PathMetrics walk',
              subtitle: '${walk.length} samples on boundary',
              colour: _kAccent,
              child: Stack(
                children: <Widget>[
                  for (final Offset o in walk)
                    Positioned(
                      left: o.dx,
                      top: o.dy,
                      child: _dot(2.5, _kAccent),
                    ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _comparisonCard(
              title: 'Path.contains probe',
              subtitle: '${cols * rows} grid hit-tests',
              colour: _kAccent5,
              child: Stack(
                children: <Widget>[
                  for (int r = 0; r < rows; r++)
                    for (int c = 0; c < cols; c++)
                      Positioned(
                        left: 8 + c * 7.0,
                        top: 12 + r * 11.0,
                        child: Container(
                          width: 5,
                          height: 5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: hits[r][c]
                                ? _kAccent5
                                : _kInkFaint.withOpacity(0.25),
                          ),
                        ),
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
      const SizedBox(height: 14),
      _miniCode(
        '// Boundary walk\n'
        'final ui.PathMetric m = path.computeMetrics().iterator..moveNext();\n'
        'for (double d = 0; d <= m.length; d += step) {\n'
        '  m.getTangentForOffset(d);\n'
        '}\n'
        '\n'
        '// Interior probe\n'
        'final bool inside = path.contains(Offset(x, y));',
        glow: _kAccent5,
      ),
    ],
  );
}

Widget _comparisonCard({
  required String title,
  required String subtitle,
  required Color colour,
  required Widget child,
}) {
  return Container(
    height: 200,
    padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
      color: _kBg,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: colour.withOpacity(0.45)),
    ),
    child: Stack(
      children: <Widget>[
        child,
        Positioned(
          left: 8,
          top: 8,
          child: _label(title, colour),
        ),
        Positioned(
          right: 8,
          top: 8,
          child: Text(
            subtitle,
            style: const TextStyle(
              color: _kInkFaint,
              fontSize: 10,
              fontFamily: 'monospace',
            ),
          ),
        ),
      ],
    ),
  );
}

// =====================================================================
// SECTION 9 — API SUMMARY TABLE
// =====================================================================

Widget _section9ApiTable() {
  return _sectionFrame(
    number: '9',
    title: 'API Summary',
    subtitle: 'Quick reference for the four types',
    headerGradient: <Color>[Color(0xFF253A5C), Color(0xFF1F6855)],
    paragraphs: <String>[
      'A consolidated cheatsheet for the symbols touched in the previous '
          'sections. Use it to remember which method belongs to which type — '
          'remember that PathMetrics is iterable and PathMetric is the per-contour '
          'record returned by that iteration.',
      'Tangent is a tiny value type with no methods of its own beyond ==/hashCode. '
          'You almost never construct it manually; it is produced by '
          'getTangentForOffset and consumed for its position, vector and angle.',
      'When in doubt: build a Path, call computeMetrics(), iterate once, and store '
          'the metrics in a List for repeated access. That single pattern covers '
          '95% of real-world use.',
    ],
    body: <Widget>[
      _apiTypeBlock(
        type: 'Path',
        colour: _kAccent,
        rows: <List<String>>[
          <String>['moveTo(x, y)', 'Begin a new contour at (x, y).'],
          <String>['lineTo(x, y)', 'Add a straight segment to (x, y).'],
          <String>['quadraticBezierTo(cx, cy, x, y)', 'Add a quadratic Bézier.'],
          <String>['cubicTo(c1x, c1y, c2x, c2y, x, y)', 'Add a cubic Bézier.'],
          <String>['addRect(rect)', 'Add a closed rectangle contour.'],
          <String>['addOval(rect)', 'Add a closed oval contour.'],
          <String>['addRRect(rrect)', 'Add a closed rounded rectangle.'],
          <String>['close()', 'Close the current contour.'],
          <String>['contains(offset)', 'Hit-test a point against the fill.'],
          <String>['computeMetrics({forceClosed})', 'Return PathMetrics for traversal.'],
        ],
      ),
      const SizedBox(height: 10),
      _apiTypeBlock(
        type: 'PathMetrics',
        colour: _kAccent2,
        rows: <List<String>>[
          <String>['iterator', 'Returns an Iterator<PathMetric>.'],
          <String>['(implements Iterable<PathMetric>)', 'One-shot — iterate once.'],
        ],
      ),
      const SizedBox(height: 10),
      _apiTypeBlock(
        type: 'PathMetric',
        colour: _kAccent3,
        rows: <List<String>>[
          <String>['length', 'Arc-length of this contour in pixels.'],
          <String>['isClosed', 'True iff this contour was closed.'],
          <String>['contourIndex', '0-based contour index in the source path.'],
          <String>['getTangentForOffset(d)', 'Return Tangent at arc-distance d.'],
          <String>['extractPath(start, end, {startWithMoveTo})', 'Sub-path over [start, end].'],
        ],
      ),
      const SizedBox(height: 10),
      _apiTypeBlock(
        type: 'Tangent',
        colour: _kAccent4,
        rows: <List<String>>[
          <String>['position', 'Offset on the contour.'],
          <String>['vector', 'Unit Offset along travel direction.'],
          <String>['angle', 'atan2(-vy, vx) — Y-flipped for Flutter.'],
        ],
      ),
    ],
  );
}

Widget _apiTypeBlock({
  required String type,
  required Color colour,
  required List<List<String>> rows,
}) {
  return Container(
    decoration: BoxDecoration(
      color: _kPanelLight,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: colour.withOpacity(0.45)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: <Color>[colour.withOpacity(0.18), colour.withOpacity(0.05)],
            ),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
          ),
          child: Row(
            children: <Widget>[
              _dot(10, colour),
              const SizedBox(width: 10),
              Text(
                type,
                style: TextStyle(
                  color: colour,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  fontFamily: 'monospace',
                  letterSpacing: 0.4,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              for (final List<String> r in rows)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        width: 240,
                        child: Text(
                          r[0],
                          style: const TextStyle(
                            color: _kInk,
                            fontSize: 12,
                            fontFamily: 'monospace',
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          r[1],
                          style: const TextStyle(
                            color: _kInkDim,
                            fontSize: 12,
                            height: 1.45,
                          ),
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

// =====================================================================
// FOOTER
// =====================================================================

Widget _footer() {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: <Color>[
          Color(0xFF142035),
          Color(0xFF101A33),
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(color: Color(0x22FFFFFF)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Recap',
          style: TextStyle(
            color: _kInk,
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Path describes geometry. PathMetrics flattens that geometry into '
          'measurable contours. PathMetric tells you how long a contour is, '
          'whether it is closed, and lets you sample tangents and extract '
          'sub-paths at any arc-distance. Tangent ties position and direction '
          'together for placement and rotation.',
          style: TextStyle(
            color: _kInkDim,
            fontSize: 13,
            height: 1.55,
          ),
        ),
        const SizedBox(height: 14),
        Row(
          children: <Widget>[
            _heroPill('walk once', _kAccent),
            const SizedBox(width: 8),
            _heroPill('clamp distances', _kWarn),
            const SizedBox(width: 8),
            _heroPill('per-contour facts', _kAccent3),
            const SizedBox(width: 8),
            _heroPill('compose with contains', _kAccent5),
          ],
        ),
      ],
    ),
  );
}
