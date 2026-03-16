// D4rt test script: Tests ViewConstraints from dart:ui
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ViewConstraints test executing');

  final vc1 = ui.ViewConstraints(minWidth: 0, maxWidth: 800, minHeight: 0, maxHeight: 600);
  print('ViewConstraints: minW=${vc1.minWidth}, maxW=${vc1.maxWidth}, minH=${vc1.minHeight}, maxH=${vc1.maxHeight}');
  print('isTight: ${vc1.isTight}');

  final vc2 = ui.ViewConstraints.tight(Size(400, 300));
  print('Tight: minW=${vc2.minWidth}, maxW=${vc2.maxWidth}');
  print('isTight: ${vc2.isTight}');
  print('isSatisfiedBy: ${vc2.isSatisfiedBy(Size(400, 300))}');
  print('not satisfied: ${vc2.isSatisfiedBy(Size(500, 300))}');

  // From PlatformDispatcher view
  final pd = ui.PlatformDispatcher.instance;
  final view = pd.implicitView;
  if (view != null) {
    final pc = view.physicalConstraints;
    print('View constraints: ${pc.minWidth}-${pc.maxWidth} x ${pc.minHeight}-${pc.maxHeight}');
  }

  print('ViewConstraints test completed');
  return Column(mainAxisSize: MainAxisSize.min, children: [
    Text('ViewConstraints Tests', style: TextStyle(fontWeight: FontWeight.bold)),
    Text('Loose: 0-800 x 0-600, tight=${vc1.isTight}'),
    Text('Tight: 400x300, tight=${vc2.isTight}'),
    Text('isSatisfiedBy: ${vc2.isSatisfiedBy(Size(400, 300))}'),
  ]);
}
