// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TransformationController from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TransformationController test executing');
  print('=' * 50);

  // TransformationController extends ValueNotifier<Matrix4>
  print('TransformationController overview:');
  print('  - Extends ValueNotifier<Matrix4>');
  print('  - Controls transformation for InteractiveViewer');
  print('  - Manages pan, zoom, rotation state');
  print('  - Notifies listeners on changes');

  // Constructor
  print('\nConstructor:');
  print('  - TransformationController([Matrix4? value])');
  print('  - Defaults to Matrix4.identity()');
  final controller = TransformationController();
  print('  Initial value: ${controller.value}');

  // toScene method
  print('\ntoScene() method:');
  print('  - Converts viewport point to scene');
  print('  - Applies inverse transformation');
  print('  - Returns Offset in scene coordinates');
  final viewportPoint = Offset(100, 200);
  final scenePoint = controller.toScene(viewportPoint);
  print('  Viewport: $viewportPoint -> Scene: $scenePoint');

  // Setting transformation
  print('\nSetting transformation:');
  final scale2x = Matrix4.identity()..scale(2.0, 2.0);
  controller.value = scale2x;
  print('  Set 2x scale');
  print('  Value: ${controller.value}');

  // toScene with scale
  print('\ntoScene with 2x scale:');
  final scaledScene = controller.toScene(viewportPoint);
  print('  Viewport: $viewportPoint -> Scene: $scaledScene');
  print('  (Points in scene are half viewport coords)');

  // Reset to identity
  controller.value = Matrix4.identity();

  // Translation
  print('\nTranslation example:');
  final translated = Matrix4.identity()..translate(50.0, 100.0);
  controller.value = translated;
  print('  Translated by (50, 100)');
  final transScene = controller.toScene(Offset.zero);
  print('  Viewport (0,0) -> Scene: $transScene');

  // Combining transformations
  print('\nCombining transformations:');
  final combined = Matrix4.identity()
    ..translate(50.0, 50.0)
    ..scale(1.5, 1.5);
  controller.value = combined;
  print('  Translate + Scale applied');

  // Listening to changes
  print('\nListening to changes:');
  print('  - addListener() for notifications');
  print('  - Fires on value assignment');
  print('  - Used by InteractiveViewer');
  print('  - Can animate value changes');

  // With InteractiveViewer
  print('\nUsage with InteractiveViewer:');
  print('  - Pass to transformationController parameter');
  print('  - Read to get current transform');
  print('  - Write to programmatically transform');
  print('  - Survives rebuild cycles');

  controller.dispose();

  print('\n' + '=' * 50);
  print('TransformationController test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TransformationController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ValueNotifier<Matrix4>'),
      Text('Key method: toScene(Offset)'),
      Text('Use: InteractiveViewer control'),
    ],
  );
}
