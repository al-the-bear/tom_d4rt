// D4rt test script: Tests PictureRecorder, Canvas basics from dart:ui
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui picture test executing');

  // ========== PICTURERECORDER ==========
  print('--- PictureRecorder Tests ---');

  final recorder = PictureRecorder();
  print('PictureRecorder created');
  print('  runtimeType: ${recorder.runtimeType}');
  print('  isRecording: ${recorder.isRecording}');

  // ========== CANVAS ==========
  print('--- Canvas Tests ---');

  final canvas = Canvas(recorder);
  print('Canvas created from recorder');
  print('  runtimeType: ${canvas.runtimeType}');
  print('  isRecording: ${recorder.isRecording}');

  // Draw a rectangle
  final rectPaint = Paint()
    ..color = Color(0xFFFF0000)
    ..style = PaintingStyle.fill;
  canvas.drawRect(Rect.fromLTWH(10.0, 10.0, 80.0, 60.0), rectPaint);
  print('Drew red rectangle (10,10,80,60)');

  // Draw a circle
  final circlePaint = Paint()
    ..color = Color(0xFF0000FF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 3.0;
  canvas.drawCircle(Offset(50.0, 50.0), 30.0, circlePaint);
  print('Drew blue circle at (50,50) r=30');

  // Draw a line
  final linePaint = Paint()
    ..color = Color(0xFF00FF00)
    ..strokeWidth = 2.0;
  canvas.drawLine(Offset(0.0, 0.0), Offset(100.0, 100.0), linePaint);
  print('Drew green diagonal line');

  // Draw oval
  final ovalPaint = Paint()
    ..color = Color(0xFFFF00FF)
    ..style = PaintingStyle.fill;
  canvas.drawOval(Rect.fromLTWH(20.0, 30.0, 60.0, 40.0), ovalPaint);
  print('Drew magenta oval');

  // Draw rounded rectangle
  final rrectPaint = Paint()
    ..color = Color(0xFFFF8800)
    ..style = PaintingStyle.fill;
  canvas.drawRRect(
    RRect.fromRectAndRadius(Rect.fromLTWH(5.0, 5.0, 90.0, 70.0), Radius.circular(10.0)),
    rrectPaint,
  );
  print('Drew orange rounded rectangle');

  // Draw path
  final path = Path();
  path.moveTo(10.0, 80.0);
  path.lineTo(50.0, 10.0);
  path.lineTo(90.0, 80.0);
  path.close();
  final pathPaint = Paint()
    ..color = Color(0xFF00FFFF)
    ..style = PaintingStyle.stroke
    ..strokeWidth = 2.0;
  canvas.drawPath(path, pathPaint);
  print('Drew cyan triangle path');

  // Save/restore
  canvas.save();
  print('Canvas save()');

  canvas.translate(10.0, 10.0);
  print('Canvas translate(10, 10)');

  canvas.scale(0.5);
  print('Canvas scale(0.5)');

  canvas.drawRect(Rect.fromLTWH(0.0, 0.0, 50.0, 50.0), rectPaint);
  print('Drew scaled rectangle');

  canvas.restore();
  print('Canvas restore()');

  // Draw arc
  canvas.drawArc(
    Rect.fromLTWH(10.0, 10.0, 80.0, 80.0),
    0.0,
    3.14159,
    false,
    circlePaint,
  );
  print('Drew arc');

  // Draw points
  final pointPaint = Paint()
    ..color = Color(0xFFFFFF00)
    ..strokeWidth = 5.0
    ..strokeCap = StrokeCap.round;
  canvas.drawPoints(
    PointMode.points,
    [Offset(20.0, 20.0), Offset(40.0, 40.0), Offset(60.0, 60.0)],
    pointPaint,
  );
  print('Drew 3 points');

  // ClipRect
  canvas.save();
  canvas.clipRect(Rect.fromLTWH(0.0, 0.0, 50.0, 50.0));
  print('Canvas clipRect applied');
  canvas.restore();

  // ========== END RECORDING ==========
  print('--- End Recording ---');

  final picture = recorder.endRecording();
  print('Picture recorded: ${picture.runtimeType}');
  print('  isRecording after end: ${recorder.isRecording}');

  // ========== POINTMODE ==========
  print('--- PointMode Tests ---');

  for (final mode in PointMode.values) {
    print('  PointMode.$mode: index=${mode.index}');
  }

  // ========== RETURN WIDGET ==========
  print('dart:ui picture test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'dart:ui Picture & Canvas Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text('Classes Tested:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('• PictureRecorder - records canvas ops'),
          Text('• Canvas - drawing surface'),
          Text('• Picture - recorded drawing'),
          Text('• PointMode - point rendering mode'),
          SizedBox(height: 16.0),

          Text('Canvas Operations:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFEDE7F6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• drawRect - filled rectangle'),
                Text('• drawCircle - stroked circle'),
                Text('• drawLine - diagonal line'),
                Text('• drawOval - filled oval'),
                Text('• drawRRect - rounded rectangle'),
                Text('• drawPath - triangle path'),
                Text('• drawArc - semicircle arc'),
                Text('• drawPoints - point array'),
                Text('• save/restore - transform stack'),
                Text('• translate/scale - transforms'),
                Text('• clipRect - clipping region'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
