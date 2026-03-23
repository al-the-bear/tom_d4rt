// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SemanticsLabelBuilder from semantics
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SemanticsLabelBuilder test executing');
  print('=' * 50);

  // SemanticsLabelBuilder typedef
  print('\nSemanticsLabelBuilder:');
  print('Typedef for building semantic labels');
  print('typedef SemanticsLabelBuilder = String Function(String label)');

  // Create a SemanticsLabelBuilder function
  String myLabelBuilder(String label) {
    return 'Prefix: $label';
  }

  print('\nCustom builder created:');
  print('myLabelBuilder("test"): ${myLabelBuilder("test")}');

  // Usage in Semantics
  print('\nUsage in Semantics:');
  print('Semantics(');
  print('  label: "Button",');
  print('  labelBuilder: (label) => "Action \$label",');
  print('  child: MyWidget(),');
  print(');');

  // Use cases
  print('\nUse cases:');
  print('- Add context to labels');
  print('- Localization transformation');
  print('- Label customization');
  print('- Accessibility enhancements');

  // Examples
  print('\nExamples:');
  print('');
  print('Counter label:');
  print('labelBuilder: (label) => "\$label: \$count items"');
  print('');
  print('State indicator:');
  print(
    'labelBuilder: (label) => "\$label, \${isActive ? "active" : "inactive"}"',
  );
  print('');
  print('Position context:');
  print('labelBuilder: (label) => "Item \$index of \$total: \$label"');

  // Common patterns
  print('\nCommon patterns:');
  print('// Add state info');
  print('(l) => selected ? "Selected \$l" : l');
  print('');
  print('// Add count');
  print('(l) => "\$l (\$count)"');
  print('');
  print('// Add position');
  print('(l) => "\$l, item \$pos of \$total"');

  // Type hierarchy
  print('\nType hierarchy:');
  print('Function');
  print('  \u2514\u2500 SemanticsLabelBuilder (typedef)');
  print('       String Function(String label)');

  // Explain purpose
  print('\nSemanticsLabelBuilder purpose:');
  print('- Typedef for label building');
  print('- String Function(String label)');
  print('- Custom label transformation');
  print('- Dynamic accessibility text');
  print('- Used in Semantics widget');

  print('\n' + '=' * 50);
  print('SemanticsLabelBuilder test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SemanticsLabelBuilder Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: typedef'),
      Text('Signature: String Function(String)'),
      Text('Test: ${myLabelBuilder("test")}'),
      Text('Purpose: Label transformation'),
    ],
  );
}
