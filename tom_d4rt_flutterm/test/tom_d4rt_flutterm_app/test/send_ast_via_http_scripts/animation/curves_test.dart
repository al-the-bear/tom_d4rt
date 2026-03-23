// ignore_for_file: avoid_print
// D4rt test script: Tests Curves from animation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Curves test executing');

  // ========== All named curves ==========
  final curves = <(String, Curve)>[
    ('linear', Curves.linear),
    ('decelerate', Curves.decelerate),
    ('fastLinearToSlowEaseIn', Curves.fastLinearToSlowEaseIn),
    ('ease', Curves.ease),
    ('easeIn', Curves.easeIn),
    ('easeInToLinear', Curves.easeInToLinear),
    ('easeInSine', Curves.easeInSine),
    ('easeInQuad', Curves.easeInQuad),
    ('easeInCubic', Curves.easeInCubic),
    ('easeInQuart', Curves.easeInQuart),
    ('easeInQuint', Curves.easeInQuint),
    ('easeInExpo', Curves.easeInExpo),
    ('easeInCirc', Curves.easeInCirc),
    ('easeInBack', Curves.easeInBack),
    ('easeOut', Curves.easeOut),
    ('linearToEaseOut', Curves.linearToEaseOut),
    ('easeOutSine', Curves.easeOutSine),
    ('easeOutQuad', Curves.easeOutQuad),
    ('easeOutCubic', Curves.easeOutCubic),
    ('easeOutQuart', Curves.easeOutQuart),
    ('easeOutQuint', Curves.easeOutQuint),
    ('easeOutExpo', Curves.easeOutExpo),
    ('easeOutCirc', Curves.easeOutCirc),
    ('easeOutBack', Curves.easeOutBack),
    ('easeInOut', Curves.easeInOut),
    ('easeInOutSine', Curves.easeInOutSine),
    ('easeInOutCubic', Curves.easeInOutCubic),
    ('bounceIn', Curves.bounceIn),
    ('bounceOut', Curves.bounceOut),
    ('bounceInOut', Curves.bounceInOut),
    ('elasticIn', Curves.elasticIn),
    ('elasticOut', Curves.elasticOut),
    ('elasticInOut', Curves.elasticInOut),
  ];

  print('--- All Curves at t=0.5 ---');
  for (final entry in curves) {
    final val = entry.$2.transform(0.5);
    print('  ${entry.$1}: ${val.toStringAsFixed(4)}');
  }

  // ========== Boundary conditions ==========
  print('--- Boundary conditions (all should be 0 at t=0, ~1 at t=1) ---');
  for (final entry in curves) {
    final v0 = entry.$2.transform(0.0);
    final v1 = entry.$2.transform(1.0);
    print(
      '  ${entry.$1}: t=0 -> ${v0.toStringAsFixed(4)}, t=1 -> ${v1.toStringAsFixed(4)}',
    );
  }

  print('Curves test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Curves Tests (${curves.length} curves)',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          for (final entry in curves)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: Row(
                children: [
                  SizedBox(
                    width: 160.0,
                    child: Text(entry.$1, style: TextStyle(fontSize: 11.0)),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 12.0,
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: entry.$2.transform(0.5).clamp(0.0, 1.0),
                        child: Container(color: Color(0xFF3F51B5)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    ),
  );
}
