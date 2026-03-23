// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for ElasticInOutCurve from animation
// ElasticInOutCurve provides spring-like animation at both start and end
// Creates a symmetric "pull-back and overshoot" effect
import 'dart:math' as math;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║               ELASTICINOUTCURVE DEEP DEMO                         ║',
  );
  print(
    '║        Spring-Like Animation at Both Boundaries                   ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ELASTICINOUTCURVE FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: ELASTICINOUTCURVE FUNDAMENTALS                         │',
  );
  print(
    '│ Understanding the symmetric elastic animation curve               │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('ElasticInOutCurve characteristics:');
  print('  • Combines ElasticIn and ElasticOut behavior');
  print('  • Oscillates below zero at start (pull-back)');
  print('  • Oscillates above 1.0 at end (overshoot)');
  print('  • Symmetric around t=0.5');
  print('  • f(t) + f(1-t) = 1.0 (point symmetry about (0.5, 0.5))');
  print('  • Default period: 0.4');
  print('');

  // Create default curve
  final defaultCurve = ElasticInOutCurve();
  print('✓ Created default ElasticInOutCurve (period: 0.4)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: DEFAULT TRANSFORM BEHAVIOR
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: DEFAULT TRANSFORM BEHAVIOR                             │',
  );
  print(
    '│ Transform values across the full parameter range                  │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final tValues = <double>[
    0.0,
    0.05,
    0.1,
    0.15,
    0.2,
    0.25,
    0.3,
    0.35,
    0.4,
    0.45,
    0.5,
    0.55,
    0.6,
    0.65,
    0.7,
    0.75,
    0.8,
    0.85,
    0.9,
    0.95,
    1.0,
  ];
  final defaultResults = <Map<String, dynamic>>[];

  print('Default ElasticInOutCurve transform:');
  print(
    '┌─────────┬─────────────────┬────────────────────────────────────────┐',
  );
  print(
    '│    t    │      value      │   visualization                        │',
  );
  print(
    '├─────────┼─────────────────┼────────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final value = defaultCurve.transform(t);
    defaultResults.add({'t': t, 'value': value});

    // Create a simple ASCII visualization
    final normalized = ((value + 0.2) * 25).round().clamp(0, 40);
    final bar =
        '│${' ' * math.max(0, normalized - 1)}*${' ' * math.max(0, 39 - normalized)}';
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${value.toStringAsFixed(8).padLeft(12)}   │$bar│',
    );
  }
  print(
    '└─────────┴─────────────────┴────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: SYMMETRY VERIFICATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: SYMMETRY VERIFICATION                                  │',
  );
  print(
    '│ Verifying f(t) + f(1-t) = 1.0                                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final symmetryResults = <Map<String, dynamic>>[];

  print('Point symmetry check (should sum to 1.0):');
  print('┌─────────┬─────────────────┬─────────────────┬──────────────────┐');
  print('│    t    │      f(t)       │     f(1-t)      │       Sum        │');
  print('├─────────┼─────────────────┼─────────────────┼──────────────────┤');

  for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5]) {
    final ft = defaultCurve.transform(t);
    final f1t = defaultCurve.transform(1.0 - t);
    final sum = ft + f1t;
    symmetryResults.add({'t': t, 'ft': ft, 'f1t': f1t, 'sum': sum});
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${ft.toStringAsFixed(8).padLeft(12)}   │  ${f1t.toStringAsFixed(8).padLeft(12)}   │  ${sum.toStringAsFixed(8).padLeft(13)}   │',
    );
  }
  print('└─────────┴─────────────────┴─────────────────┴──────────────────┘');
  print('');

  final symmetryError = symmetryResults
      .map((r) => ((r['sum'] as double) - 1.0).abs())
      .reduce(math.max);
  print('Maximum symmetry error: ${symmetryError.toStringAsFixed(12)}');
  print(
    symmetryError < 1e-10
        ? "✓ Perfect symmetry verified"
        : "⚠ Slight asymmetry detected",
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: PERIOD VARIATIONS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: PERIOD VARIATIONS                                      │',
  );
  print(
    '│ Effect of period parameter on oscillation                         │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final periods = <double>[0.1, 0.2, 0.4, 0.6, 0.8, 1.0];
  final periodCurves = <double, ElasticInOutCurve>{};
  final periodResults = <Map<String, dynamic>>[];

  for (final period in periods) {
    periodCurves[period] = ElasticInOutCurve(period);
  }

  print('Period comparison at key t values:');
  print(
    '┌─────────┬───────────┬───────────┬───────────┬───────────┬───────────┬───────────┐',
  );
  print(
    '│    t    │  p=0.1    │  p=0.2    │  p=0.4    │  p=0.6    │  p=0.8    │  p=1.0    │',
  );
  print(
    '├─────────┼───────────┼───────────┼───────────┼───────────┼───────────┼───────────┤',
  );

  for (final t in [0.0, 0.2, 0.4, 0.5, 0.6, 0.8, 1.0]) {
    final values = <double, double>{};
    for (final entry in periodCurves.entries) {
      values[entry.key] = entry.value.transform(t);
    }
    periodResults.add({'t': t, 'values': values});
    print(
      '│  ${t.toStringAsFixed(2)}   │ ${values[0.1]!.toStringAsFixed(4).padLeft(8)} │ ${values[0.2]!.toStringAsFixed(4).padLeft(8)} │ ${values[0.4]!.toStringAsFixed(4).padLeft(8)} │ ${values[0.6]!.toStringAsFixed(4).padLeft(8)} │ ${values[0.8]!.toStringAsFixed(4).padLeft(8)} │ ${values[1.0]!.toStringAsFixed(4).padLeft(8)} │',
    );
  }
  print(
    '└─────────┴───────────┴───────────┴───────────┴───────────┴───────────┴───────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: VALUE RANGE ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: VALUE RANGE ANALYSIS                                   │',
  );
  print(
    '│ Understanding min/max values for each period                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final rangeAnalysis = <Map<String, dynamic>>[];

  print('Value range for different periods:');
  print(
    '┌────────────┬──────────────────┬──────────────────┬──────────────────┐',
  );
  print(
    '│   Period   │    Min Value     │    Max Value     │   Range Width    │',
  );
  print(
    '├────────────┼──────────────────┼──────────────────┼──────────────────┤',
  );

  for (final period in periods) {
    double minVal = double.infinity;
    double maxVal = double.negativeInfinity;

    for (var i = 0; i <= 200; i++) {
      final t = i / 200;
      final v = periodCurves[period]!.transform(t);
      if (v < minVal) minVal = v;
      if (v > maxVal) maxVal = v;
    }

    final rangeWidth = maxVal - minVal;
    rangeAnalysis.add({
      'period': period,
      'min': minVal,
      'max': maxVal,
      'range': rangeWidth,
    });
    print(
      '│    ${period.toStringAsFixed(1)}     │  ${minVal.toStringAsFixed(8).padLeft(14)}  │  ${maxVal.toStringAsFixed(8).padLeft(14)}  │  ${rangeWidth.toStringAsFixed(8).padLeft(14)}  │',
    );
  }
  print(
    '└────────────┴──────────────────┴──────────────────┴──────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: ELASTIC FAMILY COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: ELASTIC CURVE FAMILY COMPARISON                        │',
  );
  print(
    '│ ElasticIn vs ElasticOut vs ElasticInOut                           │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final elasticIn = ElasticInCurve();
  final elasticOut = ElasticOutCurve();
  final elasticInOut = ElasticInOutCurve();

  final familyResults = <Map<String, dynamic>>[];

  print('Elastic curve family comparison:');
  print('┌─────────┬─────────────────┬─────────────────┬─────────────────┐');
  print('│    t    │   ElasticIn     │   ElasticOut    │  ElasticInOut   │');
  print('├─────────┼─────────────────┼─────────────────┼─────────────────┤');

  for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]) {
    final vIn = elasticIn.transform(t);
    final vOut = elasticOut.transform(t);
    final vInOut = elasticInOut.transform(t);
    familyResults.add({'t': t, 'in': vIn, 'out': vOut, 'inOut': vInOut});
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${vIn.toStringAsFixed(8).padLeft(12)}   │  ${vOut.toStringAsFixed(8).padLeft(12)}   │  ${vInOut.toStringAsFixed(8).padLeft(12)}   │',
    );
  }
  print('└─────────┴─────────────────┴─────────────────┴─────────────────┘');
  print('');

  print('Family behavior:');
  print('  • ElasticIn: Slow start with backward oscillation, fast finish');
  print('  • ElasticOut: Fast start, oscillates past 1.0 at end');
  print('  • ElasticInOut: Both effects - oscillates at start AND end');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: VELOCITY ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: VELOCITY ANALYSIS                                      │',
  );
  print(
    '│ Rate of change at different points                                │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  double calculateDerivative(Curve curve, double t, double dt) {
    final low = (t - dt / 2).clamp(0.0, 1.0);
    final high = (t + dt / 2).clamp(0.0, 1.0);
    final actualDt = high - low;
    if (actualDt == 0) return 0;
    return (curve.transform(high) - curve.transform(low)) / actualDt;
  }

  final velocityResults = <Map<String, dynamic>>[];

  print('Velocity (dy/dt) at key points:');
  print(
    '┌─────────┬─────────────────┬───────────────────────────────────────┐',
  );
  print(
    '│    t    │   Velocity      │   Interpretation                      │',
  );
  print(
    '├─────────┼─────────────────┼───────────────────────────────────────┤',
  );

  for (final t in [0.1, 0.25, 0.5, 0.75, 0.9]) {
    final velocity = calculateDerivative(defaultCurve, t, 0.01);
    String interpretation;
    if (velocity < -1.0) {
      interpretation = 'Strong backward motion';
    } else if (velocity < 0)
      interpretation = 'Backward motion';
    else if (velocity < 1.0)
      interpretation = 'Slow forward';
    else if (velocity < 3.0)
      interpretation = 'Moderate acceleration';
    else
      interpretation = 'Rapid motion';

    velocityResults.add({
      't': t,
      'velocity': velocity,
      'interpretation': interpretation,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${velocity.toStringAsFixed(8).padLeft(12)}   │ ${interpretation.padRight(37)} │',
    );
  }
  print(
    '└─────────┴─────────────────┴───────────────────────────────────────┘',
  );
  print('');

  // Peak velocity at midpoint
  final peakVelocity = calculateDerivative(defaultCurve, 0.5, 0.001);
  print('Peak velocity at t=0.5: ${peakVelocity.toStringAsFixed(4)}');
  print('This is where the curve transitions fastest');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: ANIMATION EXAMPLES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: ANIMATION EXAMPLES                                     │',
  );
  print(
    '│ Practical applications of ElasticInOutCurve                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Scale animation
  final scaleResults = <Map<String, double>>[];
  print('1. Scale animation (0.8x → 1.2x):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final curveValue = defaultCurve.transform(t);
    final scale = 0.8 + curveValue * 0.4;
    scaleResults.add({'t': t, 'curveValue': curveValue, 'scale': scale});
    print(
      '  t=${t.toStringAsFixed(2)}: curve=${curveValue.toStringAsFixed(4)} → scale=${scale.toStringAsFixed(4)}x',
    );
  }
  print('');

  // Position bounce
  final positionResults = <Map<String, double>>[];
  print('2. Position animation (0 → 100px):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final curveValue = defaultCurve.transform(t);
    final position = curveValue * 100;
    positionResults.add({'t': t, 'position': position});
    print(
      '  t=${t.toStringAsFixed(2)}: position=${position.toStringAsFixed(2)}px',
    );
  }
  print('  Note: Position can go negative at start and >100 at end');
  print('');

  // Rotation animation
  final rotationResults = <Map<String, double>>[];
  print('3. Rotation animation (0° → 360°):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final curveValue = defaultCurve.transform(t);
    final rotation = curveValue * 360;
    rotationResults.add({'t': t, 'rotation': rotation});
    print(
      '  t=${t.toStringAsFixed(2)}: rotation=${rotation.toStringAsFixed(1)}°',
    );
  }
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: BOUNDARY BEHAVIOR
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: BOUNDARY BEHAVIOR                                      │',
  );
  print(
    '│ Values near t=0 and t=1                                           │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Near-zero behavior:');
  for (final t in [0.0, 0.001, 0.01, 0.05, 0.1]) {
    print(
      '  f(${t.toString().padRight(5)}) = ${defaultCurve.transform(t).toStringAsFixed(8)}',
    );
  }
  print('');

  print('Near-one behavior:');
  for (final t in [0.9, 0.95, 0.99, 0.999, 1.0]) {
    print(
      '  f(${t.toString().padRight(5)}) = ${defaultCurve.transform(t).toStringAsFixed(8)}',
    );
  }
  print('');

  // Zero crossings
  print('Zero/One crossing analysis:');
  final crossings = <String, List<double>>{'zero': [], 'one': []};
  double prevValue = defaultCurve.transform(0.0);
  for (var i = 1; i <= 200; i++) {
    final t = i / 200;
    final value = defaultCurve.transform(t);
    if ((prevValue < 0 && value >= 0) || (prevValue >= 0 && value < 0)) {
      crossings['zero']!.add(t);
    }
    if ((prevValue < 1 && value >= 1) || (prevValue >= 1 && value < 1)) {
      crossings['one']!.add(t);
    }
    prevValue = value;
  }
  print(
    '  Zero crossings: ${crossings['zero']!.length} at t ≈ ${crossings['zero']!.map((t) => t.toStringAsFixed(2)).join(', ')}',
  );
  print(
    '  One crossings: ${crossings['one']!.length} at t ≈ ${crossings['one']!.map((t) => t.toStringAsFixed(2)).join(', ')}',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: COMPARISON WITH CURVES.ELASTICINOUT
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: CURVES.ELASTICINOUT COMPARISON                        │',
  );
  print(
    '│ Verifying equivalence with predefined constant                    │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final curvesElasticInOut = Curves.elasticInOut;

  print('Comparison with Curves.elasticInOut:');
  print(
    '┌─────────┬─────────────────────┬─────────────────────┬────────────────┐',
  );
  print(
    '│    t    │ ElasticInOutCurve() │  Curves.elasticInOut│   Difference   │',
  );
  print(
    '├─────────┼─────────────────────┼─────────────────────┼────────────────┤',
  );

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final v1 = defaultCurve.transform(t);
    final v2 = curvesElasticInOut.transform(t);
    final diff = (v1 - v2).abs();
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${v1.toStringAsFixed(12).padLeft(17)}  │  ${v2.toStringAsFixed(12).padLeft(17)}  │  ${diff.toStringAsFixed(12).padLeft(12)}  │',
    );
  }
  print(
    '└─────────┴─────────────────────┴─────────────────────┴────────────────┘',
  );
  print('');
  print('✓ ElasticInOutCurve() is equivalent to Curves.elasticInOut');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║               ELASTICINOUTCURVE SUMMARY                           ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('ElasticInOutCurve key features:');
  print('  • Spring effect at BOTH start and end');
  print('  • Values can go below 0 AND above 1');
  print('  • Point symmetric around (0.5, 0.5)');
  print('  • f(t) + f(1-t) = 1.0');
  print('  • Maximum velocity at t=0.5');
  print('');
  print('Best use cases:');
  print('  • Modal dialogs that spring into view');
  print('  • Attention-grabbing animations');
  print('  • Playful UI transitions');
  print('');
  print('Cautions:');
  print('  • Clamp values for bounded properties');
  print('  • May feel too playful for professional UIs');
  print('  • Performance with very small periods');
  print('');
  print('ElasticInOutCurve Deep Demo completed');

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
                colors: [Color(0xFF5E35B1), Color(0xFF7E57C2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'ElasticInOutCurve',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Spring Animation at Both Boundaries',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFD1C4E9)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Symmetry Verification Section
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFEDE7F6),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SYMMETRY: f(t) + f(1-t) = 1.0',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5E35B1),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...symmetryResults.map(
                  (r) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: Text(
                            't=${(r['t'] as double).toStringAsFixed(1)}',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'f(t)=${(r['ft'] as double).toStringAsFixed(4)}',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'f(1-t)=${(r['f1t'] as double).toStringAsFixed(4)}',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: ((r['sum'] as double) - 1.0).abs() < 0.0001
                                ? Color(0xFF4CAF50)
                                : Color(0xFFFF5722),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Σ=${(r['sum'] as double).toStringAsFixed(4)}',
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xFFFFFFFF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Transform Values
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFF5F5F5),
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Color(0xFFE0E0E0)),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TRANSFORM VALUES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF424242),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...defaultResults
                    .where(
                      (r) =>
                          [0.0, 0.2, 0.4, 0.5, 0.6, 0.8, 1.0].contains(r['t']),
                    )
                    .map(
                      (r) => _buildValueRow(
                        't=${(r['t'] as double).toStringAsFixed(2)}',
                        r['value'] as double,
                      ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Range Warning
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFEBEE),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.warning_amber,
                      color: Color(0xFFC62828),
                      size: 20,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'VALUE RANGE WARNING',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFC62828),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                ...rangeAnalysis
                    .take(3)
                    .map(
                      (r) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                'p=${(r['period'] as double).toStringAsFixed(1)}',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFFEF5350),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Min: ${(r['min'] as double).toStringAsFixed(3)}',
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(0xFF4CAF50),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      'Max: ${(r['max'] as double).toStringAsFixed(3)}',
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontSize: 10,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                SizedBox(height: 8),
                Text(
                  'Values go BELOW 0 at start and ABOVE 1 at end!',
                  style: TextStyle(
                    fontSize: 11,
                    color: Color(0xFF795548),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Elastic Family Comparison
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
                  'ELASTIC FAMILY AT t=0.5',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildFamilyCard(
                      'ElasticIn',
                      elasticIn.transform(0.5),
                      Color(0xFF00897B),
                    ),
                    _buildFamilyCard(
                      'ElasticOut',
                      elasticOut.transform(0.5),
                      Color(0xFF1565C0),
                    ),
                    _buildFamilyCard(
                      'ElasticInOut',
                      elasticInOut.transform(0.5),
                      Color(0xFF7B1FA2),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Velocity Analysis
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
                  'VELOCITY PROFILE',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Peak velocity: ${peakVelocity.toStringAsFixed(2)} at t=0.5',
                  style: TextStyle(fontSize: 11, color: Color(0xFF795548)),
                ),
                SizedBox(height: 12.0),
                ...velocityResults.map(
                  (r) => _buildVelocityRow(
                    't=${(r['t'] as double).toStringAsFixed(2)}',
                    r['velocity'] as double,
                    r['interpretation'] as String,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Animation Examples
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
                  'ANIMATION EXAMPLES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildAnimExample(
                  'Scale (0.8x→1.2x)',
                  '${scaleResults.last['scale']!.toStringAsFixed(3)}x',
                ),
                _buildAnimExample(
                  'Position (0→100px)',
                  '${positionResults.last['position']!.toStringAsFixed(1)}px',
                ),
                _buildAnimExample(
                  'Rotation (0°→360°)',
                  '${rotationResults.last['rotation']!.toStringAsFixed(0)}°',
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Visual Curve
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFECEFF1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'CURVE SHAPE',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF455A64),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 16.0),
                _buildCurveVisualization(defaultCurve),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      't=0 (pull back)',
                      style: TextStyle(fontSize: 10, color: Color(0xFFEF5350)),
                    ),
                    Text(
                      't=0.5 (fastest)',
                      style: TextStyle(fontSize: 10, color: Color(0xFF7B1FA2)),
                    ),
                    Text(
                      't=1 (overshoot)',
                      style: TextStyle(fontSize: 10, color: Color(0xFF4CAF50)),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Key Concepts
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4527A0), Color(0xFF5E35B1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'KEY CONCEPTS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildKeyPoint('Symmetric', 'Point symmetry around (0.5, 0.5)'),
                _buildKeyPoint('Double Effect', 'Spring at both start AND end'),
                _buildKeyPoint('Overshoot', 'Values < 0 and > 1 possible'),
                _buildKeyPoint('Peak at Center', 'Maximum velocity at t=0.5'),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Summary Stats
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
                    _buildSummaryStat('Test Points', '${tValues.length}'),
                    _buildSummaryStat('Period Tests', '${periods.length}'),
                    _buildSummaryStat(
                      'Zero Crossings',
                      '${crossings['zero']!.length}',
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat(
                      'Min Value',
                      rangeAnalysis.first['min'].toStringAsFixed(3),
                    ),
                    _buildSummaryStat(
                      'Max Value',
                      rangeAnalysis.first['max'].toStringAsFixed(3),
                    ),
                    _buildSummaryStat(
                      'Peak Velocity',
                      peakVelocity.toStringAsFixed(1),
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
              'Deep Demo • ElasticInOutCurve • Flutter Animation',
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

Widget _buildValueRow(String label, double value) {
  final isNegative = value < 0;
  final isOvershoot = value > 1.0;
  final normalized = ((value + 0.2) / 1.4).clamp(0.0, 1.0);

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Container(
            height: 18,
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Stack(
              children: [
                // Zero and one markers
                Positioned(
                  left: 0.2 / 1.4 * 200,
                  child: Container(
                    width: 1,
                    height: 18,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
                Positioned(
                  left: 1.2 / 1.4 * 200,
                  child: Container(
                    width: 1,
                    height: 18,
                    color: Color(0xFF9E9E9E),
                  ),
                ),
                // Value bar
                Positioned(
                  left: 0,
                  child: Container(
                    width: normalized * 200,
                    height: 18,
                    decoration: BoxDecoration(
                      color: isNegative
                          ? Color(0xFFEF5350)
                          : (isOvershoot
                                ? Color(0xFF4CAF50)
                                : Color(0xFF7B1FA2)),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          width: 70,
          alignment: Alignment.centerRight,
          child: Text(
            value.toStringAsFixed(4),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 10,
              color: isNegative
                  ? Color(0xFFC62828)
                  : (isOvershoot ? Color(0xFF2E7D32) : Color(0xFF424242)),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFamilyCard(String name, double value, Color color) {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(
          value.toStringAsFixed(4),
          style: TextStyle(
            fontSize: 12,
            fontFamily: 'monospace',
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

Widget _buildVelocityRow(String label, double velocity, String interpretation) {
  final normalizedVelocity = (velocity.abs() / 5).clamp(0.0, 1.0);
  final isBackward = velocity < 0;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Container(
            height: 14,
            decoration: BoxDecoration(
              color: Color(0xFFFFE0B2),
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: normalizedVelocity,
              child: Container(
                decoration: BoxDecoration(
                  color: isBackward ? Color(0xFFEF5350) : Color(0xFFF57C00),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 100,
          alignment: Alignment.centerRight,
          child: Text(
            interpretation,
            style: TextStyle(fontSize: 9, color: Color(0xFF795548)),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAnimExample(String title, String value) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(Icons.play_circle_outline, size: 16, color: Color(0xFF2E7D32)),
        SizedBox(width: 8),
        Expanded(child: Text(title, style: TextStyle(fontSize: 12))),
        Text(
          'Final: $value',
          style: TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2E7D32),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCurveVisualization(Curve curve) {
  return SizedBox(
    height: 80,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(50, (i) {
        final t = i / 49;
        final value = curve.transform(t);
        final normalizedHeight = ((value + 0.15) / 1.3 * 70).clamp(0.0, 80.0);
        final isNegative = value < 0;
        final isOvershoot = value > 1.0;

        return Expanded(
          child: Container(
            height: normalizedHeight,
            margin: EdgeInsets.symmetric(horizontal: 0.5),
            decoration: BoxDecoration(
              color: isNegative
                  ? Color(0xFFEF5350)
                  : (isOvershoot ? Color(0xFF4CAF50) : Color(0xFF7B1FA2)),
              borderRadius: BorderRadius.vertical(top: Radius.circular(1)),
            ),
          ),
        );
      }),
    ),
  );
}

Widget _buildKeyPoint(String title, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: TextStyle(
            color: Color(0xFFB39DDB),
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFFD1C4E9),
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            Text(
              description,
              style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11),
            ),
          ],
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
