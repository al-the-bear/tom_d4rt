// D4rt test script: Tests ShaderMaskLayer from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ShaderMaskLayer test executing');
  final results = <String>[];

  // ========== Section 1: Basic ShaderMaskLayer Creation ==========
  print('--- Section 1: Basic ShaderMaskLayer Creation ---');
  
  // Create a simple gradient shader
  final gradient = LinearGradient(
    colors: [Color(0xFFFF0000), Color(0xFF0000FF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  final shader = gradient.createShader(Rect.fromLTWH(0, 0, 100, 100));
  
  final layer = ShaderMaskLayer();
  print('Created ShaderMaskLayer: ${layer.runtimeType}');
  results.add('ShaderMaskLayer created');

  // ========== Section 2: Setting Shader ==========
  print('--- Section 2: Setting Shader ---');
  
  layer.shader = shader;
  print('Shader set: ${layer.shader != null}');
  print('Shader type: ${layer.shader?.runtimeType}');
  results.add('Shader set: ${layer.shader != null}');

  // ========== Section 3: Setting MaskRect ==========
  print('--- Section 3: Setting MaskRect ---');
  
  final maskRect = Rect.fromLTWH(0, 0, 200, 150);
  layer.maskRect = maskRect;
  print('MaskRect set: ${layer.maskRect}');
  results.add('MaskRect: ${layer.maskRect}');

  // ========== Section 4: BlendMode ==========
  print('--- Section 4: BlendMode ---');
  
  layer.blendMode = BlendMode.srcIn;
  print('BlendMode set: ${layer.blendMode}');
  
  // Try different blend modes
  final blendModes = [
    BlendMode.srcOver,
    BlendMode.srcIn,
    BlendMode.srcOut,
    BlendMode.dstIn,
    BlendMode.dstOut,
    BlendMode.multiply,
    BlendMode.screen,
  ];
  
  print('Testing different blend modes:');
  for (final mode in blendModes) {
    layer.blendMode = mode;
    print('  ${mode.name}: set successfully');
  }
  results.add('BlendModes tested: ${blendModes.length}');

  // ========== Section 5: Layer Hierarchy ==========
  print('--- Section 5: Layer Hierarchy ---');
  
  print('ShaderMaskLayer parent: ${layer.parent}');
  print('ShaderMaskLayer is ContainerLayer: ${layer is ContainerLayer}');
  
  // ShaderMaskLayer extends ContainerLayer
  final containerCheck = layer as ContainerLayer;
  print('First child: ${containerCheck.firstChild}');
  print('Last child: ${containerCheck.lastChild}');
  results.add('Layer hierarchy verified');

  // ========== Section 6: New Layer with Different Gradients ==========
  print('--- Section 6: Different Gradients ---');
  
  // Radial gradient
  final radialGradient = RadialGradient(
    colors: [Color(0xFFFFFF00), Color(0xFF00FF00)],
    center: Alignment.center,
    radius: 0.5,
  );
  final radialShader = radialGradient.createShader(Rect.fromLTWH(0, 0, 100, 100));
  
  final radialLayer = ShaderMaskLayer()
    ..shader = radialShader
    ..maskRect = Rect.fromLTWH(0, 0, 100, 100)
    ..blendMode = BlendMode.modulate;
  
  print('Radial gradient layer created');
  print('Radial shader: ${radialLayer.shader != null}');
  results.add('Radial gradient layer created');
  
  // Sweep gradient
  final sweepGradient = SweepGradient(
    colors: [Color(0xFFFF0000), Color(0xFF00FF00), Color(0xFF0000FF)],
    startAngle: 0.0,
    endAngle: 3.14159 * 2,
  );
  final sweepShader = sweepGradient.createShader(Rect.fromLTWH(0, 0, 100, 100));
  
  final sweepLayer = ShaderMaskLayer()
    ..shader = sweepShader
    ..maskRect = Rect.fromLTWH(50, 50, 150, 150)
    ..blendMode = BlendMode.overlay;
  
  print('Sweep gradient layer created');
  results.add('Sweep gradient layer created');

  // ========== Section 7: Append and Remove Children ==========
  print('--- Section 7: Append Children ---');
  
  final parentLayer = ShaderMaskLayer();
  final childLayer = OffsetLayer(offset: Offset(10, 20));
  
  parentLayer.append(childLayer);
  print('Child appended: ${parentLayer.firstChild != null}');
  print('First child type: ${parentLayer.firstChild?.runtimeType}');
  results.add('Child layer appended');

  // ========== Section 8: Multiple Mask Rects ==========
  print('--- Section 8: Multiple Mask Rects ---');
  
  final rects = [
    Rect.fromLTWH(0, 0, 50, 50),
    Rect.fromLTWH(100, 100, 200, 200),
    Rect.fromLTWH(-50, -50, 100, 100),
    Rect.zero,
  ];
  
  for (final rect in rects) {
    final testLayer = ShaderMaskLayer()..maskRect = rect;
    print('MaskRect $rect: ${testLayer.maskRect}');
  }
  results.add('Tested ${rects.length} mask rects');

  // ========== Section 9: EngineLayer ==========
  print('--- Section 9: EngineLayer Reference ---');
  
  print('Layer engineLayer: ${layer.engineLayer}');
  results.add('EngineLayer accessible');

  // ========== Section 10: ToString ==========
  print('--- Section 10: ToString ---');
  
  print('layer.toString(): ${layer.toString()}');
  results.add('ToString available');

  print('ShaderMaskLayer test completed');
  return SingleChildScrollView(
    child: Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('ShaderMaskLayer Tests',
               style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          ...results.map((r) => Padding(
            padding: EdgeInsets.symmetric(vertical: 2),
            child: Text('✓ $r', style: TextStyle(fontSize: 14)),
          )),
        ],
      ),
    ),
  );
}
