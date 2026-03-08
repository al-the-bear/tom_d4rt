// D4rt test script: Tests TextPosition, TextRange, TextBox, TextDecoration, TextHeightBehavior, FontFeature, FontVariation
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('dart:ui text typography tests executing');

  // ========== TextPosition ==========
  print('--- TextPosition Tests ---');
  final tp1 = TextPosition(offset: 5);
  print('TextPosition: offset=${tp1.offset}, affinity=${tp1.affinity}');
  final tp2 = TextPosition(offset: 10, affinity: TextAffinity.upstream);
  print('TextPosition upstream: offset=${tp2.offset}, affinity=${tp2.affinity}');
  final tp3 = TextPosition(offset: 0, affinity: TextAffinity.downstream);
  print('TextPosition downstream: offset=${tp3.offset}');
  print('tp1 == tp1: ${tp1 == tp1}');
  print('tp1.hashCode: ${tp1.hashCode}');

  // ========== TextRange ==========
  print('--- TextRange Tests ---');
  final tr1 = TextRange(start: 0, end: 10);
  print('TextRange(0,10): start=${tr1.start}, end=${tr1.end}');
  print('isValid: ${tr1.isValid}');
  print('isCollapsed: ${tr1.isCollapsed}');
  print('isNormalized: ${tr1.isNormalized}');
  final tr2 = TextRange.collapsed(5);
  print('TextRange.collapsed(5): start=${tr2.start}, end=${tr2.end}, isCollapsed=${tr2.isCollapsed}');
  final tr3 = TextRange.empty;
  print('TextRange.empty: start=${tr3.start}, end=${tr3.end}');
  print('textBefore: ${tr1.textBefore("Hello World")}');
  print('textAfter: ${tr1.textAfter("Hello World")}');
  print('textInside: ${tr1.textInside("Hello World")}');

  // ========== TextDecoration ==========
  print('--- TextDecoration Tests ---');
  print('TextDecoration.none: ${TextDecoration.none}');
  print('TextDecoration.underline: ${TextDecoration.underline}');
  print('TextDecoration.overline: ${TextDecoration.overline}');
  print('TextDecoration.lineThrough: ${TextDecoration.lineThrough}');
  final combined = TextDecoration.combine([TextDecoration.underline, TextDecoration.overline]);
  print('TextDecoration.combine: $combined');
  print('contains underline: ${combined.contains(TextDecoration.underline)}');
  print('contains lineThrough: ${combined.contains(TextDecoration.lineThrough)}');

  // ========== TextHeightBehavior ==========
  print('--- TextHeightBehavior Tests ---');
  final thb1 = TextHeightBehavior();
  print('TextHeightBehavior default: applyFirst=${thb1.applyHeightToFirstAscent}, applyLast=${thb1.applyHeightToLastDescent}');
  final thb2 = TextHeightBehavior(
    applyHeightToFirstAscent: false,
    applyHeightToLastDescent: true,
    leadingDistribution: TextLeadingDistribution.even,
  );
  print('TextHeightBehavior custom: applyFirst=${thb2.applyHeightToFirstAscent}, leading=${thb2.leadingDistribution}');

  // ========== FontFeature ==========
  print('--- FontFeature Tests ---');
  final ff1 = FontFeature('liga');
  print('FontFeature liga: ${ff1.feature}, value=${ff1.value}');
  final ff2 = FontFeature('smcp', 1);
  print('FontFeature smcp: ${ff2.feature}, value=${ff2.value}');
  final ff3 = FontFeature.enable('kern');
  print('FontFeature.enable kern: ${ff3.feature}');
  final ff4 = FontFeature.disable('liga');
  print('FontFeature.disable liga: ${ff4.feature}, value=${ff4.value}');
  final ff5 = FontFeature.tabularFigures();
  print('FontFeature.tabularFigures: ${ff5.feature}');
  final ff6 = FontFeature.oldstyleFigures();
  print('FontFeature.oldstyleFigures: ${ff6.feature}');

  // ========== FontVariation ==========
  print('--- FontVariation Tests ---');
  final fv1 = FontVariation('wght', 400.0);
  print('FontVariation wght: axis=${fv1.axis}, value=${fv1.value}');
  final fv2 = FontVariation('wdth', 100.0);
  print('FontVariation wdth: axis=${fv2.axis}, value=${fv2.value}');
  final fv3 = FontVariation.weight(700.0);
  print('FontVariation.weight(700): axis=${fv3.axis}, value=${fv3.value}');

  // ========== TextBox ==========
  print('--- TextBox Tests ---');
  final tb1 = TextBox.fromLTRBD(10.0, 20.0, 100.0, 40.0, TextDirection.ltr);
  print('TextBox: left=${tb1.left}, top=${tb1.top}, right=${tb1.right}, bottom=${tb1.bottom}');
  print('direction: ${tb1.direction}');
  print('start: ${tb1.start}, end: ${tb1.end}');
  final tb2 = TextBox.fromLTRBD(50.0, 0.0, 200.0, 30.0, TextDirection.rtl);
  print('TextBox RTL: start=${tb2.start}, end=${tb2.end}');
  print('toRect: ${tb1.toRect()}');

  print('All text typography tests passed');

  return MaterialApp(
    home: Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('dart:ui Text Typography Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
            SizedBox(height: 16.0),
            Text('TextPosition: 3 instances'),
            Text('TextRange: normal, collapsed, empty'),
            Text('TextDecoration: 4 types + combine'),
            Text('TextHeightBehavior: default + custom'),
            Text('FontFeature: liga, smcp, kern, tabular'),
            Text('FontVariation: wght, wdth, weight()'),
            Text('TextBox: LTR + RTL'),
          ],
        ),
      ),
    ),
  );
}
