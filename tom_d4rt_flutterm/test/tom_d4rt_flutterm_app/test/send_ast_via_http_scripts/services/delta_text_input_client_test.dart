// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests DeltaTextInputClient from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DeltaTextInputClient test executing');

  // DeltaTextInputClient is a mixin
  print('DeltaTextInputClient is a mixin');
  print('Extends TextInputClient with delta support');

  // Interface method
  print('\nDeltaTextInputClient method:');
  print('updateEditingValueWithDeltas(List<TextEditingDelta>)');
  print('Receives incremental text changes');

  // Delta types
  print('\nTextEditingDelta types:');
  print('- TextEditingDeltaInsertion: text added');
  print('- TextEditingDeltaDeletion: text removed');
  print('- TextEditingDeltaReplacement: text replaced');
  print('- TextEditingDeltaNonTextUpdate: selection only');

  // Why deltas
  print('\nWhy use deltas:');
  print('- More efficient than full text');
  print('- Better for large documents');
  print('- Preserves undo/redo history');
  print('- Used by native IME');

  // Usage pattern
  print('\nUsage pattern:');
  print('class MyTextClient with DeltaTextInputClient {');
  print('  @override');
  print('  void updateEditingValueWithDeltas(deltas) {');
  print('    for (var delta in deltas) {');
  print('      // Apply each delta');
  print('    }');
  print('  }');
  print('}');

  // EditableText uses it
  print('\nEditableText integration:');
  print('- EditableTextState implements this');
  print('- Automatic delta handling');
  print('- No manual implementation needed');

  // TextInputConnection
  print('\nEnabling delta mode:');
  print('TextInputConfiguration(');
  print('  enableDeltaModel: true, // enables deltas');
  print(')');

  print('\nDeltaTextInputClient test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'DeltaTextInputClient Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Mixin for delta text input'),
      Text('Method: updateEditingValueWithDeltas'),
      Text('More: efficient than full text'),
      Text('Used by: EditableTextState'),
    ],
  );
}
