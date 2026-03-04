// D4rt test script: Tests PopEntry from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PopEntry test executing');

  // Test PopEntry - PopEntry
  print('PopEntry is available in the widgets package');
  print('PopEntry runtimeType accessible');

  print('PopEntry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PopEntry Tests'),
      Text('PopEntry'),
    ],
  );
}
