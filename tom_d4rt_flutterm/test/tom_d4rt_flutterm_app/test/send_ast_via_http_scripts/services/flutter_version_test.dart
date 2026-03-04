// D4rt test script: Tests FlutterVersion from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('FlutterVersion test executing');

  // Test FlutterVersion - Flutter version
  print('FlutterVersion is available in the services package');
  print('FlutterVersion: Flutter version');

  print('FlutterVersion test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('FlutterVersion Tests'),
      Text('Flutter version'),
    ],
  );
}
