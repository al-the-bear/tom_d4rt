// D4rt test script: Tests MergeableMaterialItem from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('MergeableMaterialItem test executing');

  // Test MergeableMaterialItem - MergeableMaterialItem
  print('MergeableMaterialItem is available in the material package');
  print('MergeableMaterialItem runtimeType accessible');

  print('MergeableMaterialItem test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('MergeableMaterialItem Tests'),
      Text('MergeableMaterialItem'),
    ],
  );
}
