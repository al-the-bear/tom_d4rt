/// Formats generated Dart exactly as `dart format` would in the package that
/// receives it (SCG5, from sce123).
///
/// The generator assembles `*.b.dart` by string concatenation, and `dart
/// format` rewrote 18 of 27 files in each Flutter twin's `lib/`. Formatting
/// the output by hand afterwards starts a fight nobody wins: format,
/// regenerate, and the diff is back. So the repo's format guards had to
/// exclude generated files. Formatting in the generator's write path ends
/// that. Every consumer's output is `dart format`-clean the moment it is
/// written, whichever regen tool wrote it.
///
/// THE LANGUAGE VERSION IS THE TARGET PACKAGE'S, not the generator's. `dart
/// format` chooses its style from the language version of the package a file
/// belongs to (the tall style from 3.7), read from that package's
/// `.dart_tool/package_config.json`. Formatting with any other version gives
/// output that the consumer's own `dart format` then rewrites, so this reads the
/// same source, falling back to the pubspec's SDK lower bound and then to the
/// formatter's latest version.
library;

import 'dart:convert';
import 'dart:io';

import 'package:dart_style/dart_style.dart';
import 'package:path/path.dart' as p;
import 'package:pub_semver/pub_semver.dart';

/// Language versions already resolved, by package root.
final Map<String, Version> _languageVersions = {};

/// [code] formatted for the package containing [outputPath].
///
/// Code the formatter cannot parse is returned unchanged: generated output that
/// does not parse is a defect the consumer's analyzer reports with a location,
/// and failing the whole generation here would hide which file was bad.
String formatGeneratedDart(String code, {required String outputPath}) {
  final formatter = DartFormatter(
    languageVersion: _languageVersionFor(outputPath),
  );
  try {
    return formatter.format(code, uri: outputPath);
  } on FormatterException {
    return code;
  }
}

Version _languageVersionFor(String outputPath) {
  final root = _packageRootOf(p.absolute(outputPath));
  if (root == null) return DartFormatter.latestLanguageVersion;
  return _languageVersions[root] ??= _readLanguageVersion(root);
}

/// The nearest ancestor directory holding a `pubspec.yaml`.
String? _packageRootOf(String path) {
  var dir = p.dirname(path);
  while (true) {
    if (File(p.join(dir, 'pubspec.yaml')).existsSync()) return dir;
    final parent = p.dirname(dir);
    if (parent == dir) return null;
    dir = parent;
  }
}

Version _readLanguageVersion(String root) {
  final name = _pubspecName(root);
  final config = File(p.join(root, '.dart_tool', 'package_config.json'));
  if (name != null && config.existsSync()) {
    try {
      final json =
          jsonDecode(config.readAsStringSync()) as Map<String, Object?>;
      for (final entry in json['packages'] as List<Object?>) {
        if (entry is Map && entry['name'] == name) {
          final version = entry['languageVersion'];
          if (version is String) return Version.parse('$version.0');
        }
      }
    } on FormatException {
      // Fall through to the pubspec.
    }
  }
  final floor = _sdkFloor(root);
  if (floor != null) return Version(floor.major, floor.minor, 0);
  return DartFormatter.latestLanguageVersion;
}

String? _pubspecName(String root) {
  final match = RegExp(
    r'^name:\s*(\S+)',
    multiLine: true,
  ).firstMatch(File(p.join(root, 'pubspec.yaml')).readAsStringSync());
  return match?.group(1);
}

/// The lower bound of the pubspec's `environment: sdk:` constraint.
Version? _sdkFloor(String root) {
  final pubspec = File(p.join(root, 'pubspec.yaml')).readAsStringSync();
  final match = RegExp(
    r'''^\s+sdk:\s*['"]?([^'"\n]+)''',
    multiLine: true,
  ).firstMatch(pubspec);
  if (match == null) return null;
  try {
    final constraint = VersionConstraint.parse(match.group(1)!.trim());
    if (constraint is VersionRange) return constraint.min;
    if (constraint is Version) return constraint;
  } on FormatException {
    return null;
  }
  return null;
}
