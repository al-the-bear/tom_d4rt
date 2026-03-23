// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RadialGradient, SweepGradient
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('GradientsTest test executing');

  // RadialGradient
  final radialGradient = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [Colors.yellow, Colors.orange, Colors.red],
    stops: [0.0, 0.5, 1.0],
  );
  print('RadialGradient center: ${radialGradient.center}');
  print('RadialGradient radius: ${radialGradient.radius}');
  print('RadialGradient colors: ${radialGradient.colors}');
  print('RadialGradient stops: ${radialGradient.stops}');

  // SweepGradient
  final sweepGradient = SweepGradient(
    center: Alignment.center,
    startAngle: 0.0,
    endAngle: 3.14159 * 2,
    colors: [Colors.blue, Colors.green, Colors.purple, Colors.blue],
    stops: [0.0, 0.33, 0.66, 1.0],
  );
  print('SweepGradient center: ${sweepGradient.center}');
  print('SweepGradient startAngle: ${sweepGradient.startAngle}');
  print('SweepGradient endAngle: ${sweepGradient.endAngle}');
  print('SweepGradient colors: ${sweepGradient.colors}');
  print('SweepGradient stops: ${sweepGradient.stops}');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          gradient: radialGradient,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Text(
            'RadialGradient',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      SizedBox(height: 16.0),
      Container(
        width: 150.0,
        height: 150.0,
        decoration: BoxDecoration(
          gradient: sweepGradient,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Center(
          child: Text(
            'SweepGradient',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ],
  );
}
