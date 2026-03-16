// D4rt test script: Tests RenderComparison from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderComparison test executing');

  // Enumerate all RenderComparison values
  print('RenderComparison values:');
  for (final value in RenderComparison.values) {
    print('  ${value.name}: $value');
  }
  print('RenderComparison has ${ RenderComparison.values.length} values');

  final first = RenderComparison.values.first;
  final last = RenderComparison.values.last;
  print('First: $first, Last: $last');
  print('First index: ${first.index}, Last index: ${last.index}');

  print('RenderComparison test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderComparison Tests'),
      Text('Values: ${ RenderComparison.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
