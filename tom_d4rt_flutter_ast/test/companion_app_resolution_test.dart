// The companion-app resolution check the corpus harness runs before it
// launches the app: pure file reads, so these tests need no app and no GUI.
//
// Fixtures are written under this package's `.dart_tool/` and deleted
// afterwards.

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

import 'companion_app_resolution.dart';

String _lockEntry(String name, String version, {String source = 'hosted'}) =>
    '  $name:\n'
    '    dependency: transitive\n'
    '    description:\n'
    '      name: $name\n'
    '    source: $source\n'
    '    version: "$version"\n';

void _package(
  Directory dir, {
  required String name,
  String version = '1.0.0',
  List<String> lockEntries = const [],
  bool withLock = true,
}) {
  dir.createSync(recursive: true);
  File(
    '${dir.path}/pubspec.yaml',
  ).writeAsStringSync('name: $name\nversion: $version\n');
  if (withLock) {
    File('${dir.path}/pubspec.lock').writeAsStringSync(
      'packages:\n${lockEntries.join()}sdks:\n  dart: ">=3.0.0"\n',
    );
  }
}

void main() {
  late Directory root;
  late String parentDir;
  late String appDir;

  setUp(() {
    root = Directory(
      '${Directory.current.path}/.dart_tool/test_fixtures/'
      'companion_${pid}_${DateTime.now().microsecondsSinceEpoch}',
    )..createSync(recursive: true);
    parentDir = '${root.path}/zom_twin';
    appDir = '${root.path}/zom_twin/test/zom_twin_app';
    _package(
      Directory(parentDir),
      name: 'zom_twin',
      version: '0.3.0',
      lockEntries: [
        _lockEntry('tom_d4rt_ast', '0.60.0'),
        _lockEntry('tom_ast_model', '0.2.0'),
        _lockEntry('collection', '1.19.0'),
      ],
    );
  });

  tearDown(() => root.deleteSync(recursive: true));

  test('CAR-01: an app in step with this package has no mismatches '
      '[2026-09-11] (PASS)', () {
    _package(
      Directory(appDir),
      name: 'zom_twin_app',
      lockEntries: [
        _lockEntry('tom_d4rt_ast', '0.60.0'),
        _lockEntry('zom_twin', '0.3.0', source: 'path'),
      ],
    );
    expect(
      companionResolutionMismatches(parentDir: parentDir, appDir: appDir),
      isEmpty,
    );
    expect(
      companionResolutionFailure(parentDir: parentDir, appDir: appDir),
      isNull,
    );
  });

  test('CAR-02: an app on an older interpreter is named with both versions '
      '— the stale-lock state that wedged the corpus [2026-09-11] (PASS)', () {
    _package(
      Directory(appDir),
      name: 'zom_twin_app',
      lockEntries: [
        _lockEntry('tom_d4rt_ast', '0.14.0'),
        _lockEntry('zom_twin', '0.3.0', source: 'path'),
      ],
    );
    expect(
      companionResolutionMismatches(parentDir: parentDir, appDir: appDir),
      [
        'tom_d4rt_ast: the app resolves 0.14.0, this package resolves '
            '0.60.0',
      ],
    );
    final failure = companionResolutionFailure(
      parentDir: parentDir,
      appDir: appDir,
    );
    expect(failure, contains('flutter pub get'));
    expect(failure, contains('flutter pub upgrade'));
  });

  test('CAR-03: a lock recording this package at an older version means the '
      'app was not resolved since the bump [2026-09-11] (PASS)', () {
    _package(
      Directory(appDir),
      name: 'zom_twin_app',
      lockEntries: [
        _lockEntry('tom_d4rt_ast', '0.60.0'),
        _lockEntry('zom_twin', '0.2.0', source: 'path'),
      ],
    );
    expect(
      companionResolutionMismatches(
        parentDir: parentDir,
        appDir: appDir,
      ).single,
      contains('has not been resolved since the bump'),
    );
  });

  test('CAR-04: an app that was never resolved is reported '
      '[2026-09-11] (PASS)', () {
    _package(Directory(appDir), name: 'zom_twin_app', withLock: false);
    expect(
      companionResolutionMismatches(
        parentDir: parentDir,
        appDir: appDir,
      ).single,
      contains('never been resolved'),
    );
  });

  test('CAR-05: third-party packages and tom_ packages this package does '
      'not resolve are not compared [2026-09-11] (PASS)', () {
    _package(
      Directory(appDir),
      name: 'zom_twin_app',
      lockEntries: [
        _lockEntry('tom_d4rt_ast', '0.60.0'),
        _lockEntry('collection', '1.18.0'),
        _lockEntry('tom_only_in_app', '9.9.9'),
        _lockEntry('zom_twin', '0.3.0', source: 'path'),
      ],
    );
    expect(
      companionResolutionMismatches(parentDir: parentDir, appDir: appDir),
      isEmpty,
    );
  });

  test('CAR-06: the report lists every tom_ package the app resolves beside '
      'this package\'s [2026-09-11] (PASS)', () {
    _package(
      Directory(appDir),
      name: 'zom_twin_app',
      lockEntries: [
        _lockEntry('tom_d4rt_ast', '0.14.0'),
        _lockEntry('tom_only_in_app', '9.9.9'),
      ],
    );
    final report = companionResolutionReport(
      parentDir: parentDir,
      appDir: appDir,
    );
    expect(
      report,
      contains('tom_d4rt_ast 0.14.0 (hosted) — this package resolves 0.60.0'),
    );
    expect(report, contains('tom_only_in_app 9.9.9 (hosted) — not resolved'));
  });

  test('CAR-07: the tom_d4rt_flutter copy of companion_app_resolution.dart is '
      'identical to this one [2026-09-11] (PASS)', () {
    final twin = File('../tom_d4rt_flutter/test/companion_app_resolution.dart');
    if (!twin.existsSync()) {
      markTestSkipped(
        'tom_d4rt_flutter is not checked out beside this package',
      );
      return;
    }
    expect(
      twin.readAsStringSync(),
      File('test/companion_app_resolution.dart').readAsStringSync(),
      reason:
          'The two twins must run the same check. Edit it here and copy it to '
          'tom_d4rt_flutter/test/.',
    );
  });
}
