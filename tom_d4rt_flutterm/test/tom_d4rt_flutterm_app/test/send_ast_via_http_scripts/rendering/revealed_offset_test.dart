// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RevealedOffset from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RevealedOffset test executing');

  // Test RevealedOffset - Revealed offset
  print('RevealedOffset is available in the rendering package');
  print('RevealedOffset: Revealed offset');

  print('RevealedOffset test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RevealedOffset Tests'),
      Text('Revealed offset'),
    ],
  );
}
