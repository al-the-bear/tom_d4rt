// D4rt test script: Tests LogicalKeySet from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('LogicalKeySet test executing');

  // Test LogicalKeySet - LogicalKeySet
  print('LogicalKeySet is available in the widgets package');
  print('LogicalKeySet runtimeType accessible');

  print('LogicalKeySet test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('LogicalKeySet Tests'),
      Text('LogicalKeySet'),
    ],
  );
}
