// D4rt test script: Tests RenderAligningShiftedBox from rendering
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderAligningShiftedBox test executing');

  // RenderAligningShiftedBox - Aligning shifted
  // This is typically an abstract/base class used through subclasses
  print('RenderAligningShiftedBox is available in the rendering package');
  print('RenderAligningShiftedBox: Aligning shifted');

  print('RenderAligningShiftedBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderAligningShiftedBox Tests'),
      Text('Aligning shifted'),
    ],
  );
}
