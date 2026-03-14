// D4rt test script: Tests AssetBundleImageKey from painting
import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

dynamic build(BuildContext context) {
  print('AssetBundleImageKey test executing');

  // AssetBundleImageKey is the cache key for AssetImage
  print('AssetBundleImageKey uniquely identifies asset images');

  // Create via AssetImage
  final assetImage = AssetImage('placeholder.png');
  print('\nAssetImage: ${assetImage.runtimeType}');
  print('assetName: ${assetImage.assetName}');

  // Key components
  print('\nAssetBundleImageKey components:');
  print('- bundle: AssetBundle to load from');
  print('- name: asset path/name');
  print('- scale: resolution scale (1x, 2x, 3x)');

  // How key is created
  print('\nHow key is created:');
  print('1. AssetImage.obtainKey() called');
  print('2. Resolves asset for device pixel ratio');
  print('3. Returns AssetBundleImageKey');

  // Equality
  print('\nKey equality:');
  print('- Same bundle, name, scale = equal');
  print('- Different scale = different key');
  print('- Used for ImageCache lookups');

  // Resolution variant selection
  print('\nResolution variants:');
  print('Device 1.0x -> images/logo.png');
  print('Device 2.0x -> images/2.0x/logo.png');
  print('Device 3.0x -> images/3.0x/logo.png');

  // In ImageCache
  print('\nIn ImageCache:');
  print('- Key identifies cached image');
  print('- Prevents re-decoding same asset');
  print('- Scale-aware caching');

  print('\nAssetBundleImageKey test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AssetBundleImageKey Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Asset image cache key'),
      Text('Contains: bundle + name + scale'),
      Text('For: ImageCache lookups'),
    ],
  );
}
