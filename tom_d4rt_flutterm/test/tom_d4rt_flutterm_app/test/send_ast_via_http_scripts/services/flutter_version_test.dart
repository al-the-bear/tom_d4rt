// D4rt test script: Tests Flutter version information from services
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/foundation.dart';

dynamic build(BuildContext context) {
  print('Flutter Version test executing');
  final results = <String>[];
  var passCount = 0;
  var failCount = 0;

  // Test 1: Check kFlutterMemoryAllocationsEnabled constant
  print('Test 1: Checking kFlutterMemoryAllocationsEnabled constant');
  try {
    final memAllocEnabled = kFlutterMemoryAllocationsEnabled;
    print('  - kFlutterMemoryAllocationsEnabled: $memAllocEnabled');
    print('  - Type: ${memAllocEnabled.runtimeType}');
    assert(memAllocEnabled is bool);
    results.add('✓ kFlutterMemoryAllocationsEnabled accessible');
    passCount++;
  } catch (e) {
    results.add('✗ kFlutterMemoryAllocationsEnabled check failed: $e');
    failCount++;
  }

  // Test 2: Check kReleaseMode constant
  print('\nTest 2: Checking kReleaseMode constant');
  try {
    final releaseMode = kReleaseMode;
    print('  - kReleaseMode: $releaseMode');
    assert(releaseMode is bool);
    results.add('✓ kReleaseMode accessible: $releaseMode');
    passCount++;
  } catch (e) {
    results.add('✗ kReleaseMode check failed: $e');
    failCount++;
  }

  // Test 3: Check kDebugMode constant
  print('\nTest 3: Checking kDebugMode constant');
  try {
    final debugMode = kDebugMode;
    print('  - kDebugMode: $debugMode');
    assert(debugMode is bool);
    results.add('✓ kDebugMode accessible: $debugMode');
    passCount++;
  } catch (e) {
    results.add('✗ kDebugMode check failed: $e');
    failCount++;
  }

  // Test 4: Check kProfileMode constant
  print('\nTest 4: Checking kProfileMode constant');
  try {
    final profileMode = kProfileMode;
    print('  - kProfileMode: $profileMode');
    assert(profileMode is bool);
    results.add('✓ kProfileMode accessible: $profileMode');
    passCount++;
  } catch (e) {
    results.add('✗ kProfileMode check failed: $e');
    failCount++;
  }

  // Test 5: Verify exactly one mode is active
  print('\nTest 5: Verifying exactly one mode is active');
  try {
    final modeCount = [
      kDebugMode,
      kProfileMode,
      kReleaseMode,
    ].where((m) => m).length;
    print('  - Active modes count: $modeCount');
    print(
      '  - Debug: $kDebugMode, Profile: $kProfileMode, Release: $kReleaseMode',
    );
    assert(modeCount == 1);
    results.add('✓ Exactly one mode is active');
    passCount++;
  } catch (e) {
    results.add('✗ Mode verification failed: $e');
    failCount++;
  }

  // Test 6: Check kIsWeb constant
  print('\nTest 6: Checking kIsWeb constant');
  try {
    final isWeb = kIsWeb;
    print('  - kIsWeb: $isWeb');
    assert(isWeb is bool);
    results.add('✓ kIsWeb accessible: $isWeb');
    passCount++;
  } catch (e) {
    results.add('✗ kIsWeb check failed: $e');
    failCount++;
  }

  // Test 7: Check defaultTargetPlatform
  print('\nTest 7: Checking defaultTargetPlatform');
  try {
    final platform = defaultTargetPlatform;
    print('  - defaultTargetPlatform: $platform');
    print('  - Platform name: ${platform.name}');
    assert(platform is TargetPlatform);
    results.add('✓ defaultTargetPlatform accessible: ${platform.name}');
    passCount++;
  } catch (e) {
    results.add('✗ defaultTargetPlatform check failed: $e');
    failCount++;
  }

  // Test 8: Enumerate all TargetPlatform values
  print('\nTest 8: Enumerating TargetPlatform values');
  try {
    final platforms = TargetPlatform.values;
    print('  - Total platforms: ${platforms.length}');
    for (final p in platforms) {
      print('    - ${p.name}');
    }
    assert(platforms.length >= 6);
    assert(platforms.contains(TargetPlatform.android));
    assert(platforms.contains(TargetPlatform.iOS));
    results.add('✓ All ${platforms.length} TargetPlatform values enumerated');
    passCount++;
  } catch (e) {
    results.add('✗ TargetPlatform enumeration failed: $e');
    failCount++;
  }

  // Test 9: Platform-specific checks
  print('\nTest 9: Platform-specific checks');
  try {
    final platform = defaultTargetPlatform;
    final isDesktop =
        platform == TargetPlatform.linux ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.windows;
    final isMobile =
        platform == TargetPlatform.android || platform == TargetPlatform.iOS;
    print('  - Is desktop platform: $isDesktop');
    print('  - Is mobile platform: $isMobile');
    print('  - Is fuchsia: ${platform == TargetPlatform.fuchsia}');
    results.add(
      '✓ Platform classification: desktop=$isDesktop, mobile=$isMobile',
    );
    passCount++;
  } catch (e) {
    results.add('✗ Platform-specific checks failed: $e');
    failCount++;
  }

  // Test 10: Version string simulation
  print('\nTest 10: Simulating version string operations');
  try {
    final versionString = '3.19.0';
    final parts = versionString.split('.');
    assert(parts.length == 3);
    final major = int.parse(parts[0]);
    final minor = int.parse(parts[1]);
    final patch = int.parse(parts[2]);
    print('  - Version: $versionString');
    print('  - Major: $major, Minor: $minor, Patch: $patch');
    assert(major >= 0 && minor >= 0 && patch >= 0);
    results.add('✓ Version parsing works: $major.$minor.$patch');
    passCount++;
  } catch (e) {
    results.add('✗ Version string test failed: $e');
    failCount++;
  }

  // Test 11: Build mode documentation
  print('\nTest 11: Documenting build modes');
  try {
    final modes = {
      'Debug': 'Development mode with assertions enabled',
      'Profile': 'Performance profiling mode',
      'Release': 'Production mode with optimizations',
    };
    for (final entry in modes.entries) {
      print('  - ${entry.key}: ${entry.value}');
    }
    assert(modes.length == 3);
    results.add('✓ Build modes documented: ${modes.keys.join(", ")}');
    passCount++;
  } catch (e) {
    results.add('✗ Build mode documentation failed: $e');
    failCount++;
  }

  // Test 12: Current environment summary
  print('\nTest 12: Current environment summary');
  try {
    final env = <String, dynamic>{
      'platform': defaultTargetPlatform.name,
      'isWeb': kIsWeb,
      'isDebug': kDebugMode,
      'isProfile': kProfileMode,
      'isRelease': kReleaseMode,
    };
    print('  - Environment:');
    for (final entry in env.entries) {
      print('    ${entry.key}: ${entry.value}');
    }
    assert(env.isNotEmpty);
    results.add('✓ Environment summary collected');
    passCount++;
  } catch (e) {
    results.add('✗ Environment summary failed: $e');
    failCount++;
  }

  // Print summary
  print('\n========== Test Summary ==========');
  print('Total tests: ${passCount + failCount}');
  print('Passed: $passCount');
  print('Failed: $failCount');
  print('===================================');

  for (final result in results) {
    print(result);
  }

  print('\nFlutter Version test completed');
  return Column(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Flutter Version Tests',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      SizedBox(height: 8),
      Text('Platform: ${defaultTargetPlatform.name}'),
      Text(
        'Mode: ${kDebugMode
            ? "Debug"
            : kProfileMode
            ? "Profile"
            : "Release"}',
      ),
      SizedBox(height: 8),
      Text(
        'Passed: $passCount / ${passCount + failCount}',
        style: TextStyle(
          color: failCount == 0 ? Color(0xFF4CAF50) : Color(0xFFF44336),
        ),
      ),
      SizedBox(height: 8),
      ...results.map(
        (r) => Padding(
          padding: EdgeInsets.symmetric(vertical: 2),
          child: Text(r, style: TextStyle(fontSize: 12)),
        ),
      ),
    ],
  );
}
