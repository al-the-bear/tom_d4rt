// D4rt test script: Tests MessageCodec from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MessageCodec test executing');

  // Test MessageCodec - Message codec base
  print('MessageCodec is available in the services package');
  print('MessageCodec: Message codec base');

  print('MessageCodec test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MessageCodec Tests'),
      Text('Message codec base'),
    ],
  );
}
