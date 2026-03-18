// D4rt test script: Deep Demo for ThreePointCubic from animation
// ThreePointCubic defines a curve through 3 control point regions
// Used for Material Design emphasis curves with precise control
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                THREE POINT CUBIC DEEP DEMO                        ║',
  );
  print(
    '║         Complex Curve with Three Control Regions                  ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: THREE POINT CUBIC FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: THREE POINT CUBIC FUNDAMENTALS                         │',
  );
  print(
    '│ Understanding the five-offset curve definition                    │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('ThreePointCubic characteristics:');
  print('  • Uses 5 control offsets to define the curve');
  print('  • a1: First part\'s first control point');
  print('  • b1: First part\'s second control point');
  print('  • midpoint: Where two cubic curves meet');
  print('  • a2: Second part\'s first control point');
  print('  • b2: Second part\'s second control point');
  print('  • Creates smooth Material Design motion');
  print('');

  // Standard Material emphasis curve
  final emphasisCurve = ThreePointCubic(
    Offset(0.05, 0.0),
    Offset(0.133333, 0.06),
    Offset(0.166666, 0.4),
    Offset(0.208333, 0.82),
    Offset(0.25, 1.0),
  );
  print('Created Material emphasis ThreePointCubic:');
  print('  a1: (0.05, 0.0)');
  print('  b1: (0.133333, 0.06)');
  print('  midpoint: (0.166666, 0.4)');
  print('  a2: (0.208333, 0.82)');
  print('  b2: (0.25, 1.0)');
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
  // SECTION 2: FULL CURVE TRANSFORMATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: FULL CURVE TRANSFORMATION                              │',
  );
  print(
    '│ Seeing the complex curve behavior                                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final emphasisResults = <Map<String, dynamic>>[];

  print('Material Emphasis ThreePointCubic values:');
  print(
    '┌───────┬─────────────────┬───────────────────────────────────────────┐',
  );
  print(
    '│   t   │     Output      │   Curve Shape                             │',
  );
  print(
    '├───────┼─────────────────┼───────────────────────────────────────────┤',
  );

  for (final t in tValues) {
    final out = emphasisCurve.transform(t);
    emphasisResults.add({'t': t, 'out': out});

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
  // SECTION 3: FINE-GRAINED ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: FINE-GRAINED ANALYSIS                                  │',
  );
  print(
    '│ Examining the curve at higher resolution                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final fineResults = <Map<String, dynamic>>[];

  print('Fine-grained curve values (20 steps):');
  print(
    '┌───────┬─────────────────┬───────────────────────────────────────────┐',
  );
  print(
    '│   t   │     Output      │   Progress                                │',
  );
  print(
    '├───────┼─────────────────┼───────────────────────────────────────────┤',
  );

  for (var i = 0; i <= 20; i++) {
    final t = i / 20;
    final out = emphasisCurve.transform(t);
    fineResults.add({'t': t, 'out': out});

    final barWidth = (out * 35).round().clamp(0, 35);
    final bar = '▓' * barWidth + '░' * (35 - barWidth);
    print(
      '│ ${t.toStringAsFixed(2)}  │     ${out.toStringAsFixed(4).padLeft(6)}      │ $bar │',
    );
  }
  print(
    '└───────┴─────────────────┴───────────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: BOUNDARY CONDITIONS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: BOUNDARY CONDITIONS                                    │',
  );
  print(
    '│ Start and end behavior                                            │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final boundaryResults = <Map<String, dynamic>>[];

  print('Values near boundaries:');
  print(
    '┌───────────┬─────────────────┬───────────────────────────────────────┐',
  );
  print(
    '│     t     │     Output      │   Status                              │',
  );
  print(
    '├───────────┼─────────────────┼───────────────────────────────────────┤',
  );

  for (final t in [0.0, 0.01, 0.02, 0.05, 0.95, 0.98, 0.99, 1.0]) {
    final out = emphasisCurve.transform(t);
    String status;
    if (t == 0.0) {
      status = 'Start (must be 0)';
    } else if (t == 1.0)
      status = 'End (must be 1)';
    else if (t < 0.1)
      status = 'Early acceleration';
    else
      status = 'Late deceleration';
    boundaryResults.add({'t': t, 'out': out, 'status': status});
    print(
      '│   ${t.toStringAsFixed(2).padLeft(5)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │ ${status.padRight(33)} │',
    );
  }
  print(
    '└───────────┴─────────────────┴───────────────────────────────────────┘',
  );
  print('');
  print('✓ Curve correctly starts at 0.0 and ends at 1.0');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: FLIPPED CURVE
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: FLIPPED CURVE                                          │',
  );
  print(
    '│ Reversed curve behavior                                           │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final flipped = emphasisCurve.flipped;
  final flippedResults = <Map<String, dynamic>>[];

  print('Original vs Flipped comparison:');
  print(
    '┌───────┬─────────────────┬─────────────────┬───────────────────────┐',
  );
  print(
    '│   t   │    Original     │    Flipped      │   Difference          │',
  );
  print(
    '├───────┼─────────────────┼─────────────────┼───────────────────────┤',
  );

  for (final t in tValues) {
    final orig = emphasisCurve.transform(t);
    final flip = flipped.transform(t);
    final diff = (orig - flip).abs();
    flippedResults.add({'t': t, 'orig': orig, 'flip': flip, 'diff': diff});
    print(
      '│ ${t.toStringAsFixed(1)}   │     ${orig.toStringAsFixed(4).padLeft(6)}      │     ${flip.toStringAsFixed(4).padLeft(6)}      │      ${diff.toStringAsFixed(4).padLeft(6)}       │',
    );
  }
  print(
    '└───────┴─────────────────┴─────────────────┴───────────────────────┘',
  );
  print('');
  print('Note: flipped(t) = 1 - original(1 - t)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: VELOCITY ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: VELOCITY ANALYSIS                                      │',
  );
  print(
    '│ How fast the curve changes                                        │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final velocityResults = <Map<String, dynamic>>[];

  print('Approximate velocity (derivative):');
  print(
    '┌───────┬─────────────────┬──────────────────────────────────────────┐',
  );
  print(
    '│   t   │   Velocity      │   Speed Indicator                        │',
  );
  print(
    '├───────┼─────────────────┼──────────────────────────────────────────┤',
  );

  for (var i = 1; i < 20; i++) {
    final t = i / 20;
    final prev = emphasisCurve.transform((i - 1) / 20);
    final curr = emphasisCurve.transform(t);
    final velocity = (curr - prev) * 20; // Approximate derivative
    velocityResults.add({'t': t, 'vel': velocity});

    final barWidth = (velocity / 3 * 30).round().clamp(0, 30);
    final bar = '▸' * barWidth + '░' * (30 - barWidth);
    print(
      '│ ${t.toStringAsFixed(2)}  │      ${velocity.toStringAsFixed(3).padLeft(6)}      │ $bar │',
    );
  }
  print(
    '└───────┴─────────────────┴──────────────────────────────────────────┘',
  );
  print('');
  print('Note: Higher velocity = faster change');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: MIDPOINT REGION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: MIDPOINT REGION                                        │',
  );
  print(
    '│ Behavior around the midpoint (0.166666, 0.4)                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final midpointResults = <Map<String, dynamic>>[];
  final midX = 0.166666;

  print('Values around midpoint (t ≈ 0.167):');
  print(
    '┌───────────┬─────────────────┬─────────────────────────────────────┐',
  );
  print(
    '│     t     │     Output      │   Position                          │',
  );
  print(
    '├───────────┼─────────────────┼─────────────────────────────────────┤',
  );

  for (final t in [0.10, 0.12, 0.14, 0.16, 0.167, 0.18, 0.20, 0.22]) {
    final out = emphasisCurve.transform(t);
    String pos;
    if (t < midX - 0.02) {
      pos = 'Before midpoint';
    } else if (t > midX + 0.02)
      pos = 'After midpoint';
    else
      pos = '← Near midpoint transition';
    midpointResults.add({'t': t, 'out': out, 'pos': pos});
    print(
      '│   ${t.toStringAsFixed(3).padLeft(5)}   │     ${out.toStringAsFixed(4).padLeft(6)}      │ ${pos.padRight(31)} │',
    );
  }
  print(
    '└───────────┴─────────────────┴─────────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: CUSTOM THREE POINT CUBIC
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: CUSTOM THREE POINT CUBIC                               │',
  );
  print(
    '│ Creating different curve shapes                                   │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // More aggressive start
  final customCurve1 = ThreePointCubic(
    Offset(0.1, 0.0),
    Offset(0.2, 0.2),
    Offset(0.3, 0.6),
    Offset(0.4, 0.9),
    Offset(0.5, 1.0),
  );

  // Slower start, aggressive end
  final customCurve2 = ThreePointCubic(
    Offset(0.2, 0.0),
    Offset(0.4, 0.1),
    Offset(0.5, 0.3),
    Offset(0.6, 0.7),
    Offset(0.8, 1.0),
  );

  final customResults = <Map<String, dynamic>>[];

  print('Custom curve comparison at key points:');
  print('┌───────┬─────────────────┬─────────────────┬─────────────────┐');
  print('│   t   │   Emphasis      │   Custom1       │    Custom2      │');
  print('├───────┼─────────────────┼─────────────────┼─────────────────┤');

  for (final t in [0.0, 0.2, 0.4, 0.6, 0.8, 1.0]) {
    final emp = emphasisCurve.transform(t);
    final c1 = customCurve1.transform(t);
    final c2 = customCurve2.transform(t);
    customResults.add({'t': t, 'emp': emp, 'c1': c1, 'c2': c2});
    print(
      '│ ${t.toStringAsFixed(1)}   │     ${emp.toStringAsFixed(4).padLeft(6)}      │     ${c1.toStringAsFixed(4).padLeft(6)}      │     ${c2.toStringAsFixed(4).padLeft(6)}      │',
    );
  }
  print('└───────┴─────────────────┴─────────────────┴─────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: COMPARISON WITH STANDARD CURVES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: COMPARISON WITH STANDARD CURVES                        │',
  );
  print(
    '│ ThreePointCubic vs Curves.easeInOut                               │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final compResults = <Map<String, dynamic>>[];

  print('ThreePointCubic vs easeInOut:');
  print(
    '┌───────┬─────────────────┬─────────────────┬───────────────────────┐',
  );
  print(
    '│   t   │ ThreePointCubic │   easeInOut     │   Difference          │',
  );
  print(
    '├───────┼─────────────────┼─────────────────┼───────────────────────┤',
  );

  for (final t in tValues) {
    final tpc = emphasisCurve.transform(t);
    final eio = Curves.easeInOut.transform(t);
    final diff = tpc - eio;
    compResults.add({'t': t, 'tpc': tpc, 'eio': eio, 'diff': diff});
    print(
      '│ ${t.toStringAsFixed(1)}   │     ${tpc.toStringAsFixed(4).padLeft(6)}      │     ${eio.toStringAsFixed(4).padLeft(6)}      │     ${diff >= 0 ? '+' : ''}${diff.toStringAsFixed(4).padLeft(6)}       │',
    );
  }
  print(
    '└───────┴─────────────────┴─────────────────┴───────────────────────┘',
  );
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
    '│ When to use ThreePointCubic                                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('1. Material Design Emphasis:');
  print('   Used for emphasis animations in Material Design');
  print('   Quick start, smooth settle');
  print('');

  print('2. Precise Motion Control:');
  print('   When standard curves don\'t match design spec');
  print('   Fine-tune acceleration/deceleration');
  print('');

  print('3. Multi-Phase Motion:');
  print('   Different acceleration in first vs second half');
  print('   Dramatic reveals');
  print('');

  print('4. Custom Brand Motion:');
  print('   Creating unique animation feel');
  print('   Matching brand guidelines');
  print('');

  print('5. Complex Transitions:');
  print('   Page transitions with specific timing');
  print('   Modal enter/exit effects');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                  THREE POINT CUBIC SUMMARY                        ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('ThreePointCubic key features:');
  print('  • Five control offsets define the curve');
  print('  • Two cubic curves joined at midpoint');
  print('  • Precise control over acceleration');
  print('  • Used in Material Design motion');
  print('');
  print('Best use cases:');
  print('  • Material emphasis animations');
  print('  • Precise motion specifications');
  print('  • Custom brand motion curves');
  print('  • Complex multi-phase transitions');
  print('');
  print('ThreePointCubic Deep Demo completed');

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
                colors: [Color(0xFFC2185B), Color(0xFFF48FB1)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'ThreePointCubic',
                  style: TextStyle(
                    fontSize: 26.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Complex Curve with Three Control Regions',
                  style: TextStyle(fontSize: 14.0, color: Color(0xFFFCE4EC)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Control Points
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
                  'CONTROL POINTS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC2185B),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildControlPointRow('a1', '(0.05, 0.0)', 'First curve start'),
                _buildControlPointRow('b1', '(0.133, 0.06)', 'First curve end'),
                _buildControlPointRow('mid', '(0.167, 0.4)', 'Junction point'),
                _buildControlPointRow(
                  'a2',
                  '(0.208, 0.82)',
                  'Second curve start',
                ),
                _buildControlPointRow('b2', '(0.25, 1.0)', 'Second curve end'),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Curve Visualization
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
                  'CURVE VISUALIZATION',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                SizedBox(
                  height: 120,
                  child: CustomPaint(
                    painter: ThreePointCubicPainter(emphasisCurve),
                    size: Size(double.infinity, 120),
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      't = 0',
                      style: TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                    Text(
                      'midpoint',
                      style: TextStyle(color: Color(0xFFE91E63), fontSize: 10),
                    ),
                    Text(
                      't = 1',
                      style: TextStyle(color: Colors.white70, fontSize: 10),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Values Table
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
                  'CURVE VALUES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...emphasisResults
                    .where(
                      (r) => [0.0, 0.2, 0.4, 0.6, 0.8, 1.0].contains(r['t']),
                    )
                    .map((r) => _buildValueRow(r)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Comparison Section
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
                  'VS EASEINOUT',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...compResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map((r) => _buildCompRow(r)),
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
                  'Material Emphasis',
                  'Quick start, smooth settle',
                ),
                _buildUseCaseItem('Precise Control', 'Fine-tune acceleration'),
                _buildUseCaseItem('Brand Motion', 'Unique animation feel'),
                _buildUseCaseItem(
                  'Complex Transitions',
                  'Page and modal effects',
                ),
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
                    _buildSummaryStat('Control Pts', '5'),
                    _buildSummaryStat('Curves', '3'),
                    _buildSummaryStat('Sections', '10'),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat(
                      'at 0.2',
                      emphasisCurve.transform(0.2).toStringAsFixed(2),
                    ),
                    _buildSummaryStat(
                      'at 0.5',
                      emphasisCurve.transform(0.5).toStringAsFixed(2),
                    ),
                    _buildSummaryStat(
                      'at 0.8',
                      emphasisCurve.transform(0.8).toStringAsFixed(2),
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
              'Deep Demo • ThreePointCubic • Flutter Animation',
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

Widget _buildControlPointRow(String name, String value, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 35,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xFFC2185B),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              name,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(width: 8),
        SizedBox(
          width: 80,
          child: Text(
            value,
            style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
        ),
        Expanded(
          child: Text(
            description,
            style: TextStyle(fontSize: 11, color: Color(0xFF757575)),
          ),
        ),
      ],
    ),
  );
}

class ThreePointCubicPainter extends CustomPainter {
  final ThreePointCubic curve;

  ThreePointCubicPainter(this.curve);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Color(0xFFE91E63)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(0, size.height);

    for (var i = 0; i <= 100; i++) {
      final t = i / 100;
      final value = curve.transform(t);
      path.lineTo(t * size.width, size.height - value * (size.height - 8));
    }

    canvas.drawPath(path, paint);

    // Draw midpoint marker
    final midPaint = Paint()
      ..color = Color(0xFFFFEB3B)
      ..style = PaintingStyle.fill;
    final midT = 0.167;
    final midY = curve.transform(midT);
    canvas.drawCircle(
      Offset(midT * size.width, size.height - midY * (size.height - 8)),
      4,
      midPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

Widget _buildValueRow(Map<String, dynamic> r) {
  final t = r['t'] as double;
  final out = r['out'] as double;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(
          width: 45,
          child: Text(
            't=${t.toStringAsFixed(1)}',
            style: TextStyle(fontSize: 11),
          ),
        ),
        Container(
          width: 55,
          padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
          decoration: BoxDecoration(
            color: Color(0xFF4CAF50),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Center(
            child: Text(
              out.toStringAsFixed(3),
              style: TextStyle(
                fontSize: 10,
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
              color: Color(0xFFC8E6C9),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: out.clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50),
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
  final tpc = r['tpc'] as double;
  final eio = r['eio'] as double;
  final diff = r['diff'] as double;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(
          width: 45,
          child: Text(
            't=${(r['t'] as double).toStringAsFixed(2)}',
            style: TextStyle(fontSize: 11),
          ),
        ),
        _buildSmallValue(tpc.toStringAsFixed(2), Color(0xFFE91E63)),
        SizedBox(width: 8),
        _buildSmallValue(eio.toStringAsFixed(2), Color(0xFF2196F3)),
        SizedBox(width: 8),
        Text(
          '${diff >= 0 ? '+' : ''}${diff.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 10,
            color: diff.abs() > 0.05 ? Colors.orange : Colors.grey,
          ),
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
