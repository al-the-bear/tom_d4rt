// D4rt test script: Tests ResizeImage from painting
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('ResizeImage test executing');
  final results = <String>[];

  // ========== ResizeImage Tests ==========
  print('Testing ResizeImage...');

  // Test 1: ResizeImage with width
  final originalImage1 = NetworkImage('https://example.com/large.png');
  final resized1 = ResizeImage(originalImage1, width: 100);
  assert(resized1.width == 100, 'Width should be 100');
  assert(resized1.height == null, 'Height should be null');
  results.add('ResizeImage width: ${resized1.width}');
  print('ResizeImage width: ${resized1.width}');

  // Test 2: ResizeImage with height
  final resized2 = ResizeImage(originalImage1, height: 200);
  assert(resized2.height == 200, 'Height should be 200');
  assert(resized2.width == null, 'Width should be null');
  results.add('ResizeImage height: ${resized2.height}');
  print('ResizeImage height: ${resized2.height}');

  // Test 3: ResizeImage with both dimensions
  final resized3 = ResizeImage(originalImage1, width: 150, height: 150);
  assert(resized3.width == 150, 'Width should be 150');
  assert(resized3.height == 150, 'Height should be 150');
  results.add('ResizeImage both: ${resized3.width}x${resized3.height}');
  print('ResizeImage both: ${resized3.width}x${resized3.height}');

  // Test 4: ResizeImage.resizeIfNeeded static method (width only)
  final provider4 = ResizeImage.resizeIfNeeded(100, null, originalImage1);
  results.add('ResizeImage.resizeIfNeeded width: created');
  print('ResizeImage.resizeIfNeeded with width');

  // Test 5: ResizeImage.resizeIfNeeded (height only)
  final provider5 = ResizeImage.resizeIfNeeded(null, 100, originalImage1);
  results.add('ResizeImage.resizeIfNeeded height: created');
  print('ResizeImage.resizeIfNeeded with height');

  // Test 6: ResizeImage.resizeIfNeeded (both null - returns original)
  final provider6 = ResizeImage.resizeIfNeeded(null, null, originalImage1);
  assert(
    provider6 == originalImage1,
    'Should return original when no resize needed',
  );
  results.add('ResizeImage.resizeIfNeeded null: returns original');
  print('ResizeImage.resizeIfNeeded with null returns original');

  // Test 7: ResizeImage with allowUpscaling false (default)
  final resized7 = ResizeImage(
    originalImage1,
    width: 50,
    allowUpscaling: false,
  );
  assert(resized7.allowUpscaling == false, 'allowUpscaling should be false');
  results.add('ResizeImage allowUpscaling: ${resized7.allowUpscaling}');
  print('ResizeImage allowUpscaling: ${resized7.allowUpscaling}');

  // Test 8: ResizeImage with allowUpscaling true
  final resized8 = ResizeImage(
    originalImage1,
    width: 500,
    allowUpscaling: true,
  );
  assert(resized8.allowUpscaling == true, 'allowUpscaling should be true');
  results.add('ResizeImage allowUpscaling true: ${resized8.allowUpscaling}');
  print('ResizeImage allowUpscaling true verified');

  // Test 9: ResizeImage with AssetImage
  final assetImage = AssetImage('assets/photo.png');
  final resizedAsset = ResizeImage(assetImage, width: 200, height: 200);
  assert(
    resizedAsset.imageProvider == assetImage,
    'Image provider should match',
  );
  results.add(
    'ResizeImage AssetImage: ${resizedAsset.width}x${resizedAsset.height}',
  );
  print('ResizeImage with AssetImage');

  // Test 10: ResizeImage imageProvider getter
  final innerProvider = resized1.imageProvider;
  assert(innerProvider == originalImage1, 'Inner provider should match');
  results.add('ResizeImage.imageProvider: verified');
  print('ResizeImage.imageProvider getter verified');

  // Test 11: ResizeImage policy (default)
  final resized11 = ResizeImage(originalImage1, width: 100);
  results.add('ResizeImage policy: default');
  print('ResizeImage default policy');

  // Test 12: ResizeImage equality
  final resizeA = ResizeImage(originalImage1, width: 100, height: 100);
  final resizeB = ResizeImage(originalImage1, width: 100, height: 100);
  assert(resizeA == resizeB, 'Same resize params should be equal');
  results.add('ResizeImage equality: ${resizeA == resizeB}');
  print('ResizeImage equality verified');

  // Test 13: ResizeImage hashCode
  final hash1 = resizeA.hashCode;
  final hash2 = resizeB.hashCode;
  assert(hash1 == hash2, 'Equal providers should have same hash');
  results.add('ResizeImage hashCode: $hash1');
  print('ResizeImage hashCode: $hash1');

  // Test 14: ResizeImage inequality
  final resizeC = ResizeImage(originalImage1, width: 100);
  final resizeD = ResizeImage(originalImage1, width: 200);
  assert(resizeC != resizeD, 'Different sizes should not be equal');
  results.add('ResizeImage inequality: ${resizeC != resizeD}');
  print('ResizeImage inequality verified');

  print('ResizeImage test completed with ${results.length} tests');
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('ResizeImage Tests'),
      Text('Tests passed: ${results.length}'),
      ...results.take(5).map((r) => Text(r, style: TextStyle(fontSize: 10))),
    ],
  );
}
