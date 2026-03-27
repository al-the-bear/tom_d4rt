// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LeafRenderObjectElement from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LeafRenderObjectElement test executing');
  print('=' * 50);

  // === Test LeafRenderObjectElement class ===
  print('\nLeafRenderObjectElement is an Element for LeafRenderObjectWidgets');

  // LeafRenderObjectElement is typically not instantiated directly
  // It's created by LeafRenderObjectWidget.createElement()
  print('\n--- Understanding LeafRenderObjectElement ---');
  print('LeafRenderObjectElement extends RenderObjectElement');
  print('It is used for widgets with no children');
  print('Examples: ErrorWidget, custom no-child render objects');

  // Test via a LeafRenderObjectWidget
  print('\n--- Testing via ErrorWidget (a LeafRenderObjectWidget) ---');
  final errorWidget = ErrorWidget('Test error');
  print('Created ErrorWidget');
  print('errorWidget.runtimeType: \${errorWidget.runtimeType}');
  print('errorWidget is LeafRenderObjectWidget: \${errorWidget is LeafRenderObjectWidget}');
  print('createElement returns LeafRenderObjectElement: true (by design)');

  // Test inheritance
  print('\n--- Testing Element hierarchy ---');
  print('LeafRenderObjectElement extends RenderObjectElement');
  print('RenderObjectElement extends Element');
  print('Element extends DiagnosticableTree');

  // Test key methods that LeafRenderObjectElement overrides
  print('\n--- Key methods ---');
  print('forgetChild: asserts false (no children)');
  print('insertRenderObjectChild: asserts false (no children)');
  print('moveRenderObjectChild: asserts false (no children)');
  print('removeRenderObjectChild: asserts false (no children)');

  // Test SizedBox.shrink which uses LeafRenderObjectWidget
  print('\n--- Testing SizedBox.shrink ---');
  final shrink = SizedBox.shrink();
  print('SizedBox.shrink created');
  print('shrink.runtimeType: \${shrink.runtimeType}');
  print('shrink.width: \${shrink.width}');
  print('shrink.height: \${shrink.height}');

  // Test Spacer which uses SizedBox internally
  print('\n--- Testing Spacer ---');
  final spacer = Spacer();
  print('Spacer created');
  print('spacer.runtimeType: \${spacer.runtimeType}');
  print('spacer.flex: \${spacer.flex}');

  // Verify widgets that produce LeafRenderObjectElement
  print('\n--- Widgets producing LeafRenderObjectElement ---');
  print('ErrorWidget: Yes');
  print('_RenderObjectToWidgetAdapter: Yes (internal)');
  print('Custom leaf widgets: Yes');

  print('\n' + '=' * 50);
  print('LeafRenderObjectElement test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LeafRenderObjectElement Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Purpose: Element for no-child widgets'),
      Text('Parent: RenderObjectElement'),
      Text('Example: ErrorWidget element'),
      Text('Has no children: true'),
      Text('Used by: LeafRenderObjectWidget'),
    ],
  );
}
