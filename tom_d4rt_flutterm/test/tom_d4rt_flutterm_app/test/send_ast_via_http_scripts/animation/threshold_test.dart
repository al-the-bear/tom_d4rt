// D4rt test script: Tests Threshold from animation
import 'dart:ui';
import 'package:flutter/animation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Threshold test executing');

  // ========== Threshold(0.5) ==========
  print('--- Threshold(0.5) ---');
  final t50 = Threshold(0.5);
  for (final t in [0.0, 0.1, 0.2, 0.3, 0.4, 0.49, 0.5, 0.51, 0.6, 0.8, 1.0]) {
    print('  t=$t: ${t50.transform(t).toStringAsFixed(1)}');
  }

  // ========== Threshold(0.0) ==========
  print('--- Threshold(0.0) ---');
  final t0 = Threshold(0.0);
  print('  t=0.0: ${t0.transform(0.0).toStringAsFixed(1)}');
  print('  t=0.01: ${t0.transform(0.01).toStringAsFixed(1)}');
  print('  t=1.0: ${t0.transform(1.0).toStringAsFixed(1)}');

  // ========== Threshold(1.0) ==========
  print('--- Threshold(1.0) ---');
  final t1 = Threshold(1.0);
  print('  t=0.0: ${t1.transform(0.0).toStringAsFixed(1)}');
  print('  t=0.99: ${t1.transform(0.99).toStringAsFixed(1)}');
  print('  t=1.0: ${t1.transform(1.0).toStringAsFixed(1)}');

  // ========== Threshold(0.25) ==========
  print('--- Threshold(0.25) ---');
  final t25 = Threshold(0.25);
  for (final t in [0.0, 0.24, 0.25, 0.26, 0.5, 1.0]) {
    print('  t=$t: ${t25.transform(t).toStringAsFixed(1)}');
  }

  // ========== Threshold(0.75) ==========
  print('--- Threshold(0.75) ---');
  final t75 = Threshold(0.75);
  for (final t in [0.0, 0.5, 0.74, 0.75, 0.76, 1.0]) {
    print('  t=$t: ${t75.transform(t).toStringAsFixed(1)}');
  }

  print('Threshold test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Threshold Tests',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('Threshold(0.5): step function at t=0.5'),
          Text('Threshold(0.25): step function at t=0.25'),
          Text('Threshold(0.75): step function at t=0.75'),
          for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
            Row(children: [
              SizedBox(width: 50.0, child: Text('t=$t')),
              Container(
                width: 100.0,
                height: 16.0,
                color: t50.transform(t) > 0.5 ? Color(0xFF4CAF50) : Color(0xFFFF5722),
                child: Center(child: Text(t50.transform(t) > 0.5 ? 'ON' : 'OFF',
                    style: TextStyle(color: Color(0xFFFFFFFF), fontSize: 10.0))),
              ),
            ]),
        ],
      ),
    ),
  );
}
