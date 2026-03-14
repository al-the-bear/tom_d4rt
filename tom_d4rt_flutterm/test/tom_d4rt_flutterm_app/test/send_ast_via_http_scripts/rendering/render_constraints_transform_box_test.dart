// D4rt test script: Tests RenderConstraintsTransformBox from rendering
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('RenderConstraintsTransformBox test executing');

  // RenderConstraintsTransformBox - Transforms constraints and applies transform matrix
  // Used by ConstraintsTransformBox widget to allow children to render at different sizes
  
  // Create a RenderConstraintsTransformBox
  final renderBox = RenderConstraintsTransformBox(
    alignment: Alignment.center,
    textDirection: TextDirection.ltr,
    constraintsTransform: (BoxConstraints constraints) {
      // Transform constraints - e.g., make unconstrained
      return const BoxConstraints();
    },
  );
  
  print('RenderConstraintsTransformBox created: $renderBox');
  print('alignment: ${renderBox.alignment}');
  print('textDirection: ${renderBox.textDirection}');
  print('constraintsTransform: ${renderBox.constraintsTransform}');
  
  // Test alignment property
  renderBox.alignment = Alignment.topLeft;
  print('\nAfter alignment change:');
  print('alignment: ${renderBox.alignment}');
  
  // Describe the purpose
  print('\nPurpose:');
  print('- Transform constraints passed to child');
  print('- Apply matrix transform to size child differently');
  print('- Allow child to paint at different size than layout');
  print('- Control overflow behavior with clipBehavior');
  
  // Type hierarchy
  print('\nType hierarchy:');
  print('RenderConstraintsTransformBox extends RenderAligningShiftedBox');
  print('RenderAligningShiftedBox extends RenderShiftedBox');
  print('RenderShiftedBox extends RenderBox with RenderObjectWithChildMixin');
  
  // Use cases
  print('\nUse cases:');
  print('- Render child at its natural size regardless of constraints');
  print('- Scale child widget to fit available space');
  print('- Create unconstrained layout areas');
  print('- Handle overflow by clipping or allowing paint outside bounds');

  print('\nRenderConstraintsTransformBox test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RenderConstraintsTransformBox Tests'),
      Text('Transforms constraints for child'),
      Text('alignment: topLeft'),
      Text('Allows child to render at natural size'),
    ],
  );
}
