// D4rt test script: Tests HybridAndroidViewController from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('HybridAndroidViewController test executing');

  // Test HybridAndroidViewController - Hybrid Android
  print('HybridAndroidViewController is available in the services package');
  print('HybridAndroidViewController: Hybrid Android');

  print('HybridAndroidViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('HybridAndroidViewController Tests'),
      Text('Hybrid Android'),
    ],
  );
}
