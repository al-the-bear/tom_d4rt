// ignore_for_file: avoid_print, deprecated_member_use
// D4rt test script: Tests RestorableTextEditingController from widgets
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RestorableTextEditingController test executing');
  print('=' * 50);

  // RestorableTextEditingController wraps TextEditingController
  print('RestorableTextEditingController:');
  print('Purpose: Store and restore TextEditingController state');
  print('Extends: RestorableChangeNotifier<TextEditingController>');
  print('');

  // Default factory constructor
  print('Default factory constructor:');
  final defCtrl = RestorableTextEditingController();
  print('Created: RestorableTextEditingController()');
  print('runtimeType: ${defCtrl.runtimeType}');
  print('');

  // With text constructor
  print('With text constructor:');
  final withText = RestorableTextEditingController(text: 'Initial text');
  print('Created: RestorableTextEditingController(text: \'Initial text\')');
  print('');

  // fromValue constructor
  print('fromValue constructor:');
  final fromValue = RestorableTextEditingController.fromValue(
    TextEditingValue(
      text: 'Custom',
      selection: TextSelection.collapsed(offset: 3),
    ),
  );
  print('Created: RestorableTextEditingController.fromValue(...)');
  print('  text: \'Custom\'');
  print('  selection: collapsed at offset 3');
  print('');

  // What gets restored
  print('What gets restored:');
  print('  - Text content (via text property)');
  print('  - Note: Selection/composition NOT restored');
  print('  - Stores: value.text');
  print('  - Restores: TextEditingController(text: data)');
  print('');

  // Auto-dispose behavior
  print('Auto-dispose behavior:');
  print('  - TextEditingController disposed automatically');
  print('  - Scheduled via microtask');
  print('  - Allows listeners to detach first');
  print('');

  // Type hierarchy
  print('Type hierarchy:');
  print('RestorableTextEditingController');
  print('  extends RestorableChangeNotifier<TextEditingController>');
  print('    extends RestorableListenable<TextEditingController>');
  print('      extends RestorableProperty<TextEditingController>');
  print('');

  print('Type checks:');
  print('is RestorableChangeNotifier: ${defCtrl is RestorableChangeNotifier}');
  print('is RestorableProperty: ${defCtrl is RestorableProperty}');

  // Cleanup
  defCtrl.dispose();
  withText.dispose();
  fromValue.dispose();

  print('\n' + '=' * 50);
  print('RestorableTextEditingController test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'RestorableTextEditingController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Wraps TextEditingController'),
      Text('Restores text content'),
      Text('Auto-disposes controller'),
    ],
  );
}
