// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RendererBinding from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RendererBinding test executing');
  print('=' * 50);

  // RendererBinding is a mixin
  print('\nRendererBinding is a mixin');
  print('Declaration: mixin RendererBinding on BindingBase, ...');
  print('Purpose: Glue between render trees and the Flutter engine');

  // Binding hierarchy
  print('\nBinding mixin hierarchy:');
  print('  BindingBase (abstract, foundation)');
  print('  \u251c\u2500 GestureBinding');
  print('  \u251c\u2500 SchedulerBinding');
  print('  \u251c\u2500 ServicesBinding');
  print('  \u251c\u2500 SemanticsBinding');
  print('  \u251c\u2500 PaintingBinding');
  print('  \u2514\u2500 RendererBinding (this)');

  // Key static
  print('\nAccess the singleton:');
  print('  RendererBinding.instance');
  print('  Returns the current RendererBinding instance');

  // Key properties
  print('\nKey properties:');
  print('  rootPipelineOwner - Manages the root render tree');
  print('  renderViews - Set of active RenderView objects');

  // Key methods
  print('\nKey methods:');
  print('  initInstances() - Initializes render pipeline');
  print('  addRenderView(RenderView) - Registers a render view');
  print('  removeRenderView(RenderView) - Unregisters a render view');
  print('  drawFrame() - Called by engine to paint a frame');

  // Pipeline owner
  print('\nPipelineOwner responsibilities:');
  print('  - Manages dirty render objects');
  print('  - Triggers layout pass');
  print('  - Triggers compositing bits update');
  print('  - Triggers paint pass');
  print('  - Triggers semantics update');

  // Frame lifecycle
  print('\nFrame lifecycle:');
  print('  1. SchedulerBinding schedules frame');
  print('  2. RendererBinding.drawFrame() called');
  print('  3. rootPipelineOwner.flushLayout()');
  print('  4. rootPipelineOwner.flushCompositingBits()');
  print('  5. rootPipelineOwner.flushPaint()');
  print('  6. Scene composited and sent to engine');
  print('  7. rootPipelineOwner.flushSemantics()');

  // Relationship to WidgetsBinding
  print('\nRelationship to WidgetsBinding:');
  print('  WidgetsBinding includes RendererBinding');
  print('  Most apps use WidgetsFlutterBinding.ensureInitialized()');
  print('  This initializes all bindings including RendererBinding');

  print('\n${'=' * 50}');
  print('RendererBinding test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RendererBinding Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Mixin on BindingBase'),
      Text('Access: RendererBinding.instance'),
      Text('Key: drawFrame, rootPipelineOwner'),
      Text('Manages: Render tree lifecycle'),
    ],
  );
}
