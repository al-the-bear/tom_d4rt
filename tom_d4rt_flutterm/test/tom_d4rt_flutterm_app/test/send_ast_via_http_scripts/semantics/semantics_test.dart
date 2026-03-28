// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests Semantics widget from semantics
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('Semantics test executing');
  print('=' * 50);

  // Semantics widget overview
  print('Semantics widget overview:');
  print('  - Widget in widgets/basic.dart');
  print('  - Annotates child with semantics');
  print('  - Accessibility integration');

  // Key properties
  print('\nKey properties:');
  print('  String? label');
  print('    - Text description');
  print('  String? hint');
  print('    - Action hint');
  print('  String? value');
  print('    - Current value');
  print('  bool enabled');
  print('    - Enabled state');
  print('  bool selected');
  print('    - Selection state');

  // Actions
  print('\nSemantic actions:');
  print('  onTap: VoidCallback?');
  print('  onLongPress: VoidCallback?');
  print('  onScrollLeft: VoidCallback?');
  print('  onScrollRight: VoidCallback?');
  print('  onIncrease: VoidCallback?');
  print('  onDecrease: VoidCallback?');

  // Behavior properties
  print('\nBehavior properties:');
  print('  bool container');
  print('    - Creates semantics boundary');
  print('  bool explicitChildNodes');
  print('    - Force separate nodes');
  print('  bool excludeSemantics');
  print('    - Hide subtree from accessibility');

  // Text properties
  print('\nText properties:');
  print('  TextDirection? textDirection');
  print('  bool? multiline');
  print('  bool? readOnly');

  // Usage patterns
  print('\nUsage patterns:');
  print('  Wrap widgets with Semantics');
  print('  Add labels to icons');
  print('  Describe images');

  // Screen reader
  print('\nScreen reader:');
  print('  VoiceOver (iOS)');
  print('  TalkBack (Android)');
  print('  Reads label, hint, value');

  // MergeSemantics
  print('\nMergeSemantics:');
  print('  Combines child semantics');
  print('  Single accessibility node');

  // ExcludeSemantics
  print('\nExcludeSemantics:');
  print('  Hides from accessibility');
  print('  Decorative content');

  print('\n' + '=' * 50);
  print('Semantics test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Semantics Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Widget'),
      Text('Key: label, hint, actions'),
      Text('Purpose: Accessibility'),
    ],
  );
}
