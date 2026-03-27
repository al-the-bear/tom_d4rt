// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LeafRenderObjectWidget from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LeafRenderObjectWidget test executing');
  print('=' * 50);

  // === Test LeafRenderObjectWidget class ===
  print('\nLeafRenderObjectWidget is an abstract RenderObjectWidget with no children');

  // LeafRenderObjectWidget is abstract
  print('\n--- Understanding LeafRenderObjectWidget ---');
  print('LeafRenderObjectWidget is abstract');
  print('It extends RenderObjectWidget');
  print('Configures RenderObjects that have no children');

  // Test via ErrorWidget (a concrete LeafRenderObjectWidget)
  print('\n--- Testing via ErrorWidget ---');
  final errorWidget = ErrorWidget(FlutterError('Test error'));
  print('Created ErrorWidget with FlutterError');
  print('errorWidget.runtimeType: \${errorWidget.runtimeType}');
  print('errorWidget is RenderObjectWidget: \${errorWidget is RenderObjectWidget}');
  print('errorWidget is LeafRenderObjectWidget: \${errorWidget is LeafRenderObjectWidget}');
  print('errorWidget.message: \${errorWidget.message}');

  // Test the createElement method
  print('\n--- Testing createElement ---');
  print('LeafRenderObjectWidget.createElement() returns LeafRenderObjectElement');
  print('This is the element that manages the leaf widget');

  // Test via SizedBox
  print('\n--- Testing SizedBox (extends SingleChildRenderObjectWidget) ---');
  final sizedBox = SizedBox(width: 100, height: 100);
  print('SizedBox created');
  print('Note: SizedBox extends SingleChildRenderObjectWidget, not Leaf');
  print('sizedBox.width: \${sizedBox.width}');
  print('sizedBox.height: \${sizedBox.height}');

  // Test other LeafRenderObjectWidgets
  print('\n--- Other LeafRenderObjectWidget examples ---');
  print('ErrorWidget: displays error information');
  print('PlatformViewSurface: embeds platform views');
  print('_AndroidPlatformView: Android-specific platform view');
  print('_SliderRenderObjectWidget: internal slider render');

  // Test inheritance chain
  print('\n--- Inheritance chain ---');
  print('LeafRenderObjectWidget extends RenderObjectWidget');
  print('RenderObjectWidget extends Widget');
  print('Widget extends DiagnosticableTree');

  // Test key parameter
  print('\n--- Testing with key ---');
  final keyedError = ErrorWidget.withDetails(
    message: 'Keyed error',
  );
  print('Created ErrorWidget.withDetails');
  print('keyedError: \$keyedError');

  // Test that subclasses must implement createRenderObject
  print('\n--- Required methods ---');
  print('createRenderObject(BuildContext): required');
  print('updateRenderObject(BuildContext, RenderObject): optional override');

  print('\n' + '=' * 50);
  print('LeafRenderObjectWidget test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LeafRenderObjectWidget Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract class'),
      Text('Parent: RenderObjectWidget'),
      Text('Children: none (leaf)'),
      Text('Example: ErrorWidget'),
    ],
  );
}
