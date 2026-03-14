// D4rt test script: Tests AssetBundleImageKey from painting
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AssetBundleImageKey test executing');
  final results = <String>[];

  // ========== AssetBundleImageKey Tests ==========
  print('Testing AssetBundleImageKey...');

  // Test 1: Create AssetBundleImageKey with standard scale
  final bundle = rootBundle;
  final key1 = AssetBundleImageKey(
    bundle: bundle,
    name: 'assets/images/test.png',
    scale: 1.0,
  );
  assert(key1.name == 'assets/images/test.png', 'Name should match');
  assert(key1.scale == 1.0, 'Scale should be 1.0');
  results.add('AssetBundleImageKey name: ${key1.name}');
  print('AssetBundleImageKey created: ${key1.name}');

  // Test 2: AssetBundleImageKey with 2x scale
  final key2 = AssetBundleImageKey(
    bundle: bundle,
    name: 'assets/images/2x/test.png',
    scale: 2.0,
  );
  assert(key2.scale == 2.0, 'Scale should be 2.0');
  results.add('AssetBundleImageKey 2x scale: ${key2.scale}');
  print('AssetBundleImageKey 2x: scale=${key2.scale}');

  // Test 3: AssetBundleImageKey with 3x scale
  final key3 = AssetBundleImageKey(
    bundle: bundle,
    name: 'assets/images/3x/test.png',
    scale: 3.0,
  );
  assert(key3.scale == 3.0, 'Scale should be 3.0');
  results.add('AssetBundleImageKey 3x scale: ${key3.scale}');
  print('AssetBundleImageKey 3x: scale=${key3.scale}');

  // Test 4: AssetBundleImageKey with fractional scale
  final key4 = AssetBundleImageKey(
    bundle: bundle,
    name: 'assets/images/1.5x/test.png',
    scale: 1.5,
  );
  assert(key4.scale == 1.5, 'Scale should be 1.5');
  results.add('AssetBundleImageKey 1.5x scale: ${key4.scale}');
  print('AssetBundleImageKey 1.5x: scale=${key4.scale}');

  // Test 5: AssetBundleImageKey bundle reference
  final key5 = AssetBundleImageKey(
    bundle: bundle,
    name: 'test_asset.png',
    scale: 1.0,
  );
  assert(key5.bundle == bundle, 'Bundle should match rootBundle');
  results.add('AssetBundleImageKey bundle: verified');
  print('AssetBundleImageKey bundle reference verified');

  // Test 6: AssetBundleImageKey with different path
  final key6 = AssetBundleImageKey(
    bundle: bundle,
    name: 'packages/my_package/icons/icon.png',
    scale: 1.0,
  );
  assert(key6.name.contains('packages'), 'Name should contain packages');
  results.add('AssetBundleImageKey package path: ${key6.name}');
  print('AssetBundleImageKey package path verified');

  // Test 7: AssetBundleImageKey equality - same values
  final keyA = AssetBundleImageKey(
    bundle: bundle,
    name: 'same.png',
    scale: 1.0,
  );
  final keyB = AssetBundleImageKey(
    bundle: bundle,
    name: 'same.png',
    scale: 1.0,
  );
  assert(keyA == keyB, 'Same keys should be equal');
  results.add('AssetBundleImageKey equality: ${keyA == keyB}');
  print('AssetBundleImageKey equality verified');

  // Test 8: AssetBundleImageKey inequality - different names
  final keyC = AssetBundleImageKey(bundle: bundle, name: 'a.png', scale: 1.0);
  final keyD = AssetBundleImageKey(bundle: bundle, name: 'b.png', scale: 1.0);
  assert(keyC != keyD, 'Different names should not be equal');
  results.add('AssetBundleImageKey inequality (name): ${keyC != keyD}');
  print('AssetBundleImageKey name inequality verified');

  // Test 9: AssetBundleImageKey inequality - different scales
  final keyE = AssetBundleImageKey(
    bundle: bundle,
    name: 'test.png',
    scale: 1.0,
  );
  final keyF = AssetBundleImageKey(
    bundle: bundle,
    name: 'test.png',
    scale: 2.0,
  );
  assert(keyE != keyF, 'Different scales should not be equal');
  results.add('AssetBundleImageKey inequality (scale): ${keyE != keyF}');
  print('AssetBundleImageKey scale inequality verified');

  // Test 10: AssetBundleImageKey hashCode
  final hash1 = keyA.hashCode;
  final hash2 = keyB.hashCode;
  assert(hash1 == hash2, 'Equal keys should have same hashCode');
  results.add('AssetBundleImageKey hashCode: $hash1');
  print('AssetBundleImageKey hashCode: $hash1');

  // Test 11: AssetBundleImageKey toString
  final keyStr = key1.toString();
  assert(keyStr.isNotEmpty, 'toString should not be empty');
  results.add('AssetBundleImageKey toString: ${keyStr.length} chars');
  print('AssetBundleImageKey toString: $keyStr');

  // Test 12: AssetBundleImageKey with nested directory
  final key12 = AssetBundleImageKey(
    bundle: bundle,
    name: 'assets/category/subcategory/deep/image.png',
    scale: 1.0,
  );
  assert(key12.name.split('/').length == 5, 'Should have 5 path segments');
  results.add('AssetBundleImageKey nested path: ${key12.name}');
  print('AssetBundleImageKey nested path verified');

  print('AssetBundleImageKey test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AssetBundleImageKey Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
