// D4rt test script: Tests AssetMetadata from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

dynamic build(BuildContext context) {
  print('AssetMetadata comprehensive test executing');
  final results = <String>[];
  int passCount = 0;
  int failCount = 0;

  // Helper to record test results
  void recordTest(String name, bool passed) {
    if (passed) {
      passCount++;
      results.add('✓ $name');
      print('PASS: $name');
    } else {
      failCount++;
      results.add('✗ $name');
      print('FAIL: $name');
    }
  }

  // Test 1: AssetMetadata basic creation
  print('\n--- Test 1: AssetMetadata basic creation ---');
  try {
    final metadata = AssetMetadata(
      key: 'assets/images/logo.png',
      targetDevicePixelRatio: 2.0,
      main: true,
    );
    assert(metadata.key == 'assets/images/logo.png');
    assert(metadata.targetDevicePixelRatio == 2.0);
    assert(metadata.main == true);
    print('Key: ${metadata.key}');
    print('Target DPR: ${metadata.targetDevicePixelRatio}');
    print('Is main: ${metadata.main}');
    recordTest('AssetMetadata basic creation', true);
  } catch (e) {
    print('Error: $e');
    recordTest('AssetMetadata basic creation', false);
  }

  // Test 2: Non-main asset variant
  print('\n--- Test 2: Non-main asset variant ---');
  try {
    final variant = AssetMetadata(
      key: 'assets/images/2.0x/logo.png',
      targetDevicePixelRatio: 2.0,
      main: false,
    );
    assert(variant.main == false);
    assert(variant.key.contains('2.0x'));
    print('Variant key: ${variant.key}');
    print('Is main: ${variant.main}');
    recordTest('Non-main asset variant', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Non-main asset variant', false);
  }

  // Test 3: Various pixel ratios
  print('\n--- Test 3: Various pixel ratios ---');
  try {
    final ratios = [1.0, 1.5, 2.0, 2.5, 3.0, 4.0];
    for (final ratio in ratios) {
      final metadata = AssetMetadata(
        key: 'assets/test.png',
        targetDevicePixelRatio: ratio,
        main: ratio == 1.0,
      );
      print('DPR: ${metadata.targetDevicePixelRatio}');
      assert(metadata.targetDevicePixelRatio == ratio);
    }
    recordTest('Various pixel ratios', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Various pixel ratios', false);
  }

  // Test 4: Null pixel ratio
  print('\n--- Test 4: Null pixel ratio ---');
  try {
    final metadata = AssetMetadata(
      key: 'assets/data.json',
      targetDevicePixelRatio: null,
      main: true,
    );
    assert(metadata.targetDevicePixelRatio == null);
    print('Key: ${metadata.key}');
    print('Target DPR: ${metadata.targetDevicePixelRatio}');
    recordTest('Null pixel ratio', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Null pixel ratio', false);
  }

  // Test 5: Different asset paths
  print('\n--- Test 5: Different asset paths ---');
  try {
    final paths = [
      'assets/images/icon.png',
      'assets/fonts/Roboto.ttf',
      'assets/data/config.json',
      'packages/my_pkg/assets/logo.svg',
      'assets/animations/loading.json',
    ];
    for (final path in paths) {
      final metadata = AssetMetadata(
        key: path,
        targetDevicePixelRatio: null,
        main: true,
      );
      print('Path: ${metadata.key}');
      assert(metadata.key == path);
    }
    recordTest('Different asset paths', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Different asset paths', false);
  }

  // Test 6: Asset family with variants
  print('\n--- Test 6: Asset family with variants ---');
  try {
    final family = [
      AssetMetadata(
        key: 'assets/images/logo.png',
        targetDevicePixelRatio: 1.0,
        main: true,
      ),
      AssetMetadata(
        key: 'assets/images/1.5x/logo.png',
        targetDevicePixelRatio: 1.5,
        main: false,
      ),
      AssetMetadata(
        key: 'assets/images/2.0x/logo.png',
        targetDevicePixelRatio: 2.0,
        main: false,
      ),
      AssetMetadata(
        key: 'assets/images/3.0x/logo.png',
        targetDevicePixelRatio: 3.0,
        main: false,
      ),
    ];
    final mainCount = family.where((m) => m.main).length;
    assert(mainCount == 1);
    print('Asset family has ${family.length} variants');
    print('Main asset count: $mainCount');
    for (final m in family) {
      print('  ${m.key} (${m.targetDevicePixelRatio}x) main:${m.main}');
    }
    recordTest('Asset family with variants', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Asset family with variants', false);
  }

  // Test 7: Key with special characters
  print('\n--- Test 7: Key with special characters ---');
  try {
    final specialKeys = [
      'assets/my-image.png',
      'assets/my_image.png',
      'assets/my.image.png',
      'assets/my image.png',
    ];
    for (final key in specialKeys) {
      final metadata = AssetMetadata(
        key: key,
        targetDevicePixelRatio: 1.0,
        main: true,
      );
      print('Special key: ${metadata.key}');
      assert(metadata.key == key);
    }
    recordTest('Key with special characters', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Key with special characters', false);
  }

  // Test 8: Unicode in asset keys
  print('\n--- Test 8: Unicode in asset keys ---');
  try {
    final unicodeKeys = ['assets/日本語.png', 'assets/中文.png', 'assets/한국어.png'];
    for (final key in unicodeKeys) {
      final metadata = AssetMetadata(
        key: key,
        targetDevicePixelRatio: 1.0,
        main: true,
      );
      print('Unicode key: ${metadata.key}');
    }
    recordTest('Unicode in asset keys', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Unicode in asset keys', false);
  }

  // Test 9: Empty key handling
  print('\n--- Test 9: Empty key handling ---');
  try {
    final metadata = AssetMetadata(
      key: '',
      targetDevicePixelRatio: 1.0,
      main: true,
    );
    print('Empty key: "${metadata.key}"');
    assert(metadata.key == '');
    recordTest('Empty key handling', true);
  } catch (e) {
    print('Error: $e');
    recordTest('Empty key handling', false);
  }

  // Test 10: High DPI values
  print('\n--- Test 10: High DPI values ---');
  try {
    final highDpis = [4.0, 5.0, 6.0];
    for (final dpi in highDpis) {
      final metadata = AssetMetadata(
        key: 'assets/hd.png',
        targetDevicePixelRatio: dpi,
        main: false,
      );
      print('High DPI: ${metadata.targetDevicePixelRatio}');
      assert(metadata.targetDevicePixelRatio == dpi);
    }
    recordTest('High DPI values', true);
  } catch (e) {
    print('Error: $e');
    recordTest('High DPI values', false);
  }

  // Print summary
  print('\n========================================');
  print('AssetMetadata Test Summary');
  print('========================================');
  print('Passed: $passCount');
  print('Failed: $failCount');
  print('Total:  ${passCount + failCount}');
  print('========================================');

  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'AssetMetadata Test Results',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      SizedBox(height: 8),
      Text(
        'Passed: $passCount | Failed: $failCount',
        style: TextStyle(
          color: failCount == 0 ? Color(0xFF4CAF50) : Color(0xFFF44336),
        ),
      ),
      SizedBox(height: 8),
      ...results.map((r) => Text(r, style: TextStyle(fontSize: 12))),
    ],
  );
}
