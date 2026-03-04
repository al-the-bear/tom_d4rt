// D4rt test script: Tests D4rtCustomPainter proxy with CustomPaint widget
// Phase 4: Proxy class generation for abstract delegates (GEN-083)
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('D4rtCustomPainter proxy test executing');

  // ========== BASIC PROXY CREATION ==========
  print('--- D4rtCustomPainter Basic ---');

  // Create a D4rtCustomPainter with callback implementations
  final painter = D4rtCustomPainter(
    onPaint: (Canvas canvas, Size size) {
      final paint = Paint()..color = Color(0xFFFF0000);
      canvas.drawCircle(Offset(size.width / 2, size.height / 2), 40.0, paint);
    },
    onShouldRepaint: (CustomPainter oldDelegate) => false,
  );
  print('D4rtCustomPainter created: ${painter.runtimeType}');
  print('  is CustomPainter: ${painter is CustomPainter}');

  // Use in CustomPaint widget
  final widget1 = CustomPaint(
    painter: painter,
    size: Size(200.0, 200.0),
    child: Center(
      child: Text('Red Circle', style: TextStyle(color: Colors.white)),
    ),
  );
  print('CustomPaint with D4rtCustomPainter created');

  // ========== DYNAMIC REPAINT LOGIC ==========
  print('--- shouldRepaint Logic ---');

  var repaintCount = 0;
  final dynamicPainter = D4rtCustomPainter(
    onPaint: (Canvas canvas, Size size) {
      final paint = Paint()
        ..color = Color(0xFF0000FF)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.0;
      canvas.drawRect(
        Rect.fromLTWH(10, 10, size.width - 20, size.height - 20),
        paint,
      );
      repaintCount = repaintCount + 1;
    },
    onShouldRepaint: (CustomPainter oldDelegate) => true,
  );
  print('Dynamic painter created (always repaints)');

  final widget2 = CustomPaint(
    painter: dynamicPainter,
    size: Size(150.0, 150.0),
  );
  print('CustomPaint with dynamic painter created');

  // ========== FOREGROUND PAINTER ==========
  print('--- Foreground Painter ---');

  final foregroundPainter = D4rtCustomPainter(
    onPaint: (Canvas canvas, Size size) {
      final paint = Paint()
        ..color = Color(0x8800FF00)
        ..style = PaintingStyle.fill;
      canvas.drawOval(Rect.fromLTWH(0, 0, size.width, size.height), paint);
    },
    onShouldRepaint: (CustomPainter oldDelegate) => false,
  );
  print('Foreground painter created');

  final widget3 = CustomPaint(
    painter: painter,
    foregroundPainter: foregroundPainter,
    size: Size(200.0, 200.0),
    child: Center(child: Text('Layered')),
  );
  print('CustomPaint with both painter and foregroundPainter created');

  // ========== COMPLEX DRAWING ==========
  print('--- Complex Drawing ---');

  final complexPainter = D4rtCustomPainter(
    onPaint: (Canvas canvas, Size size) {
      // Background
      final bgPaint = Paint()..color = Color(0xFFF0F0F0);
      canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

      // Grid lines
      final gridPaint = Paint()
        ..color = Color(0xFFCCCCCC)
        ..strokeWidth = 1.0;
      final step = 20.0;
      var x = step;
      while (x < size.width) {
        canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
        x = x + step;
      }
      var y = step;
      while (y < size.height) {
        canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
        y = y + step;
      }

      // Colored shapes
      final colors = [
        Color(0xFFFF0000),
        Color(0xFF00FF00),
        Color(0xFF0000FF),
        Color(0xFFFFFF00),
      ];
      for (var i = 0; i < colors.length; i = i + 1) {
        final shapePaint = Paint()..color = colors[i];
        canvas.drawCircle(
          Offset(40.0 + i * 50.0, size.height / 2),
          15.0,
          shapePaint,
        );
      }
    },
    onShouldRepaint: (CustomPainter oldDelegate) => false,
  );
  print('Complex painter with grid and shapes created');

  final widget4 = CustomPaint(
    painter: complexPainter,
    size: Size(250.0, 150.0),
  );
  print('CustomPaint with complex painter created');

  // ========== PAINTER WITH ISCOMPLEX AND WILLCHANGE ==========
  print('--- CustomPaint Options ---');

  final widget5 = CustomPaint(
    painter: painter,
    size: Size(100.0, 100.0),
    isComplex: true,
    willChange: false,
  );
  print('CustomPaint with isComplex=true, willChange=false created');

  // ========== PAINTER WITH KEY ==========
  final widget6 = CustomPaint(
    key: ValueKey('proxy-paint-1'),
    painter: painter,
    size: Size(100.0, 100.0),
  );
  print('CustomPaint with ValueKey created');

  print('D4rtCustomPainter proxy test completed');
  return SingleChildScrollView(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('D4rtCustomPainter Proxy Tests'),
        SizedBox(height: 8.0),
        widget1,
        SizedBox(height: 8.0),
        widget2,
        SizedBox(height: 8.0),
        widget3,
        SizedBox(height: 8.0),
        widget4,
        SizedBox(height: 8.0),
        widget5,
      ],
    ),
  );
}
