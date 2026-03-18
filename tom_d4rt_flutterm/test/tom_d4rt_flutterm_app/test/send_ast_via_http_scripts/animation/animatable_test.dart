// D4rt test script: Tests Animatable concepts using Tween, chain(), evaluate() from animation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Animatable test executing');

  // ========== TWEEN AS ANIMATABLE ==========
  print('--- Tween as Animatable ---');

  // Tween extends Animatable, so we can use Animatable methods
  final tween = Tween<double>(begin: 0.0, end: 100.0);
  print('Tween<double>(0 -> 100):');

  // evaluate() takes an Animation<double> and returns the interpolated value
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final anim = AlwaysStoppedAnimation<double>(t);
    final result = tween.evaluate(anim);
    print('  evaluate($t): ${result.toStringAsFixed(2)}');
  }

  // transform() takes a double directly
  print('Using transform():');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${tween.transform(t).toStringAsFixed(2)}');
  }

  // ========== CHAIN WITH CURVETWEEN ==========
  print('--- chain() with CurveTween ---');

  // CurveTween applies a curve transformation
  final curveTween = CurveTween(curve: Curves.easeInOut);
  print('CurveTween(easeInOut):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${curveTween.transform(t).toStringAsFixed(4)}');
  }

  // Chain Tween with CurveTween: first applies curve, then tween
  final chained = tween.chain(CurveTween(curve: Curves.easeInOut));
  print('Tween(0->100).chain(CurveTween(easeInOut)):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${chained.transform(t).toStringAsFixed(2)}');
  }

  // Chain with easeIn
  final chainedEaseIn = tween.chain(CurveTween(curve: Curves.easeIn));
  print('Tween(0->100).chain(CurveTween(easeIn)):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${chainedEaseIn.transform(t).toStringAsFixed(2)}');
  }

  // Chain with easeOut
  final chainedEaseOut = tween.chain(CurveTween(curve: Curves.easeOut));
  print('Tween(0->100).chain(CurveTween(easeOut)):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${chainedEaseOut.transform(t).toStringAsFixed(2)}');
  }

  // Chain with bounceOut
  final chainedBounce = tween.chain(CurveTween(curve: Curves.bounceOut));
  print('Tween(0->100).chain(CurveTween(bounceOut)):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${chainedBounce.transform(t).toStringAsFixed(2)}');
  }

  // ========== MULTIPLE CHAINS ==========
  print('--- Multiple chain() calls ---');

  // chain() can be called multiple times
  final doubleChained = Tween<double>(begin: 0.0, end: 200.0)
      .chain(CurveTween(curve: Curves.easeIn))
      .chain(CurveTween(curve: Curves.easeOut));
  print('Tween(0->200).chain(easeIn).chain(easeOut):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  transform($t): ${doubleChained.transform(t).toStringAsFixed(2)}');
  }

  // ========== CURVETWEEN STANDALONE ==========
  print('--- CurveTween standalone ---');

  final curves = [
    ('linear', Curves.linear),
    ('easeIn', Curves.easeIn),
    ('easeOut', Curves.easeOut),
    ('easeInOut', Curves.easeInOut),
    ('decelerate', Curves.decelerate),
    ('fastOutSlowIn', Curves.fastOutSlowIn),
  ];

  for (final entry in curves) {
    final name = entry.$1;
    final curve = entry.$2;
    final ct = CurveTween(curve: curve);
    final values = [
      0.0,
      0.25,
      0.5,
      0.75,
      1.0,
    ].map((t) => ct.transform(t).toStringAsFixed(3)).join(', ');
    print('CurveTween($name): [$values]');
  }

  // ========== EVALUATE WITH ANIMATION ==========
  print('--- evaluate() with Animation ---');

  // evaluate uses an Animation<double> as input
  final evalTween = Tween<double>(begin: -50.0, end: 50.0);
  final chainedEval = evalTween.chain(CurveTween(curve: Curves.easeInOut));

  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final anim = AlwaysStoppedAnimation<double>(t);
    final result = chainedEval.evaluate(anim);
    print('  chained.evaluate($t): ${result.toStringAsFixed(2)}');
  }

  // ========== COLORTWEEN CHAIN ==========
  print('--- ColorTween chain() ---');

  final colorTween = ColorTween(
    begin: Color(0xFFFF0000),
    end: Color(0xFF0000FF),
  );
  final colorChained = colorTween.chain(CurveTween(curve: Curves.easeInOut));
  print('ColorTween(red->blue).chain(easeInOut):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final anim = AlwaysStoppedAnimation<double>(t);
    print('  evaluate($t): ${colorChained.evaluate(anim)}');
  }

  // ========== INTTWEEN CHAIN ==========
  print('--- IntTween chain() ---');

  final intTween = IntTween(begin: 0, end: 255);
  final intChained = intTween.chain(CurveTween(curve: Curves.easeIn));
  print('IntTween(0->255).chain(easeIn):');
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    final anim = AlwaysStoppedAnimation<double>(t);
    print('  evaluate($t): ${intChained.evaluate(anim)}');
  }

  // ========== WIDGET TREE ==========
  return Container(
    padding: EdgeInsets.all(16.0),
    child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Animatable Test Results',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1565C0),
            ),
          ),
          SizedBox(height: 16.0),

          // Visualize linear vs curved tween
          Text(
            'Linear Tween (0 → 100):',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _tweenBarChart(tween, Color(0xFF2196F3)),
          SizedBox(height: 12.0),

          Text(
            'Chained with easeInOut:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _tweenBarChart(chained, Color(0xFF4CAF50)),
          SizedBox(height: 12.0),

          Text(
            'Chained with easeIn:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _tweenBarChart(chainedEaseIn, Color(0xFFFF9800)),
          SizedBox(height: 12.0),

          Text(
            'Chained with easeOut:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _tweenBarChart(chainedEaseOut, Color(0xFF9C27B0)),
          SizedBox(height: 12.0),

          Text(
            'Chained with bounceOut:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          _tweenBarChart(chainedBounce, Color(0xFFE91E63)),
          SizedBox(height: 16.0),

          // Color gradient visualization
          Text(
            'ColorTween chained with easeInOut:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
          ),
          SizedBox(height: 4.0),
          Row(
            children: [
              for (final t in [
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
              ])
                Expanded(
                  child: Container(
                    height: 24.0,
                    color:
                        colorChained.evaluate(
                          AlwaysStoppedAnimation<double>(t),
                        ) ??
                        Color(0xFF000000),
                  ),
                ),
            ],
          ),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFF5F5F5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Animatable Summary:',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13.0),
                ),
                SizedBox(height: 4.0),
                Text(
                  '• Animatable is the base class for Tween',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• evaluate() maps Animation<double> to a value',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• transform() maps a raw double (0..1) to a value',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• chain() composes Animatables (e.g., CurveTween)',
                  style: TextStyle(fontSize: 11.0),
                ),
                Text(
                  '• CurveTween wraps a Curve as an Animatable',
                  style: TextStyle(fontSize: 11.0),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _tweenBarChart(Animatable<double> animatable, Color color) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      for (final t in [
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
      ])
        Expanded(
          child: Container(
            height: animatable.transform(t) / 2 + 5,
            margin: EdgeInsets.symmetric(horizontal: 0.5),
            color: color,
          ),
        ),
    ],
  );
}
