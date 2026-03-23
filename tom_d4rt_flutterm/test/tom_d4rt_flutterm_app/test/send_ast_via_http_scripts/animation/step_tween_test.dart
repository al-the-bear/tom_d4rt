// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for StepTween from animation
// StepTween interpolates integers using floor (truncation)
// Perfect for discrete value animations like page numbers, counts
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                    STEP TWEEN DEEP DEMO                           ║',
  );
  print(
    '║              Discrete Integer Interpolation                       ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: STEP TWEEN FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: STEP TWEEN FUNDAMENTALS                                │',
  );
  print(
    '│ Understanding floor-based integer animation                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('StepTween characteristics:');
  print('  • Interpolates between integer values');
  print('  • Uses floor() to truncate to integer');
  print('  • Formula: floor(begin + t * (end - begin))');
  print('  • Values change at discrete steps');
  print('  • Perfect for page numbers, counters, index selection');
  print('');

  // Create basic tween
  final basicTween = StepTween(begin: 0, end: 10);
  print('Created StepTween(0, 10):');
  print('  begin: ${basicTween.begin}');
  print('  end: ${basicTween.end}');
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
  // SECTION 2: STEP-BY-STEP INTERPOLATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: STEP-BY-STEP INTERPOLATION                             │',
  );
  print(
    '│ Seeing the discrete step behavior                                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final stepResults = <Map<String, dynamic>>[];

  print('StepTween(0, 10) values:');
  print(
    '┌───────┬────────────────┬──────────────┬───────────────────────────────┐',
  );
  print(
    '│   t   │   Continuous   │   StepTween  │   Step Indicator              │',
  );
  print(
    '├───────┼────────────────┼──────────────┼───────────────────────────────┤',
  );

  for (final t in tValues) {
    final continuous = t * 10;
    final stepped = basicTween.transform(t);
    stepResults.add({'t': t, 'cont': continuous, 'step': stepped});

    final stepBar = '█' * stepped + '░' * (10 - stepped);
    print(
      '│ ${t.toStringAsFixed(1)}   │      ${continuous.toStringAsFixed(1).padLeft(5)}     │      ${stepped.toString().padLeft(2)}      │ $stepBar │',
    );
  }
  print(
    '└───────┴────────────────┴──────────────┴───────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: FLOOR BEHAVIOR ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: FLOOR BEHAVIOR ANALYSIS                                │',
  );
  print(
    '│ Understanding when values change                                  │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final step5 = StepTween(begin: 0, end: 5);
  final floorResults = <Map<String, dynamic>>[];

  print('StepTween(0, 5) - precise step boundaries:');
  print(
    '┌──────────┬──────────────────┬──────────────┬─────────────────────────┐',
  );
  print(
    '│    t     │   Continuous     │   Stepped    │   Status                │',
  );
  print(
    '├──────────┼──────────────────┼──────────────┼─────────────────────────┤',
  );

  for (final t in [
    0.0,
    0.19,
    0.2,
    0.39,
    0.4,
    0.59,
    0.6,
    0.79,
    0.8,
    0.99,
    1.0,
  ]) {
    final cont = t * 5;
    final stepped = step5.transform(t);
    final wasJust = (t % 0.2 < 0.01 && t > 0.0);
    String status = wasJust ? '← Just stepped!' : '';
    floorResults.add({'t': t, 'cont': cont, 'step': stepped, 'just': wasJust});
    print(
      '│  ${t.toStringAsFixed(2).padLeft(5)}   │       ${cont.toStringAsFixed(2).padLeft(5)}        │      ${stepped.toString().padLeft(2)}      │ ${status.padRight(21)} │',
    );
  }
  print(
    '└──────────┴──────────────────┴──────────────┴─────────────────────────┘',
  );
  print('');
  print('Key insight: Step changes at t=0.2, 0.4, 0.6, 0.8 (multiples of 1/5)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: LARGE RANGE TWEEN
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: LARGE RANGE TWEEN                                      │',
  );
  print(
    '│ StepTween with larger value range                                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final largeTween = StepTween(begin: 0, end: 100);
  final largeResults = <Map<String, dynamic>>[];

  print('StepTween(0, 100) - many possible values:');
  print(
    '┌───────┬──────────────┬──────────────┬─────────────────────────────────┐',
  );
  print(
    '│   t   │   Stepped    │   Percent    │   Progress (scale: 20)          │',
  );
  print(
    '├───────┼──────────────┼──────────────┼─────────────────────────────────┤',
  );

  for (final t in tValues) {
    final stepped = largeTween.transform(t);
    final percent = stepped / 100.0 * 100;
    largeResults.add({'t': t, 'step': stepped, 'percent': percent});

    final barWidth = (stepped / 100 * 25).round().clamp(0, 25);
    final bar = '█' * barWidth + '░' * (25 - barWidth);
    print(
      '│ ${t.toStringAsFixed(1)}   │      ${stepped.toString().padLeft(3)}     │    ${percent.toStringAsFixed(0).padLeft(3)}%     │ $bar │',
    );
  }
  print(
    '└───────┴──────────────┴──────────────┴─────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: REVERSE DIRECTION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: REVERSE DIRECTION                                      │',
  );
  print(
    '│ Counting down instead of up                                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final reverseTween = StepTween(begin: 10, end: 0);
  final reverseResults = <Map<String, dynamic>>[];

  print('StepTween(10, 0) - counting down:');
  print(
    '┌───────┬──────────────┬────────────────────────────────────────────┐',
  );
  print(
    '│   t   │   Value      │   Countdown                                │',
  );
  print(
    '├───────┼──────────────┼────────────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final stepped = reverseTween.transform(t);
    reverseResults.add({'t': t, 'step': stepped});

    final barWidth = stepped.clamp(0, 10);
    final bar = '█' * barWidth + '░' * (10 - barWidth);
    print(
      '│ ${t.toStringAsFixed(1)}   │      ${stepped.toString().padLeft(2)}      │ $bar ${stepped.toString().padLeft(2)} remaining │',
    );
  }
  print(
    '└───────┴──────────────┴────────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: NEGATIVE VALUES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: NEGATIVE VALUES                                        │',
  );
  print(
    '│ Working with negative integer ranges                              │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final negativeTween = StepTween(begin: -5, end: 5);
  final negativeResults = <Map<String, dynamic>>[];

  print('StepTween(-5, 5) - crossing zero:');
  print(
    '┌───────┬──────────────┬────────────────────────────────────────────┐',
  );
  print(
    '│   t   │   Value      │   Number Line                              │',
  );
  print(
    '├───────┼──────────────┼────────────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final stepped = negativeTween.transform(t);
    negativeResults.add({'t': t, 'step': stepped});

    // Create number line visualization
    final position = (stepped + 5);
    final before = '░' * position.clamp(0, 10);
    final after = '░' * (10 - position).clamp(0, 10);
    print(
      '│ ${t.toStringAsFixed(1)}   │      ${stepped.toString().padLeft(3)}     │ $before█$after │',
    );
  }
  print(
    '└───────┴──────────────┴────────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: STEP VS INTTWEEN COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: STEP VS INTTWEEN COMPARISON                            │',
  );
  print(
    '│ Both do integers, slightly different behavior                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final stepTw = StepTween(begin: 0, end: 5);
  final intTw = IntTween(begin: 0, end: 5);
  final compResults = <Map<String, dynamic>>[];

  print('Comparison at various t values:');
  print('┌───────┬──────────────┬──────────────┬────────────────────┐');
  print('│   t   │  StepTween   │   IntTween   │   Difference       │');
  print('├───────┼──────────────┼──────────────┼────────────────────┤');

  for (final t in tValues) {
    final stepVal = stepTw.transform(t);
    final intVal = intTw.transform(t);
    final diff = stepVal - intVal;
    compResults.add({'t': t, 'step': stepVal, 'int': intVal, 'diff': diff});
    print(
      '│ ${t.toStringAsFixed(1)}   │      ${stepVal.toString().padLeft(2)}      │      ${intVal.toString().padLeft(2)}      │        ${diff >= 0 ? ' ' : ''}$diff        │',
    );
  }
  print('└───────┴──────────────┴──────────────┴────────────────────┘');
  print('');
  print('Note: StepTween uses floor(), IntTween uses round()');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: PAGE INDICATOR SIMULATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: PAGE INDICATOR SIMULATION                              │',
  );
  print(
    '│ Practical use case: page swipe indicator                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final pages = 5;
  final pageTween = StepTween(begin: 0, end: pages - 1);
  final pageResults = <Map<String, dynamic>>[];

  print('Simulating swipe through 5 pages:');
  print(
    '┌───────┬──────────────┬────────────────────────────────────────────┐',
  );
  print(
    '│   t   │    Page      │   Page Indicators                          │',
  );
  print(
    '├───────┼──────────────┼────────────────────────────────────────────┤',
  );

  for (var i = 0; i <= 20; i++) {
    final t = i / 20;
    final page = pageTween.transform(t);
    pageResults.add({'t': t, 'page': page});

    var indicators = '';
    for (var p = 0; p < pages; p++) {
      indicators += p == page ? ' ● ' : ' ○ ';
    }
    print(
      '│ ${t.toStringAsFixed(2)}  │   Page ${page + 1}    │$indicators       │',
    );
  }
  print(
    '└───────┴──────────────┴────────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: EVALUATE METHOD
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: EVALUATE METHOD                                        │',
  );
  print(
    '│ Using evaluate() with animation                                   │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final evalResults = <Map<String, dynamic>>[];

  print('evaluate() vs lerp() comparison:');
  print('┌───────┬──────────────┬──────────────┬────────────────────┐');
  print('│   t   │   lerp(t)    │  evaluate()  │   Match?           │');
  print('├───────┼──────────────┼──────────────┼────────────────────┤');

  for (final t in [0.0, 0.25, 0.33, 0.5, 0.67, 0.75, 1.0]) {
    final lerpVal = basicTween.transform(t);
    final anim = AlwaysStoppedAnimation<double>(t);
    final evalVal = basicTween.evaluate(anim);
    final match = lerpVal == evalVal;
    evalResults.add({'t': t, 'lerp': lerpVal, 'eval': evalVal, 'match': match});
    print(
      '│ ${t.toStringAsFixed(2)}  │      ${lerpVal.toString().padLeft(2)}      │      ${evalVal.toString().padLeft(2)}      │       ${match ? '✓' : '✗'}          │',
    );
  }
  print('└───────┴──────────────┴──────────────┴────────────────────┘');
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
    '│ Common StepTween applications                                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('1. Page Indicator:');
  print('   StepTween(0, pageCount - 1)');
  print('   Shows current page during swipe');
  print('');

  print('2. Counter Animation:');
  print('   StepTween(0, targetCount)');
  print('   Numbers tick up during animation');
  print('');

  print('3. Star Rating:');
  print('   StepTween(0, 5)');
  print('   Fill stars as user drags');
  print('');

  print('4. Level Progress:');
  print('   StepTween(currentLevel, newLevel)');
  print('   Level-up animation');
  print('');

  print('5. Timer Countdown:');
  print('   StepTween(seconds, 0)');
  print('   Visual countdown timer');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                     STEP TWEEN SUMMARY                            ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('StepTween key features:');
  print('  • Interpolates integers using floor()');
  print('  • Values change at discrete steps');
  print('  • Steps at multiples of 1/(end-begin)');
  print('  • Works with negative ranges');
  print('');
  print('Comparison with IntTween:');
  print('  • StepTween: floor() - always rounds down');
  print('  • IntTween: round() - rounds to nearest');
  print('');
  print('StepTween Deep Demo completed');

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
                colors: [Color(0xFF6A1B9A), Color(0xFFAB47BC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'StepTween',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Discrete Integer Interpolation',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFE1BEE7)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Step Visualization
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
                  'STEP VALUES (0 TO 10)',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A1B9A),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...stepResults.map((r) => _buildStepRow(r)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Comparison Section
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
                  'STEPTWEEN VS INTTWEEN',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...compResults
                    .where((r) => [0.0, 0.3, 0.5, 0.7, 1.0].contains(r['t']))
                    .map((r) => _buildCompRow(r)),
                SizedBox(height: 8),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Color(0xFFC8E6C9),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'StepTween: floor() | IntTween: round()',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Page Indicator Demo
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
                  'PAGE INDICATOR DEMO',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...pageResults
                    .where((r) => (r['t'] as double) % 0.25 == 0)
                    .map((r) => _buildPageRow(r, pages)),
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
                _buildUseCaseItem(
                  'Page Indicator',
                  'Track current page in carousel',
                ),
                _buildUseCaseItem('Counter', 'Animate counting numbers'),
                _buildUseCaseItem('Star Rating', 'Fill stars during drag'),
                _buildUseCaseItem('Timer', 'Countdown seconds display'),
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
                    _buildSummaryStat('Tweens', '5'),
                    _buildSummaryStat('Steps', '11'),
                    _buildSummaryStat('Sections', '10'),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat('Max Range', '100'),
                    _buildSummaryStat('Eval ✓', '7'),
                    _buildSummaryStat('Method', 'floor'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),

          // Footer
          Center(
            child: Text(
              'Deep Demo • StepTween • Flutter Animation',
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

Widget _buildStepRow(Map<String, dynamic> r) {
  final t = r['t'] as double;
  final cont = r['cont'] as double;
  final step = r['step'] as int?;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 2.0),
    child: Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(
            't=${t.toStringAsFixed(1)}',
            style: TextStyle(fontSize: 10),
          ),
        ),
        SizedBox(
          width: 45,
          child: Text(
            cont.toStringAsFixed(1),
            style: TextStyle(fontSize: 10, color: Color(0xFF757575)),
          ),
        ),
        Container(
          width: 30,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xFF7B1FA2),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              '$step',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 12,
            decoration: BoxDecoration(
              color: Color(0xFFE1BEE7),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (step ?? 0) / 10,
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF9C27B0),
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

Widget _buildCompRow(Map<String, dynamic> r) {
  final step = r['step'] as int?;
  final intVal = r['int'] as int?;
  final diff = r['diff'] as int;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(
          width: 45,
          child: Text(
            't=${(r['t'] as double).toStringAsFixed(1)}',
            style: TextStyle(fontSize: 11),
          ),
        ),
        _buildValueChip('$step', Color(0xFF9C27B0)),
        SizedBox(width: 8),
        _buildValueChip('$intVal', Color(0xFF4CAF50)),
        SizedBox(width: 8),
        Text(
          diff != 0 ? 'Diff: $diff' : 'Same',
          style: TextStyle(
            fontSize: 10,
            color: diff != 0 ? Colors.red : Colors.grey,
          ),
        ),
      ],
    ),
  );
}

Widget _buildValueChip(String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color),
    ),
    child: Text(
      value,
      style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: color),
    ),
  );
}

Widget _buildPageRow(Map<String, dynamic> r, int pages) {
  final t = r['t'] as double;
  final page = r['page'] as int;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6.0),
    child: Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            't=${t.toStringAsFixed(2)}',
            style: TextStyle(fontSize: 11),
          ),
        ),
        Row(
          children: List.generate(
            pages,
            (i) => Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: i == page ? Color(0xFF1565C0) : Color(0xFFBBDEFB),
                border: Border.all(color: Color(0xFF1565C0), width: 2),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Text(
          'Page ${page + 1}',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1565C0),
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
      children: [
        Icon(Icons.check_circle, size: 14, color: Color(0xFFE65100)),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
        ),
        SizedBox(width: 8),
        Text(
          description,
          style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
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
