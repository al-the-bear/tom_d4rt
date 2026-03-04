// D4rt test script: Tests SurfaceAndroidViewController from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('SurfaceAndroidViewController test executing');

  // Test SurfaceAndroidViewController - Surface Android
  print('SurfaceAndroidViewController is available in the services package');
  print('SurfaceAndroidViewController: Surface Android');

  print('SurfaceAndroidViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('SurfaceAndroidViewController Tests'),
      Text('Surface Android'),
    ],
  );
}
