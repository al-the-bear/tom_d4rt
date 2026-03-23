/// Shared Dart SDK path resolution utilities.
///
/// Used by both the bridge generator and proxy generator to locate the
/// Dart SDK when running as a compiled binary (where
/// `Platform.resolvedExecutable` points to the binary, not the Dart SDK).
library;

import 'dart:io';

import 'package:path/path.dart' as p;

/// Cached SDK path — resolved once, reused across calls.
String? _cachedSdkPath;

/// Resolves the Dart SDK path using multiple fallback strategies.
///
/// Resolution order:
/// 1. `DART_SDK` environment variable
/// 2. `DART_HOME` environment variable
/// 3. `Platform.resolvedExecutable` (works when running via `dart run`)
/// 4. `dart` executable in PATH (resolve symlinks)
/// 5. `flutter` executable in PATH → derive `bin/cache/dart-sdk`
/// 6. Fall back to `null` (let analyzer use its default)
///
/// When running d4rtgen as a compiled binary (e.g., from `~/.tom/bin/`),
/// the analyzer's default SDK detection fails because it derives the SDK
/// path from the executable location. Steps 1–5 handle this automatically.
String? getSdkPath() {
  if (_cachedSdkPath != null) return _cachedSdkPath;

  // 1. Check DART_SDK environment variable
  final dartSdkEnv = Platform.environment['DART_SDK'];
  if (dartSdkEnv != null && dartSdkEnv.isNotEmpty) {
    if (_isValidSdkPath(dartSdkEnv)) {
      _cachedSdkPath = dartSdkEnv;
      return _cachedSdkPath;
    }
  }

  // 2. Check DART_HOME environment variable
  final dartHomeEnv = Platform.environment['DART_HOME'];
  if (dartHomeEnv != null && dartHomeEnv.isNotEmpty) {
    if (_isValidSdkPath(dartHomeEnv)) {
      _cachedSdkPath = dartHomeEnv;
      return _cachedSdkPath;
    }
  }

  // 3. Try Platform.resolvedExecutable — when running via `dart run`,
  //    this points to the actual dart binary inside the SDK.
  //    For compiled binaries, this points to the binary itself
  //    (e.g., ~/.tom/bin/d4rtgen).
  try {
    final resolvedExe = Platform.resolvedExecutable;
    final sdk = _resolveSdkFromDartPath(resolvedExe);
    if (sdk != null) {
      _cachedSdkPath = sdk;
      return _cachedSdkPath;
    }
  } catch (_) {
    // Platform.resolvedExecutable can throw in some environments
  }

  // 4. Try to find dart in PATH and derive SDK path (resolve symlinks)
  try {
    final whichCmd = Platform.isWindows ? 'where.exe' : 'which';
    final result = Process.runSync(whichCmd, ['dart']);
    if (result.exitCode == 0) {
      final dartPath = (result.stdout as String)
          .trim()
          .split('\n')
          .first
          .trim();
      if (dartPath.isNotEmpty) {
        final sdk = _resolveSdkFromDartPath(dartPath);
        if (sdk != null) {
          _cachedSdkPath = sdk;
          return _cachedSdkPath;
        }
      }
    }
  } catch (_) {
    // Ignore errors from which/where command
  }

  // 5. Try to find flutter in PATH → <flutter>/bin/cache/dart-sdk
  try {
    final whichCmd = Platform.isWindows ? 'where.exe' : 'which';
    final result = Process.runSync(whichCmd, ['flutter']);
    if (result.exitCode == 0) {
      var flutterPath = (result.stdout as String)
          .trim()
          .split('\n')
          .first
          .trim();
      if (flutterPath.isNotEmpty) {
        // Resolve symlinks
        try {
          flutterPath = File(flutterPath).resolveSymbolicLinksSync();
        } catch (_) {}
        // flutter is at <flutter>/bin/flutter → parent of bin/ is flutter root
        final flutterRoot = p.dirname(p.dirname(flutterPath));
        final dartSdk = p.join(flutterRoot, 'bin', 'cache', 'dart-sdk');
        if (_isValidSdkPath(dartSdk)) {
          _cachedSdkPath = dartSdk;
          return _cachedSdkPath;
        }
      }
    }
  } catch (_) {
    // Ignore errors from which command
  }

  // 6. Return null - let analyzer use its default (may fail for compiled
  //    binaries)
  return null;
}

/// Validates that [sdkPath] looks like a Dart SDK (has `lib/_internal`).
bool _isValidSdkPath(String sdkPath) {
  return Directory(p.join(sdkPath, 'lib', '_internal')).existsSync();
}

/// Tries to resolve a Dart SDK from a dart executable path.
///
/// The dart binary can be at:
/// - `<sdk>/bin/dart` (standalone Dart SDK)
/// - `<flutter>/bin/dart` (Flutter wrapper → real SDK at
///   `<flutter>/bin/cache/dart-sdk`)
/// - A symlink to either of the above
String? _resolveSdkFromDartPath(String dartPath) {
  // Resolve symlinks to get the real path
  try {
    final resolved = File(dartPath).resolveSymbolicLinksSync();
    dartPath = resolved;
  } catch (_) {
    // If symlink resolution fails, continue with the original path
  }

  // dart is at <something>/bin/dart → parent of bin/ is the candidate
  var candidate = p.dirname(p.dirname(dartPath));

  // Direct SDK: <sdk>/bin/dart → candidate is <sdk>
  if (_isValidSdkPath(candidate)) return candidate;

  // Flutter SDK: <flutter>/bin/cache/dart-sdk/bin/dart → candidate is dart-sdk
  // But if dart is at <flutter>/bin/dart (wrapper), the real SDK is in cache
  final flutterCacheSdk = p.join(candidate, 'cache', 'dart-sdk');
  if (_isValidSdkPath(flutterCacheSdk)) return flutterCacheSdk;

  // Maybe the resolved path is already inside cache/dart-sdk/bin/
  // e.g. <flutter>/bin/cache/dart-sdk/bin/dart
  if (candidate.endsWith('dart-sdk') && _isValidSdkPath(candidate)) {
    return candidate;
  }

  return null;
}
