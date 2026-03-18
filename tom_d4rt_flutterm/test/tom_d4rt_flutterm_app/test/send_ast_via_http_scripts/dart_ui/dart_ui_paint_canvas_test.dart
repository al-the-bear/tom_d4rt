// D4rt test script: Tests dart:ui Canvas operations, Paint extensions,
// BlendMode, FilterQuality, StrokeCap, StrokeJoin, PathFillType,
// BlurStyle, TileMode, Clip, PointMode
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('dart:ui paint/canvas test executing');

  // ========== BlendMode ==========
  print('--- BlendMode Tests ---');
  final blendModes = [
    ui.BlendMode.srcOver,
    ui.BlendMode.srcIn,
    ui.BlendMode.srcOut,
    ui.BlendMode.dstOver,
    ui.BlendMode.dstIn,
    ui.BlendMode.clear,
    ui.BlendMode.multiply,
    ui.BlendMode.screen,
    ui.BlendMode.overlay,
    ui.BlendMode.darken,
    ui.BlendMode.lighten,
    ui.BlendMode.colorDodge,
    ui.BlendMode.colorBurn,
    ui.BlendMode.softLight,
    ui.BlendMode.hardLight,
    ui.BlendMode.difference,
    ui.BlendMode.exclusion,
    ui.BlendMode.hue,
    ui.BlendMode.saturation,
    ui.BlendMode.color,
    ui.BlendMode.luminosity,
  ];
  print('BlendMode values: ${blendModes.length} tested');
  for (final mode in blendModes.take(5)) {
    print('  BlendMode: ${mode.name}');
  }

  // ========== FilterQuality ==========
  print('--- FilterQuality Tests ---');
  for (final q in ui.FilterQuality.values) {
    print('FilterQuality: ${q.name}');
  }

  // ========== StrokeCap ==========
  print('--- StrokeCap Tests ---');
  for (final cap in ui.StrokeCap.values) {
    print('StrokeCap: ${cap.name}');
  }

  // ========== StrokeJoin ==========
  print('--- StrokeJoin Tests ---');
  for (final join in ui.StrokeJoin.values) {
    print('StrokeJoin: ${join.name}');
  }

  // ========== PathFillType ==========
  print('--- PathFillType Tests ---');
  for (final fill in ui.PathFillType.values) {
    print('PathFillType: ${fill.name}');
  }

  // ========== BlurStyle ==========
  print('--- BlurStyle Tests ---');
  for (final style in ui.BlurStyle.values) {
    print('BlurStyle: ${style.name}');
  }

  // ========== TileMode ==========
  print('--- TileMode Tests ---');
  for (final mode in ui.TileMode.values) {
    print('TileMode: ${mode.name}');
  }

  // ========== Clip ==========
  print('--- Clip Tests ---');
  for (final clip in ui.Clip.values) {
    print('Clip: ${clip.name}');
  }

  // ========== PointMode ==========
  print('--- PointMode Tests ---');
  for (final pm in ui.PointMode.values) {
    print('PointMode: ${pm.name}');
  }

  // ========== PaintingStyle ==========
  print('--- PaintingStyle Tests ---');
  for (final ps in ui.PaintingStyle.values) {
    print('PaintingStyle: ${ps.name}');
  }

  // ========== Paint advanced ==========
  print('--- Paint advanced Tests ---');
  final paint = Paint()
    ..color = Colors.blue
    ..strokeWidth = 2.0
    ..style = PaintingStyle.stroke
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..blendMode = BlendMode.srcOver
    ..filterQuality = FilterQuality.high
    ..isAntiAlias = true
    ..strokeMiterLimit = 4.0
    ..invertColors = false;
  print('Paint configured:');
  print('  color: ${paint.color}');
  print('  strokeWidth: ${paint.strokeWidth}');
  print('  style: ${paint.style}');
  print('  strokeCap: ${paint.strokeCap}');
  print('  strokeJoin: ${paint.strokeJoin}');
  print('  blendMode: ${paint.blendMode}');
  print('  filterQuality: ${paint.filterQuality}');
  print('  isAntiAlias: ${paint.isAntiAlias}');

  // ========== MaskFilter ==========
  print('--- MaskFilter Tests ---');
  final maskFilter = MaskFilter.blur(BlurStyle.normal, 5.0);
  print('MaskFilter.blur: $maskFilter');

  // ========== Path advanced ==========
  print('--- Path advanced Tests ---');
  final path = Path()
    ..moveTo(0, 0)
    ..lineTo(100, 0)
    ..lineTo(100, 100)
    ..lineTo(0, 100)
    ..close();
  final bounds = path.getBounds();
  print('Path bounds: $bounds');

  final path2 = Path()
    ..addOval(Rect.fromCircle(center: Offset(50, 50), radius: 30));
  print('Oval path bounds: ${path2.getBounds()}');
  print('Contains (50,50): ${path2.contains(Offset(50, 50))}');

  print('All dart:ui paint/canvas tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'dart:ui Paint/Canvas Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text('BlendMode: ${blendModes.length} modes'),
            Text('FilterQuality, StrokeCap, StrokeJoin'),
            Text('PathFillType, BlurStyle, TileMode'),
            Text('Paint advanced configuration'),
            Text('MaskFilter, Path operations'),
          ],
        ),
      ),
    ),
  );
}
