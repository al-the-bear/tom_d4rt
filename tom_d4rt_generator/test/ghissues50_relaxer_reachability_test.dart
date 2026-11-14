// ghissues50 — GitHub #16: a class a public barrel exports from `src/` gets
// its relaxer, whatever form its source file takes.
//
// Reported on Flutter 3.50 / Dart 3.14 (tom_analyzer_shared 0.13.1):
// regenerating tom_d4rt_flutter_ast emitted an empty flutter_relaxers.b.dart;
// the generator logged that Tween is not re-exported by any barrel (GEN-095
// stubs). `_isReachableViaBarrels` rejected every class whose `sourceFile` is
// `package:<pkg>/src/...`, judged by the path alone - but `package:flutter/
// animation.dart` exports Tween from `src/`. Measured on our Flutter 3.47.9
// setup: every parsed ClassInfo's `sourceFile` is an absolute filesystem path
// (`.../flutter/packages/flutter/lib/src/animation/tween.dart`), which the
// `package:` test never matches and the GEN-094 path mapping puts in scope -
// so the rule only fires where a source file arrives as a `package:` URI, as
// on the reporter's setup. A class a module BRIDGED is exported by its barrel
// (show / hide / skipReExports applied), and the relaxer file imports every
// barrel, so it is now reachable whatever its source file looks like; a
// `src/` class nobody bridged stays out.

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  const barrel = 'package:fake_pkg/fake_pkg.dart';
  late Directory tempDir;

  setUp(() => tempDir = Directory.systemTemp.createTempSync('ghissues50_'));
  tearDown(() => tempDir.deleteSync(recursive: true));

  /// `Box<T>` and `Apple`, both declared in `src/` and exported by the
  /// barrel, and `Hidden`, declared in `src/` and exported by nothing.
  Map<String, ClassInfo> lookup() => {
    'Box': ClassInfo(
      name: 'Box',
      sourceFile: 'package:fake_pkg/src/box.dart',
      typeParameters: const {'T': null},
      constructors: const [
        ConstructorInfo(
          parameters: [ParameterInfo(name: 'value', type: 'T')],
        ),
      ],
    ),
    'Apple': ClassInfo(
      name: 'Apple',
      sourceFile: 'package:fake_pkg/src/apple.dart',
    ),
    'Hidden': ClassInfo(
      name: 'Hidden',
      sourceFile: 'package:fake_pkg/src/hidden.dart',
    ),
  };

  BridgeConfig config() => BridgeConfig(
    name: 'fake_pkg',
    modules: const [
      ModuleConfig(
        name: 'fake',
        barrelFiles: ['lib/fake_pkg.dart'],
        outputPath: 'lib/src/fake.b.dart',
        barrelImport: barrel,
      ),
    ],
    relaxerOutputPath: '${tempDir.path}/relaxers.b.dart',
  );

  Future<String> generate({Set<String>? bridged}) async {
    final result = await generateRelaxers(
      config: config(),
      projectPath: tempDir.path,
      globalClassLookup: lookup(),
      genericExtractionSites: const [
        GenericExtractionSite(
          baseTypeName: 'Box',
          typeArg: 'Apple',
          moduleName: 'fake',
        ),
      ],
      bridgedClassNames: bridged,
    );
    return File(result.outputFile!).readAsStringSync();
  }

  group(
    'ghissues50: relaxer reachability of src/ classes a barrel exports',
    () {
      test('GHI50-1: a bridged generic class from src/ with a package: source '
          'file gets its relaxer, and a bridged src/ class is a type argument '
          '(GitHub #16) [2026-11-14]', () async {
        final code = await generate(bridged: {'Box', 'Apple'});
        expect(code, contains(r'class $RelaxedBox<'));
        expect(code, contains("'Apple' =>"));
      });

      test('GHI50-2: a src/ class no module bridged stays unreachable '
          '[2026-11-14]', () async {
        final code = await generate(bridged: {'Box', 'Apple'});
        expect(code, isNot(contains('Hidden')));
      });

      test('GHI50-3: without the bridged-class set (callers that do not pass '
          'it), the path rule decides as before [2026-11-14]', () async {
        final code = await generate();
        expect(code, isNot(contains(r'class $RelaxedBox<')));
      });
    },
  );
}
