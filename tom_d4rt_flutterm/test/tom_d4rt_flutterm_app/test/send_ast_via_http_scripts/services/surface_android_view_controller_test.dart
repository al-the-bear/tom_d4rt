// D4rt test script: Tests SurfaceAndroidViewController from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('SurfaceAndroidViewController test executing');

  // SurfaceAndroidViewController for Android platform views
  print('SurfaceAndroidViewController: Android Surface mode');
  print('Alternative to TextureAndroidViewController');

  // Comparison
  print('\nAndroid view controller types:');
  print('TextureAndroidViewController:');
  print('  - Uses texture (GPU)');
  print('  - Good for: video, maps');
  print('  - May have input issues');
  print('');
  print('SurfaceAndroidViewController:');
  print('  - Uses SurfaceView');
  print('  - Better touch handling');
  print('  - Native feel');
  print('');
  print('HybridAndroidViewController:');
  print('  - Combines both approaches');
  print('  - Best compatibility');

  // Cannot instantiate directly
  print('\nUsage via AndroidView:');
  print('AndroidView(');
  print('  viewType: "my-native-view",');
  print('  creationParams: params,');
  print('  creationParamsCodec: StandardMessageCodec(),');
  print(')');

  // Methods
  print('\nController methods:');
  print('- create(): create native view');
  print('- setSize(): resize view');
  print('- dispatchPointerEvent(): forward touches');
  print('- dispose(): cleanup');

  // Surface mode benefits
  print('\nSurface mode benefits:');
  print('- Direct hardware rendering');
  print('- Lower latency');
  print('- Better touch forwarding');
  print('- Native scrolling behavior');

  print('\nSurfaceAndroidViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'SurfaceAndroidViewController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Android Surface platform view'),
      Text('Mode: SurfaceView'),
      Text('Better: touch handling'),
      Text('Used by: AndroidView'),
    ],
  );
}
