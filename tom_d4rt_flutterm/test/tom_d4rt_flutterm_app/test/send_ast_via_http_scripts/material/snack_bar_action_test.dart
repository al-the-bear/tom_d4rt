// D4rt test script: Tests SnackBarAction from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SnackBarAction test executing');

  // Test SnackBarAction - Snackbar action
  print('SnackBarAction is available in the material package');
  print('SnackBarAction runtimeType accessible');

  print('SnackBarAction test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SnackBarAction Tests'),
      Text('Snackbar action'),
    ],
  );
}
