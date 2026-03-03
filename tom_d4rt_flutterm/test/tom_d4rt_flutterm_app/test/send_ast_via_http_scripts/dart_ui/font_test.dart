// D4rt test script: Tests FontFeature, FontVariation, RSTransform, Tangent from dart:ui
import 'dart:ui';
import 'dart:math' as math;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui font test executing');

  // ========== FONTFEATURE ==========
  print('--- FontFeature Tests ---');

  final smcp = FontFeature.enable('smcp');
  print('FontFeature.enable("smcp"): $smcp');
  print('  feature: ${smcp.feature}');
  print('  value: ${smcp.value}');
  print('  runtimeType: ${smcp.runtimeType}');

  final liga = FontFeature.enable('liga');
  print('FontFeature.enable("liga"): $liga');

  final disableLiga = FontFeature.disable('liga');
  print('FontFeature.disable("liga"): $disableLiga');
  print('  value: ${disableLiga.value}');

  final swsh = FontFeature('swsh', 2);
  print('FontFeature("swsh", 2): $swsh');
  print('  feature: ${swsh.feature}');
  print('  value: ${swsh.value}');

  // Common font features
  final features = [
    FontFeature.enable('kern'),
    FontFeature.enable('onum'),
    FontFeature.enable('tnum'),
    FontFeature.enable('frac'),
    FontFeature.enable('zero'),
  ];
  for (final f in features) {
    print('  FontFeature: ${f.feature} = ${f.value}');
  }

  // Named constructors
  final tabular = FontFeature.tabularFigures();
  print('FontFeature.tabularFigures(): $tabular');

  final oldStyle = FontFeature.oldstyleFigures();
  print('FontFeature.oldstyleFigures(): $oldStyle');

  final proportional = FontFeature.proportionalFigures();
  print('FontFeature.proportionalFigures(): $proportional');

  // ========== FONTVARIATION ==========
  print('--- FontVariation Tests ---');

  final wght = FontVariation('wght', 700);
  print('FontVariation("wght", 700): $wght');
  print('  axis: ${wght.axis}');
  print('  value: ${wght.value}');
  print('  runtimeType: ${wght.runtimeType}');

  final wdth = FontVariation('wdth', 120);
  print('FontVariation("wdth", 120): $wdth');

  final slnt = FontVariation('slnt', -12.0);
  print('FontVariation("slnt", -12): $slnt');

  final ital = FontVariation('ital', 1.0);
  print('FontVariation("ital", 1.0): $ital');

  // Named constructors
  final weightVar = FontVariation.weight(600);
  print('FontVariation.weight(600): $weightVar');

  final widthVar = FontVariation.width(110);
  print('FontVariation.width(110): $widthVar');

  final slantVar = FontVariation.slant(-10.0);
  print('FontVariation.slant(-10): $slantVar');

  final italicVar = FontVariation.italic(1.0);
  print('FontVariation.italic(1.0): $italicVar');

  // ========== RSTRANSFORM ==========
  print('--- RSTransform Tests ---');

  // Identity transform
  final identity = RSTransform(1.0, 0.0, 0.0, 0.0);
  print('RSTransform identity (1,0,0,0): $identity');
  print('  scos: ${identity.scos}');
  print('  ssin: ${identity.ssin}');
  print('  tx: ${identity.tx}');
  print('  ty: ${identity.ty}');
  print('  runtimeType: ${identity.runtimeType}');

  // Rotation transform
  final angle = math.pi / 4; // 45 degrees
  final cosA = math.cos(angle);
  final sinA = math.sin(angle);
  final rotation = RSTransform(cosA, sinA, 50.0, 50.0);
  print('RSTransform 45deg rotation at (50,50): $rotation');
  print('  scos: ${rotation.scos}');
  print('  ssin: ${rotation.ssin}');

  // Scale transform
  final scale2x = RSTransform(2.0, 0.0, 0.0, 0.0);
  print('RSTransform 2x scale: $scale2x');

  // fromComponents factory
  final fromComp = RSTransform.fromComponents(
    rotation: math.pi / 6, // 30 degrees
    scale: 1.5,
    anchorX: 0.0,
    anchorY: 0.0,
    translateX: 100.0,
    translateY: 200.0,
  );
  print('RSTransform.fromComponents(30deg, 1.5x, at 100,200): $fromComp');
  print('  scos: ${fromComp.scos}');
  print('  ssin: ${fromComp.ssin}');
  print('  tx: ${fromComp.tx}');
  print('  ty: ${fromComp.ty}');

  // ========== TANGENT ==========
  print('--- Tangent Tests ---');

  final tangent1 = Tangent(Offset(10.0, 20.0), Offset(1.0, 0.0));
  print('Tangent(position: (10,20), vector: (1,0)): $tangent1');
  print('  position: ${tangent1.position}');
  print('  vector: ${tangent1.vector}');
  print('  angle: ${tangent1.angle}');
  print('  runtimeType: ${tangent1.runtimeType}');

  final tangent2 = Tangent(Offset(50.0, 50.0), Offset(0.0, 1.0));
  print('Tangent(position: (50,50), vector: (0,1))');
  print('  angle: ${tangent2.angle}');

  final tangent3 = Tangent(Offset(0.0, 0.0), Offset(1.0, 1.0));
  print('Tangent(position: (0,0), vector: (1,1))');
  print('  angle: ${tangent3.angle}');

  // ========== LINEMETRICS / VIEWPADDING ==========
  print('--- LineMetrics / ViewPadding Notes ---');

  // LineMetrics cannot be directly constructed - it's returned by Paragraph.computeLineMetrics()
  print('LineMetrics: Not directly constructable');
  print('  Returned by Paragraph.computeLineMetrics()');
  print(
    '  Properties: hardBreak, ascent, descent, unscaledAscent, height, width, left, baseline, lineNumber',
  );

  // ViewPadding is not directly constructable
  print('ViewPadding: Not directly constructable');
  print('  Accessed via FlutterView.padding, FlutterView.viewInsets, etc.');
  print('  Properties: left, top, right, bottom');

  // GlyphInfo is not directly constructable
  print('GlyphInfo: Not directly constructable');
  print('  Returned by Paragraph.getGlyphInfoAt() etc.');

  // ========== RETURN WIDGET ==========
  print('dart:ui font test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'dart:ui Font & Transform Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text(
            'Classes Tested:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• FontFeature - OpenType font features'),
          Text('• FontVariation - variable font axes'),
          Text('• RSTransform - rotation+scale+translate'),
          Text('• Tangent - path tangent vector'),
          SizedBox(height: 16.0),

          Text(
            'Not Constructable:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.0),
          Text('• LineMetrics - from Paragraph'),
          Text('• ViewPadding - from FlutterView'),
          Text('• GlyphInfo - from Paragraph'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFFCE4EC),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FontFeature smcp: ${smcp.feature}=${smcp.value}'),
                Text('FontVariation wght: ${wght.axis}=${wght.value}'),
                Text('RSTransform identity: scos=${identity.scos}'),
                Text('Tangent angle: ${tangent1.angle}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
