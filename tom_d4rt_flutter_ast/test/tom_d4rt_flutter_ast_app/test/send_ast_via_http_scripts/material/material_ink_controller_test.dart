// ignore_for_file: avoid_print
// D4rt test script: MaterialInkController members (material, addtests2;
// cluster GEN-135).
//
// `Material.of(context)` returns the Material's render object,
// `_RenderInkFeatures extends RenderProxyBox implements
// MaterialInkController`. The interpreter wraps that private class in the
// nearest bridged class, RenderProxyBox, so the members it has only through
// the bridged interface (`color`, `vsync`, `addInkFeature`) are undefined:
// `Undefined property or method 'color' on bridged instance of
// 'RenderProxyBox'`. Native Dart builds it without error.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== MaterialInkController ===');
  final List<Type> types = [MaterialInkController];
  print('controller types: ${types.length}');
  return Material(
    color: Colors.amber,
    child: Builder(
      builder: (inner) {
        final MaterialInkController controller = Material.of(inner);
        // Output printed in this nested builder is not captured, so a wrong
        // answer throws, which the run reports. Native Dart passes both.
        if (controller.color != Colors.amber) {
          throw StateError('controller color: ${controller.color}');
        }
        if (identical(controller.vsync, controller)) {
          throw StateError('controller vsync is the controller');
        }
        return const SizedBox(width: 40, height: 40);
      },
    ),
  );
}
