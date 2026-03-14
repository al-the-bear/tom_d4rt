// D4rt test script: Tests PlatformViewsService from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PlatformViewsService test executing');
  print('=' * 50);

  // PlatformViewsService static service
  print('\nPlatformViewsService:');
  print('Static service for creating platform view controllers');
  print('Factory methods for different view types');

  // Android factory methods
  print('\nAndroid factory methods:');
  print('initSurfaceAndroidView():');
  print('  - Virtual display rendering');
  print('  - Better performance');
  print('  ');
  print('initExpensiveAndroidView():');
  print('  - Hybrid composition');
  print('  - Better compatibility');
  print('  ');
  print('initAndroidView():');
  print('  - Texture layer rendering');
  print('  - Good for video');

  // iOS factory methods
  print('\niOS/macOS factory methods:');
  print('initUiKitView():');
  print('  - iOS UIView embedding');
  print('  ');
  print('initAppKitView():');
  print('  - macOS NSView embedding');

  // Common parameters
  print('\nCommon parameters:');
  print('- id: Unique view ID');
  print('- viewType: String (native view type)');
  print('- layoutDirection: TextDirection');
  print('- creationParams: Optional params');
  print('- creationParamsCodec: MessageCodec');

  // Usage example
  print('\nUsage example:');
  print('final controller = PlatformViewsService.initSurfaceAndroidView(');
  print('  id: _viewId,');
  print('  viewType: "my_native_view",');
  print('  layoutDirection: TextDirection.ltr,');
  print('  creationParams: {"param": "value"},');
  print('  creationParamsCodec: StandardMessageCodec(),');
  print(');');
  print('await controller.create();');

  // Platform channel
  print('\nPlatform channel:');
  print('SystemChannels.platform_views');
  print('Method: create, dispose, resize, touch');

  // View type registration
  print('\nView type registration (platform side):');
  print('Android: PlatformViewRegistry.registerViewFactory');
  print('iOS: FlutterPlatformViewFactory');

  // Type hierarchy
  print('\nType hierarchy:');
  print('PlatformViewsService (static service)');
  print('  \u2514\u2500 Factory methods for controllers');

  // Explain purpose
  print('\nPlatformViewsService purpose:');
  print('- Factory for platform view controllers');
  print('- initSurfaceAndroidView(): Android surface');
  print('- initUiKitView(): iOS UIKit view');
  print('- initAppKitView(): macOS AppKit view');
  print('- Manages platform channel communication');

  print('\n' + '=' * 50);
  print('PlatformViewsService test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlatformViewsService Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: static service'),
      Text('Android: initSurfaceAndroidView'),
      Text('iOS: initUiKitView'),
      Text('Purpose: Platform view factory'),
    ],
  );
}
