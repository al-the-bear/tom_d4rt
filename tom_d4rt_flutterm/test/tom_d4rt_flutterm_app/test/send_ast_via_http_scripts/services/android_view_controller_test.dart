// D4rt test script: Tests AndroidViewController from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AndroidViewController test executing');
  print('=' * 50);

  // AndroidViewController is abstract - explain usage
  print('\nAndroidViewController:');
  print('Abstract class for controlling Android platform views');

  // Controller types
  print('\nAndroidViewController implementations:');
  print('- SurfaceAndroidViewController (default)');
  print('- TextureAndroidViewController');
  print('- ExpensiveAndroidViewController');

  // Platform view concept
  print('\nPlatform view concept:');
  print('- Embed native Android views in Flutter');
  print('- WebView, MapView, VideoPlayer');
  print('- Touch events pass to native view');
  print('- Composited with Flutter widgets');

  // Creation via PlatformViewsService
  print('\nCreation via PlatformViewsService:');
  print('PlatformViewsService.initSurfaceAndroidView(');
  print('  id: viewId,');
  print('  viewType: "native_view_type",');
  print('  layoutDirection: TextDirection.ltr,');
  print(')');

  // Controller lifecycle
  print('\nController lifecycle:');
  print('1. Create controller');
  print('2. Call create() to initialize view');
  print('3. Set size and position');
  print('4. Handle touch events');
  print('5. Call dispose() when done');

  // Common properties
  print('\nController properties:');
  print('- viewId: Unique identifier');
  print('- viewType: Native view type string');
  print('- isCreated: Whether view is initialized');
  print('- layoutDirection: LTR or RTL');

  // Touch handling
  print('\nTouch handling:');
  print('dispatchPointerEvent() - forward to native');
  print('Touch events converted to MotionEvent');

  // Display modes
  print('\nDisplay modes:');
  print('Virtual Display: Renders to texture');
  print('Hybrid Composition: Native view layering');
  print('Trade-off: Performance vs. compatibility');

  // Type hierarchy
  print('\nType hierarchy:');
  print('PlatformViewController (base)');
  print('  \u2514\u2500 AndroidViewController (abstract)');
  print('       \u251c\u2500 SurfaceAndroidViewController');
  print('       \u251c\u2500 TextureAndroidViewController');
  print('       \u2514\u2500 ExpensiveAndroidViewController');

  // Explain purpose
  print('\nAndroidViewController purpose:');
  print('- Controls Android platform views');
  print('- create(): Initialize native view');
  print('- setSize(): Set view dimensions');
  print('- dispose(): Clean up resources');
  print('- Enables native view embedding');
  print('- Manages view lifecycle');

  print('\n' + '=' * 50);
  print('AndroidViewController test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AndroidViewController Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: abstract platform view controller'),
      Text('Platform: Android only'),
      Text('Modes: Surface, Texture, Hybrid'),
      Text('Purpose: Native view embedding'),
    ],
  );
}
