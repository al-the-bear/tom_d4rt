// ignore_for_file: unused_local_variable, unused_element, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, deprecated_member_use, dead_code, avoid_unnecessary_containers, sized_box_for_whitespace, sort_child_properties_last, unnecessary_import
// D4rt deep visual demo: MacOSScrollViewFlingVelocityTracker from package:flutter/gestures.dart.
// MacOSScrollViewFlingVelocityTracker extends IOSScrollViewFlingVelocityTracker and
// adapts the velocity-tracking algorithm for macOS scroll views, applying a different
// weighted-average over the three most recent inter-sample velocities than iOS does.
//
// macOS weighted average:   v[-2]*0.15 + v[-1]*0.65 + v[0]*0.20
// iOS  weighted average:    v[-2]*0.60 + v[-1]*0.35 + v[0]*0.05
//
// Both inherit a 20-sample circular buffer and a 40 ms "assume stopped" timeout.
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  // ============================================================
  // SETUP : exercise the real tracker so the value is visible.
  // ============================================================
  final tracker = MacOSScrollViewFlingVelocityTracker(PointerDeviceKind.trackpad);
  final samples = <Map<String, dynamic>>[
    {'t': 0, 'dx': 0.0, 'dy': 0.0},
    {'t': 16, 'dx': 5.0, 'dy': 0.0},
    {'t': 32, 'dx': 15.0, 'dy': 0.0},
    {'t': 48, 'dx': 30.0, 'dy': 0.0},
    {'t': 64, 'dx': 50.0, 'dy': 0.0},
    {'t': 80, 'dx': 75.0, 'dy': 0.0},
    {'t': 96, 'dx': 105.0, 'dy': 0.0},
    {'t': 112, 'dx': 140.0, 'dy': 0.0},
  ];
  for (final s in samples) {
    tracker.addPosition(
      Duration(milliseconds: s['t'] as int),
      Offset(s['dx'] as double, s['dy'] as double),
    );
  }
  final estimate = tracker.getVelocityEstimate();
  final velocity = tracker.getVelocity();
  final pps = estimate.pixelsPerSecond;
  final confidence = estimate.confidence;
  final duration = estimate.duration;
  final offsetTotal = estimate.offset;

  // weights for the macOS / iOS algorithms
  const macOsWeights = <double>[0.15, 0.65, 0.20];
  const iOsWeights = <double>[0.60, 0.35, 0.05];

  // ============================================================
  // SHARED STYLE TOKENS
  // ============================================================
  const titleStyle = TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.bold,
    color: Color(0xFF1A237E),
  );
  const subtitleStyle = TextStyle(
    fontSize: 14.0,
    color: Color(0xFF455A64),
    fontStyle: FontStyle.italic,
  );
  const monoStyle = TextStyle(
    fontFamily: 'monospace',
    fontSize: 12.0,
    color: Color(0xFF263238),
    height: 1.45,
  );

  // ============================================================
  // SECTION 1 : Hero header
  // ============================================================
  final heroHeader = Container(
    padding: EdgeInsets.all(28.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.deepPurple.shade700,
          Colors.indigo.shade500,
          Colors.blue.shade400,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: [
        BoxShadow(
          color: Colors.deepPurple.withValues(alpha: 0.45),
          blurRadius: 24.0,
          offset: Offset(0.0, 12.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.20),
                borderRadius: BorderRadius.circular(16.0),
              ),
              child: Icon(Icons.swipe, size: 44.0, color: Colors.white),
            ),
            SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'MacOSScrollViewFlingVelocityTracker',
                    style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: 0.4,
                    ),
                  ),
                  SizedBox(height: 4.0),
                  Text(
                    'package:flutter/gestures.dart',
                    style: TextStyle(
                      fontSize: 13.0,
                      color: Colors.white70,
                      fontFamily: 'monospace',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 18.0),
        Text(
          'Estimates the fling velocity a macOS scroll view would report, '
          'using a weighted average of the three most recent inter-sample '
          'velocities of the tracked pointer.',
          style: TextStyle(
            fontSize: 14.0,
            color: Colors.white.withValues(alpha: 0.92),
            height: 1.45,
          ),
        ),
        SizedBox(height: 14.0),
        Wrap(
          spacing: 8.0,
          runSpacing: 8.0,
          children: [
            _chip('extends IOSScrollViewFlingVelocityTracker', Colors.amber),
            _chip('20-sample ring buffer', Colors.tealAccent),
            _chip('40 ms stopped-timeout', Colors.pinkAccent),
            _chip('weights 0.15 / 0.65 / 0.20', Colors.lightGreenAccent),
          ],
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 2 : Anatomy of velocity tracking
  // ============================================================
  final anatomySection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.cyan.shade50, Colors.blue.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.cyan.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.cyan.withValues(alpha: 0.18),
          blurRadius: 12.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.architecture, color: Colors.cyan.shade800, size: 28.0),
            SizedBox(width: 10.0),
            Text('Anatomy of velocity tracking', style: titleStyle),
          ],
        ),
        SizedBox(height: 12.0),
        Text(
          'A pointer fling produces a sequence of (time, position) samples. '
          'The tracker stores them in a fixed-size ring buffer, then estimates '
          'instantaneous velocity from the most recent samples.',
          style: subtitleStyle,
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(
              child: _anatomyCard(
                label: 'INPUT',
                title: 'addPosition()',
                body: 'Stores (Duration, Offset) into a 20-slot ring at index +1.',
                icon: Icons.input,
                color: Colors.indigo,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _anatomyCard(
                label: 'COMPUTE',
                title: '_previousVelocityAt(i)',
                body: 'Δposition / Δtime between two adjacent ring slots, in px/s.',
                icon: Icons.calculate,
                color: Colors.teal,
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: _anatomyCard(
                label: 'OUTPUT',
                title: 'getVelocityEstimate()',
                body: 'Weighted average of the last 3 inter-sample velocities.',
                icon: Icons.output,
                color: Colors.deepOrange,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(14.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.cyan.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'macOS weighted formula:',
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.cyan.shade900,
                ),
              ),
              SizedBox(height: 6.0),
              Text(
                'v_est = 0.15 * v[-2] + 0.65 * v[-1] + 0.20 * v[0]',
                style: monoStyle,
              ),
              SizedBox(height: 6.0),
              Text(
                'Where v[i] is the velocity between the (i-1)th and i-th most '
                'recently added samples (i.e. v[0] is the freshest pair).',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.cyan.shade900,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 3 : Samples timeline (built from `samples`)
  // ============================================================
  final timelineDots = <Widget>[];
  for (var i = 0; i < samples.length; i++) {
    final sample = samples[i];
    final t = sample['t'] as int;
    final dx = sample['dx'] as double;
    final isLatest = i == samples.length - 1;
    timelineDots.add(
      Container(
        width: 86.0,
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: isLatest
                ? [Colors.amber.shade300, Colors.deepOrange.shade300]
                : [Colors.blue.shade100, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: isLatest ? Colors.deepOrange : Colors.blue.shade300,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: (isLatest ? Colors.deepOrange : Colors.blue)
                  .withValues(alpha: 0.25),
              blurRadius: 6.0,
              offset: Offset(0.0, 3.0),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              't=${t}ms',
              style: TextStyle(
                fontSize: 11.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo.shade900,
                fontFamily: 'monospace',
              ),
            ),
            SizedBox(height: 4.0),
            Container(
              width: 14.0,
              height: 14.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isLatest
                    ? Colors.deepOrange.shade700
                    : Colors.indigo.shade400,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.18),
                    blurRadius: 3.0,
                    offset: Offset(0.0, 1.5),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.0),
            Text(
              'x=${dx.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 11.0,
                color: Colors.indigo.shade900,
                fontFamily: 'monospace',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Compute inter-sample velocities (dx/dt in px/s) for educational display.
  final interSampleVelocities = <double>[];
  for (var i = 1; i < samples.length; i++) {
    final t0 = samples[i - 1]['t'] as int;
    final t1 = samples[i]['t'] as int;
    final x0 = samples[i - 1]['dx'] as double;
    final x1 = samples[i]['dx'] as double;
    final dt = (t1 - t0).toDouble();
    final v = dt == 0 ? 0.0 : (x1 - x0) * 1000.0 / dt;
    interSampleVelocities.add(v);
  }

  final samplesTimelineSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.amber.shade50, Colors.orange.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.orange.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.orange.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.timeline, color: Colors.deepOrange.shade700, size: 28.0),
            SizedBox(width: 10.0),
            Text('Samples timeline', style: titleStyle),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Eight synthetic trackpad samples are pushed into the tracker. '
          'The latest (highlighted) is the freshest "touch up" position.',
          style: subtitleStyle,
        ),
        SizedBox(height: 16.0),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: timelineDots),
        ),
        SizedBox(height: 18.0),
        Text(
          'Δposition / Δtime between adjacent samples (px/s):',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13.0,
            color: Colors.deepOrange.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        for (var i = 0; i < interSampleVelocities.length; i++)
          _velocityRow(
            'v[${i - interSampleVelocities.length + 1}]',
            interSampleVelocities[i],
            i == interSampleVelocities.length - 1
                ? Colors.deepOrange
                : Colors.blue,
          ),
      ],
    ),
  );

  // ============================================================
  // SECTION 4 : Weighted-average curve (macOS vs iOS)
  // ============================================================
  final weightCurveSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.green.shade50, Colors.lightGreen.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.green.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.green.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.tune, color: Colors.green.shade800, size: 28.0),
            SizedBox(width: 10.0),
            Text('macOS-specific weighting', style: titleStyle),
          ],
        ),
        SizedBox(height: 10.0),
        Text(
          'macOS biases heavily toward v[-1] (the second most recent inter-sample '
          'velocity) — this captures the user\'s steady-state flick rather than '
          'the latest jittery sample. iOS, in contrast, biases toward v[-2].',
          style: subtitleStyle,
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            Expanded(child: _weightBars('macOS', macOsWeights, Colors.green)),
            SizedBox(width: 16.0),
            Expanded(child: _weightBars('iOS', iOsWeights, Colors.indigo)),
          ],
        ),
        SizedBox(height: 16.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            border: Border.all(color: Colors.green.shade100),
          ),
          child: Text(
            '// flutter/lib/src/gestures/velocity_tracker.dart\n'
            'final Offset estimatedVelocity =\n'
            '    _previousVelocityAt(-2) * 0.15 +\n'
            '    _previousVelocityAt(-1) * 0.65 +\n'
            '    _previousVelocityAt( 0) * 0.20;',
            style: monoStyle,
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 5 : Recipes (how to use it in real code)
  // ============================================================
  final recipesSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.blueGrey.shade50, Colors.indigo.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.indigo.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.indigo.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.menu_book, color: Colors.indigo.shade800, size: 28.0),
            SizedBox(width: 10.0),
            Text('Recipes', style: titleStyle),
          ],
        ),
        SizedBox(height: 12.0),
        _recipeCard(
          number: '01',
          title: 'Construct from a PointerDownEvent',
          code:
              'final tracker = MacOSScrollViewFlingVelocityTracker(\n'
              '  PointerDeviceKind.trackpad,\n'
              ');',
          color: Colors.indigo,
        ),
        SizedBox(height: 8.0),
        _recipeCard(
          number: '02',
          title: 'Feed pointer move events',
          code:
              'void onMove(PointerMoveEvent e) {\n'
              '  tracker.addPosition(e.timeStamp, e.localPosition);\n'
              '}',
          color: Colors.teal,
        ),
        SizedBox(height: 8.0),
        _recipeCard(
          number: '03',
          title: 'Read estimate at touch-up',
          code:
              'void onUp(PointerUpEvent e) {\n'
              '  final est = tracker.getVelocityEstimate();\n'
              '  if (est != null) startFling(est.pixelsPerSecond);\n'
              '}',
          color: Colors.deepPurple,
        ),
        SizedBox(height: 8.0),
        _recipeCard(
          number: '04',
          title: 'Pick the right tracker for the platform',
          code:
              'VelocityTracker pick(PointerDeviceKind kind) =>\n'
              '  Platform.isMacOS\n'
              '    ? MacOSScrollViewFlingVelocityTracker(kind)\n'
              '    : IOSScrollViewFlingVelocityTracker(kind);',
          color: Colors.deepOrange,
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 6 : Pitfalls
  // ============================================================
  final pitfallsSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.red.shade50, Colors.pink.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.red.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.red.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.warning_amber, color: Colors.red.shade700, size: 28.0),
            SizedBox(width: 10.0),
            Text('Pitfalls', style: titleStyle),
          ],
        ),
        SizedBox(height: 12.0),
        _pitfallRow(
          icon: Icons.timer_off,
          title: '40 ms stop heuristic',
          body:
              'If more than 40 ms elapses between addPosition() and the '
              'estimate read, getVelocityEstimate() returns Offset.zero with '
              'confidence 1.0. This is intentional — a slow finish means '
              '"no fling".',
        ),
        _pitfallRow(
          icon: Icons.history,
          title: 'Only 3 velocities matter',
          body:
              'Despite the 20-slot ring, only the latest three inter-sample '
              'velocities feed the weighted average. Adding more samples '
              'beyond that does not improve accuracy.',
        ),
        _pitfallRow(
          icon: Icons.swap_horiz,
          title: 'Time must be monotonic',
          body:
              'addPosition() asserts that timestamps never decrease. Always '
              'pass PointerEvent.timeStamp directly; never synthesise it.',
        ),
        _pitfallRow(
          icon: Icons.bug_report,
          title: 'Cheap, but not regression-based',
          body:
              'This class trades the linear regression accuracy of the base '
              'VelocityTracker for cheap, platform-faithful estimates. Use '
              'VelocityTracker if you need a robust line-fit instead.',
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 7 : iOS vs macOS comparison table
  // ============================================================
  final comparisonSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.purple.shade50, Colors.deepPurple.shade50],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.purple.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.compare, color: Colors.deepPurple.shade700, size: 28.0),
            SizedBox(width: 10.0),
            Text('iOS vs macOS variant', style: titleStyle),
          ],
        ),
        SizedBox(height: 12.0),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            border: Border.all(color: Colors.purple.shade100),
          ),
          child: Column(
            children: [
              _compareHeader(),
              _compareRow('Class', 'IOSScrollViewFling…', 'MacOSScrollViewFling…'),
              _compareRow('Sample buffer size', '20', '20 (inherited)'),
              _compareRow('Stop heuristic', '40 ms', '40 ms (inherited)'),
              _compareRow('Weight on v[-2]', '0.60', '0.15'),
              _compareRow('Weight on v[-1]', '0.35', '0.65'),
              _compareRow('Weight on v[ 0]', '0.05', '0.20'),
              _compareRow('Bias toward', 'older sample', 'middle sample'),
              _compareRow('Use case', 'iOS scroll views', 'macOS scroll views'),
            ],
          ),
        ),
        SizedBox(height: 14.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.purple.shade100, Colors.deepPurple.shade100],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Text(
            'Why the change? macOS scroll views weight the middle sample more '
            'heavily because trackpad fling velocities tend to plateau just '
            'before lift-off; the iOS algorithm — designed for a single '
            'finger touch — gives more credit to slightly older samples.',
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.deepPurple.shade900,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 8 : Live estimate read-out (uses real tracker output)
  // ============================================================
  final liveEstimateSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.lightBlue.shade50,
          Colors.cyan.shade50,
          Colors.teal.shade50,
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.teal.shade200, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.teal.withValues(alpha: 0.18),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.speed, color: Colors.teal.shade800, size: 28.0),
            SizedBox(width: 10.0),
            Text('Live VelocityEstimate', style: titleStyle),
          ],
        ),
        SizedBox(height: 8.0),
        Text(
          'Read directly from the constructed tracker with the eight samples '
          'plugged in above:',
          style: subtitleStyle,
        ),
        SizedBox(height: 14.0),
        _kv('runtimeType', '${tracker.runtimeType}'),
        _kv('pixelsPerSecond', '${pps.dx.toStringAsFixed(2)} px/s, '
            '${pps.dy.toStringAsFixed(2)} px/s'),
        _kv('confidence', confidence.toStringAsFixed(3)),
        _kv('duration', '${duration.inMicroseconds} µs'),
        _kv('offset', '${offsetTotal.dx.toStringAsFixed(2)}, '
            '${offsetTotal.dy.toStringAsFixed(2)}'),
        _kv('getVelocity().pixelsPerSecond',
            '${velocity.pixelsPerSecond.dx.toStringAsFixed(2)}, '
            '${velocity.pixelsPerSecond.dy.toStringAsFixed(2)}'),
        SizedBox(height: 12.0),
        Container(
          padding: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: Colors.teal.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            '// Wrap as Velocity — clamps and normalises\n'
            'final v = tracker.getVelocity();\n'
            'final clamped = v.clampMagnitude(50.0, 8000.0);',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.tealAccent.shade100,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );

  // ============================================================
  // SECTION 9 : Performance notes
  // ============================================================
  final performanceSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.yellow.shade50, Colors.amber.shade100],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.amber.shade300, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.amber.withValues(alpha: 0.25),
          blurRadius: 10.0,
          offset: Offset(0.0, 4.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bolt, color: Colors.amber.shade900, size: 28.0),
            SizedBox(width: 10.0),
            Text('Performance notes', style: titleStyle),
          ],
        ),
        SizedBox(height: 12.0),
        _perfRow('addPosition', 'O(1) — ring buffer write',
            Icons.input, Colors.green),
        _perfRow('getVelocityEstimate', 'O(1) — three Offset operations',
            Icons.calculate, Colors.blue),
        _perfRow('Memory footprint', '20 _PointAtTime slots ≈ 320 bytes',
            Icons.memory, Colors.deepPurple),
        _perfRow('Allocation churn', 'Zero per addPosition, one VelocityEstimate per read',
            Icons.recycling, Colors.teal),
        _perfRow('Compared to base VelocityTracker',
            'Cheaper (no regression), less robust to noise',
            Icons.balance, Colors.orange),
      ],
    ),
  );

  // ============================================================
  // SECTION 10 : Quick reference
  // ============================================================
  final quickRefSection = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(20.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Colors.grey.shade100, Colors.grey.shade200],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(18.0),
      border: Border.all(color: Colors.grey.shade400, width: 1.5),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.10),
          blurRadius: 8.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.bookmarks, color: Colors.grey.shade800, size: 28.0),
            SizedBox(width: 10.0),
            Text('Quick reference', style: titleStyle),
          ],
        ),
        SizedBox(height: 12.0),
        _refRow('Constructor',
            'MacOSScrollViewFlingVelocityTracker(PointerDeviceKind kind)'),
        _refRow('Inherited',
            'addPosition(Duration time, Offset position)'),
        _refRow('Inherited', 'getVelocity() → Velocity'),
        _refRow('Overridden',
            'getVelocityEstimate() → VelocityEstimate?'),
        _refRow('Inherits from',
            'IOSScrollViewFlingVelocityTracker'),
        _refRow('Sibling class',
            'IOSScrollViewFlingVelocityTracker (different weights)'),
        _refRow('Library', 'package:flutter/gestures.dart'),
        _refRow('Source',
            'flutter/lib/src/gestures/velocity_tracker.dart'),
      ],
    ),
  );

  // ============================================================
  // SECTION 11 : ASCII footer (signature look)
  // ============================================================
  final asciiFooter = Container(
    margin: EdgeInsets.symmetric(vertical: 12.0),
    padding: EdgeInsets.all(18.0),
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Color(0xFF0D1117),
          Color(0xFF161B22),
          Color(0xFF21262D),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(16.0),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.40),
          blurRadius: 14.0,
          offset: Offset(0.0, 6.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          ' MacOSScrollViewFlingVelocityTracker — fling timeline ',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.0,
            color: Colors.greenAccent.shade400,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 10.0),
        Text(
          '   t (ms) :   0    16    32    48    64    80    96   112\n'
          '   pos    :   0     5    15    30    50    75   105   140\n'
          '   v(px/s):   .   313   625   938  1250  1563  1875  2188\n'
          '              ^                           |        |\n'
          '              oldest in buffer            v[-2]   v[-1] v[0]\n'
          '\n'
          '   weights : [ 0.15 ][ 0.65 ][ 0.20 ]\n'
          '   est     :  0.15 * v[-2]  +  0.65 * v[-1]  +  0.20 * v[0]\n'
          '\n'
          '   ──── stopped if ΔlastSample > 40 ms ───►  Offset.zero',
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 11.0,
            color: Colors.lightGreenAccent.shade100,
            height: 1.35,
          ),
        ),
        SizedBox(height: 12.0),
        Row(
          children: [
            Icon(Icons.terminal,
                color: Colors.greenAccent.shade400, size: 16.0),
            SizedBox(width: 8.0),
            Text(
              'static motion — AlwaysStoppedAnimation<double> + Duration.zero',
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.0,
                color: Colors.tealAccent.shade100,
              ),
            ),
          ],
        ),
        SizedBox(height: 4.0),
        // Demonstrate the static motion tokens explicitly.
        Builder(builder: (_) {
          final AlwaysStoppedAnimation<double> staticOpacity =
              AlwaysStoppedAnimation<double>(1.0);
          final Duration zero = Duration.zero;
          return Text(
            '   AlwaysStoppedAnimation<double>.value = '
            '${staticOpacity.value} ; Duration = ${zero.inMicroseconds} µs',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10.5,
              color: Colors.white70,
            ),
          );
        }),
      ],
    ),
  );

  // ============================================================
  // ROOT layout
  // ============================================================
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF5F7FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              heroHeader,
              SizedBox(height: 8.0),
              _sectionLabel('1. Anatomy', Icons.architecture, Colors.cyan),
              anatomySection,
              _sectionLabel('2. Samples timeline', Icons.timeline,
                  Colors.deepOrange),
              samplesTimelineSection,
              _sectionLabel('3. Weighted-average curve', Icons.tune,
                  Colors.green),
              weightCurveSection,
              _sectionLabel('4. Recipes', Icons.menu_book, Colors.indigo),
              recipesSection,
              _sectionLabel('5. Pitfalls', Icons.warning_amber, Colors.red),
              pitfallsSection,
              _sectionLabel('6. iOS vs macOS', Icons.compare,
                  Colors.deepPurple),
              comparisonSection,
              _sectionLabel('7. Live estimate', Icons.speed, Colors.teal),
              liveEstimateSection,
              _sectionLabel('8. Performance', Icons.bolt, Colors.amber),
              performanceSection,
              _sectionLabel('9. Quick reference', Icons.bookmarks,
                  Colors.blueGrey),
              quickRefSection,
              asciiFooter,
              SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    ),
  );
}

// ============================================================
// HELPERS
// ============================================================

Widget _chip(String text, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.22),
      borderRadius: BorderRadius.circular(20.0),
      border: Border.all(color: color.withValues(alpha: 0.55), width: 1.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 11.0,
        color: Colors.white,
        fontFamily: 'monospace',
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}

Widget _sectionLabel(String text, IconData icon, MaterialColor color) {
  return Padding(
    padding: EdgeInsets.fromLTRB(4.0, 18.0, 4.0, 4.0),
    child: Row(
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color.shade800, size: 18.0),
        ),
        SizedBox(width: 8.0),
        Text(
          text,
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: color.shade900,
            letterSpacing: 0.3,
          ),
        ),
      ],
    ),
  );
}

Widget _anatomyCard({
  required String label,
  required String title,
  required String body,
  required IconData icon,
  required MaterialColor color,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade200, width: 1.2),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.14),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color.shade700, size: 20.0),
            SizedBox(width: 6.0),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.0,
                fontWeight: FontWeight.bold,
                color: color.shade700,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
        SizedBox(height: 6.0),
        Text(
          title,
          style: TextStyle(
            fontFamily: 'monospace',
            fontSize: 12.5,
            fontWeight: FontWeight.bold,
            color: color.shade900,
          ),
        ),
        SizedBox(height: 4.0),
        Text(
          body,
          style: TextStyle(
            fontSize: 11.0,
            color: Colors.black87,
            height: 1.35,
          ),
        ),
      ],
    ),
  );
}

Widget _velocityRow(String label, double value, MaterialColor color) {
  // Bar saturates around 2500 px/s.
  final fraction = (value.abs() / 2500.0).clamp(0.0, 1.0);
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 3.0),
    child: Row(
      children: [
        SizedBox(
          width: 60.0,
          child: Text(
            label,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: color.shade900,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 14.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(7.0),
              border: Border.all(color: color.shade100),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.shade300, color.shade600],
                  ),
                  borderRadius: BorderRadius.circular(7.0),
                ),
              ),
            ),
          ),
        ),
        SizedBox(width: 8.0),
        SizedBox(
          width: 84.0,
          child: Text(
            '${value.toStringAsFixed(0)} px/s',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.5,
              fontWeight: FontWeight.bold,
              color: color.shade900,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _weightBars(String name, List<double> weights, MaterialColor color) {
  final labels = ['v[-2]', 'v[-1]', 'v[ 0]'];
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade200),
      boxShadow: [
        BoxShadow(
          color: color.withValues(alpha: 0.18),
          blurRadius: 6.0,
          offset: Offset(0.0, 3.0),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14.0,
            color: color.shade900,
          ),
        ),
        SizedBox(height: 8.0),
        for (var i = 0; i < weights.length; i++)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3.0),
            child: Row(
              children: [
                SizedBox(
                  width: 44.0,
                  child: Text(
                    labels[i],
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      color: color.shade800,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    height: 12.0,
                    decoration: BoxDecoration(
                      color: color.shade50,
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: weights[i],
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [color.shade300, color.shade700],
                          ),
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 6.0),
                SizedBox(
                  width: 42.0,
                  child: Text(
                    weights[i].toStringAsFixed(2),
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'monospace',
                      fontSize: 11.0,
                      fontWeight: FontWeight.bold,
                      color: color.shade900,
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

Widget _recipeCard({
  required String number,
  required String title,
  required String code,
  required MaterialColor color,
}) {
  return Container(
    padding: EdgeInsets.all(12.0),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12.0),
      border: Border.all(color: color.shade200, width: 1.2),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              decoration: BoxDecoration(
                color: color.shade700,
                borderRadius: BorderRadius.circular(6.0),
              ),
              child: Text(
                number,
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  fontSize: 11.0,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 8.0),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: color.shade900,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8.0),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: color.shade900,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Text(
            code,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: color.shade50,
              height: 1.45,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _pitfallRow({
  required IconData icon,
  required String title,
  required String body,
}) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.red.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: Colors.red.shade700, size: 18.0),
        ),
        SizedBox(width: 10.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13.0,
                  color: Colors.red.shade900,
                ),
              ),
              SizedBox(height: 3.0),
              Text(
                body,
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.black87,
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

Widget _compareHeader() {
  return Container(
    decoration: BoxDecoration(
      color: Colors.deepPurple.shade100,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(12.0),
        topRight: Radius.circular(12.0),
      ),
    ),
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            'Property',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'iOS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
              fontSize: 12.0,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            'macOS',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade900,
              fontSize: 12.0,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _compareRow(String prop, String ios, String macOs) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
    decoration: BoxDecoration(
      border: Border(
        bottom: BorderSide(color: Colors.purple.shade50, width: 1.0),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            prop,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 11.5,
              color: Colors.deepPurple.shade800,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            ios,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.indigo.shade900,
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Text(
            macOs,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11.0,
              color: Colors.green.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _kv(String key, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 220.0,
          child: Text(
            key,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.teal.shade900,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12.0,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _perfRow(String op, String complexity, IconData icon,
    MaterialColor color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(6.0),
          decoration: BoxDecoration(
            color: color.shade100,
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Icon(icon, color: color.shade800, size: 18.0),
        ),
        SizedBox(width: 10.0),
        SizedBox(
          width: 200.0,
          child: Text(
            op,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.5,
              color: color.shade900,
            ),
          ),
        ),
        Expanded(
          child: Text(
            complexity,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black87,
              height: 1.35,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _refRow(String label, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110.0,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12.0,
              color: Colors.blueGrey.shade800,
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Text(
              value,
              style: TextStyle(
                fontFamily: 'monospace',
                fontSize: 11.5,
                color: Colors.blueGrey.shade900,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
