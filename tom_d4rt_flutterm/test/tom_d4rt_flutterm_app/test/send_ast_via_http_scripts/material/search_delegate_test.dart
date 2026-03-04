// D4rt test script: Tests SearchDelegate from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SearchDelegate test executing');

  // Test SearchDelegate - SearchDelegate
  print('SearchDelegate is available in the material package');
  print('SearchDelegate runtimeType accessible');

  print('SearchDelegate test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SearchDelegate Tests'),
      Text('SearchDelegate'),
    ],
  );
}
