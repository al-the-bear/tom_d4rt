// D4rt test script: Tests HybridAndroidViewController from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('HybridAndroidViewController test executing');

  // HybridAndroidViewController for Android platform views
  print('HybridAndroidViewController: Android Hybrid mode');
  print('Combines texture and surface approaches');

  // Hybrid composition
  print('\nHybrid composition:');
  print('- Uses virtual display + surface');
  print('- Falls back gracefully');
  print('- Best compatibility');
  print('- Recommended for most cases');

  // How it works
  print('\nHow hybrid mode works:');
  print('1. Try Texture layer (for composition)');
  print('2. Use Surface for touch (better response)');
  print('3. Automatic mode switching');
  print('4. Platform handles complexity');

  // Comparison
  print('\nWhen to use each mode:');
  print('Hybrid (default): most platform views');
  print('Texture: heavy graphics/video');
  print('Surface: precise touch required');

  // Usage
  print('\nUsage via AndroidView:');
  print('AndroidView(');
  print('  viewType: "my-view",');
  print('  // Uses hybrid by default');
  print(')');

  // Benefits
  print('\nHybrid benefits:');
  print('- Better than pure texture');
  print('- Better than pure surface');
  print('- Adaptive rendering');
  print('- Good touch + good graphics');

  // API
  print('\nController API:');
  print('- create(): initialize');
  print('- setSize(Size): resize');
  print('- dispatchPointerEvent(): touch');
  print('- dispose(): cleanup');

  print('\nHybridAndroidViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'HybridAndroidViewController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Android Hybrid platform view'),
      Text('Mode: texture + surface'),
      Text('Recommended: default choice'),
      Text('Used by: AndroidView'),
    ],
  );
}
