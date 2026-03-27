// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests OptionsViewOpenDirection from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('OptionsViewOpenDirection test executing');
  print('=' * 50);

  // === Test OptionsViewOpenDirection enum ===
  print('\nOptionsViewOpenDirection controls autocomplete direction');

  // List all values
  print('\n--- Enum values ---');
  for (final direction in OptionsViewOpenDirection.values) {
    print('OptionsViewOpenDirection.${direction.name}');
  }

  // Test up value
  print('\n--- Testing up ---');
  final up = OptionsViewOpenDirection.up;
  print('up.name: ${up.name}');
  print('up.index: ${up.index}');
  print('Opens options above the text field');

  // Test down value
  print('\n--- Testing down ---');
  final down = OptionsViewOpenDirection.down;
  print('down.name: ${down.name}');
  print('down.index: ${down.index}');
  print('Opens options below the text field');

  // Test comparison
  print('\n--- Testing comparison ---');
  print('up == down: ${up == down}');
  print('up == OptionsViewOpenDirection.up: ${up == OptionsViewOpenDirection.up}');

  // Test with RawAutocomplete
  print('\n--- Testing with RawAutocomplete ---');
  final autocomplete = RawAutocomplete<String>(
    optionsViewOpenDirection: OptionsViewOpenDirection.down,
    optionsBuilder: (textEditingValue) {
      return ['Option 1', 'Option 2'];
    },
    fieldViewBuilder: (context, controller, focusNode, onSubmitted) {
      return TextField(
        controller: controller,
        focusNode: focusNode,
      );
    },
    optionsViewBuilder: (context, onSelected, options) {
      return ListView(
        children: options.map((o) => Text(o)).toList(),
      );
    },
  );
  print('Created RawAutocomplete with direction: down');
  print('autocomplete.optionsViewOpenDirection: ${autocomplete.optionsViewOpenDirection}');

  // Default value
  print('\n--- Default value ---');
  print('Default: OptionsViewOpenDirection.down');
  print('Most autocompletes show below field');

  // UI considerations
  print('\n--- UI considerations ---');
  print('up: Use near bottom of screen');
  print('down: Use when space available below');

  print('\n' + '=' * 50);
  print('OptionsViewOpenDirection test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'OptionsViewOpenDirection Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('up.index: ${up.index}'),
      Text('down.index: ${down.index}'),
      Text('Values: ${OptionsViewOpenDirection.values.length}'),
    ],
  );
}
