/// Disk-backed loader for D4rt test scripts.
///
/// The default script root is resolved from `Platform.resolvedExecutable` so
/// the app finds its sibling `tom_d4rt_flutter_ast` corpus regardless of the
/// CWD it was launched from. A CWD-relative fallback keeps `flutter run`
/// from the project directory working too.
library;

import 'dart:io';

import 'package:path/path.dart' as p;

/// A single D4rt test script loaded from disk.
class TestScript {
  /// Path relative to the chosen root — used as the script's display name.
  final String name;

  /// Raw Dart source. Fed straight into `SourceFlutterD4rt.execute()`.
  final String source;

  const TestScript({required this.name, required this.source});
}

/// Loads `.dart` test scripts from a directory tree.
///
/// All methods are static — there is no per-loader state. The owning
/// `ScriptRootNotifier` holds the current root and reloads on demand.
class TestScriptLoader {
  /// Default script root: resolved relative to the executable so the app
  /// works whether launched from Xcode, `flutter run`, or Finder.
  ///
  /// Layout assumption:
  ///
  ///     <workspace>/tom_ai/d4rt/tom_d4rt_flutter_test/   ← this project
  ///     <workspace>/tom_ai/d4rt/tom_d4rt_flutter_ast/    ← sibling
  ///
  /// On macOS the bundle sits at:
  ///
  ///     <project>/build/macos/Build/Products/Debug/tom_d4rt_flutter_test.app/
  ///         Contents/MacOS/tom_d4rt_flutter_test
  ///
  /// Walking up from the executable directory and probing for the sibling
  /// path locates the corpus across both desktop bundle layouts (macOS
  /// `.app`) and ELF binary layouts (Linux). The fallback returns the
  /// CWD-relative path so `flutter run` from inside the project dir works.
  static String get defaultRoot {
    final exeDir = File(Platform.resolvedExecutable).parent;
    for (var up = 0; up < 8; up++) {
      final candidate = p.join(
        exeDir.path,
        '../' * up,
        '../tom_d4rt_flutter_ast/test'
        '/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts',
      );
      final resolved = p.normalize(candidate);
      if (Directory(resolved).existsSync()) return resolved;
    }
    // Fallback: CWD-relative.
    return p.normalize(
      '../tom_d4rt_flutter_ast/test'
      '/tom_d4rt_flutter_ast_app/test/send_ast_via_http_scripts',
    );
  }

  /// Whether [root] points to an existing directory.
  static bool rootExists(String root) => Directory(root).existsSync();

  /// Load all `.dart` files under [root], sorted by relative path.
  ///
  /// Returns an empty list (not an error) when [root] does not exist —
  /// callers should pair this with [rootExists] and surface a banner
  /// instead of crashing.
  static List<TestScript> loadAll(String root) {
    final dir = Directory(root);
    if (!dir.existsSync()) return const [];
    return dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) => f.path.endsWith('.dart'))
        .map((f) => TestScript(
              name: p.relative(f.path, from: root),
              source: f.readAsStringSync(),
            ))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }
}
