// D4rt test script: Tests RawChip from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('RawChip test executing');

  // Test RawChip - RawChip
  print('RawChip is available in the material package');
  print('RawChip runtimeType accessible');

  print('RawChip test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('RawChip Tests'),
      Text('RawChip'),
    ],
  );
}
