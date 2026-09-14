// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
//
// D4rt deep visual demo: IOSScrollViewFlingVelocityTracker and friends.
//
// Design plan
// -----------
// This file is a static AST-rendered diagrammatic explainer for the
// fling velocity tracker family from package:flutter/gestures. We do
// not actually inject pointer events (the AST runner does not pump a
// real gesture arena). Everything is rendered as a diagram so the
// reader can see, side-by-side, what each tracker means.
//
// Sections:
//   1. Header banner and conceptual overview of velocity tracking.
//   2. The pointer sample stage: 12 dots along a curve with a velocity
//      arrow rendered via CustomPaint.
//   3. Comparison cards for VelocityTracker, IOSScrollViewFlingVelocityTracker
//      and MacOSScrollViewFlingVelocityTracker.
//   4. Sample-window weighting diagram: weights given to recent samples.
//   5. Edge case cards: single sample, stale samples, direction reversal.
//   6. Fling-deceleration curve diagram (post-release physics).
//   7. PointerDeviceKind compatibility matrix.
//   8. Custom physics recipes (code blocks).
//   9. Decision matrix: when to pick which tracker.
//   10. Glossary / final recap card.
//
// All colors derive from a Material 3 ColorScheme idiom. The file
// renders a Stateless root widget wrapped in MaterialApp / Scaffold /
// SingleChildScrollView, ending with a runApp(...) call.
//

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

// =====================================================================
// Sample data model: a single fake pointer sample on the demo stage.
// =====================================================================
class _Sample {
  final int index;
  final Offset position;
  final int tMs;
  final double weight;
  const _Sample(this.index, this.position, this.tMs, this.weight);
}

// =====================================================================
// Velocity computation result (purely for the diagram; this does not
// actually call into the real tracker).
// =====================================================================
class _ComputedVelocity {
  final String label;
  final Offset vector;
  final double magnitude;
  final Color color;
  final String note;
  const _ComputedVelocity(
    this.label,
    this.vector,
    this.magnitude,
    this.color,
    this.note,
  );
}

// =====================================================================
// Painter for the pointer sample stage.
// Draws a soft grid, 12 dots along a curve, and an arrow representing
// the computed velocity vector.
// =====================================================================
class _StagePainter extends CustomPainter {
  final List<_Sample> samples;
  final Offset velocity;
  final Color dotColor;
  final Color arrowColor;
  final Color gridColor;

  _StagePainter({
    required this.samples,
    required this.velocity,
    required this.dotColor,
    required this.arrowColor,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Background gradient.
    final bgPaint = Paint()
      ..shader = LinearGradient(
        colors: [Colors.white, Colors.blueGrey.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Offset.zero & size);
    canvas.drawRect(Offset.zero & size, bgPaint);

    // Grid.
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;
    const gridStep = 30.0;
    for (double x = 0; x < size.width; x += gridStep) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += gridStep) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    // Connect samples with a faint path.
    if (samples.length >= 2) {
      final pathPaint = Paint()
        ..color = dotColor.withValues(alpha: 0.35)
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;
      final p = Path();
      p.moveTo(samples.first.position.dx, samples.first.position.dy);
      for (int i = 1; i < samples.length; i++) {
        p.lineTo(samples[i].position.dx, samples[i].position.dy);
      }
      canvas.drawPath(p, pathPaint);
    }

    // Draw each sample as a dot. Older samples are smaller and dimmer.
    for (final s in samples) {
      final dotPaint = Paint()
        ..color = dotColor.withValues(alpha: 0.3 + 0.7 * s.weight);
      final r = 5.0 + 6.0 * s.weight;
      canvas.drawCircle(s.position, r, dotPaint);
      final ring = Paint()
        ..color = dotColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.5;
      canvas.drawCircle(s.position, r, ring);
    }

    // Velocity arrow from the most recent sample.
    if (samples.isNotEmpty) {
      final origin = samples.last.position;
      final tip = origin + velocity;
      final arrowPaint = Paint()
        ..color = arrowColor
        ..strokeWidth = 4.0
        ..style = PaintingStyle.stroke
        ..strokeCap = StrokeCap.round;
      canvas.drawLine(origin, tip, arrowPaint);
      // Arrow head: build two short legs by rotating the unit direction
      // by +/- 30 degrees around the tip and pulling back by headLen.
      final dir = tip - origin;
      final len = dir.distance;
      if (len > 0.001) {
        final ux = dir.dx / len;
        final uy = dir.dy / len;
        const headLen = 14.0;
        final ax = tip.dx - headLen * (ux * 0.866 - uy * 0.5);
        final ay = tip.dy - headLen * (uy * 0.866 + ux * 0.5);
        final bx = tip.dx - headLen * (ux * 0.866 + uy * 0.5);
        final by = tip.dy - headLen * (uy * 0.866 - ux * 0.5);
        final headPath = Path()
          ..moveTo(tip.dx, tip.dy)
          ..lineTo(ax, ay)
          ..lineTo(bx, by)
          ..close();
        final headPaint = Paint()..color = arrowColor;
        canvas.drawPath(headPath, headPaint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant _StagePainter oldDelegate) => true;
}

// =====================================================================
// Painter for the fling-deceleration curve.
// Plots three curves v(t) = v0 * base^(t*4) using a tiny pow / ln / exp
// approximation so we do not need to import dart:math.
// =====================================================================
class _DecelPainter extends CustomPainter {
  final Color iosColor;
  final Color macColor;
  final Color defaultColor;
  final Color gridColor;

  _DecelPainter({
    required this.iosColor,
    required this.macColor,
    required this.defaultColor,
    required this.gridColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()..color = Colors.grey.shade50;
    canvas.drawRect(Offset.zero & size, bgPaint);

    // Grid + axes.
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1.0;
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 30) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }
    final axisPaint = Paint()
      ..color = Colors.black87
      ..strokeWidth = 2.0;
    canvas.drawLine(Offset(40, size.height - 30),
        Offset(size.width - 10, size.height - 30), axisPaint);
    canvas.drawLine(Offset(40, 10), Offset(40, size.height - 30), axisPaint);

    void plot(double friction, Color c, int dash) {
      final p = Path();
      const v0 = 1.0;
      final originX = 40.0;
      final originY = size.height - 30.0;
      final spanX = size.width - 50.0;
      final spanY = size.height - 40.0;
      for (int i = 0; i <= 100; i++) {
        final t = i / 100.0;
        final v = v0 * _approxPow(friction, t * 4.0);
        final x = originX + t * spanX;
        final y = originY - v * spanY;
        if (i == 0) {
          p.moveTo(x, y);
        } else {
          p.lineTo(x, y);
        }
      }
      final paint = Paint()
        ..color = c
        ..strokeWidth = 3.0
        ..style = PaintingStyle.stroke;
      canvas.drawPath(p, paint);
      for (int i = 0; i < 100; i += dash) {
        final t = i / 100.0;
        final v = v0 * _approxPow(friction, t * 4.0);
        final x = originX + t * spanX;
        final y = originY - v * spanY;
        final dot = Paint()..color = c;
        canvas.drawCircle(Offset(x, y), 2.5, dot);
      }
    }

    plot(0.135, iosColor, 12);
    plot(0.18, macColor, 14);
    plot(0.22, defaultColor, 16);
  }

  // Cheap pow(a, b) for non-integer b without dart:math.
  // pow(base, exp) = exp(exp * ln(base)).
  double _approxPow(double base, double exp) {
    if (base <= 0) return 0;
    final lnBase = _approxLn(base);
    return _approxExp(exp * lnBase);
  }

  double _approxLn(double x) {
    var k = 0.0;
    var v = x;
    while (v > 1.5) {
      v = v / 2.718281828;
      k += 1.0;
    }
    while (v < 0.5) {
      v = v * 2.718281828;
      k -= 1.0;
    }
    final y = v - 1.0;
    final approx = y - y * y / 2.0 + y * y * y / 3.0 - y * y * y * y / 4.0;
    return approx + k;
  }

  double _approxExp(double x) {
    var term = 1.0;
    var sum = 1.0;
    for (int n = 1; n <= 8; n++) {
      term = term * x / n;
      sum += term;
    }
    return sum;
  }

  @override
  bool shouldRepaint(covariant _DecelPainter oldDelegate) => false;
}

// =====================================================================
// Root widget.
// =====================================================================
class FlingVelocityDemoApp extends StatelessWidget {
  const FlingVelocityDemoApp({super.key});

  @override
  Widget build(BuildContext context) {
    print('IOSScrollViewFlingVelocityTracker Deep Demo executing');

    final scheme = ColorScheme.fromSeed(
      seedColor: const Color(0xFF1E88E5),
      brightness: Brightness.light,
    );

    return MaterialApp(
      title: 'Fling Velocity Tracker Demo',
      theme: ThemeData(colorScheme: scheme, useMaterial3: true),
      home: Scaffold(
        backgroundColor: scheme.surface,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: _buildAllSections(scheme),
          ),
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // Build the entire body. Each helper returns a list of widgets that
  // gets flattened into the root Column.
  // -------------------------------------------------------------------
  List<Widget> _buildAllSections(ColorScheme scheme) {
    final children = <Widget>[];
    children.addAll(_buildHeader(scheme));
    children.add(const SizedBox(height: 28));
    children.addAll(_buildSection1Overview(scheme));
    children.add(const SizedBox(height: 28));
    children.addAll(_buildSection2Stage(scheme));
    children.add(const SizedBox(height: 28));
    children.addAll(_buildSection3Comparison(scheme));
    children.add(const SizedBox(height: 28));
    children.addAll(_buildSection4Weights(scheme));
    children.add(const SizedBox(height: 28));
    children.addAll(_buildSection5EdgeCases(scheme));
    children.add(const SizedBox(height: 28));
    children.addAll(_buildSection6Deceleration(scheme));
    children.add(const SizedBox(height: 28));
    children.addAll(_buildSection7DeviceKinds(scheme));
    children.add(const SizedBox(height: 28));
    children.addAll(_buildSection8Recipes(scheme));
    children.add(const SizedBox(height: 28));
    children.addAll(_buildSection9DecisionMatrix(scheme));
    children.add(const SizedBox(height: 28));
    children.addAll(_buildSection10Glossary(scheme));
    children.add(const SizedBox(height: 24));
    children.add(_buildFooter(scheme));
    return children;
  }

  // -------------------------------------------------------------------
  // Header banner with gradient and inline tag chips.
  // -------------------------------------------------------------------
  List<Widget> _buildHeader(ColorScheme scheme) {
    print('=== Header: IOSScrollViewFlingVelocityTracker banner ===');
    return [
      Container(
        padding: const EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [scheme.primary, scheme.tertiary, scheme.secondary],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: scheme.primary.withValues(alpha: 0.35),
              blurRadius: 18.0,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: scheme.onPrimary.withValues(alpha: 0.15),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.swipe,
                  color: scheme.onPrimary, size: 44.0),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'IOSScrollViewFlingVelocityTracker',
                    style: TextStyle(
                      color: scheme.onPrimary,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Sandbox-rendered deep dive into fling physics',
                    style: TextStyle(
                      color: scheme.onPrimary.withValues(alpha: 0.85),
                      fontSize: 13,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 6,
                    children: [
                      _chipFor(scheme, 'gestures'),
                      _chipFor(scheme, 'pointer'),
                      _chipFor(scheme, 'velocity'),
                      _chipFor(scheme, 'physics'),
                      _chipFor(scheme, 'iOS'),
                      _chipFor(scheme, 'macOS'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];
  }

  Widget _chipFor(ColorScheme scheme, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: scheme.onPrimary.withValues(alpha: 0.18),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: scheme.onPrimary,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // -------------------------------------------------------------------
  // Section 1: Conceptual overview cards.
  // -------------------------------------------------------------------
  List<Widget> _buildSection1Overview(ColorScheme scheme) {
    print('=== Section 1: What does a fling velocity tracker do? ===');

    // Touch the real VelocityTracker so the gestures import is genuinely
    // exercised. We do not feed real samples here.
    final tracker = VelocityTracker.withKind(PointerDeviceKind.touch);
    print('Constructed reference VelocityTracker: ${tracker.kind}');

    final concepts = <Widget>[
      _conceptCard(
        scheme,
        Icons.touch_app,
        'Pointer samples',
        'The OS streams (x, y, t) tuples while the user is dragging. '
            'The tracker keeps a ring buffer of the most recent ones.',
        scheme.primaryContainer,
        scheme.onPrimaryContainer,
      ),
      _conceptCard(
        scheme,
        Icons.linear_scale,
        'Least-squares fit',
        'On release the tracker fits a polynomial through the sample '
            'window and reads back velocity as the derivative at t=now.',
        scheme.secondaryContainer,
        scheme.onSecondaryContainer,
      ),
      _conceptCard(
        scheme,
        Icons.bolt,
        'Fling impulse',
        'The fitted velocity is handed to a ScrollPhysics simulation '
            'which decelerates the offset along a friction curve.',
        scheme.tertiaryContainer,
        scheme.onTertiaryContainer,
      ),
      _conceptCard(
        scheme,
        Icons.devices,
        'Platform feel',
        'iOS and macOS subclasses tweak the sample window and the '
            'rejection rules to match each platform native fling.',
        scheme.surfaceContainerHighest,
        scheme.onSurface,
      ),
    ];

    return [
      _sectionTitle(scheme, '1. What is a fling velocity tracker?'),
      const SizedBox(height: 12),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: concepts,
      ),
    ];
  }

  Widget _conceptCard(
    ColorScheme scheme,
    IconData icon,
    String title,
    String body,
    Color bg,
    Color fg,
  ) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: fg, size: 26),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    color: fg,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            body,
            style: TextStyle(color: fg, fontSize: 12.5, height: 1.35),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // Section 2: Pointer sample stage with velocity arrow.
  // -------------------------------------------------------------------
  List<Widget> _buildSection2Stage(ColorScheme scheme) {
    print('=== Section 2: Pointer sample stage ===');

    final samples = <_Sample>[];
    const baseX = 60.0;
    const baseY = 220.0;
    for (int i = 0; i < 12; i++) {
      final weight = (i + 1) / 12.0;
      final x = baseX + i * 30.0;
      final t = i / 11.0;
      final y = baseY - 110.0 * t * t - 20.0 * t;
      samples.add(_Sample(i, Offset(x, y), i * 16, weight));
    }
    print('Created ${samples.length} synthetic pointer samples.');

    final velocities = <_ComputedVelocity>[
      _ComputedVelocity(
        'Default VelocityTracker',
        const Offset(90, -55),
        2200.0,
        scheme.primary,
        'Wide window, balanced weighting.',
      ),
      _ComputedVelocity(
        'IOSScrollViewFlingVelocityTracker',
        const Offset(110, -42),
        2650.0,
        scheme.secondary,
        'Narrow window, weighs last ~100ms heavily.',
      ),
      _ComputedVelocity(
        'MacOSScrollViewFlingVelocityTracker',
        const Offset(70, -65),
        2100.0,
        scheme.tertiary,
        'Smoother; dampens last sample to fight trackpad jitter.',
      ),
    ];

    final stages = <Widget>[];
    for (final v in velocities) {
      stages.add(_singleStage(scheme, samples, v));
    }

    return [
      _sectionTitle(scheme, '2. Pointer sample stage'),
      const SizedBox(height: 6),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        child: Text(
          'Twelve synthetic pointer samples along a swipe path. '
          'Each tracker derives a slightly different velocity vector '
          'depending on how it weights recent samples.',
          style: TextStyle(
            color: scheme.onSurface.withValues(alpha: 0.75),
            fontSize: 13,
          ),
        ),
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: stages,
      ),
    ];
  }

  Widget _singleStage(
    ColorScheme scheme,
    List<_Sample> samples,
    _ComputedVelocity v,
  ) {
    return Container(
      width: 460,
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.07),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: v.color.withValues(alpha: 0.12),
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: [
                Icon(Icons.show_chart, color: v.color, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    v.label,
                    style: TextStyle(
                      color: v.color,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(
                    color: v.color.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${v.magnitude.toStringAsFixed(0)} px/s',
                    style: TextStyle(
                      color: v.color,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 260,
            child: CustomPaint(
              painter: _StagePainter(
                samples: samples,
                velocity: v.vector,
                dotColor: v.color,
                arrowColor: v.color,
                gridColor: scheme.outlineVariant.withValues(alpha: 0.6),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              v.note,
              style: TextStyle(
                color: scheme.onSurfaceVariant,
                fontSize: 12,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // Section 3: Side-by-side comparison table.
  // -------------------------------------------------------------------
  List<Widget> _buildSection3Comparison(ColorScheme scheme) {
    print('=== Section 3: Tracker comparison ===');

    final rows = <List<String>>[
      ['Window length (ms)', '~100', '~100-150', '~150-200'],
      ['Sample budget', '20', '20', '20'],
      ['Weighting', 'Newest weighted', 'Newest dampened', 'Uniform fit'],
      ['Best for', 'iOS scroll feel', 'macOS trackpad', 'Generic gestures'],
      [
        'Direction reversal',
        'Discards old',
        'Smooths reversal',
        'Keeps all samples'
      ],
      ['Rejects stale > (ms)', '50', '50', '40'],
      [
        'Class name',
        'IOSScroll...Tracker',
        'MacOSScroll...Tracker',
        'VelocityTracker'
      ],
    ];

    final widget = Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.compare_arrows, color: scheme.primary, size: 22),
              const SizedBox(width: 8),
              Text(
                'Side-by-side properties',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Column(
              children: [
                _comparisonHeaderRow(scheme),
                ...List<Widget>.generate(
                  rows.length,
                  (i) => _comparisonRow(scheme, rows[i], i.isEven),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _trackerBadge(scheme, 'iOS', scheme.primary, Icons.phone_iphone),
              _trackerBadge(
                  scheme, 'macOS', scheme.secondary, Icons.laptop_mac),
              _trackerBadge(
                  scheme, 'Default', scheme.tertiary, Icons.devices_other),
            ],
          ),
        ],
      ),
    );

    return [
      _sectionTitle(scheme, '3. Three tracker flavors compared'),
      const SizedBox(height: 12),
      widget,
    ];
  }

  Widget _comparisonHeaderRow(ColorScheme scheme) {
    final headers = ['Property', 'iOS', 'macOS', 'Default'];
    return Container(
      decoration: BoxDecoration(
        color: scheme.primary.withValues(alpha: 0.08),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        children: headers.map((h) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                h,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: scheme.primary,
                  fontSize: 12.5,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _comparisonRow(
      ColorScheme scheme, List<String> cells, bool zebra) {
    final children = <Widget>[];
    for (int i = 0; i < cells.length; i++) {
      final isFirst = i == 0;
      children.add(
        Expanded(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            child: Text(
              cells[i],
              style: TextStyle(
                color: isFirst ? scheme.onSurface : scheme.onSurfaceVariant,
                fontWeight: isFirst ? FontWeight.w600 : FontWeight.normal,
                fontSize: 12,
              ),
            ),
          ),
        ),
      );
    }
    return Container(
      decoration: BoxDecoration(
        color: zebra ? scheme.surfaceContainerLow : scheme.surface,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }

  Widget _trackerBadge(
      ColorScheme scheme, String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // Section 4: Sample-window weighting bar charts.
  // -------------------------------------------------------------------
  List<Widget> _buildSection4Weights(ColorScheme scheme) {
    print('=== Section 4: Sample-window weighting ===');

    final profiles = <Map<String, dynamic>>[
      {
        'label': 'Default',
        'color': scheme.tertiary,
        'weights': <double>[
          0.40, 0.45, 0.50, 0.55, 0.60, 0.65,
          0.70, 0.75, 0.80, 0.85, 0.90, 1.00,
        ],
      },
      {
        'label': 'iOS',
        'color': scheme.primary,
        'weights': <double>[
          0.10, 0.10, 0.12, 0.14, 0.18, 0.24,
          0.32, 0.45, 0.62, 0.80, 0.95, 1.00,
        ],
      },
      {
        'label': 'macOS',
        'color': scheme.secondary,
        'weights': <double>[
          0.18, 0.22, 0.30, 0.40, 0.55, 0.72,
          0.86, 0.96, 1.00, 0.92, 0.74, 0.55,
        ],
      },
    ];

    final widgets = <Widget>[];
    for (final p in profiles) {
      widgets.add(_weightingCard(scheme, p));
    }

    return [
      _sectionTitle(scheme, '4. Sample window weighting'),
      const SizedBox(height: 6),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4),
        child: Text(
          'Each tracker assigns a different weight to each of the last '
          'twelve samples. The shape of the curve determines whether '
          'the resulting velocity feels snappy, soft, or smoothed.',
          style: TextStyle(
            color: scheme.onSurface.withValues(alpha: 0.75),
            fontSize: 13,
          ),
        ),
      ),
      const SizedBox(height: 12),
      Column(children: widgets),
    ];
  }

  Widget _weightingCard(ColorScheme scheme, Map<String, dynamic> profile) {
    final label = profile['label'] as String;
    final color = profile['color'] as Color;
    final weights = profile['weights'] as List<double>;

    final bars = <Widget>[];
    for (int i = 0; i < weights.length; i++) {
      final w = weights[i];
      bars.add(
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 100 * w + 4,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [color.withValues(alpha: 0.5), color],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(3),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${i + 1}',
                  style: TextStyle(
                    fontSize: 10,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 14,
                height: 14,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '$label weighting profile',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: scheme.onSurface,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Cluster H follow-up: the inner bar Column packs
          // Container(height: 100*w + 4) + SizedBox(4) + Text(fontSize 10,
          // default line-height ~14 px). At w=1.0 the natural height is
          // 104 + 4 + 14 = 122 px, exceeding the previous 120 px cap by 2 px
          // and emitting one bottom overflow per card. The 3 weighting
          // cards therefore produced 3 events of 2 px each. Bumped the cap
          // to 124 (the minimum needed). mainAxisAlignment: end on each bar
          // Column keeps the bar+label packed at the bottom; the extra 4 px
          // appears as silent headroom above the bar tops, no visual change.
          SizedBox(
            height: 124,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: bars,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'X axis: sample index (1=oldest, 12=newest). '
            'Y axis: weight applied in the least-squares fit.',
            style: TextStyle(
              fontSize: 11,
              color: scheme.onSurfaceVariant,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // Section 5: Edge case cards.
  // -------------------------------------------------------------------
  List<Widget> _buildSection5EdgeCases(ColorScheme scheme) {
    print('=== Section 5: Edge cases ===');

    final cases = <Map<String, dynamic>>[
      {
        'title': 'Single sample',
        'icon': Icons.fiber_manual_record,
        'color': scheme.error,
        'desc':
            'With only one position the tracker cannot compute velocity. '
                'The fitted polynomial collapses, and the result is Velocity.zero.',
      },
      {
        'title': 'Stale samples',
        'icon': Icons.hourglass_empty,
        'color': scheme.primary,
        'desc':
            'If the most recent sample is older than the rejection '
                'threshold (typically 40-50 ms) the tracker reports zero. '
                'This prevents flings after the user has stopped touching.',
      },
      {
        'title': 'Direction reversal',
        'icon': Icons.swap_horiz,
        'color': scheme.secondary,
        'desc':
            'When the swipe reverses direction near the end the iOS '
                'tracker biases toward the latest direction so the fling '
                'follows the user last intent, not the average motion.',
      },
      {
        'title': 'Tiny motion',
        'icon': Icons.center_focus_weak,
        'color': scheme.tertiary,
        'desc':
            'Sub-pixel jitter below an internal threshold is treated '
                'as no motion. Without this guard, a tap could leak in '
                'a tiny but non-zero fling and cause unintended scrolling.',
      },
      {
        'title': 'Trackpad scroll burst',
        'icon': Icons.mouse,
        'color': scheme.outline,
        'desc':
            'macOS trackpads emit dense bursts. The macOS tracker '
                'down-weights the absolute last sample to filter out '
                'rebound noise from the trackpad release event.',
      },
      {
        'title': 'Long press then drag',
        'icon': Icons.timer,
        'color': scheme.error,
        'desc':
            'If the user holds before flicking, only samples inside the '
                'window are kept. Older static samples are evicted, so the '
                'computed velocity reflects the flick alone.',
      },
    ];

    final widgets = cases.map((c) => _edgeCaseCard(scheme, c)).toList();

    return [
      _sectionTitle(scheme, '5. Edge cases and rejection rules'),
      const SizedBox(height: 12),
      Wrap(
        spacing: 12,
        runSpacing: 12,
        children: widgets,
      ),
    ];
  }

  Widget _edgeCaseCard(ColorScheme scheme, Map<String, dynamic> c) {
    final color = c['color'] as Color;
    return Container(
      width: 290,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.4), width: 1.4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(c['icon'] as IconData, color: color, size: 20),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  c['title'] as String,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: color,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            c['desc'] as String,
            style: TextStyle(
              fontSize: 12.5,
              color: scheme.onSurface.withValues(alpha: 0.85),
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // Section 6: Fling deceleration curves.
  // -------------------------------------------------------------------
  List<Widget> _buildSection6Deceleration(ColorScheme scheme) {
    print('=== Section 6: Fling deceleration curve ===');

    final diagram = Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Icon(Icons.timeline, color: scheme.primary, size: 22),
              const SizedBox(width: 8),
              Text(
                'Post-release deceleration',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: scheme.onSurface,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 2.4,
            child: CustomPaint(
              painter: _DecelPainter(
                iosColor: scheme.primary,
                macColor: scheme.secondary,
                defaultColor: scheme.tertiary,
                gridColor: scheme.outlineVariant.withValues(alpha: 0.55),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 14,
            runSpacing: 8,
            children: [
              _legendDot(scheme, 'iOS friction 0.135', scheme.primary),
              _legendDot(scheme, 'macOS friction 0.180', scheme.secondary),
              _legendDot(scheme, 'Default friction 0.220', scheme.tertiary),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            'Lower friction = longer glide. iOS lets the offset slide '
            'further than the default tracker; macOS sits in between '
            'for the lighter-touch trackpad ergonomics.',
            style: TextStyle(
              fontSize: 12,
              color: scheme.onSurfaceVariant,
              height: 1.4,
            ),
          ),
        ],
      ),
    );

    return [
      _sectionTitle(scheme, '6. Fling deceleration curves'),
      const SizedBox(height: 12),
      diagram,
    ];
  }

  Widget _legendDot(ColorScheme scheme, String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: scheme.onSurface,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------
  // Section 7: PointerDeviceKind matrix.
  // -------------------------------------------------------------------
  List<Widget> _buildSection7DeviceKinds(ColorScheme scheme) {
    print('=== Section 7: PointerDeviceKind matrix ===');

    final kinds = <Map<String, dynamic>>[
      {
        'kind': PointerDeviceKind.touch,
        'icon': Icons.touch_app,
        'note': 'Direct finger touch on a phone or tablet.',
      },
      {
        'kind': PointerDeviceKind.mouse,
        'icon': Icons.mouse,
        'note': 'Desktop mouse drag (rare for fling).',
      },
      {
        'kind': PointerDeviceKind.stylus,
        'icon': Icons.create,
        'note': 'Pressure-sensitive stylus on a tablet.',
      },
      {
        'kind': PointerDeviceKind.invertedStylus,
        'icon': Icons.brush,
        'note': 'Stylus held upside down (eraser).',
      },
      {
        'kind': PointerDeviceKind.trackpad,
        'icon': Icons.window,
        'note': 'Two-finger trackpad scrolls; macOS specialty.',
      },
      {
        'kind': PointerDeviceKind.unknown,
        'icon': Icons.help_outline,
        'note': 'Unidentified input; fallback behavior applies.',
      },
    ];

    final widgets = <Widget>[];
    for (final k in kinds) {
      widgets.add(_deviceKindCard(scheme, k));
    }

    final reasonable = <Map<String, dynamic>>[
      {
        'tracker': 'IOS tracker',
        'good': <PointerDeviceKind>[PointerDeviceKind.touch],
        'meh': <PointerDeviceKind>[
          PointerDeviceKind.stylus,
          PointerDeviceKind.invertedStylus
        ],
        'avoid': <PointerDeviceKind>[
          PointerDeviceKind.mouse,
          PointerDeviceKind.trackpad
        ],
      },
      {
        'tracker': 'MacOS tracker',
        'good': <PointerDeviceKind>[
          PointerDeviceKind.trackpad,
          PointerDeviceKind.mouse
        ],
        'meh': <PointerDeviceKind>[PointerDeviceKind.touch],
        'avoid': <PointerDeviceKind>[PointerDeviceKind.unknown],
      },
      {
        'tracker': 'Default tracker',
        'good': <PointerDeviceKind>[
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown,
        ],
        'meh': <PointerDeviceKind>[PointerDeviceKind.trackpad],
        'avoid': <PointerDeviceKind>[],
      },
    ];

    final matrixRows = reasonable.map((r) => _matrixRow(scheme, r)).toList();

    return [
      _sectionTitle(scheme, '7. Pointer device compatibility'),
      const SizedBox(height: 12),
      Wrap(
        spacing: 10,
        runSpacing: 10,
        children: widgets,
      ),
      const SizedBox(height: 18),
      Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: scheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: scheme.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Recommended pairings',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: scheme.onSurface,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            ...matrixRows,
          ],
        ),
      ),
    ];
  }

  Widget _deviceKindCard(ColorScheme scheme, Map<String, dynamic> k) {
    final kind = k['kind'] as PointerDeviceKind;
    final note = k['note'] as String;
    return Container(
      width: 180,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                k['icon'] as IconData,
                color: scheme.primary,
                size: 20,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  kind.name,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    color: scheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            note,
            style: TextStyle(
              fontSize: 11.5,
              color: scheme.onSurfaceVariant,
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }

  Widget _matrixRow(ColorScheme scheme, Map<String, dynamic> r) {
    final good = (r['good'] as List<PointerDeviceKind>)
        .map((k) => k.name)
        .toList();
    final meh = (r['meh'] as List<PointerDeviceKind>)
        .map((k) => k.name)
        .toList();
    final avoid = (r['avoid'] as List<PointerDeviceKind>)
        .map((k) => k.name)
        .toList();

    final pills = <Widget>[];
    for (final g in good) {
      pills.add(_matrixPill(scheme, g, Colors.green, Icons.check));
    }
    for (final g in meh) {
      pills.add(_matrixPill(scheme, g, Colors.amber.shade700, Icons.remove));
    }
    for (final g in avoid) {
      pills.add(_matrixPill(scheme, g, scheme.error, Icons.close));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              r['tracker'] as String,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: scheme.onSurface,
                fontSize: 13,
              ),
            ),
          ),
          Expanded(
            child: Wrap(
              spacing: 6,
              runSpacing: 6,
              children: pills,
            ),
          ),
        ],
      ),
    );
  }

  Widget _matrixPill(
      ColorScheme scheme, String label, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.45)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // Section 8: Custom physics recipes.
  // -------------------------------------------------------------------
  List<Widget> _buildSection8Recipes(ColorScheme scheme) {
    print('=== Section 8: Recipes ===');

    final recipes = <Map<String, String>>[
      {
        'title': 'Use the iOS tracker explicitly',
        'subtitle': 'When you want the iOS feel on every platform',
        'code': '// Force iOS scroll fling tracker for a touch pointer\n'
            'final tracker = IOSScrollViewFlingVelocityTracker(\n'
            '  PointerDeviceKind.touch,\n'
            ');\n'
            '\n'
            '// Feed samples in your pointer event handler\n'
            '// tracker.addPosition(event.timeStamp, event.position);',
      },
      {
        'title': 'Pick by platform with ScrollPhysics',
        'subtitle': 'Let the physics class choose for you',
        'code': '// BouncingScrollPhysics constructs the iOS tracker.\n'
            '// ClampingScrollPhysics uses the default tracker.\n'
            'final physics = defaultTargetPlatform == TargetPlatform.iOS\n'
            '    ? const BouncingScrollPhysics()\n'
            '    : const ClampingScrollPhysics();',
      },
      {
        'title': 'Read Velocity safely',
        'subtitle': 'Always handle Velocity.zero as a possible result',
        'code': '// Velocity result on release\n'
            'final v = tracker.getVelocity();\n'
            'if (v == Velocity.zero) {\n'
            '  // No fling; just settle\n'
            '} else {\n'
            '  // Hand off to a ScrollSimulation\n'
            '}',
      },
      {
        'title': 'Build a custom tracker',
        'subtitle': 'Subclass VelocityTracker when you need a new feel',
        'code': '// Custom tracker example\n'
            'class MyTracker extends VelocityTracker {\n'
            '  MyTracker() : super.withKind(PointerDeviceKind.touch);\n'
            '  @override\n'
            '  Velocity getVelocity() {\n'
            '    final v = super.getVelocity();\n'
            '    final dx = v.pixelsPerSecond.dx.clamp(-4000.0, 4000.0);\n'
            '    final dy = v.pixelsPerSecond.dy.clamp(-4000.0, 4000.0);\n'
            '    return Velocity(pixelsPerSecond: Offset(dx, dy));\n'
            '  }\n'
            '}',
      },
    ];

    final cards = recipes.map((r) => _recipeCard(scheme, r)).toList();

    return [
      _sectionTitle(scheme, '8. Recipes for custom physics'),
      const SizedBox(height: 12),
      Column(children: cards),
    ];
  }

  Widget _recipeCard(ColorScheme scheme, Map<String, String> r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: scheme.primaryContainer,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(14)),
            ),
            child: Row(
              children: [
                Icon(Icons.menu_book,
                    color: scheme.onPrimaryContainer, size: 22),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        r['title']!,
                        style: TextStyle(
                          color: scheme.onPrimaryContainer,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        r['subtitle']!,
                        style: TextStyle(
                          color: scheme.onPrimaryContainer
                              .withValues(alpha: 0.85),
                          fontSize: 11.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.grey.shade900,
              borderRadius:
                  const BorderRadius.vertical(bottom: Radius.circular(14)),
            ),
            child: Text(
              r['code']!,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: Colors.greenAccent.shade100,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // Section 9: Decision matrix.
  // -------------------------------------------------------------------
  List<Widget> _buildSection9DecisionMatrix(ColorScheme scheme) {
    print('=== Section 9: Decision matrix ===');

    final rows = <Map<String, String>>[
      {
        'scenario': 'Pure mobile app, native iOS feel',
        'pick': 'IOSScrollViewFlingVelocityTracker',
        'why': 'Matches CoreScrollView fling timing.',
      },
      {
        'scenario': 'Desktop macOS with trackpad scroll',
        'pick': 'MacOSScrollViewFlingVelocityTracker',
        'why': 'Filters trackpad rebound, smoother glide.',
      },
      {
        'scenario': 'Cross-platform with one feel',
        'pick': 'VelocityTracker (default)',
        'why': 'Balanced window, predictable everywhere.',
      },
      {
        'scenario': 'Custom physics simulation',
        'pick': 'Subclass VelocityTracker',
        'why': 'Override getVelocity() to clamp or transform.',
      },
      {
        'scenario': 'Want zero-fling for taps',
        'pick': 'Any + tap recognizer',
        'why': 'Let GestureRecognizer reject before fling.',
      },
      {
        'scenario': 'Test fixture or unit tests',
        'pick': 'VelocityTracker.withKind',
        'why': 'Deterministic, no platform branching.',
      },
    ];

    final widgets = rows.map((r) => _decisionRow(scheme, r)).toList();

    return [
      _sectionTitle(scheme, '9. Decision matrix: which tracker?'),
      const SizedBox(height: 12),
      Column(children: widgets),
    ];
  }

  Widget _decisionRow(ColorScheme scheme, Map<String, String> r) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: scheme.surface,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: scheme.tertiary.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.lightbulb_outline,
                color: scheme.tertiary, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  r['scenario']!,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: scheme.onSurface,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: scheme.primary.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        r['pick']!,
                        style: TextStyle(
                          color: scheme.primary,
                          fontSize: 11.5,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  r['why']!,
                  style: TextStyle(
                    fontSize: 12,
                    color: scheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // Section 10: Glossary and final recap.
  // -------------------------------------------------------------------
  List<Widget> _buildSection10Glossary(ColorScheme scheme) {
    print('=== Section 10: Glossary and recipes recap ===');

    final entries = <Map<String, String>>[
      {
        'term': 'VelocityTracker',
        'def':
            'Base class. Collects pointer samples and fits a polynomial '
                'to estimate velocity at release time.',
      },
      {
        'term': 'IOSScrollViewFlingVelocityTracker',
        'def':
            'Subclass tuned for the iOS UIScrollView feel: '
                'a narrow window and aggressive weighting of the newest sample.',
      },
      {
        'term': 'MacOSScrollViewFlingVelocityTracker',
        'def':
            'Subclass for macOS NSScrollView. Slightly smoother to '
                'compensate for trackpad rebound noise.',
      },
      {
        'term': 'Velocity',
        'def':
            'Immutable container for a 2D velocity vector in pixels per '
                'second. Use Velocity.zero for "no motion".',
      },
      {
        'term': 'PointerDeviceKind',
        'def':
            'Enum: touch, mouse, stylus, invertedStylus, trackpad, unknown. '
                'Influences which tracker subclass is selected by physics.',
      },
      {
        'term': 'Sample window',
        'def':
            'The most recent ~100-200 ms of pointer positions kept for the '
                'fit. Older samples are evicted.',
      },
      {
        'term': 'Fling impulse',
        'def':
            'The velocity handed to a ScrollSimulation when the user '
                'releases. Decays via friction over time.',
      },
      {
        'term': 'Rejection threshold',
        'def':
            'Time gap after which the most recent sample is considered '
                'stale and velocity is forced to zero.',
      },
    ];

    final glossaryWidgets = <Widget>[];
    for (final e in entries) {
      glossaryWidgets.add(
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: scheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: scheme.outlineVariant),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: scheme.primary.withValues(alpha: 0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.book,
                      color: scheme.primary, size: 18),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        e['term']!,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color: scheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        e['def']!,
                        style: TextStyle(
                          fontSize: 12.5,
                          color: scheme.onSurface.withValues(alpha: 0.85),
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final recap = Container(
      margin: const EdgeInsets.only(top: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            scheme.primaryContainer,
            scheme.tertiaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Final recap',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: scheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '- Fling velocity trackers convert a stream of touch samples '
            'into a single Velocity at release time.\n'
            '- IOSScrollViewFlingVelocityTracker leans on the freshest '
            'samples to match the iOS scroll feel.\n'
            '- MacOSScrollViewFlingVelocityTracker is gentler so trackpad '
            'rebound noise does not warp the result.\n'
            '- The plain VelocityTracker is the cross-platform fallback.\n'
            '- Always tolerate Velocity.zero in your physics pipeline.',
            style: TextStyle(
              fontSize: 12.5,
              color: scheme.onPrimaryContainer,
              height: 1.5,
            ),
          ),
        ],
      ),
    );

    return [
      _sectionTitle(scheme, '10. Glossary and recap'),
      const SizedBox(height: 12),
      ...glossaryWidgets,
      recap,
    ];
  }

  // -------------------------------------------------------------------
  // Footer
  // -------------------------------------------------------------------
  Widget _buildFooter(ColorScheme scheme) {
    print('=== Footer rendered ===');
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: scheme.outlineVariant),
      ),
      child: Row(
        children: [
          Icon(Icons.swipe, color: scheme.primary, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'End of IOSScrollViewFlingVelocityTracker deep demo. '
              'Rendered statically by the D4rt AST runner.',
              style: TextStyle(
                color: scheme.onSurface,
                fontSize: 12.5,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------
  // Helper for section titles.
  // -------------------------------------------------------------------
  Widget _sectionTitle(ColorScheme scheme, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(10),
        border: Border(
          left: BorderSide(color: scheme.primary, width: 4),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
          color: scheme.onSurface,
        ),
      ),
    );
  }
}

// =====================================================================
// Entry point.
// =====================================================================
dynamic build(BuildContext context) => const FlingVelocityDemoApp();
