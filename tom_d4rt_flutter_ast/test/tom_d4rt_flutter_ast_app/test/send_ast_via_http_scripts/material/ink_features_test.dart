// ignore_for_file: avoid_print
// D4rt test script: InkFeature, InkHighlight, InteractiveInkFeature,
// MaterialInkController (material, addtests2).
//
// Ink features are painted by a Material's render object. InkFeature and
// InteractiveInkFeature are abstract, MaterialInkController is the
// interface a Material's render object implements, and an InkHighlight
// needs that controller and a laid-out reference box - which exist only
// once the Material below is in the tree. So the script names them in type
// positions, reaches the controller through `Material.of` inside the
// Material it builds, and lets an InkWell create its highlights.
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('=== ink features ===');
  final List<Type> features = [
    InkFeature,
    InteractiveInkFeature,
    InkHighlight,
    MaterialInkController,
  ];
  print('ink feature types: ${features.length}');
  return Material(
    color: Colors.amber,
    child: Builder(
      builder: (inner) {
        final MaterialInkController controller = Material.of(inner);
        // Its members are GEN-135 (material_ink_controller_test). Output
        // printed in this nested builder is not captured, so a wrong answer
        // throws, which the run reports.
        if (!identical(controller, Material.of(inner))) {
          throw StateError('Material.of returned another controller');
        }
        return InkWell(
          highlightColor: Colors.red,
          onTap: () {},
          child: const SizedBox(width: 120, height: 48, child: Text('ink')),
        );
      },
    ),
  );
}
