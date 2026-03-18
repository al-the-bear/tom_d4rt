// D4rt test script: Tests Clip from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  // Enumerate all Clip values

  final first = Clip.values.first;
  final last = Clip.values.last;

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Clip Tests'),
      Text('Values: ${Clip.values.length}'),
      Text('First: $first'),
      Text('Last: $last'),
    ],
  );
}
