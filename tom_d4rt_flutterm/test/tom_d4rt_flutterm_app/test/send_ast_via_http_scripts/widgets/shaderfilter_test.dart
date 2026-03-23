// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ShaderMask, BackdropFilter, ImageFiltered,
// ColorFiltered (as widgets), OrientationBuilder, CheckedModeBanner
import 'dart:ui';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Shader/filter widgets test executing');

  // ========== ShaderMask ==========
  print('--- ShaderMask Tests ---');

  final shaderMask = ShaderMask(
    shaderCallback: (Rect bounds) {
      return LinearGradient(
        colors: [Colors.black, Colors.transparent],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(bounds);
    },
    blendMode: BlendMode.dstIn,
    child: Container(width: 100.0, height: 100.0, color: Colors.blue),
  );
  print('ShaderMask created with blendMode: ${shaderMask.blendMode}');

  // ========== BackdropFilter ==========
  print('--- BackdropFilter Tests ---');

  final backdropFilter = BackdropFilter(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    blendMode: BlendMode.srcOver,
    child: Container(
      width: 100.0,
      height: 100.0,
      color: Colors.white.withAlpha(128),
    ),
  );
  print('BackdropFilter created with blendMode: ${backdropFilter.blendMode}');

  // ========== ImageFiltered ==========
  print('--- ImageFiltered Tests ---');

  final imageFiltered = ImageFiltered(
    imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
    child: Container(width: 80.0, height: 80.0, color: Colors.green),
  );
  print('ImageFiltered created');

  // ========== ColorFiltered ==========
  print('--- ColorFiltered Tests ---');

  final colorFiltered = ColorFiltered(
    colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
    child: Container(width: 80.0, height: 80.0, color: Colors.blue),
  );
  print('ColorFiltered created');

  final colorFilteredMatrix = ColorFiltered(
    colorFilter: ColorFilter.matrix([
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.2126,
      0.7152,
      0.0722,
      0.0,
      0.0,
      0.0,
      0.0,
      0.0,
      1.0,
      0.0,
    ]),
    child: Text('Grayscale'),
  );
  print('ColorFiltered with matrix created');

  // ========== CheckedModeBanner ==========
  print('--- CheckedModeBanner Tests ---');

  final banner = CheckedModeBanner(child: Text('Banner child'));
  print('CheckedModeBanner created');

  print('All shader/filter widget tests passed');

  // ========== RETURN WIDGET ==========
  return MaterialApp(
    home: Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Shader/Filter Widget Tests',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
            ),
            SizedBox(height: 8.0),
            shaderMask,
            SizedBox(height: 8.0),
            ClipRect(
              child: Stack(
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.blue,
                    child: Text('Behind'),
                  ),
                  backdropFilter,
                ],
              ),
            ),
            SizedBox(height: 8.0),
            imageFiltered,
            SizedBox(height: 8.0),
            colorFiltered,
            SizedBox(height: 8.0),
            colorFilteredMatrix,
          ],
        ),
      ),
    ),
  );
}
