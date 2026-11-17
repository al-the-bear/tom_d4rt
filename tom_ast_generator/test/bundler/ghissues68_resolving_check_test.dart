// ghissues68 — the resolving check (GitHub al-the-bear/tom_d4rt#18, option 3
// / B2, part 1).
//
// `AstBundlerConfig(resolve: true)` resolves the bundle's modules with the
// analyzer before the bundle is returned and throws `AstResolveException` on
// an analyzer error, so a program Dart rejects is not bundled. Plain bundling
// stays parse-only. The modules can come from `explicitSources` (no project,
// file reads disabled - the reporter's setup) or from a project's
// `package_config.json`; `declarationStubs` declare libraries that exist only
// at run time, for the resolver alone; an import of a runtime-only
// (bridged) library with neither source nor stub is filtered and counted.
// The Dart SDK is found without a flag: `DART_SDK`, the `dart` or `flutter`
// on PATH, the running VM.

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart';
import 'package:tom_d4rt_ast/runtime.dart' show AstBundle;

const _resolve = AstBundlerConfig(resolve: true);

/// GitHub #18's repro: a typed local from a host function registered only at
/// run time.
const _repro = '''
import 'package:map_repro/native.dart';

extension KeyKind<K, V> on Map<K, V> {
  String keyKind() => K.toString();
}

Object main() {
  final Map<String, int> narrow = sameMap();
  return narrow.keyKind();
}
''';

const _nativeStub = '''
Map<String, int> sameMap() => throw UnimplementedError();
''';

Future<AstBundle> _bundle(
  AstBundler bundler,
  Map<String, String> sources, {
  String entry = 'package:p/main.dart',
}) => bundler.createFromSource(sources[entry]!, sourcePath: entry);

void main() {
  // One resolver for the suite: the SDK is looked up once.
  final resolver = AstResolver();

  group('ghissues68: the resolving check from explicitSources', () {
    test(
      'GH68-1: a valid program passes and is bundled [2026-11-17]',
      () async {
        final sources = {
          'package:p/main.dart':
              "import 'helper.dart'; void main() => print(twice(2));",
          'package:p/helper.dart': 'int twice(int x) => x * 2;',
        };
        final bundler = AstBundler(
          explicitSources: sources,
          fileAccessValidator: (_) => false,
          config: _resolve,
          resolver: resolver,
        );
        final bundle = await _bundle(bundler, sources);
        expect(bundle.modules.keys, hasLength(2));
        final report = bundler.lastResolveReport!;
        expect(report.passed, isTrue);
        expect(report.modulesChecked, 2);
        expect(report.filteredCount, 0);
      },
    );

    test('GH68-2: an unimported name fails with its file, line and code, and '
        'no bundle [2026-11-17]', () async {
      final sources = {
        'package:p/main.dart': 'void main() {\n  print(twice(2));\n}',
      };
      final bundler = AstBundler(
        explicitSources: sources,
        fileAccessValidator: (_) => false,
        config: _resolve,
        resolver: resolver,
      );
      await expectLater(
        _bundle(bundler, sources),
        throwsA(
          isA<AstResolveException>().having(
            (e) => e.report.errors.single,
            'error',
            isA<ResolveDiagnostic>()
                .having((d) => d.uri, 'uri', 'package:p/main.dart')
                .having((d) => d.line, 'line', 2)
                .having((d) => d.code, 'code', startsWith('undefined_'))
                .having((d) => d.message, 'message', contains('twice')),
          ),
        ),
      );
      expect(bundler.lastResolveReport!.passed, isFalse);
    });

    test('GH68-3: a type error Dart reports fails too [2026-11-17]', () async {
      final sources = {
        'package:p/main.dart': "void main() { int x = 'text'; print(x); }",
      };
      await expectLater(
        _bundle(
          AstBundler(
            explicitSources: sources,
            config: _resolve,
            resolver: resolver,
          ),
          sources,
        ),
        throwsA(
          isA<AstResolveException>().having(
            (e) => e.report.errors.single.code,
            'code',
            'invalid_assignment',
          ),
        ),
      );
    });

    test('GH68-4: a runtime-only import without source or stub is filtered '
        'and counted [2026-11-17]', () async {
      final sources = {'package:map_repro/entry.dart': _repro};
      final bundler = AstBundler(
        bridgedLibraries: {'package:map_repro/native.dart'},
        explicitSources: sources,
        fileAccessValidator: (_) => false,
        config: _resolve,
        resolver: resolver,
      );
      await _bundle(bundler, sources, entry: 'package:map_repro/entry.dart');
      final report = bundler.lastResolveReport!;
      expect(report.passed, isTrue);
      // The import, and the name it would supply.
      expect(report.filteredCount, 2);
      expect(
        report.filtered.map((d) => d.code),
        containsAll(['uri_does_not_exist']),
      );
    });

    test('GH68-5: with a stub the runtime-only library resolves, is checked '
        'against, and is not bundled [2026-11-17]', () async {
      final sources = {'package:map_repro/entry.dart': _repro};
      final bundler = AstBundler(
        bridgedLibraries: {'package:map_repro/native.dart'},
        explicitSources: sources,
        declarationStubs: {'package:map_repro/native.dart': _nativeStub},
        fileAccessValidator: (_) => false,
        config: _resolve,
        resolver: resolver,
      );
      final bundle = await _bundle(
        bundler,
        sources,
        entry: 'package:map_repro/entry.dart',
      );
      expect(bundle.modules.keys, ['package:map_repro/entry.dart']);
      expect(bundler.lastResolveReport!.passed, isTrue);
      expect(bundler.lastResolveReport!.filteredCount, 0);

      // The stub's signature is checked against: a String is not a map.
      final wrong = {
        'package:map_repro/entry.dart':
            "import 'package:map_repro/native.dart';\n"
            'void main() { String s = sameMap(); print(s); }',
      };
      await expectLater(
        _bundle(
          AstBundler(
            bridgedLibraries: {'package:map_repro/native.dart'},
            explicitSources: wrong,
            declarationStubs: {'package:map_repro/native.dart': _nativeStub},
            config: _resolve,
            resolver: resolver,
          ),
          wrong,
          entry: 'package:map_repro/entry.dart',
        ),
        throwsA(isA<AstResolveException>()),
      );
    });

    test('GH68-6: an error a filtered import does not explain is still '
        'reported [2026-11-17]', () async {
      final sources = {
        'package:map_repro/entry.dart':
            "import 'package:map_repro/native.dart';\n"
            "void main() { int x = 'text'; print(x); }",
      };
      await expectLater(
        _bundle(
          AstBundler(
            bridgedLibraries: {'package:map_repro/native.dart'},
            explicitSources: sources,
            config: _resolve,
            resolver: resolver,
          ),
          sources,
          entry: 'package:map_repro/entry.dart',
        ),
        throwsA(
          isA<AstResolveException>()
              .having((e) => e.report.errors.map((d) => d.code), 'codes', [
                'invalid_assignment',
              ])
              .having((e) => e.report.filteredCount, 'filtered', 1),
        ),
      );
    });

    test('GH68-7: off by default - a parse-only bundle of the same program, '
        'no report [2026-11-17]', () async {
      final sources = {'package:p/main.dart': 'void main() => print(twice);'};
      final bundler = AstBundler(explicitSources: sources);
      final bundle = await _bundle(bundler, sources);
      expect(bundle.modules, hasLength(1));
      expect(bundler.lastResolveReport, isNull);
    });
  });

  group('ghissues68: the resolving check in a project', () {
    late Directory project;

    setUp(() {
      project = Directory.systemTemp.createTempSync('gh68_project_');
      File(
        p.join(project.path, 'pubspec.yaml'),
      ).writeAsStringSync('name: gh68proj\nenvironment:\n  sdk: ^3.10.0\n');
      File(p.join(project.path, '.dart_tool', 'package_config.json'))
        ..createSync(recursive: true)
        ..writeAsStringSync('''
{
  "configVersion": 2,
  "packages": [
    {"name": "gh68proj", "rootUri": "../", "packageUri": "lib/", "languageVersion": "3.10"}
  ]
}
''');
      File(p.join(project.path, 'lib', 'helper.dart'))
        ..createSync(recursive: true)
        ..writeAsStringSync('int twice(int x) => x * 2;\n');
    });

    tearDown(() => project.deleteSync(recursive: true));

    test('GH68-8: createFromFile resolves the project\'s own imports, and '
        'fails on an error [2026-11-17]', () async {
      final good = File(p.join(project.path, 'bin', 'good.dart'))
        ..createSync(recursive: true)
        ..writeAsStringSync(
          "import 'package:gh68proj/helper.dart';\n"
          'void main() => print(twice(2));\n',
        );
      final bundler = AstBundler(
        packageName: 'gh68proj',
        projectRoot: project.path,
        config: _resolve,
        resolver: resolver,
      );
      final bundle = await bundler.createFromFile(good.path);
      expect(bundle.modules, hasLength(2));
      expect(bundler.lastResolveReport!.passed, isTrue);
      expect(bundler.lastResolveReport!.modulesChecked, 2);

      final bad = File(p.join(project.path, 'bin', 'bad.dart'))
        ..writeAsStringSync(
          "import 'package:gh68proj/helper.dart';\n"
          'void main() => print(thrice(2));\n',
        );
      await expectLater(
        bundler.createFromFile(bad.path),
        throwsA(
          isA<AstResolveException>().having(
            (e) => e.report.errors.single.line,
            'line',
            2,
          ),
        ),
      );
    });

    test('GH68-9: checkFiles shares one context over many files, with stubs '
        'for a package the project does not have [2026-11-17]', () async {
      final files = [
        for (var i = 0; i < 3; i++)
          File(p.join(project.path, 'bin', 's$i.dart'))
            ..createSync(recursive: true)
            ..writeAsStringSync(
              "import 'package:hostlib/native.dart';\n"
              'void main() { final Map<String, int> m = sameMap(); print(m); }\n',
            ),
      ];
      final shared = AstResolver();
      try {
        final report = await shared.checkFiles(
          [for (final f in files) f.path],
          projectRoot: project.path,
          stubs: {'package:hostlib/native.dart': _nativeStub},
        );
        expect(report.modulesChecked, 3);
        expect(report.passed, isTrue, reason: '${report.errors}');
      } finally {
        await shared.dispose();
      }
    });
  });

  group('ghissues68: finding the Dart SDK', () {
    late Directory tmp;

    // By its resolved path: on macOS the temp folder is behind a link
    // (/var -> /private/var), which the lookup resolves.
    setUp(
      () => tmp = Directory(
        Directory.systemTemp
            .createTempSync('gh68_sdk_')
            .resolveSymbolicLinksSync(),
      ),
    );
    tearDown(() => tmp.deleteSync(recursive: true));

    /// A fake SDK at [path]: `version` and `lib/_internal`.
    void fakeSdk(String path) {
      File(p.join(path, 'version'))
        ..createSync(recursive: true)
        ..writeAsStringSync('3.13.7\n');
      Directory(p.join(path, 'lib', '_internal')).createSync(recursive: true);
    }

    void fakeExecutable(String path) {
      File(path)
        ..createSync(recursive: true)
        ..writeAsStringSync('#!/bin/sh\n');
    }

    String find(Map<String, String> environment) => findDartSdk(
      environment: environment,
      isWindows: false,
      resolvedExecutable: p.join(tmp.path, 'aot', 'astgen'),
    );

    test('GH68-10: the dart on PATH - <sdk>/bin/dart [2026-11-17]', () {
      final sdk = p.join(tmp.path, 'dart-sdk');
      fakeSdk(sdk);
      fakeExecutable(p.join(sdk, 'bin', 'dart'));
      expect(
        find({'PATH': '${p.join(tmp.path, 'nothing')}:${p.join(sdk, 'bin')}'}),
        sdk,
      );
    });

    test('GH68-11: the flutter on PATH - <flutter>/bin/cache/dart-sdk, with '
        'and without Flutter\'s own dart wrapper [2026-11-17]', () {
      final flutterBin = p.join(tmp.path, 'flutter', 'bin');
      final sdk = p.join(flutterBin, 'cache', 'dart-sdk');
      fakeSdk(sdk);
      fakeExecutable(p.join(flutterBin, 'flutter'));
      expect(find({'PATH': flutterBin}), sdk);
      fakeExecutable(p.join(flutterBin, 'dart'));
      expect(find({'PATH': flutterBin}), sdk);
    });

    test('GH68-12: DART_SDK and an explicit path win; Windows PATH and '
        'extensions [2026-11-17]', () {
      final pathSdk = p.join(tmp.path, 'path-sdk');
      fakeSdk(pathSdk);
      fakeExecutable(p.join(pathSdk, 'bin', 'dart'));
      final envSdk = p.join(tmp.path, 'env-sdk');
      fakeSdk(envSdk);
      final explicitSdk = p.join(tmp.path, 'explicit-sdk');
      fakeSdk(explicitSdk);
      final env = {'PATH': p.join(pathSdk, 'bin'), 'DART_SDK': envSdk};
      expect(find(env), envSdk);
      expect(
        findDartSdk(
          explicitPath: explicitSdk,
          environment: env,
          isWindows: false,
        ),
        explicitSdk,
      );

      final winSdk = p.join(tmp.path, 'win-sdk');
      fakeSdk(winSdk);
      fakeExecutable(p.join(winSdk, 'bin', 'dart.exe'));
      expect(
        findDartSdk(
          environment: {
            'Path': '${p.join(tmp.path, 'x')};${p.join(winSdk, 'bin')}',
          },
          isWindows: true,
          resolvedExecutable: p.join(tmp.path, 'aot', 'astgen.exe'),
        ),
        winSdk,
      );
    });

    test('GH68-13: nothing found - the error names every place searched '
        '[2026-11-17]', () {
      expect(
        () => find({'PATH': p.join(tmp.path, 'empty')}),
        throwsA(
          isA<DartSdkNotFoundException>()
              .having((e) => e.searched, 'searched', hasLength(4))
              .having(
                (e) => '$e',
                'message',
                allOf(
                  contains('DART_SDK: not set'),
                  contains('dart on PATH: not found'),
                  contains('flutter on PATH: not found'),
                  contains('running executable'),
                ),
              ),
        ),
      );
    });
  });
}
