// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for ReverseTween from animation
// ReverseTween creates a reversed version of any tween
// Swaps begin and end without modifying the original
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                   REVERSE TWEEN DEEP DEMO                         ║',
  );
  print(
    '║              Creating Reversed Animation Tweens                   ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: REVERSE TWEEN FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: REVERSE TWEEN FUNDAMENTALS                             │',
  );
  print(
    '│ Understanding tween reversal                                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('ReverseTween characteristics:');
  print('  • Wraps any Tween<T> to reverse its direction');
  print('  • Swaps begin ↔ end values');
  print('  • Does NOT modify the original tween');
  print('  • Useful for bidirectional animations');
  print('  • Works with any tween type');
  print('');

  // Create basic tweens
  final doubleTween = Tween<double>(begin: 0.0, end: 100.0);
  final reversedDouble = ReverseTween<double>(doubleTween);

  print('Basic double tween reversal:');
  print('  Original: begin=${doubleTween.begin}, end=${doubleTween.end}');
  print('  Reversed: begin=${reversedDouble.begin}, end=${reversedDouble.end}');
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
  // SECTION 2: DOUBLE TWEEN COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: DOUBLE TWEEN COMPARISON                                │',
  );
  print(
    '│ Original vs Reversed side by side                                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final doubleResults = <Map<String, dynamic>>[];

  print('Tween<double>(0 → 100) vs ReverseTween:');
  print(
    '┌───────┬──────────────┬──────────────┬───────────────────────────────┐',
  );
  print(
    '│   t   │   Original   │   Reversed   │   Visualization               │',
  );
  print(
    '├───────┼──────────────┼──────────────┼───────────────────────────────┤',
  );

  for (final t in tValues) {
    final orig = doubleTween.transform(t);
    final rev = reversedDouble.transform(t);
    doubleResults.add({'t': t, 'orig': orig, 'rev': rev});

    final origBar = '█' * (orig / 100 * 12).round().clamp(0, 12);
    final revBar = '▓' * (rev / 100 * 12).round().clamp(0, 12);
    print(
      '│ ${t.toStringAsFixed(1)}   │    ${orig.toStringAsFixed(1).padLeft(6)}    │    ${rev.toStringAsFixed(1).padLeft(6)}    │ ${origBar.padRight(12)} ${revBar.padLeft(12)} │',
    );
  }
  print(
    '└───────┴──────────────┴──────────────┴───────────────────────────────┘',
  );
  print('');
  print('█ = Original (forward), ▓ = Reversed (backward)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: VERIFY REVERSAL RELATIONSHIP
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: VERIFY REVERSAL RELATIONSHIP                           │',
  );
  print(
    '│ Check: reversed(t) = original(1-t)                                │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final verifyResults = <Map<String, dynamic>>[];
  var allMatch = true;

  print('Verification: reversed(t) should equal original(1-t):');
  print('┌───────┬──────────────┬──────────────┬──────────────┬─────────┐');
  print('│   t   │  reversed(t) │ original(1-t)│   Difference │  Match  │');
  print('├───────┼──────────────┼──────────────┼──────────────┼─────────┤');

  for (final t in tValues) {
    final revVal = reversedDouble.transform(t);
    final origComplement = doubleTween.transform(1.0 - t);
    final diff = (revVal - origComplement).abs();
    final match = diff < 0.001;
    if (!match) allMatch = false;
    verifyResults.add({
      't': t,
      'rev': revVal,
      'origComp': origComplement,
      'diff': diff,
      'match': match,
    });
    print(
      '│ ${t.toStringAsFixed(1)}   │    ${revVal.toStringAsFixed(2).padLeft(7)}   │    ${origComplement.toStringAsFixed(2).padLeft(7)}   │    ${diff.toStringAsFixed(4).padLeft(7)}   │   ${match ? '✓' : '✗'}     │',
    );
  }
  print('└───────┴──────────────┴──────────────┴──────────────┴─────────┘');
  print('');
  print(
    'Result: ${allMatch ? '✓ All values match - reversal verified!' : '✗ Mismatch detected'}',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: NEGATIVE RANGE TWEEN
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: NEGATIVE RANGE TWEEN                                   │',
  );
  print(
    '│ Reversal with negative values                                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final negativeTween = Tween<double>(begin: -50.0, end: 50.0);
  final reversedNegative = ReverseTween<double>(negativeTween);

  final negResults = <Map<String, dynamic>>[];

  print('Tween<double>(-50 → 50) reversal:');
  print(
    '┌───────┬──────────────┬──────────────┬───────────────────────────────┐',
  );
  print(
    '│   t   │   Original   │   Reversed   │   Number Line                 │',
  );
  print(
    '├───────┼──────────────┼──────────────┼───────────────────────────────┤',
  );

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final orig = negativeTween.transform(t);
    final rev = reversedNegative.transform(t);
    negResults.add({'t': t, 'orig': orig, 'rev': rev});

    // Number line visualization
    final origPos = ((orig + 50) / 100 * 20).round().clamp(0, 20);
    final revPos = ((rev + 50) / 100 * 20).round().clamp(0, 20);
    final line = List.generate(21, (i) {
      if (i == 10) return '0';
      if (i == origPos && i == revPos) return '▓';
      if (i == origPos) return '█';
      if (i == revPos) return '░';
      return '─';
    }).join('');
    print(
      '│ ${t.toStringAsFixed(2)}  │    ${orig.toStringAsFixed(1).padLeft(6)}    │    ${rev.toStringAsFixed(1).padLeft(6)}    │ -50 $line 50 │',
    );
  }
  print(
    '└───────┴──────────────┴──────────────┴───────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: COLOR TWEEN REVERSAL
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: COLOR TWEEN REVERSAL                                   │',
  );
  print(
    '│ Reversing color interpolation                                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final colorTween = ColorTween(
    begin: Color(0xFFFF0000),
    end: Color(0xFF0000FF),
  );
  final reversedColor = ReverseTween<Color?>(colorTween);

  final colorResults = <Map<String, dynamic>>[];

  print('ColorTween (Red → Blue) reversal:');
  print('  Original: Red(#FF0000) → Blue(#0000FF)');
  print('  Reversed: Blue(#0000FF) → Red(#FF0000)');
  print('');
  print('┌───────┬──────────────────────────┬──────────────────────────┐');
  print('│   t   │   Original Color         │   Reversed Color         │');
  print('├───────┼──────────────────────────┼──────────────────────────┤');

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final origColor = colorTween.transform(t)!;
    final revColor = reversedColor.transform(t)!;
    colorResults.add({'t': t, 'orig': origColor, 'rev': revColor});

    final origHex =
        '#${origColor.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
    final revHex =
        '#${revColor.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase()}';
    print(
      '│ ${t.toStringAsFixed(2)}  │ ${origHex.padRight(24)} │ ${revHex.padRight(24)} │',
    );
  }
  print('└───────┴──────────────────────────┴──────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: INTEGER TWEEN REVERSAL
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: INTEGER TWEEN REVERSAL                                 │',
  );
  print(
    '│ Discrete value reversal                                           │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final intTween = IntTween(begin: 0, end: 10);
  final reversedInt = ReverseTween<int>(intTween);

  final intResults = <Map<String, dynamic>>[];

  print('IntTween(0 → 10) reversal:');
  print(
    '┌───────┬──────────────┬──────────────┬───────────────────────────────┐',
  );
  print(
    '│   t   │   Original   │   Reversed   │   Index Visualization         │',
  );
  print(
    '├───────┼──────────────┼──────────────┼───────────────────────────────┤',
  );

  for (final t in tValues) {
    final orig = intTween.transform(t);
    final rev = reversedInt.transform(t);
    intResults.add({'t': t, 'orig': orig, 'rev': rev});

    final origIndicator = List.generate(
      11,
      (i) => i == orig ? '█' : '░',
    ).join('');
    print(
      '│ ${t.toStringAsFixed(1)}   │      ${orig.toString().padLeft(2)}      │      ${rev.toString().padLeft(2)}      │ $origIndicator │',
    );
  }
  print(
    '└───────┴──────────────┴──────────────┴───────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: RECT TWEEN REVERSAL
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: RECT TWEEN REVERSAL                                    │',
  );
  print(
    '│ Reversing rectangle animations                                    │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final rectTween = RectTween(
    begin: Rect.fromLTWH(0, 0, 50, 50),
    end: Rect.fromLTWH(100, 100, 150, 100),
  );
  final reversedRect = ReverseTween<Rect?>(rectTween);

  final rectResults = <Map<String, dynamic>>[];

  print('RectTween reversal:');
  print('  Original: (0,0,50,50) → (100,100,150,100)');
  print('  Reversed: (100,100,150,100) → (0,0,50,50)');
  print('');
  print(
    '┌───────┬─────────────────────────────────┬─────────────────────────────────┐',
  );
  print(
    '│   t   │   Original Rect                 │   Reversed Rect                 │',
  );
  print(
    '├───────┼─────────────────────────────────┼─────────────────────────────────┤',
  );

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final orig = rectTween.transform(t)!;
    final rev = reversedRect.transform(t)!;
    rectResults.add({'t': t, 'orig': orig, 'rev': rev});

    final origStr =
        'L:${orig.left.toInt()} T:${orig.top.toInt()} W:${orig.width.toInt()} H:${orig.height.toInt()}';
    final revStr =
        'L:${rev.left.toInt()} T:${rev.top.toInt()} W:${rev.width.toInt()} H:${rev.height.toInt()}';
    print(
      '│ ${t.toStringAsFixed(2)}  │ ${origStr.padRight(31)} │ ${revStr.padRight(31)} │',
    );
  }
  print(
    '└───────┴─────────────────────────────────┴─────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: BIDIRECTIONAL ANIMATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: BIDIRECTIONAL ANIMATION                                │',
  );
  print(
    '│ Using ReverseTween for forward/backward playback                  │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('Bidirectional animation pattern:');
  print('');
  print('  // Forward animation');
  print('  animation.forward();  // Uses original tween');
  print('');
  print('  // Backward animation (alternative to .reverse())');
  print('  final reverseTween = ReverseTween(originalTween);');
  print('  animation.forward();  // With reverse tween = goes backward');
  print('');

  // Simulate animation progress
  print('Simulated bidirectional timeline:');
  print(
    '┌───────────────────────────────────────────────────────────────────────────┐',
  );

  final forwardFrames = <String>[];
  final backwardFrames = <String>[];

  for (var i = 0; i <= 10; i++) {
    final t = i / 10;
    final forwardVal = doubleTween.transform(t);
    final backwardVal = reversedDouble.transform(t);

    final fBar = '█' * (forwardVal / 100 * 20).round().clamp(0, 20);
    final bBar = '▓' * (backwardVal / 100 * 20).round().clamp(0, 20);
    forwardFrames.add(fBar.padRight(20));
    backwardFrames.add(bBar.padRight(20));
  }

  print('│ Forward:  ${forwardFrames.first} → ${forwardFrames.last} │');
  print('│ Backward: ${backwardFrames.first} → ${backwardFrames.last} │');
  print(
    '└───────────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: TRANSFORM METHOD
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: TRANSFORM METHOD                                       │',
  );
  print(
    '│ Using transform vs lerp                                           │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('transform(t) = begin + (end - begin) * t');
  print('');
  print('For ReverseTween, begin and end are swapped, so:');
  print('  reversed.transform(t) = end_orig + (begin_orig - end_orig) * t');
  print('  Which equals: original.transform(1-t)');
  print('');

  final transformResults = <Map<String, dynamic>>[];

  print('Transform comparison:');
  print('┌───────┬──────────────────┬──────────────────┬────────────────┐');
  print('│   t   │ original.trans() │ reversed.trans() │ orig(1-t)      │');
  print('├───────┼──────────────────┼──────────────────┼────────────────┤');

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final origTrans = doubleTween.transform(t);
    final revTrans = reversedDouble.transform(t);
    final origComplement = doubleTween.transform(1.0 - t);
    transformResults.add({
      't': t,
      'orig': origTrans,
      'rev': revTrans,
      'comp': origComplement,
    });
    print(
      '│ ${t.toStringAsFixed(2)}  │      ${origTrans.toStringAsFixed(2).padLeft(6)}        │      ${revTrans.toStringAsFixed(2).padLeft(6)}        │     ${origComplement.toStringAsFixed(2).padLeft(6)}       │',
    );
  }
  print('└───────┴──────────────────┴──────────────────┴────────────────┘');
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
    '│ When to use ReverseTween                                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('1. Toggle animations:');
  print('   Switch between forward and reverse tween based on state');
  print('');

  print('2. Ping-pong effects:');
  print('   Alternate between original and reversed tweens');
  print('');

  print('3. Undo animations:');
  print('   Play reverse tween to return to original state');
  print('');

  print('4. Mirrored UI elements:');
  print('   One element uses original, another uses reversed');
  print('');

  print('5. Sequential reversal:');
  print('   Chain animations: forward → reversed → forward');
  print('');

  print('Alternative: AnimationController.reverse()');
  print('  • Built-in method also reverses animation direction');
  print('  • ReverseTween is useful when you need the reversed');
  print('    tween as a separate object');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                   REVERSE TWEEN SUMMARY                           ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('ReverseTween key features:');
  print('  • Wraps any Tween<T> to reverse direction');
  print('  • Swaps begin ↔ end values');
  print('  • Does not modify original tween');
  print('  • reversed(t) = original(1-t)');
  print('');
  print('Works with all tween types:');
  print('  • Tween<double>');
  print('  • IntTween');
  print('  • ColorTween');
  print('  • RectTween');
  print('  • Any custom Tween<T>');
  print('');
  print('ReverseTween Deep Demo completed');

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
                colors: [Color(0xFFE65100), Color(0xFFFF9800)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'ReverseTween',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Creating Reversed Animation Tweens',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFFFE0B2)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Concept Section
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
                  'REVERSAL CONCEPT',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Color(0xFFFFCC80)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Original: begin → end',
                        style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
                      ),
                      Text(
                        'Reversed: end → begin',
                        style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'reversed(t) = original(1-t)',
                        style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
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

          // Double Comparison Visual
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
                  'DOUBLE TWEEN COMPARISON',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3949AB),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Tween<double>(0 → 100)',
                  style: TextStyle(fontSize: 11, color: Color(0xFF5C6BC0)),
                ),
                SizedBox(height: 12.0),
                ...doubleResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map(
                      (r) => _buildDoubleRow(
                        't=${(r['t'] as double).toStringAsFixed(2)}',
                        r['orig'] as double,
                        r['rev'] as double,
                      ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Color Comparison
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
                  'COLOR TWEEN REVERSAL',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC2185B),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Red → Blue',
                  style: TextStyle(fontSize: 11, color: Color(0xFFE91E63)),
                ),
                SizedBox(height: 12.0),
                ...colorResults.map(
                  (r) => _buildColorRow(
                    't=${(r['t'] as double).toStringAsFixed(2)}',
                    r['orig'] as Color,
                    r['rev'] as Color,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Verification
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
                  'REVERSAL VERIFICATION',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Check: reversed(t) = original(1-t)',
                  style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                ),
                SizedBox(height: 12.0),
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: allMatch ? Color(0xFFC8E6C9) : Color(0xFFFFCDD2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        allMatch ? Icons.check_circle : Icons.error,
                        color: allMatch ? Color(0xFF2E7D32) : Color(0xFFC62828),
                      ),
                      SizedBox(width: 8),
                      Text(
                        allMatch
                            ? 'All values match - verified!'
                            : 'Mismatch detected',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: allMatch
                              ? Color(0xFF2E7D32)
                              : Color(0xFFC62828),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Use Cases
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFEDE7F6),
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
                    color: Color(0xFF512DA8),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildUseCaseItem(
                  'Toggle animations',
                  'Forward/reverse based on state',
                ),
                _buildUseCaseItem(
                  'Ping-pong effects',
                  'Alternate between tweens',
                ),
                _buildUseCaseItem(
                  'Undo animations',
                  'Return to original state',
                ),
                _buildUseCaseItem('Mirrored elements', 'Opposite animations'),
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
                    _buildSummaryStat('Tween Types', '4'),
                    _buildSummaryStat('Test Points', '${tValues.length}'),
                    _buildSummaryStat('Verified', allMatch ? 'Yes' : 'No'),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat(
                      'Orig(0.5)',
                      '${doubleTween.transform(0.5).toInt()}',
                    ),
                    _buildSummaryStat(
                      'Rev(0.5)',
                      '${reversedDouble.transform(0.5).toInt()}',
                    ),
                    _buildSummaryStat(
                      'Sum',
                      '${(doubleTween.transform(0.5) + reversedDouble.transform(0.5)).toInt()}',
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
              'Deep Demo • ReverseTween • Flutter Animation',
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

Widget _buildDoubleRow(String label, double orig, double rev) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(width: 50, child: Text(label, style: TextStyle(fontSize: 11))),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: Color(0xFFC5CAE9),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (orig / 100).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFF3949AB),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 4),
              Expanded(
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE0B2),
                    borderRadius: BorderRadius.circular(2),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: (rev / 100).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFF9800),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${orig.toInt()}',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFF3949AB),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(' / ', style: TextStyle(fontSize: 10)),
              Text(
                '${rev.toInt()}',
                style: TextStyle(
                  fontSize: 10,
                  color: Color(0xFFFF9800),
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

Widget _buildColorRow(String label, Color orig, Color rev) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(width: 50, child: Text(label, style: TextStyle(fontSize: 11))),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: orig,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Color(0xFF9E9E9E)),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Container(
                  height: 24,
                  decoration: BoxDecoration(
                    color: rev,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Color(0xFF9E9E9E)),
                  ),
                ),
              ),
            ],
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
            color: Color(0xFF512DA8),
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
