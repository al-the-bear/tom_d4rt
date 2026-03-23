// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests EdgeInsets, EdgeInsetsDirectional, EdgeInsetsGeometry from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Painting edgeinsets test executing');

  // ========== EDGEINSETS ==========
  print('--- EdgeInsets Tests ---');

  // Test EdgeInsets.all
  final allInsets = EdgeInsets.all(16.0);
  print('EdgeInsets.all(16.0): $allInsets');
  print(
    '  left: ${allInsets.left}, top: ${allInsets.top}, right: ${allInsets.right}, bottom: ${allInsets.bottom}',
  );

  // Test EdgeInsets.zero
  final zeroInsets = EdgeInsets.zero;
  print('EdgeInsets.zero: $zeroInsets');

  // Test EdgeInsets.only
  final onlyLeftInsets = EdgeInsets.only(left: 10.0);
  print('EdgeInsets.only(left: 10.0): $onlyLeftInsets');

  final onlyTopInsets = EdgeInsets.only(top: 20.0);
  print('EdgeInsets.only(top: 20.0): $onlyTopInsets');

  final onlyMultiple = EdgeInsets.only(
    left: 10.0,
    top: 20.0,
    right: 30.0,
    bottom: 40.0,
  );
  print('EdgeInsets.only(...): $onlyMultiple');

  // Test EdgeInsets.symmetric
  final symmetricHorizontal = EdgeInsets.symmetric(horizontal: 16.0);
  print('EdgeInsets.symmetric(horizontal: 16.0): $symmetricHorizontal');

  final symmetricVertical = EdgeInsets.symmetric(vertical: 8.0);
  print('EdgeInsets.symmetric(vertical: 8.0): $symmetricVertical');

  final symmetricBoth = EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0);
  print(
    'EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0): $symmetricBoth',
  );

  // Test EdgeInsets.fromLTRB
  final fromLTRB = EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0);
  print('EdgeInsets.fromLTRB(10.0, 20.0, 30.0, 40.0): $fromLTRB');

  // Test EdgeInsets.fromViewPadding (need ViewPadding - skip for now)
  // Test EdgeInsets.lerp
  final startInsets = EdgeInsets.all(0.0);
  final endInsets = EdgeInsets.all(100.0);
  final lerpedInsets = EdgeInsets.lerp(startInsets, endInsets, 0.5);
  print('EdgeInsets.lerp at 0.5: $lerpedInsets');

  // Test EdgeInsets operators
  final addedInsets = allInsets + symmetricBoth;
  print('EdgeInsets addition: $addedInsets');

  final subtractedInsets = endInsets - startInsets;
  print('EdgeInsets subtraction: $subtractedInsets');

  final negatedInsets = -allInsets;
  print('EdgeInsets negation: $negatedInsets');

  final multipliedInsets = allInsets * 2.0;
  print('EdgeInsets multiplication: $multipliedInsets');

  final dividedInsets = allInsets / 2.0;
  print('EdgeInsets division: $dividedInsets');

  final intDividedInsets = allInsets ~/ 2;
  print('EdgeInsets integer division: $intDividedInsets');

  final moduloInsets = allInsets % 10.0;
  print('EdgeInsets modulo: $moduloInsets');

  // Test EdgeInsets properties
  print('isNonNegative: ${allInsets.isNonNegative}');
  print('horizontal: ${symmetricBoth.horizontal}');
  print('vertical: ${symmetricBoth.vertical}');
  print('collapsedSize: ${allInsets.collapsedSize}');
  print('flipped: ${fromLTRB.flipped}');

  // Test EdgeInsets methods
  final inflatedSize = allInsets.inflateSize(Size(100.0, 100.0));
  print('inflateSize(Size(100, 100)): $inflatedSize');

  final deflatedSize = allInsets.deflateSize(Size(100.0, 100.0));
  print('deflateSize(Size(100, 100)): $deflatedSize');

  final inflatedRect = allInsets.inflateRect(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
  );
  print('inflateRect: $inflatedRect');

  final deflatedRect = allInsets.deflateRect(
    Rect.fromLTWH(0.0, 0.0, 100.0, 100.0),
  );
  print('deflateRect: $deflatedRect');

  // Test EdgeInsets copyWith
  final copiedInsets = fromLTRB.copyWith(left: 99.0);
  print('copyWith(left: 99.0): $copiedInsets');

  // Test EdgeInsets clamp
  final clampedInsets = fromLTRB.clamp(EdgeInsets.zero, EdgeInsets.all(25.0));
  print('clamp to max 25: $clampedInsets');

  // ========== EDGEINSETSDIRECTIONAL ==========
  print('--- EdgeInsetsDirectional Tests ---');

  // Test EdgeInsetsDirectional.zero
  final dirZero = EdgeInsetsDirectional.zero;
  print('EdgeInsetsDirectional.zero: $dirZero');

  // Test EdgeInsetsDirectional.all
  final dirAll = EdgeInsetsDirectional.all(16.0);
  print('EdgeInsetsDirectional.all(16.0): $dirAll');
  print(
    '  start: ${dirAll.start}, top: ${dirAll.top}, end: ${dirAll.end}, bottom: ${dirAll.bottom}',
  );

  // Test EdgeInsetsDirectional.only
  final dirOnlyStart = EdgeInsetsDirectional.only(start: 10.0);
  print('EdgeInsetsDirectional.only(start: 10.0): $dirOnlyStart');

  final dirOnlyEnd = EdgeInsetsDirectional.only(end: 20.0);
  print('EdgeInsetsDirectional.only(end: 20.0): $dirOnlyEnd');

  final dirOnlyMultiple = EdgeInsetsDirectional.only(
    start: 10.0,
    top: 20.0,
    end: 30.0,
    bottom: 40.0,
  );
  print('EdgeInsetsDirectional.only(...): $dirOnlyMultiple');

  // Test EdgeInsetsDirectional.symmetric
  final dirSymmetricHorizontal = EdgeInsetsDirectional.symmetric(
    horizontal: 16.0,
  );
  print(
    'EdgeInsetsDirectional.symmetric(horizontal: 16.0): $dirSymmetricHorizontal',
  );

  final dirSymmetricVertical = EdgeInsetsDirectional.symmetric(vertical: 8.0);
  print(
    'EdgeInsetsDirectional.symmetric(vertical: 8.0): $dirSymmetricVertical',
  );

  final dirSymmetricBoth = EdgeInsetsDirectional.symmetric(
    horizontal: 20.0,
    vertical: 10.0,
  );
  print('EdgeInsetsDirectional.symmetric(h: 20, v: 10): $dirSymmetricBoth');

  // Test EdgeInsetsDirectional.fromSTEB
  final fromSTEB = EdgeInsetsDirectional.fromSTEB(10.0, 20.0, 30.0, 40.0);
  print('EdgeInsetsDirectional.fromSTEB(10, 20, 30, 40): $fromSTEB');

  // Test EdgeInsetsDirectional operators
  final dirAdded = dirAll + dirSymmetricBoth;
  print('EdgeInsetsDirectional addition: $dirAdded');

  final dirNegated = -dirAll;
  print('EdgeInsetsDirectional negation: $dirNegated');

  final dirMultiplied = dirAll * 2.0;
  print('EdgeInsetsDirectional multiplication: $dirMultiplied');

  final dirDivided = dirAll / 2.0;
  print('EdgeInsetsDirectional division: $dirDivided');

  // Test EdgeInsetsDirectional resolve
  final resolvedLTR = fromSTEB.resolve(TextDirection.ltr);
  print('Resolved LTR: $resolvedLTR');

  final resolvedRTL = fromSTEB.resolve(TextDirection.rtl);
  print('Resolved RTL: $resolvedRTL');

  // Test EdgeInsetsDirectional lerp
  final dirStart = EdgeInsetsDirectional.all(0.0);
  final dirEnd = EdgeInsetsDirectional.all(100.0);
  final dirLerped = EdgeInsetsDirectional.lerp(dirStart, dirEnd, 0.5);
  print('EdgeInsetsDirectional.lerp at 0.5: $dirLerped');

  // ========== EDGEINSETSGEOMETRY ==========
  print('--- EdgeInsetsGeometry Tests ---');

  // EdgeInsetsGeometry is abstract, test via lerp
  final geoStart = EdgeInsets.all(0.0);
  final geoEnd = EdgeInsetsDirectional.all(100.0);
  final geoLerped = EdgeInsetsGeometry.lerp(geoStart, geoEnd, 0.5);
  print(
    'EdgeInsetsGeometry.lerp between EdgeInsets and EdgeInsetsDirectional: $geoLerped',
  );

  // Test add method
  final geoAdded = geoStart.add(EdgeInsets.all(10.0));
  print('EdgeInsetsGeometry.add: $geoAdded');

  // Test subtract (via operator -)
  print('EdgeInsetsGeometry subtract: implemented via operator -');

  print('Painting edgeinsets test completed');

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
              'EdgeInsets Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            // EdgeInsets.all example
            Text(
              'EdgeInsets.all(16):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              color: Color(0xFFE3F2FD),
              child: Container(
                margin: EdgeInsets.all(16.0),
                color: Color(0xFF2196F3),
                width: 50.0,
                height: 50.0,
              ),
            ),
            SizedBox(height: 16.0),

            // EdgeInsets.symmetric example
            Text(
              'EdgeInsets.symmetric(h: 32, v: 8):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              color: Color(0xFFE8F5E9),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 32.0, vertical: 8.0),
                color: Color(0xFF4CAF50),
                width: 50.0,
                height: 50.0,
              ),
            ),
            SizedBox(height: 16.0),

            // EdgeInsets.only example
            Text(
              'EdgeInsets.only(left: 48):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              color: Color(0xFFFFF3E0),
              child: Container(
                margin: EdgeInsets.only(left: 48.0),
                color: Color(0xFFFF9800),
                width: 50.0,
                height: 50.0,
              ),
            ),
            SizedBox(height: 16.0),

            // EdgeInsets.fromLTRB example
            Text(
              'EdgeInsets.fromLTRB(8, 16, 24, 32):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              color: Color(0xFFF3E5F5),
              child: Container(
                margin: EdgeInsets.fromLTRB(8.0, 16.0, 24.0, 32.0),
                color: Color(0xFF9C27B0),
                width: 50.0,
                height: 50.0,
              ),
            ),
            SizedBox(height: 16.0),

            // RTL example
            Text(
              'EdgeInsetsDirectional (RTL-aware):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                color: Color(0xFFFFEBEE),
                child: Padding(
                  padding: EdgeInsetsDirectional.only(start: 48.0),
                  child: Container(
                    color: Color(0xFFE53935),
                    width: 50.0,
                    height: 50.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
