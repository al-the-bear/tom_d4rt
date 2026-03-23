// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests CachingAssetBundle from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('CachingAssetBundle test executing');

  // CachingAssetBundle is abstract - explain concept
  print('CachingAssetBundle extends AssetBundle');
  print('Adds caching layer for asset loading');

  // Get the default asset bundle
  print('\nDefault asset bundle:');
  final bundle = DefaultAssetBundle.of(context);
  print('DefaultAssetBundle type: ${bundle.runtimeType}');

  // AssetBundle methods
  print('\nAssetBundle methods:');
  print('- load(key): loads as ByteData');
  print('- loadString(key): loads as String');
  print('- loadStructuredData(): loads and parses');

  // Caching benefits
  print('\nCaching benefits:');
  print('- Avoids repeated disk/network IO');
  print('- Faster subsequent loads');
  print('- Memory trade-off for speed');

  // Clear cache
  print('\nClearing cache:');
  print('CachingAssetBundle.clear()');
  print('Removes all cached data');
  print('Used for: memory pressure, testing');

  // PlatformAssetBundle
  print('\nPlatformAssetBundle (impl):');
  print('- Default bundle for Flutter apps');
  print('- Loads from app assets folder');
  print('- Implements caching behavior');

  // Usage
  print('\nUsage:');
  print('DefaultAssetBundle.of(context).loadString("assets/data.json")');
  print('Image.asset("assets/image.png")');
  print('rootBundle.loadString("assets/config.yaml")');

  print('\nCachingAssetBundle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'CachingAssetBundle Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Cached asset loading'),
      Text('Parent: AssetBundle'),
      Text('Methods: load, loadString'),
      Text('clear(): remove cache'),
    ],
  );
}
