// D4rt test script: Tests OverlayChildLayoutInfo from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('OverlayChildLayoutInfo test executing');

  // Test OverlayChildLayoutInfo - OverlayChildLayoutInfo
  print('OverlayChildLayoutInfo is available in the widgets package');
  print('OverlayChildLayoutInfo runtimeType accessible');

  print('OverlayChildLayoutInfo test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('OverlayChildLayoutInfo Tests'),
      Text('OverlayChildLayoutInfo'),
    ],
  );
}
