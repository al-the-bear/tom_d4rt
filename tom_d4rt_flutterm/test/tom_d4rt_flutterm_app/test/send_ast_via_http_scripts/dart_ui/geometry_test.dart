// D4rt test script: Tests Rect, RRect, Path from dart:ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Dart:ui geometry test executing');

  // ========== RECT ==========
  print('--- Rect Tests ---');

  // Test Rect.fromLTWH
  final rectLTWH = Rect.fromLTWH(10.0, 20.0, 100.0, 80.0);
  print('Rect.fromLTWH(10, 20, 100, 80): $rectLTWH');
  print('  left: ${rectLTWH.left}');
  print('  top: ${rectLTWH.top}');
  print('  right: ${rectLTWH.right}');
  print('  bottom: ${rectLTWH.bottom}');
  print('  width: ${rectLTWH.width}');
  print('  height: ${rectLTWH.height}');

  // Test Rect.fromLTRB
  final rectLTRB = Rect.fromLTRB(10.0, 20.0, 110.0, 100.0);
  print('Rect.fromLTRB(10, 20, 110, 100): $rectLTRB');

  // Test Rect.fromCenter
  final rectCenter = Rect.fromCenter(
    center: Offset(50.0, 50.0),
    width: 100.0,
    height: 80.0,
  );
  print('Rect.fromCenter(50, 50, 100x80): $rectCenter');

  // Test Rect.fromCircle
  final rectCircle = Rect.fromCircle(center: Offset(50.0, 50.0), radius: 25.0);
  print('Rect.fromCircle(center=50,50, r=25): $rectCircle');

  // Test Rect.fromPoints
  final rectPoints = Rect.fromPoints(Offset(0.0, 0.0), Offset(100.0, 80.0));
  print('Rect.fromPoints(0,0 to 100,80): $rectPoints');

  // Test Rect.zero
  print('Rect.zero: ${Rect.zero}');

  // Test Rect.largest
  print('Rect.largest: ${Rect.largest}');

  // Test size property
  print('Size: ${rectLTWH.size}');

  // Test topLeft/topCenter/topRight/etc
  print('topLeft: ${rectLTWH.topLeft}');
  print('topCenter: ${rectLTWH.topCenter}');
  print('topRight: ${rectLTWH.topRight}');
  print('centerLeft: ${rectLTWH.centerLeft}');
  print('center: ${rectLTWH.center}');
  print('centerRight: ${rectLTWH.centerRight}');
  print('bottomLeft: ${rectLTWH.bottomLeft}');
  print('bottomCenter: ${rectLTWH.bottomCenter}');
  print('bottomRight: ${rectLTWH.bottomRight}');

  // Test shortestSide/longestSide
  print('shortestSide: ${rectLTWH.shortestSide}');
  print('longestSide: ${rectLTWH.longestSide}');

  // Test isEmpty/isFinite/isInfinite/hasNaN
  print('isEmpty: ${rectLTWH.isEmpty}');
  print('isFinite: ${rectLTWH.isFinite}');
  print('isInfinite: ${rectLTWH.isInfinite}');
  print('hasNaN: ${rectLTWH.hasNaN}');

  // Test shift
  final shiftedRect = rectLTWH.shift(Offset(50.0, 50.0));
  print('Shifted by (50, 50): $shiftedRect');

  // Test translate
  final translatedRect = rectLTWH.translate(10.0, -10.0);
  print('Translated (10, -10): $translatedRect');

  // Test inflate/deflate
  final inflatedRect = rectLTWH.inflate(10.0);
  print('Inflated by 10: $inflatedRect');

  final deflatedRect = rectLTWH.deflate(5.0);
  print('Deflated by 5: $deflatedRect');

  // Test expandToInclude
  final expandedRect = rectLTWH.expandToInclude(
    Rect.fromLTWH(200.0, 200.0, 50.0, 50.0),
  );
  print('ExpandToInclude: $expandedRect');

  // Test intersect
  final rect2 = Rect.fromLTWH(50.0, 50.0, 100.0, 100.0);
  final intersected = rectLTWH.intersect(rect2);
  print('Intersect: $intersected');

  // Test overlaps
  print('Overlaps rect2: ${rectLTWH.overlaps(rect2)}');
  print(
    'Overlaps far rect: ${rectLTWH.overlaps(Rect.fromLTWH(500.0, 500.0, 10.0, 10.0))}',
  );

  // Test contains (Offset)
  print('Contains Offset(50, 50): ${rectLTWH.contains(Offset(50.0, 50.0))}');
  print(
    'Contains Offset(200, 200): ${rectLTWH.contains(Offset(200.0, 200.0))}',
  );

  // Test Rect.lerp
  final rectLerp = Rect.lerp(
    Rect.zero,
    Rect.fromLTWH(100.0, 100.0, 100.0, 100.0),
    0.5,
  );
  print('Rect.lerp at 0.5: $rectLerp');

  // ========== RRECT ==========
  print('--- RRect Tests ---');

  // Test RRect.fromRectAndRadius
  final rrectRadius = RRect.fromRectAndRadius(
    Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
    Radius.circular(10.0),
  );
  print('RRect.fromRectAndRadius: $rrectRadius');
  print('  blRadius: ${rrectRadius.blRadius}');
  print('  brRadius: ${rrectRadius.brRadius}');
  print('  tlRadius: ${rrectRadius.tlRadius}');
  print('  trRadius: ${rrectRadius.trRadius}');

  // Test RRect.fromRectAndCorners
  final rrectCorners = RRect.fromRectAndCorners(
    Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
    topLeft: Radius.circular(5.0),
    topRight: Radius.circular(10.0),
    bottomLeft: Radius.circular(15.0),
    bottomRight: Radius.circular(20.0),
  );
  print('RRect.fromRectAndCorners:');
  print('  TL: ${rrectCorners.tlRadius}, TR: ${rrectCorners.trRadius}');
  print('  BL: ${rrectCorners.blRadius}, BR: ${rrectCorners.brRadius}');

  // Test RRect.fromLTRBR
  final rrectLTRBR = RRect.fromLTRBR(
    0.0,
    0.0,
    100.0,
    80.0,
    Radius.circular(15.0),
  );
  print('RRect.fromLTRBR: ${rrectLTRBR.tlRadius}');

  // Test RRect.fromLTRBXY
  final rrectLTRBXY = RRect.fromLTRBXY(0.0, 0.0, 100.0, 80.0, 10.0, 20.0);
  print('RRect.fromLTRBXY (elliptical): ${rrectLTRBXY.tlRadius}');

  // Test RRect.fromLTRBAndCorners
  final rrectLTRBAndCorners = RRect.fromLTRBAndCorners(
    0.0,
    0.0,
    100.0,
    80.0,
    topLeft: Radius.circular(10.0),
    bottomRight: Radius.circular(20.0),
  );
  print('RRect.fromLTRBAndCorners: TL=${rrectLTRBAndCorners.tlRadius}');

  // Test RRect.fromRectXY
  final rrectRectXY = RRect.fromRectXY(
    Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
    15.0,
    25.0,
  );
  print('RRect.fromRectXY (elliptical): ${rrectRectXY.tlRadius}');

  // Test RRect.zero
  print('RRect.zero: ${RRect.zero}');

  // Test properties
  print('left: ${rrectRadius.left}');
  print('top: ${rrectRadius.top}');
  print('right: ${rrectRadius.right}');
  print('bottom: ${rrectRadius.bottom}');
  print('width: ${rrectRadius.width}');
  print('height: ${rrectRadius.height}');
  print('center: ${rrectRadius.center}');

  // Test safeInnerRect/outerRect/middleRect/wideMiddleRect/tallMiddleRect
  print('outerRect: ${rrectRadius.outerRect}');
  print('safeInnerRect: ${rrectRadius.safeInnerRect}');
  print('middleRect: ${rrectRadius.middleRect}');
  print('wideMiddleRect: ${rrectRadius.wideMiddleRect}');
  print('tallMiddleRect: ${rrectRadius.tallMiddleRect}');

  // Test isEmpty/isFinite/isRect/isStadium/isEllipse
  print('isEmpty: ${rrectRadius.isEmpty}');
  print('isFinite: ${rrectRadius.isFinite}');
  print('isRect: ${rrectRadius.isRect}');
  print('isStadium: ${rrectRadius.isStadium}');
  print('isEllipse: ${rrectRadius.isEllipse}');

  // Test shift/inflate/deflate
  final shiftedRRect = rrectRadius.shift(Offset(20.0, 20.0));
  print('Shifted: left=${shiftedRRect.left}, top=${shiftedRRect.top}');

  final inflatedRRect = rrectRadius.inflate(5.0);
  print(
    'Inflated: width=${inflatedRRect.width}, height=${inflatedRRect.height}',
  );

  final deflatedRRect = rrectRadius.deflate(5.0);
  print(
    'Deflated: width=${deflatedRRect.width}, height=${deflatedRRect.height}',
  );

  // Test contains
  print('Contains (50, 40): ${rrectRadius.contains(Offset(50.0, 40.0))}');
  print('Contains (0, 0): ${rrectRadius.contains(Offset(0.0, 0.0))}'); // Corner

  // Test RRect.lerp
  final rrectLerp = RRect.lerp(
    RRect.fromRectAndRadius(Rect.fromLTWH(0.0, 0.0, 50.0, 50.0), Radius.zero),
    RRect.fromRectAndRadius(
      Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
      Radius.circular(25.0),
    ),
    0.5,
  );
  print(
    'RRect.lerp at 0.5: width=${rrectLerp?.width}, tlRadius=${rrectLerp?.tlRadius}',
  );

  // ========== PATH ==========
  print('--- Path Tests ---');

  // Test Path constructor
  final path = Path();
  print('Path created');

  // Test moveTo/lineTo
  path.moveTo(0.0, 0.0);
  path.lineTo(100.0, 0.0);
  path.lineTo(100.0, 80.0);
  path.lineTo(0.0, 80.0);
  path.close();
  print('Rectangle path created');

  // Test Path.from (copy)
  final pathCopy = Path.from(path);
  print('Path copied');

  // Test reset
  final resetPath = Path();
  resetPath.moveTo(50.0, 50.0);
  resetPath.lineTo(100.0, 100.0);
  resetPath.reset();
  print('Path reset');

  // Test addRect
  final rectPath = Path()..addRect(Rect.fromLTWH(0.0, 0.0, 100.0, 80.0));
  print('Path with addRect');

  // Test addRRect
  final rrectPath = Path()
    ..addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0.0, 0.0, 100.0, 80.0),
        Radius.circular(10.0),
      ),
    );
  print('Path with addRRect');

  // Test addOval
  final ovalPath = Path()..addOval(Rect.fromLTWH(0.0, 0.0, 100.0, 80.0));
  print('Path with addOval');

  // Test addArc
  final arcPath = Path()
    ..addArc(
      Rect.fromCircle(center: Offset(50.0, 50.0), radius: 30.0),
      0.0, // start angle
      3.14159, // sweep angle (180 degrees)
    );
  print('Path with addArc');

  // Test addPolygon
  final polygonPath = Path()
    ..addPolygon([
      Offset(50.0, 0.0),
      Offset(100.0, 40.0),
      Offset(80.0, 100.0),
      Offset(20.0, 100.0),
      Offset(0.0, 40.0),
    ], true);
  print('Path with pentagon polygon');

  // Test quadraticBezierTo
  final quadPath = Path()
    ..moveTo(0.0, 100.0)
    ..quadraticBezierTo(50.0, 0.0, 100.0, 100.0);
  print('Path with quadratic bezier');

  // Test cubicTo
  final cubicPath = Path()
    ..moveTo(0.0, 100.0)
    ..cubicTo(25.0, 0.0, 75.0, 0.0, 100.0, 100.0);
  print('Path with cubic bezier');

  // Test relativeLineTo/relativeMoveTo
  final relativePath = Path()
    ..moveTo(0.0, 0.0)
    ..relativeLineTo(50.0, 0.0)
    ..relativeLineTo(0.0, 50.0)
    ..relativeLineTo(-50.0, 0.0)
    ..close();
  print('Path with relative drawing');

  // Test arcTo
  final arcToPath = Path()
    ..moveTo(0.0, 50.0)
    ..arcTo(
      Rect.fromCircle(center: Offset(50.0, 50.0), radius: 50.0),
      3.14159, // pi radians (180 degrees)
      1.5708, // pi/2 radians (90 degrees)
      false,
    );
  print('Path with arcTo');

  // Test conicTo
  final conicPath = Path()
    ..moveTo(0.0, 100.0)
    ..conicTo(50.0, 0.0, 100.0, 100.0, 1.0);
  print('Path with conic (weight=1 = quadratic)');

  // Test getBounds
  final bounds = path.getBounds();
  print('Path bounds: $bounds');

  // Test contains
  print('Path contains (50, 40): ${path.contains(Offset(50.0, 40.0))}');
  print('Path contains (200, 200): ${path.contains(Offset(200.0, 200.0))}');

  // Test fillType
  path.fillType = PathFillType.evenOdd;
  print('FillType set to evenOdd: ${path.fillType}');

  path.fillType = PathFillType.nonZero;
  print('FillType set to nonZero: ${path.fillType}');

  // Test shift/transform
  final shiftedPath = path.shift(Offset(50.0, 50.0));
  print('Path shifted bounds: ${shiftedPath.getBounds()}');

  final transformedPath = path.transform(
    Matrix4.identity().scaled(2.0, 2.0).storage,
  );
  print('Path transformed (2x scale) bounds: ${transformedPath.getBounds()}');

  // Test addPath
  final combinedPath = Path()
    ..addPath(rectPath, Offset.zero)
    ..addPath(ovalPath, Offset(150.0, 0.0));
  print('Combined path bounds: ${combinedPath.getBounds()}');

  // Test extendWithPath
  final extendedPath = Path()
    ..moveTo(0.0, 0.0)
    ..extendWithPath(
      (Path()
        ..moveTo(0.0, 0.0)
        ..lineTo(100.0, 100.0)),
      Offset(50.0, 50.0),
    );
  print('Extended path created');

  // Test computeMetrics
  final metrics = path.computeMetrics();
  for (final metric in metrics) {
    print('Path metric: length=${metric.length}, isClosed=${metric.isClosed}');
  }

  print('Dart:ui geometry test completed');

  // Return a visual representation
  return Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Dart:UI Geometry Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text('Rect:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Stack(
              children: [
                Container(
                  width: 150.0,
                  height: 100.0,
                  color: Color(0xFFE0E0E0),
                ),
                Positioned(
                  left: 10.0,
                  top: 10.0,
                  child: Container(
                    width: 100.0,
                    height: 60.0,
                    color: Color(0xFF2196F3),
                    child: Center(
                      child: Text(
                        'Rect',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'RRect (Rounded Rect):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFE53935),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Center(
                    child: Text(
                      '10',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF4CAF50),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Center(
                    child: Text(
                      '20',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                    color: Color(0xFFFF9800),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Mix',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                Container(
                  width: 80.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Color(0xFF9C27B0),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(25.0),
                      right: Radius.circular(25.0),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Stadium',
                      style: TextStyle(
                        color: Color(0xFFFFFFFF),
                        fontSize: 10.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text('Path Shapes:', style: TextStyle(fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Row(
              children: [
                ClipPath(
                  clipper: TriangleClipper(),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    color: Color(0xFF2196F3),
                  ),
                ),
                SizedBox(width: 8.0),
                ClipPath(
                  clipper: PentagonClipper(),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    color: Color(0xFFE53935),
                  ),
                ),
                SizedBox(width: 8.0),
                ClipPath(
                  clipper: StarClipper(),
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    color: Color(0xFFFF9800),
                  ),
                ),
                SizedBox(width: 8.0),
                ClipOval(
                  child: Container(
                    width: 60.0,
                    height: 60.0,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'Path Operations:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              padding: EdgeInsets.all(8.0),
              color: Color(0xFFE0E0E0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '• moveTo, lineTo, close',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• addRect, addRRect, addOval',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• addArc, addPolygon',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• quadraticBezierTo, cubicTo',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text(
                    '• getBounds, contains',
                    style: TextStyle(fontSize: 12.0),
                  ),
                  Text('• shift, transform', style: TextStyle(fontSize: 12.0)),
                  Text('• computeMetrics', style: TextStyle(fontSize: 12.0)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

// Custom clippers for path demonstration
class TriangleClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    return Path()
      ..moveTo(size.width / 2, 0.0)
      ..lineTo(size.width, size.height)
      ..lineTo(0.0, size.height)
      ..close();
  }

  @override
  bool shouldReclip(TriangleClipper oldClipper) => false;
}

class PentagonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width / 2;
    final points = <Offset>[];
    for (var i = 0; i < 5; i++) {
      final angle = (i * 72.0 - 90.0) * 3.14159 / 180.0;
      points.add(
        Offset(cx + r * 0.9 * (angle).cos, cy + r * 0.9 * (angle).sin),
      );
    }
    return Path()..addPolygon(points, true);
  }

  @override
  bool shouldReclip(PentagonClipper oldClipper) => false;
}

class StarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final outerR = size.width / 2;
    final innerR = outerR * 0.4;
    final path = Path();
    for (var i = 0; i < 5; i++) {
      final outerAngle = (i * 72.0 - 90.0) * 3.14159 / 180.0;
      final innerAngle = ((i * 72.0) + 36.0 - 90.0) * 3.14159 / 180.0;
      if (i == 0) {
        path.moveTo(
          cx + outerR * 0.9 * (outerAngle).cos,
          cy + outerR * 0.9 * (outerAngle).sin,
        );
      } else {
        path.lineTo(
          cx + outerR * 0.9 * (outerAngle).cos,
          cy + outerR * 0.9 * (outerAngle).sin,
        );
      }
      path.lineTo(
        cx + innerR * 0.9 * (innerAngle).cos,
        cy + innerR * 0.9 * (innerAngle).sin,
      );
    }
    path.close();
    return path;
  }

  @override
  bool shouldReclip(StarClipper oldClipper) => false;
}

extension MathExtension on double {
  double cos() => _cos(this);
  double sin() => _sin(this);
}

// Simple cos/sin approximations for the test
double _cos(double x) {
  // Normalize to 0-2pi
  while (x < 0) x += 2 * 3.14159;
  while (x > 2 * 3.14159) x -= 2 * 3.14159;
  // Taylor series approximation
  final x2 = x * x;
  final x4 = x2 * x2;
  final x6 = x4 * x2;
  return 1 - x2 / 2 + x4 / 24 - x6 / 720;
}

double _sin(double x) {
  return _cos(x - 3.14159 / 2);
}
