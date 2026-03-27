// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ToolbarOptions from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ToolbarOptions test executing');
  print('=' * 50);

  // Note: ToolbarOptions is deprecated
  print('ToolbarOptions overview:');
  print('  - @Deprecated: Migrate to contextMenuBuilder');
  print('  - Configures text selection toolbar buttons');
  print('  - Controls copy, cut, paste, selectAll');
  print('  - Used by EditableText (deprecated)');

  // Test default constructor
  print('\nDefault constructor (all false):');
  final defaultOptions = ToolbarOptions();
  print('  copy: ${defaultOptions.copy}');
  print('  cut: ${defaultOptions.cut}');
  print('  paste: ${defaultOptions.paste}');
  print('  selectAll: ${defaultOptions.selectAll}');

  // Test with all enabled
  print('\nWith all options enabled:');
  final allEnabled = ToolbarOptions(
    copy: true,
    cut: true,
    paste: true,
    selectAll: true,
  );
  print('  copy: ${allEnabled.copy}');
  print('  cut: ${allEnabled.cut}');
  print('  paste: ${allEnabled.paste}');
  print('  selectAll: ${allEnabled.selectAll}');

  // Test partial options
  print('\nWith partial options (read-only field):');
  final readOnly = ToolbarOptions(
    copy: true,
    selectAll: true,
  );
  print('  copy: ${readOnly.copy}');
  print('  cut: ${readOnly.cut}');
  print('  paste: ${readOnly.paste}');
  print('  selectAll: ${readOnly.selectAll}');

  // Migration guidance
  print('\nMigration to contextMenuBuilder:');
  print('  - Use EditableText.contextMenuBuilder');
  print('  - Build custom AdaptiveTextSelectionToolbar');
  print('  - Control buttons via buttonItems parameter');
  print('  - More flexible than boolean flags');
  print('  - Supports custom actions');

  // Immutability
  print('\nClass characteristics:');
  print('  - @immutable annotation');
  print('  - All properties are final');
  print('  - Cannot be modified after creation');
  print('  - Constructor with named parameters');

  // Historical context
  print('\nHistorical context:');
  print('  - Introduced in early Flutter versions');
  print('  - Deprecated after v3.3.0-0.5.pre');
  print('  - Replaced by contextMenuBuilder pattern');
  print('  - More control with builder approach');

  print('\n' + '=' * 50);
  print('ToolbarOptions test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ToolbarOptions Tests (Deprecated)',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Status: Deprecated'),
      Text('Properties: copy, cut, paste, selectAll'),
      Text('Migrate to: contextMenuBuilder'),
    ],
  );
}
