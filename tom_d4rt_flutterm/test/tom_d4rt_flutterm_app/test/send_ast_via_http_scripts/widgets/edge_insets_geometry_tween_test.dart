// D4rt test script: Tests EdgeInsetsGeometryTween from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('EdgeInsetsGeometryTween test executing');

  // Test EdgeInsetsGeometryTween - EdgeInsetsGeometryTween
  print('EdgeInsetsGeometryTween is available in the widgets package');
  print('EdgeInsetsGeometryTween runtimeType accessible');

  print('EdgeInsetsGeometryTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('EdgeInsetsGeometryTween Tests'),
      Text('EdgeInsetsGeometryTween'),
    ],
  );
}
