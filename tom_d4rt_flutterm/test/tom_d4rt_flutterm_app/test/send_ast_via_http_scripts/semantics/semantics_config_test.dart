// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SemanticsConfiguration from semantics
import 'package:flutter/semantics.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsConfiguration test executing');
  print('=' * 50);

  // SemanticsConfiguration class overview
  print('SemanticsConfiguration class overview:');
  print('  - Configuration for semantics nodes');
  print('  - Describes accessibility properties');
  print('  - Used by RenderObject');

  // Create instance
  print('\nCreate instance:');
  final config = SemanticsConfiguration();
  print('  SemanticsConfiguration() created');
  print('  Initial label: ${config.label}');

  // Labeling properties
  print('\nLabeling properties:');
  print('  label: String getter');
  print('    - Main description');
  print('  hint: String getter');
  print('    - Action hint');
  print('  value: String getter');
  print('    - Current value');
  print('  increasedValue: String');
  print('  decreasedValue: String');

  // Attributed label API
  print('\nAttributedString API:');
  print('  attributedLabel: AttributedString');
  print('  attributedHint: AttributedString');
  print('  attributedValue: AttributedString');
  print('  Supports text spans');

  // Boolean properties
  print('\nBoolean properties:');
  print('  isEnabled: ${config.isEnabled}');
  print('  isSelected: ${config.isSelected}');
  print('  isButton: ${config.isButton}');
  print('  isLink: ${config.isLink}');
  print('  isHeader: ${config.isHeader}');
  print('  isImage: ${config.isImage}');
  print('  isTextField: ${config.isTextField}');

  // Actions
  print('\nActions:');
  print('  onTap: SemanticsGestureDelegate?');
  print('  onLongPress: SemanticsGestureDelegate?');
  print('  onScrollLeft: SemanticsGestureDelegate?');
  print('  onIncrease: SemanticsGestureDelegate?');

  // Tree behavior
  print('\nTree behavior:');
  print('  isSemanticBoundary: bool');
  print('    - Creates node boundary');
  print('  explicitChildNodes: bool');
  print('    - Force separate nodes');
  print('  isMergingSemanticsOfDescendants: bool');
  print('    - Merge subtree');

  // Copy
  print('\nCopy:');
  print('  copy(): SemanticsConfiguration');
  print('  Returns clone');

  // Absorb
  print('\nAbsorb:');
  print('  absorb(SemanticsConfiguration other)');
  print('  Merges properties');

  // Usage
  print('\nUsage:');
  print('  RenderObject.describeSemanticsConfiguration');
  print('  Configures semantics node');

  print('\n' + '=' * 50);
  print('SemanticsConfiguration test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SemanticsConfiguration Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Class'),
      Text('Key: label, isEnabled, actions'),
      Text('Purpose: Semantics node config'),
    ],
  );
}
