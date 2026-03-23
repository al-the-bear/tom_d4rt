// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests TextureAndroidViewController from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('TextureAndroidViewController test executing');

  // TextureAndroidViewController for Android platform views
  print('TextureAndroidViewController: Android Texture mode');
  print('Renders native view to GPU texture');

  // How texture mode works
  print('\nTexture mode:');
  print('1. Native view renders to Surface');
  print('2. Surface copied to GPU texture');
  print('3. Flutter composites texture');
  print('4. Good for video/graphics');

  // Comparison with other modes
  print('\nAndroid view modes:');
  print('Texture (TextureAndroidViewController):');
  print('  - GPU texture rendering');
  print('  - Good for: video, animations');
  print('  - May have touch latency');
  print('');
  print('Surface (SurfaceAndroidViewController):');
  print('  - Direct SurfaceView');
  print('  - Better touch handling');
  print('');
  print('Hybrid (HybridAndroidViewController):');
  print('  - Best of both');
  print('  - Recommended default');

  // Usage
  print('\nUsage via AndroidView:');
  print('AndroidView(');
  print('  viewType: "video-player",');
  print('  // Texture mode good for video');
  print(')');

  // Methods
  print('\nController methods:');
  print('- create(): initialize native view');
  print('- setSize(): resize');
  print('- clearFocus(): remove focus');
  print('- dispose(): cleanup');

  // Texture ID
  print('\nTexture composition:');
  print('- textureId: GPU texture reference');
  print('- Flutter uses Texture widget');
  print('- Composited in render tree');

  print('\nTextureAndroidViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'TextureAndroidViewController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Android Texture platform view'),
      Text('Mode: GPU texture'),
      Text('Good for: video, graphics'),
      Text('Used by: AndroidView'),
    ],
  );
}
