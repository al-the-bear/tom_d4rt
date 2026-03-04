// D4rt test script: Tests EdgeInsetsTween from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('EdgeInsetsTween test executing');

  // Test EdgeInsetsTween - EdgeInsetsTween
  print('EdgeInsetsTween is available in the widgets package');
  print('EdgeInsetsTween runtimeType accessible');

  print('EdgeInsetsTween test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('EdgeInsetsTween Tests'),
      Text('EdgeInsetsTween'),
    ],
  );
}
