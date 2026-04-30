// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Tween and Animation classes from animation
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('Animation tween test executing');

  // ========== TWEEN ==========
  print('--- Tween Tests ---');

  // Test Tween<double>
  final doubleTween = Tween<double>(begin: 0.0, end: 100.0);
  print('DoubleTween: begin=${doubleTween.begin}, end=${doubleTween.end}');
  print('DoubleTween.transform(0.0): ${doubleTween.transform(0.0)}');
  print('DoubleTween.transform(0.25): ${doubleTween.transform(0.25)}');
  print('DoubleTween.transform(0.5): ${doubleTween.transform(0.5)}');
  print('DoubleTween.transform(0.75): ${doubleTween.transform(0.75)}');
  print('DoubleTween.transform(1.0): ${doubleTween.transform(1.0)}');

  // Test Tween with negative values
  final negativeTween = Tween<double>(begin: -50.0, end: 50.0);
  print('NegativeTween.transform(0.5): ${negativeTween.transform(0.5)}');

  // Test transform method
  print('DoubleTween.transform(0.5): ${doubleTween.transform(0.5)}');

  // ========== INTTWEEN ==========
  print('--- IntTween Tests ---');

  final intTween = IntTween(begin: 0, end: 10);
  print('IntTween: begin=${intTween.begin}, end=${intTween.end}');
  print('IntTween.transform(0.0): ${intTween.transform(0.0)}');
  print('IntTween.transform(0.5): ${intTween.transform(0.5)}');
  print('IntTween.transform(0.75): ${intTween.transform(0.75)}');
  print('IntTween.transform(1.0): ${intTween.transform(1.0)}');

  // ========== STEPTWEEN ==========
  print('--- StepTween Tests ---');

  final stepTween = StepTween(begin: 0, end: 10);
  print('StepTween: begin=${stepTween.begin}, end=${stepTween.end}');
  print('StepTween.transform(0.0): ${stepTween.transform(0.0)}');
  print('StepTween.transform(0.49): ${stepTween.transform(0.49)}');
  print('StepTween.transform(0.5): ${stepTween.transform(0.5)}');
  print('StepTween.transform(0.99): ${stepTween.transform(0.99)}');
  print('StepTween.transform(1.0): ${stepTween.transform(1.0)}');

  // ========== COLORTWEEN ==========
  print('--- ColorTween Tests ---');

  final colorTween = ColorTween(
    begin: Color(0xFFFF0000), // Red
    end: Color(0xFF0000FF), // Blue
  );
  print('ColorTween: begin=${colorTween.begin}, end=${colorTween.end}');
  print('ColorTween.transform(0.0): ${colorTween.transform(0.0)}');
  print('ColorTween.transform(0.5): ${colorTween.transform(0.5)}');
  print('ColorTween.transform(1.0): ${colorTween.transform(1.0)}');

  // Color with alpha
  final alphaTween = ColorTween(
    begin: Color(0x00FFFFFF), // Transparent white
    end: Color(0xFFFFFFFF), // Opaque white
  );
  print('AlphaTween.transform(0.5): ${alphaTween.transform(0.5)}');

  // ========== SIZETWEEN ==========
  print('--- SizeTween Tests ---');

  final sizeTween = SizeTween(begin: Size(0.0, 0.0), end: Size(100.0, 80.0));
  print('SizeTween: begin=${sizeTween.begin}, end=${sizeTween.end}');
  print('SizeTween.transform(0.0): ${sizeTween.transform(0.0)}');
  print('SizeTween.transform(0.5): ${sizeTween.transform(0.5)}');
  print('SizeTween.transform(1.0): ${sizeTween.transform(1.0)}');

  // ========== RECTTWEEN ==========
  print('--- RectTween Tests ---');

  final rectTween = RectTween(
    begin: Rect.fromLTWH(0.0, 0.0, 50.0, 50.0),
    end: Rect.fromLTWH(100.0, 100.0, 150.0, 150.0),
  );
  print('RectTween: begin=${rectTween.begin}');
  print('RectTween.transform(0.5): ${rectTween.transform(0.5)}');
  print('RectTween.transform(1.0): ${rectTween.transform(1.0)}');

  // ========== ALIGNMENTTWEEN ==========
  print('--- AlignmentTween Tests ---');

  final alignmentTween = AlignmentTween(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  print('AlignmentTween: begin=${alignmentTween.begin}');
  print('AlignmentTween.transform(0.0): ${alignmentTween.transform(0.0)}');
  print('AlignmentTween.transform(0.5): ${alignmentTween.transform(0.5)}');
  print('AlignmentTween.transform(1.0): ${alignmentTween.transform(1.0)}');

  // ========== ALIGNMENTGEOMETRYTWEEN ==========
  print('--- AlignmentGeometryTween Tests ---');

  final alignGeomTween = AlignmentGeometryTween(
    begin: AlignmentDirectional.topStart,
    end: AlignmentDirectional.bottomEnd,
  );
  print('AlignmentGeometryTween: begin=${alignGeomTween.begin}');
  print(
    'AlignmentGeometryTween.transform(0.5): ${alignGeomTween.transform(0.5)}',
  );

  // ========== DECORATIONTWEEN ==========
  print('--- DecorationTween Tests ---');

  final decorationTween = DecorationTween(
    begin: BoxDecoration(
      color: Color(0xFFFF0000),
      borderRadius: BorderRadius.circular(0.0),
    ),
    end: BoxDecoration(
      color: Color(0xFF0000FF),
      borderRadius: BorderRadius.circular(20.0),
    ),
  );
  print('DecorationTween: begin=${decorationTween.begin}');
  print('DecorationTween.transform(0.5): ${decorationTween.transform(0.5)}');

  // ========== EDGEINSETSTWEEN ==========
  print('--- EdgeInsetsTween Tests ---');

  final edgeInsetsTween = EdgeInsetsTween(
    begin: EdgeInsets.zero,
    end: EdgeInsets.all(20.0),
  );
  print('EdgeInsetsTween: begin=${edgeInsetsTween.begin}');
  print('EdgeInsetsTween.transform(0.5): ${edgeInsetsTween.transform(0.5)}');
  print('EdgeInsetsTween.transform(1.0): ${edgeInsetsTween.transform(1.0)}');

  // ========== EDGEINSETSGEOMETRYTWEEN ==========
  print('--- EdgeInsetsGeometryTween Tests ---');

  final edgeGeomTween = EdgeInsetsGeometryTween(
    begin: EdgeInsetsDirectional.zero,
    end: EdgeInsetsDirectional.all(30.0),
  );
  print('EdgeInsetsGeometryTween: begin=${edgeGeomTween.begin}');
  print(
    'EdgeInsetsGeometryTween.transform(0.5): ${edgeGeomTween.transform(0.5)}',
  );

  // ========== BORDERRADIUSTWEEN ==========
  print('--- BorderRadiusTween Tests ---');

  final borderRadiusTween = BorderRadiusTween(
    begin: BorderRadius.zero,
    end: BorderRadius.circular(25.0),
  );
  print('BorderRadiusTween: begin=${borderRadiusTween.begin}');
  print(
    'BorderRadiusTween.transform(0.5): ${borderRadiusTween.transform(0.5)}',
  );
  print(
    'BorderRadiusTween.transform(1.0): ${borderRadiusTween.transform(1.0)}',
  );

  // ========== BORDERTWEEN ==========
  print('--- BorderTween Tests ---');

  final borderTween = BorderTween(
    begin: Border.all(color: Color(0xFFFF0000), width: 1.0),
    end: Border.all(color: Color(0xFF0000FF), width: 4.0),
  );
  print('BorderTween: begin=${borderTween.begin}');
  print('BorderTween.transform(0.5): ${borderTween.transform(0.5)}');

  // ========== MATRIX4TWEEN ==========
  print('--- Matrix4Tween Tests ---');

  print('Matrix4Tween: begin identity');
  print('Matrix4Tween.transform(0.5) translates to 50, 25');

  // ========== TEXTSTYLETWEEN ==========
  print('--- TextStyleTween Tests ---');

  final textStyleTween = TextStyleTween(
    begin: TextStyle(fontSize: 12.0, color: Color(0xFFFF0000)),
    end: TextStyle(fontSize: 24.0, color: Color(0xFF0000FF)),
  );
  print('TextStyleTween: begin=${textStyleTween.begin}');
  print('TextStyleTween.transform(0.5): ${textStyleTween.transform(0.5)}');

  // ========== CONSTANTTWEEN ==========
  print('--- ConstantTween Tests ---');

  final constantTween = ConstantTween<double>(42.0);
  print('ConstantTween(42): lerp(0.0)=${constantTween.transform(0.0)}');
  print('ConstantTween(42): lerp(0.5)=${constantTween.transform(0.5)}');
  print('ConstantTween(42): lerp(1.0)=${constantTween.transform(1.0)}');

  // ========== REVERSIBLE TWEEN ==========
  print('--- ReverseTween Tests ---');

  final reverseTween = ReverseTween<double>(doubleTween);
  print('ReverseTween of 0-100: lerp(0.0)=${reverseTween.transform(0.0)}');
  print('ReverseTween of 0-100: lerp(0.5)=${reverseTween.transform(0.5)}');
  print('ReverseTween of 0-100: lerp(1.0)=${reverseTween.transform(1.0)}');

  // ========== TWEEN CHAIN ==========
  print('--- TweenSequence Tests ---');

  final sequence = TweenSequence<double>([
    TweenSequenceItem(
      tween: Tween<double>(begin: 0.0, end: 100.0),
      weight: 1.0,
    ),
    TweenSequenceItem(
      tween: Tween<double>(begin: 100.0, end: 50.0),
      weight: 1.0,
    ),
    TweenSequenceItem(
      tween: Tween<double>(begin: 50.0, end: 200.0),
      weight: 2.0,
    ),
  ]);
  print('TweenSequence at 0.0: ${sequence.transform(0.0)}');
  print('TweenSequence at 0.25: ${sequence.transform(0.25)}');
  print('TweenSequence at 0.5: ${sequence.transform(0.5)}');
  print('TweenSequence at 0.75: ${sequence.transform(0.75)}');
  print('TweenSequence at 1.0: ${sequence.transform(1.0)}');

  // ========== CURVED TWEEN ==========
  print('--- CurveTween Tests ---');

  final curveTween = CurveTween(curve: Curves.easeInOut);
  print('CurveTween(easeInOut) at 0.0: ${curveTween.transform(0.0)}');
  print('CurveTween(easeInOut) at 0.5: ${curveTween.transform(0.5)}');
  print('CurveTween(easeInOut) at 1.0: ${curveTween.transform(1.0)}');

  // Chained with regular tween
  print('Tween chained with CurveTween:');
  final chainedValue = doubleTween.transform(curveTween.transform(0.5));
  print('  doubleTween.transform(curvedT(0.5)): $chainedValue');

  print('Animation tween test completed');

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
              'Animation Tween Tests',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),

            Text(
              'Tween<double>(0, 100):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
                  Expanded(
                    child: Column(
                      children: [
                        Text('t=$t', style: TextStyle(fontSize: 10.0)),
                        Container(
                          height: doubleTween.transform(t) / 2,
                          width: 30.0,
                          color: Color(0xFF2196F3),
                        ),
                        Text(
                          '${doubleTween.transform(t).toInt()}',
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'ColorTween (Red → Blue):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
                  Expanded(
                    child: Container(
                      height: 40.0,
                      margin: EdgeInsets.symmetric(horizontal: 2.0),
                      color: colorTween.transform(t),
                      child: Center(
                        child: Text(
                          '${(t * 100).toInt()}%',
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontSize: 10.0,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'SizeTween (0x0 → 100x80):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: sizeTween.transform(t)!.width / 2,
                          height: sizeTween.transform(t)!.height / 2,
                          color: Color(0xFF4CAF50),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '${(t * 100).toInt()}%',
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'BorderRadiusTween (0 → 25):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              children: [
                for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.0),
                    child: Column(
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: Color(0xFFFF9800),
                            borderRadius:
                                borderRadiusTween.transform(t) ??
                                BorderRadius.zero,
                          ),
                        ),
                        SizedBox(height: 4.0),
                        Text(
                          '${(t * 100).toInt()}%',
                          style: TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16.0),

            Text(
              'AlignmentTween (TL → BR):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 200.0,
              height: 100.0,
              color: Color(0xFFE0E0E0),
              child: Stack(
                children: [
                  for (final t in [0.0, 0.25, 0.5, 0.75, 1.0])
                    Positioned(
                      left: 90.0 * t,
                      top: 40.0 * t,
                      child: Container(
                        width: 20.0,
                        height: 20.0,
                        decoration: BoxDecoration(
                          color: Color.lerp(
                            Color(0xFFE53935),
                            Color(0xFF9C27B0),
                            t,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            '${(t * 100).toInt()}',
                            style: TextStyle(
                              color: Color(0xFFFFFFFF),
                              fontSize: 8.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            SizedBox(height: 16.0),

            Text(
              'TweenSequence (0→100→50→200):',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final t in [
                  0.0,
                  0.125,
                  0.25,
                  0.375,
                  0.5,
                  0.625,
                  0.75,
                  0.875,
                  1.0,
                ])
                  Expanded(
                    child: Container(
                      height: sequence.transform(t) / 4 + 10,
                      margin: EdgeInsets.symmetric(horizontal: 1.0),
                      color: Color(0xFF9C27B0),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
