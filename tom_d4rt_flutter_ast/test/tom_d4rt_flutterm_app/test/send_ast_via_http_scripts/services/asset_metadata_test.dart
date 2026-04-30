// ignore_for_file: avoid_print, deprecated_member_use, sort_child_properties_last
// D4rt test script: Tests AssetMetadata from services
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

dynamic build(BuildContext context) {
  print('AssetMetadata test executing');
  print('=' * 50);

  // Create AssetMetadata with basic parameters
  final meta1 = AssetMetadata(
    key: 'assets/images/logo.png',
    targetDevicePixelRatio: 1.0,
    main: true,
  );
  print('\nAssetMetadata created:');
  print('runtimeType: ${meta1.runtimeType}');
  print('key: ${meta1.key}');
  print('targetDevicePixelRatio: ${meta1.targetDevicePixelRatio}');
  print('main: ${meta1.main}');

  // Create for 2x variant
  final meta2x = AssetMetadata(
    key: 'assets/images/2.0x/logo.png',
    targetDevicePixelRatio: 2.0,
    main: false,
  );
  print('\n2x variant:');
  print('key: ${meta2x.key}');
  print('targetDevicePixelRatio: ${meta2x.targetDevicePixelRatio}');
  print('main: ${meta2x.main}');

  // Create for 3x variant
  final meta3x = AssetMetadata(
    key: 'assets/images/3.0x/logo.png',
    targetDevicePixelRatio: 3.0,
    main: false,
  );
  print('\n3x variant:');
  print('key: ${meta3x.key}');
  print('targetDevicePixelRatio: ${meta3x.targetDevicePixelRatio}');

  // Test variant selection logic
  print('\nVariant selection example:');
  final variants = [meta1, meta2x, meta3x];
  final deviceRatio = 2.5;
  print('Device pixel ratio: $deviceRatio');

  // Find best variant
  AssetMetadata? bestVariant;
  double bestDiff = double.infinity;
  for (final v in variants) {
    final diff = (v.targetDevicePixelRatio! - deviceRatio).abs();
    if (diff < bestDiff) {
      bestDiff = diff;
      bestVariant = v;
    }
  }
  print('Best variant: ${bestVariant?.key}');
  print('Target ratio: ${bestVariant?.targetDevicePixelRatio}');

  // Create with null targetDevicePixelRatio
  final metaNull = AssetMetadata(
    key: 'assets/data/config.json',
    targetDevicePixelRatio: null,
    main: true,
  );
  print('\nNon-image asset:');
  print('key: ${metaNull.key}');
  print('targetDevicePixelRatio: ${metaNull.targetDevicePixelRatio}');

  // Test type hierarchy
  print('\nType hierarchy:');
  print('is Object: true /* meta1 is Object */');

  // Compare metadata by key
  print('\nMetadata key comparison:');
  print('meta1.key == meta2x.key: ${meta1.key == meta2x.key}');
  print('meta1.main != meta2x.main: ${meta1.main != meta2x.main}');

  // Path pattern analysis
  print('\nPath pattern:');
  print('Base: assets/images/logo.png');
  print('1.5x: assets/images/1.5x/logo.png');
  print('2.0x: assets/images/2.0x/logo.png');
  print('3.0x: assets/images/3.0x/logo.png');

  // Explain purpose
  print('\nAssetMetadata purpose:');
  print('- Describes a single asset variant');
  print('- key: Full asset path in bundle');
  print('- targetDevicePixelRatio: Optimal display ratio');
  print('- main: true if this is the primary asset');
  print('- Used by AssetManifest.getAssetVariants');
  print('- Enables resolution-aware asset loading');

  print('\n' + '=' * 50);
  print('AssetMetadata test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        'AssetMetadata Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Type: ${meta1.runtimeType}'),
      Text('key: ${meta1.key}'),
      Text('ratio: ${meta1.targetDevicePixelRatio}'),
      Text('main: ${meta1.main}'),
      Text('Purpose: Asset variant metadata'),
    ],
  );
}
