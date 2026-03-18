// D4rt test script: Tests DiagnosticsTreeStyle from foundation
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('DiagnosticsTreeStyle test executing');

  // Enumerate all DiagnosticsTreeStyle values
  print('DiagnosticsTreeStyle values:');
  for (final value in DiagnosticsTreeStyle.values) {
    print('  ${value.name}: $value');
  }
  print(
    'DiagnosticsTreeStyle has ${DiagnosticsTreeStyle.values.length} values',
  );

  final first = DiagnosticsTreeStyle.values.first;
  final last = DiagnosticsTreeStyle.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('DiagnosticsTreeStyle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DiagnosticsTreeStyle Tests'),
      Text('Values: ${DiagnosticsTreeStyle.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
