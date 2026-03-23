// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests SmartDashesType from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SmartDashesType test executing');

  // Enumerate all SmartDashesType values
  print('SmartDashesType values:');
  for (final value in SmartDashesType.values) {
    print('  ${value.name}: $value');
  }
  print('SmartDashesType has ${SmartDashesType.values.length} values');

  final first = SmartDashesType.values.first;
  final last = SmartDashesType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('SmartDashesType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SmartDashesType Tests'),
      Text('Values: ${SmartDashesType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
