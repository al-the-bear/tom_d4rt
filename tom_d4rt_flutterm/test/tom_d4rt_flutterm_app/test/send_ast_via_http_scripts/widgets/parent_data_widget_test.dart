// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ParentDataWidget from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ParentDataWidget test executing');
  print('=' * 50);

  // === Test ParentDataWidget abstract class ===
  print('\nParentDataWidget applies data to parent RenderObject');

  // Describe ParentDataWidget
  print('\n--- Understanding ParentDataWidget ---');
  print('Abstract class extending ProxyWidget');
  print('Configures child\'s parentData in parent RenderObj');
  print('Used for layout configuration');

  // Test Positioned (concrete implementation)
  print('\n--- Testing Positioned ---');
  final positioned = Positioned(
    left: 10,
    top: 20,
    width: 100,
    height: 50,
    child: Container(color: Colors.red),
  );
  print('Positioned extends ParentDataWidget<StackParentData>');
  print('positioned.left: ${positioned.left}');
  print('positioned.top: ${positioned.top}');

  // Test Flexible (concrete implementation)
  print('\n--- Testing Flexible ---');
  final flexible = Flexible(
    flex: 2,
    fit: FlexFit.tight,
    child: Text('Flex child'),
  );
  print('Flexible extends ParentDataWidget<FlexParentData>');
  print('flexible.flex: ${flexible.flex}');
  print('flexible.fit: ${flexible.fit}');

  // Test debugTypicalAncestorWidgetClass
  print('\n--- debugTypicalAncestorWidgetClass ---');
  print('Type get debugTypicalAncestorWidgetClass');
  print('Returns expected parent widget type');
  print('Positioned returns Stack');
  print('Flexible returns Flex (Row/Column)');

  // Test debugIsValidRenderObject
  print('\n--- debugIsValidRenderObject ---');
  print('bool debugIsValidRenderObject(RenderObject)');
  print('Checks if parentData type matches T');
  print('Used for validation in debug mode');

  // Test applyParentData
  print('\n--- applyParentData ---');
  print('void applyParentData(RenderObject)');
  print('Abstract method to apply data');
  print('Called when widget installed or updated');

  // Common implementations
  print('\n--- Common implementations ---');
  print('Positioned: for Stack');
  print('Flexible/Expanded: for Row/Column');
  print('TableCell: for Table');

  print('\n' + '=' * 50);
  print('ParentDataWidget test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ParentDataWidget Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract class'),
      Text('Extends: ProxyWidget'),
      flexible,
    ],
  );
}
