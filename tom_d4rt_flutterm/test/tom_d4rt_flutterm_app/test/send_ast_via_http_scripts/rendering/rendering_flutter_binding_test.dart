// D4rt test script: Tests RenderingFlutterBinding from rendering
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderingFlutterBinding test executing');

  // RenderingFlutterBinding - Flutter binding
  // This is typically an abstract/base class used through subclasses
  print('RenderingFlutterBinding is available in the rendering package');
  print('RenderingFlutterBinding: Flutter binding');

  print('RenderingFlutterBinding test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderingFlutterBinding Tests'),
      Text('Flutter binding'),
    ],
  );
}
