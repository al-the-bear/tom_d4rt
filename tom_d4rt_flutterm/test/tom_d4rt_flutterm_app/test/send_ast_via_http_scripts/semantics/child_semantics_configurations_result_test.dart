// D4rt test script: Tests ChildSemanticsConfigurationsResult from semantics
import 'package:flutter/semantics.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ChildSemanticsConfigurationsResult test executing');
  print('=' * 50);

  // ChildSemanticsConfigurationsResult
  print('\nChildSemanticsConfigurationsResult:');
  print('Result of child semantics configuration collection');
  print('Contains merged and sibling configurations');

  // Purpose
  print('\nPurpose:');
  print('- Hold processed child semantics');
  print('- Track merge-up configurations');
  print('- Result of builder pattern');

  // Properties
  print('\nProperties:');
  print('');
  print('siblingMergeUpConfigurations:');
  print('  - List<SemanticsConfiguration>');
  print('  - Configs to merge with siblings');

  // Usage context
  print('\nUsage context:');
  print('Returned by ChildSemanticsConfigurationsResultBuilder.build()');
  print('Used in assembleSemanticsNode implementations');

  // Code example
  print('\nCode example:');
  print('final builder = ChildSemanticsConfigurationsResultBuilder();');
  print('');
  print('// Mark configurations for merge');
  print('for (final config in childConfigs) {');
  print('  if (shouldMerge(config)) {');
  print('    builder.markAsSiblingMergeUp(config);');
  print('  }');
  print('}');
  print('');
  print('// Get result');
  print('final ChildSemanticsConfigurationsResult result = builder.build();');
  print('');
  print('// Access merged configs');
  print('for (final config in result.siblingMergeUpConfigurations) {');
  print('  // Process merged config');
  print('}');

  // Merge behavior
  print('\nMerge behavior:');
  print('- Sibling merge combines adjacent nodes');
  print('- Reduces accessibility tree depth');
  print('- Improves screen reader navigation');

  // When used
  print('\nWhen used:');
  print('- RenderObject.assembleSemanticsNode');
  print('- Custom viewport implementations');
  print('- Complex layout semantics');

  // Type hierarchy
  print('\nType hierarchy:');
  print('ChildSemanticsConfigurationsResult (data class)');
  print('  \u2514\u2500 Created by ResultBuilder');

  // Explain purpose
  print('\nChildSemanticsConfigurationsResult purpose:');
  print('- Child semantics collection result');
  print('- Contains sibling merge configs');
  print('- Used with ResultBuilder');
  print('- Custom semantics assembly');
  print('- Accessibility tree optimization');

  print('\n' + '=' * 50);
  print('ChildSemanticsConfigurationsResult test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ChildSemanticsConfigurationsResult Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: data class'),
      Text('Property: siblingMergeUpConfigurations'),
      Text('Created by: ResultBuilder.build()'),
      Text('Purpose: Semantics collection result'),
    ],
  );
}
