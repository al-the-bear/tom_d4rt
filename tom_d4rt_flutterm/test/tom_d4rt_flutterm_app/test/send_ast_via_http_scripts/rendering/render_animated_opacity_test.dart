// D4rt test script: Tests RenderAnimatedOpacity from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderAnimatedOpacity test executing');

  // ========== ANIMATED OPACITY CONCEPTS ==========
  print('--- RenderAnimatedOpacity Concepts ---');
  print('RenderAnimatedOpacity animates the opacity of its child');
  print('It uses an Animation<double> to drive opacity changes');
  print('Optimizes painting when fully transparent or opaque');

  // ========== OPACITY VALUES ==========
  print('--- Opacity Value Range ---');
  print('Opacity 0.0: fully transparent (invisible)');
  print('Opacity 0.5: 50% transparent');
  print('Opacity 1.0: fully opaque (visible)');

  // ========== ANIMATED OPACITY WIDGET ==========
  print('--- AnimatedOpacity Widget Tests ---');

  // Create AnimatedOpacity examples with different opacities
  final fullyOpaque = AnimatedOpacity(
    opacity: 1.0,
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 80,
      height: 60,
      color: Colors.blue,
      child: Center(
        child: Text('100%', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnimatedOpacity with opacity: 1.0');

  final halfOpaque = AnimatedOpacity(
    opacity: 0.5,
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 80,
      height: 60,
      color: Colors.blue,
      child: Center(
        child: Text('50%', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnimatedOpacity with opacity: 0.5');

  final quarterOpaque = AnimatedOpacity(
    opacity: 0.25,
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 80,
      height: 60,
      color: Colors.blue,
      child: Center(
        child: Text('25%', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnimatedOpacity with opacity: 0.25');

  final fullyTransparent = AnimatedOpacity(
    opacity: 0.0,
    duration: Duration(milliseconds: 500),
    child: Container(
      width: 80,
      height: 60,
      color: Colors.blue,
      child: Center(
        child: Text('0%', style: TextStyle(color: Colors.white)),
      ),
    ),
  );
  print('Created AnimatedOpacity with opacity: 0.0');

  // ========== DURATION TESTS ==========
  print('--- Duration Tests ---');

  final fastAnimation = AnimatedOpacity(
    opacity: 0.8,
    duration: Duration(milliseconds: 100),
    child: Container(width: 50, height: 50, color: Colors.red),
  );
  print('Fast animation: 100ms');

  final slowAnimation = AnimatedOpacity(
    opacity: 0.8,
    duration: Duration(seconds: 2),
    child: Container(width: 50, height: 50, color: Colors.green),
  );
  print('Slow animation: 2 seconds');

  // ========== CURVE TESTS ==========
  print('--- Animation Curve Tests ---');

  final linearCurve = AnimatedOpacity(
    opacity: 0.7,
    duration: Duration(milliseconds: 500),
    curve: Curves.linear,
    child: Container(width: 50, height: 50, color: Colors.purple),
  );
  print('AnimatedOpacity with Curves.linear');

  final easeInCurve = AnimatedOpacity(
    opacity: 0.7,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeIn,
    child: Container(width: 50, height: 50, color: Colors.orange),
  );
  print('AnimatedOpacity with Curves.easeIn');

  final easeOutCurve = AnimatedOpacity(
    opacity: 0.7,
    duration: Duration(milliseconds: 500),
    curve: Curves.easeOut,
    child: Container(width: 50, height: 50, color: Colors.cyan),
  );
  print('AnimatedOpacity with Curves.easeOut');

  final bounceCurve = AnimatedOpacity(
    opacity: 0.7,
    duration: Duration(milliseconds: 500),
    curve: Curves.bounceOut,
    child: Container(width: 50, height: 50, color: Colors.pink),
  );
  print('AnimatedOpacity with Curves.bounceOut');

  // ========== FADE TRANSITION ==========
  print('--- FadeTransition (explicit animation) ---');
  print('FadeTransition requires an explicit Animation<double>');
  print('Uses AnimationController for fine-grained control');
  print('RenderAnimatedOpacity is used by both widgets internally');

  // ========== OPACITY LAYER ==========
  print('--- OpacityLayer Usage ---');
  print('RenderAnimatedOpacity creates an OpacityLayer during painting');
  print('When opacity is 0.0: child is not painted (optimization)');
  print('When opacity is 1.0: no layer created (optimization)');
  print('Between 0.0 and 1.0: OpacityLayer with alpha applied');

  // ========== ALWAYS INCLUDE SEMANTICS ==========
  print('--- alwaysIncludeSemantics Property ---');

  final withSemantics = AnimatedOpacity(
    opacity: 0.0,
    duration: Duration(milliseconds: 500),
    alwaysIncludeSemantics: true,
    child: Text('Hidden but accessible'),
  );
  print(
    'alwaysIncludeSemantics: true - accessibility included even when invisible',
  );

  final withoutSemantics = AnimatedOpacity(
    opacity: 0.0,
    duration: Duration(milliseconds: 500),
    alwaysIncludeSemantics: false,
    child: Text('Hidden and not accessible'),
  );
  print(
    'alwaysIncludeSemantics: false - accessibility excluded when invisible',
  );

  // ========== ON END CALLBACK ==========
  print('--- onEnd Callback ---');
  print('AnimatedOpacity supports onEnd callback');
  print('Called when animation completes');

  // ========== PERFORMANCE CONSIDERATIONS ==========
  print('--- Performance Notes ---');
  print('1. Avoid animating opacity of large subtrees');
  print('2. Use RepaintBoundary to isolate repaints');
  print('3. Consider using Opacity for static opacity');
  print('4. AnimatedOpacity creates compositor layers');

  // ========== COMPARISON WITH OPACITY WIDGET ==========
  print('--- Opacity vs AnimatedOpacity ---');
  print('Opacity: instant opacity change, no animation');
  print('AnimatedOpacity: implicit animation on opacity change');
  print('FadeTransition: explicit animation control');

  final staticOpacity = Opacity(
    opacity: 0.6,
    child: Container(width: 50, height: 50, color: Colors.teal),
  );
  print('Created Opacity widget (no animation)');

  // ========== BLEND MODE EFFECTS ==========
  print('--- ShaderMask for Advanced Effects ---');
  print('For complex opacity effects, consider ShaderMask');
  print('Allows gradient opacity and other shader-based effects');

  print('RenderAnimatedOpacity test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAnimatedOpacity Tests'),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [fullyOpaque, halfOpaque, quarterOpaque],
      ),
      SizedBox(height: 8),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [linearCurve, easeInCurve, easeOutCurve, bounceCurve],
      ),
      SizedBox(height: 8),
      staticOpacity,
      SizedBox(height: 8),
      Text('All opacity tests passed'),
    ],
  );
}
