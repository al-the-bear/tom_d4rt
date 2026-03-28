// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ResizeImagePolicy from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ResizeImagePolicy test executing');
  print('=' * 50);

  // ResizeImagePolicy enum overview
  print('ResizeImagePolicy enum overview:');
  print('  - How ResizeImage resizes');
  print('  - Memory optimization strategy');
  print('  - 2 values: exact, fit');

  // Enumerate all values
  print('\nResizeImagePolicy values:');
  for (final value in ResizeImagePolicy.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('ResizeImagePolicy has ${ResizeImagePolicy.values.length} values');

  // Test exact
  print('\nTest ResizeImagePolicy.exact:');
  final exact = ResizeImagePolicy.exact;
  print('  Name: ${exact.name}');
  print('  Behavior: Resize to exact dimensions');
  print('  May distort aspect ratio');

  // Test fit
  print('\nTest ResizeImagePolicy.fit:');
  final fit = ResizeImagePolicy.fit;
  print('  Name: ${fit.name}');
  print('  Behavior: Resize to fit within bounds');
  print('  Preserves aspect ratio');

  // First and last
  print('\nFirst and last:');
  print('  First: ${ResizeImagePolicy.values.first}');
  print('  Last: ${ResizeImagePolicy.values.last}');

  // Usage context
  print('\nUsage context:');
  print('  ResizeImage.policy parameter');
  print('  Memory-constrained scenarios');

  // Example usage
  print('\nExample usage:');
  print('  ResizeImage(');
  print('    imageProvider,');
  print('    width: 100,');
  print('    height: 100,');
  print('    policy: ResizeImagePolicy.fit,');
  print('  )');

  // Switch pattern
  print('\nSwitch pattern:');
  final policy = ResizeImagePolicy.fit;
  switch (policy) {
    case ResizeImagePolicy.exact:
      print('  Exact dimensions');
      break;
    case ResizeImagePolicy.fit:
      print('  Fit within bounds');
      break;
  }

  // Comparison
  print('\nComparison:');
  print('  exact == exact: ${ResizeImagePolicy.exact == ResizeImagePolicy.exact}');
  print('  exact == fit: ${ResizeImagePolicy.exact == ResizeImagePolicy.fit}');

  // Memory considerations
  print('\nMemory considerations:');
  print('  Both reduce decoded image size');
  print('  exact: May use more calculation');
  print('  fit: More predictable size');

  print('\n' + '=' * 50);
  print('ResizeImagePolicy test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ResizeImagePolicy Tests', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
      SizedBox(height: 8),
      Text('Type: Enum'),
      Text('Values: exact, fit'),
      Text('Purpose: Image resize strategy'),
    ],
  );
}
