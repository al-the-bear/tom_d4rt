// ignore_for_file: avoid_print
// D4rt test script: Tests CupertinoTextMagnifier from cupertino
import 'package:flutter/cupertino.dart';

dynamic build(BuildContext context) {
  print('CupertinoTextMagnifier test executing');

  // ========== CUPERTINOTEXTMAGNIFIER ==========
  print('--- CupertinoTextMagnifier Tests ---');

  // Create required dependencies
  final controller = MagnifierController();
  print('MagnifierController created: ${controller.runtimeType}');

  final magnifierInfo = ValueNotifier(MagnifierInfo.empty);
  print('magnifierInfo created: ${magnifierInfo.runtimeType}');
  print('magnifierInfo value: ${magnifierInfo.value}');

  // Test CupertinoTextMagnifier with required params only
  final basicMagnifier = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: magnifierInfo,
  );
  print('Basic CupertinoTextMagnifier created: ${basicMagnifier.runtimeType}');

  // Test CupertinoTextMagnifier with custom dragResistance
  final dragMagnifier = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: magnifierInfo,
    dragResistance: 20.0,
  );
  print('CupertinoTextMagnifier with dragResistance: ${dragMagnifier.dragResistance}');

  // Test CupertinoTextMagnifier with custom hideBelowThreshold
  final thresholdMagnifier = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: magnifierInfo,
    hideBelowThreshold: 24.0,
  );
  print('CupertinoTextMagnifier with hideBelowThreshold: ${thresholdMagnifier.hideBelowThreshold}');

  // Test CupertinoTextMagnifier with custom horizontalScreenEdgePadding
  final edgeMagnifier = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: magnifierInfo,
    horizontalScreenEdgePadding: 20.0,
  );
  print('CupertinoTextMagnifier with horizontalScreenEdgePadding: ${edgeMagnifier.horizontalScreenEdgePadding}');

  // Test CupertinoTextMagnifier with custom animationCurve
  final curveMagnifier = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: magnifierInfo,
    animationCurve: Curves.linear,
  );
  print('CupertinoTextMagnifier with custom animationCurve created [${curveMagnifier.hashCode }]');

  // Test CupertinoTextMagnifier with all custom params
  final fullMagnifier = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: magnifierInfo,
    dragResistance: 15.0,
    hideBelowThreshold: 32.0,
    horizontalScreenEdgePadding: 16.0,
    animationCurve: Curves.easeInOut,
  );
  print('Full CupertinoTextMagnifier created');
  print('dragResistance: ${fullMagnifier.dragResistance}');
  print('hideBelowThreshold: ${fullMagnifier.hideBelowThreshold}');
  print('horizontalScreenEdgePadding: ${fullMagnifier.horizontalScreenEdgePadding}');

  // Test getter access on controller
  print('controller.shown: ${controller.shown}');

  // Test MagnifierInfo with custom values
  final customInfo = MagnifierInfo(
    globalGesturePosition: Offset(100.0, 200.0),
    caretRect: Rect.fromLTWH(50.0, 100.0, 2.0, 20.0),
    fieldBounds: Rect.fromLTWH(0.0, 0.0, 300.0, 400.0),
    currentLineBoundaries: Rect.fromLTWH(0.0, 100.0, 300.0, 20.0),
  );
  final customMagnifierInfo = ValueNotifier(customInfo);
  final customMagnifier = CupertinoTextMagnifier(
    controller: controller,
    magnifierInfo: customMagnifierInfo,
  );
  print('CupertinoTextMagnifier with custom MagnifierInfo created [${customMagnifier.hashCode }]');
  print('caretRect: ${customInfo.caretRect}');
  print('fieldBounds: ${customInfo.fieldBounds}');

  print('CupertinoTextMagnifier tests complete');
  return Container();
}
