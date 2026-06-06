/// MCI#4 / A6 premise-lock-in tests.
///
/// A6 in `manual_code_interventions.md` proposed automating the hand-written
/// `D4.registerSupplementaryMethod(...)` adapters for `@protected` /
/// `@visibleForTesting` members, on the stated premise that "the generator
/// currently skips" those members. That premise is **stale**: the generator
/// emits `@protected` / `@visibleForTesting` members into the bridge `methods`
/// / `getters` maps directly, and the runtime dispatch
/// (`runtime_types.dart` — `findInstanceMethodAdapter` /
/// `findInstanceGetterAdapter`) consults the generated bridge adapter BEFORE
/// the supplementary registry. So an interpreted subclass reaches the member
/// through the normal generated path with no hand-written supplementary adapter.
///
/// These tests pin that behaviour. If a future change re-introduces a
/// `@protected` skip in the generator, the green corpus would silently lose
/// these members from subclassable bridges — these tests fail first instead.
///
/// See `fixtures/protected_members_source.dart` for the class under test.
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  late String testFixturesDir;
  late String tempOutputDir;
  late String generatedCode;

  setUpAll(() async {
    testFixturesDir =
        p.join(Directory.current.path, 'test', 'generator_tests', 'fixtures');
    tempOutputDir =
        Directory.systemTemp.createTempSync('protected_members_test_').path;

    final generator = BridgeGenerator(
      workspacePath: testFixturesDir,
      skipPrivate: true,
      helpersImport: 'package:tom_d4rt_exec/tom_d4rt.dart',
      sourceImport: 'protected_members_source.dart',
      packageName: 'test_package',
      verbose: false,
    );

    final sourceFile = p.join(testFixturesDir, 'protected_members_source.dart');
    final outputFile = p.join(tempOutputDir, 'protected_members_bridges.dart');

    final result = await generator.generateBridges(
      sourceFiles: [sourceFile],
      outputPath: outputFile,
      moduleName: 'test',
    );

    expect(result.errors, isEmpty, reason: 'Should generate without errors');
    expect(result.outputFiles, isNotEmpty);

    generatedCode = await File(result.outputFiles.first).readAsString();
  });

  tearDownAll(() {
    try {
      Directory(tempOutputDir).deleteSync(recursive: true);
    } catch (_) {}
  });

  group('Generator @protected emission policy (MCI#4 / A6 lock-in)', () {
    test('GEN-A6-1: the public member is emitted', () {
      expect(generatedCode, contains("'addObserver'"));
    });

    test('GEN-A6-2: a @protected method is emitted (not skipped)', () {
      // The premise of A6 was that this is dropped. It is not — assert it is
      // present as a bridged method so interpreted subclasses can dispatch to
      // it via the generated adapter.
      expect(
        generatedCode,
        contains("'notify'"),
        reason:
            'Generator must emit @protected methods; a skip here would break '
            'interpreted subclasses calling super.notify().',
      );
    });

    test('GEN-A6-3: a @protected getter is emitted (not skipped)', () {
      expect(generatedCode, contains("'isDirty'"));
    });

    test('GEN-A6-4: a @visibleForTesting method is emitted (not skipped)', () {
      expect(generatedCode, contains("'resetForTest'"));
    });
  });
}
