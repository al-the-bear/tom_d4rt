// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests LabeledGlobalKey from widgets
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('LabeledGlobalKey test executing');
  print('=' * 50);

  // === Test LabeledGlobalKey class ===
  print('\nLabeledGlobalKey is a GlobalKey with a debugging label');

  // Create a LabeledGlobalKey with label
  print('\n--- Testing LabeledGlobalKey with label ---');
  final key1 = LabeledGlobalKey('myLabel');
  print('Created LabeledGlobalKey with label "myLabel"');
  print('key1: \$key1');
  print('key1.runtimeType: \${key1.runtimeType}');
  print('key1.toString(): \${key1.toString()}');

  // Create another LabeledGlobalKey with different label
  print('\n--- Testing another LabeledGlobalKey ---');
  final key2 = LabeledGlobalKey('anotherLabel');
  print('Created LabeledGlobalKey with label "anotherLabel"');
  print('key2: \$key2');
  print('key2.toString(): \${key2.toString()}');

  // Create a LabeledGlobalKey with null label
  print('\n--- Testing LabeledGlobalKey with null label ---');
  final keyNoLabel = LabeledGlobalKey(null);
  print('Created LabeledGlobalKey with null label');
  print('keyNoLabel: \$keyNoLabel');
  print('keyNoLabel.toString(): \${keyNoLabel.toString()}');

  // Test that it extends GlobalKey
  print('\n--- Testing inheritance ---');
  print('key1 is GlobalKey: \${key1 is GlobalKey}');
  print('key1 is Key: \${key1 is Key}');

  // Test uniqueness
  print('\n--- Testing uniqueness ---');
  print('key1 == key2: \${key1 == key2}');
  print('key1 == key1: \${key1 == key1}');
  final key1Copy = key1;
  print('key1 == key1Copy: \${key1 == key1Copy}');

  // Test hashCode
  print('\n--- Testing hashCode ---');
  print('key1.hashCode: \${key1.hashCode}');
  print('key2.hashCode: \${key2.hashCode}');
  print('key1.hashCode == key2.hashCode: \${key1.hashCode == key2.hashCode}');

  // Test with typed parameter
  print('\n--- Testing typed LabeledGlobalKey ---');
  final typedKey = LabeledGlobalKey<State<StatefulWidget>>('typedLabel');
  print('Created typed LabeledGlobalKey');
  print('typedKey: \$typedKey');
  print('typedKey.runtimeType: \${typedKey.runtimeType}');

  // Test currentState on unattached key
  print('\n--- Testing currentState ---');
  print('key1.currentState: \${key1.currentState}');
  print('key1.currentWidget: \${key1.currentWidget}');
  print('key1.currentContext: \${key1.currentContext}');

  print('\n' + '=' * 50);
  print('LabeledGlobalKey test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'LabeledGlobalKey Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('key1 with label: myLabel'),
      Text('key2 with label: anotherLabel'),
      Text('Keys are unique: \${key1 != key2}'),
      Text('Is GlobalKey: \${key1 is GlobalKey}'),
    ],
  );
}
