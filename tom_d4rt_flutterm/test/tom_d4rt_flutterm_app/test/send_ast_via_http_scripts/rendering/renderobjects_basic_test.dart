// D4rt test script: Tests RenderProxyBox, RenderOpacity, RenderTransform
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

dynamic build(BuildContext context) {
  print('RenderObjects basic test executing');

  // ========== RENDER PROXY BOX ==========
  print('--- RenderProxyBox Tests ---');

  final proxyBox = RenderProxyBox();
  print('RenderProxyBox created: ${proxyBox.runtimeType}');
  print('  proxyBox created successfully');

  // Can set a child (another RenderBox) if available
  // proxyBox.child = someChild;
  // For now just verify construction
  print('  hasSize: false (not laid out)');

  // ========== RENDER OPACITY ==========
  print('--- RenderOpacity Tests ---');

  final opacityHalf = RenderOpacity(opacity: 0.5);
  print('RenderOpacity(0.5) created: ${opacityHalf.runtimeType}');
  print('  opacity: ${opacityHalf.opacity}');
  print('  alwaysIncludeSemantics: ${opacityHalf.alwaysIncludeSemantics}');

  final opacityZero = RenderOpacity(opacity: 0.0);
  print('RenderOpacity(0.0) opacity: ${opacityZero.opacity}');

  final opacityFull = RenderOpacity(opacity: 1.0);
  print('RenderOpacity(1.0) opacity: ${opacityFull.opacity}');

  final opacityWithSemantics = RenderOpacity(
    opacity: 0.8,
    alwaysIncludeSemantics: true,
  );
  print(
    'RenderOpacity(0.8, semantics=true) alwaysIncludeSemantics: ${opacityWithSemantics.alwaysIncludeSemantics}',
  );

  // Modify opacity
  opacityHalf.opacity = 0.75;
  print('After setting opacity to 0.75: ${opacityHalf.opacity}');

  // ========== RENDER TRANSFORM ==========
  print('--- RenderTransform Tests ---');

  final identityTransform = RenderTransform(transform: Matrix4.identity());
  print('RenderTransform(identity) created: ${identityTransform.runtimeType}');

  // Test with translation
  final translationMatrix = Matrix4.translationValues(10.0, 20.0, 0.0);
  final translateTransform = RenderTransform(transform: translationMatrix);
  print(
    'RenderTransform(translate) created: ${translateTransform.runtimeType}',
  );

  // Test with rotation
  final rotationMatrix = Matrix4.rotationZ(0.5);
  final rotateTransform = RenderTransform(transform: rotationMatrix);
  print('RenderTransform(rotateZ) created: ${rotateTransform.runtimeType}');

  // Test with scale
  final scaleMatrix = Matrix4.diagonal3Values(2.0, 2.0, 1.0);
  final scaleTransform = RenderTransform(transform: scaleMatrix);
  print('RenderTransform(scale) created: ${scaleTransform.runtimeType}');

  // Test with origin
  final originTransform = RenderTransform(
    transform: Matrix4.identity(),
    origin: Offset(50.0, 50.0),
  );
  print('RenderTransform with origin created: ${originTransform.runtimeType}');

  // Test with alignment
  final alignedTransform = RenderTransform(
    transform: Matrix4.identity(),
    alignment: Alignment.center,
  );
  print(
    'RenderTransform with alignment created: ${alignedTransform.runtimeType}',
  );

  // Test with textDirection
  final textDirTransform = RenderTransform(
    transform: Matrix4.identity(),
    textDirection: TextDirection.ltr,
  );
  print(
    'RenderTransform with textDirection created: ${textDirTransform.runtimeType}',
  );

  // Note: Cannot call layout() or paint() on orphan render objects
  // They require a parent render tree to function
  print('Note: render objects not laid out - no parent render tree attached');

  print('RenderObjects basic test completed');
  return Container(child: Text('RenderObjects basic test passed'));
}
