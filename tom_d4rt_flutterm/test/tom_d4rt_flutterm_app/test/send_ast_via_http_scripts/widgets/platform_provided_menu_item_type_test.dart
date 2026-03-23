// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests PlatformProvidedMenuItemType from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PlatformProvidedMenuItemType test executing');

  // Enumerate all PlatformProvidedMenuItemType values
  print('PlatformProvidedMenuItemType values:');
  for (final value in PlatformProvidedMenuItemType.values) {
    print('  ${value.name}: $value');
  }
  print('PlatformProvidedMenuItemType has ${ PlatformProvidedMenuItemType.values.length} values');

  final first = PlatformProvidedMenuItemType.values.first;
  final last = PlatformProvidedMenuItemType.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('PlatformProvidedMenuItemType test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PlatformProvidedMenuItemType Tests'),
      Text('Values: ${ PlatformProvidedMenuItemType.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
