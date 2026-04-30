// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextSelectionToolbarAnchors from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionToolbarAnchors test executing');
  print('=' * 50);

  // Test direct constructor
  print('Testing TextSelectionToolbarAnchors constructor:');
  final anchors1 = TextSelectionToolbarAnchors(
    primaryAnchor: Offset(100, 50),
    secondaryAnchor: Offset(100, 150),
  );
  print('  primaryAnchor: ${anchors1.primaryAnchor}');
  print('  secondaryAnchor: ${anchors1.secondaryAnchor}');

  // Test without secondary anchor
  print('\nWithout secondary anchor:');
  final anchors2 = TextSelectionToolbarAnchors(
    primaryAnchor: Offset(200, 100),
  );
  print('  primaryAnchor: ${anchors2.primaryAnchor}');
  print('  secondaryAnchor: ${anchors2.secondaryAnchor}');

  // Class properties
  print('\nTextSelectionToolbarAnchors properties:');
  print('  - primaryAnchor: Offset (required)');
  print('  - secondaryAnchor: Offset? (optional)');
  print('  - @immutable annotation');

  // fromSelection factory
  print('\nfromSelection factory constructor:');
  print('  TextSelectionToolbarAnchors.fromSelection({');
  print('    required RenderBox renderBox,');
  print('    required double startGlyphHeight,');
  print('    required double endGlyphHeight,');
  print('    required List<TextSelectionPoint> selectionEndpoints,');
  print('  })');

  // Static methods
  print('\nStatic methods:');
  print('  - getSelectionRect(): computes selection rectangle');
  print('  - _getEditingRegion(): gets RenderBox global bounds');

  // Anchor positioning logic
  print('\nAnchor positioning logic:');
  print('  - primaryAnchor: top center of selection');
  print('  - secondaryAnchor: bottom center of selection');
  print('  - Both clamped to editing region bounds');

  // Usage in AdaptiveTextSelectionToolbar
  print('\nUsage in AdaptiveTextSelectionToolbar:');
  print('  - AdaptiveTextSelectionToolbar.anchors property');
  print('  - Determines toolbar positioning');
  print('  - Primary used first, secondary if no space');

  // Primary vs Secondary
  print('\nPrimary vs Secondary anchor:');
  print('  - Primary: toolbar appears above selection');
  print('  - Secondary: toolbar appears below selection');
  print('  - Layout delegate chooses based on available space');

  // runtimeType
  print('\nType verification:');
  print('  anchors1.runtimeType: ${anchors1.runtimeType}');

  print('\n' + '=' * 50);
  print('TextSelectionToolbarAnchors test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextSelectionToolbarAnchors Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: Immutable class'),
      Text('Props: primaryAnchor, secondaryAnchor'),
      Text('Factory: fromSelection'),
    ],
  );
}
