// D4rt test script: Deep Demo for Threshold from animation
// Threshold is a step function curve - outputs 0 before threshold, 1 at/after
// Useful for binary state changes in animations
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                    THRESHOLD DEEP DEMO                            ║');
  print('║              Step Function for Binary State Changes               ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: THRESHOLD FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: THRESHOLD FUNDAMENTALS                                 │');
  print('│ Understanding the step function behavior                          │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  
  print('Threshold characteristics:');
  print('  • Binary curve - only outputs 0 or 1');
  print('  • Threshold parameter controls the switch point');
  print('  • Returns 0.0 for t < threshold');
  print('  • Returns 1.0 for t >= threshold');
  print('  • No interpolation - instant change');
  print('  • Perfect for toggle/visibility animations');
  print('');

  final threshold50 = Threshold(0.5);
  print('Created Threshold(0.5):');
  print('  threshold: 0.5 (middle of animation)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: THRESHOLD 0.5 (CENTER)
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: THRESHOLD 0.5 (CENTER)                                 │');
  print('│ Step function at animation midpoint                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final t50Results = <Map<String, dynamic>>[];
  final fineSteps = <double>[0.0, 0.1, 0.2, 0.3, 0.4, 0.45, 0.49, 0.5, 0.51, 0.55, 0.6, 0.7, 0.8, 0.9, 1.0];
  
  print('Threshold(0.5) values:');
  print('┌───────┬─────────────────┬────────────────────────────────────────────┐');
  print('│   t   │     Output      │   State                                    │');
  print('├───────┼─────────────────┼────────────────────────────────────────────┤');
  
  for (final t in fineSteps) {
    final out = threshold50.transform(t);
    final state = out == 0.0 ? '░░░░░░░░░░░░░░░░░░░░ OFF' : '████████████████████ ON ';
    t50Results.add({'t': t, 'out': out, 'state': out == 0.0 ? 'OFF' : 'ON'});
    print('│ ${t.toStringAsFixed(2).padLeft(4)}  │       ${out.toStringAsFixed(1)}         │ $state │');
  }
  print('└───────┴─────────────────┴────────────────────────────────────────────┘');
  print('');
  print('Note: Switches from OFF to ON exactly at t=0.5');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: THRESHOLD 0.0 (IMMEDIATE)
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: THRESHOLD 0.0 (IMMEDIATE)                              │');
  print('│ Instant activation at start                                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final threshold0 = Threshold(0.0);
  final t0Results = <Map<String, dynamic>>[];
  
  print('Threshold(0.0) - immediate ON:');
  print('┌───────────┬─────────────────┬───────────────────────────────────────┐');
  print('│     t     │     Output      │   State                               │');
  print('├───────────┼─────────────────┼───────────────────────────────────────┤');
  
  for (final t in [0.0, 0.001, 0.01, 0.1, 0.5, 1.0]) {
    final out = threshold0.transform(t);
    String state = out == 0.0 ? '░░░░░░░░░░░░░░░░░░░░ OFF' : '████████████████████ ON ';
    t0Results.add({'t': t, 'out': out});
    print('│  ${t.toStringAsFixed(3).padLeft(6)}   │       ${out.toStringAsFixed(1)}         │ $state │');
  }
  print('└───────────┴─────────────────┴───────────────────────────────────────┘');
  print('');
  print('Note: ON from the very start (t >= 0.0)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: THRESHOLD 1.0 (DELAYED)
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: THRESHOLD 1.0 (DELAYED)                                │');
  print('│ Activation only at completion                                     │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final threshold1 = Threshold(1.0);
  final t1Results = <Map<String, dynamic>>[];
  
  print('Threshold(1.0) - delayed until end:');
  print('┌───────────┬─────────────────┬───────────────────────────────────────┐');
  print('│     t     │     Output      │   State                               │');
  print('├───────────┼─────────────────┼───────────────────────────────────────┤');
  
  for (final t in [0.0, 0.5, 0.9, 0.99, 0.999, 1.0]) {
    final out = threshold1.transform(t);
    String state = out == 0.0 ? '░░░░░░░░░░░░░░░░░░░░ OFF' : '████████████████████ ON ';
    t1Results.add({'t': t, 'out': out});
    print('│  ${t.toStringAsFixed(3).padLeft(6)}   │       ${out.toStringAsFixed(1)}         │ $state │');
  }
  print('└───────────┴─────────────────┴───────────────────────────────────────┘');
  print('');
  print('Note: OFF until exactly t=1.0');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: VARIOUS THRESHOLDS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: VARIOUS THRESHOLDS                                     │');
  print('│ Comparing different threshold values                              │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final threshold25 = Threshold(0.25);
  final threshold75 = Threshold(0.75);
  final threshold10 = Threshold(0.1);
  final threshold90 = Threshold(0.9);
  
  final variousResults = <Map<String, dynamic>>[];
  
  print('Threshold comparison at different thresholds:');
  print('┌────────┬────────┬────────┬────────┬────────┬────────┐');
  print('│    t   │  0.10  │  0.25  │  0.50  │  0.75  │  0.90  │');
  print('├────────┼────────┼────────┼────────┼────────┼────────┤');
  
  for (final t in [0.0, 0.05, 0.1, 0.15, 0.25, 0.3, 0.5, 0.6, 0.75, 0.8, 0.9, 0.95, 1.0]) {
    final v10 = threshold10.transform(t);
    final v25 = threshold25.transform(t);
    final v50 = threshold50.transform(t);
    final v75 = threshold75.transform(t);
    final v90 = threshold90.transform(t);
    variousResults.add({'t': t, 'v10': v10, 'v25': v25, 'v50': v50, 'v75': v75, 'v90': v90});
    
    final s10 = v10 == 0.0 ? ' OFF ' : ' ON  ';
    final s25 = v25 == 0.0 ? ' OFF ' : ' ON  ';
    final s50 = v50 == 0.0 ? ' OFF ' : ' ON  ';
    final s75 = v75 == 0.0 ? ' OFF ' : ' ON  ';
    final s90 = v90 == 0.0 ? ' OFF ' : ' ON  ';
    print('│  ${t.toStringAsFixed(2).padLeft(4)}  │$s10 │$s25 │$s50 │$s75 │$s90 │');
  }
  print('└────────┴────────┴────────┴────────┴────────┴────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: FINE-GRAINED BOUNDARY
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: FINE-GRAINED BOUNDARY                                  │');
  print('│ Exact behavior at threshold edge                                  │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final boundaryResults = <Map<String, dynamic>>[];
  
  print('Values around threshold=0.5:');
  print('┌────────────────┬─────────────────┬──────────────────────────────────┐');
  print('│        t       │     Output      │   Analysis                       │');
  print('├────────────────┼─────────────────┼──────────────────────────────────┤');
  
  for (final t in [0.49, 0.499, 0.4999, 0.5, 0.5001, 0.501, 0.51]) {
    final out = threshold50.transform(t);
    String analysis;
    if (t < 0.5) analysis = 'Before threshold → OFF';
    else if (t == 0.5) analysis = 'AT threshold → ON ←';
    else analysis = 'After threshold → ON';
    boundaryResults.add({'t': t, 'out': out, 'analysis': analysis});
    print('│   ${t.toStringAsFixed(4).padLeft(10)}   │       ${out.toStringAsFixed(1)}         │ ${analysis.padRight(28)} │');
  }
  print('└────────────────┴─────────────────┴──────────────────────────────────┘');
  print('');
  print('✓ Threshold checks: t >= threshold (inclusive)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: MULTI-STEP REVEAL
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: MULTI-STEP REVEAL                                      │');
  print('│ Combining thresholds for sequential reveals                       │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final step1 = Threshold(0.2);
  final step2 = Threshold(0.4);
  final step3 = Threshold(0.6);
  final step4 = Threshold(0.8);
  
  final multiStepResults = <Map<String, dynamic>>[];
  
  print('Multi-step reveal (5 elements):');
  print('┌───────┬─────────┬─────────┬─────────┬─────────┬───────────────────┐');
  print('│   t   │  @0.2   │  @0.4   │  @0.6   │  @0.8   │  Visible Count    │');
  print('├───────┼─────────┼─────────┼─────────┼─────────┼───────────────────┤');
  
  for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]) {
    final s1 = step1.transform(t);
    final s2 = step2.transform(t);
    final s3 = step3.transform(t);
    final s4 = step4.transform(t);
    final count = (s1 + s2 + s3 + s4).toInt() + 1; // +1 for base that's always visible
    multiStepResults.add({'t': t, 's1': s1, 's2': s2, 's3': s3, 's4': s4, 'count': count});
    
    final v1 = s1 == 1.0 ? ' ■ ' : ' □ ';
    final v2 = s2 == 1.0 ? ' ■ ' : ' □ ';
    final v3 = s3 == 1.0 ? ' ■ ' : ' □ ';
    final v4 = s4 == 1.0 ? ' ■ ' : ' □ ';
    print('│ ${t.toStringAsFixed(1)}   │  $v1  │  $v2  │  $v3  │  $v4  │     $count / 5         │');
  }
  print('└───────┴─────────┴─────────┴─────────┴─────────┴───────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: OPACITY APPLICATION
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: OPACITY APPLICATION                                    │');
  print('│ Using Threshold for fade-in timing                                │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final opacityResults = <Map<String, dynamic>>[];
  
  print('Opacity with Threshold vs Linear:');
  print('┌───────┬────────────────┬────────────────┬───────────────────────────┐');
  print('│   t   │  Threshold(0.3)│    Linear      │   Visual Comparison       │');
  print('├───────┼────────────────┼────────────────┼───────────────────────────┤');
  
  final threshold30 = Threshold(0.3);
  for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]) {
    final thresholdOpacity = threshold30.transform(t);
    final linearOpacity = t;
    opacityResults.add({'t': t, 'thresh': thresholdOpacity, 'linear': linearOpacity});
    
    final tBar = thresholdOpacity == 0.0 ? '░░░░░░░░░░░░' : '████████████';
    final lBar = '█' * (linearOpacity * 12).round() + '░' * (12 - (linearOpacity * 12).round());
    print('│ ${t.toStringAsFixed(1)}   │      ${thresholdOpacity.toStringAsFixed(1)}       │      ${linearOpacity.toStringAsFixed(1)}       │ T:$tBar L:$lBar │');
  }
  print('└───────┴────────────────┴────────────────┴───────────────────────────┘');
  print('');
  print('Threshold: instant appear | Linear: gradual fade');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: WITH CURVES TRANSFORM
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: WITH CURVES TRANSFORM                                  │');
  print('│ Threshold combined with other curves                              │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final combinedResults = <Map<String, dynamic>>[];
  
  print('Using easeIn.transform then checking threshold:');
  print('┌───────┬────────────────┬──────────────────┬─────────────────────────┐');
  print('│   t   │   easeIn(t)    │ Thresh(easeIn(t))│   Result                │');
  print('├───────┼────────────────┼──────────────────┼─────────────────────────┤');
  
  for (final t in [0.0, 0.2, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]) {
    final eased = Curves.easeIn.transform(t);
    final threshResult = threshold50.transform(eased);
    combinedResults.add({'t': t, 'eased': eased, 'result': threshResult});
    
    final result = threshResult == 0.0 ? 'OFF (waiting)' : 'ON  (triggered)';
    print('│ ${t.toStringAsFixed(1)}   │     ${eased.toStringAsFixed(4).padLeft(6)}     │       ${threshResult.toStringAsFixed(1)}          │ ${result.padRight(17)} │');
  }
  print('└───────┴────────────────┴──────────────────┴─────────────────────────┘');
  print('');
  print('Note: With easeIn, threshold is reached later in real time');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PRACTICAL USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: PRACTICAL USE CASES                                   │');
  print('│ When to use Threshold                                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('1. Visibility Toggle:');
  print('   Show/hide elements at specific animation point');
  print('   Example: Threshold(0.5) for midpoint visibility');
  print('');

  print('2. Sequential Reveals:');
  print('   Multiple elements appearing one after another');
  print('   Example: Threshold(0.2), Threshold(0.4), etc.');
  print('');

  print('3. State Indicators:');
  print('   Binary on/off states in animations');
  print('   Example: Loading → Loaded transition');
  print('');

  print('4. Checkpoint Actions:');
  print('   Trigger actions at animation checkpoints');
  print('   Example: Sound effect at 50% progress');
  print('');

  print('5. Delayed Appearance:');
  print('   Elements that should wait before showing');
  print('   Example: Threshold(0.8) for late reveal');
  print('');

  print('6. Conditional Animations:');
  print('   Sub-animations that start after a point');
  print('   Example: Secondary animation after main');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                    THRESHOLD SUMMARY                              ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');
  print('Threshold key features:');
  print('  • Binary output: 0 or 1 only');
  print('  • Instant transition at threshold');
  print('  • No interpolation between states');
  print('  • Perfect for visibility control');
  print('');
  print('Formula: output = (t >= threshold) ? 1.0 : 0.0');
  print('');
  print('Common threshold values:');
  print('  • 0.0 - Always ON');
  print('  • 0.5 - Midpoint toggle');
  print('  • 1.0 - ON only at completion');
  print('');
  print('Threshold Deep Demo completed');

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
                colors: [Color(0xFF6A1B9A), Color(0xFFCE93D8)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'Threshold',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Step Function for Binary State Changes',
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFFF3E5F5),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Step Function Visual
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
                  'STEP FUNCTION VISUAL',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  height: 80,
                  child: CustomPaint(
                    painter: ThresholdPainter(0.5),
                    size: Size(double.infinity, 80),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('t = 0', style: TextStyle(color: Colors.white70, fontSize: 10)),
                    Text('threshold = 0.5', style: TextStyle(color: Color(0xFFAB47BC), fontSize: 10)),
                    Text('t = 1', style: TextStyle(color: Colors.white70, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Threshold Values Grid
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
                  'THRESHOLD STATES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A1B9A),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...t50Results.where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t'])).map((r) => _buildStateRow(r)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Threshold Comparison
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
                  'DIFFERENT THRESHOLDS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildThresholdIndicator('0.0', 'Immediate'),
                    _buildThresholdIndicator('0.25', 'Early'),
                    _buildThresholdIndicator('0.5', 'Middle'),
                    _buildThresholdIndicator('0.75', 'Late'),
                    _buildThresholdIndicator('1.0', 'End'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Multi-Step Reveal
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
                  'SEQUENTIAL REVEAL',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...multiStepResults.where((r) => [0.0, 0.2, 0.4, 0.6, 0.8, 1.0].contains(r['t'])).map((r) => _buildRevealRow(r)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Use Cases
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
                  'USE CASES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildUseCaseItem('Visibility Toggle', 'Show/hide at point'),
                _buildUseCaseItem('Sequential Reveals', 'Elements one by one'),
                _buildUseCaseItem('State Indicators', 'Binary on/off'),
                _buildUseCaseItem('Checkpoint Actions', 'Trigger at progress'),
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
                    _buildSummaryStat('Output', '0 or 1'),
                    _buildSummaryStat('Type', 'Step'),
                    _buildSummaryStat('Sections', '10'),
                  ],
                ),
                SizedBox(height: 12.0),
                Text(
                  'Formula: (t >= threshold) ? 1.0 : 0.0',
                  style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF90A4AE),
                    fontFamily: 'monospace',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),

          // Footer
          Center(
            child: Text(
              'Deep Demo • Threshold • Flutter Animation',
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

class ThresholdPainter extends CustomPainter {
  final double threshold;
  
  ThresholdPainter(this.threshold);
  
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFAB47BC)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;
    
    final path = Path();
    path.moveTo(0, size.height - 8);
    path.lineTo(threshold * size.width, size.height - 8);
    path.lineTo(threshold * size.width, 8);
    path.lineTo(size.width, 8);
    
    canvas.drawPath(path, paint);
    
    // Draw threshold marker
    final markerPaint = Paint()
      ..color = Color(0xFFFFEB3B)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(threshold * size.width, (size.height - 8 + 8) / 2), 5, markerPaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildStateRow(Map<String, dynamic> r) {
  final t = r['t'] as double;
  final out = r['out'] as double;
  final state = r['state'] as String;
  
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(width: 50, child: Text('t=${t.toStringAsFixed(2)}', style: TextStyle(fontSize: 11))),
        Container(
          width: 60,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 4),
          decoration: BoxDecoration(
            color: state == 'ON' ? Color(0xFF4CAF50) : Color(0xFF9E9E9E),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(child: Text(state, style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white))),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 16,
            decoration: BoxDecoration(
              color: state == 'ON' ? Color(0xFF4CAF50) : Color(0xFFE0E0E0),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildThresholdIndicator(String value, String label) {
  return Column(
    children: [
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF1565C0),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(value, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      SizedBox(height: 4),
      Text(label, style: TextStyle(fontSize: 9, color: Color(0xFF616161))),
    ],
  );
}

Widget _buildRevealRow(Map<String, dynamic> r) {
  final t = r['t'] as double;
  final count = r['count'] as int;
  
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(width: 45, child: Text('t=${t.toStringAsFixed(1)}', style: TextStyle(fontSize: 11))),
        Expanded(
          child: Row(
            children: List.generate(5, (i) {
              final visible = i < count;
              return Container(
                width: 24,
                height: 24,
                margin: EdgeInsets.only(right: 4),
                decoration: BoxDecoration(
                  color: visible ? Color(0xFF4CAF50) : Color(0xFFE0E0E0),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Center(child: Text('${i + 1}', style: TextStyle(fontSize: 10, color: visible ? Colors.white : Colors.grey))),
              );
            }),
          ),
        ),
        Text('$count/5', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
      ],
    ),
  );
}

Widget _buildUseCaseItem(String title, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(Icons.check_circle, size: 14, color: Color(0xFFE65100)),
        SizedBox(width: 8),
        Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
        SizedBox(width: 8),
        Text(description, style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
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
      Text(
        label,
        style: TextStyle(
          fontSize: 9.0,
          color: Color(0xFF90A4AE),
        ),
      ),
    ],
  );
}
