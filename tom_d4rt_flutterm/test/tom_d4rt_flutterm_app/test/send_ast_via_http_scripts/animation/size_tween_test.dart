// D4rt test script: Deep Demo for SizeTween from animation
// SizeTween interpolates between two Size values
// Perfect for size animations, grow/shrink effects
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                    SIZE TWEEN DEEP DEMO                           ║',
  );
  print(
    '║              Width and Height Interpolation                       ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: SIZE TWEEN FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: SIZE TWEEN FUNDAMENTALS                                │',
  );
  print(
    '│ Understanding width and height interpolation                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('SizeTween characteristics:');
  print('  • Interpolates between two Size values');
  print('  • Width and height interpolate independently');
  print(
    '  • Formula: Size(w_begin + t*(w_end-w_begin), h_begin + t*(h_end-h_begin))',
  );
  print('  • Area changes non-linearly unless dimensions scale equally');
  print('  • Perfect for grow/shrink animations');
  print('');

  // Create basic tween
  final basicTween = SizeTween(
    begin: Size(50.0, 50.0),
    end: Size(200.0, 100.0),
  );
  print('Created SizeTween:');
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
  // SECTION 2: FULL INTERPOLATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: FULL INTERPOLATION                                     │',
  );
  print(
    '│ Size values at each t step                                        │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final interpResults = <Map<String, dynamic>>[];

  print('Interpolation from (50x50) to (200x100):');
  print(
    '┌───────┬─────────────┬─────────────┬────────────────┬──────────────────────────┐',
  );
  print(
    '│   t   │    Width    │   Height    │     Area       │   Aspect Ratio           │',
  );
  print(
    '├───────┼─────────────┼─────────────┼────────────────┼──────────────────────────┤',
  );

  for (final t in tValues) {
    final s = basicTween.lerp(t)!;
    final area = s.width * s.height;
    final aspectRatio = s.width / s.height;
    interpResults.add({
      't': t,
      'w': s.width,
      'h': s.height,
      'area': area,
      'ar': aspectRatio,
    });
    print(
      '│ ${t.toStringAsFixed(1)}   │   ${s.width.toStringAsFixed(1).padLeft(6)}    │   ${s.height.toStringAsFixed(1).padLeft(6)}    │   ${area.toStringAsFixed(0).padLeft(8)}     │   ${aspectRatio.toStringAsFixed(3).padLeft(6)}               │',
    );
  }
  print(
    '└───────┴─────────────┴─────────────┴────────────────┴──────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ZERO TO FULL SIZE
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: ZERO TO FULL SIZE                                      │',
  );
  print(
    '│ Growing from nothing                                              │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final zeroTween = SizeTween(begin: Size.zero, end: Size(300.0, 200.0));
  final zeroResults = <Map<String, dynamic>>[];

  print('Zero to Size(300x200):');
  print(
    '┌───────┬─────────────┬─────────────┬─────────────────────────────────┐',
  );
  print(
    '│   t   │    Width    │   Height    │   Visualization                 │',
  );
  print(
    '├───────┼─────────────┼─────────────┼─────────────────────────────────┤',
  );

  for (final t in tValues) {
    final s = zeroTween.lerp(t)!;
    zeroResults.add({'t': t, 'w': s.width, 'h': s.height});

    final barWidth = (s.width / 300 * 25).round().clamp(0, 25);
    final bar = '█' * barWidth + '░' * (25 - barWidth);
    print(
      '│ ${t.toStringAsFixed(1)}   │   ${s.width.toStringAsFixed(0).padLeft(6)}    │   ${s.height.toStringAsFixed(0).padLeft(6)}    │ $bar │',
    );
  }
  print(
    '└───────┴─────────────┴─────────────┴─────────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: SQUARE TO RECTANGLE TRANSFORMATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: SQUARE TO RECTANGLE TRANSFORMATION                     │',
  );
  print(
    '│ Shape morphing animation                                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final shapeTween = SizeTween(
    begin: Size(100.0, 100.0),
    end: Size(300.0, 50.0),
  );
  final shapeResults = <Map<String, dynamic>>[];

  print('Square (100x100) to wide rectangle (300x50):');
  print('┌───────┬────────────────────┬────────────────┬────────────────────┐');
  print('│   t   │       Size         │   Aspect Ratio │   Shape            │');
  print('├───────┼────────────────────┼────────────────┼────────────────────┤');

  for (final t in tValues) {
    final s = shapeTween.lerp(t)!;
    final ar = s.width / s.height;
    String shape;
    if (ar < 1.2)
      shape = 'Square';
    else if (ar < 2.0)
      shape = 'Rectangle';
    else if (ar < 4.0)
      shape = 'Wide rect';
    else
      shape = 'Very wide';
    shapeResults.add({'t': t, 'size': s, 'ar': ar, 'shape': shape});
    print(
      '│ ${t.toStringAsFixed(1)}   │  ${s.width.toStringAsFixed(0).padLeft(3)} x ${s.height.toStringAsFixed(0).padLeft(3)}         │     ${ar.toStringAsFixed(2).padLeft(5)}      │ ${shape.padRight(16)} │',
    );
  }
  print('└───────┴────────────────────┴────────────────┴────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: AREA ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: AREA ANALYSIS                                          │',
  );
  print(
    '│ Area changes non-linearly!                                        │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('IMPORTANT: Area interpolation is NOT linear!');
  print('  When width and height change at different rates,');
  print('  the area follows a more complex curve.');
  print('');

  final areaTween = SizeTween(begin: Size(50.0, 50.0), end: Size(150.0, 150.0));
  final areaResults = <Map<String, dynamic>>[];

  print('Uniform scaling (50x50) to (150x150):');
  print('┌───────┬──────────────┬────────────────┬────────────────────┐');
  print('│   t   │    Size      │     Area       │   Area Change %    │');
  print('├───────┼──────────────┼────────────────┼────────────────────┤');

  final beginArea = 50.0 * 50.0;
  for (final t in tValues) {
    final s = areaTween.lerp(t)!;
    final area = s.width * s.height;
    final areaPercent = (area / beginArea * 100) - 100;
    areaResults.add({'t': t, 'size': s, 'area': area, 'percent': areaPercent});
    print(
      '│ ${t.toStringAsFixed(1)}   │ ${s.width.toStringAsFixed(0).padLeft(3)}x${s.height.toStringAsFixed(0).padLeft(3)}       │   ${area.toStringAsFixed(0).padLeft(8)}     │   ${areaPercent >= 0 ? '+' : ''}${areaPercent.toStringAsFixed(0).padLeft(4)}%            │',
    );
  }
  print('└───────┴──────────────┴────────────────┴────────────────────┘');
  print('');
  print('Note: At t=0.5, area is 10000 (4x original), not 4500 (linear)!');
  print('      Area follows: (begin_dim + t*Δdim)²  = quadratic growth');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: WIDTH-ONLY AND HEIGHT-ONLY CHANGES
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: WIDTH-ONLY AND HEIGHT-ONLY CHANGES                     │',
  );
  print(
    '│ Single dimension animations                                       │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final widthOnlyTween = SizeTween(
    begin: Size(50.0, 100.0),
    end: Size(250.0, 100.0),
  );

  final heightOnlyTween = SizeTween(
    begin: Size(100.0, 30.0),
    end: Size(100.0, 150.0),
  );

  final singleDimResults = <Map<String, dynamic>>[];

  print('Width-only change (height constant at 100):');
  print('┌───────┬──────────────┬──────────────────────────────────────────┐');
  print('│   t   │    Size      │   Width Bar                              │');
  print('├───────┼──────────────┼──────────────────────────────────────────┤');

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final s = widthOnlyTween.lerp(t)!;
    singleDimResults.add({'type': 'width', 't': t, 'size': s});

    final barWidth = (s.width / 250 * 32).round().clamp(0, 32);
    final bar = '▓' * barWidth + '░' * (32 - barWidth);
    print(
      '│ ${t.toStringAsFixed(2)}  │ ${s.width.toStringAsFixed(0).padLeft(3)}x${s.height.toStringAsFixed(0).padLeft(3)}     │ $bar │',
    );
  }
  print('└───────┴──────────────┴──────────────────────────────────────────┘');
  print('');

  print('Height-only change (width constant at 100):');
  print('┌───────┬──────────────┬──────────────────────────────────────────┐');
  print('│   t   │    Size      │   Height Bar                             │');
  print('├───────┼──────────────┼──────────────────────────────────────────┤');

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final s = heightOnlyTween.lerp(t)!;
    singleDimResults.add({'type': 'height', 't': t, 'size': s});

    final barHeight = (s.height / 150 * 32).round().clamp(0, 32);
    final bar = '▓' * barHeight + '░' * (32 - barHeight);
    print(
      '│ ${t.toStringAsFixed(2)}  │ ${s.width.toStringAsFixed(0).padLeft(3)}x${s.height.toStringAsFixed(0).padLeft(3)}     │ $bar │',
    );
  }
  print('└───────┴──────────────┴──────────────────────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: SHRINKING ANIMATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: SHRINKING ANIMATION                                    │',
  );
  print(
    '│ Collapse from large to small                                      │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final shrinkTween = SizeTween(
    begin: Size(200.0, 150.0),
    end: Size(20.0, 15.0),
  );
  final shrinkResults = <Map<String, dynamic>>[];

  print('Shrinking from (200x150) to (20x15):');
  print(
    '┌───────┬──────────────────┬─────────────────┬───────────────────────┐',
  );
  print(
    '│   t   │      Size        │    Scale %      │   Visual              │',
  );
  print(
    '├───────┼──────────────────┼─────────────────┼───────────────────────┤',
  );

  for (final t in tValues) {
    final s = shrinkTween.lerp(t)!;
    final scale = s.width / 200.0 * 100;
    shrinkResults.add({'t': t, 'size': s, 'scale': scale});

    final barWidth = ((1.0 - t) * 15).round().clamp(0, 15);
    final bar = '█' * barWidth + '░' * (15 - barWidth);
    print(
      '│ ${t.toStringAsFixed(1)}   │  ${s.width.toStringAsFixed(0).padLeft(5)} x ${s.height.toStringAsFixed(0).padLeft(5)}   │     ${scale.toStringAsFixed(0).padLeft(3)}%       │ $bar │',
    );
  }
  print(
    '└───────┴──────────────────┴─────────────────┴───────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: MULTIPLE SIZE TWEENS COMPARISON
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: MULTIPLE SIZE TWEENS COMPARISON                        │',
  );
  print(
    '│ Different transformation behaviors                                │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final tweenA = SizeTween(
    begin: Size(100, 100),
    end: Size(200, 200),
  ); // Uniform grow
  final tweenB = SizeTween(
    begin: Size(100, 100),
    end: Size(200, 100),
  ); // Width only
  final tweenC = SizeTween(
    begin: Size(100, 100),
    end: Size(100, 200),
  ); // Height only
  final tweenD = SizeTween(
    begin: Size(100, 100),
    end: Size(200, 50),
  ); // Width up, height down

  final compareResults = <Map<String, dynamic>>[];

  print('Size comparison at t=0.5:');
  print(
    '┌──────────────────────┬──────────────────┬──────────────────┬─────────────┐',
  );
  print(
    '│ Tween Type           │ Begin            │ End              │ At t=0.5    │',
  );
  print(
    '├──────────────────────┼──────────────────┼──────────────────┼─────────────┤',
  );

  final sA = tweenA.lerp(0.5)!;
  final sB = tweenB.lerp(0.5)!;
  final sC = tweenC.lerp(0.5)!;
  final sD = tweenD.lerp(0.5)!;

  compareResults.add({
    'name': 'Uniform grow',
    'begin': Size(100, 100),
    'end': Size(200, 200),
    'mid': sA,
  });
  compareResults.add({
    'name': 'Width only',
    'begin': Size(100, 100),
    'end': Size(200, 100),
    'mid': sB,
  });
  compareResults.add({
    'name': 'Height only',
    'begin': Size(100, 100),
    'end': Size(100, 200),
    'mid': sC,
  });
  compareResults.add({
    'name': 'W up, H down',
    'begin': Size(100, 100),
    'end': Size(200, 50),
    'mid': sD,
  });

  print(
    '│ Uniform grow         │ 100x100          │ 200x200          │ ${sA.width.toStringAsFixed(0)}x${sA.height.toStringAsFixed(0)}     │',
  );
  print(
    '│ Width only           │ 100x100          │ 200x100          │ ${sB.width.toStringAsFixed(0)}x${sB.height.toStringAsFixed(0)}     │',
  );
  print(
    '│ Height only          │ 100x100          │ 100x200          │ ${sC.width.toStringAsFixed(0)}x${sC.height.toStringAsFixed(0)}     │',
  );
  print(
    '│ W up, H down         │ 100x100          │ 200x50           │ ${sD.width.toStringAsFixed(0)}x${sD.height.toStringAsFixed(0)}      │',
  );
  print(
    '└──────────────────────┴──────────────────┴──────────────────┴─────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: EVALUATE WITH ANIMATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: EVALUATE WITH ANIMATION                                │',
  );
  print(
    '│ Using evaluate() method                                           │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final evalResults = <Map<String, dynamic>>[];

  print('evaluate() vs lerp() comparison:');
  print('┌───────┬─────────────────┬─────────────────┬───────────────────┐');
  print('│   t   │    lerp(t)      │   evaluate()    │    Match?         │');
  print('├───────┼─────────────────┼─────────────────┼───────────────────┤');

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final lerpVal = basicTween.lerp(t)!;
    final anim = AlwaysStoppedAnimation<double>(t);
    final evalVal = basicTween.evaluate(anim)!;
    final match =
        lerpVal.width == evalVal.width && lerpVal.height == evalVal.height;
    evalResults.add({'t': t, 'lerp': lerpVal, 'eval': evalVal, 'match': match});
    print(
      '│ ${t.toStringAsFixed(2)}  │ ${lerpVal.width.toStringAsFixed(0)}x${lerpVal.height.toStringAsFixed(0).padLeft(3)}         │ ${evalVal.width.toStringAsFixed(0)}x${evalVal.height.toStringAsFixed(0).padLeft(3)}         │       ${match ? '✓' : '✗'}         │',
    );
  }
  print('└───────┴─────────────────┴─────────────────┴───────────────────┘');
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
    '│ Common SizeTween applications                                     │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('1. Modal Dialog Grow:');
  final modalTween = SizeTween(begin: Size(0, 0), end: Size(320, 480));
  print('   From invisible to ${modalTween.end}');
  print('');

  print('2. Image Zoom:');
  final zoomTween = SizeTween(begin: Size(100, 75), end: Size(400, 300));
  print('   From thumbnail to fullsize');
  print('');

  print('3. Collapse Animation:');
  final collapseTween = SizeTween(begin: Size(200, 100), end: Size(200, 0));
  print('   Height collapses while width stays');
  print('');

  print('4. Expand/Collapse Container:');
  final expandTween = SizeTween(begin: Size(48, 48), end: Size(200, 150));
  print('   FAB to expanded panel');
  print('');

  print('5. Card Resize:');
  final cardTween = SizeTween(begin: Size(300, 200), end: Size(350, 250));
  print('   Subtle emphasis effect');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                     SIZE TWEEN SUMMARY                            ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('SizeTween key features:');
  print('  • Interpolates width and height independently');
  print('  • Area changes non-linearly (quadratic for uniform scaling)');
  print('  • Supports null begin/end for conditional animations');
  print('  • Works with AlwaysStoppedAnimation via evaluate()');
  print('');
  print('Common patterns:');
  print('  • Grow from zero: dialog/modal entry');
  print('  • Shrink to zero: collapse/dismiss');
  print('  • Shape morph: square to rectangle');
  print('  • Single dimension: accordion expand');
  print('');
  print('SizeTween Deep Demo completed');

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
                colors: [Color(0xFF795548), Color(0xFFA1887F)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'SizeTween',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Width and Height Interpolation',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFD7CCC8)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Size Interpolation Visualization
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
                  'SIZE INTERPOLATION',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF5D4037),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'From 50×50 to 200×100:',
                  style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                ),
                SizedBox(height: 12.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: [
                    for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
                      _buildSizeBox(basicTween.lerp(t)!, t, Color(0xFF795548)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Area Growth Analysis
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
                  'AREA ANALYSIS (NON-LINEAR!)',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...areaResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map((r) => _buildAreaRow(r)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Shape Morphing
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
                  'SHAPE MORPHING',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFE65100),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Text(
                  'Square to wide rectangle:',
                  style: TextStyle(fontSize: 12, color: Color(0xFF757575)),
                ),
                SizedBox(height: 12.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.center,
                  children: [
                    for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
                      _buildShapeBox(shapeTween.lerp(t)!, t),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Comparison Table
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
                  'TWEEN TYPE COMPARISON',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...compareResults.map((r) => _buildCompareRow(r)),
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
                  'COMMON USE CASES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildUseCaseRow('Modal Dialog', 'Grow from center'),
                _buildUseCaseRow('Image Zoom', 'Thumbnail to full'),
                _buildUseCaseRow('Collapse', 'Height only shrink'),
                _buildUseCaseRow('FAB Expand', 'Button to panel'),
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
                    _buildSummaryStat('Tweens', '7'),
                    _buildSummaryStat('Steps', '${tValues.length}'),
                    _buildSummaryStat('Sections', '10'),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat('Max W', '300'),
                    _buildSummaryStat('Max H', '200'),
                    _buildSummaryStat('Eval ✓', '5'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),

          // Footer
          Center(
            child: Text(
              'Deep Demo • SizeTween • Flutter Animation',
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

Widget _buildSizeBox(Size size, double t, Color color) {
  final scale = 0.4;
  return Column(
    children: [
      Container(
        width: size.width * scale,
        height: size.height * scale,
        decoration: BoxDecoration(
          color: color.withOpacity(0.3 + t * 0.7),
          border: Border.all(color: color, width: 2),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            't=${t.toStringAsFixed(1)}',
            style: TextStyle(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
      ),
      SizedBox(height: 4),
      Text(
        '${size.width.toStringAsFixed(0)}×${size.height.toStringAsFixed(0)}',
        style: TextStyle(fontSize: 9, color: Color(0xFF757575)),
      ),
    ],
  );
}

Widget _buildAreaRow(Map<String, dynamic> r) {
  final size = r['size'] as Size;
  final area = r['area'] as double;
  final percent = r['percent'] as double;

  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 45,
          child: Text(
            't=${(r['t'] as double).toStringAsFixed(1)}',
            style: TextStyle(fontSize: 11),
          ),
        ),
        Container(
          width: 55,
          child: Text(
            '${size.width.toStringAsFixed(0)}×${size.height.toStringAsFixed(0)}',
            style: TextStyle(fontSize: 11, fontFamily: 'monospace'),
          ),
        ),
        Expanded(
          child: Container(
            height: 16,
            decoration: BoxDecoration(
              color: Color(0xFFC8E6C9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (area / 22500).clamp(0.0, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFF4CAF50),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ),
        Container(
          width: 60,
          alignment: Alignment.centerRight,
          child: Text(
            '${percent >= 0 ? '+' : ''}${percent.toStringAsFixed(0)}%',
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildShapeBox(Size size, double t) {
  final maxWidth = 150.0;
  final maxHeight = 50.0;
  final scaleW = maxWidth / 300;
  final scaleH = maxHeight / 100;

  return Column(
    children: [
      Container(
        width: size.width * scaleW,
        height: size.height * scaleH,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFF9800), Color(0xFFFFCC80)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: Text(
            '${t.toStringAsFixed(1)}',
            style: TextStyle(
              fontSize: 9,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      SizedBox(height: 4),
      Text(
        '${(size.width / size.height).toStringAsFixed(1)}:1',
        style: TextStyle(fontSize: 9, color: Color(0xFF757575)),
      ),
    ],
  );
}

Widget _buildCompareRow(Map<String, dynamic> r) {
  final mid = r['mid'] as Size;
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(
          width: 80,
          child: Text(
            r['name'] as String,
            style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Color(0xFFE1BEE7),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            '${mid.width.toStringAsFixed(0)}×${mid.height.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 10,
              fontFamily: 'monospace',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 12,
            decoration: BoxDecoration(
              color: Color(0xFFF3E5F5),
              borderRadius: BorderRadius.circular(2),
            ),
            child: Row(
              children: [
                Container(width: mid.width / 4, color: Color(0xFF9C27B0)),
                Container(width: 1, color: Colors.white),
                Container(width: mid.height / 4, color: Color(0xFFCE93D8)),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildUseCaseRow(String title, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Icon(Icons.check_circle, size: 14, color: Color(0xFF1565C0)),
        SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
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
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4DD0E1),
        ),
      ),
      Text(label, style: TextStyle(fontSize: 10.0, color: Color(0xFF90A4AE))),
    ],
  );
}
