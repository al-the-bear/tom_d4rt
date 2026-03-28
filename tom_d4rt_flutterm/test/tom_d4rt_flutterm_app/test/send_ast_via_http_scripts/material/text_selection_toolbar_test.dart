// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextSelectionToolbar from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextSelectionToolbar test executing');
  print('=' * 50);

  // TextSelectionToolbar overview
  print('TextSelectionToolbar overview:');
  print('  - Material text selection toolbar');
  print('  - Shows copy/cut/paste buttons');
  print('  - StatelessWidget implementation');

  // Test basic toolbar
  print('\nTest basic toolbar:');
  final toolbar1 = TextSelectionToolbar(
    anchorAbove: Offset(100, 50),
    anchorBelow: Offset(100, 70),
    children: [
      TextSelectionToolbarTextButton(
        padding: EdgeInsets.all(8),
        onPressed: () {},
        child: Text('Copy'),
      ),
    ],
  );
  print('  anchorAbove: ${toolbar1.anchorAbove}');
  print('  anchorBelow: ${toolbar1.anchorBelow}');
  print('  children count: ${toolbar1.children.length}');

  // Test with multiple actions
  print('\nTest with multiple actions:');
  final toolbar2 = TextSelectionToolbar(
    anchorAbove: Offset(100, 50),
    anchorBelow: Offset(100, 70),
    children: [
      TextSelectionToolbarTextButton(padding: EdgeInsets.all(8), onPressed: () {}, child: Text('Cut')),
      TextSelectionToolbarTextButton(padding: EdgeInsets.all(8), onPressed: () {}, child: Text('Copy')),
      TextSelectionToolbarTextButton(padding: EdgeInsets.all(8), onPressed: () {}, child: Text('Paste')),
    ],
  );
  print('  Actions: Cut, Copy, Paste');
  print('  children count: ${toolbar2.children.length}');

  // Anchor positioning
  print('\nAnchor positioning:');
  print('  - anchorAbove: try above selection');
  print('  - anchorBelow: fallback below');
  print('  - Auto-adjusts for screen');

  // Visual properties
  print('\nVisual properties:');
  print('  - Material elevation');
  print('  - Rounded corners');
  print('  - Row of buttons');

  // Related classes
  print('\nRelated classes:');
  print('  - TextSelectionToolbarTextButton');
  print('  - CupertinoTextSelectionToolbar');
  print('  - TextSelectionToolbarAnchors');

  // Usage pattern
  print('\nUsage pattern:');
  print('  SelectionArea.contextMenuBuilder');
  print('  TextField.contextMenuBuilder');
  print('  SelectableText.contextMenuBuilder');

  print('\n' + '=' * 50);
  print('TextSelectionToolbar test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextSelectionToolbar Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: StatelessWidget'),
      Text('Purpose: Selection actions'),
    ],
  );
}
