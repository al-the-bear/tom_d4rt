// D4rt test script: Tests CustomPaint, CustomPainter, Canvas operations,
// CustomClipper, RenderObjectWidget, MouseRegion advanced, Listener advanced
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

dynamic build(BuildContext context) {
  print('Render objects misc test executing');

  // ========== CustomPaint ==========
  print('--- CustomPaint Tests ---');
  final customPaint = CustomPaint(
    painter: TestPainter(),
    foregroundPainter: TestForegroundPainter(),
    size: Size(200, 200),
    isComplex: true,
    willChange: false,
    child: Container(width: 200, height: 200),
  );
  print('CustomPaint created');

  // ========== CustomPainter ==========
  print('--- CustomPainter Tests ---');
  final painter = TestPainter();
  print('TestPainter created');
  print('  semanticsBuilder: ${painter.semanticsBuilder}');
  print('  hitTest: ${painter.hitTest(Offset(50, 50))}');

  // ========== CustomClipper<Rect> ==========
  print('--- CustomClipper Tests ---');
  final clippedRect = ClipRect(
    clipper: TestRectClipper(),
    clipBehavior: Clip.antiAlias,
    child: Container(width: 200, height: 200, color: Colors.blue),
  );
  print('ClipRect with CustomClipper created');

  // ========== CustomClipper<Path> ==========
  print('--- CustomClipper<Path> Tests ---');
  final clippedPath = ClipPath(
    clipper: TestPathClipper(),
    clipBehavior: Clip.antiAliasWithSaveLayer,
    child: Container(width: 200, height: 200, color: Colors.red),
  );
  print('ClipPath with CustomClipper created');

  // ========== MouseRegion advanced ==========
  print('--- MouseRegion Advanced Tests ---');
  final mouseRegion = MouseRegion(
    onEnter: (event) => print('  Mouse entered: ${event.position}'),
    onExit: (event) => print('  Mouse exited: ${event.position}'),
    onHover: (event) => print('  Mouse hover: ${event.position}'),
    cursor: SystemMouseCursors.click,
    opaque: true,
    hitTestBehavior: HitTestBehavior.opaque,
    child: Container(
      width: 100,
      height: 100,
      color: Colors.green,
      child: Center(child: Text('Hover me')),
    ),
  );
  print('MouseRegion advanced created');
  print('  cursor: ${SystemMouseCursors.click}');
  print('  SystemMouseCursors.basic: ${SystemMouseCursors.basic}');
  print('  SystemMouseCursors.text: ${SystemMouseCursors.text}');
  print('  SystemMouseCursors.grab: ${SystemMouseCursors.grab}');
  print('  SystemMouseCursors.move: ${SystemMouseCursors.move}');
  print('  SystemMouseCursors.resizeLeft: ${SystemMouseCursors.resizeLeft}');

  // ========== Listener advanced ==========
  print('--- Listener Advanced Tests ---');
  final listener = Listener(
    onPointerDown: (event) => print('  Pointer down: ${event.position}'),
    onPointerUp: (event) => print('  Pointer up: ${event.position}'),
    onPointerMove: (event) => print('  Pointer move: ${event.position}'),
    onPointerCancel: (event) => print('  Pointer cancel'),
    onPointerHover: (event) => print('  Pointer hover: ${event.position}'),
    onPointerSignal: (event) => print('  Pointer signal'),
    onPointerPanZoomStart: (event) => print('  PanZoom start'),
    onPointerPanZoomUpdate: (event) => print('  PanZoom update'),
    onPointerPanZoomEnd: (event) => print('  PanZoom end'),
    behavior: HitTestBehavior.translucent,
    child: Container(width: 100, height: 100, color: Colors.orange),
  );
  print('Listener advanced created');

  // ========== DecoratedBox ==========
  print('--- DecoratedBox Tests ---');
  final decoratedBox = DecoratedBox(
    decoration: BoxDecoration(
      color: Colors.purple[100],
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: Colors.purple, width: 2),
      boxShadow: [
        BoxShadow(
          color: Colors.purple[200]!,
          blurRadius: 8,
          offset: Offset(2, 2),
        ),
      ],
      gradient: LinearGradient(
        colors: [Colors.purple[100]!, Colors.purple[300]!],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    ),
    position: DecorationPosition.background,
    child: Container(
      width: 100,
      height: 100,
      child: Center(child: Text('Decorated')),
    ),
  );
  print('DecoratedBox created');

  print('All render objects misc tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            customPaint,
            clippedRect,
            clippedPath,
            mouseRegion,
            listener,
            decoratedBox,
          ],
        ),
      ),
    ),
  );
}

class TestPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke;

    canvas.drawRect(
      Rect.fromLTWH(10, 10, size.width - 20, size.height - 20),
      paint,
    );
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      30,
      paint
        ..style = PaintingStyle.fill
        ..color = Colors.red,
    );
    canvas.drawLine(
      Offset(0, 0),
      Offset(size.width, size.height),
      paint
        ..color = Colors.green
        ..style = PaintingStyle.stroke,
    );
  }

  @override
  bool shouldRepaint(TestPainter oldDelegate) => false;

  @override
  bool? hitTest(Offset position) => true;
}

class TestForegroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.black.withValues(alpha: 0.3)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(Offset(size.width / 2, size.height / 2), 20, paint);
  }

  @override
  bool shouldRepaint(TestForegroundPainter oldDelegate) => false;
}

class TestRectClipper extends CustomClipper<Rect> {
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(
      size.width * 0.1,
      size.height * 0.1,
      size.width * 0.8,
      size.height * 0.8,
    );
  }

  @override
  bool shouldReclip(TestRectClipper oldClipper) => false;
}

class TestPathClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(TestPathClipper oldClipper) => false;
}
