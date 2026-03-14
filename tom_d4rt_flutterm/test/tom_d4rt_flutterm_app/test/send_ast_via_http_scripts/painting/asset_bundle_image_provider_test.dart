// D4rt test script: Tests AssetBundleImageProvider conceptual via AssetImage from painting
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AssetBundleImageProvider test executing');
  final results = <String>[];

  // ========== AssetBundleImageProvider via AssetImage Tests ==========
  // AssetBundleImageProvider is an abstract base class
  // We test via concrete implementation AssetImage
  print('Testing AssetBundleImageProvider concepts via AssetImage...');

  // Test 1: Create basic AssetImage
  final assetImage1 = AssetImage('assets/images/logo.png');
  assert(assetImage1.assetName == 'assets/images/logo.png', 'Asset name should match');
  results.add('AssetImage name: ${assetImage1.assetName}');
  print('AssetImage created: ${assetImage1.assetName}');

  // Test 2: AssetImage with package
  final assetImage2 = AssetImage('icons/icon.png', package: 'my_package');
  assert(assetImage2.package == 'my_package', 'Package should match');
  results.add('AssetImage package: ${assetImage2.package}');
  print('AssetImage package: ${assetImage2.package}');

  // Test 3: AssetImage keyName with package
  final assetImage3 = AssetImage('icon.png', package: 'other_package');
  final keyName3 = assetImage3.keyName;
  assert(keyName3.contains('packages'), 'KeyName should contain packages');
  results.add('AssetImage keyName: $keyName3');
  print('AssetImage keyName: $keyName3');

  // Test 4: AssetImage without package keyName
  final assetImage4 = AssetImage('assets/test.png');
  assert(assetImage4.keyName == 'assets/test.png', 'KeyName should equal assetName');
  results.add('AssetImage no-package keyName: ${assetImage4.keyName}');
  print('AssetImage keyName without package verified');

  // Test 5: AssetImage with explicit bundle
  final customBundle = rootBundle;
  final assetImage5 = AssetImage('test.png', bundle: customBundle);
  assert(assetImage5.bundle == customBundle, 'Bundle should match');
  results.add('AssetImage bundle: bundled');
  print('AssetImage bundle reference verified');

  // Test 6: AssetImage equality
  final imgA = AssetImage('same.png');
  final imgB = AssetImage('same.png');
  assert(imgA == imgB, 'Same asset images should be equal');
  results.add('AssetImage equality: ${imgA == imgB}');
  print('AssetImage equality verified');

  // Test 7: AssetImage inequality
  final imgC = AssetImage('a.png');
  final imgD = AssetImage('b.png');
  assert(imgC != imgD, 'Different asset images should not be equal');
  results.add('AssetImage inequality: ${imgC != imgD}');
  print('AssetImage inequality verified');

  // Test 8: AssetImage hashCode consistency
  final hash1 = imgA.hashCode;
  final hash2 = imgB.hashCode;
  assert(hash1 == hash2, 'Equal images should have same hashCode');
  results.add('AssetImage hashCode: $hash1');
  print('AssetImage hashCode: $hash1');

  // Test 9: AssetImage toString
  final strVal = assetImage1.toString();
  assert(strVal.isNotEmpty, 'toString should not be empty');
  results.add('AssetImage toString: ${strVal.length} chars');
  print('AssetImage toString: $strVal');

  // Test 10: ExactAssetImage - related class
  final exactAsset = ExactAssetImage('assets/exact.png', scale: 2.0);
  assert(exactAsset.scale == 2.0, 'Scale should be 2.0');
  assert(exactAsset.assetName == 'assets/exact.png', 'Asset name should match');
  results.add('ExactAssetImage scale: ${exactAsset.scale}');
  print('ExactAssetImage: scale=${exactAsset.scale}');

  // Test 11: ExactAssetImage with package
  final exactAsset2 = ExactAssetImage('icon.png', scale: 1.0, package: 'pkg');
  assert(exactAsset2.package == 'pkg', 'Package should match');
  results.add('ExactAssetImage package: ${exactAsset2.package}');
  print('ExactAssetImage package: ${exactAsset2.package}');

  // Test 12: ExactAssetImage keyName
  final exactKeyName = exactAsset2.keyName;
  assert(exactKeyName.contains('packages'), 'Should contain packages path');
  results.add('ExactAssetImage keyName: $exactKeyName');
  print('ExactAssetImage keyName: $exactKeyName');

  // Test 13: ExactAssetImage equality
  final exact1 = ExactAssetImage('test.png', scale: 2.0);
  final exact2 = ExactAssetImage('test.png', scale: 2.0);
  assert(exact1 == exact2, 'Equal exact images should be equal');
  results.add('ExactAssetImage equality: ${exact1 == exact2}');
  print('ExactAssetImage equality verified');

  print('AssetBundleImageProvider test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('AssetBundleImageProvider Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
