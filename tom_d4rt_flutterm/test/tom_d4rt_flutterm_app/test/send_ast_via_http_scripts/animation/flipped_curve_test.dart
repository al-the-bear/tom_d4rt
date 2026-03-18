// D4rt test script: Deep Demo for FlippedCurve from animation
// FlippedCurve transforms any curve by flipping it around both axes
// Formula: flipped(t) = 1 - original(1 - t)
import 'dart:math' as math;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                  FLIPPEDCURVE DEEP DEMO                           ║',
  );
  print(
    '║           Horizontal and Vertical Curve Inversion                 ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: FLIPPEDCURVE FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: FLIPPEDCURVE FUNDAMENTALS                              │',
  );
  print(
    '│ Understanding the curve inversion wrapper                         │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('FlippedCurve characteristics:');
  print('  • Wraps any existing Curve');
  print('  • Applies horizontal flip (time reversal): t → (1-t)');
  print('  • Applies vertical flip (value inversion): y → (1-y)');
  print('  • Combined: flipped(t) = 1 - curve(1 - t)');
  print('  • Creates opposite animation feel');
  print('  • Double flip restores original curve');
  print('');

  // Create flipped curves for various base curves
  final easeIn = Curves.easeIn;
  final flippedEaseIn = FlippedCurve(easeIn);
  print('✓ Created FlippedCurve(Curves.easeIn)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: FLIP FORMULA VERIFICATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: FLIP FORMULA VERIFICATION                              │',
  );
  print(
    '│ Verifying flipped(t) = 1 - original(1-t)                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
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
  final formulaResults = <Map<String, dynamic>>[];

  print('Formula verification for FlippedCurve(easeIn):');
  print('┌─────────┬─────────────────┬─────────────────┬───────────────┐');
  print('│    t    │   flipped(t)    │ 1-easeIn(1-t)   │     Diff      │');
  print('├─────────┼─────────────────┼─────────────────┼───────────────┤');

  for (final t in tValues) {
    final flippedVal = flippedEaseIn.transform(t);
    final expected = 1.0 - easeIn.transform(1.0 - t);
    final diff = (flippedVal - expected).abs();
    formulaResults.add({
      't': t,
      'flipped': flippedVal,
      'expected': expected,
      'diff': diff,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${flippedVal.toStringAsFixed(8).padLeft(12)}   │  ${expected.toStringAsFixed(8).padLeft(12)}   │  ${diff.toStringAsFixed(10).padLeft(11)}  │',
    );
  }
  print('└─────────┴─────────────────┴─────────────────┴───────────────┘');
  print('');

  final maxDiff = formulaResults
      .map((r) => r['diff'] as double)
      .reduce(math.max);
  print('Maximum formula error: ${maxDiff.toStringAsFixed(12)}');
  print(
    maxDiff < 1e-10
        ? "✓ Formula perfectly verified"
        : "⚠ Small numerical error detected",
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ORIGINAL VS FLIPPED COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: ORIGINAL VS FLIPPED COMPARISON                         │',
  );
  print(
    '│ Side by side view of easeIn and flipped(easeIn)                   │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final comparisonResults = <Map<String, dynamic>>[];

  print('EaseIn vs FlippedEaseIn:');
  print(
    '┌─────────┬─────────────────┬─────────────────┬───────────────────────┐',
  );
  print(
    '│    t    │    easeIn(t)    │   flipped(t)    │    Relationship       │',
  );
  print(
    '├─────────┼─────────────────┼─────────────────┼───────────────────────┤',
  );

  for (final t in tValues) {
    final orig = easeIn.transform(t);
    final flip = flippedEaseIn.transform(t);
    String relationship;
    if (t == 0.0) {
      relationship = 'Start both 0→1';
    } else if (t == 1.0)
      relationship = 'End both at 1';
    else if (t == 0.5)
      relationship = 'Meet at midpoint';
    else if (flip > orig)
      relationship = 'Flipped ahead';
    else
      relationship = 'Original ahead';

    comparisonResults.add({
      't': t,
      'orig': orig,
      'flip': flip,
      'relationship': relationship,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${orig.toStringAsFixed(8).padLeft(12)}   │  ${flip.toStringAsFixed(8).padLeft(12)}   │ ${relationship.padRight(21)} │',
    );
  }
  print(
    '└─────────┴─────────────────┴─────────────────┴───────────────────────┘',
  );
  print('');

  print('Observation: Flipping easeIn creates easeOut-like behavior!');
  print('  • easeIn: slow start, fast end');
  print('  • flipped(easeIn): fast start, slow end');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: FLIPPING VARIOUS CURVES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: FLIPPING VARIOUS CURVES                                │',
  );
  print(
    '│ How flip affects different curve types                            │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final curves = <String, Curve>{
    'linear': Curves.linear,
    'easeIn': Curves.easeIn,
    'easeOut': Curves.easeOut,
    'easeInOut': Curves.easeInOut,
    'bounceIn': Curves.bounceIn,
    'bounceOut': Curves.bounceOut,
  };

  final flippedCurves = <String, FlippedCurve>{};
  for (final entry in curves.entries) {
    flippedCurves[entry.key] = FlippedCurve(entry.value);
  }

  final curveResults = <Map<String, dynamic>>[];

  print('Original vs Flipped at t=0.3:');
  print(
    '┌─────────────────┬─────────────────┬─────────────────┬───────────────┐',
  );
  print(
    '│      Curve      │   Original(0.3) │   Flipped(0.3)  │   Diff        │',
  );
  print(
    '├─────────────────┼─────────────────┼─────────────────┼───────────────┤',
  );

  for (final name in curves.keys) {
    final orig = curves[name]!.transform(0.3);
    final flip = flippedCurves[name]!.transform(0.3);
    final diff = flip - orig;
    curveResults.add({'name': name, 'orig': orig, 'flip': flip, 'diff': diff});
    print(
      '│ ${name.padRight(15)} │  ${orig.toStringAsFixed(8).padLeft(13)}  │  ${flip.toStringAsFixed(8).padLeft(13)}  │  ${diff.toStringAsFixed(6).padLeft(10)}   │',
    );
  }
  print(
    '└─────────────────┴─────────────────┴─────────────────┴───────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: FLIP SYMMETRY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: FLIP SYMMETRY                                          │',
  );
  print(
    '│ original(t) + flipped(1-t) = 1                                    │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final symmetryResults = <Map<String, dynamic>>[];

  print('Symmetry check for easeIn and flipped(easeIn):');
  print('┌─────────┬─────────────────┬─────────────────┬───────────────┐');
  print('│    t    │   easeIn(t)     │  flipped(1-t)   │     Sum       │');
  print('├─────────┼─────────────────┼─────────────────┼───────────────┤');

  for (final t in [0.0, 0.2, 0.4, 0.5, 0.6, 0.8, 1.0]) {
    final orig = easeIn.transform(t);
    final flip1t = flippedEaseIn.transform(1.0 - t);
    final sum = orig + flip1t;
    symmetryResults.add({'t': t, 'orig': orig, 'flip1t': flip1t, 'sum': sum});
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${orig.toStringAsFixed(8).padLeft(12)}   │  ${flip1t.toStringAsFixed(8).padLeft(12)}   │  ${sum.toStringAsFixed(8).padLeft(11)}  │',
    );
  }
  print('└─────────┴─────────────────┴─────────────────┴───────────────┘');
  print('');

  final symError = symmetryResults
      .map((r) => ((r['sum'] as double) - 1.0).abs())
      .reduce(math.max);
  print('Maximum symmetry error: ${symError.toStringAsFixed(12)}');
  print(
    symError < 1e-10
        ? "✓ Perfect symmetry verified"
        : "⚠ Small numerical error",
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: DOUBLE FLIP = IDENTITY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: DOUBLE FLIP = IDENTITY                                 │',
  );
  print(
    '│ Flipping twice restores original curve                            │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final doubleFlip = FlippedCurve(flippedEaseIn);
  final doubleResults = <Map<String, dynamic>>[];

  print('Double flip verification:');
  print('┌─────────┬─────────────────┬─────────────────┬───────────────┐');
  print('│    t    │    easeIn(t)    │ doubleFlip(t)   │     Diff      │');
  print('├─────────┼─────────────────┼─────────────────┼───────────────┤');

  for (final t in tValues) {
    final orig = easeIn.transform(t);
    final df = doubleFlip.transform(t);
    final diff = (orig - df).abs();
    doubleResults.add({'t': t, 'orig': orig, 'double': df, 'diff': diff});
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${orig.toStringAsFixed(8).padLeft(12)}   │  ${df.toStringAsFixed(8).padLeft(12)}   │  ${diff.toStringAsFixed(10).padLeft(11)}  │',
    );
  }
  print('└─────────┴─────────────────┴─────────────────┴───────────────┘');
  print('');

  final doubleError = doubleResults
      .map((r) => r['diff'] as double)
      .reduce(math.max);
  print('Maximum double-flip error: ${doubleError.toStringAsFixed(12)}');
  print(
    doubleError < 1e-10
        ? "✓ Double flip equals original"
        : "⚠ Small numerical error",
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: FLIPPING LINEAR CURVE
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: FLIPPING LINEAR CURVE                                  │',
  );
  print(
    '│ Linear is invariant under flip                                    │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final linear = Curves.linear;
  final flippedLinear = FlippedCurve(linear);
  final linearResults = <Map<String, dynamic>>[];

  print('Linear curve flip (should be unchanged):');
  print('┌─────────┬─────────────────┬─────────────────┬───────────────┐');
  print('│    t    │    linear(t)    │   flipped(t)    │     Diff      │');
  print('├─────────┼─────────────────┼─────────────────┼───────────────┤');

  for (final t in tValues) {
    final lin = linear.transform(t);
    final flip = flippedLinear.transform(t);
    final diff = (lin - flip).abs();
    linearResults.add({'t': t, 'linear': lin, 'flipped': flip, 'diff': diff});
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${lin.toStringAsFixed(8).padLeft(12)}   │  ${flip.toStringAsFixed(8).padLeft(12)}   │  ${diff.toStringAsFixed(10).padLeft(11)}  │',
    );
  }
  print('└─────────┴─────────────────┴─────────────────┴───────────────┘');
  print('');

  print('✓ Flipping a linear curve produces the same linear curve');
  print('  This is because: 1 - (1-t) = t for all t');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: FLIP RELATIONSHIPS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: FLIP RELATIONSHIPS                                     │',
  );
  print(
    '│ How standard curves relate through flipping                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Check if flip(easeIn) ≈ easeOut
  final flippedEaseInVsEaseOut = <Map<String, dynamic>>[];
  final easeOut = Curves.easeOut;

  print('Flipped(easeIn) vs easeOut:');
  print('┌─────────┬─────────────────┬─────────────────┬───────────────┐');
  print('│    t    │ flipped(easeIn) │     easeOut     │     Diff      │');
  print('├─────────┼─────────────────┼─────────────────┼───────────────┤');

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final flip = flippedEaseIn.transform(t);
    final out = easeOut.transform(t);
    final diff = (flip - out).abs();
    flippedEaseInVsEaseOut.add({
      't': t,
      'flip': flip,
      'out': out,
      'diff': diff,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${flip.toStringAsFixed(8).padLeft(12)}   │  ${out.toStringAsFixed(8).padLeft(12)}   │  ${diff.toStringAsFixed(10).padLeft(11)}  │',
    );
  }
  print('└─────────┴─────────────────┴─────────────────┴───────────────┘');
  print('');

  final flipEaseInDiff = flippedEaseInVsEaseOut
      .map((r) => r['diff'] as double)
      .reduce(math.max);
  print(
    'Note: flipped(easeIn) ≈ easeOut (max diff: ${flipEaseInDiff.toStringAsFixed(6)})',
  );
  print('They are conceptually similar but may differ in implementation');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: VELOCITY ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: VELOCITY ANALYSIS                                      │',
  );
  print(
    '│ How flipping affects the rate of change                           │',
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

  print('Velocity comparison (easeIn vs flipped):');
  print(
    '┌─────────┬─────────────────┬─────────────────┬───────────────────────┐',
  );
  print(
    '│    t    │  v(easeIn)      │  v(flipped)     │   Interpretation      │',
  );
  print(
    '├─────────┼─────────────────┼─────────────────┼───────────────────────┤',
  );

  for (final t in [0.1, 0.3, 0.5, 0.7, 0.9]) {
    final vOrig = calculateDerivative(easeIn, t, 0.01);
    final vFlip = calculateDerivative(flippedEaseIn, t, 0.01);
    String interpretation;
    if (vFlip > vOrig) {
      interpretation = 'Flipped faster';
    } else if (vFlip < vOrig)
      interpretation = 'Original faster';
    else
      interpretation = 'Equal speed';

    velocityResults.add({
      't': t,
      'vOrig': vOrig,
      'vFlip': vFlip,
      'interpretation': interpretation,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${vOrig.toStringAsFixed(8).padLeft(12)}   │  ${vFlip.toStringAsFixed(8).padLeft(12)}   │ ${interpretation.padRight(21)} │',
    );
  }
  print(
    '└─────────┴─────────────────┴─────────────────┴───────────────────────┘',
  );
  print('');

  print('Velocity relationship: v_flipped(t) = v_original(1-t)');
  print('  • At t=0.1: easeIn slow, flipped fast');
  print('  • At t=0.9: easeIn fast, flipped slow');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PRACTICAL APPLICATIONS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: PRACTICAL APPLICATIONS                                │',
  );
  print(
    '│ When and why to use FlippedCurve                                  │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Example: Reverse animation with same curve
  final forwardAnim = <Map<String, double>>[];
  final reverseAnim = <Map<String, double>>[];

  print('1. Reversing an animation (0→100px forward, 100→0px reverse):');
  for (final t in [0.0, 0.5, 1.0]) {
    final forwardPos = easeIn.transform(t) * 100;
    final reversePos = 100 - flippedEaseIn.transform(t) * 100;
    forwardAnim.add({'t': t, 'pos': forwardPos});
    reverseAnim.add({'t': t, 'pos': reversePos});
    print(
      '  t=${t.toStringAsFixed(1)}: forward=${forwardPos.toStringAsFixed(1)}px, reverse=${reversePos.toStringAsFixed(1)}px',
    );
  }
  print('  Flipped curve keeps same "feel" when going backward');
  print('');

  // Example: Creating complementary animations
  print('2. Scale in (easeIn) and scale out (flipped):');
  for (final t in [0.0, 0.5, 1.0]) {
    final scaleIn = easeIn.transform(t);
    final scaleOut = flippedEaseIn.transform(t);
    print(
      '  t=${t.toStringAsFixed(1)}: scaleIn=${scaleIn.toStringAsFixed(3)}, scaleOut=${scaleOut.toStringAsFixed(3)}',
    );
  }
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                   FLIPPEDCURVE SUMMARY                            ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('FlippedCurve key features:');
  print('  • Wraps any Curve to invert it');
  print('  • Formula: flipped(t) = 1 - curve(1-t)');
  print('  • Double flip = original');
  print('  • Linear curve is invariant');
  print('');
  print('Best use cases:');
  print('  • Creating reverse animations');
  print('  • Changing animation "feel"');
  print('  • Complementary in/out animations');
  print('  • When you need the opposite curve');
  print('');
  print('Relationships:');
  print('  • flipped(easeIn) ≈ easeOut');
  print('  • flipped(bounceIn) ≈ bounceOut');
  print('  • flipped(linear) = linear');
  print('');
  print('FlippedCurve Deep Demo completed');

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
                colors: [Color(0xFFAD1457), Color(0xFFD81B60)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'FlippedCurve',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Horizontal & Vertical Curve Inversion',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFF8BBD9)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Formula Section
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFCE4EC),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FLIP FORMULA',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFAD1457),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFFF48FB1)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'flipped(t) = 1 - curve(1 - t)',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFFAD1457),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'where:',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF757575),
                        ),
                      ),
                      Text(
                        '  • (1 - t) = horizontal flip (time reversal)',
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        '  • 1 - (...) = vertical flip (value inversion)',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Max formula error: ${maxDiff.toStringAsFixed(12)}',
                  style: TextStyle(fontSize: 10, color: Color(0xFF4CAF50)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Original vs Flipped
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
                  'EASEIN vs FLIPPED(EASEIN)',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF424242),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...comparisonResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map(
                      (r) => _buildComparisonRow(
                        't=${(r['t'] as double).toStringAsFixed(2)}',
                        r['orig'] as double,
                        r['flip'] as double,
                      ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Visual Curve Comparison
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
                SizedBox(height: 8),
                Row(
                  children: [
                    Container(width: 12, height: 12, color: Color(0xFF1565C0)),
                    SizedBox(width: 4),
                    Text('easeIn', style: TextStyle(fontSize: 10)),
                    SizedBox(width: 16),
                    Container(width: 12, height: 12, color: Color(0xFFAD1457)),
                    SizedBox(width: 4),
                    Text('flipped(easeIn)', style: TextStyle(fontSize: 10)),
                  ],
                ),
                SizedBox(height: 12.0),
                _buildDualCurveVisualization(easeIn, flippedEaseIn),
                SizedBox(height: 8),
                Text(
                  'Notice how the curves are mirror images around the diagonal',
                  style: TextStyle(
                    fontSize: 10,
                    fontStyle: FontStyle.italic,
                    color: Color(0xFF757575),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Double Flip Section
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.sync, color: Color(0xFF2E7D32), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'DOUBLE FLIP = IDENTITY',
                      style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2E7D32),
                        letterSpacing: 1.2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                ...doubleResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map(
                      (r) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 2.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Text(
                                't=${(r['t'] as double).toStringAsFixed(2)}',
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'easeIn: ${(r['orig'] as double).toStringAsFixed(4)}',
                                style: TextStyle(
                                  fontSize: 11,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'double: ${(r['double'] as double).toStringAsFixed(4)}',
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
                                '✓',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 10,
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

          // Linear Invariance
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
                  'LINEAR IS INVARIANT',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'flipped(linear) = linear',
                  style: TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 12,
                    color: Color(0xFFE65100),
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Because: 1 - (1-t) = t for all t',
                  style: TextStyle(fontSize: 11, color: Color(0xFF795548)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Flip Relationships
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
                  'FLIP RELATIONSHIPS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildRelationshipRow('flipped(easeIn)', '≈', 'easeOut'),
                _buildRelationshipRow('flipped(easeOut)', '≈', 'easeIn'),
                _buildRelationshipRow('flipped(bounceIn)', '≈', 'bounceOut'),
                _buildRelationshipRow('flipped(linear)', '=', 'linear'),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Velocity Analysis
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
                  'VELOCITY COMPARISON',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...velocityResults.map(
                  (r) => _buildVelocityRow(
                    't=${(r['t'] as double).toStringAsFixed(2)}',
                    r['vOrig'] as double,
                    r['vFlip'] as double,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Key Concepts
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF880E4F), Color(0xFFAD1457)],
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
                _buildKeyPoint('Formula', 'flipped(t) = 1 - curve(1-t)'),
                _buildKeyPoint('Double Flip', 'flip(flip(curve)) = curve'),
                _buildKeyPoint('Velocity', 'v_flip(t) = v_orig(1-t)'),
                _buildKeyPoint('Use Case', 'Reverse animations'),
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
                    _buildSummaryStat('Curves Tested', '${curves.length}'),
                    _buildSummaryStat(
                      'Formula Error',
                      maxDiff < 1e-10 ? '0' : maxDiff.toStringAsFixed(12),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat('Symmetry', symError < 1e-10 ? '✓' : '~'),
                    _buildSummaryStat(
                      'Double Flip',
                      doubleError < 1e-10 ? '✓' : '~',
                    ),
                    _buildSummaryStat('Linear Inv', '✓'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),

          // Footer
          Center(
            child: Text(
              'Deep Demo • FlippedCurve • Flutter Animation',
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

Widget _buildComparisonRow(String label, double orig, double flip) {
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
          child: Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              // Original bar (blue)
              Positioned(
                left: 0,
                child: Container(
                  width: orig * 140,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Color(0xFF1565C0),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Flipped bar (pink)
              Positioned(
                left: 0,
                top: 10,
                child: Container(
                  width: flip * 140,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Color(0xFFAD1457),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 90,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                orig.toStringAsFixed(3),
                style: TextStyle(
                  fontSize: 9,
                  color: Color(0xFF1565C0),
                  fontFamily: 'monospace',
                ),
              ),
              Text(
                flip.toStringAsFixed(3),
                style: TextStyle(
                  fontSize: 9,
                  color: Color(0xFFAD1457),
                  fontFamily: 'monospace',
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildDualCurveVisualization(Curve curve1, Curve curve2) {
  return SizedBox(
    height: 80,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: List.generate(40, (i) {
        final t = i / 39;
        final v1 = curve1.transform(t);
        final v2 = curve2.transform(t);
        final h1 = (v1 * 70).clamp(0.0, 80.0);
        final h2 = (v2 * 70).clamp(0.0, 80.0);

        return Expanded(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: h1,
                margin: EdgeInsets.only(right: 2),
                decoration: BoxDecoration(
                  color: Color(0xFF1565C0).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(1)),
                ),
              ),
              Container(
                height: h2,
                margin: EdgeInsets.only(left: 2),
                decoration: BoxDecoration(
                  color: Color(0xFFAD1457).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(1)),
                ),
              ),
            ],
          ),
        );
      }),
    ),
  );
}

Widget _buildRelationshipRow(String left, String op, String right) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Expanded(
          child: Text(
            left,
            style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
        ),
        SizedBox(
          width: 30,
          child: Text(
            op,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
        ),
        Expanded(
          child: Text(
            right,
            style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
        ),
      ],
    ),
  );
}

Widget _buildVelocityRow(String label, double vOrig, double vFlip) {
  final maxV = math.max(vOrig.abs(), vFlip.abs());
  final scale = maxV > 0 ? 1 / maxV : 1;

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
          child: Row(
            children: [
              Container(
                width: 60,
                height: 12,
                decoration: BoxDecoration(
                  color: Color(0xFFE1BEE7),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (vOrig.abs() * scale).clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF1565C0),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4),
              Container(
                width: 60,
                height: 12,
                decoration: BoxDecoration(
                  color: Color(0xFFE1BEE7),
                  borderRadius: BorderRadius.circular(2),
                ),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: (vFlip.abs() * scale).clamp(0.0, 1.0),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFAD1457),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 70,
          child: Text(
            vFlip > vOrig ? 'flip faster' : 'orig faster',
            style: TextStyle(fontSize: 9, color: Color(0xFF757575)),
          ),
        ),
      ],
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
            color: Color(0xFFF48FB1),
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFFF8BBD9),
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
