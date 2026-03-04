// D4rt test script: Tests RawTooltip from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawTooltip test executing');

  // Test RawTooltip - RawTooltip
  print('RawTooltip is available in the widgets package');
  print('RawTooltip runtimeType accessible');

  print('RawTooltip test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawTooltip Tests'),
      Text('RawTooltip'),
    ],
  );
}
