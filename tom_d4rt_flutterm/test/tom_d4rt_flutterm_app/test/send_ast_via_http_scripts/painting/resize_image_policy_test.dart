// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests ResizeImagePolicy from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('ResizeImagePolicy test executing');
  print('=' * 50);

  // Enumerate all values
  print('\nResizeImagePolicy values:');
  for (final value in ResizeImagePolicy.values) {
    print('  ${value.name}: index=${value.index}');
  }
  print('ResizeImagePolicy has ${ResizeImagePolicy.values.length} values');

  // First and last
  final first = ResizeImagePolicy.values.first;
  final last = ResizeImagePolicy.values.last;
  print('\nFirst: $first (${first.name}, index ${first.index})');
  print('Last: $last (${last.name}, index ${last.index})');

  // Specific values
  print('\nSpecific values:');
  print('exact: ${ResizeImagePolicy.exact.name} (index ${ResizeImagePolicy.exact.index})');
  print('  Resize the image to exactly the specified dimensions');
  print('  The decoded image will match the target width/height exactly');
  print('  May distort the image if aspect ratio differs');
  print('fit: ${ResizeImagePolicy.fit.name} (index ${ResizeImagePolicy.fit.index})');
  print('  Resize to fit within the specified dimensions');
  print('  Maintains aspect ratio, may be smaller than target');
  print('  Similar to BoxFit.contain behavior');

  // ResizeImage integration
  print('\nResizeImage integration:');
  print('  ResizeImage(imageProvider, width: 100, policy: ResizeImagePolicy.exact)');
  print('  ResizeImage(imageProvider, height: 200, policy: ResizeImagePolicy.fit)');
  print('  Default policy: ResizeImagePolicy.exact');

  // Memory optimization context
  print('\nMemory optimization:');
  print('  ResizeImage decodes images at a smaller size');
  print('  Reduces memory usage for large images');
  print('  exact: precise control over decoded size');
  print('  fit: preserves aspect ratio at lower memory cost');
  print('  Important for lists with many images');

  // Comparison to BoxFit
  print('\nComparison to BoxFit:');
  print('  exact is like BoxFit.fill (forces dimensions)');
  print('  fit is like BoxFit.contain (preserves ratio)');
  print('  ResizeImagePolicy works at decode time, BoxFit at paint time');

  // Equality tests
  print('\nEquality tests:');
  print('exact == exact: ${ResizeImagePolicy.exact == ResizeImagePolicy.exact}');
  print('exact == fit: ${ResizeImagePolicy.exact == ResizeImagePolicy.fit}');
  print('identical: ${identical(ResizeImagePolicy.exact, ResizeImagePolicy.values[0])}');

  // Type checks
  print('\nType checks:');
  print('runtimeType: ${first.runtimeType}');
  print('is ResizeImagePolicy: ${first is ResizeImagePolicy}');
  print('is Enum: ${first is Enum}');

  // String representations
  print('\nString representations:');
  for (final value in ResizeImagePolicy.values) {
    print('  toString: $value, name: ${value.name}');
  }

  // Collection operations
  print('\nCollection operations:');
  final policyMap = {for (final p in ResizeImagePolicy.values) p.name: p.index};
  print('  Map: $policyMap');
  print('  Reversed: ${ResizeImagePolicy.values.reversed.map((v) => v.name).join(', ')}');

  print('\n' + '=' * 50);
  print('ResizeImagePolicy test completed');

  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'ResizeImagePolicy Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Values: ${ResizeImagePolicy.values.length}'),
      for (final v in ResizeImagePolicy.values)
        Text('  ${v.name} (${v.index})'),
      Text('ResizeImage: decode-time resize strategy'),
    ],
  );
}
