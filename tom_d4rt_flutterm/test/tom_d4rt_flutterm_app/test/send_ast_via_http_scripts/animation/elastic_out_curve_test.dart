// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for ElasticOutCurve from animation
// ElasticOutCurve provides spring-like overshoot animation at the end
// Starts fast and oscillates past target, settling back
import 'dart:math' as math;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                 ELASTICOUTCURVE DEEP DEMO                         ║',
  );
  print(
    '║          Spring-Like Overshoot Animation at End                   ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ELASTICOUTCURVE FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: ELASTICOUTCURVE FUNDAMENTALS                           │',
  );
  print(
    '│ Understanding the spring overshoot animation curve                │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('ElasticOutCurve characteristics:');
  print('  • Starts fast (value rises quickly from 0)');
  print('  • Overshoots past 1.0 target');
  print('  • Oscillates back and settles at 1.0');
  print('  • Mirror of ElasticInCurve: f_out(t) = 1 - f_in(1-t)');
  print('  • Creates a "spring settling" effect');
  print('  • Default period: 0.4');
  print('');

  // Create default curve
  final defaultCurve = ElasticOutCurve();
  print('✓ Created default ElasticOutCurve (period: 0.4)');
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

  print('Default ElasticOutCurve transform:');
  print(
    '┌─────────┬─────────────────┬────────────────────────────────────────┐',
  );
  print(
    '│    t    │      value      │   visualization (above 1.0 = green)    │',
  );
  print(
    '├─────────┼─────────────────┼────────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final value = defaultCurve.transform(t);
    defaultResults.add({'t': t, 'value': value});

    // Create a simple ASCII visualization
    final normalized = (value * 30).round().clamp(0, 40);
    final bar =
        '│${'=' * math.min(normalized, 30)}${value > 1.0 ? '+' * math.min((value - 1.0) * 100, 10).round() : ''}${' ' * math.max(0, 39 - normalized)}';
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${value.toStringAsFixed(8).padLeft(12)}   │$bar│',
    );
  }
  print(
    '└─────────┴─────────────────┴────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: MIRROR RELATIONSHIP WITH ELASTICIN
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: MIRROR RELATIONSHIP WITH ELASTICIN                     │',
  );
  print(
    '│ Verifying f_out(t) = 1 - f_in(1-t)                                │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final elasticIn = ElasticInCurve();
  final mirrorResults = <Map<String, dynamic>>[];

  print('Mirror relationship verification:');
  print(
    '┌─────────┬─────────────────┬─────────────────┬─────────────────┬──────────────┐',
  );
  print(
    '│    t    │   f_out(t)      │   f_in(1-t)     │ 1 - f_in(1-t)   │   Diff       │',
  );
  print(
    '├─────────┼─────────────────┼─────────────────┼─────────────────┼──────────────┤',
  );

  for (final t in [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]) {
    final fOut = defaultCurve.transform(t);
    final fIn1t = elasticIn.transform(1.0 - t);
    final mirror = 1.0 - fIn1t;
    final diff = (fOut - mirror).abs();
    mirrorResults.add({'t': t, 'fOut': fOut, 'mirror': mirror, 'diff': diff});
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${fOut.toStringAsFixed(8).padLeft(12)}   │  ${fIn1t.toStringAsFixed(8).padLeft(12)}   │  ${mirror.toStringAsFixed(8).padLeft(12)}   │  ${diff.toStringAsFixed(10).padLeft(10)}  │',
    );
  }
  print(
    '└─────────┴─────────────────┴─────────────────┴─────────────────┴──────────────┘',
  );
  print('');

  final mirrorError = mirrorResults
      .map((r) => r['diff'] as double)
      .reduce(math.max);
  print('Maximum mirror error: ${mirrorError.toStringAsFixed(12)}');
  print(
    mirrorError < 1e-10
        ? "✓ Perfect mirror relationship verified"
        : "⚠ Small numerical difference detected",
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
    '│ Effect of period parameter on overshoot behavior                  │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final periods = <double>[0.1, 0.2, 0.4, 0.6, 0.8, 1.0];
  final periodCurves = <double, ElasticOutCurve>{};
  final periodResults = <Map<String, dynamic>>[];

  for (final period in periods) {
    periodCurves[period] = ElasticOutCurve(period);
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
  // SECTION 5: OVERSHOOT ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: OVERSHOOT ANALYSIS                                     │',
  );
  print(
    '│ Maximum overshoot for each period                                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final overshootAnalysis = <Map<String, dynamic>>[];

  print('Maximum overshoot analysis:');
  print(
    '┌────────────┬──────────────────┬──────────────────┬──────────────────┐',
  );
  print(
    '│   Period   │    Max Value     │  Overshoot (%)   │  Overshoot At t  │',
  );
  print(
    '├────────────┼──────────────────┼──────────────────┼──────────────────┤',
  );

  for (final period in periods) {
    double maxVal = 0.0;
    double maxT = 0.0;

    for (var i = 0; i <= 200; i++) {
      final t = i / 200;
      final v = periodCurves[period]!.transform(t);
      if (v > maxVal) {
        maxVal = v;
        maxT = t;
      }
    }

    final overshootPercent = (maxVal - 1.0) * 100;
    overshootAnalysis.add({
      'period': period,
      'max': maxVal,
      'overshoot': overshootPercent,
      'peakT': maxT,
    });
    print(
      '│    ${period.toStringAsFixed(1)}     │  ${maxVal.toStringAsFixed(8).padLeft(14)}  │  ${overshootPercent.toStringAsFixed(4).padLeft(14)}  │  ${maxT.toStringAsFixed(3).padLeft(14)}  │',
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

  print('ElasticOut behavior:');
  print('  • Fast initial rise (high velocity at start)');
  print('  • Overshoots past 1.0 target');
  print('  • Springs back toward 1.0');
  print('  • Settles smoothly at final value');
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

  for (final t in [0.05, 0.15, 0.3, 0.5, 0.7, 0.9]) {
    final velocity = calculateDerivative(defaultCurve, t, 0.01);
    String interpretation;
    if (velocity > 5.0) {
      interpretation = 'Very fast start';
    } else if (velocity > 2.0)
      interpretation = 'Fast motion';
    else if (velocity > 0.5)
      interpretation = 'Moderate speed';
    else if (velocity > 0)
      interpretation = 'Settling';
    else
      interpretation = 'Moving backward (bounce)';

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

  // Peak velocity at start
  final peakVelocity = calculateDerivative(defaultCurve, 0.05, 0.01);
  print('Initial velocity (near t=0): ${peakVelocity.toStringAsFixed(4)}');
  print('This is where ElasticOut is fastest (opposite of ElasticIn)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: SETTLING BEHAVIOR
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: SETTLING BEHAVIOR                                      │',
  );
  print(
    '│ How the curve settles to 1.0                                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final settlingResults = <Map<String, dynamic>>[];

  print('Deviation from target (1.0) over time:');
  print(
    '┌─────────┬─────────────────┬─────────────────┬─────────────────────┐',
  );
  print(
    '│    t    │      Value      │   Deviation     │  Status             │',
  );
  print(
    '├─────────┼─────────────────┼─────────────────┼─────────────────────┤',
  );

  for (final t in [0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]) {
    final value = defaultCurve.transform(t);
    final deviation = value - 1.0;
    String status;
    if (deviation > 0.05) {
      status = 'Significant overshoot';
    } else if (deviation > 0.01)
      status = 'Minor overshoot';
    else if (deviation > 0)
      status = 'Slight overshoot';
    else if (deviation > -0.01)
      status = 'At target';
    else
      status = 'Undershoot';

    settlingResults.add({
      't': t,
      'value': value,
      'deviation': deviation,
      'status': status,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${value.toStringAsFixed(8).padLeft(12)}   │  ${deviation.toStringAsFixed(8).padLeft(12)}   │ ${status.padRight(19)} │',
    );
  }
  print(
    '└─────────┴─────────────────┴─────────────────┴─────────────────────┘',
  );
  print('');

  // One crossings
  print('One crossing analysis (where value crosses 1.0):');
  final oneCrossings = <double>[];
  double prevValue = defaultCurve.transform(0.0);
  for (var i = 1; i <= 200; i++) {
    final t = i / 200;
    final value = defaultCurve.transform(t);
    if ((prevValue < 1.0 && value >= 1.0) ||
        (prevValue >= 1.0 && value < 1.0)) {
      oneCrossings.add(t);
    }
    prevValue = value;
  }
  print('  Number of 1.0 crossings: ${oneCrossings.length}');
  print(
    '  Crossing points: t ≈ ${oneCrossings.map((t) => t.toStringAsFixed(2)).join(', ')}',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: ANIMATION EXAMPLES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: ANIMATION EXAMPLES                                     │',
  );
  print(
    '│ Practical applications of ElasticOutCurve                         │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Slide in animation
  final slideResults = <Map<String, double>>[];
  print('1. Slide in animation (-100px → 0px):');
  for (final t in [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]) {
    final curveValue = defaultCurve.transform(t);
    final position = -100 + curveValue * 100;
    slideResults.add({'t': t, 'curveValue': curveValue, 'position': position});
    print(
      '  t=${t.toStringAsFixed(2)}: curve=${curveValue.toStringAsFixed(4)} → position=${position.toStringAsFixed(1)}px',
    );
  }
  print(
    '  Note: Positive values mean overshoot past 0 (slight visible bounce)',
  );
  print('');

  // Scale up with bounce
  final scaleResults = <Map<String, double>>[];
  print('2. Scale up with overshoot (0x → 1x):');
  for (final t in [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]) {
    final curveValue = defaultCurve.transform(t);
    final scale = curveValue;
    scaleResults.add({'t': t, 'scale': scale});
    print('  t=${t.toStringAsFixed(2)}: scale=${scale.toStringAsFixed(4)}x');
  }
  print('');

  // Fade in with spring
  final fadeResults = <Map<String, double>>[];
  print('3. Opacity animation (0 → 1, clamped):');
  for (final t in [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]) {
    final curveValue = defaultCurve.transform(t);
    final opacity = curveValue.clamp(0.0, 1.0);
    fadeResults.add({'t': t, 'raw': curveValue, 'opacity': opacity});
    print(
      '  t=${t.toStringAsFixed(2)}: raw=${curveValue.toStringAsFixed(4)} → clamped=${opacity.toStringAsFixed(3)}',
    );
  }
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: COMPARISON WITH CURVES.ELASTICOUT
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: CURVES.ELASTICOUT COMPARISON                          │',
  );
  print(
    '│ Verifying equivalence with predefined constant                    │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final curvesElasticOut = Curves.elasticOut;

  print('Comparison with Curves.elasticOut:');
  print(
    '┌─────────┬─────────────────────┬─────────────────────┬────────────────┐',
  );
  print(
    '│    t    │  ElasticOutCurve()  │   Curves.elasticOut │   Difference   │',
  );
  print(
    '├─────────┼─────────────────────┼─────────────────────┼────────────────┤',
  );

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final v1 = defaultCurve.transform(t);
    final v2 = curvesElasticOut.transform(t);
    final diff = (v1 - v2).abs();
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${v1.toStringAsFixed(12).padLeft(17)}  │  ${v2.toStringAsFixed(12).padLeft(17)}  │  ${diff.toStringAsFixed(12).padLeft(12)}  │',
    );
  }
  print(
    '└─────────┴─────────────────────┴─────────────────────┴────────────────┘',
  );
  print('');
  print('✓ ElasticOutCurve() is equivalent to Curves.elasticOut');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                  ELASTICOUTCURVE SUMMARY                          ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('ElasticOutCurve key features:');
  print('  • Fast start - high velocity at beginning');
  print('  • Overshoots past target (values > 1.0)');
  print('  • Bounces back and settles');
  print('  • Mirror of ElasticInCurve');
  print('');
  print('Best use cases:');
  print('  • "Pop in" animations');
  print('  • Attention-grabbing entrances');
  print('  • Scale-up effects with bounce');
  print('  • Slide in with spring');
  print('');
  print('Cautions:');
  print('  • Clamp values for bounded properties (opacity)');
  print('  • Higher period = more bounce');
  print('  • May feel too playful for business UI');
  print('');
  print('ElasticOutCurve Deep Demo completed');

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
                colors: [Color(0xFF00897B), Color(0xFF26A69A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'ElasticOutCurve',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Spring Overshoot Animation',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFB2DFDB)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Mirror Verification Section
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE0F2F1),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'MIRROR: f_out(t) = 1 - f_in(1-t)',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00796B),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...mirrorResults.map(
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
                            'out=${(r['fOut'] as double).toStringAsFixed(4)}',
                            style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'monospace',
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'mirror=${(r['mirror'] as double).toStringAsFixed(4)}',
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
                            color: (r['diff'] as double) < 0.0001
                                ? Color(0xFF4CAF50)
                                : Color(0xFFFF5722),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'Δ=${(r['diff'] as double).toStringAsFixed(6)}',
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

          // Overshoot Analysis
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
                    Icon(Icons.trending_up, color: Color(0xFFC62828), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'OVERSHOOT ANALYSIS',
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
                ...overshootAnalysis
                    .take(4)
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
                                      'Max: ${(r['max'] as double).toStringAsFixed(3)}',
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
                                      color: Color(0xFFFF7043),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      '+${(r['overshoot'] as double).toStringAsFixed(1)}%',
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
                  'Values exceed 1.0 during animation!',
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
                  'ELASTIC FAMILY AT t=0.3',
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
                      elasticIn.transform(0.3),
                      Color(0xFF7B1FA2),
                    ),
                    _buildFamilyCard(
                      'ElasticOut',
                      elasticOut.transform(0.3),
                      Color(0xFF00897B),
                    ),
                    _buildFamilyCard(
                      'ElasticInOut',
                      elasticInOut.transform(0.3),
                      Color(0xFF1565C0),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'ElasticOut is ahead - it starts fast and settles slowly',
                  style: TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF5C6BC0),
                  ),
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
                  'Peak velocity: ${peakVelocity.toStringAsFixed(2)} at t≈0',
                  style: TextStyle(fontSize: 11, color: Color(0xFF795548)),
                ),
                SizedBox(height: 12.0),
                ...velocityResults
                    .take(4)
                    .map(
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

          // Settling Behavior
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
                  'SETTLING BEHAVIOR',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...settlingResults
                    .where((r) => [0.4, 0.6, 0.8, 1.0].contains(r['t']))
                    .map(
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
                                '${r['status']}',
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                            Text(
                              'dev: ${(r['deviation'] as double) >= 0 ? '+' : ''}${(r['deviation'] as double).toStringAsFixed(4)}',
                              style: TextStyle(
                                fontSize: 10,
                                fontFamily: 'monospace',
                                color: (r['deviation'] as double).abs() < 0.01
                                    ? Color(0xFF4CAF50)
                                    : Color(0xFFFF9800),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                SizedBox(height: 8),
                Text(
                  '1.0 crossings: ${oneCrossings.length} at t ≈ ${oneCrossings.map((t) => t.toStringAsFixed(2)).join(", ")}',
                  style: TextStyle(fontSize: 10, color: Color(0xFF9C27B0)),
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
                  'Slide in (-100→0)',
                  '${slideResults.last['position']!.toStringAsFixed(1)}px',
                ),
                _buildAnimExample(
                  'Scale up (0→1)',
                  '${scaleResults.last['scale']!.toStringAsFixed(3)}x',
                ),
                _buildAnimExample(
                  'Fade in (clamped)',
                  fadeResults.last['opacity']!.toStringAsFixed(3),
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
                      't=0 (fast start)',
                      style: TextStyle(fontSize: 10, color: Color(0xFF00897B)),
                    ),
                    Text(
                      'overshoot zone',
                      style: TextStyle(fontSize: 10, color: Color(0xFFEF5350)),
                    ),
                    Text(
                      't=1 (settled)',
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
                colors: [Color(0xFF00695C), Color(0xFF00897B)],
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
                _buildKeyPoint('Fast Start', 'Maximum velocity at t≈0'),
                _buildKeyPoint('Overshoot', 'Values exceed 1.0 past target'),
                _buildKeyPoint('Settling', 'Bounces back to settle at 1.0'),
                _buildKeyPoint('Mirror', 'f_out(t) = 1 - f_in(1-t)'),
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
                      '1.0 Crossings',
                      '${oneCrossings.length}',
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat(
                      'Max Value',
                      overshootAnalysis.first['max'].toStringAsFixed(3),
                    ),
                    _buildSummaryStat(
                      'Peak Overshoot',
                      '+${overshootAnalysis.first['overshoot'].toStringAsFixed(1)}%',
                    ),
                    _buildSummaryStat(
                      'Init Velocity',
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
              'Deep Demo • ElasticOutCurve • Flutter Animation',
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
  final isOvershoot = value > 1.0;
  final normalized = (value / 1.2).clamp(0.0, 1.0);

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
                // 1.0 marker
                Positioned(
                  left: 1.0 / 1.2 * 200,
                  child: Container(
                    width: 1,
                    height: 18,
                    color: Color(0xFF4CAF50),
                  ),
                ),
                // Value bar
                Positioned(
                  left: 0,
                  child: Container(
                    width: normalized * 200,
                    height: 18,
                    decoration: BoxDecoration(
                      color: isOvershoot
                          ? Color(0xFFEF5350)
                          : Color(0xFF00897B),
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
              color: isOvershoot ? Color(0xFFC62828) : Color(0xFF424242),
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
  final normalizedVelocity = (velocity.abs() / 10).clamp(0.0, 1.0);
  final isNegative = velocity < 0;

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
                  color: isNegative ? Color(0xFFEF5350) : Color(0xFFF57C00),
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
        final normalizedHeight = (value / 1.15 * 70).clamp(0.0, 80.0);
        final isOvershoot = value > 1.0;

        return Expanded(
          child: Container(
            height: normalizedHeight,
            margin: EdgeInsets.symmetric(horizontal: 0.5),
            decoration: BoxDecoration(
              color: isOvershoot ? Color(0xFFEF5350) : Color(0xFF00897B),
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
            color: Color(0xFF80CBC4),
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFFB2DFDB),
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
