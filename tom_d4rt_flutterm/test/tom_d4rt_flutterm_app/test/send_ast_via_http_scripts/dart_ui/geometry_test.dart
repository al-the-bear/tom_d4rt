// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Deep Demo for geometry primitives from dart:ui
// Covers: Offset, Size, Rect, RRect, Radius — the core geometry building blocks
import 'dart:math' as math;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== Geometry Deep Demo ===');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 1: OFFSET — 2D displacement
  // ═══════════════════════════════════════════════════════════════════════════

  final o1 = Offset(30.0, 40.0);
  final o2 = Offset(60.0, 10.0);
  final oSum = o1 + o2;
  final oDiff = o1 - o2;
  final oScaled = o1 * 2.0;
  final oNeg = -o1;
  print('o1=$o1, distance=${o1.distance.toStringAsFixed(2)}');
  print('o1+o2=$oSum, o1-o2=$oDiff');
  print('o1*2=$oScaled, -o1=$oNeg');

  // Offset.fromDirection
  final angles = [0.0, math.pi / 6, math.pi / 4, math.pi / 3, math.pi / 2];
  for (final a in angles) {
    final od = Offset.fromDirection(a, 40.0);
    print(
      'angle=${(a * 180 / math.pi).toStringAsFixed(0)}°: dx=${od.dx.toStringAsFixed(1)}, dy=${od.dy.toStringAsFixed(1)}',
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 2: SIZE — width x height dimensions
  // ═══════════════════════════════════════════════════════════════════════════

  final s1 = Size(200.0, 100.0);
  final s2 = Size(80.0, 60.0);
  final sSquare = Size.square(50.0);
  final sFromWH = Size.fromWidth(120.0);
  final sFromH = Size.fromHeight(90.0);
  print('s1=$s1, aspectRatio=${s1.aspectRatio}');
  print('square=$sSquare, fromWidth=$sFromWH, fromHeight=$sFromH');
  print('s1.contains(Offset(50,50)): ${s1.contains(Offset(50.0, 50.0))}');
  print('flipped=${s1.flipped}');
  print('shortestSide=${s1.shortestSide}, longestSide=${s1.longestSide}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 3: RECT — axis-aligned rectangle
  // ═══════════════════════════════════════════════════════════════════════════

  final r1 = Rect.fromLTWH(10, 20, 150, 80);
  final r2 = Rect.fromLTRB(50, 30, 180, 100);
  final rCenter = Rect.fromCenter(
    center: Offset(100, 60),
    width: 120,
    height: 60,
  );
  final rCircle = Rect.fromCircle(center: Offset(100, 100), radius: 50);
  final rPoints = Rect.fromPoints(Offset(10, 20), Offset(100, 80));

  print('fromLTWH: $r1');
  print('fromLTRB: $r2');
  print('fromCenter: $rCenter');
  print('fromCircle: $rCircle');
  print('fromPoints: $rPoints');

  // Rect properties
  print('center=${r1.center}, size=${r1.size}');
  print('topLeft=${r1.topLeft}, bottomRight=${r1.bottomRight}');
  print('width=${r1.width}, height=${r1.height}');

  // Rect operations
  final rInflated = r1.inflate(10);
  final rDeflated = r1.deflate(5);
  final rShifted = r1.shift(Offset(20, 10));
  final rIntersect = r1.intersect(r2);
  final rExpand = r1.expandToInclude(r2);
  print('inflated=$rInflated');
  print('deflated=$rDeflated');
  print('shifted=$rShifted');
  print('intersect=$rIntersect');
  print('expandToInclude=$rExpand');
  print('contains(60,50): ${r1.contains(Offset(60, 50))}');
  print('overlaps r2: ${r1.overlaps(r2)}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 4: RADIUS — circular/elliptical corner radius
  // ═══════════════════════════════════════════════════════════════════════════

  final rad1 = Radius.circular(10.0);
  final rad2 = Radius.elliptical(20.0, 10.0);
  final radZero = Radius.zero;
  print('circular(10): $rad1, x=${rad1.x}, y=${rad1.y}');
  print('elliptical(20,10): $rad2');
  print('zero: $radZero');
  print('rad1 + rad2 = ${rad1 + rad2}');
  print('rad1 - rad2 = ${rad1 - rad2}');
  print('rad1 * 2 = ${rad1 * 2}');
  print('-rad1 = ${-rad1}');

  // ═══════════════════════════════════════════════════════════════════════════
  // SECTION 5: RRECT — rounded rectangle
  // ═══════════════════════════════════════════════════════════════════════════

  final rr1 = RRect.fromLTRBR(0, 0, 120, 80, Radius.circular(12));
  final rr2 = RRect.fromRectAndRadius(
    Rect.fromLTWH(0, 0, 120, 80),
    Radius.circular(20),
  );
  final rr3 = RRect.fromLTRBAndCorners(
    0,
    0,
    120,
    80,
    topLeft: Radius.circular(20),
    topRight: Radius.circular(5),
    bottomLeft: Radius.circular(5),
    bottomRight: Radius.circular(20),
  );
  final rrZero = RRect.zero;
  print('fromR: $rr1');
  print('fromRect: $rr2');
  print('corners: $rr3');
  print('zero: $rrZero');
  print('outerRect=${rr1.outerRect}');
  print('center=${rr1.center}');
  print('width=${rr1.width}, height=${rr1.height}');

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL — Offset directions as arrows
  // ═══════════════════════════════════════════════════════════════════════════

  Widget buildOffsetArrows() {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        children: [
          // Center point
          Positioned(
            left: 76,
            top: 76,
            child: Container(
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.black,
              ),
            ),
          ),
          // Arrow endpoints at various angles
          for (int i = 0; i < angles.length; i++)
            Positioned(
              left: 80 + Offset.fromDirection(angles[i], 55).dx - 5,
              top: 80 + Offset.fromDirection(angles[i], 55).dy - 5,
              child: Container(
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: [
                    Colors.red,
                    Colors.orange,
                    Colors.blue,
                    Colors.green,
                    Colors.purple,
                  ][i],
                ),
              ),
            ),
          // Labels
          Positioned(
            bottom: 4,
            left: 0,
            right: 0,
            child: Text(
              'Offset.fromDirection',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9, color: Colors.grey[600]),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL — Size comparisons
  // ═══════════════════════════════════════════════════════════════════════════

  Widget buildSizeBox(String label, Size sz, Color color) {
    return Column(
      children: [
        Container(
          width: sz.width * 0.5,
          height: sz.height * 0.5,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.3),
            border: Border.all(color: color, width: 1.5),
          ),
          child: Center(
            child: Text(
              '${sz.width.toInt()}×${sz.height.toInt()}',
              style: TextStyle(fontSize: 9, color: color),
            ),
          ),
        ),
        SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 9)),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL — Rect operations
  // ═══════════════════════════════════════════════════════════════════════════

  Widget buildRectDemo(String label, Rect rect, Color color, {Rect? overlay}) {
    return Container(
      width: 200,
      height: 120,
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Stack(
        children: [
          Positioned(
            left: rect.left * 0.8,
            top: rect.top * 0.8,
            child: Container(
              width: rect.width * 0.8,
              height: rect.height * 0.8,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.3),
                border: Border.all(color: color, width: 1.5),
              ),
            ),
          ),
          if (overlay != null)
            Positioned(
              left: overlay.left * 0.8,
              top: overlay.top * 0.8,
              child: Container(
                width: overlay.width * 0.8,
                height: overlay.height * 0.8,
                decoration: BoxDecoration(
                  color: Colors.red.withValues(alpha: 0.2),
                  border: Border.all(color: Colors.red, width: 1),
                ),
              ),
            ),
          Positioned(
            bottom: 2,
            left: 4,
            child: Text(
              label,
              style: TextStyle(fontSize: 9, color: Colors.grey[700]),
            ),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL — Rounded rectangle corner styles
  // ═══════════════════════════════════════════════════════════════════════════

  Widget buildRRectCard(String label, BorderRadius br, Color color) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 50,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.3),
            border: Border.all(color: color, width: 2),
            borderRadius: br,
          ),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 9), textAlign: TextAlign.center),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // VISUAL — Radius comparison: circular vs elliptical
  // ═══════════════════════════════════════════════════════════════════════════

  Widget buildRadiusViz(String label, Radius r, Color color) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 40,
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.3),
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.only(topLeft: r),
          ),
        ),
        SizedBox(height: 2),
        Text(label, style: TextStyle(fontSize: 9)),
        Text(
          'x=${r.x.toInt()},y=${r.y.toInt()}',
          style: TextStyle(fontSize: 8, color: Colors.grey),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  // BUILD VISUAL OUTPUT
  // ═══════════════════════════════════════════════════════════════════════════

  return SingleChildScrollView(
    padding: EdgeInsets.all(16),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.deepPurple, Colors.indigo],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(Icons.grid_on, color: Colors.white, size: 36),
              SizedBox(height: 8),
              Text(
                'Geometry Primitives Deep Demo',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Offset · Size · Rect · RRect · Radius',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ),
        SizedBox(height: 16),

        // ── OFFSET SECTION ──
        Text(
          '1. Offset — 2D Displacement',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildOffsetArrows(),
            SizedBox(width: 12),
            Expanded(
              child: Card(
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Arithmetic',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text('$o1 + $o2 = $oSum', style: TextStyle(fontSize: 11)),
                      Text(
                        '$o1 - $o2 = $oDiff',
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        '$o1 × 2 = $oScaled',
                        style: TextStyle(fontSize: 11),
                      ),
                      Text('−$o1 = $oNeg', style: TextStyle(fontSize: 11)),
                      Divider(),
                      Text(
                        'Properties',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        'distance: ${o1.distance.toStringAsFixed(1)}',
                        style: TextStyle(fontSize: 11),
                      ),
                      Text(
                        'direction: ${o1.direction.toStringAsFixed(3)} rad',
                        style: TextStyle(fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── SIZE SECTION ──
        Text(
          '2. Size — Width × Height',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            buildSizeBox('200×100', s1, Colors.blue),
            buildSizeBox('80×60', s2, Colors.green),
            buildSizeBox('50×50', sSquare, Colors.orange),
            buildSizeBox('120×∞', sFromWH, Colors.purple),
          ],
        ),
        SizedBox(height: 8),
        Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  's1 aspectRatio: ${s1.aspectRatio}',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  's1 flipped: ${s1.flipped}',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  'shortestSide: ${s1.shortestSide}, longestSide: ${s1.longestSide}',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  'contains(50,50): ${s1.contains(Offset(50, 50))}',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // ── RECT SECTION ──
        Text(
          '3. Rect — Axis-Aligned Rectangle',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        buildRectDemo('fromLTWH(10,20,150,80)', r1, Colors.blue),
        buildRectDemo('r1 ∩ r2 (overlap)', r1, Colors.blue, overlay: r2),
        buildRectDemo('inflate(10)', rInflated, Colors.green),
        buildRectDemo('shift(20,10)', rShifted, Colors.orange),
        SizedBox(height: 8),
        Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('center: ${r1.center}', style: TextStyle(fontSize: 11)),
                Text(
                  'topLeft: ${r1.topLeft}  bottomRight: ${r1.bottomRight}',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  'overlaps r2: ${r1.overlaps(r2)}',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  'contains(60,50): ${r1.contains(Offset(60, 50))}',
                  style: TextStyle(fontSize: 11),
                ),
                Text('intersect: $rIntersect', style: TextStyle(fontSize: 11)),
              ],
            ),
          ),
        ),
        SizedBox(height: 16),

        // ── RADIUS SECTION ──
        Text(
          '4. Radius — Corner Curvature',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            buildRadiusViz('circular(5)', Radius.circular(5), Colors.blue),
            buildRadiusViz('circular(15)', Radius.circular(15), Colors.green),
            buildRadiusViz('circular(25)', Radius.circular(25), Colors.orange),
            buildRadiusViz(
              'elliptical\n(25,10)',
              Radius.elliptical(25, 10),
              Colors.purple,
            ),
            buildRadiusViz(
              'elliptical\n(10,25)',
              Radius.elliptical(10, 25),
              Colors.red,
            ),
          ],
        ),
        SizedBox(height: 16),

        // ── RRECT SECTION ──
        Text(
          '5. RRect — Rounded Rectangles',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            buildRRectCard(
              'Uniform 12',
              BorderRadius.circular(12),
              Colors.blue,
            ),
            buildRRectCard(
              'Uniform 20',
              BorderRadius.circular(20),
              Colors.green,
            ),
            buildRRectCard(
              'Only TL/BR',
              BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              Colors.orange,
            ),
            buildRRectCard(
              'Only TR/BL',
              BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              Colors.purple,
            ),
            buildRRectCard(
              'Elliptical',
              BorderRadius.all(Radius.elliptical(30, 15)),
              Colors.red,
            ),
          ],
        ),
        SizedBox(height: 8),
        Card(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'rr1 outerRect: ${rr1.outerRect}',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  'rr1 center: ${rr1.center}',
                  style: TextStyle(fontSize: 11),
                ),
                Text(
                  'rr1 width: ${rr1.width}, height: ${rr1.height}',
                  style: TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 24),
      ],
    ),
  );
}
