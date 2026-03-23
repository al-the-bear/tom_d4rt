// ignore_for_file: avoid_print
// D4rt test script: Deep Demo for Size from dart:ui
// Size represents 2D dimensions (width × height) — fundamental for layout
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Size Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: CONSTRUCTORS
  // ═══════════════════════════════════════════════════════════════════════════

  final basic = Size(200.0, 100.0);
  print('Size(200, 100): width=${basic.width}, height=${basic.height}');

  final square = Size.square(80.0);
  print('Size.square(80): $square');

  final fromW = Size.fromWidth(150.0);
  print('Size.fromWidth(150): $fromW — height=${fromW.height}');

  final fromH = Size.fromHeight(90.0);
  print('Size.fromHeight(90): $fromH — width=${fromH.width}');

  final fromR = Size.fromRadius(50.0);
  print('Size.fromRadius(50): $fromR — creates ${fromR.width}×${fromR.height}');

  final zero = Size.zero;
  print('Size.zero: $zero');

  final infinite = Size.infinite;
  print('Size.infinite: $infinite');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: PROPERTIES
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Properties of Size(200, 100) ---');
  print('aspectRatio: ${basic.aspectRatio}');
  print('flipped: ${basic.flipped}');
  print('shortestSide: ${basic.shortestSide}');
  print('longestSide: ${basic.longestSide}');
  print('isEmpty: ${basic.isEmpty}');
  print('isFinite: ${basic.isFinite}');
  print('isInfinite: ${basic.isInfinite}');

  print('Size.zero isEmpty: ${zero.isEmpty}');
  print('Size.infinite isInfinite: ${infinite.isInfinite}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: ARITHMETIC OPERATIONS
  // ═══════════════════════════════════════════════════════════════════════════

  final s1 = Size(100.0, 60.0);
  final s2 = Size(50.0, 30.0);

  final sub = s1 - s2;
  print('\ns1 - s2: $sub (returns Offset)');

  final mulS = s1 * 1.5;
  print('s1 * 1.5: $mulS');

  final divS = s1 / 2.0;
  print('s1 / 2: $divS');

  final intDiv = s1 ~/ 3;
  print('s1 ~/ 3: $intDiv');

  final modS = s1 % 30;
  print('s1 % 30: $modS');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: CONTAINS
  // ═══════════════════════════════════════════════════════════════════════════

  print('\n--- Contains check for Size(100, 60) ---');
  print('contains(50,30): ${s1.contains(Offset(50.0, 30.0))}');
  print('contains(100,60): ${s1.contains(Offset(100.0, 60.0))}');
  print('contains(150,30): ${s1.contains(Offset(150.0, 30.0))}');
  print('contains(0,0): ${s1.contains(Offset.zero)}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: OFFSET & OPERATOR
  // ═══════════════════════════════════════════════════════════════════════════

  final rect = Offset(10, 20) & s1;
  print('\nOffset(10,20) & Size(100,60): $rect');
  print('topLeft: ${rect.topLeft}, bottomRight: ${rect.bottomRight}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 6: ASPECT RATIOS
  // ═══════════════════════════════════════════════════════════════════════════

  final aspects = <String, Size>{
    'Square 1:1': Size.square(100),
    'Wide 16:9': Size(160, 90),
    'Portrait 9:16': Size(90, 160),
    'Ultra Wide 21:9': Size(210, 90),
    'Golden ratio': Size(161.8, 100),
    'A4 Paper': Size(210, 297),
  };

  print('\n--- Aspect Ratios ---');
  for (final e in aspects.entries) {
    print('${e.key}: ${e.value.aspectRatio.toStringAsFixed(3)}');
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 7: EQUALITY
  // ═══════════════════════════════════════════════════════════════════════════

  final sa = Size(100, 50);
  final sb = Size(100, 50);
  final sc = Size(50, 100);
  print('\nEquality: Size(100,50) == Size(100,50): ${sa == sb}');
  print('Equality: Size(100,50) == Size(50,100): ${sa == sc}');
  print('Flipped equals swapped: ${sc == sa.flipped}');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL HELPERS
  // ═══════════════════════════════════════════════════════════════════════════

  Widget sizeBox(String label, Size sz, Color color, {double scale = 0.45}) {
    final w = sz.width.isFinite ? sz.width * scale : 80.0;
    final h = sz.height.isFinite ? sz.height * scale : 80.0;
    return Container(
      margin: EdgeInsets.all(4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: w.clamp(20.0, 120.0),
            height: h.clamp(20.0, 80.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.25),
              border: Border.all(color: color, width: 2),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Center(
              child: Text(
                '${sz.width.isFinite ? sz.width.toInt() : "∞"}×${sz.height.isFinite ? sz.height.toInt() : "∞"}',
                style: TextStyle(
                  fontSize: 9,
                  color: color,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: 3),
          Text(label, style: TextStyle(fontSize: 9)),
        ],
      ),
    );
  }

  Widget propRow(String label, String value, {Color? badge}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(fontSize: 11))),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 6, vertical: 1),
            decoration: badge != null
                ? BoxDecoration(
                    color: badge.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(4),
                  )
                : null,
            child: Text(
              value,
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: badge ?? Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget arithRow(String op, String result, Color color) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 2),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Text(op, style: TextStyle(fontWeight: FontWeight.w500, fontSize: 11)),
          Spacer(),
          Text(
            result,
            style: TextStyle(
              fontSize: 11,
              color: color,
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  Widget aspectBar(String label, Size sz, Color color) {
    final maxW = 160.0;
    final bigger = sz.width > sz.height ? sz.width : sz.height;
    final scale = maxW / bigger;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          SizedBox(
            width: 85,
            child: Text(label, style: TextStyle(fontSize: 10)),
          ),
          Container(
            width: (sz.width * scale * 0.6).clamp(10.0, 120.0),
            height: (sz.height * scale * 0.6).clamp(8.0, 50.0),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.3),
              border: Border.all(color: color, width: 1.5),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          SizedBox(width: 6),
          Text(
            sz.aspectRatio.toStringAsFixed(3),
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey[600],
              fontFamily: 'monospace',
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // FLIPPED DEMO
  // ═══════════════════════════════════════════════════════════════════════════

  Widget flippedDemo() {
    final orig = Size(160, 80);
    final flip = orig.flipped;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: orig.width * 0.5,
              height: orig.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.25),
                border: Border.all(color: Colors.blue, width: 2),
              ),
              child: Center(
                child: Text(
                  '${orig.width.toInt()}×${orig.height.toInt()}',
                  style: TextStyle(fontSize: 10, color: Colors.blue),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text('original', style: TextStyle(fontSize: 10)),
          ],
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.swap_horiz, color: Colors.grey),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: flip.width * 0.5,
              height: flip.height * 0.5,
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.25),
                border: Border.all(color: Colors.orange, width: 2),
              ),
              child: Center(
                child: Text(
                  '${flip.width.toInt()}×${flip.height.toInt()}',
                  style: TextStyle(fontSize: 10, color: Colors.orange),
                ),
              ),
            ),
            SizedBox(height: 4),
            Text('.flipped', style: TextStyle(fontSize: 10)),
          ],
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // CONTAINS VISUAL
  // ═══════════════════════════════════════════════════════════════════════════

  Widget containsDemo() {
    final testSize = Size(120, 80);
    final points = <MapEntry<Offset, bool>>[
      MapEntry(Offset(30, 20), true),
      MapEntry(Offset(60, 40), true),
      MapEntry(Offset(0, 0), true),
      MapEntry(Offset(150, 50), false),
      MapEntry(Offset(60, 100), false),
      MapEntry(Offset(-10, 30), false),
    ];
    return Container(
      width: 200,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 10,
            top: 10,
            child: Container(
              width: testSize.width,
              height: testSize.height,
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.1),
                border: Border.all(color: Colors.blue, width: 1.5),
              ),
              child: Center(
                child: Text(
                  '120×80',
                  style: TextStyle(fontSize: 10, color: Colors.blue[300]),
                ),
              ),
            ),
          ),
          for (final p in points)
            Positioned(
              left: 10 + p.key.dx - 4,
              top: 10 + p.key.dy - 4,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: p.value ? Colors.green : Colors.red,
                  border: Border.all(color: Colors.white, width: 1),
                ),
              ),
            ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // OFFSET & SIZE → RECT DEMO
  // ═══════════════════════════════════════════════════════════════════════════

  Widget rectFromSizeDemo() {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.indigo[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Offset(10,20) & Size(100,60)',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
          SizedBox(height: 4),
          Text(
            '= $rect',
            style: TextStyle(fontFamily: 'monospace', fontSize: 11),
          ),
          SizedBox(height: 8),
          Container(
            width: 160,
            height: 100,
            color: Colors.grey[100],
            child: Stack(
              children: [
                Positioned(
                  left: 10,
                  top: 20,
                  child: Container(
                    width: 100,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.indigo.withValues(alpha: 0.3),
                      border: Border.all(color: Colors.indigo, width: 2),
                    ),
                    child: Center(
                      child: Text(
                        '100×60',
                        style: TextStyle(fontSize: 10, color: Colors.indigo),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 16,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.red,
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 2,
                  child: Text(
                    '(10,20)',
                    style: TextStyle(fontSize: 8, color: Colors.red),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD LAYOUT
  // ═══════════════════════════════════════════════════════════════════════════

  final aspectColors = [
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.red,
    Colors.teal,
  ];

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title banner
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [Colors.teal, Colors.cyan]),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.crop_square, color: Colors.white, size: 36),
              SizedBox(height: 8),
              Text(
                'Size Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Width × Height — the foundation of layout',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // Section 1: Constructors
        Text(
          '1. Constructors',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 4,
          runSpacing: 4,
          children: [
            sizeBox('Size(200,100)', basic, Colors.blue),
            sizeBox('square(80)', square, Colors.green),
            sizeBox('fromWidth(150)', fromW, Colors.orange),
            sizeBox('fromHeight(90)', fromH, Colors.purple),
            sizeBox('fromRadius(50)', fromR, Colors.red),
            sizeBox('zero', zero, Colors.grey),
          ],
        ),
        SizedBox(height: 16),

        // Section 2: Properties
        Text(
          '2. Properties',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                propRow('width', '${basic.width}'),
                propRow('height', '${basic.height}'),
                propRow('aspectRatio', '${basic.aspectRatio}'),
                propRow('shortestSide', '${basic.shortestSide}'),
                propRow('longestSide', '${basic.longestSide}'),
                Divider(),
                propRow(
                  'isEmpty (zero)',
                  '${zero.isEmpty}',
                  badge: Colors.orange,
                ),
                propRow(
                  'isEmpty (basic)',
                  '${basic.isEmpty}',
                  badge: Colors.green,
                ),
                propRow('isFinite', '${basic.isFinite}', badge: Colors.green),
                propRow(
                  'isInfinite',
                  '${infinite.isInfinite}',
                  badge: Colors.red,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // Section 3: Aspect Ratios
        Text(
          '3. Aspect Ratios',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        ...aspects.entries.toList().asMap().entries.map(
          (e) => aspectBar(
            e.value.key,
            e.value.value,
            aspectColors[e.key % aspectColors.length],
          ),
        ),
        SizedBox(height: 16),

        // Section 4: Flipped
        Text(
          '4. Flipped (swap width ↔ height)',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        flippedDemo(),
        SizedBox(height: 16),

        // Section 5: Contains
        Text(
          '5. Contains Check',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(
          'Green = inside, Red = outside',
          style: TextStyle(fontSize: 11, color: Colors.grey[600]),
        ),
        SizedBox(height: 8),
        Center(child: containsDemo()),
        SizedBox(height: 16),

        // Section 6: Arithmetic
        Text(
          '6. Arithmetic Operations',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        arithRow('Size(100,60) * 1.5', '$mulS', Colors.blue),
        arithRow('Size(100,60) / 2', '$divS', Colors.green),
        arithRow('Size(100,60) ~/ 3', '$intDiv', Colors.orange),
        arithRow('Size(100,60) % 30', '$modS', Colors.purple),
        arithRow('Size(100,60) - Size(50,30)', '$sub', Colors.red),
        SizedBox(height: 16),

        // Section 7: Equality
        Text(
          '7. Equality',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Card(
          child: Padding(
            padding: EdgeInsets.all(12),
            child: Column(
              children: [
                propRow(
                  'Size(100,50) == Size(100,50)',
                  '${sa == sb}',
                  badge: Colors.green,
                ),
                propRow(
                  'Size(100,50) == Size(50,100)',
                  '${sa == sc}',
                  badge: Colors.red,
                ),
                propRow(
                  'flipped == swapped',
                  '${sc == sa.flipped}',
                  badge: Colors.green,
                ),
                propRow(
                  'hashCode match',
                  '${sa.hashCode == sb.hashCode}',
                  badge: Colors.green,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // Section 8: Offset & Size → Rect
        Text(
          '8. Offset & Size → Rect',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        rectFromSizeDemo(),
        SizedBox(height: 24),
      ],
    ),
  );
}
