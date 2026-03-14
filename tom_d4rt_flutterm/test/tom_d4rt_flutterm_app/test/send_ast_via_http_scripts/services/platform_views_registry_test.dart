// D4rt test script: Tests PlatformViewsRegistry from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PlatformViewsRegistry test executing');

  // Access the singleton instance
  final registry = PlatformViewsRegistry.instance;

  print('Created: ${registry.runtimeType}');

  // Get next view ID
  print('\nView ID allocation:');
  final viewId1 = registry.getNextPlatformViewId();
  print('First view ID: $viewId1');

  final viewId2 = registry.getNextPlatformViewId();
  print('Second view ID: $viewId2');

  final viewId3 = registry.getNextPlatformViewId();
  print('Third view ID: $viewId3');

  // IDs should be sequential
  print('\nID sequence:');
  print(
    'IDs are sequential: ${viewId2 == viewId1 + 1 && viewId3 == viewId2 + 1}',
  );

  // Explain purpose
  print('\nPlatformViewsRegistry purpose:');
  print('- Generates unique IDs for platform views');
  print('- Singleton instance per app');
  print('- Used by PlatformView implementations');
  print('- Ensures no ID collisions');

  // Platform views
  print('\nPlatform views:');
  print('- AndroidView: Android native view');
  print('- UiKitView: iOS native view');
  print('- HtmlElementView: Web HTML element');
  print('- All need unique IDs from registry');

  // Usage pattern
  print('\nUsage pattern:');
  print('1. Get ID: registry.getNextPlatformViewId()');
  print('2. Create platform view with ID');
  print('3. Platform side creates native view');
  print('4. ID links Flutter and native views');

  print('\nPlatformViewsRegistry test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlatformViewsRegistry Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Unique ID generator for views'),
      Text('viewId1: $viewId1'),
      Text('viewId2: $viewId2'),
      Text('Sequential: ${viewId2 == viewId1 + 1}'),
    ],
  );
}
