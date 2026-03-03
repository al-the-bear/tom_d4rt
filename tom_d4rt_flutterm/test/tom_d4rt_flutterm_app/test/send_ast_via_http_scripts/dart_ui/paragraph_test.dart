// D4rt test script: Tests ParagraphStyle, ParagraphConstraints, StrutStyle from dart:ui
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui paragraph test executing');

  // ========== PARAGRAPHSTYLE ==========
  print('--- ParagraphStyle Tests ---');

  final style1 = ParagraphStyle(
    textAlign: TextAlign.center,
    fontSize: 16.0,
  );
  print('ParagraphStyle(textAlign: center, fontSize: 16) created');
  print('  runtimeType: ${style1.runtimeType}');
  print('  toString: $style1');

  final style2 = ParagraphStyle(
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
    maxLines: 3,
    fontFamily: 'Roboto',
    fontSize: 14.0,
    height: 1.5,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
  );
  print('Full ParagraphStyle created');
  print('  toString: $style2');

  final style3 = ParagraphStyle(
    textAlign: TextAlign.right,
    textDirection: TextDirection.rtl,
    maxLines: 1,
    ellipsis: '...',
  );
  print('ParagraphStyle with ellipsis: $style3');

  // Test different TextAlign values
  for (final align in TextAlign.values) {
    final s = ParagraphStyle(textAlign: align);
    print('  ParagraphStyle(textAlign: $align): $s');
  }

  // ========== PARAGRAPHCONSTRAINTS ==========
  print('--- ParagraphConstraints Tests ---');

  final constraints1 = ParagraphConstraints(width: 200.0);
  print('ParagraphConstraints(width: 200): $constraints1');
  print('  width: ${constraints1.width}');
  print('  runtimeType: ${constraints1.runtimeType}');

  final constraints2 = ParagraphConstraints(width: 500.0);
  print('ParagraphConstraints(width: 500): $constraints2');
  print('  width: ${constraints2.width}');

  final wideConstraints = ParagraphConstraints(width: double.infinity);
  print('ParagraphConstraints(width: infinity): $wideConstraints');

  // Test equality
  final c1 = ParagraphConstraints(width: 300.0);
  final c2 = ParagraphConstraints(width: 300.0);
  final c3 = ParagraphConstraints(width: 400.0);
  print('Constraints equality: c1 == c2: ${c1 == c2}');
  print('Constraints equality: c1 == c3: ${c1 == c3}');

  // ========== STRUTSTYLE ==========
  print('--- StrutStyle Tests ---');

  final strut1 = StrutStyle(
    fontSize: 16.0,
  );
  print('StrutStyle(fontSize: 16) created');
  print('  runtimeType: ${strut1.runtimeType}');
  print('  toString: $strut1');

  final strut2 = StrutStyle(
    fontFamily: 'Roboto',
    fontSize: 14.0,
    height: 1.5,
    leading: 0.5,
    fontWeight: FontWeight.w500,
    fontStyle: FontStyle.normal,
    forceStrutHeight: true,
  );
  print('Full StrutStyle created: $strut2');

  final strut3 = StrutStyle(
    fontFamily: 'Courier',
    fontFamilyFallback: ['monospace', 'serif'],
    fontSize: 12.0,
  );
  print('StrutStyle with fallback fonts: $strut3');

  // ========== PARAGRAPHBUILDER ==========
  print('--- ParagraphBuilder Tests ---');

  final paragraphStyle = ParagraphStyle(
    textAlign: TextAlign.left,
    fontSize: 18.0,
    fontWeight: FontWeight.normal,
  );

  final paragraphBuilder = ParagraphBuilder(paragraphStyle);
  print('ParagraphBuilder created');
  print('  runtimeType: ${paragraphBuilder.runtimeType}');

  paragraphBuilder.pushStyle(TextStyle(
    color: Color(0xFF000000),
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
  ));
  paragraphBuilder.addText('Hello from ParagraphBuilder!');
  paragraphBuilder.pop();

  final paragraph = paragraphBuilder.build();
  print('Paragraph built: ${paragraph.runtimeType}');

  paragraph.layout(ParagraphConstraints(width: 300.0));
  print('Paragraph laid out with width 300');
  print('  height: ${paragraph.height}');
  print('  width: ${paragraph.width}');
  print('  minIntrinsicWidth: ${paragraph.minIntrinsicWidth}');
  print('  maxIntrinsicWidth: ${paragraph.maxIntrinsicWidth}');
  print('  alphabeticBaseline: ${paragraph.alphabeticBaseline}');
  print('  ideographicBaseline: ${paragraph.ideographicBaseline}');
  print('  didExceedMaxLines: ${paragraph.didExceedMaxLines}');

  // ========== RETURN WIDGET ==========
  print('dart:ui paragraph test completed');

  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'dart:ui Paragraph Test',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),

          Text('Classes Tested:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8.0),
          Text('• ParagraphStyle - text paragraph styling'),
          Text('• ParagraphConstraints - layout width constraint'),
          Text('• StrutStyle - vertical line metrics'),
          Text('• ParagraphBuilder - builds paragraph objects'),
          Text('• Paragraph - laid out text'),
          SizedBox(height: 16.0),

          Container(
            padding: EdgeInsets.all(8.0),
            color: Color(0xFFE8F5E9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Constraint width: ${constraints1.width}'),
                Text('Paragraph height: ${paragraph.height}'),
                Text('Max intrinsic width: ${paragraph.maxIntrinsicWidth}'),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
