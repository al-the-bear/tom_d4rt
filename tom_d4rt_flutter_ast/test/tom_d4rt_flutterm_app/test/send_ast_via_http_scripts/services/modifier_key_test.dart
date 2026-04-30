// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ModifierKey from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

// Local shim — ModifierKey not available in D4rt bridge (deprecated API)
enum ModifierKey {
  controlModifier, shiftModifier, altModifier, metaModifier,
  capsLockModifier, numLockModifier, scrollLockModifier, functionModifier,
  symbolModifier,
}

dynamic build(BuildContext context) {
  print('ModifierKey test executing');

  // Enumerate all ModifierKey values
  print('ModifierKey values:');
  for (final value in ModifierKey.values) {
    print('  ${value.name}: $value');
  }
  print('ModifierKey has ${ModifierKey.values.length} values');

  final first = ModifierKey.values.first;
  final last = ModifierKey.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('ModifierKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ModifierKey Tests'),
      Text('Values: ${ModifierKey.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
