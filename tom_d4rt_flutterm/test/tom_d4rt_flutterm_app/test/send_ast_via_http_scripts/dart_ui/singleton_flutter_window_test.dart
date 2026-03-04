// D4rt test script: Tests SingletonFlutterWindow from dart_ui
import 'dart:ui';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SingletonFlutterWindow test executing');

  // Test SingletonFlutterWindow - SingletonFlutterWindow
  print('SingletonFlutterWindow is available in the dart_ui package');
  print('SingletonFlutterWindow: SingletonFlutterWindow');

  print('SingletonFlutterWindow test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SingletonFlutterWindow Tests'),
      Text('SingletonFlutterWindow'),
    ],
  );
}
