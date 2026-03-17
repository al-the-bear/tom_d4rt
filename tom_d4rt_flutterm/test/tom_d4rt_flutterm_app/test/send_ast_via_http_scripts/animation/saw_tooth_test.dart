// D4rt test script: Deep Demo for SawTooth from animation
// SawTooth creates a repeating linear sawtooth pattern
// Perfect for looping animations and progress indicators
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                    SAW TOOTH DEEP DEMO                            ║',
  );
  print(
    '║            Repeating Linear Pattern Animation                     ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: SAW TOOTH FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: SAW TOOTH FUNDAMENTALS                                 │',
  );
  print(
    '│ Understanding the repeating pattern                               │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('SawTooth characteristics:');
  print('  • Creates a repeating linear ramp pattern');
  print('  • Count parameter: number of complete cycles');
  print('  • Formula: (t * count) % 1.0');
  print('  • Each cycle: rises from 0 to ~1, then resets to 0');
  print('  • Perfect for looping animations');
  print('');

  // Create sawtooth curves with different counts
  final saw1 = SawTooth(1);
  final saw2 = SawTooth(2);
  final saw3 = SawTooth(3);
  final saw4 = SawTooth(4);
  final saw5 = SawTooth(5);
  print('✓ Created SawTooth curves with counts 1-5');
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
  // SECTION 2: SAWTOOTH(1) - SINGLE CYCLE
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: SAWTOOTH(1) - SINGLE CYCLE                             │',
  );
  print(
    '│ Identity transformation (same as linear)                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final saw1Results = <Map<String, dynamic>>[];

  print('SawTooth(1) - single cycle:');
  print(
    '┌───────┬─────────────────┬───────────────────────────────────────────┐',
  );
  print(
    '│   t   │     Output      │   Visualization                           │',
  );
  print(
    '├───────┼─────────────────┼───────────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final out = saw1.transform(t);
    saw1Results.add({'t': t, 'out': out});

    final barWidth = (out * 35).round().clamp(0, 35);
    final bar = '█' * barWidth + '░' * (35 - barWidth);
    print(
      '│ ${t.toStringAsFixed(1)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │ $bar │',
    );
  }
  print(
    '└───────┴─────────────────┴───────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: SAWTOOTH(2) - TWO CYCLES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: SAWTOOTH(2) - TWO CYCLES                               │',
  );
  print(
    '│ Pattern repeats twice                                             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final saw2Results = <Map<String, dynamic>>[];

  print('SawTooth(2) visualization:');
  print(
    '┌───────┬─────────────────┬─────────┬────────────────────────────────┐',
  );
  print(
    '│   t   │     Output      │  Cycle  │   Pattern                      │',
  );
  print(
    '├───────┼─────────────────┼─────────┼────────────────────────────────┤',
  );

  for (var i = 0; i <= 20; i++) {
    final t = i / 20;
    final out = saw2.transform(t);
    final cycle = (t * 2).floor();
    saw2Results.add({'t': t, 'out': out, 'cycle': cycle});

    final barWidth = (out * 26).round().clamp(0, 26);
    final bar = '▓' * barWidth + '░' * (26 - barWidth);
    print(
      '│ ${t.toStringAsFixed(2)}  │     ${out.toStringAsFixed(4).padLeft(6)}      │    ${cycle + 1}    │ $bar │',
    );
  }
  print(
    '└───────┴─────────────────┴─────────┴────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: SAWTOOTH(3) - THREE CYCLES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: SAWTOOTH(3) - THREE CYCLES                             │',
  );
  print(
    '│ Pattern repeats three times                                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final saw3Results = <Map<String, dynamic>>[];

  print('SawTooth(3) cycle boundaries:');
  print('  Cycle 1: t ∈ [0.000, 0.333)');
  print('  Cycle 2: t ∈ [0.333, 0.667)');
  print('  Cycle 3: t ∈ [0.667, 1.000]');
  print('');
  print(
    '┌───────┬─────────────────┬─────────┬────────────────────────────────┐',
  );
  print(
    '│   t   │     Output      │  Cycle  │   Wave Pattern                 │',
  );
  print(
    '├───────┼─────────────────┼─────────┼────────────────────────────────┤',
  );

  for (var i = 0; i <= 15; i++) {
    final t = i / 15;
    final out = saw3.transform(t);
    final cycle = (t * 3).floor().clamp(0, 2);
    saw3Results.add({'t': t, 'out': out, 'cycle': cycle});

    final barWidth = (out * 24).round().clamp(0, 24);
    final bar = '█' * barWidth + '░' * (24 - barWidth);
    print(
      '│ ${t.toStringAsFixed(2)}  │     ${out.toStringAsFixed(4).padLeft(6)}      │    ${cycle + 1}    │ $bar │',
    );
  }
  print(
    '└───────┴─────────────────┴─────────┴────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: FORMULA VERIFICATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: FORMULA VERIFICATION                                   │',
  );
  print(
    '│ Checking: output = (t * count) % 1.0                              │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final formulaResults = <Map<String, dynamic>>[];
  var formulaValid = true;

  print('Formula verification for SawTooth(4):');
  print('┌───────┬─────────────────┬─────────────────┬───────────────┐');
  print('│   t   │   transform()   │  (t*4) % 1.0    │   Diff        │');
  print('├───────┼─────────────────┼─────────────────┼───────────────┤');

  for (final t in tValues) {
    final sawVal = saw4.transform(t);
    final formulaVal = (t * 4) % 1.0;
    final diff = (sawVal - formulaVal).abs();
    if (diff > 0.0001) formulaValid = false;
    formulaResults.add({
      't': t,
      'saw': sawVal,
      'formula': formulaVal,
      'diff': diff,
    });
    print(
      '│ ${t.toStringAsFixed(1)}   │     ${sawVal.toStringAsFixed(6).padLeft(8)}    │     ${formulaVal.toStringAsFixed(6).padLeft(8)}    │  ${diff.toStringAsFixed(8).padLeft(10)}   │',
    );
  }
  print('└───────┴─────────────────┴─────────────────┴───────────────┘');
  print('');
  print(
    'Result: ${formulaValid ? '✓ Formula verified!' : '✗ Mismatch detected'}',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: CYCLE COUNT COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: CYCLE COUNT COMPARISON                                 │',
  );
  print(
    '│ Different counts at same t values                                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final compResults = <Map<String, dynamic>>[];

  print('Comparison at key t values:');
  print('┌───────┬──────────┬──────────┬──────────┬──────────┬──────────┐');
  print('│   t   │  Saw(1)  │  Saw(2)  │  Saw(3)  │  Saw(4)  │  Saw(5)  │');
  print('├───────┼──────────┼──────────┼──────────┼──────────┼──────────┤');

  for (final t in tValues) {
    final s1 = saw1.transform(t);
    final s2 = saw2.transform(t);
    final s3 = saw3.transform(t);
    final s4 = saw4.transform(t);
    final s5 = saw5.transform(t);
    compResults.add({'t': t, 's1': s1, 's2': s2, 's3': s3, 's4': s4, 's5': s5});
    print(
      '│ ${t.toStringAsFixed(1)}   │  ${s1.toStringAsFixed(2).padLeft(5)}   │  ${s2.toStringAsFixed(2).padLeft(5)}   │  ${s3.toStringAsFixed(2).padLeft(5)}   │  ${s4.toStringAsFixed(2).padLeft(5)}   │  ${s5.toStringAsFixed(2).padLeft(5)}   │',
    );
  }
  print('└───────┴──────────┴──────────┴──────────┴──────────┴──────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: DISCONTINUITY POINTS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: DISCONTINUITY POINTS                                   │',
  );
  print(
    '│ Where the pattern resets                                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('SawTooth(4) discontinuity analysis:');
  print('  Reset points at t = 0.25, 0.5, 0.75');
  print('');

  final discontinuityResults = <Map<String, dynamic>>[];

  print('Values near reset points:');
  print(
    '┌─────────┬─────────────────┬────────────────────────────────────────┐',
  );
  print(
    '│    t    │     Output      │   Status                               │',
  );
  print(
    '├─────────┼─────────────────┼────────────────────────────────────────┤',
  );

  for (final t in [
    0.24,
    0.249,
    0.25,
    0.251,
    0.26,
    0.49,
    0.5,
    0.51,
    0.74,
    0.75,
    0.76,
  ]) {
    final out = saw4.transform(t);
    String status;
    if ((t * 4) % 1.0 < 0.1)
      status = '↓ Just reset';
    else if ((t * 4) % 1.0 > 0.9)
      status = '↑ About to reset';
    else
      status = '  Mid-cycle';
    discontinuityResults.add({'t': t, 'out': out, 'status': status});
    print(
      '│  ${t.toStringAsFixed(3).padLeft(5)}  │     ${out.toStringAsFixed(4).padLeft(6)}      │ ${status.padRight(38)} │',
    );
  }
  print(
    '└─────────┴─────────────────┴────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: PRACTICAL APPLICATIONS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: PRACTICAL APPLICATIONS                                 │',
  );
  print(
    '│ Common use cases for SawTooth                                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('1. Progress Indicator Loop:');
  print('   Use SawTooth(1) with repeat animation for endless progress');
  print('');

  print('2. Carousel/Slide Animation:');
  print('   SawTooth(n) where n = number of slides');
  print('');

  print('3. Pulse Effect:');
  print('   High count SawTooth for rapid pulsing');
  print('');

  print('4. Scanning Animation:');
  print('   Line moving across screen repeatedly');
  print('');

  print('5. Loading Shimmer:');
  print('   Gradient position cycling');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: FREQUENCY ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: FREQUENCY ANALYSIS                                     │',
  );
  print(
    '│ Cycle duration and frequency                                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final freqResults = <Map<String, dynamic>>[];

  print('Timing analysis for different counts:');
  print('┌─────────────┬────────────────────┬─────────────────────────────┐');
  print('│   Count     │   Cycle Duration   │   Frequency (cycles/unit)   │');
  print('├─────────────┼────────────────────┼─────────────────────────────┤');

  for (final count in [1, 2, 3, 4, 5, 10]) {
    final duration = 1.0 / count;
    final freq = count.toDouble();
    freqResults.add({'count': count, 'duration': duration, 'freq': freq});
    print(
      '│     ${count.toString().padLeft(2)}      │       ${duration.toStringAsFixed(4).padLeft(6)}         │           ${freq.toStringAsFixed(1).padLeft(4)}              │',
    );
  }
  print('└─────────────┴────────────────────┴─────────────────────────────┘');
  print('');
  print('Note: With 1-second animation, SawTooth(4) completes');
  print('      4 cycles, each lasting 0.25 seconds');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: HIGH FREQUENCY DEMO
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: HIGH FREQUENCY DEMO                                   │',
  );
  print(
    '│ SawTooth(10) - rapid pulsing                                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final saw10 = SawTooth(10);
  final highFreqResults = <Map<String, dynamic>>[];

  print('SawTooth(10) pattern (10 cycles in unit time):');
  print(
    '┌───────┬─────────────────┬─────────┬────────────────────────────────┐',
  );
  print(
    '│   t   │     Output      │  Cycle  │   Rapid Pattern                │',
  );
  print(
    '├───────┼─────────────────┼─────────┼────────────────────────────────┤',
  );

  for (var i = 0; i <= 20; i++) {
    final t = i / 20;
    final out = saw10.transform(t);
    final cycle = (t * 10).floor().clamp(0, 9) + 1;
    highFreqResults.add({'t': t, 'out': out, 'cycle': cycle});

    final barWidth = (out * 24).round().clamp(0, 24);
    final bar = '█' * barWidth + '░' * (24 - barWidth);
    print(
      '│ ${t.toStringAsFixed(2)}  │     ${out.toStringAsFixed(4).padLeft(6)}      │   ${cycle.toString().padLeft(2)}    │ $bar │',
    );
  }
  print(
    '└───────┴─────────────────┴─────────┴────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                     SAW TOOTH SUMMARY                             ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('SawTooth key features:');
  print('  • Creates repeating linear ramp pattern');
  print('  • Formula: (t * count) % 1.0');
  print('  • Higher count = more cycles');
  print('  • Discontinuous at cycle boundaries');
  print('');
  print('Best use cases:');
  print('  • Looping progress indicators');
  print('  • Carousel animations');
  print('  • Pulse/shimmer effects');
  print('  • Scanning/sweeping animations');
  print('');
  print('SawTooth Deep Demo completed');

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
                colors: [Color(0xFF5D4037), Color(0xFF8D6E63)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'SawTooth',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Repeating Linear Pattern Animation',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFD7CCC8)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Formula Section
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFEFEBE9),
              borderRadius: BorderRadius.circular(8.0),
            ),
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'FORMULA',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFFBCAAA4)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'output = (t × count) mod 1.0',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Each cycle: 0 → 1 → 0 → 1 ...',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF757575),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // SawTooth Visualization
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
                  'SAWTOOTH PATTERNS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildSawtoothGraph('Count: 1', saw1, Color(0xFF4CAF50)),
                SizedBox(height: 8),
                _buildSawtoothGraph('Count: 2', saw2, Color(0xFF2196F3)),
                SizedBox(height: 8),
                _buildSawtoothGraph('Count: 3', saw3, Color(0xFFFF9800)),
                SizedBox(height: 8),
                _buildSawtoothGraph('Count: 4', saw4, Color(0xFFE91E63)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Cycle Comparison
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
                  'CYCLE COMPARISON',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...compResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map((r) => _buildComparisonRow(r)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Frequency Table
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
                  'FREQUENCY ANALYSIS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...freqResults.map((r) => _buildFrequencyRow(r)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Use Cases
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
                  'USE CASES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildUseCaseItem('Progress Loop', 'Endless loading indicator'),
                _buildUseCaseItem('Carousel', 'Auto-scrolling slides'),
                _buildUseCaseItem(
                  'Pulse Effect',
                  'Attention-grabbing animation',
                ),
                _buildUseCaseItem('Shimmer', 'Loading placeholder effect'),
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
                    _buildSummaryStat('Counts Tested', '6'),
                    _buildSummaryStat('Test Points', '${tValues.length}'),
                    _buildSummaryStat('Formula', formulaValid ? '✓' : '✗'),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat(
                      'Saw2(0.3)',
                      saw2.transform(0.3).toStringAsFixed(2),
                    ),
                    _buildSummaryStat(
                      'Saw3(0.5)',
                      saw3.transform(0.5).toStringAsFixed(2),
                    ),
                    _buildSummaryStat(
                      'Saw4(0.7)',
                      saw4.transform(0.7).toStringAsFixed(2),
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
              'Deep Demo • SawTooth • Flutter Animation',
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

Widget _buildSawtoothGraph(String label, SawTooth curve, Color color) {
  return Row(
    children: [
      Container(
        width: 65,
        child: Text(
          label,
          style: TextStyle(color: Colors.white70, fontSize: 11),
        ),
      ),
      Expanded(
        child: Container(
          height: 30,
          child: CustomPaint(
            painter: SawtoothLinePainter(curve, color),
            size: Size(double.infinity, 30),
          ),
        ),
      ),
    ],
  );
}

class SawtoothLinePainter extends CustomPainter {
  final SawTooth curve;
  final Color color;

  SawtoothLinePainter(this.curve, this.color);

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
      final value = curve.transform(t);
      path.lineTo(t * size.width, size.height - value * (size.height - 4));
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildComparisonRow(Map<String, dynamic> r) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 45,
          child: Text(
            't=${(r['t'] as double).toStringAsFixed(2)}',
            style: TextStyle(fontSize: 11),
          ),
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSmallValue(
                (r['s1'] as double).toStringAsFixed(2),
                Color(0xFF4CAF50),
              ),
              _buildSmallValue(
                (r['s2'] as double).toStringAsFixed(2),
                Color(0xFF2196F3),
              ),
              _buildSmallValue(
                (r['s3'] as double).toStringAsFixed(2),
                Color(0xFFFF9800),
              ),
              _buildSmallValue(
                (r['s4'] as double).toStringAsFixed(2),
                Color(0xFFE91E63),
              ),
              _buildSmallValue(
                (r['s5'] as double).toStringAsFixed(2),
                Color(0xFF9C27B0),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildSmallValue(String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: color.withOpacity(0.2),
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text(
      value,
      style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: color),
    ),
  );
}

Widget _buildFrequencyRow(Map<String, dynamic> r) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 60,
          child: Text(
            'Count: ${r['count']}',
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: Container(
            height: 16,
            decoration: BoxDecoration(
              color: Color(0xFFE1BEE7),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: ((r['count'] as int) / 10).clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF7B1FA2),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 70,
          alignment: Alignment.centerRight,
          child: Text(
            '${(r['duration'] as double).toStringAsFixed(3)}s/cycle',
            style: TextStyle(fontSize: 9, fontFamily: 'monospace'),
          ),
        ),
      ],
    ),
  );
}

Widget _buildUseCaseItem(String title, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '• ',
          style: TextStyle(
            color: Color(0xFFF57C00),
            fontWeight: FontWeight.bold,
          ),
        ),
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
