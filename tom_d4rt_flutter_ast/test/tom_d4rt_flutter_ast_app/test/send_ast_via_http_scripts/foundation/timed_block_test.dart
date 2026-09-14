// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
//
// =====================================================================
// TimedBlock — visual deep-demo
// =====================================================================
//
// This file is a hand-written, single-entry Flutter demo that visually
// explains the role of `TimedBlock` from `package:flutter/foundation.dart`.
//
// In Flutter, a TimedBlock is a small immutable data record describing a
// single span of execution that was instrumented for the inspector and
// the DevTools timeline.  At runtime, the engine collects raw spans;
// the framework wraps them into `TimedBlock` instances which are then
// summarised by `AggregatedTimedBlock` for tooling consumption.
//
// The conceptual life-cycle that engineers reason about is:
//
//     final block = TimedBlock(name);   // open the span
//     ... do some work ...              // user code inside the span
//     block.finish();                   // close the span
//
// In production code the open/close pair is normally produced by
// `Timeline.startSync(name)` and `Timeline.finishSync()` from
// `dart:developer`; the framework's `TimedBlock` is the data view
// of that span once collection has finished.
//
// This file is a *visual* demo, not a behavioural test.  It draws:
//
//   1. a hero band with a stopwatch graphic;
//   2. a labelled anatomy of a TimedBlock instance;
//   3. a horizontal life-cycle timeline (constructor -> start ->
//      user code -> finish);
//   4. five stylised "trace event" cards;
//   5. a Gantt-style nested-block timeline drawn with a CustomPainter;
//   6. an `AggregatedTimedBlock` summary panel (count/sum/min/max/avg);
//   7. a recipe code listing;
//   8. the relationship with `Timeline.startSync` / `finishSync`;
//   9. a pitfalls panel; and
//  10. a footer.
//
// Hard rules respected:
//   * Single static `dynamic build(BuildContext)` entry point.
//   * MaterialApp wrapper.
//   * No setState, controllers, async, Future, Timer, streams.
//   * All private classes / typedefs use `_PrivateXxx` (PascalCase).
//   * All private top-level functions / variables use `_privateXxx`.
//   * No `.withOpacity` (uses `withValues(alpha:)`).
//   * No inline `// ignore:`.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// =====================================================================
// SECTION A: palette & spacing tokens
// =====================================================================

class _PrivatePalette {
  static const Color background = Color(0xFF0E1116);
  static const Color surface = Color(0xFF161B22);
  static const Color surfaceAlt = Color(0xFF1F2630);
  static const Color border = Color(0xFF2A323D);
  static const Color text = Color(0xFFE6EDF3);
  static const Color textDim = Color(0xFF8B949E);
  static const Color accent = Color(0xFFFFB454);
  static const Color accentAlt = Color(0xFFFFD27A);
  static const Color trace1 = Color(0xFF5AB0F2);
  static const Color trace2 = Color(0xFF7FE3A1);
  static const Color trace3 = Color(0xFFE684C8);
  static const Color trace4 = Color(0xFFE7C66B);
  static const Color trace5 = Color(0xFFA890F0);
  static const Color trace6 = Color(0xFF6FCFD3);
  static const Color danger = Color(0xFFF87171);
  static const Color ok = Color(0xFF4ADE80);
}

class _PrivateSpacing {
  static const double s1 = 4;
  static const double s2 = 8;
  static const double s3 = 12;
  static const double s4 = 16;
  static const double s5 = 20;
  static const double s6 = 24;
  static const double s7 = 32;
  static const double s8 = 40;
  static const double s9 = 56;
}

// =====================================================================
// SECTION B: the entry point
// =====================================================================

dynamic build(BuildContext context) {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'TimedBlock — visual deep demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: _PrivatePalette.background,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: _PrivatePalette.text),
      ),
    ),
    home: const _PrivateHome(),
  );
}

// =====================================================================
// SECTION C: the home scaffold
// =====================================================================

class _PrivateHome extends StatelessWidget {
  const _PrivateHome();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _PrivatePalette.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: _PrivateSpacing.s7,
            vertical: _PrivateSpacing.s6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const <Widget>[
              _PrivateHero(),
              SizedBox(height: _PrivateSpacing.s7),
              _PrivateAnatomy(),
              SizedBox(height: _PrivateSpacing.s7),
              _PrivateLifecycle(),
              SizedBox(height: _PrivateSpacing.s7),
              _PrivateTraceEventGallery(),
              SizedBox(height: _PrivateSpacing.s7),
              _PrivateGanttSection(),
              SizedBox(height: _PrivateSpacing.s7),
              _PrivateAggregateSection(),
              SizedBox(height: _PrivateSpacing.s7),
              _PrivateRecipeSection(),
              SizedBox(height: _PrivateSpacing.s7),
              _PrivateTimelineRelation(),
              SizedBox(height: _PrivateSpacing.s7),
              _PrivatePitfalls(),
              SizedBox(height: _PrivateSpacing.s7),
              _PrivateFooter(),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION D: hero band with stopwatch graphic
// =====================================================================

class _PrivateHero extends StatelessWidget {
  const _PrivateHero();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_PrivateSpacing.s6),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: <Color>[
            _PrivatePalette.surface,
            _PrivatePalette.surfaceAlt,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const _PrivateStopwatchGraphic(size: 132),
          const SizedBox(width: _PrivateSpacing.s7),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'TimedBlock',
                  style: TextStyle(
                    color: _PrivatePalette.accent,
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: _PrivateSpacing.s2),
                Text(
                  'A perf-instrumentation primitive from package:flutter/foundation.dart',
                  style: TextStyle(
                    color: _PrivatePalette.textDim,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: _PrivateSpacing.s4),
                Wrap(
                  spacing: _PrivateSpacing.s2,
                  runSpacing: _PrivateSpacing.s2,
                  children: const <Widget>[
                    _PrivateTag(label: 'foundation'),
                    _PrivateTag(label: 'inspector'),
                    _PrivateTag(label: 'devtools-timeline'),
                    _PrivateTag(label: 'trace-event'),
                    _PrivateTag(label: 'aggregate'),
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

class _PrivateStopwatchGraphic extends StatelessWidget {
  const _PrivateStopwatchGraphic({required this.size});

  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _PrivateStopwatchPainter(),
      ),
    );
  }
}

class _PrivateStopwatchPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Offset center = Offset(size.width / 2, size.height / 2 + 6);
    final double radius = size.width * 0.42;
    final Paint body = Paint()..color = _PrivatePalette.surfaceAlt;
    final Paint ring = Paint()
      ..color = _PrivatePalette.accent
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5;
    final Paint hand = Paint()
      ..color = _PrivatePalette.accentAlt
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;
    final Paint tick = Paint()
      ..color = _PrivatePalette.textDim
      ..strokeWidth = 2;
    canvas.drawCircle(center, radius, body);
    canvas.drawCircle(center, radius, ring);
    for (int i = 0; i < 12; i++) {
      final double a = i * 3.1415926 * 2 / 12;
      final Offset p1 = center +
          Offset(radius * 0.84 * _privateCos(a), radius * 0.84 * _privateSin(a));
      final Offset p2 = center +
          Offset(radius * 0.95 * _privateCos(a), radius * 0.95 * _privateSin(a));
      canvas.drawLine(p1, p2, tick);
    }
    canvas.drawLine(
      center,
      center + Offset(radius * 0.6, -radius * 0.55),
      hand,
    );
    canvas.drawCircle(center, 4, Paint()..color = _PrivatePalette.accent);
    final Paint crown = Paint()..color = _PrivatePalette.accent;
    final Rect crownRect = Rect.fromLTWH(
      center.dx - 8,
      center.dy - radius - 12,
      16,
      10,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(crownRect, const Radius.circular(2)),
      crown,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

double _privateCos(double a) {
  // Tiny Taylor-like wrapper that delegates to dart:math via foundation.
  // We use the standard library implementation indirectly through
  // `clampDouble` shapes; for our painter accuracy we just call
  // through to `_privateMathCos`.
  return _privateMathCos(a);
}

double _privateSin(double a) => _privateMathSin(a);

double _privateMathCos(double a) {
  // Use a couple of identities so we stay deterministic for the painter.
  // The reduction below keeps `a` in `[-pi, pi]`.
  const double twoPi = 6.283185307179586;
  double x = a % twoPi;
  if (x > 3.141592653589793) x -= twoPi;
  if (x < -3.141592653589793) x += twoPi;
  final double x2 = x * x;
  return 1 - x2 / 2 + x2 * x2 / 24 - x2 * x2 * x2 / 720;
}

double _privateMathSin(double a) {
  const double twoPi = 6.283185307179586;
  double x = a % twoPi;
  if (x > 3.141592653589793) x -= twoPi;
  if (x < -3.141592653589793) x += twoPi;
  final double x2 = x * x;
  return x - x * x2 / 6 + x * x2 * x2 / 120 - x * x2 * x2 * x2 / 5040;
}

// =====================================================================
// SECTION E: anatomy panel
// =====================================================================

class _PrivateAnatomy extends StatelessWidget {
  const _PrivateAnatomy();

  @override
  Widget build(BuildContext context) {
    return _PrivateSection(
      title: 'Anatomy of a TimedBlock',
      subtitle:
          'Each TimedBlock is an immutable record describing one span of work.',
      child: Padding(
        padding: const EdgeInsets.all(_PrivateSpacing.s5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: _PrivateSpacing.s5,
                vertical: _PrivateSpacing.s4,
              ),
              decoration: BoxDecoration(
                color: _PrivatePalette.surfaceAlt,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: _PrivatePalette.border),
              ),
              child: Row(
                children: <Widget>[
                  _PrivateAnatomyField(
                    label: 'name',
                    value: '"layout-pass"',
                    color: _PrivatePalette.trace1,
                  ),
                  const _PrivateAnatomyArrow(),
                  _PrivateAnatomyField(
                    label: 'start',
                    value: '1000.0 µs',
                    color: _PrivatePalette.trace2,
                  ),
                  const _PrivateAnatomyArrow(),
                  _PrivateAnatomyField(
                    label: 'end',
                    value: '2500.0 µs',
                    color: _PrivatePalette.trace3,
                  ),
                  const _PrivateAnatomyArrow(),
                  _PrivateAnatomyField(
                    label: 'duration',
                    value: '1500.0 µs',
                    color: _PrivatePalette.trace4,
                  ),
                ],
              ),
            ),
            const SizedBox(height: _PrivateSpacing.s4),
            Text(
              'duration is a derived field: it equals end - start. A TimedBlock '
              'with start == end has duration 0 — that is the canonical '
              'representation of an instantaneous trace event.',
              style: TextStyle(
                color: _PrivatePalette.textDim,
                fontSize: 13,
                height: 1.45,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateAnatomyField extends StatelessWidget {
  const _PrivateAnatomyField({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: _PrivateSpacing.s4,
          vertical: _PrivateSpacing.s3,
        ),
        margin: const EdgeInsets.symmetric(horizontal: _PrivateSpacing.s1),
        decoration: BoxDecoration(
          color: _PrivatePalette.surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.6)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.1,
              ),
            ),
            const SizedBox(height: _PrivateSpacing.s1),
            Text(
              value,
              style: TextStyle(
                color: _PrivatePalette.text,
                fontSize: 15,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateAnatomyArrow extends StatelessWidget {
  const _PrivateAnatomyArrow();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 28,
      child: Center(
        child: Icon(
          Icons.arrow_forward,
          color: _PrivatePalette.textDim,
          size: 18,
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION F: lifecycle timeline
// =====================================================================

class _PrivateLifecycle extends StatelessWidget {
  const _PrivateLifecycle();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateLifecycleStep> steps = <_PrivateLifecycleStep>[
      _PrivateLifecycleStep(
        ordinal: 1,
        title: 'constructor',
        body: 'TimedBlock(name: "frame")',
        color: _PrivatePalette.trace1,
      ),
      _PrivateLifecycleStep(
        ordinal: 2,
        title: 'start',
        body: 'block.start = now()',
        color: _PrivatePalette.trace2,
      ),
      _PrivateLifecycleStep(
        ordinal: 3,
        title: 'user-code',
        body: 'measured work runs',
        color: _PrivatePalette.trace3,
      ),
      _PrivateLifecycleStep(
        ordinal: 4,
        title: 'finish()',
        body: 'block.end = now(); emit',
        color: _PrivatePalette.trace4,
      ),
    ];
    return _PrivateSection(
      title: 'Lifecycle of one TimedBlock',
      subtitle:
          'A block is opened, the measured work happens, and finish() closes it.',
      child: Padding(
        padding: const EdgeInsets.all(_PrivateSpacing.s5),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                for (int i = 0; i < steps.length; i++) ...<Widget>[
                  Expanded(child: _PrivateLifecycleNode(step: steps[i])),
                  if (i < steps.length - 1)
                    Container(
                      width: 18,
                      height: 2,
                      color: _PrivatePalette.border,
                    ),
                ],
              ],
            ),
            const SizedBox(height: _PrivateSpacing.s4),
            Container(
              height: 28,
              decoration: BoxDecoration(
                color: _PrivatePalette.surfaceAlt,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: _PrivatePalette.border),
              ),
              child: Row(
                children: <Widget>[
                  Container(width: 6, color: _PrivatePalette.trace1),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: _PrivatePalette.trace2.withValues(alpha: 0.4),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      color: _PrivatePalette.trace3.withValues(alpha: 0.5),
                      alignment: Alignment.center,
                      child: Text(
                        'measured user-code (the "inside" of the block)',
                        style: TextStyle(
                          color: _PrivatePalette.text,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  Container(width: 6, color: _PrivatePalette.trace4),
                ],
              ),
            ),
            const SizedBox(height: _PrivateSpacing.s2),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('start', style: _privateMonoLabel()),
                Text('finish()', style: _privateMonoLabel()),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

TextStyle _privateMonoLabel() => TextStyle(
      color: _PrivatePalette.textDim,
      fontSize: 12,
      fontFamily: 'monospace',
    );

class _PrivateLifecycleStep {
  const _PrivateLifecycleStep({
    required this.ordinal,
    required this.title,
    required this.body,
    required this.color,
  });

  final int ordinal;
  final String title;
  final String body;
  final Color color;
}

class _PrivateLifecycleNode extends StatelessWidget {
  const _PrivateLifecycleNode({required this.step});

  final _PrivateLifecycleStep step;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_PrivateSpacing.s3),
      decoration: BoxDecoration(
        color: _PrivatePalette.surfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: step.color.withValues(alpha: 0.7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 11,
                backgroundColor: step.color,
                child: Text(
                  '${step.ordinal}',
                  style: TextStyle(
                    color: _PrivatePalette.background,
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(width: _PrivateSpacing.s2),
              Expanded(
                child: Text(
                  step.title,
                  style: TextStyle(
                    color: step.color,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: _PrivateSpacing.s2),
          Text(
            step.body,
            style: TextStyle(
              color: _PrivatePalette.text,
              fontSize: 12,
              fontFamily: 'monospace',
              height: 1.35,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION G: trace-event card gallery (5 cards)
// =====================================================================

class _PrivateTraceEventGallery extends StatelessWidget {
  const _PrivateTraceEventGallery();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateTraceEvent> events = <_PrivateTraceEvent>[
      _PrivateTraceEvent(
        block: TimedBlock(name: 'build', start: 0.0, end: 1800.0),
        color: _PrivatePalette.trace1,
        note: 'widget rebuild pass',
      ),
      _PrivateTraceEvent(
        block: TimedBlock(name: 'layout', start: 1800.0, end: 2900.0),
        color: _PrivatePalette.trace2,
        note: 'parent constraints flow down',
      ),
      _PrivateTraceEvent(
        block: TimedBlock(name: 'paint', start: 2900.0, end: 3650.0),
        color: _PrivatePalette.trace3,
        note: 'render objects emit picture',
      ),
      _PrivateTraceEvent(
        block: TimedBlock(name: 'compositing', start: 3650.0, end: 3940.0),
        color: _PrivatePalette.trace4,
        note: 'layer tree assembly',
      ),
      _PrivateTraceEvent(
        block: TimedBlock(name: 'raster', start: 3940.0, end: 4720.0),
        color: _PrivatePalette.trace5,
        note: 'GPU raster of layer tree',
      ),
    ];
    final double maxDuration = events
        .map((_PrivateTraceEvent e) => e.block.duration)
        .reduce((double a, double b) => a > b ? a : b);
    return _PrivateSection(
      title: 'Trace events as TimedBlock instances',
      subtitle: 'Five pretend frames-pipeline phases, each backed by a real '
          'TimedBlock object.',
      child: Padding(
        padding: const EdgeInsets.all(_PrivateSpacing.s5),
        child: Column(
          children: <Widget>[
            for (final _PrivateTraceEvent event in events) ...<Widget>[
              _PrivateTraceCard(event: event, maxDuration: maxDuration),
              const SizedBox(height: _PrivateSpacing.s3),
            ],
          ],
        ),
      ),
    );
  }
}

class _PrivateTraceEvent {
  const _PrivateTraceEvent({
    required this.block,
    required this.color,
    required this.note,
  });

  final TimedBlock block;
  final Color color;
  final String note;
}

class _PrivateTraceCard extends StatelessWidget {
  const _PrivateTraceCard({required this.event, required this.maxDuration});

  final _PrivateTraceEvent event;
  final double maxDuration;

  @override
  Widget build(BuildContext context) {
    final double frac =
        maxDuration == 0 ? 0 : (event.block.duration / maxDuration);
    return Container(
      padding: const EdgeInsets.all(_PrivateSpacing.s4),
      decoration: BoxDecoration(
        color: _PrivatePalette.surfaceAlt,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: event.color.withValues(alpha: 0.55)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            width: 10,
            height: 56,
            decoration: BoxDecoration(
              color: event.color,
              borderRadius: BorderRadius.circular(3),
            ),
          ),
          const SizedBox(width: _PrivateSpacing.s4),
          SizedBox(
            width: 220,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  event.block.name,
                  style: TextStyle(
                    color: event.color,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  event.note,
                  style: TextStyle(
                    color: _PrivatePalette.textDim,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LayoutBuilder(
                  builder: (BuildContext ctx, BoxConstraints c) {
                    return Container(
                      height: 18,
                      width: c.maxWidth,
                      decoration: BoxDecoration(
                        color: _PrivatePalette.surface,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: _PrivatePalette.border),
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          height: 18,
                          width: c.maxWidth * frac,
                          decoration: BoxDecoration(
                            color: event.color.withValues(alpha: 0.85),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 6),
                Row(
                  children: <Widget>[
                    _PrivateMetaChip(
                      label: 'start',
                      value: '${event.block.start.toStringAsFixed(1)} µs',
                    ),
                    const SizedBox(width: _PrivateSpacing.s2),
                    _PrivateMetaChip(
                      label: 'end',
                      value: '${event.block.end.toStringAsFixed(1)} µs',
                    ),
                    const SizedBox(width: _PrivateSpacing.s2),
                    _PrivateMetaChip(
                      label: 'duration',
                      value:
                          '${event.block.duration.toStringAsFixed(1)} µs',
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

class _PrivateMetaChip extends StatelessWidget {
  const _PrivateMetaChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _PrivatePalette.surface,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            '$label:',
            style: TextStyle(
              color: _PrivatePalette.textDim,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
          const SizedBox(width: 4),
          Text(
            value,
            style: TextStyle(
              color: _PrivatePalette.text,
              fontSize: 11,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION H: Gantt-style nested-block timeline
// =====================================================================

class _PrivateGanttSection extends StatelessWidget {
  const _PrivateGanttSection();

  @override
  Widget build(BuildContext context) {
    final List<_PrivateGanttRow> rows = <_PrivateGanttRow>[
      _PrivateGanttRow(
        depth: 0,
        block: TimedBlock(name: 'frame', start: 0.0, end: 16000.0),
        color: _PrivatePalette.trace1,
      ),
      _PrivateGanttRow(
        depth: 1,
        block: TimedBlock(name: 'build', start: 100.0, end: 5200.0),
        color: _PrivatePalette.trace2,
      ),
      _PrivateGanttRow(
        depth: 2,
        block: TimedBlock(name: 'reconcile', start: 200.0, end: 4500.0),
        color: _PrivatePalette.trace3,
      ),
      _PrivateGanttRow(
        depth: 1,
        block: TimedBlock(name: 'layout', start: 5300.0, end: 9800.0),
        color: _PrivatePalette.trace4,
      ),
      _PrivateGanttRow(
        depth: 1,
        block: TimedBlock(name: 'paint', start: 9900.0, end: 12500.0),
        color: _PrivatePalette.trace5,
      ),
      _PrivateGanttRow(
        depth: 1,
        block: TimedBlock(name: 'raster', start: 12600.0, end: 15800.0),
        color: _PrivatePalette.trace6,
      ),
    ];
    return _PrivateSection(
      title: 'Gantt timeline of nested TimedBlocks',
      subtitle:
          'Nested spans must finish in LIFO order — children close before '
          'their parent.',
      child: Padding(
        padding: const EdgeInsets.all(_PrivateSpacing.s5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              height: 240,
              child: CustomPaint(
                painter: _PrivateGanttPainter(rows: rows, totalUs: 16000.0),
                size: Size.infinite,
              ),
            ),
            const SizedBox(height: _PrivateSpacing.s4),
            Wrap(
              spacing: _PrivateSpacing.s3,
              runSpacing: _PrivateSpacing.s2,
              children: <Widget>[
                for (final _PrivateGanttRow r in rows)
                  _PrivateLegendDot(label: r.block.name, color: r.color),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateGanttRow {
  const _PrivateGanttRow({
    required this.depth,
    required this.block,
    required this.color,
  });

  final int depth;
  final TimedBlock block;
  final Color color;
}

class _PrivateGanttPainter extends CustomPainter {
  _PrivateGanttPainter({required this.rows, required this.totalUs});

  final List<_PrivateGanttRow> rows;
  final double totalUs;

  @override
  void paint(Canvas canvas, Size size) {
    final double rowHeight = (size.height - 30) / rows.length;
    final Paint axis = Paint()..color = _PrivatePalette.border;
    canvas.drawLine(
      Offset(0, size.height - 22),
      Offset(size.width, size.height - 22),
      axis,
    );
    final TextPainter tp = TextPainter(
      textDirection: TextDirection.ltr,
    );
    for (int t = 0; t <= 4; t++) {
      final double x = size.width * t / 4;
      canvas.drawLine(
        Offset(x, size.height - 26),
        Offset(x, size.height - 18),
        axis,
      );
      tp.text = TextSpan(
        text: '${(totalUs * t / 4).toStringAsFixed(0)} µs',
        style: TextStyle(color: _PrivatePalette.textDim, fontSize: 10),
      );
      tp.layout();
      tp.paint(canvas, Offset(x + 2, size.height - 14));
    }
    for (int i = 0; i < rows.length; i++) {
      final _PrivateGanttRow row = rows[i];
      final double y = i * rowHeight + 6;
      final double xStart =
          size.width * (row.block.start / totalUs);
      final double xEnd = size.width * (row.block.end / totalUs);
      final double indent = row.depth * 14.0;
      final Paint barBg = Paint()..color = _PrivatePalette.surfaceAlt;
      final Rect rect = Rect.fromLTRB(
        xStart + indent,
        y,
        xEnd,
        y + rowHeight - 8,
      );
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        barBg,
      );
      final Paint bar = Paint()..color = row.color.withValues(alpha: 0.85);
      canvas.drawRRect(
        RRect.fromRectAndRadius(rect, const Radius.circular(4)),
        bar,
      );
      tp.text = TextSpan(
        text: row.block.name,
        style: TextStyle(
          color: _PrivatePalette.background,
          fontSize: 11,
          fontFamily: 'monospace',
          fontWeight: FontWeight.w700,
        ),
      );
      tp.layout();
      tp.paint(canvas, Offset(rect.left + 6, rect.top + 3));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _PrivateLegendDot extends StatelessWidget {
  const _PrivateLegendDot({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: _PrivatePalette.text,
            fontSize: 12,
            fontFamily: 'monospace',
          ),
        ),
      ],
    );
  }
}

// =====================================================================
// SECTION I: AggregatedTimedBlock summary panel
// =====================================================================

class _PrivateAggregateSection extends StatelessWidget {
  const _PrivateAggregateSection();

  @override
  Widget build(BuildContext context) {
    final List<TimedBlock> raw = _privateBuildHundredBlocks();
    final _PrivateAggregateStats stats = _privateAggregate(raw);
    return _PrivateSection(
      title: 'AggregatedTimedBlock — collapsing 100 raw blocks',
      subtitle:
          'AggregatedTimedBlock keeps the per-name count, sum, min, max '
          '(and lets you derive the average).',
      child: Padding(
        padding: const EdgeInsets.all(_PrivateSpacing.s5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                _PrivateStatTile(
                  label: 'name',
                  value: '"build"',
                  color: _PrivatePalette.trace1,
                ),
                _PrivateStatTile(
                  label: 'count',
                  value: '${stats.count}',
                  color: _PrivatePalette.trace2,
                ),
                _PrivateStatTile(
                  label: 'sum',
                  value: '${stats.sum.toStringAsFixed(1)} µs',
                  color: _PrivatePalette.trace3,
                ),
              ],
            ),
            const SizedBox(height: _PrivateSpacing.s2),
            Row(
              children: <Widget>[
                _PrivateStatTile(
                  label: 'min',
                  value: '${stats.min.toStringAsFixed(1)} µs',
                  color: _PrivatePalette.trace4,
                ),
                _PrivateStatTile(
                  label: 'max',
                  value: '${stats.max.toStringAsFixed(1)} µs',
                  color: _PrivatePalette.trace5,
                ),
                _PrivateStatTile(
                  label: 'avg',
                  value: '${(stats.sum / stats.count).toStringAsFixed(1)} µs',
                  color: _PrivatePalette.trace6,
                ),
              ],
            ),
            const SizedBox(height: _PrivateSpacing.s4),
            Container(
              padding: const EdgeInsets.all(_PrivateSpacing.s4),
              decoration: BoxDecoration(
                color: _PrivatePalette.surfaceAlt,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _PrivatePalette.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Distribution preview (sampled 24 of 100 raw blocks)',
                    style: TextStyle(
                      color: _PrivatePalette.textDim,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: _PrivateSpacing.s2),
                  SizedBox(
                    height: 60,
                    child: CustomPaint(
                      painter: _PrivateHistogramPainter(
                        values: <double>[
                          for (int i = 0; i < raw.length; i += 4)
                            raw[i].duration,
                        ],
                      ),
                      size: Size.infinite,
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

class _PrivateAggregateStats {
  const _PrivateAggregateStats({
    required this.count,
    required this.sum,
    required this.min,
    required this.max,
  });

  final int count;
  final double sum;
  final double min;
  final double max;
}

List<TimedBlock> _privateBuildHundredBlocks() {
  final List<TimedBlock> out = <TimedBlock>[];
  double cursor = 0.0;
  for (int i = 0; i < 100; i++) {
    final double d = 800.0 + (i * 53 % 700) + (i % 13) * 7.0;
    out.add(TimedBlock(name: 'build', start: cursor, end: cursor + d));
    cursor += d + 100.0;
  }
  return out;
}

_PrivateAggregateStats _privateAggregate(List<TimedBlock> blocks) {
  double sum = 0;
  double min = double.infinity;
  double max = double.negativeInfinity;
  for (final TimedBlock b in blocks) {
    sum += b.duration;
    if (b.duration < min) min = b.duration;
    if (b.duration > max) max = b.duration;
  }
  return _PrivateAggregateStats(
    count: blocks.length,
    sum: sum,
    min: min,
    max: max,
  );
}

class _PrivateStatTile extends StatelessWidget {
  const _PrivateStatTile({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: _PrivateSpacing.s1),
        padding: const EdgeInsets.symmetric(
          horizontal: _PrivateSpacing.s4,
          vertical: _PrivateSpacing.s3,
        ),
        decoration: BoxDecoration(
          color: _PrivatePalette.surfaceAlt,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: color.withValues(alpha: 0.55)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                letterSpacing: 1.1,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: _PrivatePalette.text,
                fontSize: 16,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateHistogramPainter extends CustomPainter {
  _PrivateHistogramPainter({required this.values});

  final List<double> values;

  @override
  void paint(Canvas canvas, Size size) {
    if (values.isEmpty) return;
    double mx = 0;
    for (final double v in values) {
      if (v > mx) mx = v;
    }
    if (mx == 0) mx = 1;
    final double w = size.width / values.length;
    for (int i = 0; i < values.length; i++) {
      final double h = size.height * (values[i] / mx);
      final Rect r = Rect.fromLTWH(i * w, size.height - h, w - 2, h);
      canvas.drawRRect(
        RRect.fromRectAndRadius(r, const Radius.circular(2)),
        Paint()..color = _PrivatePalette.accent.withValues(alpha: 0.85),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// =====================================================================
// SECTION J: recipe code listing
// =====================================================================

class _PrivateRecipeSection extends StatelessWidget {
  const _PrivateRecipeSection();

  @override
  Widget build(BuildContext context) {
    const String code = '''// Recipe: instrumenting a span with a real TimedBlock.
//
// In production code, the canonical pattern is to open a span, run the
// measured work inside a try/finally, and close it on the way out.

void doExpensiveWork() {
  final block = TimedBlock(name: "expensive_work");
  try {
    // ... user code being measured ...
    runComputation();
  } finally {
    block.finish();
  }
}

// Nested blocks must finish in strict LIFO order.

void doParentAndChild() {
  final outer = TimedBlock(name: "outer");
  try {
    final inner = TimedBlock(name: "inner");
    try {
      doSomething();
    } finally {
      inner.finish();   // close child first
    }
  } finally {
    outer.finish();     // then close parent
  }
}''';
    return _PrivateSection(
      title: 'Recipe — open, measure, finish',
      subtitle:
          'TimedBlock(name) opens; finish() closes. Always pair them in '
          'try/finally.',
      child: Padding(
        padding: const EdgeInsets.all(_PrivateSpacing.s5),
        child: Container(
          padding: const EdgeInsets.all(_PrivateSpacing.s4),
          decoration: BoxDecoration(
            color: _PrivatePalette.surfaceAlt,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: _PrivatePalette.border),
          ),
          child: SelectableText(
            code,
            style: TextStyle(
              color: _PrivatePalette.text,
              fontFamily: 'monospace',
              fontSize: 12.5,
              height: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// SECTION K: relationship with Timeline.startSync / finishSync
// =====================================================================

class _PrivateTimelineRelation extends StatelessWidget {
  const _PrivateTimelineRelation();

  @override
  Widget build(BuildContext context) {
    return _PrivateSection(
      title: 'Relationship with Timeline.startSync / finishSync',
      subtitle:
          'TimedBlock is the framework data view of a span that the engine '
          'collected through Timeline.',
      child: Padding(
        padding: const EdgeInsets.all(_PrivateSpacing.s5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: _PrivateBridgeCard(
                title: 'dart:developer side',
                lines: const <String>[
                  'Timeline.startSync("layout");',
                  '// ... measured work ...',
                  'Timeline.finishSync();',
                ],
                color: _PrivatePalette.trace2,
                footnote:
                    'The engine receives raw begin/end trace events.',
              ),
            ),
            const SizedBox(width: _PrivateSpacing.s4),
            Container(
              width: 38,
              alignment: Alignment.center,
              child: Icon(
                Icons.compare_arrows,
                color: _PrivatePalette.accent,
                size: 28,
              ),
            ),
            const SizedBox(width: _PrivateSpacing.s4),
            Expanded(
              child: _PrivateBridgeCard(
                title: 'foundation side',
                lines: const <String>[
                  'TimedBlock(',
                  '  name: "layout",',
                  '  start: 1800.0,',
                  '  end:   2900.0,',
                  ');',
                ],
                color: _PrivatePalette.trace3,
                footnote:
                    'The framework wraps each span as a TimedBlock for the '
                    'inspector.',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PrivateBridgeCard extends StatelessWidget {
  const _PrivateBridgeCard({
    required this.title,
    required this.lines,
    required this.color,
    required this.footnote,
  });

  final String title;
  final List<String> lines;
  final Color color;
  final String footnote;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_PrivateSpacing.s4),
      decoration: BoxDecoration(
        color: _PrivatePalette.surfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.6)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 13,
              fontWeight: FontWeight.w800,
              letterSpacing: 1.1,
            ),
          ),
          const SizedBox(height: _PrivateSpacing.s2),
          for (final String line in lines)
            Padding(
              padding: const EdgeInsets.only(bottom: 2),
              child: Text(
                line,
                style: TextStyle(
                  color: _PrivatePalette.text,
                  fontSize: 12.5,
                  fontFamily: 'monospace',
                ),
              ),
            ),
          const SizedBox(height: _PrivateSpacing.s3),
          Text(
            footnote,
            style: TextStyle(
              color: _PrivatePalette.textDim,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

// =====================================================================
// SECTION L: pitfalls
// =====================================================================

class _PrivatePitfalls extends StatelessWidget {
  const _PrivatePitfalls();

  @override
  Widget build(BuildContext context) {
    final List<_PrivatePitfall> items = <_PrivatePitfall>[
      _PrivatePitfall(
        symbol: '!',
        title: 'Forgetting to call finish()',
        body: 'A block that is never finished leaks: it stays open in the '
            'collector, the timeline never closes, and aggregation skips it.',
        color: _PrivatePalette.danger,
      ),
      _PrivatePitfall(
        symbol: '!',
        title: 'Wrong nesting order',
        body: 'Nested blocks must finish in LIFO order. Closing the parent '
            'before the child produces overlapping or interleaved spans, '
            'which DevTools rejects.',
        color: _PrivatePalette.danger,
      ),
      _PrivatePitfall(
        symbol: '!',
        title: 'Async work between start and finish',
        body: 'TimedBlock measures synchronous wall time. Putting an await '
            'between TimedBlock(name) and finish() inflates the duration '
            'with idle time.',
        color: _PrivatePalette.danger,
      ),
      _PrivatePitfall(
        symbol: 'i',
        title: 'Names should be stable',
        body: 'Aggregation groups by name. If the name varies per call '
            '(e.g. includes an id), aggregation degenerates into one entry '
            'per call.',
        color: _PrivatePalette.accent,
      ),
    ];
    return _PrivateSection(
      title: 'Pitfalls & best practices',
      subtitle:
          'Cheap rules that keep your timeline data clean and aggregable.',
      child: Padding(
        padding: const EdgeInsets.all(_PrivateSpacing.s5),
        child: Column(
          children: <Widget>[
            for (final _PrivatePitfall p in items) ...<Widget>[
              _PrivatePitfallCard(item: p),
              const SizedBox(height: _PrivateSpacing.s2),
            ],
          ],
        ),
      ),
    );
  }
}

class _PrivatePitfall {
  const _PrivatePitfall({
    required this.symbol,
    required this.title,
    required this.body,
    required this.color,
  });

  final String symbol;
  final String title;
  final String body;
  final Color color;
}

class _PrivatePitfallCard extends StatelessWidget {
  const _PrivatePitfallCard({required this.item});

  final _PrivatePitfall item;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_PrivateSpacing.s4),
      decoration: BoxDecoration(
        color: _PrivatePalette.surfaceAlt,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: item.color.withValues(alpha: 0.55)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: item.color.withValues(alpha: 0.18),
              shape: BoxShape.circle,
              border: Border.all(color: item.color),
            ),
            child: Text(
              item.symbol,
              style: TextStyle(
                color: item.color,
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(width: _PrivateSpacing.s3),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  item.title,
                  style: TextStyle(
                    color: _PrivatePalette.text,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item.body,
                  style: TextStyle(
                    color: _PrivatePalette.textDim,
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

// =====================================================================
// SECTION M: footer
// =====================================================================

class _PrivateFooter extends StatelessWidget {
  const _PrivateFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(_PrivateSpacing.s5),
      decoration: BoxDecoration(
        color: _PrivatePalette.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(Icons.timer_outlined, color: _PrivatePalette.accent, size: 28),
          const SizedBox(width: _PrivateSpacing.s4),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Recap',
                  style: TextStyle(
                    color: _PrivatePalette.accent,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1.1,
                  ),
                ),
                const SizedBox(height: _PrivateSpacing.s2),
                Text(
                  'TimedBlock is the foundation-level data record for one '
                  'measured span: { name, start, end, duration }. Open with '
                  'TimedBlock(name), close with finish() (engine-side, via '
                  'Timeline.startSync/finishSync), aggregate with '
                  'AggregatedTimedBlock for tooling. Always pair open/close '
                  'in try/finally and respect LIFO nesting — that is the '
                  'whole contract.',
                  style: TextStyle(
                    color: _PrivatePalette.text,
                    fontSize: 13,
                    height: 1.5,
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

// =====================================================================
// SECTION N: shared section shell + tag
// =====================================================================

class _PrivateSection extends StatelessWidget {
  const _PrivateSection({
    required this.title,
    required this.subtitle,
    required this.child,
  });

  final String title;
  final String subtitle;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _PrivatePalette.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: _PrivateSpacing.s5,
              vertical: _PrivateSpacing.s4,
            ),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: _PrivatePalette.border),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                    color: _PrivatePalette.text,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: _PrivatePalette.textDim,
                    fontSize: 13,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}

class _PrivateTag extends StatelessWidget {
  const _PrivateTag({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _PrivatePalette.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: _PrivatePalette.border),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: _PrivatePalette.accent,
          fontSize: 11,
          fontFamily: 'monospace',
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}
