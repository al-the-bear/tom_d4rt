// D4rt test script: Deep Demo for Rect from dart:ui
// Rect defines a rectangle by left, top, right, bottom coordinates
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Rect Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CONSTRUCTORS
  // ═══════════════════════════════════════════════════════════════════════════

  final fromLTRB = Rect.fromLTRB(10, 20, 210, 120);
  print('fromLTRB(10,20,210,120): $fromLTRB');

  final fromLTWH = Rect.fromLTWH(10, 20, 200, 100);
  print('fromLTWH(10,20,200,100): $fromLTWH');

  final fromCenter = Rect.fromCenter(
    center: Offset(100, 60),
    width: 200,
    height: 100,
  );
  print('fromCenter(c:(100,60), w:200, h:100): $fromCenter');

  final fromCircle = Rect.fromCircle(center: Offset(100, 100), radius: 50);
  print('fromCircle(c:(100,100), r:50): $fromCircle');

  final fromPoints = Rect.fromPoints(Offset(30, 40), Offset(180, 140));
  print('fromPoints((30,40),(180,140)): $fromPoints');

  final zero = Rect.zero;
  print('Rect.zero: $zero');

  final largest = Rect.largest;
  print('Rect.largest: exists=${largest.width > 0}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  final r = Rect.fromLTWH(20, 30, 160, 80);
  print('left=${r.left}, top=${r.top}, right=${r.right}, bottom=${r.bottom}');
  print('width=${r.width}, height=${r.height}');
  print('size=${r.size}');
  print('center=${r.center}');
  print('topLeft=${r.topLeft}, topRight=${r.topRight}');
  print('bottomLeft=${r.bottomLeft}, bottomRight=${r.bottomRight}');
  print('topCenter=${r.topCenter}, bottomCenter=${r.bottomCenter}');
  print('centerLeft=${r.centerLeft}, centerRight=${r.centerRight}');
  print('shortestSide=${r.shortestSide}, longestSide=${r.longestSide}');
  print('hasNaN=${r.hasNaN}, isFinite=${r.isFinite}, isEmpty=${r.isEmpty}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  final shifted = r.shift(Offset(40, 20));
  print('shift(40,20): $shifted');

  final translated = r.translate(10, -10);
  print('translate(10,-10): $translated');

  final inflated = r.inflate(15);
  print('inflate(15): $inflated');

  final deflated = r.deflate(10);
  print('deflate(10): $deflated');

  // Intersection and union
  final r2 = Rect.fromLTWH(100, 50, 160, 80);
  final intersection = r.intersect(r2);
  print('intersect: $intersection');
  final union = r.expandToInclude(r2);
  print('expandToInclude: $union');
  print('overlaps: ${r.overlaps(r2)}');

  // Contains
  print('contains(100,70): ${r.contains(Offset(100, 70))}');
  print('contains(300,300): ${r.contains(Offset(300, 300))}');

  // Lerp
  final lerpResult = Rect.lerp(r, r2, 0.5);
  print('lerp(0.5): $lerpResult');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: EQUALITY
  // ═══════════════════════════════════════════════════════════════════════════

  final eq1 = Rect.fromLTWH(10, 10, 50, 50);
  final eq2 = Rect.fromLTRB(10, 10, 60, 60);
  final eq3 = Rect.fromLTWH(10, 10, 50, 60);
  print('eq1 == eq2: ${eq1 == eq2}');
  print('eq1 == eq3: ${eq1 == eq3}');

  print('Rect demo complete');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL DISPLAY
  // ═══════════════════════════════════════════════════════════════════════════

  return MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Color(0xFFF0F4F8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ── Header ──
              Container(
                margin: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF00695C), Color(0xFF26A69A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.teal.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.crop_square, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'Rect Deep Demo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      'Rectangle: left, top, right, bottom',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 1: Constructors Visualization ──
              _sectionTitle('1. RECT CONSTRUCTORS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Stack(
                  children: [
                    _rectWidget(fromLTRB, 'fromLTRB', Color(0xFF1565C0)),
                    _rectWidget(fromCircle, 'fromCircle', Color(0xFF6A1B9A)),
                    _rectWidget(
                      Rect.fromLTWH(120, 80, 80, 60),
                      'fromLTWH',
                      Color(0xFFE65100),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                child: Text(
                  'Overlapping rects from different constructors',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),

              // ── Demo 2: Properties ──
              _sectionTitle('2. RECT PROPERTIES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _propRow(
                      'left / top',
                      '${r.left} / ${r.top}',
                      Color(0xFF1565C0),
                    ),
                    _propRow(
                      'right / bottom',
                      '${r.right} / ${r.bottom}',
                      Color(0xFF00695C),
                    ),
                    _propRow(
                      'width / height',
                      '${r.width} / ${r.height}',
                      Color(0xFF6A1B9A),
                    ),
                    _propRow('center', '${r.center}', Color(0xFFE65100)),
                    _propRow('size', '${r.size}', Color(0xFF2E7D32)),
                    Divider(),
                    _propRow(
                      'shortestSide',
                      '${r.shortestSide}',
                      Color(0xFF00838F),
                    ),
                    _propRow(
                      'longestSide',
                      '${r.longestSide}',
                      Color(0xFFC62828),
                    ),
                    _propRow('isEmpty', '${r.isEmpty}', Color(0xFF455A64)),
                    _propRow('isFinite', '${r.isFinite}', Color(0xFF455A64)),
                  ],
                ),
              ),

              // ── Demo 3: Corner Points ──
              _sectionTitle('3. CORNER & EDGE POINTS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 180,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Stack(
                  children: [
                    // The rect
                    Positioned(
                      left: 40,
                      top: 30,
                      width: 240,
                      height: 120,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF00695C),
                            width: 2,
                          ),
                          color: Color(0xFF00695C).withValues(alpha: 0.05),
                        ),
                      ),
                    ),
                    // Corners
                    _cornerDot(40, 30, 'TL', Color(0xFF1565C0)),
                    _cornerDot(280, 30, 'TR', Color(0xFF6A1B9A)),
                    _cornerDot(40, 150, 'BL', Color(0xFFE65100)),
                    _cornerDot(280, 150, 'BR', Color(0xFFC62828)),
                    // Edge centers
                    _cornerDot(160, 30, 'TC', Color(0xFF00838F)),
                    _cornerDot(160, 150, 'BC', Color(0xFF00838F)),
                    _cornerDot(40, 90, 'CL', Color(0xFF2E7D32)),
                    _cornerDot(280, 90, 'CR', Color(0xFF2E7D32)),
                    // Center
                    _cornerDot(160, 90, 'C', Color(0xFFFF6F00)),
                  ],
                ),
              ),

              // ── Demo 4: Shift & Translate ──
              _sectionTitle('4. SHIFT & TRANSLATE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 170,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Stack(
                  children: [
                    _rectBox(
                      r.left * 0.8,
                      r.top * 0.8,
                      r.width * 0.8,
                      r.height * 0.8,
                      'original',
                      Color(0xFF1565C0),
                    ),
                    _rectBox(
                      shifted.left * 0.8,
                      shifted.top * 0.8,
                      shifted.width * 0.8,
                      shifted.height * 0.8,
                      'shifted',
                      Color(0xFF6A1B9A),
                    ),
                    _rectBox(
                      translated.left * 0.8,
                      translated.top * 0.8,
                      translated.width * 0.8,
                      translated.height * 0.8,
                      'translated',
                      Color(0xFF2E7D32),
                    ),
                  ],
                ),
              ),

              // ── Demo 5: Inflate & Deflate ──
              _sectionTitle('5. INFLATE & DEFLATE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 170,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Stack(
                  children: [
                    _rectBox(
                      inflated.left * 0.5 + 20,
                      inflated.top * 0.5 + 10,
                      inflated.width * 0.5,
                      inflated.height * 0.5,
                      'inflated',
                      Color(0xFFC62828).withValues(alpha: 0.3),
                    ),
                    _rectBox(
                      r.left * 0.5 + 20,
                      r.top * 0.5 + 10,
                      r.width * 0.5,
                      r.height * 0.5,
                      'original',
                      Color(0xFF1565C0),
                    ),
                    _rectBox(
                      deflated.left * 0.5 + 20,
                      deflated.top * 0.5 + 10,
                      deflated.width * 0.5,
                      deflated.height * 0.5,
                      'deflated',
                      Color(0xFF2E7D32),
                    ),
                  ],
                ),
              ),

              // ── Demo 6: Intersect & Union ──
              _sectionTitle('6. INTERSECT & EXPAND'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 180,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Stack(
                  children: [
                    _rectBox(
                      r.left * 0.5,
                      r.top * 0.5 + 10,
                      r.width * 0.5,
                      r.height * 0.5,
                      'rect1',
                      Color(0xFF1565C0).withValues(alpha: 0.3),
                    ),
                    _rectBox(
                      r2.left * 0.5,
                      r2.top * 0.5 + 10,
                      r2.width * 0.5,
                      r2.height * 0.5,
                      'rect2',
                      Color(0xFF6A1B9A).withValues(alpha: 0.3),
                    ),
                    _rectBox(
                      intersection.left * 0.5,
                      intersection.top * 0.5 + 10,
                      intersection.width * 0.5,
                      intersection.height * 0.5,
                      'intersect',
                      Color(0xFFE65100),
                    ),
                    Positioned(
                      left: 10,
                      top: 150,
                      child: Text(
                        'overlaps: ${r.overlaps(r2)} | intersection: ${intersection.width.toStringAsFixed(0)}x${intersection.height.toStringAsFixed(0)}',
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 7: Contains ──
              _sectionTitle('7. CONTAINS POINT'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 140,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      left: 30,
                      top: 20,
                      width: 200,
                      height: 90,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Color(0xFF00695C),
                            width: 2,
                          ),
                          color: Color(0xFF00695C).withValues(alpha: 0.08),
                        ),
                      ),
                    ),
                    // Inside point
                    _pointDot(100, 60, true, 'inside'),
                    // Outside point
                    _pointDot(260, 120, false, 'outside'),
                  ],
                ),
              ),

              // ── Demo 8: Lerp ──
              _sectionTitle('8. RECT.LERP'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 120,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Stack(
                  children: [
                    _rectBox(
                      r.left * 0.4,
                      r.top * 0.4 + 5,
                      r.width * 0.4,
                      r.height * 0.4,
                      't=0',
                      Color(0xFF1565C0).withValues(alpha: 0.4),
                    ),
                    if (lerpResult != null)
                      _rectBox(
                        lerpResult.left * 0.4,
                        lerpResult.top * 0.4 + 5,
                        lerpResult.width * 0.4,
                        lerpResult.height * 0.4,
                        't=0.5',
                        Color(0xFF6A1B9A),
                      ),
                    _rectBox(
                      r2.left * 0.4,
                      r2.top * 0.4 + 5,
                      r2.width * 0.4,
                      r2.height * 0.4,
                      't=1',
                      Color(0xFFC62828).withValues(alpha: 0.4),
                    ),
                  ],
                ),
              ),

              // ── Demo 9: Equality ──
              _sectionTitle('9. EQUALITY'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _equalityRow(
                      'fromLTWH == fromLTRB (same)',
                      eq1 == eq2,
                      true,
                    ),
                    SizedBox(height: 8),
                    _equalityRow('different height', eq1 == eq3, false),
                  ],
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    ),
  );
}

// ─── HELPERS ────────────────────────────────────────────────────────────────

Widget _sectionTitle(String title) {
  return Padding(
    padding: EdgeInsets.fromLTRB(16, 20, 16, 8),
    child: Text(
      title,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: Color(0xFF455A64),
        letterSpacing: 1.0,
      ),
    ),
  );
}

Widget _rectWidget(Rect rect, String label, Color color) {
  return Positioned(
    left: rect.left,
    top: rect.top,
    child: Container(
      width: rect.width.clamp(20.0, 300.0),
      height: rect.height.clamp(20.0, 200.0),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        color: color.withValues(alpha: 0.1),
      ),
      child: Padding(
        padding: EdgeInsets.all(4),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget _propRow(String label, String value, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Container(
          width: 120,
          child: Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ),
      ],
    ),
  );
}

Widget _cornerDot(double x, double y, String label, Color color) {
  return Positioned(
    left: x - 12,
    top: y - 12,
    child: Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 2),
      ),
      child: Center(
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 8,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget _rectBox(
  double x,
  double y,
  double w,
  double h,
  String label,
  Color color,
) {
  return Positioned(
    left: x,
    top: y,
    child: Container(
      width: w.clamp(10.0, 250.0),
      height: h.clamp(10.0, 150.0),
      decoration: BoxDecoration(
        border: Border.all(color: color, width: 2),
        color: color.withValues(alpha: 0.15),
      ),
      child: Padding(
        padding: EdgeInsets.all(2),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 9,
            color: color,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
  );
}

Widget _pointDot(double x, double y, bool inside, String label) {
  final color = inside ? Color(0xFF2E7D32) : Color(0xFFC62828);
  return Positioned(
    left: x - 10,
    top: y - 10,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 4),
            ],
          ),
          child: Center(
            child: Icon(
              inside ? Icons.check : Icons.close,
              size: 12,
              color: Colors.white,
            ),
          ),
        ),
        Text(label, style: TextStyle(fontSize: 9, color: color)),
      ],
    ),
  );
}

Widget _equalityRow(String label, bool result, bool expected) {
  return Row(
    children: [
      Icon(
        result == expected ? Icons.check_circle : Icons.cancel,
        color: result == expected ? Colors.green : Colors.red,
        size: 20,
      ),
      SizedBox(width: 8),
      Expanded(
        child: Text(
          label,
          style: TextStyle(fontSize: 12, fontFamily: 'monospace'),
        ),
      ),
      Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: result ? Color(0xFFE8F5E9) : Color(0xFFFFEBEE),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          '$result',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: result ? Color(0xFF2E7D32) : Color(0xFFC62828),
          ),
        ),
      ),
    ],
  );
}
