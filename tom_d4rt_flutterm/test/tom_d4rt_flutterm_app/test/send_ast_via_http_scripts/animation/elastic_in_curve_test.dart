// D4rt test script: Deep Demo for ElasticInCurve from animation
// ElasticInCurve provides spring-like animation with initial overshoot
// Creates a "pull-back" effect at the start of animations
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                ELASTICINCURVE DEEP DEMO                           ║');
  print('║         Spring-Like Animation with Initial Overshoot              ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: ELASTICINCURVE FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: ELASTICINCURVE FUNDAMENTALS                            │');
  print('│ Understanding elastic spring animation curves                     │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  
  print('ElasticInCurve characteristics:');
  print('  • Oscillates below zero at the start (negative overshoot)');
  print('  • Accelerates toward end with spring-like motion');
  print('  • Period parameter controls oscillation frequency');
  print('  • Default period: 0.4 (standard spring feel)');
  print('  • Output range: Can exceed [0,1] due to overshoot');
  print('');

  // Create default curve
  final defaultCurve = ElasticInCurve();
  print('✓ Created default ElasticInCurve (period: 0.4)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: DEFAULT TRANSFORM BEHAVIOR
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: DEFAULT TRANSFORM BEHAVIOR                             │');
  print('│ Transform values across the full parameter range                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final tValues = <double>[0.0, 0.05, 0.1, 0.15, 0.2, 0.25, 0.3, 0.35, 0.4, 0.45, 0.5, 0.55, 0.6, 0.65, 0.7, 0.75, 0.8, 0.85, 0.9, 0.95, 1.0];
  final defaultResults = <Map<String, dynamic>>[];
  
  print('Default ElasticInCurve transform:');
  print('┌─────────┬─────────────────┬────────────────────────────────────────┐');
  print('│    t    │      value      │   visualization                        │');
  print('├─────────┼─────────────────┼────────────────────────────────────────┤');
  
  for (final t in tValues) {
    final value = defaultCurve.transform(t);
    defaultResults.add({'t': t, 'value': value});
    
    // Create a simple ASCII visualization
    final normalized = ((value + 0.5) * 20).round().clamp(0, 40);
    final bar = '│' + ' ' * math.max(0, normalized - 1) + '*' + ' ' * math.max(0, 39 - normalized);
    print('│  ${t.toStringAsFixed(2)}   │  ${value.toStringAsFixed(8).padLeft(12)}   │$bar│');
  }
  print('└─────────┴─────────────────┴────────────────────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: PERIOD VARIATIONS - Oscillation Frequency
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: PERIOD VARIATIONS                                      │');
  print('│ Effect of period parameter on oscillation                         │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final periods = <double>[0.1, 0.2, 0.4, 0.6, 0.8, 1.0];
  final periodCurves = <double, ElasticInCurve>{};
  final periodResults = <Map<String, dynamic>>[];
  
  for (final period in periods) {
    periodCurves[period] = ElasticInCurve(period);
  }
  
  print('Period comparison at key t values:');
  print('┌─────────┬───────────┬───────────┬───────────┬───────────┬───────────┬───────────┐');
  print('│    t    │  p=0.1    │  p=0.2    │  p=0.4    │  p=0.6    │  p=0.8    │  p=1.0    │');
  print('├─────────┼───────────┼───────────┼───────────┼───────────┼───────────┼───────────┤');
  
  for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]) {
    final values = <double, double>{};
    for (final entry in periodCurves.entries) {
      values[entry.key] = entry.value.transform(t);
    }
    periodResults.add({'t': t, 'values': values});
    print('│  ${t.toStringAsFixed(2)}   │ ${values[0.1]!.toStringAsFixed(4).padLeft(8)} │ ${values[0.2]!.toStringAsFixed(4).padLeft(8)} │ ${values[0.4]!.toStringAsFixed(4).padLeft(8)} │ ${values[0.6]!.toStringAsFixed(4).padLeft(8)} │ ${values[0.8]!.toStringAsFixed(4).padLeft(8)} │ ${values[1.0]!.toStringAsFixed(4).padLeft(8)} │');
  }
  print('└─────────┴───────────┴───────────┴───────────┴───────────┴───────────┴───────────┘');
  print('');

  print('Period effects:');
  print('  • Smaller period → Faster oscillations');
  print('  • Larger period → Slower, more gentle oscillations');
  print('  • Period 0.4 is the standard/default feel');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: VALUE RANGE ANALYSIS - Overshoot Detection
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: VALUE RANGE ANALYSIS                                   │');
  print('│ Understanding overshoot behavior                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  // Find min/max values
  final rangeAnalysis = <Map<String, dynamic>>[];
  
  print('Value range for different periods:');
  print('┌────────────┬──────────────────┬──────────────────┬──────────────────┐');
  print('│   Period   │    Min Value     │    Max Value     │   Range Width    │');
  print('├────────────┼──────────────────┼──────────────────┼──────────────────┤');
  
  for (final period in periods) {
    double minVal = double.infinity;
    double maxVal = double.negativeInfinity;
    
    for (var i = 0; i <= 100; i++) {
      final t = i / 100;
      final v = periodCurves[period]!.transform(t);
      if (v < minVal) minVal = v;
      if (v > maxVal) maxVal = v;
    }
    
    final rangeWidth = maxVal - minVal;
    rangeAnalysis.add({'period': period, 'min': minVal, 'max': maxVal, 'range': rangeWidth});
    print('│    ${period.toStringAsFixed(1)}     │  ${minVal.toStringAsFixed(8).padLeft(14)}  │  ${maxVal.toStringAsFixed(8).padLeft(14)}  │  ${rangeWidth.toStringAsFixed(8).padLeft(14)}  │');
  }
  print('└────────────┴──────────────────┴──────────────────┴──────────────────┘');
  print('');

  print('Key observations:');
  print('  • All ElasticInCurve instances have negative minimum values');
  print('  • Maximum value is always 1.0 (at t=1.0)');
  print('  • Smaller periods create larger negative overshoots');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: COMPARISON WITH ELASTIC FAMILY
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: ELASTIC CURVE FAMILY COMPARISON                        │');
  print('│ ElasticIn vs ElasticOut vs ElasticInOut                           │');
  print('└────────────────────────────────────────────────────────────────────┘');
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
    print('│  ${t.toStringAsFixed(2)}   │  ${vIn.toStringAsFixed(8).padLeft(12)}   │  ${vOut.toStringAsFixed(8).padLeft(12)}   │  ${vInOut.toStringAsFixed(8).padLeft(12)}   │');
  }
  print('└─────────┴─────────────────┴─────────────────┴─────────────────┘');
  print('');

  print('Family behavior summary:');
  print('  • ElasticIn: Slow start with backward oscillation');
  print('  • ElasticOut: Fast start, oscillates past 1.0 at end');
  print('  • ElasticInOut: Oscillates at both ends, smooth middle');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: MATHEMATICAL PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: MATHEMATICAL PROPERTIES                                │');
  print('│ Analysis of curve characteristics                                 │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  // Calculate derivatives (approximate)
  double calculateDerivative(Curve curve, double t, double dt) {
    final low = (t - dt / 2).clamp(0.0, 1.0);
    final high = (t + dt / 2).clamp(0.0, 1.0);
    final actualDt = high - low;
    if (actualDt == 0) return 0;
    return (curve.transform(high) - curve.transform(low)) / actualDt;
  }
  
  final derivativeResults = <Map<String, dynamic>>[];
  
  print('Velocity (dy/dt) at key points:');
  print('┌─────────┬─────────────────┬─────────────────────────────────────────┐');
  print('│    t    │   Velocity      │   Interpretation                        │');
  print('├─────────┼─────────────────┼─────────────────────────────────────────┤');
  
  for (final t in [0.1, 0.25, 0.5, 0.75, 0.9]) {
    final velocity = calculateDerivative(defaultCurve, t, 0.01);
    String interpretation;
    if (velocity < -0.5) interpretation = 'Strong backward motion';
    else if (velocity < 0) interpretation = 'Backward motion';
    else if (velocity < 0.5) interpretation = 'Slow forward motion';
    else if (velocity < 2.0) interpretation = 'Moderate forward';
    else interpretation = 'Rapid acceleration';
    
    derivativeResults.add({'t': t, 'velocity': velocity, 'interpretation': interpretation});
    print('│  ${t.toStringAsFixed(2)}   │  ${velocity.toStringAsFixed(8).padLeft(12)}   │ ${interpretation.padRight(39)} │');
  }
  print('└─────────┴─────────────────┴─────────────────────────────────────────┘');
  print('');

  // Zero crossings
  print('Zero crossing analysis:');
  final zeroCrossings = <double>[];
  double prevValue = defaultCurve.transform(0.0);
  for (var i = 1; i <= 100; i++) {
    final t = i / 100;
    final value = defaultCurve.transform(t);
    if ((prevValue < 0 && value >= 0) || (prevValue >= 0 && value < 0)) {
      zeroCrossings.add(t);
    }
    prevValue = value;
  }
  print('  Zero crossings found: ${zeroCrossings.length}');
  for (final crossing in zeroCrossings) {
    print('  • Crosses zero near t ≈ ${crossing.toStringAsFixed(2)}');
  }
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: ANIMATION USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: ANIMATION USE CASES                                    │');
  print('│ Practical applications of ElasticInCurve                          │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  // Scale animation example
  print('1. Scale animation (0.5x → 1.5x):');
  final scaleBase = 0.5;
  final scaleRange = 1.0;
  final scaleResults = <Map<String, double>>[];
  
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final curveValue = defaultCurve.transform(t);
    final scale = scaleBase + curveValue * scaleRange;
    scaleResults.add({'t': t, 'curveValue': curveValue, 'scale': scale});
    print('  t=${t.toStringAsFixed(2)}: curve=${curveValue.toStringAsFixed(4)} → scale=${scale.toStringAsFixed(4)}x');
  }
  print('');

  // Position animation example
  print('2. Position animation (0 → 200 px):');
  final positionResults = <Map<String, double>>[];
  
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final curveValue = defaultCurve.transform(t);
    final position = curveValue * 200;
    positionResults.add({'t': t, 'position': position});
    print('  t=${t.toStringAsFixed(2)}: position=${position.toStringAsFixed(2)} px');
  }
  print('  Note: Negative positions mean "pulling back" effect');
  print('');

  // Opacity animation (clamped)
  print('3. Opacity animation (clamped to 0-1):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final curveValue = defaultCurve.transform(t);
    final rawOpacity = curveValue;
    final clampedOpacity = curveValue.clamp(0.0, 1.0);
    print('  t=${t.toStringAsFixed(2)}: raw=${rawOpacity.toStringAsFixed(4)} → clamped=${clampedOpacity.toStringAsFixed(4)}');
  }
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: BOUNDARY VALUES AND EDGE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: BOUNDARY VALUES                                        │');
  print('│ Edge cases and boundary behavior                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Exact boundary values:');
  print('  transform(0.0) = ${defaultCurve.transform(0.0).toStringAsFixed(12)}');
  print('  transform(1.0) = ${defaultCurve.transform(1.0).toStringAsFixed(12)}');
  print('');

  print('Near-boundary behavior:');
  for (final t in [0.001, 0.01, 0.99, 0.999]) {
    print('  transform(${t.toString().padRight(5)}) = ${defaultCurve.transform(t).toStringAsFixed(8)}');
  }
  print('');

  // Extreme periods
  print('Extreme period values:');
  final veryTight = ElasticInCurve(0.05);
  final veryWide = ElasticInCurve(2.0);
  print('  period=0.05 at t=0.5: ${veryTight.transform(0.5).toStringAsFixed(6)}');
  print('  period=2.0 at t=0.5:  ${veryWide.transform(0.5).toStringAsFixed(6)}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: CURVE SMOOTHNESS ANALYSIS  
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: CURVE SMOOTHNESS ANALYSIS                              │');
  print('│ Continuity and smoothness verification                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  // Check for continuity
  double maxJump = 0;
  double prevVal = defaultCurve.transform(0.0);
  for (var i = 1; i <= 1000; i++) {
    final t = i / 1000;
    final val = defaultCurve.transform(t);
    final jump = (val - prevVal).abs();
    if (jump > maxJump) maxJump = jump;
    prevVal = val;
  }
  
  print('Continuity check (1000 samples):');
  print('  Maximum step change: ${maxJump.toStringAsFixed(8)}');
  print('  Step change per 0.001: ${(maxJump).toStringAsFixed(8)}');
  print('  ${maxJump < 0.1 ? "✓ Curve is continuous (no jumps)" : "⚠ Large jumps detected"}');
  print('');

  // Second derivative (acceleration smoothness)
  print('Acceleration smoothness (second derivative):');
  for (final t in [0.1, 0.5, 0.9]) {
    final d1 = calculateDerivative(defaultCurve, t - 0.01, 0.01);
    final d2 = calculateDerivative(defaultCurve, t + 0.01, 0.01);
    final acceleration = (d2 - d1) / 0.02;
    print('  t=${t.toStringAsFixed(1)}: acceleration ≈ ${acceleration.toStringAsFixed(4)}');
  }
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: CURVES.ELASTICIN EQUIVALENCE
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: CURVES.ELASTICIN EQUIVALENCE                          │');
  print('│ Comparing with the predefined constant                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final curvesElasticIn = Curves.elasticIn;
  
  print('Comparison with Curves.elasticIn:');
  print('┌─────────┬─────────────────────┬─────────────────────┬────────────────┐');
  print('│    t    │   ElasticInCurve()  │   Curves.elasticIn  │   Difference   │');
  print('├─────────┼─────────────────────┼─────────────────────┼────────────────┤');
  
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final v1 = defaultCurve.transform(t);
    final v2 = curvesElasticIn.transform(t);
    final diff = (v1 - v2).abs();
    print('│  ${t.toStringAsFixed(2)}   │  ${v1.toStringAsFixed(12).padLeft(17)}  │  ${v2.toStringAsFixed(12).padLeft(17)}  │  ${diff.toStringAsFixed(12).padLeft(12)}  │');
  }
  print('└─────────┴─────────────────────┴─────────────────────┴────────────────┘');
  print('');
  print('✓ ElasticInCurve() is equivalent to Curves.elasticIn');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                ELASTICINCURVE SUMMARY                             ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');
  print('ElasticInCurve key features:');
  print('  • Creates spring-like "pull-back" effect at animation start');
  print('  • Values can go negative (below zero)');
  print('  • Period parameter controls oscillation frequency');
  print('  • Equivalent to Curves.elasticIn when using default period');
  print('');
  print('Best use cases:');
  print('  • Scale animations with dramatic entrance');
  print('  • Position animations where pullback is desired');
  print('  • Combined with CurveTween for timing control');
  print('');
  print('Cautions:');
  print('  • Clamp values when used for opacity (0-1 range)');
  print('  • Consider performance with very small periods');
  print('  • May need adjustment for accessibility');
  print('');
  print('ElasticInCurve Deep Demo completed');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY - Comprehensive UI Layout
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
                colors: [Color(0xFF00695C), Color(0xFF00897B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'ElasticInCurve',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Spring-Like Animation with Initial Overshoot',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFFB2DFDB),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Transform Values Section
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
                  'DEFAULT TRANSFORM VALUES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00695C),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...defaultResults.where((r) => [0.0, 0.2, 0.4, 0.6, 0.8, 1.0].contains(r['t'])).map((r) => _buildTransformRow(
                  't=${(r['t'] as double).toStringAsFixed(2)}',
                  r['value'] as double,
                  Color(0xFF00897B),
                )),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Period Comparison Section
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
                  'PERIOD COMPARISON AT t=0.5',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF424242),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...periods.map((period) {
                  final value = periodCurves[period]!.transform(0.5);
                  return _buildPeriodRow(period, value);
                }),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Range Analysis Section
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
                    Icon(Icons.warning_amber, color: Color(0xFFC62828), size: 20),
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
                ...rangeAnalysis.take(3).map((r) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Container(
                        width: 70,
                        child: Text(
                          'p=${(r['period'] as double).toStringAsFixed(1)}',
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Min: ${(r['min'] as double).toStringAsFixed(4)}',
                          style: TextStyle(
                            color: Color(0xFFC62828),
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Max: ${(r['max'] as double).toStringAsFixed(4)}',
                          style: TextStyle(
                            color: Color(0xFF2E7D32),
                            fontFamily: 'monospace',
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
                SizedBox(height: 8),
                Text(
                  '⚠ Values can be negative! Clamp for opacity/color animations.',
                  style: TextStyle(fontSize: 11, color: Color(0xFF795548), fontStyle: FontStyle.italic),
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
                  'ELASTIC CURVE FAMILY',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...familyResults.where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t'])).map((r) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        child: Text(
                          't=${(r['t'] as double).toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
                        ),
                      ),
                      _buildFamilyValue('In', r['in'] as double, Color(0xFF00897B)),
                      SizedBox(width: 4),
                      _buildFamilyValue('Out', r['out'] as double, Color(0xFF1565C0)),
                      SizedBox(width: 4),
                      _buildFamilyValue('IO', r['inOut'] as double, Color(0xFF7B1FA2)),
                    ],
                  ),
                )),
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
                  'VELOCITY ANALYSIS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...derivativeResults.map((r) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        child: Text(
                          't=${(r['t'] as double).toStringAsFixed(2)}',
                          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11),
                        ),
                      ),
                      Container(
                        width: 80,
                        child: Text(
                          'v=${(r['velocity'] as double).toStringAsFixed(3)}',
                          style: TextStyle(fontFamily: 'monospace', fontSize: 11),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          r['interpretation'] as String,
                          style: TextStyle(fontSize: 10, color: Color(0xFF795548)),
                        ),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Use Cases Section
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
                  'PRACTICAL USE CASES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildUseCaseItem('Scale Animation', 'pullback-then-grow', Color(0xFF7B1FA2)),
                _buildUseCaseItem('Position Animation', 'slide with elastic start', Color(0xFF7B1FA2)),
                _buildUseCaseItem('Rotation', 'wind-up then spin', Color(0xFF7B1FA2)),
                _buildUseCaseItem('Combined Effects', 'chain with CurveTween', Color(0xFF7B1FA2)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Visual Curve Display
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
                  'CURVE VISUALIZATION',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF455A64),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 16.0),
                _buildCurveVisualization(defaultCurve),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Key Concepts
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF004D40), Color(0xFF00695C)],
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
                  'KEY TAKEAWAYS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildKeyPoint('Negative values', 'Curve can return values < 0'),
                _buildKeyPoint('Period control', 'Smaller = faster oscillations'),
                _buildKeyPoint('Start effect', 'Pull-back at animation beginning'),
                _buildKeyPoint('Clamping', 'Required for 0-1 bounded properties'),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Summary Statistics
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
                    _buildSummaryStat('Zero Crossings', '${zeroCrossings.length}'),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat('Min Value', rangeAnalysis.first['min'].toStringAsFixed(3)),
                    _buildSummaryStat('Default Period', '0.4'),
                    _buildSummaryStat('Family Curves', '3'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),

          // Footer
          Center(
            child: Text(
              'Deep Demo • ElasticInCurve • Flutter Animation',
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

Widget _buildTransformRow(String label, double value, Color color) {
  final normalizedValue = ((value + 0.5) / 1.5).clamp(0.0, 1.0);
  final isNegative = value < 0;
  
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(width: 60, child: Text(label, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12))),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFB2DFDB),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // Zero line indicator
              Positioned(
                left: 0.5 / 1.5 * 200, // Adjust based on container width
                child: Container(
                  width: 2,
                  height: 20,
                  color: Color(0xFF004D40),
                ),
              ),
              Positioned(
                left: 0,
                child: Container(
                  width: normalizedValue * 200,
                  height: 20,
                  decoration: BoxDecoration(
                    color: isNegative ? Color(0xFFEF5350) : color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 80,
          alignment: Alignment.centerRight,
          child: Text(
            value.toStringAsFixed(4),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              color: isNegative ? Color(0xFFC62828) : Color(0xFF2E7D32),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildPeriodRow(double period, double value) {
  final isNegative = value < 0;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 70,
          child: Text(
            'p=${period.toStringAsFixed(1)}',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ),
        Expanded(
          child: Container(
            height: 16,
            decoration: BoxDecoration(
              color: Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(3),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: ((value + 0.3) / 1.3).clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: isNegative ? Color(0xFFEF5350) : Color(0xFF00897B),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 70,
          alignment: Alignment.centerRight,
          child: Text(
            value.toStringAsFixed(4),
            style: TextStyle(fontFamily: 'monospace', fontSize: 10),
          ),
        ),
      ],
    ),
  );
}

Widget _buildFamilyValue(String label, double value, Color color) {
  return Expanded(
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Text(label, style: TextStyle(fontSize: 9, color: color, fontWeight: FontWeight.bold)),
          Text(
            value.toStringAsFixed(3),
            style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
          ),
        ],
      ),
    ),
  );
}

Widget _buildUseCaseItem(String title, String description, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(Icons.check_circle, size: 16, color: color),
        SizedBox(width: 8),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(fontSize: 12, color: Color(0xFF424242)),
              children: [
                TextSpan(text: '$title: ', style: TextStyle(fontWeight: FontWeight.bold)),
                TextSpan(text: description),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCurveVisualization(Curve curve) {
  return Container(
    height: 100,
    child: Row(
      children: List.generate(40, (i) {
        final t = i / 39;
        final value = curve.transform(t);
        final normalizedHeight = ((value + 0.3) / 1.3 * 80).clamp(0.0, 100.0);
        return Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: normalizedHeight,
                margin: EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: value < 0 ? Color(0xFFEF5350) : Color(0xFF00897B),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(2)),
                ),
              ),
            ],
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
        Text('• ', style: TextStyle(color: Color(0xFF80CBC4), fontWeight: FontWeight.bold)),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: TextStyle(color: Color(0xFFB2DFDB), fontWeight: FontWeight.bold, fontSize: 12)),
            Text(description, style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 11)),
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
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4DD0E1),
        ),
      ),
      Text(
        label,
        style: TextStyle(
          fontSize: 10.0,
          color: Color(0xFF90A4AE),
        ),
      ),
    ],
  );
}
