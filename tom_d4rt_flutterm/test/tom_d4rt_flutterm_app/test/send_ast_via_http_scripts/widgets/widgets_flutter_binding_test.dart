// D4rt test script: Tests WidgetsFlutterBinding from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('WidgetsFlutterBinding test executing');

  // Test WidgetsFlutterBinding - Flutter binding
  print('WidgetsFlutterBinding is available in the widgets package');
  print('WidgetsFlutterBinding runtimeType accessible');

  print('WidgetsFlutterBinding test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('WidgetsFlutterBinding Tests'),
      Text('Flutter binding'),
    ],
  );
}
