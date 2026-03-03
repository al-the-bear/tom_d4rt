// D4rt test script: Tests Velocity, VelocityEstimate, ForcePressDetails from package:flutter/gestures.dart
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Gestures velocity test executing');

  // ========== VELOCITY ==========
  print('--- Velocity Tests ---');

  final vel1 = Velocity(pixelsPerSecond: Offset(100.0, 200.0));
  print('Velocity(100, 200): $vel1');
  print('  pixelsPerSecond: ${vel1.pixelsPerSecond}');
  print('  runtimeType: ${vel1.runtimeType}');

  final vel2 = Velocity(pixelsPerSecond: Offset(-50.0, 300.0));
  print('Velocity(-50, 300): $vel2');
  print('  pixelsPerSecond: ${vel2.pixelsPerSecond}');

  final velZero = Velocity.zero;
  print('Velocity.zero: $velZero');
  print('  pixelsPerSecond: ${velZero.pixelsPerSecond}');

  // Velocity operations
  final sum = vel1 + vel2;
  print('vel1 + vel2: $sum');
  print('  pixelsPerSecond: ${sum.pixelsPerSecond}');

  final negated = -vel1;
  print('-vel1: $negated');
  print('  pixelsPerSecond: ${negated.pixelsPerSecond}');

  final diff = vel1 - vel2;
  print('vel1 - vel2: $diff');
  print('  pixelsPerSecond: ${diff.pixelsPerSecond}');

  // clampMagnitude
  final bigVel = Velocity(pixelsPerSecond: Offset(5000.0, 5000.0));
  print('Big velocity: ${bigVel.pixelsPerSecond}');

  final clamped = bigVel.clampMagnitude(0.0, 1000.0);
  print('Clamped to 1000: $clamped');
  print('  pixelsPerSecond: ${clamped.pixelsPerSecond}');

  // Test equality
  final velA = Velocity(pixelsPerSecond: Offset(100.0, 200.0));
  final velB = Velocity(pixelsPerSecond: Offset(100.0, 200.0));
  final velC = Velocity(pixelsPerSecond: Offset(100.0, 201.0));
  print('Velocity equality: velA == velB: ${velA == velB}');
  print('Velocity equality: velA == velC: ${velA == velC}');

  // Various velocity values
  final fastSwipe = Velocity(pixelsPerSecond: Offset(2000.0, 0.0));
  print('Fast horizontal swipe: ${fastSwipe.pixelsPerSecond}');

  final slowDrag = Velocity(pixelsPerSecond: Offset(10.0, 15.0));
  print('Slow drag: ${slowDrag.pixelsPerSecond}');

  final diagonalFling = Velocity(pixelsPerSecond: Offset(1000.0, -800.0));
  print('Diagonal fling: ${diagonalFling.pixelsPerSecond}');

  // ========== FORCEPRESSDETAILS ==========
  print('--- ForcePressDetails Tests ---');

  final force1 = ForcePressDetails(
    globalPosition: Offset(10.0, 20.0),
    pressure: 0.5,
  );
  print('ForcePressDetails(10, 20, p=0.5):');
  print('  globalPosition: ${force1.globalPosition}');
  print('  localPosition: ${force1.localPosition}');
  print('  pressure: ${force1.pressure}');
  print('  runtimeType: ${force1.runtimeType}');

  final force2 = ForcePressDetails(
    globalPosition: Offset(100.0, 200.0),
    localPosition: Offset(50.0, 80.0),
    pressure: 0.8,
  );
  print('ForcePressDetails with localPosition:');
  print('  globalPosition: ${force2.globalPosition}');
  print('  localPosition: ${force2.localPosition}');
  print('  pressure: ${force2.pressure}');

  // Light touch
  final lightTouch = ForcePressDetails(
    globalPosition: Offset(50.0, 50.0),
    pressure: 0.1,
  );
  print('Light touch pressure: ${lightTouch.pressure}');

  // Hard press
  final hardPress = ForcePressDetails(
    globalPosition: Offset(50.0, 50.0),
    pressure: 1.0,
  );
  print('Hard press pressure: ${hardPress.pressure}');

  // ========== VELOCITYESTIMATE ==========
  print('--- VelocityEstimate Tests ---');

  final estimate = VelocityEstimate(
    pixelsPerSecond: Offset(500.0, -300.0),
    confidence: 0.95,
    duration: Duration(milliseconds: 200),
    offset: Offset(100.0, -60.0),
  );
  print('VelocityEstimate:');
  print('  pixelsPerSecond: ${estimate.pixelsPerSecond}');
  print('  confidence: ${estimate.confidence}');
  print('  duration: ${estimate.duration}');
  print('  offset: ${estimate.offset}');
  print('  runtimeType: ${estimate.runtimeType}');

  final lowConfidence = VelocityEstimate(
    pixelsPerSecond: Offset(50.0, 50.0),
    confidence: 0.2,
    duration: Duration(milliseconds: 50),
    offset: Offset(5.0, 5.0),
  );
  print('Low confidence estimate:');
  print('  confidence: ${lowConfidence.confidence}');
  print('  pixelsPerSecond: ${lowConfidence.pixelsPerSecond}');

  // ========== RETURN WIDGET ==========
  print('Gestures velocity test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gestures Velocity Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text('Classes Tested:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('• Velocity - speed and direction'),
          Text('• VelocityEstimate - estimated velocity'),
          Text('• ForcePressDetails - 3D touch details'),
          SizedBox(height: 16.0),

          Text('Velocity Operations:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE8EAF6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('vel1: ${vel1.pixelsPerSecond}'),
                Text('vel2: ${vel2.pixelsPerSecond}'),
                Text('vel1 + vel2: ${sum.pixelsPerSecond}'),
                Text('-vel1: ${negated.pixelsPerSecond}'),
                Text('Velocity.zero: ${velZero.pixelsPerSecond}'),
                SizedBox(height: 8.0),
                Text('ForcePressDetails:'),
                Text('  position: ${force1.globalPosition}'),
                Text('  pressure: ${force1.pressure}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
