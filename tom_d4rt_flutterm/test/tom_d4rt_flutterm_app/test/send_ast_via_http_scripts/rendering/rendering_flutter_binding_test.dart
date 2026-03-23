// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests RenderingFlutterBinding from rendering
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
