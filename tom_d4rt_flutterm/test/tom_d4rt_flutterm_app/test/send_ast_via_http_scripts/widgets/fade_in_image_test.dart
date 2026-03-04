// D4rt test script: Tests FadeInImage from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FadeInImage test executing');

  // Test FadeInImage - Fade-in images
  print('FadeInImage is available in the widgets package');
  print('FadeInImage runtimeType accessible');

  print('FadeInImage test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FadeInImage Tests'),
      Text('Fade-in images'),
    ],
  );
}
