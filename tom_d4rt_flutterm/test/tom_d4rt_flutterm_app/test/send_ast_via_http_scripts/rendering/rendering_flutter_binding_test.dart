// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderingFlutterBinding from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RenderingFlutterBinding test executing');
  print('=' * 50);

  // RenderingFlutterBinding is a concrete class
  print('\nRenderingFlutterBinding:');
  print('Extends: BindingBase');
  print('Mixins: GestureBinding, SchedulerBinding, ServicesBinding,');
  print('  SemanticsBinding, PaintingBinding, RendererBinding');
  print('Purpose: Concrete binding for rendering without widgets layer');

  // When to use
  print('\nWhen to use:');
  print('  Use when you want rendering without the widgets framework');
  print('  For pure render-object apps without Widget/Element trees');
  print('  Most apps use WidgetsFlutterBinding instead');

  // Static method
  print('\nStatic method:');
  print('  RenderingFlutterBinding.ensureInitialized()');
  print('  Returns: RendererBinding');
  print('  Creates RenderingFlutterBinding if no binding exists');

  // Difference from WidgetsFlutterBinding
  print('\nDifference from WidgetsFlutterBinding:');
  print('  RenderingFlutterBinding:');
  print('    - GestureBinding');
  print('    - SchedulerBinding');
  print('    - ServicesBinding');
  print('    - SemanticsBinding');
  print('    - PaintingBinding');
  print('    - RendererBinding');
  print('');
  print('  WidgetsFlutterBinding adds:');
  print('    - WidgetsBinding (Widget tree, Element tree)');

  // Binding initialization order
  print('\nBinding initialization order:');
  print('  1. BindingBase.initInstances()');
  print('  2. GestureBinding.initInstances()');
  print('  3. SchedulerBinding.initInstances()');
  print('  4. ServicesBinding.initInstances()');
  print('  5. SemanticsBinding.initInstances()');
  print('  6. PaintingBinding.initInstances()');
  print('  7. RendererBinding.initInstances()');

  // Use case: render object testing
  print('\nPractical use:');
  print('  void main() {');
  print('    final binding = RenderingFlutterBinding.ensureInitialized();');
  print('    // Work with render objects directly');
  print('    // No Widget or Element layer needed');
  print('  }');

  // Multiple render trees
  print('\nMultiple render trees:');
  print('  RenderingFlutterBinding can manage multiple render trees');
  print('  Each render tree has its own RenderView');
  print('  PipelineOwner manages the render pipeline');

  // Type checks
  print('\nType hierarchy from WidgetsBinding perspective:');
  print('  WidgetsFlutterBinding is the full binding');
  print('  RenderingFlutterBinding is rendering-only');
  print('  Both provide RendererBinding.instance');

  print('\n${'=' * 50}');
  print('RenderingFlutterBinding test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RenderingFlutterBinding Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Concrete class'),
      Text('Extends: BindingBase'),
      Text('6 binding mixins included'),
      Text('No widgets layer'),
    ],
  );
}
