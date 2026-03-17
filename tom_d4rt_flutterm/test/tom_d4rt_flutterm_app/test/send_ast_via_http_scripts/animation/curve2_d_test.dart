// D4rt test script: Deep Demo for Curve2D from animation
// Curve2D is an abstract class representing 2D parametric curves
// This comprehensive test exercises curve behavior through its concrete implementation
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                    CURVE2D DEEP DEMO                              ║',
  );
  print(
    '║           Abstract 2D Parametric Curve Interface                  ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CURVE2D FUNDAMENTALS - Abstract Interface Overview
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: CURVE2D FUNDAMENTALS                                   │',
  );
  print(
    '│ Understanding the abstract 2D curve interface                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Curve2D is abstract - we use CatmullRomSpline as concrete implementation
  print('• Curve2D is an abstract class defining the contract for 2D curves');
  print('• Key method: transform(t) maps t ∈ [0,1] to Offset(x, y)');
  print('• Unlike 1D Curve which maps t → double, Curve2D maps t → Offset');
  print('• Primary implementations: CatmullRomSpline');
  print('');

  // Create our primary test curve - a simple arc shape
  final basicCurve = CatmullRomSpline([
    Offset(0.0, 0.0),
    Offset(0.25, 0.5),
    Offset(0.5, 0.75),
    Offset(0.75, 0.5),
    Offset(1.0, 0.0),
  ]);
  print('✓ Created basic CatmullRomSpline as Curve2D implementation');
  print(
    '  Control points: (0,0) → (0.25,0.5) → (0.5,0.75) → (0.75,0.5) → (1,0)',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: TRANSFORM METHOD - Core Curve Evaluation
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: TRANSFORM METHOD                                       │',
  );
  print(
    '│ Evaluating curve positions at parameter t                         │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Test transform at various t values
  final transformTests = <double>[
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
  final transformResults = <Map<String, dynamic>>[];

  print('Transform evaluation across parameter space:');
  print('┌─────────┬─────────────────┬─────────────────┬──────────────────┐');
  print('│    t    │       x         │       y         │    magnitude     │');
  print('├─────────┼─────────────────┼─────────────────┼──────────────────┤');

  for (final t in transformTests) {
    final point = basicCurve.transform(t);
    final magnitude = math.sqrt(point.dx * point.dx + point.dy * point.dy);
    transformResults.add({
      't': t,
      'x': point.dx,
      'y': point.dy,
      'magnitude': magnitude,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${point.dx.toStringAsFixed(6).padLeft(12)}  │  ${point.dy.toStringAsFixed(6).padLeft(12)}  │  ${magnitude.toStringAsFixed(6).padLeft(13)} │',
    );
  }
  print('└─────────┴─────────────────┴─────────────────┴──────────────────┘');
  print('');

  // Verify transform properties
  final startPoint = basicCurve.transform(0.0);
  final endPoint = basicCurve.transform(1.0);
  final midPoint = basicCurve.transform(0.5);

  print('Transform verification:');
  print(
    '  • Start (t=0.0): (${startPoint.dx.toStringAsFixed(4)}, ${startPoint.dy.toStringAsFixed(4)})',
  );
  print(
    '  • Mid (t=0.5):   (${midPoint.dx.toStringAsFixed(4)}, ${midPoint.dy.toStringAsFixed(4)})',
  );
  print(
    '  • End (t=1.0):   (${endPoint.dx.toStringAsFixed(4)}, ${endPoint.dy.toStringAsFixed(4)})',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: SAMPLE GENERATION - Adaptive Curve Sampling
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: SAMPLE GENERATION                                      │',
  );
  print(
    '│ Creating curve samples with adaptive tolerance                    │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Default sampling
  final defaultSamples = basicCurve.generateSamples();
  print('Default sample generation:');
  print('  • Sample count: ${defaultSamples.length}');
  print('  • Uses default tolerance for adaptive sampling');
  print('');

  // Display sample details
  print('First 10 samples:');
  print('┌─────┬─────────────┬─────────────────┬─────────────────┐');
  print('│  #  │      t      │       x         │       y         │');
  print('├─────┼─────────────┼─────────────────┼─────────────────┤');
  for (var i = 0; i < math.min(10, defaultSamples.length); i++) {
    final sample = defaultSamples[i];
    print(
      '│ ${i.toString().padLeft(3)} │ ${sample.t.toStringAsFixed(6).padLeft(10)}  │  ${sample.value.dx.toStringAsFixed(6).padLeft(12)}  │  ${sample.value.dy.toStringAsFixed(6).padLeft(12)}  │',
    );
  }
  print('└─────┴─────────────┴─────────────────┴─────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: TOLERANCE VARIATIONS - Controlling Sample Density
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: TOLERANCE VARIATIONS                                   │',
  );
  print(
    '│ Effect of tolerance on sample density                             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final toleranceTests = <double>[0.001, 0.01, 0.05, 0.1, 0.25, 0.5, 1.0];
  final toleranceResults = <Map<String, dynamic>>[];

  print('Tolerance impact on sample count:');
  print('┌─────────────┬─────────────────┬──────────────────────────────────┐');
  print('│  Tolerance  │  Sample Count   │  Relative Density                │');
  print('├─────────────┼─────────────────┼──────────────────────────────────┤');

  final baseCount = defaultSamples.length;
  for (final tolerance in toleranceTests) {
    final samples = basicCurve.generateSamples(tolerance: tolerance);
    final relDensity = (samples.length / baseCount * 100).toStringAsFixed(1);
    toleranceResults.add({
      'tolerance': tolerance,
      'count': samples.length,
      'relative': samples.length / baseCount,
    });
    print(
      '│   ${tolerance.toStringAsFixed(3).padLeft(7)}   │  ${samples.length.toString().padLeft(12)}   │  ${relDensity.padLeft(6)}% of default            │',
    );
  }
  print('└─────────────┴─────────────────┴──────────────────────────────────┘');
  print('');

  print('Tolerance guidelines:');
  print('  • Lower tolerance → More samples → Higher accuracy');
  print('  • Higher tolerance → Fewer samples → Faster computation');
  print('  • Choose based on rendering resolution needs');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: CURVE SHAPES - Different Control Point Configurations
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: CURVE SHAPES                                           │',
  );
  print(
    '│ Various control point configurations                              │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Straight line
  final straightLine = CatmullRomSpline([
    Offset(0.0, 0.0),
    Offset(0.5, 0.5),
    Offset(1.0, 1.0),
  ]);
  final straightSamples = straightLine.generateSamples();
  print('1. Straight Line (diagonal):');
  print('   Points: (0,0) → (0.5,0.5) → (1,1)');
  print('   Sample count: ${straightSamples.length}');

  // S-curve
  final sCurve = CatmullRomSpline([
    Offset(0.0, 0.0),
    Offset(0.25, 0.0),
    Offset(0.5, 0.5),
    Offset(0.75, 1.0),
    Offset(1.0, 1.0),
  ]);
  final sSamples = sCurve.generateSamples();
  print('');
  print('2. S-Curve (sigmoid-like):');
  print('   Points: (0,0) → (0.25,0) → (0.5,0.5) → (0.75,1) → (1,1)');
  print('   Sample count: ${sSamples.length}');

  // Wave curve
  final waveCurve = CatmullRomSpline([
    Offset(0.0, 0.5),
    Offset(0.2, 0.8),
    Offset(0.4, 0.2),
    Offset(0.6, 0.8),
    Offset(0.8, 0.2),
    Offset(1.0, 0.5),
  ]);
  final waveSamples = waveCurve.generateSamples();
  print('');
  print('3. Wave Curve (oscillating):');
  print(
    '   Points: (0,0.5) → (0.2,0.8) → (0.4,0.2) → (0.6,0.8) → (0.8,0.2) → (1,0.5)',
  );
  print('   Sample count: ${waveSamples.length}');

  // Loop curve
  final loopCurve = CatmullRomSpline([
    Offset(0.0, 0.5),
    Offset(0.3, 0.0),
    Offset(0.7, 1.0),
    Offset(1.0, 0.5),
  ]);
  final loopSamples = loopCurve.generateSamples();
  print('');
  print('4. Arc Curve (rise and fall):');
  print('   Points: (0,0.5) → (0.3,0) → (0.7,1) → (1,0.5)');
  print('   Sample count: ${loopSamples.length}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: CURVE ANALYSIS - Mathematical Properties
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: CURVE ANALYSIS                                         │',
  );
  print(
    '│ Mathematical properties of Curve2D                                │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Calculate arc length approximation
  double approximateArcLength(CatmullRomSpline curve, int segments) {
    double length = 0.0;
    Offset prevPoint = curve.transform(0.0);
    for (var i = 1; i <= segments; i++) {
      final t = i / segments;
      final point = curve.transform(t);
      final dx = point.dx - prevPoint.dx;
      final dy = point.dy - prevPoint.dy;
      length += math.sqrt(dx * dx + dy * dy);
      prevPoint = point;
    }
    return length;
  }

  print('Arc length approximations (vary segment count):');
  print('┌────────────────┬─────────────────────┬───────────────────┐');
  print('│   Segments     │   Arc Length        │   Δ from prev     │');
  print('├────────────────┼─────────────────────┼───────────────────┤');

  final arcLengthResults = <Map<String, dynamic>>[];
  double? prevLength;
  for (final segments in [10, 50, 100, 500, 1000]) {
    final length = approximateArcLength(basicCurve, segments);
    final delta = prevLength != null ? (length - prevLength).abs() : 0.0;
    arcLengthResults.add({
      'segments': segments,
      'length': length,
      'delta': delta,
    });
    print(
      '│   ${segments.toString().padLeft(10)}   │   ${length.toStringAsFixed(10).padLeft(15)}   │   ${delta.toStringAsFixed(10).padLeft(13)}   │',
    );
    prevLength = length;
  }
  print('└────────────────┴─────────────────────┴───────────────────┘');
  print('');

  // Bounding box calculation
  Offset minBound = Offset(double.infinity, double.infinity);
  Offset maxBound = Offset(double.negativeInfinity, double.negativeInfinity);
  for (final sample in defaultSamples) {
    if (sample.value.dx < minBound.dx)
      minBound = Offset(sample.value.dx, minBound.dy);
    if (sample.value.dy < minBound.dy)
      minBound = Offset(minBound.dx, sample.value.dy);
    if (sample.value.dx > maxBound.dx)
      maxBound = Offset(sample.value.dx, maxBound.dy);
    if (sample.value.dy > maxBound.dy)
      maxBound = Offset(maxBound.dx, sample.value.dy);
  }

  print('Bounding box analysis:');
  print(
    '  • Min corner: (${minBound.dx.toStringAsFixed(6)}, ${minBound.dy.toStringAsFixed(6)})',
  );
  print(
    '  • Max corner: (${maxBound.dx.toStringAsFixed(6)}, ${maxBound.dy.toStringAsFixed(6)})',
  );
  print('  • Width: ${(maxBound.dx - minBound.dx).toStringAsFixed(6)}');
  print('  • Height: ${(maxBound.dy - minBound.dy).toStringAsFixed(6)}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: SAMPLE POINT DISTRIBUTION - Understanding Curve2DSample
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: SAMPLE POINT DISTRIBUTION                              │',
  );
  print(
    '│ Analyzing Curve2DSample structure                                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Curve2DSample structure:');
  print('  • t: Parameter value [0,1]');
  print('  • value: Offset(x, y) position on curve');
  print('');

  // Analyze sample distribution
  final sampleGaps = <double>[];
  for (var i = 1; i < defaultSamples.length; i++) {
    sampleGaps.add(defaultSamples[i].t - defaultSamples[i - 1].t);
  }

  if (sampleGaps.isNotEmpty) {
    final avgGap = sampleGaps.reduce((a, b) => a + b) / sampleGaps.length;
    final minGap = sampleGaps.reduce(math.min);
    final maxGap = sampleGaps.reduce(math.max);

    print('Parameter t distribution statistics:');
    print('  • Average gap: ${avgGap.toStringAsFixed(8)}');
    print('  • Minimum gap: ${minGap.toStringAsFixed(8)}');
    print('  • Maximum gap: ${maxGap.toStringAsFixed(8)}');
    print('  • Gap ratio (max/min): ${(maxGap / minGap).toStringAsFixed(4)}');
    print('');
    print('✓ Adaptive sampling creates variable t spacing based on curvature');
  }
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: CURVE INTERPOLATION COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: CURVE INTERPOLATION COMPARISON                         │',
  );
  print(
    '│ Comparing different curves at same t values                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final comparisonT = [0.0, 0.25, 0.5, 0.75, 1.0];

  print('Comparison at key t values:');
  print(
    '┌───────┬────────────────────┬────────────────────┬────────────────────┐',
  );
  print(
    '│   t   │   Basic Arc        │   S-Curve          │   Wave             │',
  );
  print(
    '├───────┼────────────────────┼────────────────────┼────────────────────┤',
  );

  final comparisonData = <Map<String, dynamic>>[];
  for (final t in comparisonT) {
    final basic = basicCurve.transform(t);
    final s = sCurve.transform(t);
    final wave = waveCurve.transform(t);
    comparisonData.add({'t': t, 'basic': basic, 's': s, 'wave': wave});
    print(
      '│ ${t.toStringAsFixed(2)}  │ (${basic.dx.toStringAsFixed(2)}, ${basic.dy.toStringAsFixed(2)})       │ (${s.dx.toStringAsFixed(2)}, ${s.dy.toStringAsFixed(2)})       │ (${wave.dx.toStringAsFixed(2)}, ${wave.dy.toStringAsFixed(2)})       │',
    );
  }
  print(
    '└───────┴────────────────────┴────────────────────┴────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: EDGE CASES AND BOUNDARY CONDITIONS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: EDGE CASES                                             │',
  );
  print(
    '│ Boundary conditions and special cases                             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Very small t values
  print('Near-boundary evaluation:');
  final nearZero = [0.0, 0.001, 0.01, 0.99, 0.999, 1.0];
  for (final t in nearZero) {
    final point = basicCurve.transform(t);
    print(
      '  t=${t.toStringAsFixed(3)}: (${point.dx.toStringAsFixed(8)}, ${point.dy.toStringAsFixed(8)})',
    );
  }
  print('');

  // Minimal control points
  final minimalCurve = CatmullRomSpline([Offset(0.0, 0.0), Offset(1.0, 1.0)]);
  final minimalSamples = minimalCurve.generateSamples();
  print('Minimal curve (2 points):');
  print('  Sample count: ${minimalSamples.length}');
  print(
    '  Start: (${minimalCurve.transform(0.0).dx}, ${minimalCurve.transform(0.0).dy})',
  );
  print(
    '  End: (${minimalCurve.transform(1.0).dx}, ${minimalCurve.transform(1.0).dy})',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PARAMETRIC CURVE PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: PARAMETRIC CURVE PROPERTIES                           │',
  );
  print(
    '│ Understanding t → (x,y) mapping                                   │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Key properties of Curve2D:');
  print('  • Domain: t ∈ [0, 1]');
  print('  • Range: (x, y) ∈ ℝ² determined by control points');
  print('  • Continuity: C1 continuous (smooth tangent)');
  print('  • Not necessarily arc-length parameterized');
  print('');

  // Show parameter vs arc length relationship
  print('Parameter vs arc length relationship:');
  double cumulativeLength = 0.0;
  Offset prevPt = basicCurve.transform(0.0);
  final arcLengthMapping = <Map<String, double>>[];

  for (var i = 0; i <= 10; i++) {
    final t = i / 10;
    final pt = basicCurve.transform(t);
    if (i > 0) {
      final dx = pt.dx - prevPt.dx;
      final dy = pt.dy - prevPt.dy;
      cumulativeLength += math.sqrt(dx * dx + dy * dy);
    }
    arcLengthMapping.add({'t': t, 'arcLength': cumulativeLength});
    prevPt = pt;
  }

  final totalArc = arcLengthMapping.last['arcLength']!;
  print('┌─────────┬─────────────────┬───────────────────────┐');
  print('│    t    │   Arc Length    │   % of Total Arc      │');
  print('├─────────┼─────────────────┼───────────────────────┤');
  for (final mapping in arcLengthMapping) {
    final pct = (mapping['arcLength']! / totalArc * 100);
    print(
      '│  ${mapping['t']!.toStringAsFixed(1)}    │  ${mapping['arcLength']!.toStringAsFixed(6).padLeft(12)}   │  ${pct.toStringAsFixed(2).padLeft(6)}%               │',
    );
  }
  print('└─────────┴─────────────────┴───────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                    CURVE2D SUMMARY                                ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('Curve2D is an abstract interface for 2D parametric curves:');
  print('  • transform(t): Maps parameter t to 2D point Offset(x,y)');
  print('  • generateSamples(): Creates adaptive curve samples');
  print('  • Tolerance controls sample density/accuracy tradeoff');
  print('  • CatmullRomSpline is the primary concrete implementation');
  print('');
  print('Key differences from 1D Curve:');
  print('  • 1D Curve: t → y (single coordinate)');
  print('  • 2D Curve2D: t → (x, y) (2D point)');
  print('');
  print('Common use cases:');
  print('  • Path animation along arbitrary 2D shapes');
  print('  • Drawing smooth curves through control points');
  print('  • Motion paths for UI elements');
  print('');
  print('Curve2D Deep Demo completed');

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
                colors: [Color(0xFF1A237E), Color(0xFF3949AB)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'Curve2D',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Abstract 2D Parametric Curve Interface',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFE8EAF6)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Transform Results Section
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
                  'TRANSFORM EVALUATION',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF424242),
                    letterSpacing: 1.2,
                  ),
                ),
                Divider(),
                ...transformResults
                    .take(6)
                    .map(
                      (r) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            Container(
                              width: 60,
                              child: Text(
                                't=${(r['t'] as double).toStringAsFixed(2)}',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '(${(r['x'] as double).toStringAsFixed(4)}, ${(r['y'] as double).toStringAsFixed(4)})',
                                style: TextStyle(
                                  fontFamily: 'monospace',
                                  color: Color(0xFF1565C0),
                                ),
                              ),
                            ),
                            Text(
                              '|r| = ${(r['magnitude'] as double).toStringAsFixed(4)}',
                              style: TextStyle(
                                color: Color(0xFF757575),
                                fontSize: 12.0,
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

          // Tolerance Impact Section
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
                  'TOLERANCE IMPACT ON SAMPLING',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...toleranceResults.map(
                  (r) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      children: [
                        Container(
                          width: 80,
                          child: Text(
                            'tol=${(r['tolerance'] as double).toStringAsFixed(3)}',
                            style: TextStyle(fontSize: 12.0),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 16,
                            decoration: BoxDecoration(
                              color: Color(0xFF1565C0).withOpacity(0.2),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            child: FractionallySizedBox(
                              widthFactor: math.min(
                                1.0,
                                (r['relative'] as double),
                              ),
                              alignment: Alignment.centerLeft,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF1565C0),
                                  borderRadius: BorderRadius.circular(4.0),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: 60,
                          alignment: Alignment.centerRight,
                          child: Text(
                            '${r['count']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
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

          // Curve Shapes Section
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
                  'CURVE SHAPE COMPARISON',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildCurveShapeRow(
                  'Straight Line',
                  '${straightSamples.length} samples',
                  Color(0xFFFF9800),
                ),
                _buildCurveShapeRow(
                  'S-Curve',
                  '${sSamples.length} samples',
                  Color(0xFFFFA726),
                ),
                _buildCurveShapeRow(
                  'Wave',
                  '${waveSamples.length} samples',
                  Color(0xFFFFB74D),
                ),
                _buildCurveShapeRow(
                  'Arc',
                  '${loopSamples.length} samples',
                  Color(0xFFFFCC80),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Arc Length Analysis Section
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
                  'ARC LENGTH CONVERGENCE',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...arcLengthResults.map(
                  (r) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${r['segments']} segments',
                          style: TextStyle(fontSize: 12.0),
                        ),
                        Text(
                          'L = ${(r['length'] as double).toStringAsFixed(8)}',
                          style: TextStyle(
                            fontFamily: 'monospace',
                            fontSize: 12.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Δ = ${(r['delta'] as double).toStringAsFixed(8)}',
                          style: TextStyle(
                            fontSize: 11.0,
                            color: Color(0xFF757575),
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

          // Bounding Box Section
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
                  'BOUNDING BOX',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildBoundingItem(
                      'Min',
                      '(${minBound.dx.toStringAsFixed(4)}, ${minBound.dy.toStringAsFixed(4)})',
                    ),
                    _buildBoundingItem(
                      'Max',
                      '(${maxBound.dx.toStringAsFixed(4)}, ${maxBound.dy.toStringAsFixed(4)})',
                    ),
                    _buildBoundingItem(
                      'Size',
                      '${(maxBound.dx - minBound.dx).toStringAsFixed(4)} × ${(maxBound.dy - minBound.dy).toStringAsFixed(4)}',
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Curve Comparison Table
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
                  'CURVE COMPARISON AT KEY POINTS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF455A64),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...comparisonData.map(
                  (d) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        Container(
                          width: 50,
                          child: Text(
                            't=${(d['t'] as double).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Arc: (${(d['basic'] as Offset).dx.toStringAsFixed(2)}, ${(d['basic'] as Offset).dy.toStringAsFixed(2)})',
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'S: (${(d['s'] as Offset).dx.toStringAsFixed(2)}, ${(d['s'] as Offset).dy.toStringAsFixed(2)})',
                            style: TextStyle(fontSize: 11.0),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'W: (${(d['wave'] as Offset).dx.toStringAsFixed(2)}, ${(d['wave'] as Offset).dy.toStringAsFixed(2)})',
                            style: TextStyle(fontSize: 11.0),
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

          // Key Concepts Section
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
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
                _buildConceptItem('Parametric', 't ∈ [0,1] → Offset(x,y)'),
                _buildConceptItem(
                  'Abstract',
                  'Interface for 2D curve implementations',
                ),
                _buildConceptItem(
                  'Adaptive',
                  'Tolerance controls sample density',
                ),
                _buildConceptItem('Smooth', 'C1 continuous tangent vectors'),
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
                    _buildSummaryStatWhite(
                      'Transform Points',
                      '${transformResults.length}',
                    ),
                    _buildSummaryStatWhite(
                      'Tolerance Tests',
                      '${toleranceResults.length}',
                    ),
                    _buildSummaryStatWhite('Curve Shapes', '4'),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStatWhite(
                      'Default Samples',
                      '${defaultSamples.length}',
                    ),
                    _buildSummaryStatWhite('Control Points', '5'),
                    _buildSummaryStatWhite(
                      'Arc Length',
                      '~${totalArc.toStringAsFixed(3)}',
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
              'Deep Demo • Curve2D • Flutter Animation',
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

Widget _buildCurveShapeRow(String name, String samples, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 12.0),
        Expanded(
          child: Text(name, style: TextStyle(fontWeight: FontWeight.w500)),
        ),
        Text(
          samples,
          style: TextStyle(fontSize: 12.0, color: Color(0xFF757575)),
        ),
      ],
    ),
  );
}

Widget _buildBoundingItem(String label, String value) {
  return Column(
    children: [
      Text(
        label,
        style: TextStyle(
          fontSize: 11.0,
          color: Color(0xFF9C27B0),
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(height: 4.0),
      Text(value, style: TextStyle(fontSize: 12.0, fontFamily: 'monospace')),
    ],
  );
}

Widget _buildConceptItem(String title, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: TextStyle(
            color: Color(0xFFCE93D8),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '$title: ',
          style: TextStyle(
            color: Color(0xFFE1BEE7),
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 13.0),
          ),
        ),
      ],
    ),
  );
}

Widget _buildSummaryStatWhite(String label, String value) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4DD0E1),
        ),
      ),
      Text(label, style: TextStyle(fontSize: 10.0, color: Color(0xFF90A4AE))),
    ],
  );
}
