// ignore_for_file: avoid_print
// D4rt test script: Tests Paragraph, ParagraphBuilder, ParagraphStyle, StrutStyle, LineMetrics
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui paragraph tests executing');

  // ========== ParagraphStyle ==========
  print('--- ParagraphStyle Tests ---');
  final ps1 = ui.ParagraphStyle(
    textAlign: TextAlign.left,
    textDirection: TextDirection.ltr,
    maxLines: 3,
    fontSize: 16.0,
    fontWeight: FontWeight.normal,
  );
  print('ParagraphStyle created: $ps1');

  final ps2 = ui.ParagraphStyle(
    textAlign: TextAlign.center,
    textDirection: TextDirection.rtl,
    maxLines: 1,
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    ellipsis: '...',
  );
  print('ParagraphStyle with ellipsis: $ps2');

  // ========== TextStyle (ui) ==========
  print('--- ui.TextStyle Tests ---');
  final ts1 = ui.TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 14.0,
    fontWeight: FontWeight.w500,
  );
  print('ui.TextStyle created: $ts1');

  final ts2 = ui.TextStyle(
    color: Color.fromARGB(255, 255, 0, 0),
    fontSize: 20.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.italic,
    letterSpacing: 1.5,
    wordSpacing: 2.0,
  );
  print('ui.TextStyle bold+italic: $ts2');

  // ========== StrutStyle ==========
  print('--- StrutStyle Tests ---');
  final strut1 = ui.StrutStyle(fontSize: 16.0, forceStrutHeight: true);
  print('StrutStyle created: $strut1');

  // ========== ParagraphBuilder + Paragraph ==========
  print('--- ParagraphBuilder Tests ---');
  final builder1 = ui.ParagraphBuilder(ps1);
  print('ParagraphBuilder created');

  builder1.pushStyle(ts1);
  builder1.addText('Hello, world! This is a test paragraph with multiple words.');
  builder1.pop();
  print('pushStyle + addText + pop done');

  final paragraph1 = builder1.build();
  print('Paragraph built: ${paragraph1.runtimeType}');

  // ========== ParagraphConstraints ==========
  print('--- ParagraphConstraints Tests ---');
  final constraints1 = ui.ParagraphConstraints(width: 200.0);
  print('ParagraphConstraints: width=${constraints1.width}');
  final constraints2 = ui.ParagraphConstraints(width: 500.0);
  print('ParagraphConstraints: width=${constraints2.width}');

  // ========== Layout ==========
  print('--- Paragraph Layout Tests ---');
  paragraph1.layout(constraints1);
  print('Paragraph laid out at width 200');
  print('width: ${paragraph1.width}');
  print('height: ${paragraph1.height}');
  print('minIntrinsicWidth: ${paragraph1.minIntrinsicWidth}');
  print('maxIntrinsicWidth: ${paragraph1.maxIntrinsicWidth}');
  print('alphabeticBaseline: ${paragraph1.alphabeticBaseline}');
  print('ideographicBaseline: ${paragraph1.ideographicBaseline}');
  print('longestLine: ${paragraph1.longestLine}');
  print('didExceedMaxLines: ${paragraph1.didExceedMaxLines}');

  // ========== Multi-style paragraph ==========
  print('--- Multi-style Paragraph ---');
  final builder2 = ui.ParagraphBuilder(ps2);
  builder2.pushStyle(ts1);
  builder2.addText('Normal text ');
  builder2.pop();
  builder2.pushStyle(ts2);
  builder2.addText('Bold red text');
  builder2.pop();
  final paragraph2 = builder2.build();
  paragraph2.layout(constraints2);
  print('Multi-style paragraph: w=${paragraph2.width}, h=${paragraph2.height}');
  print('didExceedMaxLines: ${paragraph2.didExceedMaxLines}');

  // ========== LineMetrics ==========
  print('--- LineMetrics Tests ---');
  final metrics = paragraph1.computeLineMetrics();
  print('Line count: ${metrics.length}');
  if (metrics.isNotEmpty) {
    final line = metrics.first;
    print('Line 0: ascent=${line.ascent}, descent=${line.descent}');
    print('  width=${line.width}, height=${line.height}');
    print('  baseline=${line.baseline}, lineNumber=${line.lineNumber}');
    print('  hardBreak=${line.hardBreak}, left=${line.left}');
  }

  print('All paragraph tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('dart:ui Paragraph Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('ParagraphStyle: 2 configurations'),
            Text('TextStyle: normal + bold+italic'),
            Text('ParagraphBuilder: single + multi-style'),
            Text('Layout: w=${paragraph1.width.toInt()}, h=${paragraph1.height.toInt()}'),
            Text('LineMetrics: ${metrics.length} lines'),
          ],
        ),
      ),
    ),
  );
}
