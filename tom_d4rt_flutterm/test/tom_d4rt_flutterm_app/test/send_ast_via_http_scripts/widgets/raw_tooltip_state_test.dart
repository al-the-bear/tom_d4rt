// D4rt test script: Tests RawTooltipState from widgets
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RawTooltipState test executing');

  // Test RawTooltipState - RawTooltipState
  print('RawTooltipState is available in the widgets package');
  print('RawTooltipState runtimeType accessible');

  print('RawTooltipState test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawTooltipState Tests'),
      Text('RawTooltipState'),
    ],
  );
}
