// ignore_for_file: unused_field, unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, sort_child_properties_last
// D4rt visual deep demo: AggregatedTimedBlock from package:flutter/foundation.dart
//
// AggregatedTimedBlock is the lightweight "summary value object" emitted by
// Flutter's foundation Timeline subsystem when many small TimedBlock entries
// are reduced to a single statistical record (count, summed duration, name).
// It powers DevTools' aggregated histogram/timeline view and is the unit of
// information produced by AggregatedTimings.aggregatedBlocks.
//
// This file contains a hand-written, single-build, static visualization that
// walks through:
//   1. Hero introduction (many bars to one histogram metaphor)
//   2. Anatomy of AggregatedTimedBlock(name, duration, count)
//   3. Relationship with TimedBlock raw entries
//   4. Six sample aggregate cards (build/layout/paint/composite/raster/engine)
//   5. CustomPainter horizontal stacked-bar of proportions
//   6. Statistics panel (count, sum, avg, derived min, derived max)
//   7. DevTools timeline view explainer
//   8. Recipe / pseudo-code listing for aggregating raw blocks
//   9. Side-by-side comparison: AggregatedTimedBlock vs raw TimedBlock list
//  10. Pitfalls: averages vs percentiles, sum overflow on long sessions
//  11. Footer with reference links
//
// Strict rules: a single static `dynamic build(BuildContext)` entry, MaterialApp
// wrapper, no setState/controllers/async/Future/Timer/streams. Classes are
// PascalCase, top-level functions/values are lowerCamelCase.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// Top-level color tokens (lowerCamelCase, const where useful).
// ---------------------------------------------------------------------------

const Color paletteBg = Color(0xFF0F1115);
const Color paletteSurface = Color(0xFF181B22);
const Color paletteSurfaceAlt = Color(0xFF20242D);
const Color paletteBorder = Color(0xFF2C313C);
const Color paletteText = Color(0xFFE6E8EE);
const Color paletteTextDim = Color(0xFF9AA1B0);
const Color paletteAccent = Color(0xFF7AA8FF);
const Color paletteAccent2 = Color(0xFFB48BFF);
const Color paletteOk = Color(0xFF6FE0A1);
const Color paletteWarn = Color(0xFFE8C26B);
const Color paletteBad = Color(0xFFE07A8B);

const Color phaseBuild = Color(0xFF7AA8FF);
const Color phaseLayout = Color(0xFFB48BFF);
const Color phasePaint = Color(0xFF6FE0A1);
const Color phaseComposite = Color(0xFFE8C26B);
const Color phaseRaster = Color(0xFFE07A8B);
const Color phaseEngine = Color(0xFF8AD7E0);

// ---------------------------------------------------------------------------
// Domain model (PascalCase classes / typedefs)
// ---------------------------------------------------------------------------

class SamplePhase {
  final String name;
  final int count;
  final double sumMicros;
  final double avgMicros;
  final double minMicros;
  final double maxMicros;
  final Color color;
  final String description;
  const SamplePhase({
    required this.name,
    required this.count,
    required this.sumMicros,
    required this.avgMicros,
    required this.minMicros,
    required this.maxMicros,
    required this.color,
    required this.description,
  });
}

class FieldRow {
  final String field;
  final String type;
  final String example;
  final String meaning;
  const FieldRow({
    required this.field,
    required this.type,
    required this.example,
    required this.meaning,
  });
}

class ComparisonRow {
  final String aspect;
  final String aggregated;
  final String raw;
  const ComparisonRow({
    required this.aspect,
    required this.aggregated,
    required this.raw,
  });
}

class PitfallEntry {
  final String title;
  final String body;
  final IconData icon;
  final Color tone;
  const PitfallEntry({
    required this.title,
    required this.body,
    required this.icon,
    required this.tone,
  });
}

// ---------------------------------------------------------------------------
// Sample data — six aggregate phases as required by the spec.
// build_phase: count=120 sum=240ms avg=2ms
// layout_phase: count=120 sum=180ms avg=1.5ms
// paint_phase: count=120 sum=90ms avg=0.75ms
// composite_phase: count=60 sum=30ms avg=0.5ms
// gpu_raster: count=120 sum=600ms avg=5ms
// engine_main: count=120 sum=120ms avg=1ms
// Durations are stored as microseconds (matching foundation's convention).
// ---------------------------------------------------------------------------

const List<SamplePhase> samplePhases = <SamplePhase>[
  SamplePhase(
    name: 'build_phase',
    count: 120,
    sumMicros: 240000.0,
    avgMicros: 2000.0,
    minMicros: 980.0,
    maxMicros: 5400.0,
    color: phaseBuild,
    description:
        'Widget rebuilds in the framework: createState, didUpdateWidget, '
        'build() invocations, and Element diffing.',
  ),
  SamplePhase(
    name: 'layout_phase',
    count: 120,
    sumMicros: 180000.0,
    avgMicros: 1500.0,
    minMicros: 720.0,
    maxMicros: 4100.0,
    color: phaseLayout,
    description:
        'RenderObject layout: performLayout, applyConstraints, intrinsic '
        'dimension queries, and child positioning.',
  ),
  SamplePhase(
    name: 'paint_phase',
    count: 120,
    sumMicros: 90000.0,
    avgMicros: 750.0,
    minMicros: 320.0,
    maxMicros: 2200.0,
    color: phasePaint,
    description:
        'paint() walking the render tree, recording PictureLayer drawing '
        'commands into the layer tree.',
  ),
  SamplePhase(
    name: 'composite_phase',
    count: 60,
    sumMicros: 30000.0,
    avgMicros: 500.0,
    minMicros: 220.0,
    maxMicros: 1100.0,
    color: phaseComposite,
    description:
        'Compositor scene assembly: pushing layers, transforms, opacity, '
        'and clip operations onto the SceneBuilder.',
  ),
  SamplePhase(
    name: 'gpu_raster',
    count: 120,
    sumMicros: 600000.0,
    avgMicros: 5000.0,
    minMicros: 1900.0,
    maxMicros: 18000.0,
    color: phaseRaster,
    description:
        'Rasterization on the GPU thread (Impeller/Skia): converting the '
        'layer tree into pixel commands and dispatching to the GPU.',
  ),
  SamplePhase(
    name: 'engine_main',
    count: 120,
    sumMicros: 120000.0,
    avgMicros: 1000.0,
    minMicros: 480.0,
    maxMicros: 3000.0,
    color: phaseEngine,
    description:
        'Engine-side bookkeeping per frame: vsync handling, animation '
        'tick scheduling, microtask drain, and Dart isolate trampolines.',
  ),
];

// Field-by-field anatomy table.
const List<FieldRow> anatomyRows = <FieldRow>[
  FieldRow(
    field: 'name',
    type: 'final String',
    example: "'build_phase'",
    meaning:
        'Human-readable category label, copied from the source TimedBlock '
        'entries used during aggregation.',
  ),
  FieldRow(
    field: 'duration',
    type: 'final double',
    example: '240000.0',
    meaning:
        'Sum of all source TimedBlock durations under this name, expressed '
        'in microseconds (matches foundation Timeline timestamps).',
  ),
  FieldRow(
    field: 'count',
    type: 'final int',
    example: '120',
    meaning:
        'How many raw TimedBlock entries were folded together to produce '
        'this aggregate. Used to compute mean duration.',
  ),
];

// Comparison rows.
const List<ComparisonRow> comparisonRows = <ComparisonRow>[
  ComparisonRow(
    aspect: 'Memory cost',
    aggregated: 'O(unique names) — six entries cover thousands of frames.',
    raw: 'O(events) — every recorded begin/end pair lives until export.',
  ),
  ComparisonRow(
    aspect: 'Detail level',
    aggregated: 'Loses ordering; preserves count, sum, derived mean.',
    raw: 'Preserves wall-clock start/end and per-event nesting.',
  ),
  ComparisonRow(
    aspect: 'Best for',
    aggregated: 'Long-running profiling sessions, dashboards, alerts.',
    raw: 'Frame-by-frame inspection, jank root-cause hunts.',
  ),
  ComparisonRow(
    aspect: 'API entry',
    aggregated: 'AggregatedTimings.aggregatedBlocks',
    raw: 'AggregatedTimings.timedBlocks',
  ),
  ComparisonRow(
    aspect: 'Construction',
    aggregated: 'AggregatedTimedBlock(name:, duration:, count:)',
    raw: 'TimedBlock(start:, end:, name:)',
  ),
  ComparisonRow(
    aspect: 'Statistical safety',
    aggregated: 'Mean only; no min/max/percentiles.',
    raw: 'Full distribution can be re-derived after the fact.',
  ),
];

// Pitfalls.
const List<PitfallEntry> pitfallEntries = <PitfallEntry>[
  PitfallEntry(
    title: 'Average is not a percentile',
    body:
        'A mean of 2 ms says nothing about the 99th percentile. A handful of '
        '60 ms outliers — the actual jank — disappear into the average.',
    icon: Icons.warning_amber_rounded,
    tone: paletteWarn,
  ),
  PitfallEntry(
    title: 'Sum overflow on long sessions',
    body:
        'duration is a double of microseconds. Hours of profiling can push '
        'the sum past 1e9 µs (~16 minutes). Reset aggregates per scene.',
    icon: Icons.report_gmailerrorred_outlined,
    tone: paletteBad,
  ),
  PitfallEntry(
    title: 'Name collisions hide phases',
    body:
        'If two unrelated subsystems both emit the same name, their counts '
        'and sums merge. Namespacing (e.g. "ui.layout") helps separate them.',
    icon: Icons.merge_type,
    tone: paletteAccent2,
  ),
  PitfallEntry(
    title: 'Aggregated blocks do not compose',
    body:
        'You cannot reconstruct a histogram from an AggregatedTimedBlock. '
        'Keep raw TimedBlock data if you ever need percentiles.',
    icon: Icons.layers_clear_outlined,
    tone: paletteAccent,
  ),
];

// ---------------------------------------------------------------------------
// Helpers
// ---------------------------------------------------------------------------

String formatMicros(double micros) {
  if (micros >= 1000.0) {
    final ms = micros / 1000.0;
    return '${ms.toStringAsFixed(2)} ms';
  }
  return '${micros.toStringAsFixed(1)} µs';
}

double sumOfPhase(SamplePhase p) => p.sumMicros;

double totalSum() {
  var t = 0.0;
  for (final p in samplePhases) {
    t += p.sumMicros;
  }
  return t;
}

int totalCount() {
  var c = 0;
  for (final p in samplePhases) {
    c += p.count;
  }
  return c;
}

double globalMean() {
  final c = totalCount();
  if (c == 0) return 0.0;
  return totalSum() / c;
}

double globalMin() {
  var m = samplePhases.first.minMicros;
  for (final p in samplePhases) {
    if (p.minMicros < m) m = p.minMicros;
  }
  return m;
}

double globalMax() {
  var m = samplePhases.first.maxMicros;
  for (final p in samplePhases) {
    if (p.maxMicros > m) m = p.maxMicros;
  }
  return m;
}

// ---------------------------------------------------------------------------
// Build the Real AggregatedTimedBlock instances so the demo also documents
// real interaction with the foundation API. These instances are listed in
// the recipe section.
// ---------------------------------------------------------------------------

List<AggregatedTimedBlock> realAggregated() {
  return <AggregatedTimedBlock>[
    AggregatedTimedBlock(name: 'build_phase', duration: 240000.0, count: 120),
    AggregatedTimedBlock(name: 'layout_phase', duration: 180000.0, count: 120),
    AggregatedTimedBlock(name: 'paint_phase', duration: 90000.0, count: 120),
    AggregatedTimedBlock(name: 'composite_phase', duration: 30000.0, count: 60),
    AggregatedTimedBlock(name: 'gpu_raster', duration: 600000.0, count: 120),
    AggregatedTimedBlock(name: 'engine_main', duration: 120000.0, count: 120),
  ];
}

// ---------------------------------------------------------------------------
// CustomPainter — many bars to one histogram metaphor (hero) and the
// horizontal stacked bar showing phase proportion.
// ---------------------------------------------------------------------------

class HeroAggregationPainter extends CustomPainter {
  final List<SamplePhase> phases;
  const HeroAggregationPainter(this.phases);

  @override
  void paint(Canvas canvas, Size size) {
    final bg = Paint()..color = paletteSurface;
    canvas.drawRRect(
      RRect.fromRectAndRadius(Offset.zero & size, const Radius.circular(16)),
      bg,
    );

    // Left half: many thin bars representing raw TimedBlock entries.
    final leftWidth = size.width * 0.42;
    final leftRect = Rect.fromLTWH(
      14,
      14,
      leftWidth - 14,
      size.height - 28,
    );
    final leftBg = Paint()..color = paletteSurfaceAlt;
    canvas.drawRRect(
      RRect.fromRectAndRadius(leftRect, const Radius.circular(10)),
      leftBg,
    );

    // Draw approx 60 thin bars with varying heights.
    const barCount = 60;
    final barAreaW = leftRect.width - 16;
    final barW = barAreaW / barCount;
    final baseY = leftRect.bottom - 12;
    for (var i = 0; i < barCount; i++) {
      final phase = phases[i % phases.length];
      final p = Paint()..color = phase.color;
      final t = ((i * 37) % 100) / 100.0;
      final h = 14.0 + t * (leftRect.height - 30);
      final x = leftRect.left + 8 + i * barW;
      canvas.drawRect(
        Rect.fromLTWH(x, baseY - h, barW * 0.7, h),
        p,
      );
    }

    // Arrow in the middle.
    final arrowStart = leftRect.right + 10;
    final arrowEnd = arrowStart + (size.width * 0.10);
    final arrowY = size.height / 2;
    final arrowPaint = Paint()
      ..color = paletteText
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(arrowStart, arrowY), Offset(arrowEnd, arrowY), arrowPaint);
    final headPath = Path()
      ..moveTo(arrowEnd, arrowY)
      ..lineTo(arrowEnd - 10, arrowY - 6)
      ..lineTo(arrowEnd - 10, arrowY + 6)
      ..close();
    canvas.drawPath(headPath, Paint()..color = paletteText);

    // Right half: aggregated stacked bar with 6 segments.
    final rightLeft = arrowEnd + 12;
    final rightRect = Rect.fromLTWH(
      rightLeft,
      14,
      size.width - rightLeft - 14,
      size.height - 28,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rightRect, const Radius.circular(10)),
      Paint()..color = paletteSurfaceAlt,
    );

    // The aggregated bar.
    final total = totalSum();
    final aggBarRect = Rect.fromLTWH(
      rightRect.left + 14,
      rightRect.top + rightRect.height / 2 - 22,
      rightRect.width - 28,
      44,
    );
    var x = aggBarRect.left;
    for (final p in phases) {
      final w = aggBarRect.width * (p.sumMicros / total);
      final paint = Paint()..color = p.color;
      canvas.drawRect(
        Rect.fromLTWH(x, aggBarRect.top, w, aggBarRect.height),
        paint,
      );
      x += w;
    }
    // Frame around aggregate bar.
    final frame = Paint()
      ..color = paletteBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRect(aggBarRect, frame);
  }

  @override
  bool shouldRepaint(covariant HeroAggregationPainter oldDelegate) => false;
}

class StackedProportionPainter extends CustomPainter {
  final List<SamplePhase> phases;
  const StackedProportionPainter(this.phases);

  @override
  void paint(Canvas canvas, Size size) {
    final total = totalSum();
    if (total <= 0) return;

    final barRect = Rect.fromLTWH(0, 0, size.width, size.height);
    const radius = Radius.circular(8);

    // Outer rounded clip.
    final clipPath = Path()
      ..addRRect(RRect.fromRectAndRadius(barRect, radius));
    canvas.save();
    canvas.clipPath(clipPath);

    var x = 0.0;
    for (final p in phases) {
      final w = size.width * (p.sumMicros / total);
      canvas.drawRect(
        Rect.fromLTWH(x, 0, w, size.height),
        Paint()..color = p.color,
      );
      // Tick mark.
      final tick = Paint()
        ..color = paletteBg
        ..strokeWidth = 1.0;
      if (x > 0) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), tick);
      }
      x += w;
    }

    canvas.restore();

    // Border.
    final border = Paint()
      ..color = paletteBorder
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawRRect(RRect.fromRectAndRadius(barRect, radius), border);
  }

  @override
  bool shouldRepaint(covariant StackedProportionPainter oldDelegate) => false;
}

// ---------------------------------------------------------------------------
// Entry point — single static `dynamic build(BuildContext)`.
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // Sanity construction of real AggregatedTimedBlock instances.
  final realBlocks = realAggregated();

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'AggregatedTimedBlock — Deep Demo',
    theme: ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: paletteBg,
      textTheme: const TextTheme(
        bodyMedium: TextStyle(color: paletteText, fontSize: 13),
      ),
      colorScheme: const ColorScheme.dark(
        primary: paletteAccent,
        secondary: paletteAccent2,
        surface: paletteSurface,
      ),
    ),
    home: Scaffold(
      backgroundColor: paletteBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // ============================================================
              // SECTION 1: Hero
              // ============================================================
              const _SectionTitle(
                index: '01',
                title: 'AggregatedTimedBlock',
                subtitle:
                    'Many raw TimedBlock samples → one statistical record',
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: paletteSurface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: paletteBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'A foundation primitive',
                      style: TextStyle(
                        color: paletteAccent,
                        fontSize: 12,
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const Text(
                      'AggregatedTimedBlock is the value type that\n'
                      'AggregatedTimings emits per unique TimedBlock name.\n'
                      'It folds an arbitrary number of raw start/end events\n'
                      'into three immutable fields: name, summed duration\n'
                      '(in microseconds), and count.',
                      style: TextStyle(color: paletteText, fontSize: 15, height: 1.5),
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      height: 160,
                      child: CustomPaint(
                        painter: const HeroAggregationPainter(samplePhases),
                        size: Size.infinite,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: const <Widget>[
                        _PillTag(label: 'package:flutter/foundation.dart', color: paletteAccent),
                        SizedBox(width: 8),
                        _PillTag(label: 'final class', color: paletteAccent2),
                        SizedBox(width: 8),
                        _PillTag(label: 'immutable', color: paletteOk),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ============================================================
              // SECTION 2: Anatomy of the constructor
              // ============================================================
              const _SectionTitle(
                index: '02',
                title: 'Anatomy of the constructor',
                subtitle:
                    'AggregatedTimedBlock({required name, required duration, required count})',
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: paletteSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: paletteBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const _CodeBlock(
                      code:
                          'final class AggregatedTimedBlock {\n'
                          '  const AggregatedTimedBlock({\n'
                          '    required this.name,\n'
                          '    required this.duration,\n'
                          '    required this.count,\n'
                          '  })  : assert(duration >= 0),\n'
                          '        assert(count >= 0);\n'
                          '\n'
                          '  final String name;\n'
                          '  final double duration; // microseconds, summed\n'
                          '  final int    count;    // # of source TimedBlocks\n'
                          '}',
                    ),
                    const SizedBox(height: 14),
                    Table(
                      columnWidths: const <int, TableColumnWidth>{
                        0: FixedColumnWidth(110),
                        1: FixedColumnWidth(140),
                        2: FixedColumnWidth(150),
                        3: FlexColumnWidth(),
                      },
                      defaultVerticalAlignment: TableCellVerticalAlignment.top,
                      children: <TableRow>[
                        const TableRow(
                          decoration: BoxDecoration(color: paletteSurfaceAlt),
                          children: <Widget>[
                            _TableHead(text: 'Field'),
                            _TableHead(text: 'Type'),
                            _TableHead(text: 'Example'),
                            _TableHead(text: 'Meaning'),
                          ],
                        ),
                        for (final r in anatomyRows)
                          TableRow(
                            children: <Widget>[
                              _TableCell(text: r.field, mono: true, color: paletteAccent),
                              _TableCell(text: r.type, mono: true),
                              _TableCell(text: r.example, mono: true, color: paletteOk),
                              _TableCell(text: r.meaning),
                            ],
                          ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ============================================================
              // SECTION 3: Relationship with TimedBlock
              // ============================================================
              const _SectionTitle(
                index: '03',
                title: 'Relationship with TimedBlock',
                subtitle:
                    'a–b–c–d–e raw entries → one aggregated card per name',
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: paletteSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: paletteBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Inspector / Timeline produces dozens of TimedBlock '
                      'instances per frame. AggregatedTimings folds entries '
                      'with identical names. The diagram below shows five '
                      'raw "build_phase" blocks (a–b–c–d–e) being reduced.',
                      style: TextStyle(color: paletteTextDim, height: 1.5),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          flex: 5,
                          child: Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: paletteSurfaceAlt,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                _RawTimedBlockRow(label: 'a', name: 'build_phase', start: 0, end: 1900),
                                _RawTimedBlockRow(label: 'b', name: 'build_phase', start: 1900, end: 4100),
                                _RawTimedBlockRow(label: 'c', name: 'build_phase', start: 4100, end: 5700),
                                _RawTimedBlockRow(label: 'd', name: 'build_phase', start: 5700, end: 7800),
                                _RawTimedBlockRow(label: 'e', name: 'build_phase', start: 7800, end: 9300),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        const _ArrowIcon(),
                        const SizedBox(width: 14),
                        const Expanded(
                          flex: 4,
                          child: _AggregateCard(
                            phase: SamplePhase(
                              name: 'build_phase',
                              count: 5,
                              sumMicros: 9300.0,
                              avgMicros: 1860.0,
                              minMicros: 1500.0,
                              maxMicros: 2200.0,
                              color: phaseBuild,
                              description:
                                  'a..e folded into one AggregatedTimedBlock.',
                            ),
                            highlight: true,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'In real Flutter code:',
                      style: TextStyle(
                        color: paletteTextDim,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 6),
                    const _CodeBlock(
                      code:
                          'final timings = AggregatedTimings(rawTimedBlocks);\n'
                          'for (final agg in timings.aggregatedBlocks) {\n'
                          '  print(\'\${agg.name}: count=\${agg.count} '
                          'duration=\${agg.duration}\');\n'
                          '}',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ============================================================
              // SECTION 4: Six sample aggregate cards
              // ============================================================
              const _SectionTitle(
                index: '04',
                title: 'Six sample aggregate cards',
                subtitle:
                    'Per-phase counts and sums for a 2-second profiling window',
              ),
              const SizedBox(height: 12),
              // 20260524-2003 baseline §6/H-secondary todo #14
              // (aggregated_timed_block_test): 6×14 px bottom overflow
              // — `_AggregateCard` natural height is ~14 px taller
              // than 1.45 aspect gives at the flutter_ast pane's
              // ~700/3-col cell width. Drop to 1.18 to widen the cell
              // vertically.
              GridView.count(
                crossAxisCount: 3,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.18,
                children: <Widget>[
                  for (final p in samplePhases)
                    _AggregateCard(phase: p, highlight: false),
                ],
              ),

              const SizedBox(height: 32),

              // ============================================================
              // SECTION 5: Stacked horizontal bar (CustomPainter)
              // ============================================================
              const _SectionTitle(
                index: '05',
                title: 'Proportional stacked bar',
                subtitle:
                    'Each segment width = phase.sum / Σ phase.sum (custom paint)',
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: paletteSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: paletteBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 38,
                      child: CustomPaint(
                        painter: const StackedProportionPainter(samplePhases),
                        size: Size.infinite,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 14,
                      runSpacing: 8,
                      children: <Widget>[
                        for (final p in samplePhases)
                          _LegendChip(
                            color: p.color,
                            label: p.name,
                            value:
                                '${(p.sumMicros / totalSum() * 100).toStringAsFixed(1)} %',
                          ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'gpu_raster dominates wall-clock time even though every '
                      'phase has the same count of TimedBlock entries — a '
                      'classic example where AggregatedTimedBlock immediately '
                      'reveals where the engine is spending cycles.',
                      style: TextStyle(color: paletteTextDim, height: 1.5),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ============================================================
              // SECTION 6: Statistics panel — count / sum / avg / min / max
              // ============================================================
              const _SectionTitle(
                index: '06',
                title: 'Derived statistics panel',
                subtitle:
                    'count and sum are stored; avg = sum/count; min/max derived externally',
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: paletteSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: paletteBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        _StatTile(
                          label: 'phases',
                          value: '${samplePhases.length}',
                          tone: paletteAccent,
                        ),
                        const SizedBox(width: 10),
                        _StatTile(
                          label: 'total count',
                          value: '${totalCount()}',
                          tone: paletteAccent2,
                        ),
                        const SizedBox(width: 10),
                        _StatTile(
                          label: 'total sum',
                          value: formatMicros(totalSum()),
                          tone: paletteOk,
                        ),
                        const SizedBox(width: 10),
                        _StatTile(
                          label: 'global mean',
                          value: formatMicros(globalMean()),
                          tone: paletteWarn,
                        ),
                        const SizedBox(width: 10),
                        _StatTile(
                          label: 'global min',
                          value: formatMicros(globalMin()),
                          tone: paletteAccent,
                        ),
                        const SizedBox(width: 10),
                        _StatTile(
                          label: 'global max',
                          value: formatMicros(globalMax()),
                          tone: paletteBad,
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: paletteSurfaceAlt,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          const Text(
                            'Per-phase derived view',
                            style: TextStyle(
                              color: paletteAccent,
                              fontSize: 12,
                              letterSpacing: 1.2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Table(
                            columnWidths: const <int, TableColumnWidth>{
                              0: FixedColumnWidth(150),
                              1: FixedColumnWidth(80),
                              2: FixedColumnWidth(120),
                              3: FixedColumnWidth(110),
                              4: FixedColumnWidth(110),
                              5: FlexColumnWidth(),
                            },
                            children: <TableRow>[
                              const TableRow(
                                decoration: BoxDecoration(color: paletteBg),
                                children: <Widget>[
                                  _TableHead(text: 'name'),
                                  _TableHead(text: 'count'),
                                  _TableHead(text: 'sum'),
                                  _TableHead(text: 'avg'),
                                  _TableHead(text: 'min*'),
                                  _TableHead(text: 'max*'),
                                ],
                              ),
                              for (final p in samplePhases)
                                TableRow(
                                  children: <Widget>[
                                    _TableCell(text: p.name, mono: true, color: p.color),
                                    _TableCell(text: '${p.count}'),
                                    _TableCell(text: formatMicros(p.sumMicros), mono: true),
                                    _TableCell(text: formatMicros(p.avgMicros), mono: true, color: paletteOk),
                                    _TableCell(text: formatMicros(p.minMicros), mono: true, color: paletteAccent),
                                    _TableCell(text: formatMicros(p.maxMicros), mono: true, color: paletteBad),
                                  ],
                                ),
                            ],
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            '* min and max are NOT stored on AggregatedTimedBlock. '
                            'They must be derived from the original raw '
                            'TimedBlock list before aggregation.',
                            style: TextStyle(
                              color: paletteTextDim,
                              fontSize: 11,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ============================================================
              // SECTION 7: DevTools usage explainer
              // ============================================================
              const _SectionTitle(
                index: '07',
                title: 'Usage in DevTools timeline view',
                subtitle:
                    'How the Performance tab consumes AggregatedTimedBlock',
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: paletteSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: paletteBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const _ExplainerStep(
                      step: '1',
                      title: 'Engine emits TimedBlock events',
                      body:
                          'During a profiling session the Flutter engine and '
                          'framework emit Timeline begin/end pairs, each '
                          'becoming a TimedBlock(start, end, name).',
                    ),
                    const _ExplainerStep(
                      step: '2',
                      title: 'AggregatedTimings folds by name',
                      body:
                          'When DevTools requests a summary, '
                          'AggregatedTimings(rawBlocks) lazily computes a '
                          'List<AggregatedTimedBlock> via groupBy(name).',
                    ),
                    const _ExplainerStep(
                      step: '3',
                      title: 'DevTools renders an aggregated histogram',
                      body:
                          'Each AggregatedTimedBlock is drawn as one bar in '
                          'the Performance > Frame Times panel. count drives '
                          'tooltip text, duration drives bar height/width.',
                    ),
                    const _ExplainerStep(
                      step: '4',
                      title: 'User clicks a bar → drill-down',
                      body:
                          'On click, DevTools queries the original raw '
                          'TimedBlocks (via AggregatedTimings.timedBlocks) '
                          'so that ordering and per-event detail re-appear.',
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: paletteSurfaceAlt,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: const <Widget>[
                          Icon(Icons.lightbulb_outline, color: paletteWarn, size: 18),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Tip: The "Aggregated" toggle in DevTools '
                              'switches the rendering between '
                              'AggregatedTimings.timedBlocks (raw) and '
                              'AggregatedTimings.aggregatedBlocks (this type).',
                              style: TextStyle(color: paletteTextDim, height: 1.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ============================================================
              // SECTION 8: Recipe — illustrative aggregation loop
              // ============================================================
              const _SectionTitle(
                index: '08',
                title: 'Recipe: aggregating raw TimedBlocks by hand',
                subtitle:
                    'How a profiling tool would build AggregatedTimedBlocks',
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: paletteSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: paletteBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'Below is a faithful, illustrative reproduction of the '
                      'core aggregation loop used inside AggregatedTimings. '
                      'It sums durations and counts entries grouped by name.',
                      style: TextStyle(color: paletteTextDim, height: 1.5),
                    ),
                    const SizedBox(height: 12),
                    const _CodeBlock(
                      code:
                          '// Inputs: a List<TimedBlock> rawBlocks.\n'
                          'final Map<String, _Acc> byName = <String, _Acc>{};\n'
                          'for (final block in rawBlocks) {\n'
                          '  final acc = byName.putIfAbsent(\n'
                          '    block.name,\n'
                          '    () => _Acc(0.0, 0),\n'
                          '  );\n'
                          '  acc.duration += (block.end - block.start);\n'
                          '  acc.count += 1;\n'
                          '}\n'
                          '\n'
                          'final aggregates = <AggregatedTimedBlock>[\n'
                          '  for (final e in byName.entries)\n'
                          '    AggregatedTimedBlock(\n'
                          '      name: e.key,\n'
                          '      duration: e.value.duration,\n'
                          '      count: e.value.count,\n'
                          '    ),\n'
                          '];\n'
                          '\n'
                          '// _Acc is a tiny mutable scratch class.\n'
                          'class _Acc {\n'
                          '  _Acc(this.duration, this.count);\n'
                          '  double duration;\n'
                          '  int count;\n'
                          '}',
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Live invocation in this demo (constructed at build):',
                      style: TextStyle(color: paletteTextDim, fontSize: 12, fontStyle: FontStyle.italic),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: paletteSurfaceAlt,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (final b in realBlocks)
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: Text(
                                'AggregatedTimedBlock(name: "${b.name}", '
                                'duration: ${b.duration.toStringAsFixed(1)}, '
                                'count: ${b.count})',
                                style: const TextStyle(
                                  color: paletteText,
                                  fontFamily: 'monospace',
                                  fontSize: 12,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ============================================================
              // SECTION 9: Comparison — aggregated vs raw
              // ============================================================
              const _SectionTitle(
                index: '09',
                title: 'AggregatedTimedBlock vs raw TimedBlock list',
                subtitle:
                    'Trade-offs between summary and full event detail',
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: paletteSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: paletteBorder),
                ),
                child: Table(
                  columnWidths: const <int, TableColumnWidth>{
                    0: FixedColumnWidth(180),
                    1: FlexColumnWidth(),
                    2: FlexColumnWidth(),
                  },
                  defaultVerticalAlignment: TableCellVerticalAlignment.top,
                  children: <TableRow>[
                    const TableRow(
                      decoration: BoxDecoration(color: paletteSurfaceAlt),
                      children: <Widget>[
                        _TableHead(text: 'Aspect'),
                        _TableHead(text: 'AggregatedTimedBlock'),
                        _TableHead(text: 'Raw TimedBlock list'),
                      ],
                    ),
                    for (final r in comparisonRows)
                      TableRow(
                        children: <Widget>[
                          _TableCell(text: r.aspect, color: paletteAccent),
                          _TableCell(text: r.aggregated),
                          _TableCell(text: r.raw),
                        ],
                      ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // ============================================================
              // SECTION 10: Pitfalls
              // ============================================================
              const _SectionTitle(
                index: '10',
                title: 'Pitfalls',
                subtitle: 'Common mistakes when reading AggregatedTimedBlock data',
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.6,
                children: <Widget>[
                  for (final p in pitfallEntries)
                    _PitfallTile(entry: p),
                ],
              ),

              const SizedBox(height: 32),

              // ============================================================
              // SECTION 11: Footer
              // ============================================================
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: paletteSurface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: paletteBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Text(
                      'References',
                      style: TextStyle(
                        color: paletteAccent,
                        fontSize: 12,
                        letterSpacing: 1.4,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      '• flutter/packages/flutter/lib/src/foundation/timeline.dart\n'
                      '• AggregatedTimings — folds raw blocks by name\n'
                      '• TimedBlock — single begin/end timing pair\n'
                      '• DevTools Performance tab — visual surface for both\n'
                      '• Skia/Impeller raster threads — origin of gpu_raster',
                      style: TextStyle(color: paletteTextDim, height: 1.6),
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: const <Widget>[
                        Icon(Icons.timer_outlined, color: paletteAccent, size: 16),
                        SizedBox(width: 8),
                        Text(
                          'AggregatedTimedBlock — small, immutable, the unit '
                          'of "this is what your frames are spending time on".',
                          style: TextStyle(color: paletteText, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 36),
            ],
          ),
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Local widgets — all stateless, no controllers, no async.
// ---------------------------------------------------------------------------

class _SectionTitle extends StatelessWidget {
  final String index;
  final String title;
  final String subtitle;
  const _SectionTitle({
    required this.index,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: paletteSurface,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: paletteBorder),
          ),
          child: Text(
            index,
            style: const TextStyle(
              color: paletteAccent,
              fontWeight: FontWeight.w700,
              fontSize: 15,
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
                style: const TextStyle(
                  color: paletteText,
                  fontSize: 19,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: const TextStyle(
                  color: paletteTextDim,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PillTag extends StatelessWidget {
  final String label;
  final Color color;
  const _PillTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: paletteSurfaceAlt,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontFamily: 'monospace',
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class _CodeBlock extends StatelessWidget {
  final String code;
  const _CodeBlock({required this.code});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: paletteBg,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: paletteBorder),
      ),
      child: Text(
        code,
        style: const TextStyle(
          color: paletteText,
          fontFamily: 'monospace',
          fontSize: 12,
          height: 1.5,
        ),
      ),
    );
  }
}

class _TableHead extends StatelessWidget {
  final String text;
  const _TableHead({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text.toUpperCase(),
        style: const TextStyle(
          color: paletteAccent,
          fontSize: 11,
          letterSpacing: 1.2,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _TableCell extends StatelessWidget {
  final String text;
  final bool mono;
  final Color? color;
  const _TableCell({
    required this.text,
    this.mono = false,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        text,
        style: TextStyle(
          color: color ?? paletteText,
          fontFamily: mono ? 'monospace' : null,
          fontSize: mono ? 12 : 13,
          height: 1.4,
        ),
      ),
    );
  }
}

class _AggregateCard extends StatelessWidget {
  final SamplePhase phase;
  final bool highlight;
  const _AggregateCard({required this.phase, required this.highlight});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: paletteSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: highlight ? phase.color : paletteBorder,
          width: highlight ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  color: phase.color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  phase.name,
                  style: TextStyle(
                    color: phase.color,
                    fontFamily: 'monospace',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                '${phase.count}',
                style: const TextStyle(
                  color: paletteText,
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 4),
              const Padding(
                padding: EdgeInsets.only(bottom: 3),
                child: Text(
                  'count',
                  style: TextStyle(color: paletteTextDim, fontSize: 11),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'sum  ${formatMicros(phase.sumMicros)}',
            style: const TextStyle(
              color: paletteText,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
          Text(
            'avg  ${formatMicros(phase.avgMicros)}',
            style: const TextStyle(
              color: paletteOk,
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            phase.description,
            style: const TextStyle(
              color: paletteTextDim,
              fontSize: 11,
              height: 1.4,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class _RawTimedBlockRow extends StatelessWidget {
  final String label;
  final String name;
  final int start;
  final int end;
  const _RawTimedBlockRow({
    required this.label,
    required this.name,
    required this.start,
    required this.end,
  });

  @override
  Widget build(BuildContext context) {
    final dur = end - start;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: <Widget>[
          Container(
            width: 22,
            height: 22,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: phaseBuild,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              label,
              style: const TextStyle(
                color: paletteBg,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'TimedBlock(',
            style: TextStyle(color: paletteTextDim, fontFamily: 'monospace', fontSize: 11),
          ),
          Text(
            'name: "$name", ',
            style: const TextStyle(color: paletteAccent, fontFamily: 'monospace', fontSize: 11),
          ),
          Text(
            'start: $start, end: $end',
            style: const TextStyle(color: paletteText, fontFamily: 'monospace', fontSize: 11),
          ),
          const Text(
            ')',
            style: TextStyle(color: paletteTextDim, fontFamily: 'monospace', fontSize: 11),
          ),
          const Spacer(),
          Text(
            '$dur µs',
            style: const TextStyle(color: paletteOk, fontFamily: 'monospace', fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _ArrowIcon extends StatelessWidget {
  const _ArrowIcon();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Icon(Icons.arrow_forward_rounded, color: paletteAccent, size: 30),
        Text(
          'fold',
          style: TextStyle(
            color: paletteAccent,
            fontFamily: 'monospace',
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}

class _LegendChip extends StatelessWidget {
  final Color color;
  final String label;
  final String value;
  const _LegendChip({
    required this.color,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: paletteSurfaceAlt,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: paletteBorder),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            value,
            style: const TextStyle(
              color: paletteText,
              fontFamily: 'monospace',
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  final String label;
  final String value;
  final Color tone;
  const _StatTile({
    required this.label,
    required this.value,
    required this.tone,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: paletteSurfaceAlt,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: paletteBorder),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              label.toUpperCase(),
              style: const TextStyle(
                color: paletteTextDim,
                fontSize: 10,
                letterSpacing: 1.4,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                color: tone,
                fontSize: 17,
                fontWeight: FontWeight.w700,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExplainerStep extends StatelessWidget {
  final String step;
  final String title;
  final String body;
  const _ExplainerStep({
    required this.step,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: paletteAccent,
              borderRadius: BorderRadius.circular(13),
            ),
            child: Text(
              step,
              style: const TextStyle(
                color: paletteBg,
                fontSize: 12,
                fontWeight: FontWeight.w800,
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
                  style: const TextStyle(
                    color: paletteText,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  body,
                  style: const TextStyle(
                    color: paletteTextDim,
                    fontSize: 12,
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

class _PitfallTile extends StatelessWidget {
  final PitfallEntry entry;
  const _PitfallTile({required this.entry});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: paletteSurface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: entry.tone),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 36,
            height: 36,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: paletteSurfaceAlt,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(entry.icon, color: entry.tone, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  entry.title,
                  style: TextStyle(
                    color: entry.tone,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  entry.body,
                  style: const TextStyle(
                    color: paletteTextDim,
                    fontSize: 12,
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
