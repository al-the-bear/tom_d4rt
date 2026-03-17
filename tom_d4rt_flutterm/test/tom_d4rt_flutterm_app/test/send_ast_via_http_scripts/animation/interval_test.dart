// D4rt test script: Deep Demo for Interval from animation
// Interval remaps a portion of the animation timeline to 0-1
// Essential for staggered and sequential animations
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                    INTERVAL DEEP DEMO                             ║',
  );
  print(
    '║         Time Remapping for Staggered Animations                   ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: INTERVAL FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: INTERVAL FUNDAMENTALS                                  │',
  );
  print(
    '│ Understanding time remapping curves                               │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Interval characteristics:');
  print('  • Remaps a portion of t (0-1) to the full 0-1 range');
  print('  • Before begin: output = 0');
  print('  • After end: output = 1');
  print('  • Between: output = (t - begin) / (end - begin)');
  print('  • Optional curve applied to the remapped value');
  print('  • Perfect for staggered animations');
  print('');

  // Create basic intervals
  final fullInterval = Interval(0.0, 1.0);
  final firstHalf = Interval(0.0, 0.5);
  final secondHalf = Interval(0.5, 1.0);
  final middle = Interval(0.25, 0.75);
  print('✓ Created various Interval configurations');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: FULL INTERVAL (0.0 → 1.0)
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: FULL INTERVAL (0.0 → 1.0)                              │',
  );
  print(
    '│ Baseline: identity transformation                                 │',
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
  final fullResults = <Map<String, dynamic>>[];

  print('Interval(0.0, 1.0) - identity:');
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
    final out = fullInterval.transform(t);
    fullResults.add({'t': t, 'out': out});

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
  print('Note: Full interval is equivalent to linear curve');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: FIRST HALF INTERVAL (0.0 → 0.5)
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: FIRST HALF INTERVAL (0.0 → 0.5)                        │',
  );
  print(
    '│ Animation completes in first half of timeline                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final firstHalfResults = <Map<String, dynamic>>[];

  print('Interval(0.0, 0.5):');
  print(
    '┌─────────┬─────────────────┬──────────────────────────┬────────────────┐',
  );
  print(
    '│    t    │     Output      │   Timeline Position      │   Status       │',
  );
  print(
    '├─────────┼─────────────────┼──────────────────────────┼────────────────┤',
  );

  for (final t in tValues) {
    final out = firstHalf.transform(t);
    String status;
    if (t <= 0.0)
      status = 'Not started';
    else if (t >= 0.5)
      status = 'Complete';
    else
      status = 'In progress';
    firstHalfResults.add({'t': t, 'out': out, 'status': status});

    final marker = t <= 0.5 ? '▌' : ' ';
    final timeline =
        '[${'█' * ((t * 20).round().clamp(0, 10))}${'░' * (10 - (t * 20).round().clamp(0, 10))}|${'░' * 10}]';
    print(
      '│  ${t.toStringAsFixed(2)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │ $timeline │ ${status.padRight(14)} │',
    );
  }
  print(
    '└─────────┴─────────────────┴──────────────────────────┴────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: SECOND HALF INTERVAL (0.5 → 1.0)
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: SECOND HALF INTERVAL (0.5 → 1.0)                       │',
  );
  print(
    '│ Animation starts at midpoint of timeline                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final secondHalfResults = <Map<String, dynamic>>[];

  print('Interval(0.5, 1.0):');
  print(
    '┌─────────┬─────────────────┬──────────────────────────┬────────────────┐',
  );
  print(
    '│    t    │     Output      │   Timeline Position      │   Status       │',
  );
  print(
    '├─────────┼─────────────────┼──────────────────────────┼────────────────┤',
  );

  for (final t in tValues) {
    final out = secondHalf.transform(t);
    String status;
    if (t < 0.5)
      status = 'Waiting';
    else if (t >= 1.0)
      status = 'Complete';
    else
      status = 'In progress';
    secondHalfResults.add({'t': t, 'out': out, 'status': status});

    final pos = ((t - 0.5) * 20).round().clamp(0, 10);
    final timeline = '[${'░' * 10}|${'█' * pos}${'░' * (10 - pos)}]';
    print(
      '│  ${t.toStringAsFixed(2)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │ $timeline │ ${status.padRight(14)} │',
    );
  }
  print(
    '└─────────┴─────────────────┴──────────────────────────┴────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: MIDDLE INTERVAL (0.25 → 0.75)
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: MIDDLE INTERVAL (0.25 → 0.75)                          │',
  );
  print(
    '│ Animation runs during middle portion only                         │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final middleResults = <Map<String, dynamic>>[];

  print('Interval(0.25, 0.75):');
  print(
    '┌─────────┬─────────────────┬──────────────────────────────────────────┐',
  );
  print(
    '│    t    │     Output      │   Timeline                               │',
  );
  print(
    '├─────────┼─────────────────┼──────────────────────────────────────────┤',
  );

  for (var i = 0; i <= 20; i++) {
    final t = i / 20;
    final out = middle.transform(t);
    middleResults.add({'t': t, 'out': out});

    // Create timeline showing active region
    final beforeActive = 5;
    final afterActive = 5;
    final activeWidth = 10;
    final pos = ((out) * activeWidth).round().clamp(0, activeWidth);

    String timeline;
    if (t < 0.25) {
      timeline =
          '░' * beforeActive +
          '|' +
          '░' * activeWidth +
          '|' +
          '░' * afterActive;
    } else if (t > 0.75) {
      timeline =
          '░' * beforeActive +
          '|' +
          '█' * activeWidth +
          '|' +
          '░' * afterActive;
    } else {
      timeline =
          '░' * beforeActive +
          '|' +
          '█' * pos +
          '░' * (activeWidth - pos) +
          '|' +
          '░' * afterActive;
    }

    print(
      '│  ${t.toStringAsFixed(2)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │ [$timeline] │',
    );
  }
  print(
    '└─────────┴─────────────────┴──────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: INTERVAL WITH CURVE
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: INTERVAL WITH CURVE                                    │',
  );
  print(
    '│ Applying easing to the remapped time                              │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final easedInterval = Interval(0.0, 1.0, curve: Curves.easeInOut);
  final linearInterval = Interval(0.0, 1.0);
  final curveResults = <Map<String, dynamic>>[];

  print('Interval with easeInOut curve:');
  print('┌─────────┬─────────────────┬─────────────────┬───────────────┐');
  print('│    t    │     Linear      │    EaseInOut    │   Difference  │');
  print('├─────────┼─────────────────┼─────────────────┼───────────────┤');

  for (final t in tValues) {
    final linear = linearInterval.transform(t);
    final eased = easedInterval.transform(t);
    final diff = eased - linear;
    curveResults.add({'t': t, 'linear': linear, 'eased': eased, 'diff': diff});
    print(
      '│  ${t.toStringAsFixed(2)}   │     ${linear.toStringAsFixed(4).padLeft(6)}      │     ${eased.toStringAsFixed(4).padLeft(6)}      │   ${diff.toStringAsFixed(4).padLeft(9)}   │',
    );
  }
  print('└─────────┴─────────────────┴─────────────────┴───────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: STAGGERED ANIMATION EXAMPLE
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: STAGGERED ANIMATION EXAMPLE                            │',
  );
  print(
    '│ Three elements animating in sequence                              │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final item1 = Interval(0.0, 0.4, curve: Curves.easeOut);
  final item2 = Interval(0.2, 0.6, curve: Curves.easeOut);
  final item3 = Interval(0.4, 0.8, curve: Curves.easeOut);

  final staggeredResults = <Map<String, dynamic>>[];

  print('Staggered list items (overlapping intervals):');
  print(
    '┌─────────┬───────────┬───────────┬───────────┬──────────────────────────┐',
  );
  print(
    '│    t    │   Item 1  │   Item 2  │   Item 3  │   Visual Timeline        │',
  );
  print(
    '├─────────┼───────────┼───────────┼───────────┼──────────────────────────┤',
  );

  for (var i = 0; i <= 10; i++) {
    final t = i / 10;
    final v1 = item1.transform(t);
    final v2 = item2.transform(t);
    final v3 = item3.transform(t);
    staggeredResults.add({'t': t, 'v1': v1, 'v2': v2, 'v3': v3});

    // Visual timeline
    final bar1 = v1 >= 0.99 ? '█' : (v1 > 0 ? '▓' : '░');
    final bar2 = v2 >= 0.99 ? '█' : (v2 > 0 ? '▓' : '░');
    final bar3 = v3 >= 0.99 ? '█' : (v3 > 0 ? '▓' : '░');
    final timeline =
        '$bar1$bar1$bar1$bar1  $bar2$bar2$bar2$bar2  $bar3$bar3$bar3$bar3';

    print(
      '│  ${t.toStringAsFixed(2)}   │   ${v1.toStringAsFixed(2).padLeft(4)}    │   ${v2.toStringAsFixed(2).padLeft(4)}    │   ${v3.toStringAsFixed(2).padLeft(4)}    │ $timeline │',
    );
  }
  print(
    '└─────────┴───────────┴───────────┴───────────┴──────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: SMALL INTERVALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: SMALL INTERVALS                                        │',
  );
  print(
    '│ Very short animation windows                                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final tiny = Interval(0.45, 0.55); // 10% window
  final tinyResults = <Map<String, dynamic>>[];

  print('Tiny Interval(0.45, 0.55) - 10% window:');
  print(
    '┌─────────┬─────────────────┬────────────────────────────────────────────┐',
  );
  print(
    '│    t    │     Output      │   Status                                   │',
  );
  print(
    '├─────────┼─────────────────┼────────────────────────────────────────────┤',
  );

  for (final t in [0.0, 0.4, 0.45, 0.475, 0.5, 0.525, 0.55, 0.6, 1.0]) {
    final out = tiny.transform(t);
    String status;
    if (t < 0.45)
      status = 'Before interval (waiting)';
    else if (t > 0.55)
      status = 'After interval (complete)';
    else
      status = 'In interval (${((t - 0.45) / 0.1 * 100).round()}% progress)';
    tinyResults.add({'t': t, 'out': out, 'status': status});
    print(
      '│  ${t.toStringAsFixed(3).padLeft(5)}  │     ${out.toStringAsFixed(4).padLeft(6)}      │ ${status.padRight(42)} │',
    );
  }
  print(
    '└─────────┴─────────────────┴────────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: FORMULA VERIFICATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: FORMULA VERIFICATION                                   │',
  );
  print(
    '│ Checking: (t - begin) / (end - begin)                             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final testInterval = Interval(0.2, 0.8); // 60% window
  final formulaResults = <Map<String, dynamic>>[];

  print('Interval(0.2, 0.8) formula check:');
  print('┌─────────┬─────────────────┬─────────────────┬───────────────┐');
  print('│    t    │   Interval.t()  │   (t-0.2)/0.6   │   Diff        │');
  print('├─────────┼─────────────────┼─────────────────┼───────────────┤');

  for (final t in [0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8]) {
    final intervalVal = testInterval.transform(t);
    final formulaVal = ((t - 0.2) / 0.6).clamp(0.0, 1.0);
    final diff = (intervalVal - formulaVal).abs();
    formulaResults.add({
      't': t,
      'interval': intervalVal,
      'formula': formulaVal,
      'diff': diff,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │     ${intervalVal.toStringAsFixed(6).padLeft(10)}  │     ${formulaVal.toStringAsFixed(6).padLeft(10)}  │  ${diff.toStringAsFixed(10).padLeft(11)}  │',
    );
  }
  print('└─────────┴─────────────────┴─────────────────┴───────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: PRACTICAL USE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: PRACTICAL USE CASES                                   │',
  );
  print(
    '│ Common applications for Interval                                  │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('1. Sequential Animations:');
  print('   [Fade in] → [Scale up] → [Move right]');
  print('   Interval(0.0, 0.33) → Interval(0.33, 0.66) → Interval(0.66, 1.0)');
  print('');

  print('2. Overlapping Animations:');
  print('   Fade starts, then scale begins while fade finishing');
  print('   Interval(0.0, 0.5) for fade, Interval(0.3, 0.8) for scale');
  print('');

  print('3. Delayed Start with Early Finish:');
  print('   Skip first 25%, complete by 75%');
  print('   Interval(0.25, 0.75, curve: Curves.easeInOut)');
  print('');

  print('4. List Item Stagger:');
  print('   Each item delayed by 0.1');
  for (var i = 0; i < 5; i++) {
    final start = i * 0.15;
    final end = (start + 0.4).clamp(0.0, 1.0);
    print(
      '   Item $i: Interval(${start.toStringAsFixed(2)}, ${end.toStringAsFixed(2)})',
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
    '║                      INTERVAL SUMMARY                             ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('Interval key features:');
  print('  • Remaps portion of t to full 0-1 range');
  print('  • Output = 0 before begin');
  print('  • Output = 1 after end');
  print('  • Formula: (t - begin) / (end - begin)');
  print('  • Optional curve for easing');
  print('');
  print('Best use cases:');
  print('  • Staggered list animations');
  print('  • Sequential multi-step animations');
  print('  • Delayed/early completion effects');
  print('  • Complex choreographed animations');
  print('');
  print('Remember:');
  print('  • begin must be < end');
  print('  • Both begin and end in range [0, 1]');
  print('  • Curve is optional (default: linear)');
  print('');
  print('Interval Deep Demo completed');

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
                colors: [Color(0xFF6A1B9A), Color(0xFF8E24AA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'Interval',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Time Remapping for Staggered Animations',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFE1BEE7)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Formula Section
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
                  'INTERVAL FORMULA',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A1B9A),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFFCE93D8)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'output = (t - begin) / (end - begin)',
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6A1B9A),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Clamped to [0, 1], then curve applied',
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

          // Different Intervals
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
                  'INTERVAL CONFIGURATIONS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3949AB),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildIntervalDisplay('First Half', 0.0, 0.5, firstHalf),
                SizedBox(height: 8),
                _buildIntervalDisplay('Second Half', 0.5, 1.0, secondHalf),
                SizedBox(height: 8),
                _buildIntervalDisplay('Middle', 0.25, 0.75, middle),
                SizedBox(height: 8),
                _buildIntervalDisplay('Tiny', 0.45, 0.55, tiny),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Staggered Animation Demo
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
                  'STAGGERED ANIMATION',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  '3 items with overlapping intervals',
                  style: TextStyle(fontSize: 11, color: Color(0xFF558B2F)),
                ),
                SizedBox(height: 12.0),
                _buildStaggeredDisplay(item1, item2, item3),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // With Curve
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
                  'INTERVAL WITH CURVE',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...curveResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map(
                      (r) => _buildCurveComparisonRow(
                        't=${(r['t'] as double).toStringAsFixed(2)}',
                        r['linear'] as double,
                        r['eased'] as double,
                      ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Timeline Visualization
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
                  'TIMELINE VISUALIZATION',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF455A64),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildTimeline('Full (0.0-1.0)', 0.0, 1.0),
                SizedBox(height: 8),
                _buildTimeline('First Half', 0.0, 0.5),
                SizedBox(height: 8),
                _buildTimeline('Second Half', 0.5, 1.0),
                SizedBox(height: 8),
                _buildTimeline('Middle', 0.25, 0.75),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Key Concepts
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF4A148C), Color(0xFF6A1B9A)],
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
                _buildKeyPoint('Time Remap', 'Maps portion to full 0-1'),
                _buildKeyPoint('Before', 'Output = 0 until begin'),
                _buildKeyPoint('After', 'Output = 1 after end'),
                _buildKeyPoint('Curve', 'Optional easing applied'),
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
                    _buildSummaryStat('Intervals', '6'),
                    _buildSummaryStat(
                      'Mid Output',
                      middle.transform(0.5).toStringAsFixed(2),
                    ),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat(
                      'First Half',
                      firstHalf.transform(0.25).toStringAsFixed(2),
                    ),
                    _buildSummaryStat(
                      'Second Half',
                      secondHalf.transform(0.75).toStringAsFixed(2),
                    ),
                    _buildSummaryStat(
                      'Tiny',
                      tiny.transform(0.5).toStringAsFixed(2),
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
              'Deep Demo • Interval • Flutter Animation',
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

Widget _buildIntervalDisplay(
  String name,
  double begin,
  double end,
  Interval interval,
) {
  final midValue = interval.transform(0.5);

  return Row(
    children: [
      Container(
        width: 80,
        child: Text(
          name,
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      ),
      Expanded(
        child: Stack(
          children: [
            Container(
              height: 20,
              decoration: BoxDecoration(
                color: Color(0xFFC5CAE9),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            Positioned(
              left: begin * 180,
              width: (end - begin) * 180,
              child: Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Color(0xFF3949AB),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        width: 60,
        alignment: Alignment.centerRight,
        child: Text(
          't=0.5: ${midValue.toStringAsFixed(2)}',
          style: TextStyle(fontSize: 10, fontFamily: 'monospace'),
        ),
      ),
    ],
  );
}

Widget _buildStaggeredDisplay(Interval item1, Interval item2, Interval item3) {
  return Column(
    children: [0.0, 0.2, 0.4, 0.6, 0.8, 1.0].map((t) {
      final v1 = item1.transform(t);
      final v2 = item2.transform(t);
      final v3 = item3.transform(t);

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            Container(
              width: 50,
              child: Text(
                't=${t.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 10),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  _buildStaggerBar('1', v1, Color(0xFF4CAF50)),
                  SizedBox(width: 4),
                  _buildStaggerBar('2', v2, Color(0xFF2196F3)),
                  SizedBox(width: 4),
                  _buildStaggerBar('3', v3, Color(0xFFFF9800)),
                ],
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildStaggerBar(String label, double value, Color color) {
  return Expanded(
    child: Row(
      children: [
        Text(label, style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold)),
        SizedBox(width: 2),
        Expanded(
          child: Container(
            height: 12,
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: value.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildCurveComparisonRow(String label, double linear, double eased) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 50,
          child: Text(label, style: TextStyle(fontSize: 11)),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE0B2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: linear.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF757575),
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
                    color: Color(0xFFFFE0B2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: eased.clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF57C00),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${linear.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 9, color: Color(0xFF757575)),
              ),
              Text(' / ', style: TextStyle(fontSize: 9)),
              Text(
                '${eased.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 9,
                  color: Color(0xFFF57C00),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

Widget _buildTimeline(String label, double begin, double end) {
  return Row(
    children: [
      Container(width: 80, child: Text(label, style: TextStyle(fontSize: 11))),
      Expanded(
        child: Container(
          height: 16,
          child: Stack(
            children: [
              // Background
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFFCFD8DC),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              // Active region
              Positioned(
                left: begin * 180,
                width: (end - begin) * 180,
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: Color(0xFF6A1B9A),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              // Labels
              Positioned(
                left: begin * 180 + 4,
                child: Text(
                  '${begin.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 8, color: Colors.white),
                ),
              ),
              Positioned(
                left: end * 180 - 20,
                child: Text(
                  '${end.toStringAsFixed(1)}',
                  style: TextStyle(fontSize: 8, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
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
            color: Color(0xFFCE93D8),
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFFE1BEE7),
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
