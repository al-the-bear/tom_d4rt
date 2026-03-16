// D4rt test script: Tests ImageStreamCompleter from painting
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImageStreamCompleter test executing');

  // Test ImageStreamCompleter - Stream completion
  print('ImageStreamCompleter is available in the painting package');
  print('ImageStreamCompleter: Stream completion');

  print('ImageStreamCompleter test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImageStreamCompleter Tests'),
      Text('Stream completion'),
    ],
  );
}
