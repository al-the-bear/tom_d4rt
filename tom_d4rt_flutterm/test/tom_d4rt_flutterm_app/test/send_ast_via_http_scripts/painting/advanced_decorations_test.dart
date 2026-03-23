// ignore_for_file: avoid_print
// D4rt test script: Tests advanced painting — ImageFilter, ColorFilter,
// MaskFilter, Gradient advanced (sweep, radial stops), ShaderMask concept,
// TextHeightBehavior, StrutStyle
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

dynamic build(BuildContext context) {
  print('Advanced painting test executing');

  // ========== ImageFilter ==========
  print('--- ImageFilter Tests ---');
  final blur = ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  print('ImageFilter.blur: sigmaX=5, sigmaY=5 [${blur.hashCode }]');

  final matrix = ui.ImageFilter.matrix(
    Matrix4.identity().storage,
    filterQuality: FilterQuality.high,
  );
  print('ImageFilter.matrix: identity [${matrix.hashCode }]');

  final compose = ui.ImageFilter.compose(
    outer: ui.ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
    inner: ui.ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
  );
  print('ImageFilter.compose: outer+inner blur [${compose.hashCode }]');

  // ========== ColorFilter ==========
  print('--- ColorFilter Tests ---');
  final modeFilter = ColorFilter.mode(Colors.red, BlendMode.srcATop);
  print('ColorFilter.mode: red srcATop [${modeFilter.hashCode }]');

  final matrixFilter = ColorFilter.matrix(<double>[
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
    0,
    0,
    0,
    0,
    1,
    0,
  ]);
  print('ColorFilter.matrix: identity [${matrixFilter.hashCode }]');

  final saturationFilter = ColorFilter.linearToSrgbGamma();
  print('ColorFilter.linearToSrgbGamma created [${saturationFilter.hashCode }]');

  final invGamma = ColorFilter.srgbToLinearGamma();
  print('ColorFilter.srgbToLinearGamma created [${invGamma.hashCode }]');

  // ========== SweepGradient ==========
  print('--- SweepGradient Tests ---');
  final sweep = SweepGradient(
    center: Alignment.center,
    startAngle: 0.0,
    endAngle: 3.14159 * 2,
    colors: [Colors.red, Colors.green, Colors.blue, Colors.red],
    stops: [0.0, 0.33, 0.67, 1.0],
    tileMode: TileMode.clamp,
  );
  print('SweepGradient: 4 colors, full circle');

  // ========== RadialGradient advanced ==========
  print('--- RadialGradient advanced Tests ---');
  final radial = RadialGradient(
    center: Alignment.center,
    radius: 0.5,
    colors: [Colors.white, Colors.blue.shade200, Colors.blue.shade800],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.mirror,
    focal: Alignment(0.1, 0.1),
    focalRadius: 0.05,
  );
  print('RadialGradient: focal point, mirror mode');

  // ========== TextHeightBehavior ==========
  print('--- TextHeightBehavior Tests ---');
  final thb = TextHeightBehavior(
    applyHeightToFirstAscent: true,
    applyHeightToLastDescent: false,
    leadingDistribution: TextLeadingDistribution.proportional,
  );
  print('TextHeightBehavior: applyFirst=true, applyLast=false');
  print('  leadingDistribution: ${thb.leadingDistribution}');

  // ========== TextLeadingDistribution ==========
  print('--- TextLeadingDistribution Tests ---');
  for (final dist in TextLeadingDistribution.values) {
    print('TextLeadingDistribution: ${dist.name}');
  }

  // ========== StrutStyle ==========
  print('--- StrutStyle Tests ---');
  final strut = StrutStyle(
    fontFamily: 'Roboto',
    fontFamilyFallback: ['Arial', 'sans-serif'],
    fontSize: 16.0,
    height: 1.5,
    leading: 0.5,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    forceStrutHeight: false,
    leadingDistribution: TextLeadingDistribution.even,
  );
  print('StrutStyle: fontFamily=Roboto, fontSize=16, height=1.5');
  print('  forceStrutHeight: false');

  // ========== InlineSpan concepts ==========
  print('--- InlineSpan Tests ---');
  final textSpan = TextSpan(
    text: 'Hello ',
    style: TextStyle(color: Colors.black),
    children: [
      TextSpan(
        text: 'World',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: Icon(Icons.star, size: 16),
      ),
    ],
  );
  print('TextSpan with children: text + WidgetSpan');

  // ========== PlaceholderAlignment ==========
  print('--- PlaceholderAlignment Tests ---');
  for (final pa in PlaceholderAlignment.values) {
    print('PlaceholderAlignment: ${pa.name}');
  }

  print('All advanced painting tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Advanced Painting Test',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(gradient: sweep),
            ),
            SizedBox(height: 16.0),
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: radial,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(height: 16.0),
            Text.rich(textSpan, strutStyle: strut, textHeightBehavior: thb),
          ],
        ),
      ),
    ),
  );
}
