// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for CurveTween from animation
// CurveTween applies a curve transformation to animation values
// Converts linear 0-1 input to curved output using specified Curve
import 'dart:math' as math;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print(
    '╔════════════════════════════════════════════════════════════════════╗',
  );
  print(
    '║                   CURVETWEEN DEEP DEMO                            ║',
  );
  print(
    '║       Applying Curve Transformations to Animations                ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CURVETWEEN FUNDAMENTALS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 1: CURVETWEEN FUNDAMENTALS                                │',
  );
  print(
    '│ Understanding curve-based animation transformation                │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('CurveTween wraps a Curve to create an Animatable<double>:');
  print('  • Maps input t ∈ [0,1] through a Curve');
  print('  • Output range is determined by the curve (typically 0-1)');
  print('  • Can be chained with other tweens for complex effects');
  print('  • Essential for non-linear animation timing');
  print('');

  // Create basic CurveTweens
  final linearTween = CurveTween(curve: Curves.linear);
  final easeInTween = CurveTween(curve: Curves.easeIn);
  final easeOutTween = CurveTween(curve: Curves.easeOut);
  final easeInOutTween = CurveTween(curve: Curves.easeInOut);

  print('✓ Created CurveTweens with standard curves');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: TRANSFORM METHOD - Core Value Mapping
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 2: TRANSFORM METHOD                                       │',
  );
  print(
    '│ Mapping input values through curves                               │',
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
  final transformResults = <Map<String, dynamic>>[];

  print('Transform comparison across curves:');
  print('┌─────────┬─────────────┬─────────────┬─────────────┬─────────────┐');
  print('│    t    │   Linear    │   EaseIn    │   EaseOut   │  EaseInOut  │');
  print('├─────────┼─────────────┼─────────────┼─────────────┼─────────────┤');

  for (final t in tValues) {
    final linear = linearTween.transform(t);
    final easeIn = easeInTween.transform(t);
    final easeOut = easeOutTween.transform(t);
    final easeInOut = easeInOutTween.transform(t);
    transformResults.add({
      't': t,
      'linear': linear,
      'easeIn': easeIn,
      'easeOut': easeOut,
      'easeInOut': easeInOut,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │   ${linear.toStringAsFixed(4).padLeft(7)}   │   ${easeIn.toStringAsFixed(4).padLeft(7)}   │   ${easeOut.toStringAsFixed(4).padLeft(7)}   │   ${easeInOut.toStringAsFixed(4).padLeft(7)}   │',
    );
  }
  print('└─────────┴─────────────┴─────────────┴─────────────┴─────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: CURVE COMPARISON - Visual Characteristics
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 3: CURVE COMPARISON                                       │',
  );
  print(
    '│ Understanding different curve behaviors                           │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Compare at key points
  print('Curve behavior at t=0.25 (early phase):');
  print(
    '  • Linear:    ${linearTween.transform(0.25).toStringAsFixed(4)} (25% progress)',
  );
  print(
    '  • EaseIn:    ${easeInTween.transform(0.25).toStringAsFixed(4)} (slow start)',
  );
  print(
    '  • EaseOut:   ${easeOutTween.transform(0.25).toStringAsFixed(4)} (fast start)',
  );
  print(
    '  • EaseInOut: ${easeInOutTween.transform(0.25).toStringAsFixed(4)} (slow start)',
  );
  print('');

  print('Curve behavior at t=0.75 (late phase):');
  print(
    '  • Linear:    ${linearTween.transform(0.75).toStringAsFixed(4)} (75% progress)',
  );
  print(
    '  • EaseIn:    ${easeInTween.transform(0.75).toStringAsFixed(4)} (accelerating)',
  );
  print(
    '  • EaseOut:   ${easeOutTween.transform(0.75).toStringAsFixed(4)} (decelerating)',
  );
  print(
    '  • EaseInOut: ${easeInOutTween.transform(0.75).toStringAsFixed(4)} (decelerating)',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: EXTENDED CURVE SET - More Timing Options
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 4: EXTENDED CURVE SET                                     │',
  );
  print(
    '│ Additional Curves for animation timing                            │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final extendedCurves = <String, CurveTween>{
    'decelerate': CurveTween(curve: Curves.decelerate),
    'fastOutSlowIn': CurveTween(curve: Curves.fastOutSlowIn),
    'slowMiddle': CurveTween(curve: Curves.slowMiddle),
    'bounceIn': CurveTween(curve: Curves.bounceIn),
    'bounceOut': CurveTween(curve: Curves.bounceOut),
    'elasticIn': CurveTween(curve: Curves.elasticIn),
    'elasticOut': CurveTween(curve: Curves.elasticOut),
  };

  final extendedResults = <Map<String, dynamic>>[];

  print('Extended curves at t=0.5:');
  print(
    '┌─────────────────────┬──────────────────┬────────────────────────────┐',
  );
  print(
    '│       Curve         │   Value at 0.5   │   Behavior                 │',
  );
  print(
    '├─────────────────────┼──────────────────┼────────────────────────────┤',
  );

  for (final entry in extendedCurves.entries) {
    final value = entry.value.transform(0.5);
    String behavior;
    if (value < 0.4) {
      behavior = 'Slow mid-phase';
    } else if (value > 0.6)
      behavior = 'Fast mid-phase';
    else if (value < 0)
      behavior = 'Overshoot negative';
    else if (value > 1)
      behavior = 'Overshoot positive';
    else
      behavior = 'Balanced';

    extendedResults.add({
      'name': entry.key,
      'value': value,
      'behavior': behavior,
    });
    print(
      '│ ${entry.key.padRight(19)} │ ${value.toStringAsFixed(6).padLeft(16)} │ ${behavior.padRight(26)} │',
    );
  }
  print(
    '└─────────────────────┴──────────────────┴────────────────────────────┘',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: EVALUATE METHOD - Animation Integration
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 5: EVALUATE METHOD                                        │',
  );
  print(
    '│ Using CurveTween with Animation objects                           │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  print('evaluate() method accepts an Animation<double>:');
  print('');

  final evaluateResults = <Map<String, dynamic>>[];
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final animation = AlwaysStoppedAnimation<double>(t);
    final linear = linearTween.evaluate(animation);
    final easeIn = easeInTween.evaluate(animation);
    final easeOut = easeOutTween.evaluate(animation);
    evaluateResults.add({
      't': t,
      'linear': linear,
      'easeIn': easeIn,
      'easeOut': easeOut,
    });
    print('  Animation(${t.toStringAsFixed(2)}):');
    print('    linear.evaluate()  = ${linear.toStringAsFixed(4)}');
    print('    easeIn.evaluate()  = ${easeIn.toStringAsFixed(4)}');
    print('    easeOut.evaluate() = ${easeOut.toStringAsFixed(4)}');
    print('');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: CHAINING TWEENS - Composing Animations
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 6: CHAINING TWEENS                                        │',
  );
  print(
    '│ Combining CurveTween with value Tweens                            │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Chain with value tween
  final valueTween = Tween<double>(begin: 0.0, end: 100.0);
  final chainedLinear = valueTween.chain(linearTween);
  final chainedEaseIn = valueTween.chain(easeInTween);
  final chainedEaseOut = valueTween.chain(easeOutTween);

  final chainResults = <Map<String, dynamic>>[];

  print('Tween(0→100) chained with curves:');
  print('┌─────────┬─────────────────┬─────────────────┬─────────────────┐');
  print('│    t    │   Linear(100)   │   EaseIn(100)   │  EaseOut(100)   │');
  print('├─────────┼─────────────────┼─────────────────┼─────────────────┤');

  for (final t in tValues) {
    final linear = chainedLinear.transform(t);
    final easeIn = chainedEaseIn.transform(t);
    final easeOut = chainedEaseOut.transform(t);
    chainResults.add({
      't': t,
      'linear': linear,
      'easeIn': easeIn,
      'easeOut': easeOut,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │    ${linear.toStringAsFixed(2).padLeft(10)}     │    ${easeIn.toStringAsFixed(2).padLeft(10)}     │    ${easeOut.toStringAsFixed(2).padLeft(10)}     │',
    );
  }
  print('└─────────┴─────────────────┴─────────────────┴─────────────────┘');
  print('');

  // Chain for color animation (using double range)
  final opacityTween = Tween<double>(begin: 0.0, end: 1.0);
  final fadeInTween = opacityTween.chain(easeInTween);
  final fadeOutTween = opacityTween.chain(easeOutTween);

  print('Opacity fade with curves:');
  print(
    '  fadeIn at t=0.5:  ${fadeInTween.transform(0.5).toStringAsFixed(4)} opacity',
  );
  print(
    '  fadeOut at t=0.5: ${fadeOutTween.transform(0.5).toStringAsFixed(4)} opacity',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: POSITION ANIMATION - Practical Example
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 7: POSITION ANIMATION                                     │',
  );
  print(
    '│ Real-world use case with position tweens                          │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Simulate position animation
  final positionTween = Tween<double>(begin: 0.0, end: 300.0);
  final slideInTween = positionTween.chain(easeOutTween);
  final slideOutTween = positionTween.chain(easeInTween);

  final positionResults = <Map<String, dynamic>>[];

  print('Position animation (0→300 pixels):');
  print('┌────────────┬──────────────────┬──────────────────┬───────────────┐');
  print('│   Time %   │   SlideIn (px)   │  SlideOut (px)   │    Delta      │');
  print('├────────────┼──────────────────┼──────────────────┼───────────────┤');

  for (final t in tValues) {
    final slideIn = slideInTween.transform(t);
    final slideOut = slideOutTween.transform(t);
    final delta = (slideIn - slideOut).abs();
    positionResults.add({
      't': t,
      'slideIn': slideIn,
      'slideOut': slideOut,
      'delta': delta,
    });
    print(
      '│  ${(t * 100).toStringAsFixed(0).padLeft(6)}%   │   ${slideIn.toStringAsFixed(2).padLeft(13)}   │   ${slideOut.toStringAsFixed(2).padLeft(13)}   │  ${delta.toStringAsFixed(2).padLeft(10)}   │',
    );
  }
  print('└────────────┴──────────────────┴──────────────────┴───────────────┘');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 8: BOUNCE AND ELASTIC CURVES - Special Effects
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 8: BOUNCE AND ELASTIC CURVES                              │',
  );
  print(
    '│ Curves with overshoot and oscillation                             │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  final bounceOutTween = CurveTween(curve: Curves.bounceOut);
  final bounceInTween = CurveTween(curve: Curves.bounceIn);
  final elasticOutTween = CurveTween(curve: Curves.elasticOut);
  final elasticInTween = CurveTween(curve: Curves.elasticIn);

  final bounceResults = <Map<String, dynamic>>[];

  print('Bounce and Elastic curves:');
  print('┌─────────┬─────────────┬─────────────┬─────────────┬─────────────┐');
  print('│    t    │  BounceOut  │  BounceIn   │ ElasticOut  │  ElasticIn  │');
  print('├─────────┼─────────────┼─────────────┼─────────────┼─────────────┤');

  for (final t in tValues) {
    final bo = bounceOutTween.transform(t);
    final bi = bounceInTween.transform(t);
    final eo = elasticOutTween.transform(t);
    final ei = elasticInTween.transform(t);
    bounceResults.add({
      't': t,
      'bounceOut': bo,
      'bounceIn': bi,
      'elasticOut': eo,
      'elasticIn': ei,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │  ${bo.toStringAsFixed(4).padLeft(9)}  │  ${bi.toStringAsFixed(4).padLeft(9)}  │  ${eo.toStringAsFixed(4).padLeft(9)}  │  ${ei.toStringAsFixed(4).padLeft(9)}  │',
    );
  }
  print('└─────────┴─────────────┴─────────────┴─────────────┴─────────────┘');
  print('');

  print('Note: Elastic curves can produce values outside [0,1]');
  final maxElastic = [
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
  ].map((t) => elasticOutTween.transform(t)).reduce(math.max);
  final minElastic = [
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
  ].map((t) => elasticOutTween.transform(t)).reduce(math.min);
  print(
    '  ElasticOut range: [${minElastic.toStringAsFixed(4)}, ${maxElastic.toStringAsFixed(4)}]',
  );
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 9: CURVE VELOCITY ANALYSIS
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 9: CURVE VELOCITY ANALYSIS                                │',
  );
  print(
    '│ Understanding animation speed at different points                 │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Calculate approximate velocities
  double calculateVelocity(CurveTween tween, double t, double dt) {
    final low = t - dt / 2;
    final high = t + dt / 2;
    return (tween.transform(high.clamp(0.0, 1.0)) -
            tween.transform(low.clamp(0.0, 1.0))) /
        dt;
  }

  final velocityResults = <Map<String, dynamic>>[];

  print('Approximate velocity (dy/dt) at key points:');
  print('┌─────────┬─────────────┬─────────────┬─────────────┬─────────────┐');
  print('│    t    │   Linear    │   EaseIn    │   EaseOut   │  EaseInOut  │');
  print('├─────────┼─────────────┼─────────────┼─────────────┼─────────────┤');

  for (final t in [0.1, 0.25, 0.5, 0.75, 0.9]) {
    final vLinear = calculateVelocity(linearTween, t, 0.01);
    final vEaseIn = calculateVelocity(easeInTween, t, 0.01);
    final vEaseOut = calculateVelocity(easeOutTween, t, 0.01);
    final vEaseInOut = calculateVelocity(easeInOutTween, t, 0.01);
    velocityResults.add({
      't': t,
      'linear': vLinear,
      'easeIn': vEaseIn,
      'easeOut': vEaseOut,
      'easeInOut': vEaseInOut,
    });
    print(
      '│  ${t.toStringAsFixed(2)}   │   ${vLinear.toStringAsFixed(4).padLeft(7)}   │   ${vEaseIn.toStringAsFixed(4).padLeft(7)}   │   ${vEaseOut.toStringAsFixed(4).padLeft(7)}   │   ${vEaseInOut.toStringAsFixed(4).padLeft(7)}   │',
    );
  }
  print('└─────────┴─────────────┴─────────────┴─────────────┴─────────────┘');
  print('');
  print('Velocity interpretation:');
  print('  • Linear: Constant velocity = 1.0');
  print('  • EaseIn: Low→High (accelerating)');
  print('  • EaseOut: High→Low (decelerating)');
  print('  • EaseInOut: Low→High→Low (S-curve)');
  print('');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 10: CUSTOM CURVE INTEGRATION
  // ═══════════════════════════════════════════════════════════════════════════
  print(
    '┌────────────────────────────────────────────────────────────────────┐',
  );
  print(
    '│ SECTION 10: ADVANCED CURVE OPTIONS                                │',
  );
  print(
    '│ Cubic and interval-based curves                                   │',
  );
  print(
    '└────────────────────────────────────────────────────────────────────┘',
  );
  print('');

  // Cubic curve
  final cubicTween = CurveTween(curve: Cubic(0.25, 0.1, 0.25, 1.0));
  print('Cubic(0.25, 0.1, 0.25, 1.0) - CSS ease equivalent:');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print(
      '  t=${t.toStringAsFixed(2)}: ${cubicTween.transform(t).toStringAsFixed(4)}',
    );
  }
  print('');

  // Interval usage
  final intervalTween = CurveTween(
    curve: Interval(0.0, 0.5, curve: Curves.easeOut),
  );
  print('Interval(0.0, 0.5, curve: easeOut) - First half only:');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print(
      '  t=${t.toStringAsFixed(2)}: ${intervalTween.transform(t).toStringAsFixed(4)}',
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
    '║                   CURVETWEEN SUMMARY                              ║',
  );
  print(
    '╚════════════════════════════════════════════════════════════════════╝',
  );
  print('');
  print('CurveTween key features:');
  print('  • transform(t): Apply curve to input value');
  print('  • evaluate(animation): Use with Animation objects');
  print('  • chain(): Combine with value Tweens');
  print('');
  print('Common use cases:');
  print('  • Non-linear animation timing');
  print('  • Easing effects (ease-in, ease-out)');
  print('  • Bounce and elastic animations');
  print('  • Combined with position/opacity/scale tweens');
  print('');
  print('CurveTween Deep Demo completed');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY - Comprehensive UI Layout
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
                colors: [Color(0xFFAD1457), Color(0xFFD81B60)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
            ),
            padding: EdgeInsets.all(24.0),
            child: Column(
              children: [
                Text(
                  'CurveTween',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFFFFF),
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Curve-Based Animation Transformation',
                  style: TextStyle(fontSize: 16.0, color: Color(0xFFF8BBD9)),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Transform Visualization Section
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
                  'CURVE TRANSFORM COMPARISON',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFC2185B),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...transformResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map(
                      (r) => _buildCurveComparisonRow(
                        't=${(r['t'] as double).toStringAsFixed(2)}',
                        r['linear'] as double,
                        r['easeIn'] as double,
                        r['easeOut'] as double,
                        r['easeInOut'] as double,
                      ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Visual Curve Bars
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
                  'VISUAL CURVE PROGRESSION',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF424242),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 16.0),
                _buildCurveProgressBar(
                  'Linear',
                  linearTween,
                  Color(0xFF9E9E9E),
                ),
                SizedBox(height: 8.0),
                _buildCurveProgressBar(
                  'EaseIn',
                  easeInTween,
                  Color(0xFFE91E63),
                ),
                SizedBox(height: 8.0),
                _buildCurveProgressBar(
                  'EaseOut',
                  easeOutTween,
                  Color(0xFF2196F3),
                ),
                SizedBox(height: 8.0),
                _buildCurveProgressBar(
                  'EaseInOut',
                  easeInOutTween,
                  Color(0xFF4CAF50),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Chained Results Section
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
                  'CHAINED TWEEN VALUES (0→100)',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...chainResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map(
                      (r) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                't=${(r['t'] as double).toStringAsFixed(2)}',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            _buildValueChip(
                              (r['linear'] as double).toStringAsFixed(1),
                              Color(0xFF9E9E9E),
                            ),
                            SizedBox(width: 8),
                            _buildValueChip(
                              (r['easeIn'] as double).toStringAsFixed(1),
                              Color(0xFFE91E63),
                            ),
                            SizedBox(width: 8),
                            _buildValueChip(
                              (r['easeOut'] as double).toStringAsFixed(1),
                              Color(0xFF2196F3),
                            ),
                          ],
                        ),
                      ),
                    ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Bounce/Elastic Results
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
                  'BOUNCE & ELASTIC EFFECTS',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF57C00),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...bounceResults
                    .where((r) => [0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map(
                      (r) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              child: Text(
                                't=${(r['t'] as double).toStringAsFixed(2)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Bounce: ${(r['bounceOut'] as double).toStringAsFixed(3)}',
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Elastic: ${(r['elasticOut'] as double).toStringAsFixed(3)}',
                                style: TextStyle(fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                SizedBox(height: 8.0),
                Row(
                  children: [
                    Icon(
                      Icons.warning_amber,
                      size: 16,
                      color: Color(0xFFFF9800),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Elastic curves may exceed [0,1] range',
                        style: TextStyle(
                          fontSize: 11,
                          color: Color(0xFF795548),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Velocity Analysis Section
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
                  'ANIMATION VELOCITY (dy/dt)',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...velocityResults.map(
                  (r) => Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 50,
                          child: Text(
                            't=${(r['t'] as double).toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        _buildVelocityIndicator(
                          r['easeIn'] as double,
                          'In',
                          Color(0xFFE91E63),
                        ),
                        SizedBox(width: 4),
                        _buildVelocityIndicator(
                          r['easeOut'] as double,
                          'Out',
                          Color(0xFF2196F3),
                        ),
                        SizedBox(width: 4),
                        _buildVelocityIndicator(
                          r['easeInOut'] as double,
                          'IO',
                          Color(0xFF4CAF50),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Extended Curves Grid
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
                  'EXTENDED CURVE SET AT t=0.5',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF7B1FA2),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: extendedResults
                      .map(
                        (r) => Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xFFFFFFFF),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(color: Color(0xFFCE93D8)),
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                r['name'] as String,
                                style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                (r['value'] as double).toStringAsFixed(4),
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Position Animation Example
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
                  'POSITION ANIMATION (0→300px)',
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF455A64),
                    letterSpacing: 1.2,
                  ),
                ),
                SizedBox(height: 12.0),
                ...positionResults
                    .where((r) => [0.0, 0.25, 0.5, 0.75, 1.0].contains(r['t']))
                    .map(
                      (r) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 50,
                              child: Text(
                                '${((r['t'] as double) * 100).toInt()}%',
                                style: TextStyle(fontWeight: FontWeight.w500),
                              ),
                            ),
                            Expanded(
                              child: Stack(
                                children: [
                                  Container(
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFCFD8DC),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                  ),
                                  Positioned(
                                    left: (r['slideIn'] as double) / 300 * 250,
                                    child: Container(
                                      width: 8,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Color(0xFF2196F3),
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: (r['slideOut'] as double) / 300 * 250,
                                    child: Container(
                                      width: 8,
                                      height: 20,
                                      decoration: BoxDecoration(
                                        color: Color(0xFFE91E63),
                                        borderRadius: BorderRadius.circular(2),
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
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(width: 12, height: 12, color: Color(0xFF2196F3)),
                    SizedBox(width: 4),
                    Text('EaseOut', style: TextStyle(fontSize: 10)),
                    SizedBox(width: 16),
                    Container(width: 12, height: 12, color: Color(0xFFE91E63)),
                    SizedBox(width: 4),
                    Text('EaseIn', style: TextStyle(fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Key Concepts
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF512DA8), Color(0xFF7B1FA2)],
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
                _buildConceptRow('transform()', 'Apply curve to t value'),
                _buildConceptRow('evaluate()', 'Use with Animation objects'),
                _buildConceptRow('chain()', 'Combine with Tween<T>'),
                _buildConceptRow('Curves.*', 'Predefined curve constants'),
              ],
            ),
          ),
          SizedBox(height: 16.0),

          // Summary Statistics
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
                    _buildSummaryStat('Standard Curves', '4'),
                    _buildSummaryStat(
                      'Extended Curves',
                      '${extendedCurves.length}',
                    ),
                    _buildSummaryStat('Test Points', '${tValues.length}'),
                  ],
                ),
                SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat('Chain Examples', '3'),
                    _buildSummaryStat(
                      'Velocity Points',
                      '${velocityResults.length}',
                    ),
                    _buildSummaryStat(
                      'Position Tests',
                      '${positionResults.length}',
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
              'Deep Demo • CurveTween • Flutter Animation',
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

Widget _buildCurveComparisonRow(
  String label,
  double linear,
  double easeIn,
  double easeOut,
  double easeInOut,
) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        SizedBox(
          width: 60,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 12),
          ),
        ),
        Expanded(child: _buildMiniBar(linear, Color(0xFF9E9E9E))),
        SizedBox(width: 4),
        Expanded(child: _buildMiniBar(easeIn, Color(0xFFE91E63))),
        SizedBox(width: 4),
        Expanded(child: _buildMiniBar(easeOut, Color(0xFF2196F3))),
        SizedBox(width: 4),
        Expanded(child: _buildMiniBar(easeInOut, Color(0xFF4CAF50))),
      ],
    ),
  );
}

Widget _buildMiniBar(double value, Color color) {
  return Container(
    height: 16,
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.2),
      borderRadius: BorderRadius.circular(3),
    ),
    child: FractionallySizedBox(
      alignment: Alignment.centerLeft,
      widthFactor: value.clamp(0.0, 1.0),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(3),
        ),
      ),
    ),
  );
}

Widget _buildCurveProgressBar(String name, CurveTween tween, Color color) {
  return Row(
    children: [
      SizedBox(
        width: 70,
        child: Text(
          name,
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ),
      Expanded(
        child: SizedBox(
          height: 24,
          child: Row(
            children: List.generate(20, (i) {
              final t = i / 19;
              final value = tween.transform(t);
              return Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 1),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2 + value * 0.8),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              );
            }),
          ),
        ),
      ),
    ],
  );
}

Widget _buildValueChip(String value, Color color) {
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: color.withValues(alpha: 0.5)),
    ),
    child: Text(
      value,
      style: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.bold,
        color: color,
        fontFamily: 'monospace',
      ),
    ),
  );
}

Widget _buildVelocityIndicator(double velocity, String label, Color color) {
  final normalizedVelocity = (velocity / 2.0).clamp(0.0, 1.0);
  return Expanded(
    child: Row(
      children: [
        Text(label, style: TextStyle(fontSize: 9, color: color)),
        SizedBox(width: 2),
        Expanded(
          child: Container(
            height: 10,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: normalizedVelocity,
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

Widget _buildConceptRow(String title, String description) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4.0),
    child: Row(
      children: [
        Text(
          '• ',
          style: TextStyle(
            color: Color(0xFFB39DDB),
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          title,
          style: TextStyle(
            color: Color(0xFFD1C4E9),
            fontWeight: FontWeight.bold,
            fontFamily: 'monospace',
            fontSize: 12,
          ),
        ),
        Text(' - ', style: TextStyle(color: Color(0xFFB39DDB))),
        Expanded(
          child: Text(
            description,
            style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 12),
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
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Color(0xFF4DD0E1),
        ),
      ),
      Text(label, style: TextStyle(fontSize: 10.0, color: Color(0xFF90A4AE))),
    ],
  );
}
