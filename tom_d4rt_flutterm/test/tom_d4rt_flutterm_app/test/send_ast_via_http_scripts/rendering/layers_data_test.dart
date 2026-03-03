// D4rt test script: Tests OpacityLayer, TransformLayer, ClipRectLayer, ClipRRectLayer, ImageFilterLayer, BackdropFilterLayer
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('Layers data test executing');

  // ========== OPACITY LAYER ==========
  print('--- OpacityLayer Tests ---');

  final opacityLayer = OpacityLayer(alpha: 128);
  print('OpacityLayer(128) created: ${opacityLayer.runtimeType}');
  print('  alpha: ${opacityLayer.alpha}');

  final opacityLayerFull = OpacityLayer(alpha: 255);
  print('OpacityLayer(255) alpha: ${opacityLayerFull.alpha}');

  final opacityLayerZero = OpacityLayer(alpha: 0);
  print('OpacityLayer(0) alpha: ${opacityLayerZero.alpha}');

  final opacityLayerWithOffset = OpacityLayer(
    alpha: 200,
    offset: Offset(10.0, 20.0),
  );
  print('OpacityLayer(200, offset):');
  print('  alpha: ${opacityLayerWithOffset.alpha}');
  print('  offset: ${opacityLayerWithOffset.offset}');

  // Modify alpha
  opacityLayer.alpha = 64;
  print('After setting alpha to 64: ${opacityLayer.alpha}');

  // Modify offset
  opacityLayer.offset = Offset(5.0, 10.0);
  print('After setting offset: ${opacityLayer.offset}');

  // ========== TRANSFORM LAYER ==========
  print('--- TransformLayer Tests ---');

  final transformLayer = TransformLayer();
  print('TransformLayer() created: ${transformLayer.runtimeType}');

  final transformLayerIdentity = TransformLayer(
    transform: Matrix4.identity(),
  );
  print(
    'TransformLayer(identity) created: ${transformLayerIdentity.runtimeType}',
  );

  final transformLayerTranslate = TransformLayer(
    transform: Matrix4.translationValues(50.0, 100.0, 0.0),
  );
  print('TransformLayer(translate) created');
  print('  transform: ${transformLayerTranslate.transform}');

  final transformLayerScale = TransformLayer(
    transform: Matrix4.diagonal3Values(2.0, 2.0, 1.0),
  );
  print('TransformLayer(scale) created');

  final transformLayerWithOffset = TransformLayer(
    transform: Matrix4.identity(),
    offset: Offset(10.0, 20.0),
  );
  print('TransformLayer with offset: ${transformLayerWithOffset.offset}');

  // Modify transform
  transformLayer.transform = Matrix4.rotationZ(0.5);
  print('After setting transform: ${transformLayer.transform}');

  // ========== CLIP RECT LAYER ==========
  print('--- ClipRectLayer Tests ---');

  final clipRectLayer = ClipRectLayer(
    clipRect: Rect.fromLTWH(0, 0, 100, 80),
  );
  print('ClipRectLayer created: ${clipRectLayer.runtimeType}');
  print('  clipRect: ${clipRectLayer.clipRect}');
  print('  clipBehavior: ${clipRectLayer.clipBehavior}');

  final clipRectLayerAntiAlias = ClipRectLayer(
    clipRect: Rect.fromLTWH(10, 10, 200, 150),
    clipBehavior: Clip.antiAlias,
  );
  print(
    'ClipRectLayer(antiAlias) clipBehavior: ${clipRectLayerAntiAlias.clipBehavior}',
  );

  // Modify clipRect
  clipRectLayer.clipRect = Rect.fromLTWH(5, 5, 90, 70);
  print('After setting clipRect: ${clipRectLayer.clipRect}');

  // ========== CLIP RRECT LAYER ==========
  print('--- ClipRRectLayer Tests ---');

  final clipRRectLayer = ClipRRectLayer(
    clipRRect: RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, 100, 80),
      Radius.circular(12.0),
    ),
  );
  print('ClipRRectLayer created: ${clipRRectLayer.runtimeType}');
  print('  clipRRect: ${clipRRectLayer.clipRRect}');

  final clipRRectCustomCorners = ClipRRectLayer(
    clipRRect: RRect.fromRectAndCorners(
      Rect.fromLTWH(0, 0, 100, 80),
      topLeft: Radius.circular(8.0),
      topRight: Radius.circular(16.0),
      bottomLeft: Radius.circular(4.0),
      bottomRight: Radius.circular(24.0),
    ),
  );
  print('ClipRRectLayer(custom corners) created');

  // ========== IMAGE FILTER LAYER ==========
  print('--- ImageFilterLayer Tests ---');

  final blurFilter = ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0);
  final imageFilterLayer = ImageFilterLayer(imageFilter: blurFilter);
  print('ImageFilterLayer(blur) created: ${imageFilterLayer.runtimeType}');

  final imageFilterLayerOffset = ImageFilterLayer(
    imageFilter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
    offset: Offset(0.0, 0.0),
  );
  print('ImageFilterLayer(blur, offset) created');

  // ========== BACKDROP FILTER LAYER ==========
  print('--- BackdropFilterLayer Tests ---');

  final backdropFilter = BackdropFilterLayer(
    filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
  );
  print('BackdropFilterLayer created: ${backdropFilter.runtimeType}');

  final backdropFilterWithBlend = BackdropFilterLayer(
    filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
    blendMode: BlendMode.srcOver,
  );
  print('BackdropFilterLayer(blend) created');
  print('  blendMode: ${backdropFilterWithBlend.blendMode}');

  // ========== OFFSET LAYER ==========
  print('--- OffsetLayer Tests ---');

  final offsetLayer = OffsetLayer();
  print('OffsetLayer() created: ${offsetLayer.runtimeType}');

  offsetLayer.offset = Offset(25.0, 50.0);
  print('OffsetLayer offset: ${offsetLayer.offset}');

  final offsetLayerDirect = OffsetLayer(offset: Offset(10.0, 20.0));
  print('OffsetLayer(10,20) offset: ${offsetLayerDirect.offset}');

  // ========== CLIP PATH LAYER ==========
  print('--- ClipPathLayer Tests ---');

  final path = Path()
    ..addOval(Rect.fromCircle(center: Offset(50, 50), radius: 40));
  final clipPathLayer = ClipPathLayer(clipPath: path);
  print('ClipPathLayer created: ${clipPathLayer.runtimeType}');
  print('  clipBehavior: ${clipPathLayer.clipBehavior}');

  final clipPathLayerAntiAlias = ClipPathLayer(
    clipPath: path,
    clipBehavior: Clip.antiAlias,
  );
  print(
    'ClipPathLayer(antiAlias) clipBehavior: ${clipPathLayerAntiAlias.clipBehavior}',
  );

  print('Layers data test completed');
  return Container(child: Text('Layers data test passed'));
}
