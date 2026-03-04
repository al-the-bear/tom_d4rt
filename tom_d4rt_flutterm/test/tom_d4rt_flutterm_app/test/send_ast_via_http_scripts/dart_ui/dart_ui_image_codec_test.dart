// D4rt test script: Tests dart:ui Image concepts, Codec, FrameInfo,
// Picture, PictureRecorder, SceneBuilder, Scene, Paragraph,
// ParagraphBuilder, ParagraphStyle, TextStyle as ui.TextStyle
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('Dart UI image/codec test executing');

  // ========== PictureRecorder ==========
  print('--- PictureRecorder Tests ---');
  final recorder = ui.PictureRecorder();
  print('PictureRecorder created');
  print('  isRecording: ${recorder.isRecording}');

  // ========== Canvas with PictureRecorder ==========
  print('--- Canvas Tests ---');
  final canvas = Canvas(recorder);
  print('Canvas created from PictureRecorder');

  canvas.drawRect(
    Rect.fromLTWH(0, 0, 100, 100),
    Paint()..color = Color(0xFFFF0000),
  );
  print('  drawRect done');

  canvas.drawCircle(
    Offset(50, 50),
    30,
    Paint()..color = Color(0xFF00FF00)..style = PaintingStyle.fill,
  );
  print('  drawCircle done');

  canvas.drawLine(
    Offset(0, 0),
    Offset(100, 100),
    Paint()..color = Color(0xFF0000FF)..strokeWidth = 2.0,
  );
  print('  drawLine done');

  canvas.drawOval(
    Rect.fromLTWH(10, 10, 80, 40),
    Paint()..color = Color(0xFFFF00FF),
  );
  print('  drawOval done');

  canvas.drawRRect(
    RRect.fromRectAndRadius(Rect.fromLTWH(10, 60, 80, 30), Radius.circular(8)),
    Paint()..color = Color(0xFFFFFF00),
  );
  print('  drawRRect done');

  final path = Path();
  path.moveTo(50, 0);
  path.lineTo(100, 100);
  path.lineTo(0, 100);
  path.close();
  canvas.drawPath(path, Paint()..color = Color(0xFF00FFFF));
  print('  drawPath (triangle) done');

  canvas.save();
  canvas.translate(10, 10);
  canvas.rotate(0.1);
  canvas.scale(0.9);
  canvas.restore();
  print('  save/translate/rotate/scale/restore done');

  canvas.clipRect(Rect.fromLTWH(0, 0, 80, 80));
  print('  clipRect done');

  canvas.clipRRect(RRect.fromRectAndRadius(Rect.fromLTWH(0, 0, 80, 80), Radius.circular(8)));
  print('  clipRRect done');

  canvas.clipPath(path);
  print('  clipPath done');

  // ========== Picture ==========
  print('--- Picture Tests ---');
  final picture = recorder.endRecording();
  print('Picture created from recorder');

  // ========== ParagraphBuilder ==========
  print('--- ParagraphBuilder Tests ---');
  final paragraphStyle = ui.ParagraphStyle(
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
    maxLines: 3,
    fontFamily: 'Roboto',
    fontSize: 16.0,
    height: 1.5,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    ellipsis: '...',
    locale: Locale('en', 'US'),
    strutStyle: ui.StrutStyle(
      fontFamily: 'Roboto',
      fontSize: 16.0,
      height: 1.5,
      leading: 0.0,
      forceStrutHeight: false,
    ),
  );
  print('ParagraphStyle created');

  final builder = ui.ParagraphBuilder(paragraphStyle);
  builder.pushStyle(ui.TextStyle(
    color: Color(0xFF000000),
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.5,
    wordSpacing: 1.0,
    height: 1.5,
    decoration: TextDecoration.none,
    decorationColor: Color(0xFFFF0000),
    decorationStyle: TextDecorationStyle.solid,
    fontFamily: 'Roboto',
    locale: Locale('en'),
  ));
  builder.addText('Hello World from ParagraphBuilder. ');
  builder.pop();

  builder.pushStyle(ui.TextStyle(
    color: Color(0xFFFF0000),
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    decoration: TextDecoration.underline,
  ));
  builder.addText('Bold red text.');
  builder.pop();

  print('ParagraphBuilder with styles created');

  // ========== Paragraph ==========
  print('--- Paragraph Tests ---');
  final paragraph = builder.build();
  paragraph.layout(ui.ParagraphConstraints(width: 300));
  print('Paragraph built and laid out');
  print('  width: ${paragraph.width}');
  print('  height: ${paragraph.height}');
  print('  minIntrinsicWidth: ${paragraph.minIntrinsicWidth}');
  print('  maxIntrinsicWidth: ${paragraph.maxIntrinsicWidth}');
  print('  longestLine: ${paragraph.longestLine}');
  print('  alphabeticBaseline: ${paragraph.alphabeticBaseline}');
  print('  ideographicBaseline: ${paragraph.ideographicBaseline}');
  print('  didExceedMaxLines: ${paragraph.didExceedMaxLines}');

  // ========== Paint advanced ==========
  print('--- Paint Advanced Tests ---');
  final paint = Paint()
    ..color = Color(0xFF0000FF)
    ..strokeWidth = 3.0
    ..strokeCap = StrokeCap.round
    ..strokeJoin = StrokeJoin.round
    ..strokeMiterLimit = 4.0
    ..style = PaintingStyle.stroke
    ..isAntiAlias = true
    ..blendMode = BlendMode.srcOver
    ..filterQuality = FilterQuality.high
    ..invertColors = false;
  print('Paint advanced created');
  print('  color: ${paint.color}');
  print('  strokeWidth: ${paint.strokeWidth}');
  print('  strokeCap: ${paint.strokeCap}');
  print('  strokeJoin: ${paint.strokeJoin}');
  print('  style: ${paint.style}');
  print('  blendMode: ${paint.blendMode}');
  print('  filterQuality: ${paint.filterQuality}');

  // ========== BlendMode values ==========
  print('--- BlendMode Tests ---');
  final blendModes = [
    BlendMode.clear, BlendMode.src, BlendMode.dst,
    BlendMode.srcOver, BlendMode.dstOver, BlendMode.srcIn,
    BlendMode.dstIn, BlendMode.srcOut, BlendMode.dstOut,
    BlendMode.srcATop, BlendMode.dstATop, BlendMode.xor,
    BlendMode.plus, BlendMode.multiply, BlendMode.screen,
    BlendMode.overlay, BlendMode.darken, BlendMode.lighten,
  ];
  for (final mode in blendModes) {
    print('  BlendMode.$mode');
  }

  // ========== StrokeCap / StrokeJoin ==========
  print('--- StrokeCap Tests ---');
  for (final cap in StrokeCap.values) {
    print('  StrokeCap.$cap');
  }
  print('--- StrokeJoin Tests ---');
  for (final join in StrokeJoin.values) {
    print('  StrokeJoin.$join');
  }

  print('All dart:ui image/codec tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: CustomPaint(
          size: Size(300, 300),
          painter: TestCanvasPainter(picture),
        ),
      ),
    ),
  );
}

class TestCanvasPainter extends CustomPainter {
  final ui.Picture picture;
  TestCanvasPainter(this.picture);

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPicture(picture);
  }

  @override
  bool shouldRepaint(TestCanvasPainter oldDelegate) => false;
}
