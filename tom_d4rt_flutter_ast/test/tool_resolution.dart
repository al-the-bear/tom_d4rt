/// Finding `flutter` and `dart` for the corpus harness, on every platform the
/// fleet runs it on.
///
/// The harness used to ask `which`, which does not exist on Windows. The call
/// threw, the throw was swallowed, the Linux fallback path did not exist
/// either, and every run on legiondary01 died in `setUpAll` with "Flutter
/// executable not found" while `flutter` was on PATH and had just run
/// `pub get` for the same runner. No corpus run could have started there.
///
/// Measured on legiondary01 (Flutter 3.44.6, 2026-09-25):
///
///   * `where flutter` prints the extensionless bash script (shipped for Git
///     Bash) FIRST and `flutter.bat` second; `dart` is the same. Taking the
///     first line, the obvious port of `which`, picks a file CreateProcess
///     cannot execute. So on Windows the first entry with a runnable
///     extension wins.
///   * `Process.start` launches `flutter.bat` directly, with or without
///     `runInShell`, so the resolved path needs no special launch.
///
/// This file is identical in both flutter twins (`test/tool_resolution.dart`);
/// `sce170_twin_test_infrastructure_test.dart` fails when the copies differ.
library;

import 'dart:io';

/// The extensions Windows can execute directly, in PATHEXT's usual order.
const List<String> windowsRunnableExtensions = ['.exe', '.bat', '.cmd'];

/// Resolves the tool [name] (`flutter`, `dart`), or null when none is found.
///
/// Order: the [envVar] override when it names an existing file, then the
/// platform's PATH lookup (`where` on Windows, `which` elsewhere), then each of
/// [fallbacks] that exists.
Future<String?> resolveTool(
  String name, {
  required String envVar,
  List<String> fallbacks = const [],
}) async {
  final fromEnv = Platform.environment[envVar];
  if (fromEnv != null && fromEnv.isNotEmpty && File(fromEnv).existsSync()) {
    return fromEnv;
  }

  try {
    final result = await Process.run(Platform.isWindows ? 'where' : 'which', [
      name,
    ]);
    if (result.exitCode == 0) {
      final picked = pickFromPathLookup(
        (result.stdout as String).split(RegExp(r'\r?\n')),
        windows: Platform.isWindows,
      );
      if (picked != null) return picked;
    }
  } on ProcessException {
    // No lookup command on this machine; the fallbacks are the last resort.
  }

  for (final candidate in fallbacks) {
    if (File(candidate).existsSync()) return candidate;
  }
  return null;
}

/// The entry of a PATH lookup's output that can actually be executed.
///
/// On Windows that is the first line with a [windowsRunnableExtensions]
/// extension; elsewhere, the first line. Blank lines are ignored.
String? pickFromPathLookup(Iterable<String> lines, {required bool windows}) {
  final candidates = [
    for (final line in lines)
      if (line.trim().isNotEmpty) line.trim(),
  ];
  if (!windows) return candidates.isEmpty ? null : candidates.first;
  for (final candidate in candidates) {
    final lower = candidate.toLowerCase();
    if (windowsRunnableExtensions.any(lower.endsWith)) return candidate;
  }
  return null;
}

/// [tool]'s file name beside another tool in the same `bin/` directory: `dart`
/// next to `flutter`, as `dart.bat` on Windows.
String siblingToolName(String tool, {required bool windows}) =>
    windows ? '$tool.bat' : tool;
