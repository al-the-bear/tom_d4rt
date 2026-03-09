// D4rt test script: Tests Paint, Canvas, PictureRecorder, MaskFilter, ColorFilter, ImageFilter
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui paint/canvas tests executing');

  // ========== Paint comprehensive ==========
  print('--- Paint Tests ---');
  final paint1 = Paint()
    ..color = Color.fromARGB(255, 255, 0, 0)
    ..strokeWidth = 3.0
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.bevel
    ..blendMode = BlendMode.srcOver
    ..filterQuality = FilterQuality.high
    ..isAntiAlias = true
    ..strokeMiterLimit = 6.0
    ..invertColors = false;
  print('paint1 color: ${paint1.color}');
  print('paint1 strokeWidth: ${paint1.strokeWidth}');
  print('paint1 style: ${paint1.style}');
  print('paint1 strokeCap: ${paint1.strokeCap}');
  print('paint1 strokeJoin: ${paint1.strokeJoin}');
  print('paint1 blendMode: ${paint1.blendMode}');
  print('paint1 filterQuality: ${paint1.filterQuality}');
  print('paint1 isAntiAlias: ${paint1.isAntiAlias}');

  final paint2 = Paint()
    ..color = Color.fromARGB(128, 0, 255, 0)
    ..style = PaintingStyle.fill;
  print('paint2 style: ${paint2.style}');

  // ========== MaskFilter ==========
  print('--- MaskFilter Tests ---');
  final mask1 = MaskFilter.blur(BlurStyle.normal, 5.0);
  print('MaskFilter.blur(normal, 5): $mask1');
  final mask2 = MaskFilter.blur(BlurStyle.inner, 3.0);
  print('MaskFilter.blur(inner, 3): $mask2');
  final mask3 = MaskFilter.blur(BlurStyle.outer, 8.0);
  print('MaskFilter.blur(outer, 8): $mask3');
  final mask4 = MaskFilter.blur(BlurStyle.solid, 2.0);
  print('MaskFilter.blur(solid, 2): $mask4');

  // ========== ColorFilter ==========
  print('--- ColorFilter Tests ---');
  final cf1 = ColorFilter.mode(Colors.red, BlendMode.srcIn);
  print('ColorFilter.mode(red, srcIn): $cf1');
  final cf2 = ColorFilter.linearToSrgbGamma();
  print('ColorFilter.linearToSrgbGamma: $cf2');
  final cf3 = ColorFilter.srgbToLinearGamma();
  print('ColorFilter.srgbToLinearGamma: $cf3');
  final cf4 = ColorFilter.matrix(<double>[
    1, 0, 0, 0, 0,
    0, 1, 0, 0, 0,
    0, 0, 1, 0, 0,
    0, 0, 0, 1, 0,
  ]);
  print('ColorFilter.matrix (identity): $cf4');

  // ========== ImageFilter ==========
  print('--- ImageFilter Tests ---');
  final imgf1 = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  print('ImageFilter.blur(5,5): $imgf1');
  final imgf2 = ui.ImageFilter.blur(sigmaX: 0.0, sigmaY: 10.0);
  print('ImageFilter.blur(0,10): $imgf2');
  final imgf3 = ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0, tileMode: TileMode.clamp);
  print('ImageFilter.blur w/ clamp: $imgf3');

  // ========== Canvas + PictureRecorder ==========
  print('--- Canvas/PictureRecorder Tests ---');
  final recorder = ui.PictureRecorder();
  print('PictureRecorder created: ${recorder.runtimeType}');
  print('isRecording before: ${recorder.isRecording}');

  final canvas = Canvas(recorder, Rect.fromLTWH(0, 0, 300, 200));
  print('Canvas created');

  canvas.drawRect(Rect.fromLTWH(10, 10, 100, 80), paint1);
  print('drawRect done');

  canvas.drawCircle(Offset(150.0, 100.0), 40.0, paint2);
  print('drawCircle done');

  canvas.drawLine(Offset(0, 0), Offset(300.0, 200.0), paint1);
  print('drawLine done');

  final path = Path()
    ..moveTo(50, 50)
    ..lineTo(100, 10)
    ..lineTo(150, 50)
    ..close();
  canvas.drawPath(path, paint2);
  print('drawPath done');

  canvas.drawOval(Rect.fromLTWH(180, 20, 80, 50), paint1);
  print('drawOval done');

  canvas.drawRRect(RRect.fromLTRBXY(200, 80, 290, 180, 10, 10), paint2);
  print('drawRRect done');

  canvas.save();
  canvas.translate(10.0, 10.0);
  canvas.restore();
  print('save/translate/restore done');

  canvas.clipRect(Rect.fromLTWH(0, 0, 300, 200));
  print('clipRect done');

  final picture = recorder.endRecording();
  print('Picture recorded: ${picture.runtimeType}');
  print('isRecording after: ${recorder.isRecording}');

  print('All paint/canvas tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('dart:ui Paint/Canvas Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('Paint: stroke=${paint1.strokeWidth}, cap=${paint1.strokeCap}'),
            Text('MaskFilter: 4 blur styles'),
            Text('ColorFilter: mode, gamma, matrix'),
            Text('ImageFilter: 3 blur configs'),
            Text('Canvas: rect, circle, line, path, oval, rrect'),
            Text('PictureRecorder: record + endRecording'),
          ],
        ),
      ),
    ),
  );
}
