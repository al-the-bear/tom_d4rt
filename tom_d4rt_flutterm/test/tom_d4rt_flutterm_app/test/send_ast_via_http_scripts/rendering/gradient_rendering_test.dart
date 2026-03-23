// ignore_for_file: avoid_print
// D4rt test script: Tests LinearGradient, RadialGradient, SweepGradient in rendering context with createShader
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Gradient rendering test executing');

  // ========== LINEAR GRADIENT ==========
  print('--- LinearGradient Tests ---');

  final linearGrad = LinearGradient(colors: [Colors.red, Colors.blue]);
  print('LinearGradient created: ${linearGrad.runtimeType}');
  print('  begin: ${linearGrad.begin}');
  print('  end: ${linearGrad.end}');
  print('  colors: ${linearGrad.colors}');
  print('  tileMode: ${linearGrad.tileMode}');

  final linearGradCustom = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.red, Colors.yellow, Colors.green],
    stops: [0.0, 0.5, 1.0],
    tileMode: TileMode.clamp,
  );
  print('LinearGradient(custom):');
  print('  begin: ${linearGradCustom.begin}');
  print('  end: ${linearGradCustom.end}');
  print('  colors count: ${linearGradCustom.colors.length}');
  print('  stops: ${linearGradCustom.stops}');
  print('  tileMode: ${linearGradCustom.tileMode}');

  // Create shader from gradient (rendering-specific usage)
  final linearShaderRect = Rect.fromLTWH(0, 0, 200, 200);
  final linearShader = linearGrad.createShader(linearShaderRect);
  print('LinearGradient.createShader: ${linearShader.runtimeType}');

  final linearShaderCustom = linearGradCustom.createShader(
    Rect.fromLTWH(0, 0, 100, 300),
  );
  print(
    'LinearGradient(custom).createShader: ${linearShaderCustom.runtimeType}',
  );

  // ========== RADIAL GRADIENT ==========
  print('--- RadialGradient Tests ---');

  final radialGrad = RadialGradient(colors: [Colors.white, Colors.black]);
  print('RadialGradient created: ${radialGrad.runtimeType}');
  print('  center: ${radialGrad.center}');
  print('  radius: ${radialGrad.radius}');
  print('  colors: ${radialGrad.colors}');
  print('  tileMode: ${radialGrad.tileMode}');

  final radialGradCustom = RadialGradient(
    center: Alignment.center,
    radius: 0.8,
    colors: [Colors.orange, Colors.purple, Colors.transparent],
    stops: [0.0, 0.7, 1.0],
    tileMode: TileMode.mirror,
  );
  print('RadialGradient(custom):');
  print('  center: ${radialGradCustom.center}');
  print('  radius: ${radialGradCustom.radius}');
  print('  colors count: ${radialGradCustom.colors.length}');
  print('  stops: ${radialGradCustom.stops}');
  print('  tileMode: ${radialGradCustom.tileMode}');

  final radialGradFocal = RadialGradient(
    center: Alignment.center,
    radius: 0.5,
    colors: [Colors.blue, Colors.green],
    focal: Alignment(-0.1, 0.6),
    focalRadius: 0.1,
  );
  print('RadialGradient(focal):');
  print('  focal: ${radialGradFocal.focal}');
  print('  focalRadius: ${radialGradFocal.focalRadius}');

  // Create shader from radial gradient
  final radialShader = radialGrad.createShader(Rect.fromLTWH(0, 0, 200, 200));
  print('RadialGradient.createShader: ${radialShader.runtimeType}');

  // ========== SWEEP GRADIENT ==========
  print('--- SweepGradient Tests ---');

  final sweepGrad = SweepGradient(
    colors: [Colors.red, Colors.green, Colors.blue, Colors.red],
  );
  print('SweepGradient created: ${sweepGrad.runtimeType}');
  print('  center: ${sweepGrad.center}');
  print('  startAngle: ${sweepGrad.startAngle}');
  print('  endAngle: ${sweepGrad.endAngle}');
  print('  colors count: ${sweepGrad.colors.length}');
  print('  tileMode: ${sweepGrad.tileMode}');

  final sweepGradCustom = SweepGradient(
    center: Alignment(0.0, 0.0),
    startAngle: 0.0,
    endAngle: 3.14159 * 2,
    colors: [Colors.cyan, Colors.pink, Colors.yellow, Colors.cyan],
    stops: [0.0, 0.33, 0.67, 1.0],
    tileMode: TileMode.clamp,
  );
  print('SweepGradient(custom):');
  print('  startAngle: ${sweepGradCustom.startAngle}');
  print('  endAngle: ${sweepGradCustom.endAngle}');
  print('  stops: ${sweepGradCustom.stops}');

  // Create shader from sweep gradient
  final sweepShader = sweepGrad.createShader(Rect.fromLTWH(0, 0, 200, 200));
  print('SweepGradient.createShader: ${sweepShader.runtimeType}');

  // ========== TILE MODE ENUM ==========
  print('--- TileMode values ---');
  print('TileMode.clamp: ${TileMode.clamp}');
  print('TileMode.repeated: ${TileMode.repeated}');
  print('TileMode.mirror: ${TileMode.mirror}');
  print('TileMode.decal: ${TileMode.decal}');

  // ========== GRADIENT IN PAINT ==========
  print('--- Gradient with Paint ---');

  final paint = Paint();
  paint.shader = linearGrad.createShader(Rect.fromLTWH(0, 0, 100, 100));
  print('Paint with gradient shader: ${paint.shader.runtimeType}');

  // ========== GRADIENT IN DECORATION ==========
  print('--- Gradient in BoxDecoration ---');

  final decoration = BoxDecoration(
    gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
  );
  print('BoxDecoration with gradient: ${decoration.runtimeType}');
  print('  gradient: ${decoration.gradient.runtimeType}');

  final radialDecoration = BoxDecoration(
    gradient: RadialGradient(colors: [Colors.white, Colors.grey], radius: 1.0),
  );
  print(
    'BoxDecoration with radial gradient: ${radialDecoration.gradient.runtimeType}',
  );

  final sweepDecoration = BoxDecoration(
    gradient: SweepGradient(colors: [Colors.red, Colors.blue, Colors.red]),
  );
  print(
    'BoxDecoration with sweep gradient: ${sweepDecoration.gradient.runtimeType}',
  );

  // ========== GRADIENT SCALE ==========
  print('--- Gradient scale ---');

  final scaledLinear = linearGrad.scale(0.5);
  print('LinearGradient.scale(0.5): ${scaledLinear.runtimeType}');

  final scaledRadial = radialGrad.scale(0.5);
  print('RadialGradient.scale(0.5): ${scaledRadial.runtimeType}');

  // ========== GRADIENT LERP ==========
  // Note: Gradient.lerp and LinearGradient.lerp are not bridged yet
  // (static methods on abstract Gradient class). Skip for now.

  print('Gradient rendering test completed');
  return Text('Gradient rendering test passed');
}
