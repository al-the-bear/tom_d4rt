// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RevealedOffset from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RevealedOffset test executing');
  print('=' * 50);

  // RevealedOffset is an immutable value class
  print('\nRevealedOffset:');
  print('Purpose: Return value for RenderAbstractViewport.getOffsetToReveal');
  print('Holds the offset and rect needed to reveal an element in a viewport');

  // Create an instance
  final revealed = RevealedOffset(
    offset: 100.0,
    rect: const Rect.fromLTWH(0, 0, 200, 50),
  );
  print('\nCreated RevealedOffset:');
  print('  runtimeType: ${revealed.runtimeType}');
  print('  offset: ${revealed.offset}');
  print('  rect: ${revealed.rect}');

  // Test different offset values
  final revealed2 = RevealedOffset(
    offset: 250.5,
    rect: const Rect.fromLTWH(10, 20, 300, 100),
  );
  print('\nSecond RevealedOffset:');
  print('  offset: ${revealed2.offset}');
  print('  rect: ${revealed2.rect}');

  // Zero offset case
  final zeroOffset = RevealedOffset(
    offset: 0.0,
    rect: Rect.zero,
  );
  print('\nZero RevealedOffset:');
  print('  offset: ${zeroOffset.offset}');
  print('  rect: ${zeroOffset.rect}');

  // Negative offset case
  final negativeOffset = RevealedOffset(
    offset: -50.0,
    rect: const Rect.fromLTWH(0, 0, 100, 100),
  );
  print('\nNegative offset RevealedOffset:');
  print('  offset: ${negativeOffset.offset}');
  print('  rect: ${negativeOffset.rect}');

  // Static method clampOffset
  print('\nStatic method: RevealedOffset.clampOffset');
  print('  Determines which edge (leading or trailing) to use');
  print('  Returns null if target is already fully visible');
  print('  Used by RenderViewportBase.showInViewport');

  // Coordinate systems
  print('\nViewport coordinate systems:');
  print('  Inner: origin at top-left of scrollable content');
  print('  Outer: origin at top-left of visible viewport');
  print('  rect is in the outer coordinate system');

  // Usage context
  print('\nUsage context:');
  print('  RenderAbstractViewport.getOffsetToReveal() returns RevealedOffset');
  print('  showInViewport uses clampOffset to pick best edge');
  print('  offset: viewport scroll position to make element visible');
  print('  rect: where the element will appear in visible area');

  print('\n==================================================');
  print('RevealedOffset test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RevealedOffset Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Immutable value class'),
      Text('offset: ${revealed.offset}'),
      Text('rect: ${revealed.rect}'),
      Text('Purpose: Viewport element reveal'),
    ],
  );
}
