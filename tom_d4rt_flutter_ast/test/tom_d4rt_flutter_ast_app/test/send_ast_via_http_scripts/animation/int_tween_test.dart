// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for IntTween from animation
// IntTween interpolates between integers with proper rounding
// Useful for discrete animations like counters, steps, indices
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                    INTTWEEN DEEP DEMO                             ║',
  );
  print(
    '║          Integer Interpolation for Discrete Animations            ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: INTTWEEN FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: INTTWEEN FUNDAMENTALS                                  │',
  );
  print(
    '│ Understanding integer interpolation                               │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('IntTween characteristics:');
  print('  • Interpolates between two integers');
  print('  • Uses rounding (not truncation): (a + (b - a) * t).round()');
  print('  • Useful for discrete values (counts, indices, steps)');
  print('  • Always returns integer values');
  print('  • Extends Tween<int>');
  print('');

  // Create basic tween
  final basicTween = IntTween(begin: 0, end: 100);
  print('✓ Created IntTween(begin: 0, end: 100)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: BASIC INTERPOLATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: BASIC INTERPOLATION                                    │',
  );
  print(
    '│ IntTween(0, 100) across the t range                               │',
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
  final basicResults = <Map<String, dynamic>>[];

  print('Basic IntTween interpolation:');
  print(
    '┌─────────┬───────────────┬───────────────┬───────────────────────────┐',
  );
  print(
    '│    t    │   Int Value   │  Float Equiv  │   Visualization           │',
  );
  print(
    '├─────────┼───────────────┼───────────────┼───────────────────────────┤',
  );

  for (final t in tValues) {
    final intVal = basicTween.transform(t);
    final floatVal = 0 + (100 - 0) * t;
    basicResults.add({'t': t, 'int': intVal, 'float': floatVal});

    final barWidth = (intVal / 100 * 20).round();
    final bar = '█' * barWidth + '░' * (20 - barWidth);
    print(
      '│  ${t.toStringAsFixed(2)}   │      ${intVal.toString().padLeft(3)}      │     ${floatVal.toStringAsFixed(1).padLeft(5)}     │ ${bar.padRight(25)} │',
    );
  }
  print(
    '└─────────┴───────────────┴───────────────┴───────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ROUNDING BEHAVIOR
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: ROUNDING BEHAVIOR                                      │',
  );
  print(
    '│ How IntTween rounds intermediate values                           │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final smallTween = IntTween(begin: 0, end: 10);
  final roundingResults = <Map<String, dynamic>>[];

  print('Rounding demonstration (IntTween 0 → 10):');
  print(
    '┌─────────┬───────────────┬───────────────┬───────────────────────────┐',
  );
  print(
    '│    t    │  Float Value  │   Rounded     │   Step Changes            │',
  );
  print(
    '├─────────┼───────────────┼───────────────┼───────────────────────────┤',
  );

  int prevVal = -1;
  for (var i = 0; i <= 20; i++) {
    final t = i / 20;
    final floatVal = t * 10;
    final intVal = smallTween.transform(t);
    final changed = intVal != prevVal;
    roundingResults.add({
      't': t,
      'float': floatVal,
      'int': intVal,
      'changed': changed,
    });
    final changeMarker = changed ? ' ← STEP' : '';
    print(
      '│  ${t.toStringAsFixed(2)}   │     ${floatVal.toStringAsFixed(2).padLeft(5)}     │      ${intVal.toString().padLeft(2)}       │ ${changeMarker.padRight(25)} │',
    );
    prevVal = intVal;
  }
  print(
    '└─────────┴───────────────┴───────────────┴───────────────────────────┘',
  );
  print('');

  // Count step changes
  final stepChanges = roundingResults.where((r) => r['changed'] == true).length;
  print('Step changes: $stepChanges (expected: 11 values 0-10)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: DIFFERENT RANGES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: DIFFERENT RANGES                                       │',
  );
  print(
    '│ IntTween with various begin/end values                            │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final ranges = <String, IntTween>{
    '0→10': IntTween(begin: 0, end: 10),
    '0→100': IntTween(begin: 0, end: 100),
    '-50→50': IntTween(begin: -50, end: 50),
    '100→0': IntTween(begin: 100, end: 0),
    '-100→-50': IntTween(begin: -100, end: -50),
    '1→255': IntTween(begin: 1, end: 255),
  };

  final rangeResults = <Map<String, dynamic>>[];

  print('Range comparison at t=0.5:');
  print('┌──────────────────┬───────────────┬───────────────┬───────────────┐');
  print('│      Range       │     begin     │      end      │    at t=0.5   │');
  print('├──────────────────┼───────────────┼───────────────┼───────────────┤');

  for (final entry in ranges.entries) {
    final tween = entry.value;
    final mid = tween.transform(0.5);
    rangeResults.add({
      'name': entry.key,
      'begin': tween.begin,
      'end': tween.end,
      'mid': mid,
    });
    print(
      '│ ${entry.key.padRight(16)} │      ${tween.begin.toString().padLeft(4)}     │      ${tween.end.toString().padLeft(4)}     │      ${mid.toString().padLeft(4)}     │',
    );
  }
  print('└──────────────────┴───────────────┴───────────────┴───────────────┘');
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
    '│ IntTween with begin > end (counting down)                         │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final reverseTween = IntTween(begin: 100, end: 0);
  final reverseResults = <Map<String, dynamic>>[];

  print('Reverse IntTween (100 → 0):');
  print(
    '┌─────────┬───────────────┬───────────────────────────────────────────┐',
  );
  print(
    '│    t    │   Int Value   │   Visualization                           │',
  );
  print(
    '├─────────┼───────────────┼───────────────────────────────────────────┤',
  );

  for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]) {
    final intVal = reverseTween.transform(t);
    reverseResults.add({'t': t, 'value': intVal});

    final barWidth = (intVal / 100 * 30).round();
    final bar = '█' * barWidth + '░' * (30 - barWidth);
    print(
      '│  ${t.toStringAsFixed(2)}   │      ${intVal.toString().padLeft(3)}      │ ${bar.padRight(41)} │',
    );
  }
  print(
    '└─────────┴───────────────┴───────────────────────────────────────────┘',
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
    '│ IntTween crossing zero and negative ranges                        │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final negTween = IntTween(begin: -50, end: 50);
  final negResults = <Map<String, dynamic>>[];

  print('IntTween(-50 → 50):');
  print(
    '┌─────────┬───────────────┬───────────────────────────────────────────┐',
  );
  print(
    '│    t    │   Int Value   │   Number Line                             │',
  );
  print(
    '├─────────┼───────────────┼───────────────────────────────────────────┤',
  );

  for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]) {
    final intVal = negTween.transform(t);
    negResults.add({'t': t, 'value': intVal});

    // Create a number line visualization centered at 0
    final normalizedPos = ((intVal + 50) / 100 * 38).round().clamp(0, 38);
    final line = '${'-' * 19}│${'-' * 19}';
    final lineChars = line.split('');
    lineChars[normalizedPos] = '*';
    print(
      '│  ${t.toStringAsFixed(2)}   │      ${intVal.toString().padLeft(4)}     │ ${lineChars.join('')} │',
    );
  }
  print(
    '└─────────┴───────────────┴───────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: COMPARISON WITH TWEEN<DOUBLE>
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: COMPARISON WITH TWEEN<DOUBLE>                          │',
  );
  print(
    '│ IntTween vs Tween<double>.toInt()                                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final doubleTween = Tween<double>(begin: 0.0, end: 100.0);
  final comparisonResults = <Map<String, dynamic>>[];

  print('IntTween vs Tween<double>:');
  print(
    '┌─────────┬───────────────┬───────────────┬───────────────┬─────────────┐',
  );
  print(
    '│    t    │   IntTween    │ Tween<double> │   Truncated   │   Match?    │',
  );
  print(
    '├─────────┼───────────────┼───────────────┼───────────────┼─────────────┤',
  );

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final intVal = basicTween.transform(t);
    final dblVal = doubleTween.transform(t);
    final truncVal = dblVal.toInt();
    final match = intVal == dblVal.round();
    comparisonResults.add({
      't': t,
      'int': intVal,
      'double': dblVal,
      'trunc': truncVal,
      'match': match,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │      ${intVal.toString().padLeft(3)}      │     ${dblVal.toStringAsFixed(1).padLeft(5)}     │      ${truncVal.toString().padLeft(3)}      │    ${match ? "✓" : "✗"}${match ? " yes " : " no  "}   │',
    );
  }
  print(
    '└─────────┴───────────────┴───────────────┴───────────────┴─────────────┘',
  );
  print('');
  print('Note: IntTween uses .round(), not .toInt() (truncation)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: EVALUATE WITH ANIMATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: EVALUATE WITH ANIMATION                                │',
  );
  print(
    '│ Using evaluate() with Animation objects                           │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final evalResults = <Map<String, dynamic>>[];

  print('Evaluate with AlwaysStoppedAnimation:');
  print('┌─────────────────────────┬───────────────┐');
  print('│  Animation Value        │   Result      │');
  print('├─────────────────────────┼───────────────┤');

  for (final v in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final anim = AlwaysStoppedAnimation<double>(v);
    final result = basicTween.evaluate(anim);
    evalResults.add({'animValue': v, 'result': result});
    print(
      '│ AlwaysStoppedAnimation(${v.toStringAsFixed(2)}) │      ${result.toString().padLeft(3)}      │',
    );
  }
  print('└─────────────────────────┴───────────────┘');
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
    '│ Common applications for IntTween                                  │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Counter animation
  final counterTween = IntTween(begin: 0, end: 1000);
  print('1. Counter Animation (0 → 1000):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  t=${t.toStringAsFixed(2)}: ${counterTween.transform(t)}');
  }
  print('');

  // Page indicator
  final pageTween = IntTween(begin: 0, end: 4);
  print('2. Page Indicator (5 pages, index 0-4):');
  for (final t in [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]) {
    final page = pageTween.transform(t);
    final dots = List.generate(5, (i) => i == page ? '●' : '○').join(' ');
    print('  t=${t.toStringAsFixed(2)}: page $page  [$dots]');
  }
  print('');

  // Color component animation
  final colorTween = IntTween(begin: 0, end: 255);
  print('3. Color Component (0 → 255 RGB):');
  for (final t in [0.0, 0.33, 0.67, 1.0]) {
    final val = colorTween.transform(t);
    print(
      '  t=${t.toStringAsFixed(2)}: ${val.toString().padLeft(3)} → Color(0xFF${val.toRadixString(16).padLeft(2, '0').toUpperCase()}0000)',
    );
  }
  print('');

  // Star rating
  final starTween = IntTween(begin: 0, end: 5);
  print('4. Star Rating (0 → 5 stars):');
  for (final t in [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]) {
    final stars = starTween.transform(t);
    final display = '★' * stars + '☆' * (5 - stars);
    print('  t=${t.toStringAsFixed(2)}: $stars stars  $display');
  }
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: EDGE CASES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: EDGE CASES                                            │',
  );
  print(
    '│ Special scenarios and boundary conditions                         │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Same begin and end
  final sameTween = IntTween(begin: 50, end: 50);
  print('1. Same begin and end (IntTween(50, 50)):');
  for (final t in [0.0, 0.5, 1.0]) {
    print('  t=${t.toStringAsFixed(1)}: ${sameTween.transform(t)}');
  }
  print('');

  // Single step range
  final singleStep = IntTween(begin: 0, end: 1);
  print('2. Single step range (0 → 1):');
  for (var i = 0; i <= 10; i++) {
    final t = i / 10;
    print('  t=${t.toStringAsFixed(1)}: ${singleStep.transform(t)}');
  }
  print('');

  // Large range
  final largeRange = IntTween(begin: 0, end: 1000000);
  print('3. Large range (0 → 1,000,000):');
  for (final t in [0.0, 0.001, 0.01, 0.1, 0.5, 0.9, 0.99, 0.999, 1.0]) {
    print(
      '  t=${t.toString().padRight(5)}: ${largeRange.transform(t).toString().padLeft(7)}',
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
    '║                      INTTWEEN SUMMARY                             ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('IntTween key features:');
  print('  • Interpolates between integers');
  print('  • Uses rounding (not truncation)');
  print('  • Extends Tween<int>');
  print('  • Works with negative values');
  print('');
  print('Best use cases:');
  print('  • Counter animations');
  print('  • Page indicators');
  print('  • Star ratings');
  print('  • Color components (0-255)');
  print('  • Discrete step indicators');
  print('');
  print('Remember:');
  print('  • lerp() returns the interpolated integer');
  print('  • evaluate() works with Animation objects');
  print('  • begin can be greater than end (reverse)');
  print('');
  print('IntTween Deep Demo completed');

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
                colors: [Color(0xFF1565C0), Color(0xFF1976D2)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'IntTween',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Integer Interpolation for Discrete Animations',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFBBDEFB)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Basic Interpolation
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
                  'BASIC INTERPOLATION (0 → 100)',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...basicResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map(
                      (r) => _buildIntValueRow(
                        't=${(r['t'] as double).toStringAsFixed(2)}',
                        r['int'] as int,
                        100,
                      ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Rounding Behavior
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
                  'ROUNDING BEHAVIOR (0 → 10)',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Uses .round(), not .toInt()',
                  style: TextStyle(fontSize: 11, color: Color(0xFF795548)),
                ),
                SizedBox(height: 12.0),
                _buildStepVisualization(smallTween),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Range Comparison
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
                  'RANGE COMPARISON AT t=0.5',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF424242),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...rangeResults.map(
                  (r) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          child: Text(
                            r['name'],
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
                                  color: Color(0xFF90CAF9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${r['begin']}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '→',
                                    style: TextStyle(color: Color(0xFF757575)),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF1565C0),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${r['mid']}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '→',
                                    style: TextStyle(color: Color(0xFF757575)),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xFF90CAF9),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  '${r['end']}',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
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
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Reverse Direction
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
                    Icon(Icons.swap_horiz, color: Color(0xFFC62828), size: 20),
                    SizedBox(width: 8),
                    Text(
                      'REVERSE DIRECTION (100 → 0)',
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
                ...reverseResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map(
                      (r) => _buildReverseRow(
                        't=${(r['t'] as double).toStringAsFixed(2)}',
                        r['value'] as int,
                      ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Negative Values
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
                  'CROSSING ZERO (-50 → 50)',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildNumberLine(negTween),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Use Cases
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
                  'PRACTICAL USE CASES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildUseCase(
                  'Counter',
                  '0 → 1000',
                  '${counterTween.transform(0.5)}',
                ),
                _buildUseCase(
                  'Page Index',
                  '0 → 4',
                  '${pageTween.transform(0.5)}',
                ),
                _buildUseCase(
                  'Color (RGB)',
                  '0 → 255',
                  '${colorTween.transform(0.5)}',
                ),
                _buildUseCase(
                  'Star Rating',
                  '0 → 5',
                  '${starTween.transform(0.6)}',
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Star Rating Demo
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
                  'STAR RATING ANIMATION',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...[0.0, 0.2, 0.4, 0.6, 0.8, 1.0].map((t) {
                  final stars = starTween.transform(t);
                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: Text(
                            't=${t.toStringAsFixed(1)}',
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                        ...List.generate(
                          5,
                          (i) => Icon(
                            i < stars ? Icons.star : Icons.star_border,
                            color: Color(0xFFFFC107),
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 8),
                        Text(
                          '($stars)',
                          style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Key Concepts
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0D47A1), Color(0xFF1565C0)],
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
                _buildKeyPoint('Rounding', 'Uses .round() not .toInt()'),
                _buildKeyPoint('Discrete', 'Returns integer, no fractions'),
                _buildKeyPoint('Bi-directional', 'begin can be > end'),
                _buildKeyPoint('Negative', 'Works with negative values'),
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
                    _buildSummaryStat('Ranges Tested', '${ranges.length}'),
                    _buildSummaryStat('Step Changes', '$stepChanges'),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat(
                      'Basic (0.5)',
                      '${basicTween.transform(0.5)}',
                    ),
                    _buildSummaryStat(
                      'Reverse (0.5)',
                      '${reverseTween.transform(0.5)}',
                    ),
                    _buildSummaryStat(
                      'Negative (0.5)',
                      '${negTween.transform(0.5)}',
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
              'Deep Demo • IntTween • Flutter Animation',
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

Widget _buildIntValueRow(String label, int value, int max) {
  final fraction = value / max;

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
            height: 20,
            decoration: BoxDecoration(
              color: Color(0xFFBBDEFB),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF1565C0),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment.centerRight,
          child: Text(
            value.toString(),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildStepVisualization(IntTween tween) {
  return SizedBox(
    height: 50,
    child: Row(
      children: List.generate(21, (i) {
        final t = i / 20;
        final value = tween.transform(t);
        final prevValue = i > 0 ? tween.transform((i - 1) / 20) : -1;
        final changed = value != prevValue;

        return Expanded(
          child: Column(
            children: [
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 8,
                  fontWeight: changed ? FontWeight.bold : FontWeight.normal,
                  color: changed ? Color(0xFFF57C00) : Color(0xFF757575),
                ),
              ),
              Container(
                height: 30,
                margin: EdgeInsets.symmetric(horizontal: 1),
                decoration: BoxDecoration(
                  color: changed ? Color(0xFFF57C00) : Color(0xFFFFE0B2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        );
      }),
    ),
  );
}

Widget _buildReverseRow(String label, int value) {
  final fraction = value / 100;

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
            height: 16,
            decoration: BoxDecoration(
              color: Color(0xFFFFCDD2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: fraction.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFC62828),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 50,
          alignment: Alignment.centerRight,
          child: Text(
            value.toString(),
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 11,
              fontWeight: FontWeight.bold,
              color: Color(0xFFC62828),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildNumberLine(IntTween tween) {
  return Column(
    children: [0.0, 0.25, 0.5, 0.75, 1.0].map((t) {
      final value = tween.transform(t);
      final normalized = (value + 50) / 100; // -50 to 50 → 0 to 1

      return Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              child: Text(
                't=${t.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 11),
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFFEF5350),
                          Color(0xFFFFFFFF),
                          Color(0xFF4CAF50),
                        ],
                        stops: [0.0, 0.5, 1.0],
                      ),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  // Zero marker
                  Positioned(
                    left: 100, // 50% of 200px
                    child: Container(
                      width: 2,
                      height: 20,
                      color: Color(0xFF424242),
                    ),
                  ),
                  // Value marker
                  Positioned(
                    left: normalized * 200 - 5,
                    child: Container(
                      width: 10,
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(0xFF7B1FA2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 50,
              alignment: Alignment.centerRight,
              child: Text(
                value.toString(),
                style: TextStyle(
                  fontFamily: 'monospace',
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

Widget _buildUseCase(String title, String range, String mid) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(Icons.check_circle, color: Color(0xFF2E7D32), size: 16),
        SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
          ),
        ),
        Text(range, style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
        SizedBox(width: 8),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xFF2E7D32),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            't=0.5: $mid',
            style: TextStyle(color: Colors.white, fontSize: 10),
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
            color: Color(0xFF90CAF9),
            fontWeight: FontWeight.bold,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                color: Color(0xFFBBDEFB),
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
