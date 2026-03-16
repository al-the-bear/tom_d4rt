// D4rt test script: Tests SawTooth from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SawTooth test executing');

  // ========== SawTooth(1) ==========
  print('--- SawTooth(1) ---');
  final saw1 = SawTooth(1);
  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0]) {
    print('  t=$t: ${saw1.transform(t).toStringAsFixed(4)}');
  }

  // ========== SawTooth(2) ==========
  print('--- SawTooth(2) ---');
  final saw2 = SawTooth(2);
  for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]) {
    print('  t=$t: ${saw2.transform(t).toStringAsFixed(4)}');
  }

  // ========== SawTooth(3) ==========
  print('--- SawTooth(3) ---');
  final saw3 = SawTooth(3);
  for (final t in [0.0, 0.166, 0.333, 0.5, 0.666, 0.833, 1.0]) {
    print('  t=$t: ${saw3.transform(t).toStringAsFixed(4)}');
  }

  // ========== SawTooth(5) ==========
  print('--- SawTooth(5) ---');
  final saw5 = SawTooth(5);
  print('  t=0.0: ${saw5.transform(0.0).toStringAsFixed(4)}');
  print('  t=0.1: ${saw5.transform(0.1).toStringAsFixed(4)}');
  print('  t=0.2: ${saw5.transform(0.2).toStringAsFixed(4)}');
  print('  t=0.5: ${saw5.transform(0.5).toStringAsFixed(4)}');

  print('SawTooth test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('SawTooth Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('SawTooth(2) visualization:'),
          for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0])
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.0),
              child: Row(children: [
                SizedBox(width: 50.0, child: Text('t=$t')),
                Expanded(
                  child: Container(
                    height: 12.0,
                    child: FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: saw2.transform(t).clamp(0.0, 1.0),
                      child: Container(color: Color(0xFFFF9800)),
                    ),
                  ),
                ),
              ]),
            ),
        ],
      ),
    ),
  );
}
