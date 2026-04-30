// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for ParametricCurve from animation
// ParametricCurve is the base class for all animation curves
// Maps time [0,1] to value [0,1] with various mathematical functions
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                  PARAMETRIC CURVE DEEP DEMO                       ║',
  );
  print(
    '║            Base Class for All Animation Curves                    ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: PARAMETRIC CURVE FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: PARAMETRIC CURVE FUNDAMENTALS                          │',
  );
  print(
    '│ Understanding the base class for all curves                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('ParametricCurve characteristics:');
  print('  • Abstract base class for animation curves');
  print('  • Input: t ∈ [0, 1] (animation progress)');
  print('  • Output: value ∈ [0, 1] (typical, may exceed)');
  print('  • Must satisfy: transform(0) ≈ 0, transform(1) ≈ 1');
  print('  • Provides .flipped getter to invert curves');
  print('');

  // Create various curve implementations
  final linear = Curves.linear;
  final easeIn = Curves.easeIn;
  final easeOut = Curves.easeOut;
  final cubic = Cubic(0.25, 0.1, 0.25, 1.0);
  final sawTooth = SawTooth(4);
  final threshold = Threshold(0.5);
  final interval = Interval(0.25, 0.75);
  print('✓ Created various ParametricCurve implementations');
  print('');

  final tValues = <double>[
    0.0,
    0.1,
    0.2,
    0.3,
    0.4,
    0.5,
    0.6,
    0.7,
    0.8,
    0.9,
    1.0,
  ];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: LINEAR CURVE (IDENTITY)
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: LINEAR CURVE (IDENTITY)                                │',
  );
  print(
    '│ transform(t) = t - the simplest curve                             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final linearResults = <Map<String, dynamic>>[];

  print('Curves.linear (baseline reference):');
  print(
    '┌─────────┬─────────────────┬───────────────────────────────────────────┐',
  );
  print(
    '│    t    │     Output      │   Visualization                           │',
  );
  print(
    '├─────────┼─────────────────┼───────────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final out = linear.transform(t);
    linearResults.add({'t': t, 'out': out});

    final barWidth = (out * 35).round();
    final bar = '█' * barWidth + '░' * (35 - barWidth);
    print(
      '│  ${t.toStringAsFixed(2)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │ $bar │',
    );
  }
  print(
    '└─────────┴─────────────────┴───────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: CUBIC BEZIER CURVES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: CUBIC BEZIER CURVES                                    │',
  );
  print(
    '│ Defined by 4 control points (2 implicit: start/end)               │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final cubicResults = <Map<String, dynamic>>[];

  print('Cubic(0.25, 0.1, 0.25, 1.0):');
  print('  Control points: (0,0) → (0.25,0.1) → (0.25,1.0) → (1,1)');
  print('');
  print(
    '┌─────────┬─────────────────┬───────────────────────────────────────────┐',
  );
  print(
    '│    t    │     Output      │   Comparison to Linear                    │',
  );
  print(
    '├─────────┼─────────────────┼───────────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final out = cubic.transform(t);
    final diff = out - t;
    cubicResults.add({'t': t, 'out': out, 'diff': diff});

    final diffStr = diff >= 0
        ? '+${diff.toStringAsFixed(3)}'
        : diff.toStringAsFixed(3);
    final barWidth = (out * 25).round();
    final linearBar = (t * 25).round();
    String bar = '';
    for (var i = 0; i <= 25; i++) {
      if (i == barWidth && i == linearBar) {
        bar += '▓';
      } else if (i == barWidth)
        bar += '█';
      else if (i == linearBar)
        bar += '│';
      else
        bar += '░';
    }
    print(
      '│  ${t.toStringAsFixed(2)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │ $bar ($diffStr) │',
    );
  }
  print(
    '└─────────┴─────────────────┴───────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: EASE IN vs EASE OUT
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: EASE IN vs EASE OUT                                    │',
  );
  print(
    '│ Slow start vs slow finish behaviors                               │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final easeResults = <Map<String, dynamic>>[];

  print('EaseIn vs EaseOut comparison:');
  print(
    '┌─────────┬───────────────┬───────────────┬───────────────────────────┐',
  );
  print(
    '│    t    │    EaseIn     │    EaseOut    │   Visual Comparison       │',
  );
  print(
    '├─────────┼───────────────┼───────────────┼───────────────────────────┤',
  );

  for (final t in tValues) {
    final inVal = easeIn.transform(t);
    final outVal = easeOut.transform(t);
    easeResults.add({'t': t, 'inVal': inVal, 'outVal': outVal});

    final inBar = '█' * (inVal * 10).round().clamp(0, 10);
    final outBar = '▓' * (outVal * 10).round().clamp(0, 10);
    print(
      '│  ${t.toStringAsFixed(2)}   │    ${inVal.toStringAsFixed(4).padLeft(6)}     │    ${outVal.toStringAsFixed(4).padLeft(6)}     │ ${inBar.padRight(10)}${outBar.padLeft(10)} │',
    );
  }
  print(
    '└─────────┴───────────────┴───────────────┴───────────────────────────┘',
  );
  print('');
  print('█ = EaseIn (slow start, fast end)');
  print('▓ = EaseOut (fast start, slow end)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: SAWTOOTH CURVE
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: SAWTOOTH CURVE                                         │',
  );
  print(
    '│ Repeating linear pattern                                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final sawtoothResults = <Map<String, dynamic>>[];

  print('SawTooth(4) - 4 complete cycles:');
  print('┌─────────┬─────────────────┬──────────────────────────────────────┐');
  print('│    t    │     Output      │   Pattern                            │');
  print('├─────────┼─────────────────┼──────────────────────────────────────┤');

  for (var i = 0; i <= 20; i++) {
    final t = i / 20;
    final out = sawTooth.transform(t);
    final cycle = (t * 4).floor();
    sawtoothResults.add({'t': t, 'out': out, 'cycle': cycle});

    final pos = (out * 8).round();
    final pattern = '${'░' * pos}█${'░' * (8 - pos)}';
    print(
      '│  ${t.toStringAsFixed(2)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │ Cycle $cycle: $pattern │',
    );
  }
  print('└─────────┴─────────────────┴──────────────────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: THRESHOLD CURVE
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: THRESHOLD CURVE                                        │',
  );
  print(
    '│ Binary step function                                              │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final thresholdResults = <Map<String, dynamic>>[];

  print('Threshold(0.5) - step at 50%:');
  print(
    '┌─────────┬─────────────────┬───────────────────────────────────────────┐',
  );
  print(
    '│    t    │     Output      │   State                                   │',
  );
  print(
    '├─────────┼─────────────────┼───────────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final out = threshold.transform(t);
    final state = out == 0.0
        ? 'Before threshold (OFF)'
        : 'After threshold (ON)';
    thresholdResults.add({'t': t, 'out': out, 'state': state});

    final visual = out == 0.0 ? '░░░░░░░░░░' : '██████████';
    print(
      '│  ${t.toStringAsFixed(2)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │ $visual ${state.padRight(30)} │',
    );
  }
  print(
    '└─────────┴─────────────────┴───────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: INTERVAL CURVE
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: INTERVAL CURVE                                         │',
  );
  print(
    '│ Time remapping for portions of animation                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final intervalResults = <Map<String, dynamic>>[];

  print('Interval(0.25, 0.75) - middle 50%:');
  print(
    '┌─────────┬─────────────────┬──────────────────────────────────────────┐',
  );
  print(
    '│    t    │     Output      │   Status                                 │',
  );
  print(
    '├─────────┼─────────────────┼──────────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final out = interval.transform(t);
    String status;
    if (t < 0.25) {
      status = '░░░░░ Waiting';
    } else if (t > 0.75)
      status = '█████ Complete';
    else
      status = '▓▓▓▓▓ Active (${(out * 100).round()}%)';
    intervalResults.add({'t': t, 'out': out, 'status': status});
    print(
      '│  ${t.toStringAsFixed(2)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │ ${status.padRight(40)} │',
    );
  }
  print(
    '└─────────┴─────────────────┴──────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: FLIPPED CURVES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: FLIPPED CURVES                                         │',
  );
  print(
    '│ Using .flipped getter to reverse a curve                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final flippedCubic = cubic.flipped;
  final flippedResults = <Map<String, dynamic>>[];

  print('Original Cubic vs Flipped:');
  print('  Flipped formula: flipped(t) = 1 - curve(1 - t)');
  print('');
  print('┌─────────┬───────────────┬───────────────┬───────────────┐');
  print('│    t    │   Original    │    Flipped    │   Difference  │');
  print('├─────────┼───────────────┼───────────────┼───────────────┤');

  for (final t in tValues) {
    final orig = cubic.transform(t);
    final flip = flippedCubic.transform(t);
    final diff = flip - orig;
    flippedResults.add({'t': t, 'orig': orig, 'flip': flip, 'diff': diff});
    print(
      '│  ${t.toStringAsFixed(2)}   │    ${orig.toStringAsFixed(4).padLeft(6)}     │    ${flip.toStringAsFixed(4).padLeft(6)}     │   ${diff.toStringAsFixed(4).padLeft(8)}    │',
    );
  }
  print('└─────────┴───────────────┴───────────────┴───────────────┘');
  print('');

  // Verify flipped relationship
  print('Verifying: flipped(t) ≈ 1 - original(1 - t)');
  var flippedValid = true;
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final flip = flippedCubic.transform(t);
    final expected = 1.0 - cubic.transform(1.0 - t);
    final diff = (flip - expected).abs();
    if (diff > 0.0001) flippedValid = false;
    print(
      '  t=$t: flipped=${flip.toStringAsFixed(4)}, 1-orig(1-t)=${expected.toStringAsFixed(4)}, diff=${diff.toStringAsFixed(6)}',
    );
  }
  print(
    '  Result: ${flippedValid ? '✓ Formula verified' : '✗ Mismatch detected'}',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: CURVE COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: CURVE COMPARISON                                       │',
  );
  print(
    '│ All ParametricCurve implementations at t=0.5                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final curves = <String, Curve>{
    'Linear': linear,
    'EaseIn': easeIn,
    'EaseOut': easeOut,
    'EaseInOut': Curves.easeInOut,
    'Cubic': cubic,
    'Decelerate': Curves.decelerate,
    'Bounce': Curves.bounceOut,
    'Elastic': Curves.elasticOut,
  };

  final comparisonResults = <Map<String, dynamic>>[];

  print('All curves at t=0.5:');
  print(
    '┌───────────────┬─────────────────┬──────────────────────────────────┐',
  );
  print(
    '│   Curve       │   Output (0.5)  │   Bar                            │',
  );
  print(
    '├───────────────┼─────────────────┼──────────────────────────────────┤',
  );

  for (final entry in curves.entries) {
    final out = entry.value.transform(0.5);
    comparisonResults.add({'name': entry.key, 'out': out});

    // Handle values outside 0-1 range for elastic/bounce
    final clampedOut = out.clamp(0.0, 1.0);
    final barWidth = (clampedOut * 28).round();
    final bar = '█' * barWidth + '░' * (28 - barWidth);
    final overshoot = out > 1.0 ? ' ↑' : (out < 0.0 ? ' ↓' : '');
    print(
      '│ ${entry.key.padRight(13)} │     ${out.toStringAsFixed(4).padRight(10)}  │ $bar$overshoot│',
    );
  }
  print(
    '└───────────────┴─────────────────┴──────────────────────────────────┘',
  );
  print('');
  print('Note: Elastic/Bounce may overshoot 0-1 range');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: BOUNDARY CONDITIONS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: BOUNDARY CONDITIONS                                   │',
  );
  print(
    '│ Verifying transform(0)≈0 and transform(1)≈1                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final boundaryResults = <Map<String, dynamic>>[];

  print('Boundary condition check:');
  print(
    '┌───────────────┬─────────────────┬─────────────────┬───────────────┐',
  );
  print(
    '│   Curve       │  transform(0)   │  transform(1)   │   Valid?      │',
  );
  print(
    '├───────────────┼─────────────────┼─────────────────┼───────────────┤',
  );

  for (final entry in curves.entries) {
    final t0 = entry.value.transform(0.0);
    final t1 = entry.value.transform(1.0);
    final valid = (t0 - 0.0).abs() < 0.01 && (t1 - 1.0).abs() < 0.01;
    boundaryResults.add({
      'name': entry.key,
      't0': t0,
      't1': t1,
      'valid': valid,
    });
    print(
      '│ ${entry.key.padRight(13)} │     ${t0.toStringAsFixed(6).padRight(10)} │     ${t1.toStringAsFixed(6).padRight(10)} │ ${valid ? '    ✓        ' : '    ✗        '} │',
    );
  }
  print(
    '└───────────────┴─────────────────┴─────────────────┴───────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                  PARAMETRIC CURVE SUMMARY                         ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('ParametricCurve implementations tested:');
  print('  • Linear - identity: f(t) = t');
  print('  • Cubic - Bézier curves with control points');
  print('  • EaseIn/EaseOut - slow start/end');
  print('  • SawTooth - repeating linear pattern');
  print('  • Threshold - binary step function');
  print('  • Interval - time remapping');
  print('  • Flipped - curve inversion via .flipped');
  print('');
  print('Key properties:');
  print('  • Input: t ∈ [0, 1]');
  print('  • Output: typically [0, 1] (may exceed for elastic/bounce)');
  print('  • Boundary conditions: f(0) ≈ 0, f(1) ≈ 1');
  print('');
  print('ParametricCurve Deep Demo completed');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'ParametricCurve',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Base Class for All Animation Curves',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFBBDEFB)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Concept Section
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE3F2FD),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CURVE CONCEPT',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFF90CAF9)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Input: t ∈ [0, 1] (animation progress)',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Output: value (typically 0-1)',
                        style: TextStyle(fontSize: 12),
                      ),
                      Text(
                        'Requirement: f(0) ≈ 0, f(1) ≈ 1',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Curve Types Grid
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CURVE IMPLEMENTATIONS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildCurveChip('Linear', Color(0xFF4CAF50)),
                    _buildCurveChip('Cubic', Color(0xFF2196F3)),
                    _buildCurveChip('EaseIn', Color(0xFFFF9800)),
                    _buildCurveChip('EaseOut', Color(0xFFE91E63)),
                    _buildCurveChip('SawTooth', Color(0xFF9C27B0)),
                    _buildCurveChip('Threshold', Color(0xFF607D8B)),
                    _buildCurveChip('Interval', Color(0xFF795548)),
                    _buildCurveChip('Elastic', Color(0xFF00BCD4)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Comparison at t=0.5
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFF8E1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'COMPARISON AT t=0.5',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...comparisonResults
                    .take(6)
                    .map((r) => _buildComparisonRow(r['name'], r['out'])),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // EaseIn vs EaseOut
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE8EAF6),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'EASE IN vs EASE OUT',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3949AB),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...easeResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map(
                      (r) => _buildEaseRow(
                        't=${(r['t'] as double).toStringAsFixed(2)}',
                        r['inVal'] as double,
                        r['outVal'] as double,
                      ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Flipped Visualization
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FLIPPED CURVE',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'flipped(t) = 1 - curve(1 - t)',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
                SizedBox(height: 12.0),
                ...flippedResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map(
                      (r) => _buildFlippedRow(
                        't=${(r['t'] as double).toStringAsFixed(2)}',
                        r['orig'] as double,
                        r['flip'] as double,
                      ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // SawTooth Visual
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE0F7FA),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SAWTOOTH PATTERN',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00838F),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text('SawTooth(4) - 4 cycles', style: TextStyle(fontSize: 12)),
                SizedBox(height: 12.0),
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: CustomPaint(
                    painter: SawtoothPainter(sawTooth, 4),
                    size: Size(double.infinity, 80),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Summary
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  'SUMMARY',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat('Curves Tested', '${curves.length}'),
                    _buildSummaryStat('Test Points', '${tValues.length}'),
                    _buildSummaryStat(
                      'Flipped Valid',
                      flippedValid ? 'Yes' : 'No',
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat(
                      'Cubic t=0.5',
                      cubic.transform(0.5).toStringAsFixed(2),
                    ),
                    _buildSummaryStat(
                      'EaseIn t=0.5',
                      easeIn.transform(0.5).toStringAsFixed(2),
                    ),
                    _buildSummaryStat(
                      'EaseOut t=0.5',
                      easeOut.transform(0.5).toStringAsFixed(2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),

          // Footer
          Center(
            child: Text(
              'Deep Demo • ParametricCurve • Flutter Animation',
              style: TextStyle(
                fontSize: 12.0,
                color: Color(0xFF9E9E9E),
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCurveChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(
      label,
      style: TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Widget _buildComparisonRow(String name, double value) {
  final clampedValue = value.clamp(0.0, 1.0);

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(width: 80, child: Text(name, style: TextStyle(fontSize: 11))),
        Expanded(
          child: Container(
            height: 16,
            decoration: BoxDecoration(
              color: Color(0xFFFFE0B2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: clampedValue,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF57C00),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment.centerRight,
          child: Text(
            value.toStringAsFixed(3),
            style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
          ),
        ),
      ],
    ),
  );
}

Widget _buildEaseRow(String label, double easeIn, double easeOut) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(width: 50, child: Text(label, style: TextStyle(fontSize: 11))),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Color(0xFFC5CAE9),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: easeIn.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF3949AB),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Color(0xFFC5CAE9),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: easeOut.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF7986CB),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                easeIn.toStringAsFixed(2),
                style: TextStyle(fontSize: 9, color: Color(0xFF3949AB)),
              ),
              Text(' / ', style: TextStyle(fontSize: 9)),
              Text(
                easeOut.toStringAsFixed(2),
                style: TextStyle(fontSize: 9, color: Color(0xFF7986CB)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildFlippedRow(String label, double orig, double flipped) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(width: 50, child: Text(label, style: TextStyle(fontSize: 11))),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Color(0xFFE1BEE7),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: orig.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF7B1FA2),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Color(0xFFE1BEE7),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: flipped.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFAB47BC),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                orig.toStringAsFixed(2),
                style: TextStyle(fontSize: 9, color: Color(0xFF7B1FA2)),
              ),
              Text(' / ', style: TextStyle(fontSize: 9)),
              Text(
                flipped.toStringAsFixed(2),
                style: TextStyle(fontSize: 9, color: Color(0xFFAB47BC)),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryStat(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4DD0E1),
        ),
      ),
      Text(label, style: TextStyle(fontSize: 9.0, color: Color(0xFF90A4AE))),
    ],
  );
}

class SawtoothPainter extends CustomPainter {
  final SawTooth sawTooth;
  final int count;

  SawtoothPainter(this.sawTooth, this.count);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFF00838F)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height);

    for (var i = 0; i <= 100; i++) {
      final t = i / 100;
      final value = sawTooth.transform(t);
      path.lineTo(t * size.width, size.height - value * (size.height - 10));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
