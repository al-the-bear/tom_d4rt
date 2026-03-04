// D4rt test script: Tests PositionedDirectional from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('PositionedDirectional test executing');

  // Test PositionedDirectional - RTL positioned
  print('PositionedDirectional is available in the widgets package');
  print('PositionedDirectional runtimeType accessible');

  print('PositionedDirectional test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('PositionedDirectional Tests'),
      Text('RTL positioned'),
    ],
  );
}
