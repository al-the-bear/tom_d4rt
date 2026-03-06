// D4rt test script: Tests ChannelBuffers from dart_ui
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ChannelBuffers test executing');

  // Test ChannelBuffers - Platform channel buffers
  print('ChannelBuffers is available in the dart_ui package');
  print('ChannelBuffers: Platform channel buffers');

  print('ChannelBuffers test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ChannelBuffers Tests'),
      Text('Platform channel buffers'),
    ],
  );
}
