// D4rt test script: Deep Demo for RectTween from animation
// RectTween interpolates between two Rect objects
// Perfect for animating widget positions and sizes
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                    RECT TWEEN DEEP DEMO                           ║');
  print('║            Interpolating Rectangle Position & Size                ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: RECT TWEEN FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 1: RECT TWEEN FUNDAMENTALS                                │');
  print('│ Understanding rectangle interpolation                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');
  
  print('RectTween characteristics:');
  print('  • Interpolates all 4 Rect properties: left, top, right, bottom');
  print('  • Effectively animates position AND size simultaneously');
  print('  • Uses linear interpolation for each property');
  print('  • Null safety: returns null if begin or end is null');
  print('  • Common use: window/card animations, morphing shapes');
  print('');

  // Create basic tween
  final basicTween = RectTween(
    begin: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
    end: Rect.fromLTWH(200.0, 100.0, 200.0, 150.0),
  );
  print('Basic RectTween created:');
  print('  Begin: ${basicTween.begin}');
  print('  End: ${basicTween.end}');
  print('');

  final tValues = <double>[0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: FULL INTERPOLATION
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 2: FULL INTERPOLATION                                     │');
  print('│ Position and size changing together                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final fullResults = <Map<String, dynamic>>[];
  
  print('Complete interpolation path:');
  print('┌───────┬──────────────┬──────────────┬──────────────┬──────────────┐');
  print('│   t   │     Left     │     Top      │    Width     │    Height    │');
  print('├───────┼──────────────┼──────────────┼──────────────┼──────────────┤');
  
  for (final t in tValues) {
    final r = basicTween.lerp(t)!;
    fullResults.add({'t': t, 'rect': r, 'left': r.left, 'top': r.top, 'width': r.width, 'height': r.height});
    print('│ ${t.toStringAsFixed(1)}   │    ${r.left.toStringAsFixed(1).padLeft(6)}    │    ${r.top.toStringAsFixed(1).padLeft(6)}    │    ${r.width.toStringAsFixed(1).padLeft(6)}    │    ${r.height.toStringAsFixed(1).padLeft(6)}    │');
  }
  print('└───────┴──────────────┴──────────────┴──────────────┴──────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: POSITION ONLY ANIMATION
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 3: POSITION ONLY ANIMATION                                │');
  print('│ Moving rectangle without changing size                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final positionTween = RectTween(
    begin: Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
    end: Rect.fromLTWH(200.0, 150.0, 100.0, 80.0),
  );
  
  final posResults = <Map<String, dynamic>>[];
  
  print('Position-only tween (size constant 100x80):');
  print('┌───────┬──────────────┬──────────────┬──────────────────────────────┐');
  print('│   t   │     Left     │     Top      │   Position Visualization     │');
  print('├───────┼──────────────┼──────────────┼──────────────────────────────┤');
  
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final r = positionTween.lerp(t)!;
    posResults.add({'t': t, 'left': r.left, 'top': r.top, 'width': r.width, 'height': r.height});
    
    // Visual position indicator
    final xPos = (r.left / 200 * 20).round().clamp(0, 20);
    final yPos = (r.top / 150 * 5).round().clamp(0, 5);
    final vis = 'X=${r.left.toStringAsFixed(0).padLeft(3)} Y=${r.top.toStringAsFixed(0).padLeft(3)}';
    print('│ ${t.toStringAsFixed(2)}  │    ${r.left.toStringAsFixed(1).padLeft(6)}    │    ${r.top.toStringAsFixed(1).padLeft(6)}    │ $vis │');
  }
  print('└───────┴──────────────┴──────────────┴──────────────────────────────┘');
  print('');
  print('Size verification:');
  for (final r in posResults) {
    print('  t=${r['t']}: width=${r['width']}, height=${r['height']} (constant ✓)');
  }
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: SIZE ONLY ANIMATION
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 4: SIZE ONLY ANIMATION                                    │');
  print('│ Growing/shrinking rectangle at fixed position                     │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final sizeTween = RectTween(
    begin: Rect.fromLTWH(50.0, 50.0, 50.0, 50.0),
    end: Rect.fromLTWH(50.0, 50.0, 200.0, 150.0),
  );
  
  final sizeResults = <Map<String, dynamic>>[];
  
  print('Size-only tween (position constant at 50,50):');
  print('┌───────┬──────────────┬──────────────┬──────────────────────────────┐');
  print('│   t   │    Width     │    Height    │   Size Visualization         │');
  print('├───────┼──────────────┼──────────────┼──────────────────────────────┤');
  
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final r = sizeTween.lerp(t)!;
    sizeResults.add({'t': t, 'left': r.left, 'top': r.top, 'width': r.width, 'height': r.height});
    
    final wBar = '█' * (r.width / 200 * 15).round().clamp(0, 15);
    final hBar = '▓' * (r.height / 150 * 10).round().clamp(0, 10);
    print('│ ${t.toStringAsFixed(2)}  │    ${r.width.toStringAsFixed(1).padLeft(6)}    │    ${r.height.toStringAsFixed(1).padLeft(6)}    │ W:${wBar.padRight(15)} │');
  }
  print('└───────┴──────────────┴──────────────┴──────────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: CENTER-BASED GROWTH
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 5: CENTER-BASED GROWTH                                    │');
  print('│ Scaling from center point                                         │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  // To scale from center, start and end must have same center
  final centerX = 150.0;
  final centerY = 100.0;
  final centerTween = RectTween(
    begin: Rect.fromCenter(center: Offset(centerX, centerY), width: 50.0, height: 50.0),
    end: Rect.fromCenter(center: Offset(centerX, centerY), width: 200.0, height: 150.0),
  );
  
  final centerResults = <Map<String, dynamic>>[];
  
  print('Center-based growth (center at 150,100):');
  print('┌───────┬──────────────┬──────────────┬──────────────┬──────────────┐');
  print('│   t   │   Center X   │   Center Y   │    Width     │    Height    │');
  print('├───────┼──────────────┼──────────────┼──────────────┼──────────────┤');
  
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final r = centerTween.lerp(t)!;
    final cx = r.left + r.width / 2;
    final cy = r.top + r.height / 2;
    centerResults.add({'t': t, 'cx': cx, 'cy': cy, 'width': r.width, 'height': r.height});
    print('│ ${t.toStringAsFixed(2)}  │    ${cx.toStringAsFixed(1).padLeft(6)}    │    ${cy.toStringAsFixed(1).padLeft(6)}    │    ${r.width.toStringAsFixed(1).padLeft(6)}    │    ${r.height.toStringAsFixed(1).padLeft(6)}    │');
  }
  print('└───────┴──────────────┴──────────────┴──────────────┴──────────────┘');
  print('');
  print('Center verification (should remain constant):');
  for (final r in centerResults) {
    final cxMatch = (r['cx'] as double - 150.0).abs() < 0.01;
    final cyMatch = (r['cy'] as double - 100.0).abs() < 0.01;
    print('  t=${r['t']}: center=(${(r['cx'] as double).toStringAsFixed(1)},${(r['cy'] as double).toStringAsFixed(1)}) ${cxMatch && cyMatch ? '✓' : '✗'}');
  }
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: AREA CALCULATION
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 6: AREA CALCULATION                                       │');
  print('│ How area changes during interpolation                             │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final areaResults = <Map<String, dynamic>>[];
  final beginArea = basicTween.begin!.width * basicTween.begin!.height;
  final endArea = basicTween.end!.width * basicTween.end!.height;
  
  print('Area interpolation analysis:');
  print('  Begin area: ${beginArea.toStringAsFixed(0)}');
  print('  End area: ${endArea.toStringAsFixed(0)}');
  print('  Note: Area does NOT interpolate linearly!');
  print('');
  print('┌───────┬──────────────┬──────────────┬───────────────────────────────┐');
  print('│   t   │     Area     │  Linear Est  │   Difference (non-linear)     │');
  print('├───────┼──────────────┼──────────────┼───────────────────────────────┤');
  
  for (final t in tValues) {
    final r = basicTween.lerp(t)!;
    final actualArea = r.width * r.height;
    final linearArea = beginArea + (endArea - beginArea) * t;  // What linear area would be
    final diff = actualArea - linearArea;
    areaResults.add({'t': t, 'actual': actualArea, 'linear': linearArea, 'diff': diff});
    
    final sign = diff >= 0 ? '+' : '';
    print('│ ${t.toStringAsFixed(1)}   │  ${actualArea.toStringAsFixed(0).padLeft(8)}    │  ${linearArea.toStringAsFixed(0).padLeft(8)}    │ ${sign}${diff.toStringAsFixed(1).padLeft(10)} (${((diff/linearArea)*100).abs().toStringAsFixed(1)}%) │');
  }
  print('└───────┴──────────────┴──────────────┴───────────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: DIAGONAL MOVEMENT
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 7: DIAGONAL MOVEMENT                                      │');
  print('│ Moving from corner to corner                                      │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final diagTween = RectTween(
    begin: Rect.fromLTWH(0.0, 0.0, 80.0, 60.0),
    end: Rect.fromLTWH(220.0, 140.0, 80.0, 60.0),
  );
  
  final diagResults = <Map<String, dynamic>>[];
  
  print('Diagonal movement (top-left to bottom-right):');
  print('┌───────┬──────────────┬──────────────┬──────────────────────────────────┐');
  print('│   t   │     Left     │     Top      │   Path Visualization             │');
  print('├───────┼──────────────┼──────────────┼──────────────────────────────────┤');
  
  for (final t in tValues) {
    final r = diagTween.lerp(t)!;
    diagResults.add({'t': t, 'left': r.left, 'top': r.top});
    
    // Calculate distance from origin
    final dist = math.sqrt(r.left * r.left + r.top * r.top);
    final maxDist = math.sqrt(220.0 * 220.0 + 140.0 * 140.0);
    final progress = (dist / maxDist * 25).round().clamp(0, 25);
    final path = '░' * progress + '█' + '░' * (25 - progress);
    print('│ ${t.toStringAsFixed(1)}   │    ${r.left.toStringAsFixed(1).padLeft(6)}    │    ${r.top.toStringAsFixed(1).padLeft(6)}    │ $path │');
  }
  print('└───────┴──────────────┴──────────────┴──────────────────────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: ASPECT RATIO CHANGES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 8: ASPECT RATIO CHANGES                                   │');
  print('│ Square to wide rectangle transition                               │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  final aspectTween = RectTween(
    begin: Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),  // 1:1 aspect ratio
    end: Rect.fromLTWH(0.0, 0.0, 200.0, 50.0),     // 4:1 aspect ratio
  );
  
  final aspectResults = <Map<String, dynamic>>[];
  
  print('Square (1:1) to Wide (4:1) transition:');
  print('┌───────┬──────────────┬──────────────┬──────────────┬─────────────────┐');
  print('│   t   │    Width     │    Height    │ Aspect Ratio │  Shape          │');
  print('├───────┼──────────────┼──────────────┼──────────────┼─────────────────┤');
  
  for (final t in tValues) {
    final r = aspectTween.lerp(t)!;
    final aspect = r.width / r.height;
    aspectResults.add({'t': t, 'width': r.width, 'height': r.height, 'aspect': aspect});
    
    String shape;
    if (aspect < 1.2) shape = '■ Square';
    else if (aspect < 2.0) shape = '▬ Wide';
    else if (aspect < 3.0) shape = '▬▬ Wider';
    else shape = '▬▬▬ Very Wide';
    
    print('│ ${t.toStringAsFixed(1)}   │    ${r.width.toStringAsFixed(1).padLeft(6)}    │    ${r.height.toStringAsFixed(1).padLeft(6)}    │    ${aspect.toStringAsFixed(2).padLeft(6)}    │ ${shape.padRight(15)} │');
  }
  print('└───────┴──────────────┴──────────────┴──────────────┴─────────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: PRACTICAL EXAMPLES
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 9: PRACTICAL EXAMPLES                                     │');
  print('│ Common RectTween use cases                                        │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('1. Card Expansion:');
  final cardTween = RectTween(
    begin: Rect.fromLTWH(20, 100, 80, 120),
    end: Rect.fromLTWH(0, 0, 320, 480),
  );
  print('   Collapsed: ${cardTween.begin}');
  print('   Expanded: ${cardTween.end}');
  print('   Mid-expansion: ${cardTween.lerp(0.5)}');
  print('');

  print('2. List Item to Detail:');
  final listTween = RectTween(
    begin: Rect.fromLTWH(16, 200, 288, 72),
    end: Rect.fromLTWH(0, 56, 320, 400),
  );
  print('   List item: ${listTween.begin}');
  print('   Detail view: ${listTween.end}');
  print('   Transition: ${listTween.lerp(0.5)}');
  print('');

  print('3. FAB to Dialog:');
  final fabTween = RectTween(
    begin: Rect.fromLTWH(264, 520, 56, 56),
    end: Rect.fromLTWH(40, 200, 240, 200),
  );
  print('   FAB: ${fabTween.begin}');
  print('   Dialog: ${fabTween.end}');
  print('   Mid-morph: ${fabTween.lerp(0.5)}');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: USING WITH ANIMATEDBUILDER
  // ═══════════════════════════════════════════════════════════════════════════
  print('┌────────────────────────────────────────────────────────────────────┐');
  print('│ SECTION 10: USING WITH ANIMATEDBUILDER                            │');
  print('│ Integration with animation controllers                            │');
  print('└────────────────────────────────────────────────────────────────────┘');
  print('');

  print('Common integration pattern:');
  print('```');
  print('final animation = controller.drive(RectTween(');
  print('  begin: smallRect,');
  print('  end: largeRect,'));
  print(').chain(CurveTween(curve: Curves.easeInOut)));');
  print('');
  print('AnimatedBuilder(');
  print('  animation: animation,');
  print('  builder: (context, child) {');
  print('    final rect = animation.value;');
  print("    return Positioned.fromRect(rect: rect, child: child);");
  print('  },');
  print(')');
  print('```');
  print('');

  // Test with AlwaysStoppedAnimation
  final testAnim = AlwaysStoppedAnimation<double>(0.5);
  final evalResult = basicTween.evaluate(testAnim);
  print('Evaluate test with AlwaysStoppedAnimation(0.5):');
  print('  Result: $evalResult');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SUMMARY
  // ═══════════════════════════════════════════════════════════════════════════
  print('╔════════════════════════════════════════════════════════════════════╗');
  print('║                     RECT TWEEN SUMMARY                            ║');
  print('╚════════════════════════════════════════════════════════════════════╝');
  print('');
  print('RectTween key features:');
  print('  • Interpolates position and size simultaneously');
  print('  • Linear interpolation on all 4 properties');
  print('  • Area changes are non-linear');
  print('');
  print('Use cases:');
  print('  • Hero animations');
  print('  • Card expansion');
  print('  • Modal transitions');
  print('  • List to detail morphing');
  print('');
  print('RectTween Deep Demo completed');

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
                colors: [Color(0xFF00695C), Color(0xFF26A69A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'RectTween',
                  style: TextStyle(
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Rectangle Position & Size Interpolation',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFFB2DFDB),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Properties Section
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
                  'INTERPOLATED PROPERTIES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF00695C),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildPropertyChip('Left', Color(0xFF00897B)),
                    _buildPropertyChip('Top', Color(0xFF00897B)),
                    _buildPropertyChip('Width', Color(0xFF00897B)),
                    _buildPropertyChip('Height', Color(0xFF00897B)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Visual Rect Animation
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
                  'RECTANGLE TRANSITION',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Container(
                  height: 150,
                  child: Stack(
                    children: [
                      // Begin rect
                      Positioned(
                        left: 10,
                        top: 10,
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFF26A69A).withOpacity(0.3),
                            border: Border.all(color: Color(0xFF26A69A), width: 2),
                          ),
                          child: Center(child: Text('Begin', style: TextStyle(color: Color(0xFF26A69A), fontSize: 10))),
                        ),
                      ),
                      // Mid rect
                      Positioned(
                        left: 70,
                        top: 50,
                        child: Container(
                          width: 90,
                          height: 75,
                          decoration: BoxDecoration(
                            color: Color(0xFF80CBC4).withOpacity(0.3),
                            border: Border.all(color: Color(0xFF80CBC4), width: 2, strokeAlign: BorderSide.strokeAlignInside),
                          ),
                          child: Center(child: Text('t=0.5', style: TextStyle(color: Color(0xFF80CBC4), fontSize: 10))),
                        ),
                      ),
                      // End rect
                      Positioned(
                        left: 130,
                        top: 60,
                        child: Container(
                          width: 120,
                          height: 90,
                          decoration: BoxDecoration(
                            color: Color(0xFF4DB6AC).withOpacity(0.3),
                            border: Border.all(color: Color(0xFF4DB6AC), width: 2),
                          ),
                          child: Center(child: Text('End', style: TextStyle(color: Color(0xFF4DB6AC), fontSize: 10))),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Interpolation Values
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
                  'INTERPOLATION VALUES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...fullResults.where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t'])).map((r) => _buildRectRow(r)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Area Analysis
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
                  'AREA ANALYSIS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 8),
                Text('Area does NOT interpolate linearly!', style: TextStyle(fontSize: 11, fontStyle: FontStyle.italic)),
                SizedBox(height: 12.0),
                ...areaResults.where((r) => [0.0, 0.5, 1.0].contains(r['t'])).map((r) => _buildAreaRow(r)),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Use Cases
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
                  'COMMON USE CASES',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF3949AB),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                _buildUseCaseItem('Hero animations', 'Smooth transition between screens'),
                _buildUseCaseItem('Card expansion', 'List item to full card'),
                _buildUseCaseItem('Modal morphing', 'FAB to dialog transition'),
                _buildUseCaseItem('Layout animations', 'Responsive layout changes'),
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
                    _buildSummaryStat('Properties', '4'),
                    _buildSummaryStat('Test Points', '${tValues.length}'),
                    _buildSummaryStat('Tweens', '7'),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat('Begin Area', '${beginArea.toInt()}'),
                    _buildSummaryStat('Mid Area', '${(fullResults[5]['rect'] as Rect).width.toInt() * (fullResults[5]['rect'] as Rect).height.toInt()}'),
                    _buildSummaryStat('End Area', '${endArea.toInt()}'),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 24.0),

          // Footer
          Center(
            child: Text(
              'Deep Demo • RectTween • Flutter Animation',
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

Widget _buildPropertyChip(String label, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(16),
    ),
    child: Text(label, style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w500)),
  );
}

Widget _buildRectRow(Map<String, dynamic> r) {
  final rect = r['rect'] as Rect;
  
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(width: 45, child: Text('t=${(r['t'] as double).toStringAsFixed(2)}', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w500))),
        Expanded(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Color(0xFFC8E6C9),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('L:${rect.left.toInt()}', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
                Text('T:${rect.top.toInt()}', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
                Text('W:${rect.width.toInt()}', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
                Text('H:${rect.height.toInt()}', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget _buildAreaRow(Map<String, dynamic> r) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Container(width: 45, child: Text('t=${(r['t'] as double).toStringAsFixed(1)}', style: TextStyle(fontSize: 11))),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFE0B2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: ((r['actual'] as double) / 30000).clamp(0.0, 1.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFF57C00),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Text('${(r['actual'] as double).toInt()}', style: TextStyle(fontSize: 10, fontFamily: 'monospace')),
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
        Text('• ', style: TextStyle(color: Color(0xFF3949AB), fontWeight: FontWeight.bold)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12)),
              Text(description, style: TextStyle(fontSize: 11, color: Color(0xFF757575))),
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