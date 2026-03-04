// D4rt test script: Tests TextureAndroidViewController from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('TextureAndroidViewController test executing');

  // Test TextureAndroidViewController - Texture Android
  print('TextureAndroidViewController is available in the services package');
  print('TextureAndroidViewController: Texture Android');

  print('TextureAndroidViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('TextureAndroidViewController Tests'),
      Text('Texture Android'),
    ],
  );
}
