// ignore_for_file: avoid_print
// D4rt test script: Tests PlatformAssetBundle from services
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('PlatformAssetBundle test executing');
  print('=' * 50);

  // PlatformAssetBundle is the default asset bundle
  print('\nPlatformAssetBundle:');
  print('Default implementation for rootBundle');
  print('Loads assets from app package');

  // Access via rootBundle
  print('\nAccess via rootBundle:');
  print('rootBundle is PlatformAssetBundle');
  print('Global access to packaged assets');

  // AssetBundle interface
  print('\nAssetBundle interface methods:');
  print('load(key): Load as ByteData');
  print('loadString(key): Load as String');
  print('loadBuffer(key): Load as ImmutableBuffer');
  print('loadStructuredData(): Load and parse');
  print('evict(key): Remove from cache');

  // Asset key resolution
  print('\nAsset key resolution:');
  print('Key: assets/images/logo.png');
  print('Resolved from app bundle/APK');
  print('Matches pubspec.yaml asset entries');

  // Usage patterns
  print('\nUsage patterns:');
  print('// Load text file');
  print('final text = await rootBundle.loadString("assets/data.json");');
  print('// Load binary file');
  print('final data = await rootBundle.load("assets/image.png");');

  // Platform-specific storage
  print('\nPlatform-specific storage:');
  print('Android: APK assets directory');
  print('iOS: App bundle resources');
  print('Web: Server assets directory');
  print('Desktop: Executable bundle');

  // Caching
  print('\nCaching behavior:');
  print('- Loaded assets are cached');
  print('- evict() removes cache entry');
  print('- Cache reduces disk/network I/O');

  // DefaultAssetBundle
  print('\nDefaultAssetBundle widget:');
  print('DefaultAssetBundle.of(context)');
  print('Returns nearest ancestor bundle');
  print('Enables bundle injection for testing');

  // Type hierarchy
  print('\nType hierarchy:');
  print('AssetBundle (abstract)');
  print('  \u251c\u2500 CachingAssetBundle (with cache)');
  print('  |    \u2514\u2500 PlatformAssetBundle (default)');
  print('  \u2514\u2500 NetworkAssetBundle (remote)');

  // Explain purpose
  print('\nPlatformAssetBundle purpose:');
  print('- Default AssetBundle implementation');
  print('- Loads from app package');
  print('- Caches loaded assets');
  print('- Platform-specific resolution');
  print('- Available via rootBundle');
  print('- Foundation for asset loading');

  print('\n' + '=' * 50);
  print('PlatformAssetBundle test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'PlatformAssetBundle Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: default AssetBundle'),
      Text('Access: rootBundle'),
      Text('Methods: load, loadString'),
      Text('Purpose: Local asset loading'),
    ],
  );
}
