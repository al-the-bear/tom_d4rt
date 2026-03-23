// ignore_for_file: avoid_print
// D4rt test script: Tests UnconstrainedBox, LimitedBox, Baseline from Flutter widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Sizing widgets test executing');

  // Test UnconstrainedBox with child
  final unconstrained1 = UnconstrainedBox(
    child: Container(width: 200, height: 100, color: Colors.blue),
  );
  print('UnconstrainedBox with Container(200x100) created');

  // Test UnconstrainedBox with constrainedAxis horizontal
  final unconstrained2 = UnconstrainedBox(
    constrainedAxis: Axis.horizontal,
    child: Container(width: 150, height: 80, color: Colors.green),
  );
  print('UnconstrainedBox(constrainedAxis: Axis.horizontal) created');

  // Test UnconstrainedBox with constrainedAxis vertical
  final unconstrained3 = UnconstrainedBox(
    constrainedAxis: Axis.vertical,
    child: Container(width: 120, height: 60, color: Colors.cyan),
  );
  print('UnconstrainedBox(constrainedAxis: Axis.vertical) created');

  // Test LimitedBox with maxWidth and maxHeight
  final limited1 = LimitedBox(
    maxWidth: 100,
    maxHeight: 50,
    child: Container(color: Colors.red),
  );
  print('LimitedBox(maxWidth: 100, maxHeight: 50) created');

  // Test LimitedBox with only maxWidth
  final limited2 = LimitedBox(
    maxWidth: 200,
    child: Container(color: Colors.orange),
  );
  print('LimitedBox(maxWidth: 200) created');

  // Test Baseline with alphabetic
  final baseline1 = Baseline(
    baseline: 20.0,
    baselineType: TextBaseline.alphabetic,
    child: Text('Baseline alphabetic'),
  );
  print('Baseline(baseline: 20.0, TextBaseline.alphabetic) created');

  // Test Baseline with ideographic
  final baseline2 = Baseline(
    baseline: 40.0,
    baselineType: TextBaseline.ideographic,
    child: Text('Baseline ideographic'),
  );
  print('Baseline(baseline: 40.0, TextBaseline.ideographic) created');

  print('Sizing widgets test completed');
  return Column(
    children: [
      unconstrained1,
      unconstrained2,
      unconstrained3,
      SizedBox(height: 60, child: limited1),
      SizedBox(height: 60, child: limited2),
      baseline1,
      baseline2,
    ],
  );
}
