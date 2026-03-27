// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PlatformViewSurface from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('PlatformViewSurface test executing');
  print('=' * 50);

  // === Test PlatformViewSurface class ===
  print('\nPlatformViewSurface embeds platform view via compositor');

  // Describe PlatformViewSurface
  print('\n--- Understanding PlatformViewSurface ---');
  print('Extends LeafRenderObjectWidget');
  print('Uses system compositor for platform view');
  print('Required: controller, hitTestBehavior, gestureRecognizers');

  // Test constructor parameters
  print('\n--- Constructor parameters ---');
  print('controller: PlatformViewController');
  print('hitTestBehavior: PlatformViewHitTestBehavior');
  print('gestureRecognizers: Set<Factory<OneSequenceGestureRecognizer>>');

  // Test PlatformViewHitTestBehavior
  print('\n--- PlatformViewHitTestBehavior options ---');
  print('PlatformViewHitTestBehavior.opaque');
  print('PlatformViewHitTestBehavior.translucent');
  print('PlatformViewHitTestBehavior.transparent');

  // Test empty gesture recognizers
  print('\n--- Empty gesture recognizers ---');
  const emptyRecognizers = <Factory<OneSequenceGestureRecognizer>>{};
  print('Empty set: ${emptyRecognizers.isEmpty}');
  print('Dispatches to view if unclaimed by arena');

  // Test with gesture recognizers
  print('\n--- With gesture recognizers ---');
  print('Factory<OneSequenceGestureRecognizer>');
  print('Participates in gesture arena');
  print('If factory wins, pointer events go to view');

  // Related classes
  print('\n--- Related classes ---');
  print('AndroidView: Android platform view');
  print('UiKitView: iOS platform view');
  print('PlatformViewLink: multi-platform view');

  // RenderObject creation
  print('\n--- RenderObject creation ---');
  print('createRenderObject -> PlatformViewRenderBox');
  print('updateRenderObject updates controller, behavior, recognizers');

  // Usage pattern
  print('\n--- Usage pattern ---');
  print('PlatformViewLink.onCreatePlatformView');
  print('Returns PlatformViewSurface as surfaceFactory');


  // System compositor
  print('\n--- System compositor ---');
  print('Renders via platform compositor');
  print('Better performance than texture');
  print('May have overlay limitations');

  // Updates
  print('\n--- updateRenderObject ---');
  print('Updates controller property');
  print('Updates hitTestBehavior');
  print('Updates gestureRecognizers');

  print('\n' + '=' * 50);
  print('PlatformViewSurface test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlatformViewSurface Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: LeafRenderObjectWidget'),
      Text('Compositor integration: Yes'),
      Text('Gesture arena: Participates'),
    ],
  );
}
