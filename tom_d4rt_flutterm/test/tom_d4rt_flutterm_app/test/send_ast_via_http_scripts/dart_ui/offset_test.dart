// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for Offset from dart:ui
// Offset represents a 2D displacement with dx (horizontal) and dy (vertical)
// Used extensively for positioning, touch events, and animations
import 'dart:math' as math;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Offset Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CONSTRUCTORS
  // ═══════════════════════════════════════════════════════════════════════════

  final basic = Offset(100.0, 200.0);
  print('Offset(100, 200): dx=${basic.dx}, dy=${basic.dy}');

  final zero = Offset.zero;
  print('Offset.zero: $zero');

  final infinite = Offset.infinite;
  print('Offset.infinite: $infinite');

  // fromDirection creates from angle + optional distance
  final fromDir = Offset.fromDirection(math.pi / 4, 100.0);
  print(
    'fromDirection(pi/4, 100): dx=${fromDir.dx.toStringAsFixed(2)}, dy=${fromDir.dy.toStringAsFixed(2)}',
  );

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  final p = Offset(30.0, 40.0);
  print('dx=${p.dx}, dy=${p.dy}');
  print('distance=${p.distance}');
  print('distanceSquared=${p.distanceSquared}');
  print('direction=${p.direction.toStringAsFixed(4)}');
  print('isFinite=${p.isFinite}');
  print('isInfinite=${infinite.isInfinite}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ARITHMETIC OPERATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  final a = Offset(60.0, 80.0);
  final b = Offset(20.0, 30.0);

  final sum = a + b;
  print('$a + $b = $sum');

  final diff = a - b;
  print('$a - $b = $diff');

  final neg = -a;
  print('-$a = $neg');

  final scaled = a * 1.5;
  print('$a * 1.5 = $scaled');

  final divided = a / 2.0;
  print('$a / 2.0 = $divided');

  final truncDiv = a ~/ 3;
  print('$a ~/ 3 = $truncDiv');

  final modulo = a % 25.0;
  print('$a %% 25.0 = $modulo');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: METHODS
  // ═══════════════════════════════════════════════════════════════════════════

  final scaleResult = a.scale(2.0, 0.5);
  print('scale(2.0, 0.5): $scaleResult');

  final translateResult = a.translate(10.0, -10.0);
  print('translate(10, -10): $translateResult');

  // Lerp between two offsets
  final lerpResult = Offset.lerp(Offset.zero, Offset(200.0, 100.0), 0.5);
  print('lerp(zero, (200,100), 0.5): $lerpResult');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: DISTANCE & DIRECTION
  // ═══════════════════════════════════════════════════════════════════════════

  // Build 8 offsets around a circle (compass directions)
  final compassOffsets = <String, Offset>{};
  final directions = ['N', 'NE', 'E', 'SE', 'S', 'SW', 'W', 'NW'];
  for (var i = 0; i < 8; i++) {
    final angle = -math.pi / 2 + (i * math.pi / 4);
    compassOffsets[directions[i]] = Offset.fromDirection(angle, 60.0);
  }
  for (final entry in compassOffsets.entries) {
    print(
      '${entry.key}: dx=${entry.value.dx.toStringAsFixed(1)}, dy=${entry.value.dy.toStringAsFixed(1)}',
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: EQUALITY & HASHCODE
  // ═══════════════════════════════════════════════════════════════════════════

  final eq1 = Offset(10.0, 20.0);
  final eq2 = Offset(10.0, 20.0);
  final eq3 = Offset(10.0, 30.0);
  print('eq1 == eq2: ${eq1 == eq2}');
  print('eq1 == eq3: ${eq1 == eq3}');
  print('hashCode match: ${eq1.hashCode == eq2.hashCode}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: LERP ANIMATION DEMO DATA
  // ═══════════════════════════════════════════════════════════════════════════

  final lerpSteps = <double>[0.0, 0.2, 0.4, 0.6, 0.8, 1.0];
  final startOffset = Offset(20.0, 20.0);
  final endOffset = Offset(250.0, 100.0);
  final lerpPoints = lerpSteps
      .map((t) => Offset.lerp(startOffset, endOffset, t)!)
      .toList();
  for (var i = 0; i < lerpSteps.length; i++) {
    print('lerp t=${lerpSteps[i]}: ${lerpPoints[i]}');
  }

  print('truncDiv: $truncDiv, modulo: $modulo');
  print('zero: $zero');

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
                    colors: [Color(0xFF0D47A1), Color(0xFF42A5F5)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: Offset(0, 6),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    Icon(Icons.control_camera, size: 48, color: Colors.white),
                    SizedBox(height: 12),
                    Text(
                      'Offset Deep Demo',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 6),
                    Text(
                      '2D displacement: dx & dy',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 1: Offset Positioning ──
              _sectionTitle('1. OFFSET POSITIONING'),
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
                    // Grid lines for reference
                    ..._buildGridLines(200),
                    // Origin marker
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            'O',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    // Offset point
                    Positioned(
                      left: basic.dx,
                      top: basic.dy * 0.8,
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Color(0xFF1565C0),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '(${basic.dx.toInt()}, ${basic.dy.toInt()})',
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                    ),
                    // Zero offset
                    Positioned(
                      left: 25,
                      top: 5,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          'zero',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                    // fromDirection point
                    Positioned(
                      left: 80 + fromDir.dx * 0.5,
                      top: 80 + fromDir.dy * 0.5,
                      child: Container(
                        padding: EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'fromDir',
                          style: TextStyle(color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Red = origin, Blue = Offset(100, 200), Green = fromDirection(pi/4, 100)',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),

              // ── Demo 2: Arithmetic Operations ──
              _sectionTitle('2. ARITHMETIC OPERATIONS'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _operationRow('A', a, Color(0xFF1565C0)),
                    _operationRow('B', b, Color(0xFF00838F)),
                    Divider(),
                    _operationRow('A + B', sum, Color(0xFF2E7D32)),
                    _operationRow('A - B', diff, Color(0xFFE65100)),
                    _operationRow('-A', neg, Color(0xFFC62828)),
                    _operationRow('A x 1.5', scaled, Color(0xFF6A1B9A)),
                    _operationRow('A / 2', divided, Color(0xFF00695C)),
                  ],
                ),
              ),

              // ── Demo 3: Visual Offset Arithmetic ──
              _sectionTitle('3. VISUAL ADD & SUBTRACT'),
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
                    // Vector A (blue arrow)
                    Positioned(
                      left: 10,
                      top: 80,
                      child: Container(
                        width: a.dx,
                        height: 4,
                        color: Color(0xFF1565C0),
                      ),
                    ),
                    Positioned(
                      left: 10 + a.dx + 4,
                      top: 74,
                      child: Text(
                        'A',
                        style: TextStyle(
                          color: Color(0xFF1565C0),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    // Vector B (teal arrow)
                    Positioned(
                      left: 10 + a.dx,
                      top: 80,
                      child: Container(
                        width: b.dx,
                        height: 4,
                        color: Color(0xFF00838F),
                      ),
                    ),
                    Positioned(
                      left: 10 + a.dx + b.dx + 4,
                      top: 74,
                      child: Text(
                        'B',
                        style: TextStyle(
                          color: Color(0xFF00838F),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    // Result A+B (green)
                    Positioned(
                      left: 10,
                      top: 100,
                      child: Container(
                        width: sum.dx,
                        height: 4,
                        color: Color(0xFF2E7D32),
                      ),
                    ),
                    Positioned(
                      left: 10 + sum.dx + 4,
                      top: 94,
                      child: Text(
                        'A+B',
                        style: TextStyle(
                          color: Color(0xFF2E7D32),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    // Labels
                    Positioned(
                      left: 10,
                      top: 10,
                      child: Text(
                        'Vector Addition: A(${a.dx},${a.dy}) + B(${b.dx},${b.dy}) = (${sum.dx},${sum.dy})',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    // Difference bar (orange)
                    Positioned(
                      left: 10,
                      top: 130,
                      child: Container(
                        width: diff.dx,
                        height: 4,
                        color: Color(0xFFE65100),
                      ),
                    ),
                    Positioned(
                      left: 10 + diff.dx + 4,
                      top: 124,
                      child: Text(
                        'A-B',
                        style: TextStyle(
                          color: Color(0xFFE65100),
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 155,
                      child: Text(
                        'Subtraction: A - B = (${diff.dx}, ${diff.dy})',
                        style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 4: Compass Directions ──
              _sectionTitle('4. OFFSET.FROMDIRECTION'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 220,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Stack(
                  children: [
                    // Center point
                    Positioned(
                      left: 160 - 6,
                      top: 110 - 6,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    // Compass direction dots
                    ...compassOffsets.entries.map((entry) {
                      final cx = 160.0 + entry.value.dx;
                      final cy = 110.0 + entry.value.dy;
                      final hue =
                          (compassOffsets.keys.toList().indexOf(entry.key) *
                          45.0);
                      return Positioned(
                        left: cx - 16,
                        top: cy - 16,
                        child: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: HSVColor.fromAHSV(
                              1.0,
                              hue,
                              0.7,
                              0.9,
                            ).toColor(),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 3,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                          child: Center(
                            child: Text(
                              entry.key,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 4),
                child: Text(
                  'Each dot placed using Offset.fromDirection(angle, 60)',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                ),
              ),

              // ── Demo 5: Lerp Visualization ──
              _sectionTitle('5. OFFSET.LERP INTERPOLATION'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                height: 160,
                decoration: BoxDecoration(
                  color: Color(0xFFFAFAFA),
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(color: Color(0xFFE0E0E0)),
                ),
                child: Stack(
                  children: [
                    // Start-end line
                    Positioned(
                      left: startOffset.dx,
                      top: startOffset.dy + 40,
                      child: Container(
                        width: endOffset.dx - startOffset.dx,
                        height: 2,
                        color: Colors.grey[300],
                      ),
                    ),
                    // Lerp points
                    ...lerpPoints.asMap().entries.map((entry) {
                      final i = entry.key;
                      final pt = entry.value;
                      final t = lerpSteps[i];
                      return Positioned(
                        left: pt.dx - 12,
                        top: pt.dy + 28,
                        child: Column(
                          children: [
                            Container(
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: Color.lerp(
                                  Color(0xFF1565C0),
                                  Color(0xFFC62828),
                                  t,
                                ),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              't=${t.toStringAsFixed(1)}',
                              style: TextStyle(
                                fontSize: 9,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                    Positioned(
                      left: 10,
                      top: 120,
                      child: Text(
                        'Interpolation from (${startOffset.dx.toInt()},${startOffset.dy.toInt()}) to (${endOffset.dx.toInt()},${endOffset.dy.toInt()})',
                        style: TextStyle(fontSize: 11, color: Colors.grey[700]),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 6: Distance & Direction ──
              _sectionTitle('6. DISTANCE & DIRECTION'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _propertyTile(
                      Icons.straighten,
                      'distance',
                      '${p.distance.toStringAsFixed(2)}',
                      'sqrt(dx^2 + dy^2) = sqrt(${p.dx}^2 + ${p.dy}^2)',
                      Color(0xFF1565C0),
                    ),
                    Divider(height: 1),
                    _propertyTile(
                      Icons.crop_square,
                      'distanceSquared',
                      '${p.distanceSquared.toStringAsFixed(0)}',
                      'dx^2 + dy^2 (no sqrt)',
                      Color(0xFF00838F),
                    ),
                    Divider(height: 1),
                    _propertyTile(
                      Icons.explore,
                      'direction',
                      '${p.direction.toStringAsFixed(4)} rad',
                      'atan2(dy, dx) in radians',
                      Color(0xFF6A1B9A),
                    ),
                    Divider(height: 1),
                    _propertyTile(
                      Icons.check_circle,
                      'isFinite',
                      '${p.isFinite}',
                      'Both dx and dy are finite',
                      Color(0xFF2E7D32),
                    ),
                  ],
                ),
              ),

              // ── Demo 7: Scale & Translate ──
              _sectionTitle('7. SCALE & TRANSLATE'),
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
                    _offsetDot(
                      a.dx * 0.5,
                      a.dy * 0.5,
                      'original',
                      Color(0xFF1565C0),
                    ),
                    _offsetDot(
                      scaleResult.dx * 0.5,
                      scaleResult.dy * 0.25,
                      'scale(2,0.5)',
                      Color(0xFF6A1B9A),
                    ),
                    _offsetDot(
                      translateResult.dx * 0.5,
                      translateResult.dy * 0.5,
                      'translate(10,-10)',
                      Color(0xFF2E7D32),
                    ),
                    Positioned(
                      left: 10,
                      top: 155,
                      child: Text(
                        'Original: (${a.dx},${a.dy})  ->  scale(2,0.5): $scaleResult  ->  translate(10,-10): $translateResult',
                        style: TextStyle(fontSize: 10, color: Colors.grey[600]),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Demo 8: Equality ──
              _sectionTitle('8. EQUALITY & HASHCODE'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Column(
                  children: [
                    _equalityRow('(10, 20) == (10, 20)', eq1 == eq2, true),
                    SizedBox(height: 8),
                    _equalityRow('(10, 20) == (10, 30)', eq1 == eq3, false),
                    SizedBox(height: 8),
                    _equalityRow(
                      'hashCode match',
                      eq1.hashCode == eq2.hashCode,
                      true,
                    ),
                  ],
                ),
              ),

              // ── Demo 9: Special Values ──
              _sectionTitle('9. SPECIAL VALUES'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _specialValueCard(
                        'Offset.zero',
                        '(0.0, 0.0)',
                        Icons.gps_fixed,
                        Color(0xFF00838F),
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: _specialValueCard(
                        'Offset.infinite',
                        '(inf, inf)',
                        Icons.all_inclusive,
                        Color(0xFFC62828),
                      ),
                    ),
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

Widget _operationRow(String label, Offset offset, Color color) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 6),
    child: Row(
      children: [
        SizedBox(
          width: 50,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              color: color,
            ),
          ),
        ),
        SizedBox(width: 8),
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        SizedBox(width: 8),
        Text(
          'dx=${offset.dx.toStringAsFixed(1)}, dy=${offset.dy.toStringAsFixed(1)}',
          style: TextStyle(fontSize: 13, fontFamily: 'monospace'),
        ),
        Spacer(),
        Container(
          width: (offset.dx.abs() / 2).clamp(4.0, 100.0),
          height: 8,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.4),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ],
    ),
  );
}

Widget _propertyTile(
  IconData icon,
  String name,
  String value,
  String description,
  Color color,
) {
  return ListTile(
    leading: Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Icon(icon, color: color, size: 22),
    ),
    title: Row(
      children: [
        Text(name, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
        Spacer(),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 14,
            color: color,
          ),
        ),
      ],
    ),
    subtitle: Text(description, style: TextStyle(fontSize: 11)),
  );
}

Widget _offsetDot(double x, double y, String label, Color color) {
  return Positioned(
    left: x,
    top: y,
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22,
          height: 22,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color.withValues(alpha: 0.4), blurRadius: 6),
            ],
          ),
        ),
        SizedBox(height: 2),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(label, style: TextStyle(fontSize: 9, color: color)),
        ),
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
      Text(label, style: TextStyle(fontSize: 13, fontFamily: 'monospace')),
      Spacer(),
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

Widget _specialValueCard(
  String title,
  String value,
  IconData icon,
  Color color,
) {
  return Container(
    padding: EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: color.withValues(alpha: 0.25)),
    ),
    child: Column(
      children: [
        Icon(icon, size: 32, color: color),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: color,
          ),
        ),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 18, fontFamily: 'monospace')),
      ],
    ),
  );
}

List<Widget> _buildGridLines(double height) {
  final lines = <Widget>[];
  for (var x = 50.0; x < 320; x += 50) {
    lines.add(
      Positioned(
        left: x,
        top: 0,
        child: Container(width: 1, height: height, color: Color(0x15000000)),
      ),
    );
  }
  for (var y = 50.0; y < height; y += 50) {
    lines.add(
      Positioned(
        left: 0,
        top: y,
        child: Container(width: 320, height: 1, color: Color(0x15000000)),
      ),
    );
  }
  return lines;
}
