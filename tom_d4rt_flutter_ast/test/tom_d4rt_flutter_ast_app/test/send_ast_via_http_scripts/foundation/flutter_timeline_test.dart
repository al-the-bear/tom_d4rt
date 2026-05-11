// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last, unused_local_variable, unused_element, unused_element_parameter, unused_field, unnecessary_import
import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

// ---------------------------------------------------------------------------
// FlutterTimeline — Visual Deep Demo
// ---------------------------------------------------------------------------
//
// FlutterTimeline lives in `package:flutter/foundation.dart` and is the
// framework's instrumentation hook for performance tracing. It is the API
// the Flutter engine itself uses to record events that show up in the
// "Performance Overlay" and the DevTools "Performance" / "Timeline" tabs.
//
// The four primary entry points are:
//
//   FlutterTimeline.startSync(String name, {Map<String, Object?>? arguments})
//   FlutterTimeline.finishSync()
//   FlutterTimeline.timeSync<T>(String name, TimelineSyncFunction<T> body)
//   FlutterTimeline.instantSync(String name, {Map<String, Object?>? arguments})
//
// These calls are EXTREMELY low-cost in profile builds and effective
// no-ops in release builds. They become observable when the Dart VM
// timeline is being recorded (DevTools, --start-paused, --trace-startup,
// ...). They do NOT produce on-screen output by themselves.
//
// This demo file therefore does two things at once:
//
//   1.  It actually CALLS FlutterTimeline.startSync/finishSync/timeSync/
//       instantSync inside the build() function, so a curious reader can
//       inspect the calls (and a profiling session would record them).
//
//   2.  It renders a *mock* trace visualization built from pre-computed
//       lists of "events" (name, start time, duration, depth, category)
//       so the screen actually shows something interesting — colored
//       horizontal bars arranged in lanes, plus a 16 ms frame-budget ruler.
//
// The visualization is purely illustrative. It is not the real timeline.
// It is a teaching aid that explains what the real timeline looks like
// when viewed in DevTools.
//
// ---------------------------------------------------------------------------

/// A single mock trace event used to render the timeline visualization.
///
/// In a real DevTools timeline each event has a name, a category, a start
/// time, a duration, a depth (the position in the call stack) and an
/// optional map of arguments. We mimic that here with a plain Dart record.
class _MockEvent {
  const _MockEvent({
    required this.name,
    required this.category,
    required this.startUs,
    required this.durationUs,
    required this.depth,
    this.arguments = const <String, Object?>{},
  });

  final String name;
  final String category;
  final int startUs;
  final int durationUs;
  final int depth;
  final Map<String, Object?> arguments;

  int get endUs => startUs + durationUs;
}

/// A single "instant" event — has a position on the time axis but no
/// duration. Renders as a thin vertical marker in the trace.
class _MockInstant {
  const _MockInstant({
    required this.name,
    required this.atUs,
    required this.category,
  });

  final String name;
  final int atUs;
  final String category;
}

/// Color mapping for trace categories. DevTools uses similar buckets.
const Map<String, Color> _categoryColor = <String, Color>{
  'build': Color(0xFF4FC3F7),
  'layout': Color(0xFFFFB74D),
  'paint': Color(0xFFAED581),
  'composite': Color(0xFFBA68C8),
  'raster': Color(0xFFE57373),
  'gc': Color(0xFF90A4AE),
  'user': Color(0xFFF06292),
  'io': Color(0xFFFFD54F),
  'dart': Color(0xFF81C784),
};

/// The 16-millisecond frame budget for a 60-FPS application, expressed
/// in microseconds. Anything that does not fit inside this budget will
/// cause "jank" — a missed frame.
const int _frameBudgetUs = 16000;

/// Returns the color associated with [category], or grey if unknown.
Color _colorFor(String category) {
  return _categoryColor[category] ?? const Color(0xFFB0BEC5);
}

/// Pre-computes a synthetic trace covering ~32 ms (two frames). The first
/// frame fits inside the 16 ms budget. The second frame overshoots to
/// illustrate jank.
List<_MockEvent> _buildSyntheticTrace() {
  return const <_MockEvent>[
    // Frame 1 — healthy frame, ~12.4 ms total.
    _MockEvent(
      name: 'Frame',
      category: 'composite',
      startUs: 0,
      durationUs: 12400,
      depth: 0,
    ),
    _MockEvent(
      name: 'Animate',
      category: 'build',
      startUs: 100,
      durationUs: 800,
      depth: 1,
    ),
    _MockEvent(
      name: 'Build',
      category: 'build',
      startUs: 1000,
      durationUs: 3200,
      depth: 1,
      arguments: <String, Object?>{'widgets': 42},
    ),
    _MockEvent(
      name: 'StatelessWidget.build',
      category: 'build',
      startUs: 1200,
      durationUs: 900,
      depth: 2,
    ),
    _MockEvent(
      name: 'StatefulWidget.build',
      category: 'build',
      startUs: 2200,
      durationUs: 1800,
      depth: 2,
    ),
    _MockEvent(
      name: 'Layout',
      category: 'layout',
      startUs: 4400,
      durationUs: 3000,
      depth: 1,
    ),
    _MockEvent(
      name: 'RenderObject.performLayout',
      category: 'layout',
      startUs: 4600,
      durationUs: 1400,
      depth: 2,
    ),
    _MockEvent(
      name: 'RenderFlex.performLayout',
      category: 'layout',
      startUs: 6100,
      durationUs: 1200,
      depth: 2,
    ),
    _MockEvent(
      name: 'Paint',
      category: 'paint',
      startUs: 7600,
      durationUs: 2300,
      depth: 1,
    ),
    _MockEvent(
      name: 'RenderObject.paint',
      category: 'paint',
      startUs: 7800,
      durationUs: 1900,
      depth: 2,
    ),
    _MockEvent(
      name: 'Compositing',
      category: 'composite',
      startUs: 10000,
      durationUs: 1400,
      depth: 1,
    ),
    _MockEvent(
      name: 'Raster',
      category: 'raster',
      startUs: 11500,
      durationUs: 900,
      depth: 1,
    ),

    // Frame 2 — JANKY frame, ~21.8 ms (overshoots the 16 ms budget).
    _MockEvent(
      name: 'Frame',
      category: 'composite',
      startUs: 16700,
      durationUs: 21800,
      depth: 0,
    ),
    _MockEvent(
      name: 'Animate',
      category: 'build',
      startUs: 16800,
      durationUs: 600,
      depth: 1,
    ),
    _MockEvent(
      name: 'Build',
      category: 'build',
      startUs: 17500,
      durationUs: 5800,
      depth: 1,
      arguments: <String, Object?>{'widgets': 188},
    ),
    _MockEvent(
      name: 'expensiveBuilder',
      category: 'build',
      startUs: 17700,
      durationUs: 5500,
      depth: 2,
    ),
    _MockEvent(
      name: 'Layout',
      category: 'layout',
      startUs: 23400,
      durationUs: 6900,
      depth: 1,
    ),
    _MockEvent(
      name: 'RenderSliverList.performLayout',
      category: 'layout',
      startUs: 23600,
      durationUs: 6500,
      depth: 2,
    ),
    _MockEvent(
      name: 'Paint',
      category: 'paint',
      startUs: 30400,
      durationUs: 4100,
      depth: 1,
    ),
    _MockEvent(
      name: 'Compositing',
      category: 'composite',
      startUs: 34600,
      durationUs: 2200,
      depth: 1,
    ),
    _MockEvent(
      name: 'Raster',
      category: 'raster',
      startUs: 36900,
      durationUs: 1600,
      depth: 1,
    ),
  ];
}

/// Instantaneous events for the same window — these mark interesting
/// points in time (vsync, gesture, GC) and have zero duration.
List<_MockInstant> _buildSyntheticInstants() {
  return const <_MockInstant>[
    _MockInstant(name: 'vsync', atUs: 0, category: 'composite'),
    _MockInstant(name: 'gesture', atUs: 4200, category: 'user'),
    _MockInstant(name: 'gc.minor', atUs: 9800, category: 'gc'),
    _MockInstant(name: 'vsync', atUs: 16700, category: 'composite'),
    _MockInstant(name: 'image.decode', atUs: 19400, category: 'io'),
    _MockInstant(name: 'gc.major', atUs: 28500, category: 'gc'),
  ];
}

/// Returns a list of "phase totals" for the given trace, summed by
/// category. Used in the phase bar chart further down.
Map<String, int> _phaseTotals(List<_MockEvent> trace) {
  final Map<String, int> totals = <String, int>{};
  for (final _MockEvent e in trace) {
    if (e.depth == 1) {
      totals[e.category] = (totals[e.category] ?? 0) + e.durationUs;
    }
  }
  return totals;
}

/// Recap of microseconds-per-millisecond, used in the legend.
const int _usPerMs = 1000;

// ---------------------------------------------------------------------------
// build() — entry point
// ---------------------------------------------------------------------------

dynamic build(BuildContext context) {
  // -------------------------------------------------------------------------
  // Actually call FlutterTimeline at build time so the API is exercised.
  // In a real app you would NOT wrap your build method in timeline events
  // — Flutter already does that for you. We do it here purely for the
  // demonstration value of seeing the API in source.
  // -------------------------------------------------------------------------
  FlutterTimeline.startSync(
    'flutter_timeline_test.build',
    arguments: <String, Object?>{
      'mode': kReleaseMode
          ? 'release'
          : kProfileMode
              ? 'profile'
              : 'debug',
      'platform': defaultTargetPlatform.toString(),
    },
  );

  // A nested START/FINISH pair to demonstrate stacking.
  FlutterTimeline.startSync('precompute trace data');
  final List<_MockEvent> trace = _buildSyntheticTrace();
  final List<_MockInstant> instants = _buildSyntheticInstants();
  FlutterTimeline.finishSync();

  // timeSync is the safe, scoped equivalent of startSync/finishSync.
  final Map<String, int> phaseTotals = FlutterTimeline.timeSync<Map<String, int>>(
    'compute phase totals',
    () {
      return _phaseTotals(trace);
    },
    arguments: <String, Object?>{'events': trace.length},
  );

  // instantSync is a zero-duration "ping" — useful for marking gestures,
  // network responses, GC events, etc.
  FlutterTimeline.instantSync(
    'visualization-ready',
    arguments: <String, Object?>{'eventCount': trace.length},
  );

  // The render surface itself.
  final Widget content = SingleChildScrollView(
    padding: const EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _dossier(),
        const SizedBox(height: 16),
        _anatomySection(),
        const SizedBox(height: 16),
        _traceVisualization(trace: trace, instants: instants),
        const SizedBox(height: 16),
        _phaseBarChart(totals: phaseTotals),
        const SizedBox(height: 16),
        _recipesSection(),
        const SizedBox(height: 16),
        _comparisonSection(),
        const SizedBox(height: 16),
        _pitfallsSection(),
        const SizedBox(height: 16),
        _glossarySection(),
        const SizedBox(height: 16),
        _recapSection(),
        const SizedBox(height: 24),
      ],
    ),
  );

  // Always finish what you started.
  FlutterTimeline.finishSync();

  return Scaffold(
    appBar: AppBar(
      title: const Text('FlutterTimeline — Deep Visual Demo'),
      backgroundColor: Colors.indigo.shade700,
      foregroundColor: Colors.white,
    ),
    backgroundColor: Colors.grey.shade50,
    body: content,
  );
}

// ---------------------------------------------------------------------------
// Section 1 — DOSSIER
// ---------------------------------------------------------------------------

Widget _dossier() {
  return _sectionCard(
    title: 'Dossier',
    accent: Colors.indigo,
    children: <Widget>[
      const Text(
        'FlutterTimeline is the framework-level instrumentation API used '
        'by the Flutter engine, the rendering pipeline, the widgets library '
        'and most well-behaved third-party packages to emit performance '
        'events. Those events surface in:',
        style: TextStyle(fontSize: 14, height: 1.4),
      ),
      const SizedBox(height: 8),
      _bullet('The Performance Overlay (the colored bars at the top of the screen).'),
      _bullet('The DevTools "Performance" page (frame chart, flame chart).'),
      _bullet('The DevTools "Timeline" page (full VM event stream).'),
      _bullet('Any tool that ingests Dart VM "Timeline" JSON output.'),
      const SizedBox(height: 12),
      _factRow('Library', 'package:flutter/foundation.dart'),
      _factRow('Class', 'FlutterTimeline'),
      _factRow('Primary methods', 'startSync / finishSync / timeSync / instantSync'),
      _factRow('Cost in release', 'effectively zero — calls are elided'),
      _factRow('Cost in profile', 'tiny — a few hundred ns per event'),
      _factRow('Visible output', 'none, unless DevTools or VM trace is recording'),
      const SizedBox(height: 12),
      const Text(
        'Build-mode behavior',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      const SizedBox(height: 4),
      _bullet('Debug:   recorded if a VM timeline subscriber is attached.'),
      _bullet('Profile: recorded; this is the mode you typically profile in.'),
      _bullet('Release: completely no-op. No string allocation, no dispatch.'),
      const SizedBox(height: 8),
      const Text(
        'Because of the release-mode no-op, you do NOT need to wrap your '
        'production timeline calls in `assert` or `if (kProfileMode)`. Just '
        'call them. The compiler tree-shakes them away.',
        style: TextStyle(fontSize: 13, height: 1.4),
      ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 2 — ANATOMY
// ---------------------------------------------------------------------------

Widget _anatomySection() {
  return _sectionCard(
    title: 'Anatomy of the four calls',
    accent: Colors.teal,
    children: <Widget>[
      _apiBlock(
        signature: 'FlutterTimeline.startSync(String name, {Map<String, Object?>? arguments})',
        description:
            'Opens a new "duration" event on the current thread. Every '
            'startSync MUST be paired with exactly one finishSync. They '
            'stack — nested pairs are allowed and produce a tree.',
      ),
      _apiBlock(
        signature: 'FlutterTimeline.finishSync()',
        description:
            'Closes the most recent open event on the current thread. '
            'If you call finishSync without a matching startSync the VM '
            'will assert in debug mode and produce malformed traces in '
            'profile mode.',
      ),
      _apiBlock(
        signature: 'FlutterTimeline.timeSync<T>(String name, T Function() body, '
            '{Map<String, Object?>? arguments})',
        description:
            'Convenience wrapper that calls startSync, runs body, then '
            'calls finishSync — even if body throws. Prefer this over '
            'manual start/finish pairs. The return value of body is '
            'forwarded to the caller.',
      ),
      _apiBlock(
        signature: 'FlutterTimeline.instantSync(String name, {Map<String, Object?>? arguments})',
        description:
            'Emits a zero-duration event at "now". Use for things like '
            '"image decoded", "gesture detected", "websocket message". '
            'In DevTools these render as thin vertical lines.',
      ),
      const SizedBox(height: 12),
      const Text(
        'Stacking diagram (startSync / finishSync)',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
      const SizedBox(height: 8),
      _stackDiagram(),
    ],
  );
}

Widget _apiBlock({required String signature, required String description}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.teal.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.teal.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          signature,
          style: const TextStyle(
            fontFamily: 'monospace',
            fontSize: 12,
            color: Color(0xFF00695C),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          description,
          style: const TextStyle(fontSize: 13, height: 1.4),
        ),
      ],
    ),
  );
}

Widget _stackDiagram() {
  // Visual: nested rectangles to show start/finish stacking.
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.grey.shade100,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _stackBar(label: 'startSync("frame")', width: 380, color: Colors.indigo.shade300, indent: 0),
        const SizedBox(height: 4),
        _stackBar(label: 'startSync("build")', width: 220, color: Colors.blue.shade300, indent: 20),
        const SizedBox(height: 4),
        _stackBar(label: 'startSync("widget.build")', width: 140, color: Colors.cyan.shade300, indent: 40),
        const SizedBox(height: 4),
        _stackBar(label: 'finishSync() // widget.build', width: 140, color: Colors.cyan.shade100, indent: 40),
        const SizedBox(height: 4),
        _stackBar(label: 'finishSync() // build', width: 220, color: Colors.blue.shade100, indent: 20),
        const SizedBox(height: 4),
        _stackBar(label: 'startSync("paint")', width: 160, color: Colors.green.shade300, indent: 20),
        const SizedBox(height: 4),
        _stackBar(label: 'finishSync() // paint', width: 160, color: Colors.green.shade100, indent: 20),
        const SizedBox(height: 4),
        _stackBar(label: 'finishSync() // frame', width: 380, color: Colors.indigo.shade100, indent: 0),
      ],
    ),
  );
}

Widget _stackBar({
  required String label,
  required double width,
  required Color color,
  required double indent,
}) {
  return Padding(
    padding: EdgeInsets.only(left: indent),
    child: Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontFamily: 'monospace',
          fontSize: 11,
          color: Colors.black87,
        ),
      ),
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 3 — TRACE VISUALIZATION
// ---------------------------------------------------------------------------

Widget _traceVisualization({
  required List<_MockEvent> trace,
  required List<_MockInstant> instants,
}) {
  const double pxPerUs = 0.04; // 40 px per ms
  const double laneHeight = 22;
  const int maxDepth = 3;
  final int totalDurationUs = trace.fold<int>(0, (int acc, _MockEvent e) {
    return math.max(acc, e.endUs);
  });
  final double width = totalDurationUs * pxPerUs;
  final double height = laneHeight * (maxDepth + 1) + 60;

  return _sectionCard(
    title: 'Mock trace visualization',
    accent: Colors.deepPurple,
    children: <Widget>[
      const Text(
        'Pre-computed events are laid out on a horizontal time axis. Each '
        'lane corresponds to a depth in the call stack. The dashed vertical '
        'lines mark the 16 ms frame-budget boundary — anything that crosses '
        'them caused jank. Vertical pins are instantSync events.',
        style: TextStyle(fontSize: 13, height: 1.4),
      ),
      const SizedBox(height: 12),
      _legendRow(),
      const SizedBox(height: 12),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SizedBox(
          width: width + 40,
          height: height,
          child: Stack(
            children: <Widget>[
              // Frame budget guides (every 16 ms).
              for (int i = 0; i * _frameBudgetUs <= totalDurationUs; i++)
                Positioned(
                  left: i * _frameBudgetUs * pxPerUs,
                  top: 0,
                  bottom: 0,
                  child: _budgetGuide(label: '${i * 16} ms'),
                ),
              // Lane labels.
              for (int d = 0; d <= maxDepth; d++)
                Positioned(
                  left: 0,
                  top: 20 + d * laneHeight,
                  child: SizedBox(
                    width: 40,
                    height: laneHeight,
                    child: Center(
                      child: Text(
                        'd=$d',
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey.shade600,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ),
                  ),
                ),
              // Event bars.
              for (final _MockEvent e in trace)
                Positioned(
                  left: 40 + e.startUs * pxPerUs,
                  top: 20 + e.depth * laneHeight,
                  width: math.max(2.0, e.durationUs * pxPerUs),
                  height: laneHeight - 2,
                  child: _eventBar(event: e),
                ),
              // Instant pins.
              for (final _MockInstant ins in instants)
                Positioned(
                  left: 40 + ins.atUs * pxPerUs - 3,
                  top: 16,
                  child: _instantPin(instant: ins, height: height - 40),
                ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 8),
      Text(
        'Trace span: ${(totalDurationUs / _usPerMs).toStringAsFixed(1)} ms, '
        '${trace.length} duration events, ${instants.length} instant events.',
        style: TextStyle(fontSize: 12, color: Colors.grey.shade700),
      ),
    ],
  );
}

Widget _budgetGuide({required String label}) {
  return SizedBox(
    width: 1,
    child: Stack(
      clipBehavior: Clip.none,
      children: <Widget>[
        Container(width: 1, color: Colors.red.shade200),
        Positioned(
          left: 2,
          top: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
            color: Colors.red.shade50,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 9,
                color: Colors.red.shade700,
                fontFamily: 'monospace',
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _eventBar({required _MockEvent event}) {
  return Tooltip(
    message: '${event.name}\n'
        'category: ${event.category}\n'
        'start: ${(event.startUs / _usPerMs).toStringAsFixed(2)} ms\n'
        'duration: ${(event.durationUs / _usPerMs).toStringAsFixed(2)} ms',
    child: Container(
      decoration: BoxDecoration(
        color: _colorFor(event.category),
        borderRadius: BorderRadius.circular(3),
        border: Border.all(
          color: _colorFor(event.category).withOpacity(0.9),
          width: 1,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      alignment: Alignment.centerLeft,
      child: Text(
        event.name,
        style: const TextStyle(
          fontSize: 10,
          color: Colors.black87,
          fontFamily: 'monospace',
        ),
        overflow: TextOverflow.fade,
        softWrap: false,
      ),
    ),
  );
}

Widget _instantPin({required _MockInstant instant, required double height}) {
  return Tooltip(
    message: '${instant.name} @ ${(instant.atUs / _usPerMs).toStringAsFixed(2)} ms',
    child: SizedBox(
      width: 6,
      height: height,
      child: Column(
        children: <Widget>[
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: _colorFor(instant.category),
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Container(width: 1, color: _colorFor(instant.category).withOpacity(0.6)),
          ),
        ],
      ),
    ),
  );
}

Widget _legendRow() {
  return Wrap(
    spacing: 10,
    runSpacing: 6,
    children: <Widget>[
      for (final MapEntry<String, Color> e in _categoryColor.entries)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: e.value.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: e.value),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 10,
                height: 10,
                color: e.value,
              ),
              const SizedBox(width: 4),
              Text(
                e.key,
                style: const TextStyle(
                  fontSize: 11,
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
    ],
  );
}

// ---------------------------------------------------------------------------
// Section 4 — PHASE BAR CHART (Build / Layout / Paint / Composite / Raster)
// ---------------------------------------------------------------------------

Widget _phaseBarChart({required Map<String, int> totals}) {
  // We display the totals in the canonical pipeline order, even if a phase
  // is missing from the data.
  const List<String> order = <String>['build', 'layout', 'paint', 'composite', 'raster'];
  final int maxValue = totals.values.fold<int>(0, math.max);
  // Compute a sensible right axis — round up to nearest 5 ms.
  final int axisUs = ((maxValue / 5000).ceil() * 5000).clamp(5000, 1 << 30);

  return _sectionCard(
    title: 'Phase totals — Build / Layout / Paint / Composite / Raster',
    accent: Colors.orange,
    children: <Widget>[
      const Text(
        'These totals add up the duration of every depth=1 event grouped by '
        'category. A healthy 60-FPS frame keeps the *sum* of build + layout '
        '+ paint + composite under 16 ms on the UI thread, with rasterize '
        'staying under 16 ms on the raster thread.',
        style: TextStyle(fontSize: 13, height: 1.4),
      ),
      const SizedBox(height: 12),
      for (final String phase in order)
        _phaseBarRow(
          label: phase,
          us: totals[phase] ?? 0,
          axisUs: axisUs,
        ),
      const SizedBox(height: 12),
      Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.amber.shade50,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.amber.shade200),
        ),
        child: const Text(
          'Tip: if Build is by far the largest bar, your widget tree is '
          'rebuilding more than it needs to. Look at const constructors, '
          'RepaintBoundary, and selective ListenableBuilder/AnimatedBuilder '
          'subtree rebuilds before optimizing further.',
          style: TextStyle(fontSize: 12, height: 1.4),
        ),
      ),
    ],
  );
}

Widget _phaseBarRow({
  required String label,
  required int us,
  required int axisUs,
}) {
  final double frac = axisUs == 0 ? 0 : us / axisUs;
  final Color c = _colorFor(label);
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: <Widget>[
        SizedBox(
          width: 80,
          child: Text(
            label,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints c2) {
              final double w = c2.maxWidth;
              return Stack(
                children: <Widget>[
                  Container(
                    height: 18,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  Container(
                    width: w * frac,
                    height: 18,
                    decoration: BoxDecoration(
                      color: c,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  // 16 ms guide if it fits inside axisUs.
                  if (axisUs >= _frameBudgetUs)
                    Positioned(
                      left: w * (_frameBudgetUs / axisUs),
                      top: -2,
                      bottom: -2,
                      child: Container(width: 1.5, color: Colors.red.shade400),
                    ),
                ],
              );
            },
          ),
        ),
        const SizedBox(width: 8),
        SizedBox(
          width: 70,
          child: Text(
            '${(us / _usPerMs).toStringAsFixed(2)} ms',
            textAlign: TextAlign.right,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 5 — RECIPES
// ---------------------------------------------------------------------------

Widget _recipesSection() {
  return _sectionCard(
    title: 'Recipes',
    accent: Colors.green,
    children: <Widget>[
      _recipe(
        title: 'Trace one function with timeSync',
        body:
            'Wrap the body of a hot function. timeSync handles start, '
            'finish, and exception forwarding automatically. The return '
            'value is forwarded to the caller, so it composes nicely.',
        code: '''
final Image image = FlutterTimeline.timeSync<Image>(
  'decodeIcon',
  () => Image.memory(bytes),
  arguments: <String, Object?>{'bytes': bytes.length},
);''',
      ),
      _recipe(
        title: 'Trace a nested computation',
        body:
            'startSync/finishSync calls compose into a tree. Each open '
            'event is a child of the most recent unfinished event.',
        code: '''
FlutterTimeline.startSync('aggregate');
try {
  FlutterTimeline.startSync('parse');
  final parsed = _parse(json);
  FlutterTimeline.finishSync();

  FlutterTimeline.startSync('normalize');
  final normalized = _normalize(parsed);
  FlutterTimeline.finishSync();

  return normalized;
} finally {
  FlutterTimeline.finishSync(); // close "aggregate"
}''',
      ),
      _recipe(
        title: 'Mark an instantaneous event',
        body:
            'Instant events have no duration but show up as a marker in '
            'the trace. Useful for gestures, network callbacks, etc.',
        code: '''
void _onTap(TapDownDetails d) {
  FlutterTimeline.instantSync(
    'tap',
    arguments: <String, Object?>{'x': d.localPosition.dx, 'y': d.localPosition.dy},
  );
}''',
      ),
      _recipe(
        title: 'Frame-budget visualization',
        body:
            'The 16 ms boundary (60 FPS) is the canonical jank threshold. '
            'For 120 Hz devices it is 8.3 ms. Visualize budgets as red '
            'guides above the trace bars.',
        code: '''
const int sixtyFpsBudgetUs   = 16000;
const int oneTwentyFpsBudget = 8333;''',
      ),
      _recipe(
        title: 'Mock-trace export for tests',
        body:
            'You can persist a trace from `FlutterTimeline.debugCollectionEnabled` '
            'and FlutterTimeline.debugCollect() in profile builds to a JSON '
            'file for offline analysis. The mock data in this file is shaped '
            'similarly to what you would get back.',
        code: '''
final List<TimedBlock> blocks = FlutterTimeline.debugCollect();
final json = blocks.map((b) => <String, Object?>{
  'name': b.name,
  'startMicros': b.start,
  'durationMicros': b.end - b.start,
}).toList();''',
      ),
      _recipe(
        title: 'Profiling tips',
        body:
            'A few rules of thumb when reading a real trace.',
        code: '''
// 1. Profile mode only — debug numbers are misleading.
// 2. Run on a physical device, not a simulator.
// 3. Toggle "Performance Overlay" first; it is free.
// 4. Then move to DevTools > Performance for flame charts.
// 5. Look for tall stacks; tall == long single function.
// 6. Look for wide bars; wide == ran a long time.
// 7. RepaintBoundary at scrollable leaves often pays off.''',
      ),
    ],
  );
}

Widget _recipe({
  required String title,
  required String body,
  required String code,
}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 12),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.green.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.green.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1B5E20),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          body,
          style: const TextStyle(fontSize: 13, height: 1.4),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.85),
            borderRadius: BorderRadius.circular(6),
          ),
          width: double.infinity,
          child: Text(
            code,
            style: const TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              color: Color(0xFFCDDC39),
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 6 — COMPARISON vs dart:developer Timeline
// ---------------------------------------------------------------------------

Widget _comparisonSection() {
  return _sectionCard(
    title: 'FlutterTimeline vs dart:developer Timeline',
    accent: Colors.blueGrey,
    children: <Widget>[
      const Text(
        'Dart ships its own tracing API in dart:developer (`Timeline`). '
        'FlutterTimeline is layered on top of it: every call funnels into '
        'the VM-level tracer, but FlutterTimeline adds three things on top.',
        style: TextStyle(fontSize: 13, height: 1.4),
      ),
      const SizedBox(height: 10),
      _comparisonRow(
        feature: 'Release-mode no-op',
        flutter: 'YES — calls compile away to nothing.',
        dart: 'NO — calls remain (but the VM may discard the events).',
      ),
      _comparisonRow(
        feature: 'Argument map allocation',
        flutter: 'lazy — only allocated when actually recording.',
        dart: 'eager — always allocated.',
      ),
      _comparisonRow(
        feature: 'In-memory aggregation',
        flutter: 'YES — FlutterTimeline.debugCollect() exposes blocks.',
        dart: 'NO — events go straight to the VM stream.',
      ),
      _comparisonRow(
        feature: 'Async tracing',
        flutter: 'NO — sync-only API.',
        dart: 'YES — startAsync / finishAsync flow events.',
      ),
      _comparisonRow(
        feature: 'Recommended for',
        flutter: 'Flutter app and framework code.',
        dart: 'Pure-Dart libraries that may run outside Flutter.',
      ),
    ],
  );
}

Widget _comparisonRow({
  required String feature,
  required String flutter,
  required String dart,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 160,
          child: Text(
            feature,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            'flutter: $flutter',
            style: const TextStyle(fontSize: 12, height: 1.35),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            'dart: $dart',
            style: const TextStyle(fontSize: 12, height: 1.35),
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 7 — PITFALLS
// ---------------------------------------------------------------------------

Widget _pitfallsSection() {
  return _sectionCard(
    title: 'Common pitfalls',
    accent: Colors.red,
    children: <Widget>[
      _pitfall(
        title: 'Mismatched start/finish pairs',
        body:
            'Every startSync must be matched by exactly one finishSync. '
            'If you throw between them without a try/finally the stack '
            'becomes corrupted. Use timeSync, which uses a try/finally '
            'internally, whenever possible.',
      ),
      _pitfall(
        title: 'Expecting visible output in release builds',
        body:
            'FlutterTimeline calls are stripped from release builds. If '
            'you toggle "release" mode and wonder why nothing appears in '
            'DevTools, switch to profile mode instead.',
      ),
      _pitfall(
        title: 'Tracing tiny functions',
        body:
            'A startSync/finishSync pair costs ~100-300 ns in profile '
            'mode. Wrapping a single arithmetic operation drowns the '
            'signal in instrumentation noise. Trace at function or '
            'phase granularity, not per-statement.',
      ),
      _pitfall(
        title: 'Allocating in argument maps',
        body:
            'The `arguments` map is only sent when the VM is recording, '
            'but the Dart literal itself is allocated eagerly. Avoid '
            'building large argument maps inside hot loops.',
      ),
      _pitfall(
        title: 'Crossing isolates',
        body:
            'FlutterTimeline records events on the current isolate. '
            'Events emitted from a background isolate appear in a '
            'different trace lane. Plan accordingly when correlating '
            'work done in compute() or Isolate.run().',
      ),
      _pitfall(
        title: 'Confusing UI thread vs raster thread',
        body:
            'Build / Layout / Paint run on the UI thread. Raster work '
            'runs on the raster (GPU) thread. They have independent 16 '
            'ms budgets. Read the thread name in DevTools before '
            'concluding that "the frame was too slow".',
      ),
    ],
  );
}

Widget _pitfall({required String title, required String body}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.red.shade50,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.red.shade200),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Icon(Icons.warning_amber_rounded,
                color: Colors.red.shade700, size: 18),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: Colors.red.shade800,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(body, style: const TextStyle(fontSize: 12, height: 1.4)),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Section 8 — GLOSSARY
// ---------------------------------------------------------------------------

Widget _glossarySection() {
  return _sectionCard(
    title: 'Glossary',
    accent: Colors.brown,
    children: const <Widget>[
      _GlossaryEntry(
        term: 'Sync event',
        definition:
            'An event with a known start and finish on the same thread. '
            'Equivalent to a function call duration.',
      ),
      _GlossaryEntry(
        term: 'Instant event',
        definition:
            'An event with no duration — only a timestamp. Marks a '
            'single point in time.',
      ),
      _GlossaryEntry(
        term: 'Argument map',
        definition:
            'Optional key/value metadata attached to an event. Shows up '
            'in DevTools as expandable detail for that event.',
      ),
      _GlossaryEntry(
        term: 'Frame',
        definition:
            'One iteration of the Flutter rendering pipeline. Composed '
            'of Animate, Build, Layout, Paint, Compositing, then Raster.',
      ),
      _GlossaryEntry(
        term: 'Jank',
        definition:
            'A visible stutter caused by a frame that did not fit '
            'inside its budget — typically 16.67 ms at 60 Hz.',
      ),
      _GlossaryEntry(
        term: 'Frame budget',
        definition:
            'The time a frame has to finish before the next vsync. '
            'Equal to 1 / refresh_rate.',
      ),
      _GlossaryEntry(
        term: 'UI thread',
        definition:
            'The thread that runs Dart code, builds widgets, performs '
            'layout, paints, and submits the render tree.',
      ),
      _GlossaryEntry(
        term: 'Raster thread',
        definition:
            'The thread that turns the submitted scene into GPU '
            'commands. Has its own 16 ms budget.',
      ),
      _GlossaryEntry(
        term: 'Vsync',
        definition:
            'The hardware signal that tells the OS a new frame can be '
            'presented. The frame budget starts at vsync.',
      ),
      _GlossaryEntry(
        term: 'DevTools Performance page',
        definition:
            'The DevTools tab where FlutterTimeline events are '
            'visualized as a flame chart per frame.',
      ),
      _GlossaryEntry(
        term: 'TimedBlock',
        definition:
            'The data class returned by FlutterTimeline.debugCollect(). '
            'Has name, start, and end fields in microseconds.',
      ),
      _GlossaryEntry(
        term: 'AggregatedTimings',
        definition:
            'Companion API that aggregates many TimedBlocks by name. '
            'Useful for "how much time did Build take in total?" '
            'queries.',
      ),
    ],
  );
}

class _GlossaryEntry extends StatelessWidget {
  const _GlossaryEntry({required this.term, required this.definition});

  final String term;
  final String definition;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 160,
            child: Text(
              term,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'monospace',
                fontSize: 12,
              ),
            ),
          ),
          Expanded(
            child: Text(
              definition,
              style: const TextStyle(fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Section 9 — RECAP
// ---------------------------------------------------------------------------

Widget _recapSection() {
  return _sectionCard(
    title: 'Recap',
    accent: Colors.indigo,
    children: <Widget>[
      _recapPoint(
        n: 1,
        title: 'FlutterTimeline is the framework tracer.',
        body:
            'Use startSync/finishSync, timeSync, and instantSync to emit '
            'events that the Flutter engine and DevTools understand.',
      ),
      _recapPoint(
        n: 2,
        title: 'It is free in release builds.',
        body:
            'The compiler erases the calls. Sprinkle them liberally in '
            'profile-relevant code paths.',
      ),
      _recapPoint(
        n: 3,
        title: 'Pair every startSync with a finishSync.',
        body:
            'Or, better still, use timeSync, which guarantees that '
            'pairing under all exit paths.',
      ),
      _recapPoint(
        n: 4,
        title: 'Visualize traces as horizontal bars per lane.',
        body:
            'Depth determines the lane, start time determines x, '
            'duration determines width.',
      ),
      _recapPoint(
        n: 5,
        title: 'The 16 ms guide is the jank line.',
        body:
            'A frame that crosses 16 ms at 60 Hz is a missed frame. '
            'Always overlay the guide when reading traces.',
      ),
      _recapPoint(
        n: 6,
        title: 'Instant events mark moments, not durations.',
        body:
            'Use them for gestures, GC, network callbacks, hot-reloads, '
            'and any other "ping".',
      ),
      _recapPoint(
        n: 7,
        title: 'Use dart:developer Timeline for non-Flutter Dart code.',
        body:
            'FlutterTimeline lives in flutter/foundation and would not '
            'be available in a pure-Dart library or CLI.',
      ),
    ],
  );
}

Widget _recapPoint({
  required int n,
  required String title,
  required String body,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: Colors.indigo.shade100,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Text(
            '$n',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.indigo.shade800,
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
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                body,
                style: const TextStyle(fontSize: 12, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

// ---------------------------------------------------------------------------
// Shared widget helpers
// ---------------------------------------------------------------------------

Widget _sectionCard({
  required String title,
  required Color accent,
  required List<Widget> children,
}) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black.withOpacity(0.06),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
      border: Border(left: BorderSide(color: accent, width: 4)),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: accent,
          ),
        ),
        const SizedBox(height: 10),
        ...children,
      ],
    ),
  );
}

Widget _bullet(String text) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Padding(
          padding: EdgeInsets.only(top: 6, right: 8),
          child: Icon(Icons.circle, size: 6, color: Colors.black54),
        ),
        Expanded(
          child: Text(text, style: const TextStyle(fontSize: 13, height: 1.4)),
        ),
      ],
    ),
  );
}

Widget _factRow(String key, String value) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 2),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 130,
          child: Text(
            key,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              fontFamily: 'monospace',
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              fontSize: 12,
              fontFamily: 'monospace',
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
