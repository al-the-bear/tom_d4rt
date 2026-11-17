/// Finding the Dart SDK the resolving check analyzes against.
///
/// The analyzer needs an SDK folder (`<sdk>/version`, `<sdk>/lib/...`). The
/// AOT-compiled `astgen` cannot take it from the running executable (that is
/// `astgen` itself, so the analyzer's own default fails with
/// `PathNotFoundException(.../version)`), so it is looked up the way a user's
/// shell would find Dart: an explicit path, then `DART_SDK`, then the `dart` on
/// `PATH`, then the `flutter` on `PATH` (whose SDK is `bin/cache/dart-sdk`),
/// and last the SDK of the running Dart VM when it is one (`dart run`).
library;

import 'dart:io';

import 'package:path/path.dart' as p;

/// No Dart SDK was found; [searched] names every place that was looked at.
class DartSdkNotFoundException implements Exception {
  /// What was looked at, in order, each with why it was not an SDK.
  final List<String> searched;

  DartSdkNotFoundException(this.searched);

  @override
  String toString() =>
      'DartSdkNotFoundException: no Dart SDK found for the resolving check. '
      'Searched:\n${searched.map((s) => '  - $s').join('\n')}\n'
      'Put `dart` or `flutter` on PATH, set DART_SDK, or pass the SDK path '
      '(`--dart-sdk`, `AstBundlerConfig.sdkPath`).';
}

/// Whether [path] is a Dart SDK folder: it holds `version` and
/// `lib/_internal`.
bool isDartSdk(String path) =>
    File(p.join(path, 'version')).existsSync() &&
    Directory(p.join(path, 'lib', '_internal')).existsSync();

/// Finds the Dart SDK: [explicitPath] when given, else `DART_SDK` of
/// [environment], else the SDK of the `dart` on `PATH`, else that of the
/// `flutter` on `PATH`, else the running VM's when it is a Dart SDK.
///
/// [environment] defaults to [Platform.environment], [isWindows] to
/// [Platform.isWindows] and [resolvedExecutable] to
/// [Platform.resolvedExecutable]; tests pass their own. Throws
/// [DartSdkNotFoundException] naming every place searched.
String findDartSdk({
  String? explicitPath,
  Map<String, String>? environment,
  bool? isWindows,
  String? resolvedExecutable,
}) {
  final env = environment ?? Platform.environment;
  final windows = isWindows ?? Platform.isWindows;
  final searched = <String>[];

  String? accept(String candidate, String what) {
    final normalized = p.normalize(p.absolute(candidate));
    if (isDartSdk(normalized)) return normalized;
    searched.add('$what: $normalized (no version / lib/_internal)');
    return null;
  }

  if (explicitPath != null) {
    final found = accept(explicitPath, 'explicit SDK path');
    if (found != null) return found;
    throw DartSdkNotFoundException(searched);
  }

  final dartSdkVar = env['DART_SDK'];
  if (dartSdkVar != null && dartSdkVar.isNotEmpty) {
    final found = accept(dartSdkVar, 'DART_SDK');
    if (found != null) return found;
  } else {
    searched.add('DART_SDK: not set');
  }

  final pathDirs = (env['PATH'] ?? env['Path'] ?? '')
      .split(windows ? ';' : ':')
      .where((d) => d.isNotEmpty)
      .toList();

  // `dart` on PATH: `<sdk>/bin/dart`, or Flutter's `<flutter>/bin/dart`
  // wrapper, whose SDK is `<flutter>/bin/cache/dart-sdk`.
  final dart = _onPath('dart', pathDirs, windows, const ['.exe', '.bat']);
  if (dart == null) {
    searched.add('dart on PATH: not found');
  } else {
    final bin = p.dirname(_resolveLinks(dart));
    final found =
        accept(p.dirname(bin), 'dart on PATH ($dart)') ??
        accept(
          p.join(bin, 'cache', 'dart-sdk'),
          'dart on PATH ($dart), Flutter layout',
        );
    if (found != null) return found;
  }

  final flutter = _onPath('flutter', pathDirs, windows, const ['.bat', '.exe']);
  if (flutter == null) {
    searched.add('flutter on PATH: not found');
  } else {
    final bin = p.dirname(_resolveLinks(flutter));
    final found = accept(
      p.join(bin, 'cache', 'dart-sdk'),
      'flutter on PATH ($flutter)',
    );
    if (found != null) return found;
  }

  // Under `dart run` the VM is `<sdk>/bin/dart`; under the AOT `astgen` it is
  // astgen itself and this is not an SDK.
  final executable = resolvedExecutable ?? Platform.resolvedExecutable;
  final found = accept(
    p.dirname(p.dirname(executable)),
    'running executable ($executable)',
  );
  if (found != null) return found;

  throw DartSdkNotFoundException(searched);
}

/// The first `<dir>/<name>` (with one of [windowsExtensions] on Windows) of
/// [pathDirs] that exists.
String? _onPath(
  String name,
  List<String> pathDirs,
  bool windows,
  List<String> windowsExtensions,
) {
  for (final dir in pathDirs) {
    final names = windows
        ? [for (final ext in windowsExtensions) '$name$ext', name]
        : [name];
    for (final candidate in names) {
      final path = p.join(dir, candidate);
      if (File(path).existsSync()) return path;
    }
  }
  return null;
}

/// [path] with its symbolic links resolved (a Homebrew `dart` links into the
/// SDK's `bin`); [path] itself when it cannot be resolved.
String _resolveLinks(String path) {
  try {
    return File(path).resolveSymbolicLinksSync();
  } on FileSystemException {
    return path;
  }
}
