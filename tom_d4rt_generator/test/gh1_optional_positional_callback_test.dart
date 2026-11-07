// GitHub al-the-bear/tom_d4rt#1, the "secondary" finding: a callback whose
// typedef has an optional positional parameter.
//
//     typedef ParamsEncoder =
//         String Function(Map<String, dynamic> params, [dynamic args]);
//
// The generator wrapped a script closure passed for it as
// `(Map<String, dynamic> p0, dynamic p1) {...}`, cast to
// `String Function(Map<String, dynamic>, dynamic)`: both parameters required.
// That type is not a `ParamsEncoder`, so the emitted bridge did not compile,
// and the issue's author needed a user bridge. Measured 2026-11-07 on 1.55.0:
// still so. `FunctionTypeInfo` never recorded which positional parameters are
// optional, in either of the two places it is built.
//
// Now the closure declares `[dynamic p1]`, the cast keeps the brackets, and the
// closure leaves an omitted trailing argument out of the script call, so a
// one-parameter script closure works where the native code calls with one.
//
// The end-to-end half synthesises a package, generates its bridges with
// `bridge_api.generateBridges`, analyses them (GEN-121's helpers) and runs a
// script against them in a subprocess.
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_api.dart' as api;
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/verification/generated_output_analysis.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart'
    show FunctionTypeInfo;

import 'synthesised_package.dart';

const _package = 'zom_gh1cb';

const _library = '''
typedef ParamsEncoder = String Function(Map<String, dynamic> params, [dynamic args]);

/// Calls the encoder once without and once with the optional argument.
String encodeWith(ParamsEncoder encoder) =>
    '\${encoder({'a': 1})}|\${encoder({'b': 2}, 'x')}';

class UrlBuilder {
  UrlBuilder(this.encoder);

  final ParamsEncoder encoder;

  /// Calls the encoder without the optional argument only.
  String build() => encoder({'k': 'v'});
}
''';

/// A script for [_runner]: the issue's use, plus a one-parameter closure.
const _script = r'''
import 'package:zom_gh1cb/zom_gh1cb.dart';

main() {
  final both = encodeWith((params, [args]) => '${params.keys.first}:$args');
  final one = UrlBuilder((params) => 'k=${params['k']}').build();
  return '$both;$one';
}
''';

const _runner =
    '''
import 'package:tom_d4rt/d4rt.dart';
import 'package:$_package/src/bridges/all_bridges.b.dart';

void main(List<String> args) {
  final d4rt = D4rt();
  AllBridge.registerBridges(d4rt, 'package:$_package/$_package.dart');
  print('RESULT=\${d4rt.execute(source: args.single, name: 'main')}');
}
''';

void main() {
  group('gh1 secondary: optional positional callback parameters', () {
    const info = FunctionTypeInfo(
      returnType: 'String',
      positionalParamTypes: ['Map<String, dynamic>', 'dynamic', 'int'],
      optionalPositionalCount: 2,
    );

    test('GH1S-1: the closure declares the optional parameters nullable in '
        'brackets [2026-11-07]', () {
      expect(
        info.positionalParameterList(info.positionalParamTypes),
        'Map<String, dynamic> p0, [dynamic p1, int? p2]',
      );
    });

    test('GH1S-2: the call leaves out only trailing omitted arguments '
        '[2026-11-07]', () {
      expect(
        info.positionalArgumentList(['p0', 'p1', 'p2']),
        '[p0, if (p1 != null || p2 != null) p1, if (p2 != null) p2]',
      );
      // Without optional parameters the list is the plain one.
      const plain = FunctionTypeInfo(
        returnType: 'void',
        positionalParamTypes: ['int', 'String'],
      );
      expect(
        plain.positionalParameterList(plain.positionalParamTypes),
        'int p0, String p1',
      );
      expect(plain.positionalArgumentList(['p0', 'p1']), '[p0, p1]');
    });

    late Directory root;
    late String code;

    setUpAll(() async {
      root = Directory.systemTemp.createTempSync('gh1cb_');
      File(p.join(root.path, 'pubspec.yaml')).writeAsStringSync(
        'name: $_package\n'
        'environment:\n'
        "  sdk: '>=3.0.0 <4.0.0'\n",
      );
      final lib = Directory(p.join(root.path, 'lib'))..createSync();
      File(p.join(lib.path, '$_package.dart')).writeAsStringSync(_library);
      writeSynthesisedPackageConfig(
        root: root,
        generatorRoot: Directory.current.path,
        packageName: _package,
      );
      final result = await api.generateBridges(
        projectPath: root.path,
        config: BridgeConfig(
          name: _package,
          helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
          d4rtImport: 'package:tom_d4rt/d4rt.dart',
          modules: [
            ModuleConfig(
              name: 'all',
              barrelFiles: ['lib/$_package.dart'],
              outputPath: 'lib/src/bridges/all_bridges.b.dart',
            ),
          ],
        ),
      );
      expect(result.errors, isEmpty);
      code = File(
        p.join(root.path, 'lib', 'src', 'bridges', 'all_bridges.b.dart'),
      ).readAsStringSync();
    });

    tearDownAll(() {
      try {
        root.deleteSync(recursive: true);
      } catch (_) {}
    });

    test('GH1S-3: the emitted wrapper declares [dynamic p1] and casts to the '
        'typedef\'s shape, for a function and a constructor [2026-11-07]', () {
      final closures = RegExp(
        r'\(Map<String, dynamic> p0, \[dynamic p1\]\)',
      ).allMatches(code);
      expect(closures, hasLength(2), reason: code);
      expect(
        code,
        contains('as String Function(Map<String, dynamic>, [dynamic])'),
      );
      expect(code, contains('[p0, if (p1 != null) p1]'));
      expect(code, isNot(contains('(Map<String, dynamic> p0, dynamic p1)')));
    });

    test(
      'GH1S-4: the generated bridge compiles [2026-11-07]',
      () async {
        final fatal = fatalDiagnostics(await analyzeDirectory(root.path));
        expect(fatal, isEmpty, reason: fatal.join('\n'));
      },
      timeout: const Timeout(Duration(minutes: 3)),
    );

    test('GH1S-5: a script passes a two-parameter closure (called with and '
        'without the optional argument) and a one-parameter closure '
        '[2026-11-07]', () async {
      final bin = Directory(p.join(root.path, 'bin'))..createSync();
      File(p.join(bin.path, 'run.dart')).writeAsStringSync(_runner);
      // Not `dart run`: it re-resolves the package, whose pubspec names no
      // dependency, and drops the borrowed tom_d4rt from the config.
      final run = await Process.run(Platform.resolvedExecutable, [
        '--packages=${p.join('.dart_tool', 'package_config.json')}',
        p.join('bin', 'run.dart'),
        _script,
      ], workingDirectory: root.path);
      expect(run.exitCode, 0, reason: '${run.stdout}\n${run.stderr}');
      expect(run.stdout as String, contains('RESULT=a:null|b:x;k=v'));
    }, timeout: const Timeout(Duration(minutes: 3)));
  });
}
