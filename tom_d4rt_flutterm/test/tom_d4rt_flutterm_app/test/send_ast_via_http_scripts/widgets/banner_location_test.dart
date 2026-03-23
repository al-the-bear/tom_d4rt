// ignore_for_file: avoid_print
// D4rt test script: Tests BannerLocation from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('BannerLocation test executing');

  // Enumerate all BannerLocation values
  print('BannerLocation values:');
  for (final value in BannerLocation.values) {
    print('  ${value.name}: $value');
  }
  print('BannerLocation has ${ BannerLocation.values.length} values');

  final first = BannerLocation.values.first;
  final last = BannerLocation.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('BannerLocation test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('BannerLocation Tests'),
      Text('Values: ${ BannerLocation.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
