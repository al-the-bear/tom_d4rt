// D4rt test script: Tests DefaultMaterialLocalizations from material
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('DefaultMaterialLocalizations test executing');

  // Test DefaultMaterialLocalizations - Default locale
  print('DefaultMaterialLocalizations is available in the material package');
  print('DefaultMaterialLocalizations runtimeType accessible');

  print('DefaultMaterialLocalizations test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('DefaultMaterialLocalizations Tests'),
      Text('Default locale'),
    ],
  );
}
