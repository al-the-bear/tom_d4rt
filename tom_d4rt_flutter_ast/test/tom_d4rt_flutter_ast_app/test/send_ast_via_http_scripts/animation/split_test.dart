// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for Split from animation
// Split applies two different curves before and after a threshold
// Perfect for multi-phase animations with distinct behaviors
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                       SPLIT DEEP DEMO                             ║',
  );
  print(
    '║           Two-Phase Curve Composition                             ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: SPLIT FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: SPLIT FUNDAMENTALS                                     │',
  );
  print(
    '│ Understanding the two-phase curve                                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Split characteristics:');
  print('  • Applies one curve before threshold, another after');
  print('  • threshold: the point where curves switch (0.0-1.0)');
  print('  • beginCurve: used for t < threshold');
  print('  • endCurve: used for t >= threshold');
  print('  • Both curves rescaled to their phase');
  print('  • Creates complex multi-phase behaviors');
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
  // SECTION 2: SPLIT AT 0.5 (EQUAL PHASES)
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: SPLIT AT 0.5 (EQUAL PHASES)                            │',
  );
  print(
    '│ EaseIn first half, EaseOut second half                            │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final split50 = Split(
    0.5,
    beginCurve: Curves.easeIn,
    endCurve: Curves.easeOut,
  );
  final split50Results = <Map<String, dynamic>>[];

  print('Split(0.5) with easeIn/easeOut:');
  print(
    '┌───────┬─────────────────┬───────────┬────────────────────────────────────┐',
  );
  print(
    '│   t   │     Output      │   Phase   │   Visualization                    │',
  );
  print(
    '├───────┼─────────────────┼───────────┼────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final out = split50.transform(t);
    final phase = t < 0.5 ? 'Begin' : 'End';
    split50Results.add({'t': t, 'out': out, 'phase': phase});

    final barWidth = (out * 28).round().clamp(0, 28);
    final bar = '█' * barWidth + '░' * (28 - barWidth);
    print(
      '│ ${t.toStringAsFixed(1)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │   ${phase.padRight(5)}   │ $bar │',
    );
  }
  print(
    '└───────┴─────────────────┴───────────┴────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: SPLIT AT 0.25 (SHORT FIRST PHASE)
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: SPLIT AT 0.25 (SHORT FIRST PHASE)                      │',
  );
  print(
    '│ Quick start, long finish                                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final split25 = Split(
    0.25,
    beginCurve: Curves.easeIn,
    endCurve: Curves.linear,
  );
  final split25Results = <Map<String, dynamic>>[];

  print('Split(0.25) - easeIn for 25%, linear for 75%:');
  print(
    '┌───────┬─────────────────┬───────────┬────────────────────────────────────┐',
  );
  print(
    '│   t   │     Output      │   Phase   │   Progress                         │',
  );
  print(
    '├───────┼─────────────────┼───────────┼────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final out = split25.transform(t);
    final phase = t < 0.25 ? 'Begin' : 'End';
    split25Results.add({'t': t, 'out': out, 'phase': phase});

    final barWidth = (out * 28).round().clamp(0, 28);
    final bar = '▓' * barWidth + '░' * (28 - barWidth);
    print(
      '│ ${t.toStringAsFixed(1)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │   ${phase.padRight(5)}   │ $bar │',
    );
  }
  print(
    '└───────┴─────────────────┴───────────┴────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: SPLIT AT 0.75 (LONG FIRST PHASE)
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: SPLIT AT 0.75 (LONG FIRST PHASE)                       │',
  );
  print(
    '│ Long start, quick finish                                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final split75 = Split(
    0.75,
    beginCurve: Curves.linear,
    endCurve: Curves.easeOut,
  );
  final split75Results = <Map<String, dynamic>>[];

  print('Split(0.75) - linear for 75%, easeOut for 25%:');
  print(
    '┌───────┬─────────────────┬───────────┬────────────────────────────────────┐',
  );
  print(
    '│   t   │     Output      │   Phase   │   Progress                         │',
  );
  print(
    '├───────┼─────────────────┼───────────┼────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final out = split75.transform(t);
    final phase = t < 0.75 ? 'Begin' : 'End';
    split75Results.add({'t': t, 'out': out, 'phase': phase});

    final barWidth = (out * 28).round().clamp(0, 28);
    final bar = '▓' * barWidth + '░' * (28 - barWidth);
    print(
      '│ ${t.toStringAsFixed(1)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │   ${phase.padRight(5)}   │ $bar │',
    );
  }
  print(
    '└───────┴─────────────────┴───────────┴────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: CURVE COMBINATIONS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: CURVE COMBINATIONS                                     │',
  );
  print(
    '│ Different begin/end curve pairs                                   │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final combos = <Map<String, dynamic>>[
    {
      'name': 'ease/ease',
      'split': Split(0.5, beginCurve: Curves.easeIn, endCurve: Curves.easeOut),
    },
    {
      'name': 'linear/ease',
      'split': Split(
        0.5,
        beginCurve: Curves.linear,
        endCurve: Curves.easeInOut,
      ),
    },
    {
      'name': 'bounce/ease',
      'split': Split(
        0.5,
        beginCurve: Curves.bounceIn,
        endCurve: Curves.easeOut,
      ),
    },
    {
      'name': 'slow/fast',
      'split': Split(
        0.5,
        beginCurve: Curves.slowMiddle,
        endCurve: Curves.fastOutSlowIn,
      ),
    },
  ];

  final comboResults = <Map<String, dynamic>>[];

  print('Comparison at t=0.5 (threshold):');
  print(
    '┌────────────────┬──────────────────┬──────────────────┬──────────────────┐',
  );
  print(
    '│ Combination    │    at t=0.25     │    at t=0.50     │    at t=0.75     │',
  );
  print(
    '├────────────────┼──────────────────┼──────────────────┼──────────────────┤',
  );

  for (final combo in combos) {
    final split = combo['split'] as Split;
    final v25 = split.transform(0.25);
    final v50 = split.transform(0.50);
    final v75 = split.transform(0.75);
    comboResults.add({
      'name': combo['name'],
      'v25': v25,
      'v50': v50,
      'v75': v75,
    });
    print(
      '│ ${(combo['name'] as String).padRight(14)} │     ${v25.toStringAsFixed(4).padLeft(6)}       │     ${v50.toStringAsFixed(4).padLeft(6)}       │     ${v75.toStringAsFixed(4).padLeft(6)}       │',
    );
  }
  print(
    '└────────────────┴──────────────────┴──────────────────┴──────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: THRESHOLD BOUNDARY BEHAVIOR
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: THRESHOLD BOUNDARY BEHAVIOR                            │',
  );
  print(
    '│ Values near the split point                                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final boundaryResults = <Map<String, dynamic>>[];

  print('Values near threshold=0.5:');
  print(
    '┌─────────┬─────────────────┬───────────┬───────────────────────────────┐',
  );
  print(
    '│    t    │     Output      │   Curve   │   Status                      │',
  );
  print(
    '├─────────┼─────────────────┼───────────┼───────────────────────────────┤',
  );

  for (final t in [0.45, 0.48, 0.49, 0.50, 0.51, 0.52, 0.55]) {
    final out = split50.transform(t);
    final curve = t < 0.5 ? 'easeIn' : 'easeOut';
    String status;
    if (t == 0.5) {
      status = '← Split point!';
    } else if ((t - 0.5).abs() < 0.03)
      status = 'Near boundary';
    else
      status = '';
    boundaryResults.add({'t': t, 'out': out, 'curve': curve});
    print(
      '│  ${t.toStringAsFixed(2).padLeft(5)}  │     ${out.toStringAsFixed(4).padLeft(6)}      │  ${curve.padRight(7)} │ ${status.padRight(27)} │',
    );
  }
  print(
    '└─────────┴─────────────────┴───────────┴───────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: PHASE DURATION COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: PHASE DURATION COMPARISON                              │',
  );
  print(
    '│ Different split points                                            │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final thresholds = [0.1, 0.25, 0.5, 0.75, 0.9];
  final durationResults = <Map<String, dynamic>>[];

  print('Phase durations for different thresholds:');
  print(
    '┌───────────┬─────────────────┬─────────────────┬────────────────────┐',
  );
  print(
    '│ Threshold │ Begin Duration  │  End Duration   │   Ratio (B:E)      │',
  );
  print(
    '├───────────┼─────────────────┼─────────────────┼────────────────────┤',
  );

  for (final th in thresholds) {
    final beginDur = th;
    final endDur = 1.0 - th;
    final ratio = beginDur / endDur;
    durationResults.add({
      'th': th,
      'beginDur': beginDur,
      'endDur': endDur,
      'ratio': ratio,
    });
    print(
      '│   ${th.toStringAsFixed(2)}     │      ${beginDur.toStringAsFixed(2)}         │      ${endDur.toStringAsFixed(2)}         │   ${ratio.toStringAsFixed(2).padLeft(5)} : 1.00      │',
    );
  }
  print(
    '└───────────┴─────────────────┴─────────────────┴────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: SAME CURVE BOTH PHASES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: SAME CURVE BOTH PHASES                                 │',
  );
  print(
    '│ When both curves are identical                                    │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final splitLinear = Split(
    0.5,
    beginCurve: Curves.linear,
    endCurve: Curves.linear,
  );
  final splitEase = Split(
    0.5,
    beginCurve: Curves.easeInOut,
    endCurve: Curves.easeInOut,
  );
  final sameCurveResults = <Map<String, dynamic>>[];

  print('Same curve comparison:');
  print(
    '┌───────┬─────────────────┬─────────────────┬───────────────────────┐',
  );
  print(
    '│   t   │ Linear/Linear   │ EaseIO/EaseIO   │    Difference         │',
  );
  print(
    '├───────┼─────────────────┼─────────────────┼───────────────────────┤',
  );

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final lin = splitLinear.transform(t);
    final ease = splitEase.transform(t);
    final diff = (ease - lin).abs();
    sameCurveResults.add({'t': t, 'lin': lin, 'ease': ease, 'diff': diff});
    print(
      '│ ${t.toStringAsFixed(2)}  │     ${lin.toStringAsFixed(4).padLeft(6)}      │     ${ease.toStringAsFixed(4).padLeft(6)}      │     ${diff.toStringAsFixed(4).padLeft(6)}        │',
    );
  }
  print(
    '└───────┴─────────────────┴─────────────────┴───────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: PRACTICAL USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: PRACTICAL USE CASES                                    │',
  );
  print(
    '│ Common Split applications                                         │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('1. Menu Animation:');
  print('   Fast open (easeOut), slow settle (easeInOut)');
  print('   Split(0.3, Curves.easeOut, Curves.easeInOut)');
  print('');

  print('2. Bounce Entry:');
  print('   Quick entrance, bounce at end');
  print('   Split(0.6, Curves.easeOut, Curves.bounceOut)');
  print('');

  print('3. Two-Stage Reveal:');
  print('   Slow anticipation, fast reveal');
  print('   Split(0.7, Curves.slowMiddle, Curves.easeIn)');
  print('');

  print('4. Attention Animation:');
  print('   Scale up quickly, settle slowly');
  print('   Split(0.2, Curves.easeIn, Curves.elasticOut)');
  print('');

  print('5. Progress Indicator:');
  print('   Quick progress to 80%, slow to 100%');
  print('   Split(0.8, Curves.easeOut, Curves.easeInOut)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: EXTREME THRESHOLDS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: EXTREME THRESHOLDS                                    │',
  );
  print(
    '│ Very early and very late splits                                   │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final splitExtreme05 = Split(
    0.05,
    beginCurve: Curves.easeIn,
    endCurve: Curves.linear,
  );
  final splitExtreme95 = Split(
    0.95,
    beginCurve: Curves.linear,
    endCurve: Curves.easeOut,
  );
  final extremeResults = <Map<String, dynamic>>[];

  print('Extreme threshold comparisons:');
  print('┌───────┬─────────────────────┬─────────────────────┐');
  print('│   t   │    Split(0.05)      │    Split(0.95)      │');
  print('├───────┼─────────────────────┼─────────────────────┤');

  for (final t in tValues) {
    final v05 = splitExtreme05.transform(t);
    final v95 = splitExtreme95.transform(t);
    extremeResults.add({'t': t, 'v05': v05, 'v95': v95});
    print(
      '│ ${t.toStringAsFixed(1)}   │       ${v05.toStringAsFixed(4).padLeft(6)}        │       ${v95.toStringAsFixed(4).padLeft(6)}        │',
    );
  }
  print('└───────┴─────────────────────┴─────────────────────┘');
  print('');
  print('Note: Extreme thresholds mean one phase is very short');
  print('      and the other dominates the animation.');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                        SPLIT SUMMARY                              ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('Split key features:');
  print('  • Combines two curves with threshold');
  print('  • Each curve rescaled to its phase duration');
  print('  • Threshold controls phase balance');
  print('  • Creates multi-phase behaviors');
  print('');
  print('Best use cases:');
  print('  • Menu open/settle animations');
  print('  • Bounce entry effects');
  print('  • Two-stage reveals');
  print('  • Progress indicators');
  print('');
  print('Split Deep Demo completed');

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
                colors: [Color(0xFF00695C), Color(0xFF4DB6AC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'Split',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Two-Phase Curve Composition',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFB2DFDB)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // How Split Works
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
                  'HOW SPLIT WORKS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00695C),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildSplitDiagram(),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Split Curve Visualizations
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF263238),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'SPLIT CURVES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildSplitGraph(
                  'Split(0.25)',
                  split25,
                  0.25,
                  Color(0xFFFF9800),
                ),
                SizedBox(height: 8),
                _buildSplitGraph(
                  'Split(0.50)',
                  split50,
                  0.50,
                  Color(0xFF4CAF50),
                ),
                SizedBox(height: 8),
                _buildSplitGraph(
                  'Split(0.75)',
                  split75,
                  0.75,
                  Color(0xFF2196F3),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Threshold Comparison
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFF3E0),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'THRESHOLD EFFECTS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...durationResults.map((r) => _buildThresholdRow(r)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Curve Combinations
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
                  'CURVE COMBINATIONS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...comboResults.map((r) => _buildComboRow(r)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Use Cases
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
                  'USE CASES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildUseCaseItem('Menu Animation', 'Fast open + slow settle'),
                _buildUseCaseItem('Bounce Entry', 'Quick entrance + bounce'),
                _buildUseCaseItem(
                  'Two-Stage Reveal',
                  'Slow anticipation + fast reveal',
                ),
                _buildUseCaseItem('Progress', 'Fast to 80%, slow to 100%'),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Summary Stats
          Container(
            decoration: BoxDecoration(
              color: Color(0xFF37474F),
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
                    _buildSummaryStat('Thresholds', '5'),
                    _buildSummaryStat('Combos', '${combos.length}'),
                    _buildSummaryStat('Sections', '10'),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat(
                      'Split(0.25)',
                      split25.transform(0.5).toStringAsFixed(2),
                    ),
                    _buildSummaryStat(
                      'Split(0.50)',
                      split50.transform(0.5).toStringAsFixed(2),
                    ),
                    _buildSummaryStat(
                      'Split(0.75)',
                      split75.transform(0.5).toStringAsFixed(2),
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
              'Deep Demo • Split • Flutter Animation',
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

Widget _buildSplitDiagram() {
  return Container(
    padding: EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Color(0xFFFFFFFF),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Color(0xFF80CBC4)),
    ),
    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Color(0xFFFF9800),
                  borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    'Begin Curve',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(width: 2, height: 30, color: Color(0xFF00695C)),
            Expanded(
              flex: 1,
              child: Container(
                height: 30,
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.horizontal(
                    right: Radius.circular(4),
                  ),
                ),
                child: Center(
                  child: Text(
                    'End Curve',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              't = 0.0',
              style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
            ),
            Text(
              'threshold',
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Color(0xFF00695C),
              ),
            ),
            Text(
              't = 1.0',
              style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
            ),
          ],
        ),
      ],
    ),
  );
}

Widget _buildSplitGraph(
  String label,
  Split split,
  double threshold,
  Color color,
) {
  return Row(
    children: [
      SizedBox(
        width: 75,
        child: Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ),
      Expanded(
        child: SizedBox(
          height: 30,
          child: CustomPaint(
            painter: SplitCurvePainter(split, threshold, color),
            size: Size(double.infinity, 30),
          ),
        ),
      ),
    ],
  );
}

class SplitCurvePainter extends CustomPainter {
  final Split split;
  final double threshold;
  final Color color;

  SplitCurvePainter(this.split, this.threshold, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height);

    for (var i = 0; i <= 100; i++) {
      final t = i / 100;
      final value = split.transform(t);
      path.lineTo(t * size.width, size.height - value * (size.height - 4));
    }

    canvas.drawPath(path, paint);

    // Draw threshold line
    final thresholdPaint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1;
    canvas.drawLine(
      Offset(threshold * size.width, 0),
      Offset(threshold * size.width, size.height),
      thresholdPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildThresholdRow(Map<String, dynamic> r) {
  final th = r['th'] as double;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            '${(th * 100).toStringAsFixed(0)}%',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFFFFE0B2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: th * 200,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFFFF9800),
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(4),
                      ),
                    ),
                  ),
                  Container(
                    width: (1 - th) * 200,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Color(0xFF4CAF50),
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          width: 60,
          alignment: Alignment.centerRight,
          child: Text(
            '${th.toStringAsFixed(2)}:${(1 - th).toStringAsFixed(2)}',
            style: TextStyle(fontSize: 9, fontFamily: 'monospace'),
          ),
        ),
      ],
    ),
  );
}

Widget _buildComboRow(Map<String, dynamic> r) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(
          width: 70,
          child: Text(
            r['name'] as String,
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
          ),
        ),
        _buildSmallValue(
          (r['v25'] as double).toStringAsFixed(2),
          Color(0xFFFF9800),
        ),
        SizedBox(width: 8),
        _buildSmallValue(
          (r['v50'] as double).toStringAsFixed(2),
          Color(0xFF4CAF50),
        ),
        SizedBox(width: 8),
        _buildSmallValue(
          (r['v75'] as double).toStringAsFixed(2),
          Color(0xFF2196F3),
        ),
      ],
    ),
  );
}

Widget _buildSmallValue(String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      value,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
    ),
  );
}

Widget _buildUseCaseItem(String title, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.arrow_forward, size: 14, color: Color(0xFF1565C0)),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
              ),
              Text(
                description,
                style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
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
