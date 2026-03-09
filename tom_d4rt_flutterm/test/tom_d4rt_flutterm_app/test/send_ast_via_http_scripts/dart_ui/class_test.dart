// D4rt test script: Tests dart:ui core class availability and type system
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui class overview test executing');

  // Verify core class types are accessible
  print('--- Core Geometry ---');
  final offset = Offset(10, 20);
  print('Offset: ${offset.runtimeType}');
  final size = Size(100, 50);
  print('Size: ${size.runtimeType}');
  final rect = Rect.fromLTWH(0, 0, 100, 100);
  print('Rect: ${rect.runtimeType}');
  final rrect = RRect.fromRectXY(rect, 8, 8);
  print('RRect: ${rrect.runtimeType}');
  final radius = Radius.circular(10);
  print('Radius: ${radius.runtimeType}');

  // Verify painting classes
  print('--- Painting ---');
  final paint = Paint();
  print('Paint: ${paint.runtimeType}');
  final path = Path();
  print('Path: ${path.runtimeType}');
  final color = Color.fromARGB(255, 100, 200, 50);
  print('Color: ${color.runtimeType}');

  // Verify text classes
  print('--- Text ---');
  final ps = ui.ParagraphStyle(fontSize: 14);
  print('ParagraphStyle: ${ps.runtimeType}');
  final ts = ui.TextStyle(fontSize: 14);
  print('ui.TextStyle: ${ts.runtimeType}');
  final tp = TextPosition(offset: 0);
  print('TextPosition: ${tp.runtimeType}');
  final tr = TextRange(start: 0, end: 5);
  print('TextRange: ${tr.runtimeType}');

  // Verify recording classes
  print('--- Recording ---');
  final recorder = ui.PictureRecorder();
  print('PictureRecorder: ${recorder.runtimeType}');
  final sb = ui.SceneBuilder();
  print('SceneBuilder: ${sb.runtimeType}');
  final sub = ui.SemanticsUpdateBuilder();
  print('SemanticsUpdateBuilder: ${sub.runtimeType}');

  // Type hierarchy checks
  print('--- Type Hierarchy ---');
  print('Offset is OffsetBase: ${offset is ui.OffsetBase}');
  print('Size is OffsetBase: ${size is ui.OffsetBase}');

  final update = sub.build();
  update.dispose();
  print('SemanticsUpdate disposed');

  print('dart:ui class overview test completed');
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('dart:ui Class Overview', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('Geometry: Offset, Size, Rect, RRect, Radius'),
            Text('Painting: Paint, Path, Color'),
            Text('Text: ParagraphStyle, TextStyle, TextPosition'),
            Text('Recording: PictureRecorder, SceneBuilder'),
            Text('Hierarchy: Offset/Size extend OffsetBase'),
          ],
        ),
      ),
    ),
  );
}
