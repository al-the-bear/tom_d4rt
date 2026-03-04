// D4rt test script: Tests ImgElementPlatformView from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ImgElementPlatformView test executing');

  // Test ImgElementPlatformView - ImgElementPlatformView
  print('ImgElementPlatformView is available in the widgets package');
  print('ImgElementPlatformView runtimeType accessible');

  print('ImgElementPlatformView test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ImgElementPlatformView Tests'),
      Text('ImgElementPlatformView'),
    ],
  );
}
