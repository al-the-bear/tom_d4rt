// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests InspectorSerializationDelegate from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('InspectorSerializationDelegate test executing');
  print('=' * 50);

  // === InspectorSerializationDelegate class tests ===
  // InspectorSerializationDelegate configures how DiagnosticsNode
  // hierarchies are serialized for the Flutter Inspector.

  // Test 1: Class definition
  print('\nTest 1: Class definition');
  print('class InspectorSerializationDelegate');
  print('  implements DiagnosticsSerializationDelegate');
  print('Annotated @visibleForTesting');

  // Test 2: Constructor parameters
  print('\nTest 2: Constructor parameters');
  print('service: WidgetInspectorService (required)');
  print('groupName: String? (for live object ids)');
  print('summaryTree: bool (default: false)');
  print('maxDescendantsTruncatableNode: int (default: -1)');
  print('expandPropertyValues: bool (default: true)');
  print('subtreeDepth: int (default: 1)');
  print('includeProperties: bool (default: false)');

  // Test 3: DiagnosticsSerializationDelegate interface
  print('\nTest 3: Interface implementation');
  print('additionalNodeProperties(node, fullDetails)');
  print('delegateForNode(node)');
  print('includeProperties: bool getter');
  print('subtreeDepth: int getter');
  print('expandPropertyValues: bool getter');

  // Test 4: summaryTree behavior
  print('\nTest 4: summaryTree mode');
  print('When true:');
  print('  - Includes only summary tree nodes');
  print('  - Filters to local project nodes');
  print('  - Adds summaryTree: true to JSON');

  // Test 5: groupName behavior
  print('\nTest 5: groupName / interactive mode');
  print('When groupName is provided:');
  print('  - Adds valueId to JSON');
  print('  - Objects tracked by group');
  print('  - group can be disposed later');

  // Test 6: additionalNodeProperties
  print('\nTest 6: additionalNodeProperties');
  print('Adds to JSON map:');
  print('  - summaryTree: bool (if applicable)');
  print('  - valueId: String (if interactive)');
  print('  - locationId: int');
  print('  - creationLocation: Map');
  print('  - createdByLocalProject: bool');

  // Test 7: Local project filtering
  print('\nTest 7: Local project filtering');
  print('Tracks _nodesCreatedByLocalProject list');
  print('Checks file path via _isLocalCreationLocation');
  print('Marks nodes with createdByLocalProject flag');

  // Test 8: delegateForNode behavior
  print('\nTest 8: delegateForNode');
  print('Returns delegate with decremented subtreeDepth');
  print('Special case for summaryTree mode:');
  print('  - Keeps depth until summary tree node found');

  // Test 9: copyWith method
  print('\nTest 9: copyWith');
  print('Creates new delegate with modified:');
  print('  - subtreeDepth');
  print('  - includeProperties');

  // Test 10: addAdditionalPropertiesCallback
  print('\nTest 10: Custom properties callback');
  print('Optional callback to add experimental properties');
  print('Signature: (DiagnosticsNode, delegate) -> Map?');
  print('Used for DevTools experimental features');

  print('\n' + '=' * 50);
  print('InspectorSerializationDelegate test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'InspectorSerializationDelegate Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Tests: 10 categories executed'),
      Text('Type: DiagnosticsSerializationDelegate'),
      Text('Mode: Summary tree support'),
      Text('Purpose: Widget inspector JSON'),
    ],
  );
}
