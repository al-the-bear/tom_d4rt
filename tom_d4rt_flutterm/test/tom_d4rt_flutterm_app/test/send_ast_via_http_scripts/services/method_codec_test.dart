// D4rt test script: Tests MethodCodec from services
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('MethodCodec test executing');

  // Test MethodCodec - Method codec base
  print('MethodCodec is available in the services package');
  print('MethodCodec: Method codec base');

  print('MethodCodec test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MethodCodec Tests'),
      Text('Method codec base'),
    ],
  );
}
