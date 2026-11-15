// ghfeatures2 — a sub-package barrel offers only what that package declares.
//
// Measured 2026-11-15 in both Flutter twins (published generator 1.65.0): a
// corpus script importing only `package:flutter/material.dart` used
// `CupertinoPageTransitionsBuilder` (declared in cupertino.dart, which
// material.dart does not export). Dart rejects it; the interpreter ran it.
// The cause is in the generated registration, not the interpreter: a module
// whose bridged declarations come from a second package (the cupertino
// module bridges `StringCharacters` from `package:characters`) lists that
// package's barrel in `subPackageBarrels()`, and the registration code then
// called `registerBridges(d4rt, barrel)` for it - registering the WHOLE
// module under `package:characters/characters.dart`. `widgets.dart`
// re-exports that library, so every cupertino class was visible through
// material.dart.
//
// The generator now emits `registerBridges(d4rt, barrel, onlyOwnPackage:
// true)` for a sub-package barrel, and `registerBridges` with
// `onlyOwnPackage` registers only the declarations whose source is in that
// barrel's package (classes, enums, functions, globals, extensions, aliases
// of its classes; function typedefs carry no source and are left out).
// GEN-030's purpose - a script may import the sub-package directly and get
// its declarations - stays.

@Tags(['generation'])
library;

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_api.dart' as api;
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/file_generators.dart';

import 'synthesised_package.dart';

const _main = 'zom_ghf2';
const _sub = 'zom_ghf2_sub';

const _mainLibrary =
    '''
export 'package:$_sub/$_sub.dart';

class MainThing {
  String get name => 'main';
}
''';

const _subLibrary = '''
class SubThing {
  String get name => 'sub';
}

String subGreeting() => 'hello from sub';

const String subConstant = 'sub constant';
''';

/// Registers the module as the generated dartscript does - the primary
/// barrel, then each sub-package barrel with `onlyOwnPackage: <flag>` - and
/// runs the script given as the first argument.
const _runner =
    '''
import 'package:tom_d4rt/d4rt.dart';
import 'package:$_main/src/bridges/all_bridges.b.dart';

void main(List<String> args) {
  final onlyOwn = args[1] == 'own';
  final d4rt = D4rt();
  AllBridge.registerBridges(d4rt, 'package:$_main/$_main.dart');
  for (final barrel in AllBridge.subPackageBarrels()) {
    AllBridge.registerBridges(d4rt, barrel, onlyOwnPackage: onlyOwn);
  }
  try {
    print('RESULT=\${d4rt.execute(source: args[0], name: 'main')}');
  } catch (e) {
    print('ERROR=\$e');
  }
}
''';

String _script(String import, String expression) =>
    "import '$import';\nmain() => $expression;";

void main() {
  group('ghfeatures2: sub-package barrels', () {
    late Directory root;
    late String code;

    setUpAll(() async {
      root = Directory.systemTemp.createTempSync('ghf2_');
      File(p.join(root.path, 'pubspec.yaml')).writeAsStringSync(
        'name: $_main\n'
        'environment:\n'
        "  sdk: '>=3.0.0 <4.0.0'\n",
      );
      final lib = Directory(p.join(root.path, 'lib'))..createSync();
      File(p.join(lib.path, '$_main.dart')).writeAsStringSync(_mainLibrary);
      final subRoot = Directory(p.join(root.path, 'sub'))..createSync();
      File(p.join(subRoot.path, 'pubspec.yaml')).writeAsStringSync(
        'name: $_sub\n'
        'environment:\n'
        "  sdk: '>=3.0.0 <4.0.0'\n",
      );
      final subLib = Directory(p.join(subRoot.path, 'lib'))..createSync();
      File(p.join(subLib.path, '$_sub.dart')).writeAsStringSync(_subLibrary);
      writeSynthesisedPackageConfig(
        root: root,
        generatorRoot: Directory.current.path,
        packageName: _main,
      );
      // The helper resolves one fixture package; add the second.
      final configFile = File(
        p.join(root.path, '.dart_tool', 'package_config.json'),
      );
      final config =
          jsonDecode(configFile.readAsStringSync()) as Map<String, dynamic>;
      (config['packages'] as List).add({
        'name': _sub,
        'rootUri': '../sub/',
        'packageUri': 'lib/',
        'languageVersion': '3.0',
      });
      configFile.writeAsStringSync(
        const JsonEncoder.withIndent('  ').convert(config),
      );

      final result = await api.generateBridges(
        projectPath: root.path,
        config: BridgeConfig(
          name: _main,
          helpersImport: 'package:tom_d4rt/tom_d4rt.dart',
          d4rtImport: 'package:tom_d4rt/d4rt.dart',
          modules: [
            ModuleConfig(
              name: 'all',
              barrelFiles: ['lib/$_main.dart'],
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

    test('GHF2-1: the sub-package is a sub-package barrel, and registration '
        'filters by source under onlyOwnPackage [2026-11-15]', () {
      expect(code, contains("'package:$_sub/$_sub.dart'"));
      expect(
        code,
        matches(
          RegExp(
            r'static void registerBridges\(\s*D4rt interpreter,\s*'
            r'String importPath,\s*\{\s*bool onlyOwnPackage = false',
          ),
        ),
      );
      for (final guard in [
        'if (!include(classSources[entry.key])) continue;',
        'if (!include(funcSources[entry.key])) continue;',
        'registerGlobalVariables(interpreter, importPath, include: include);',
      ]) {
        expect(code, contains(guard));
      }
    });

    test('GHF2-2: the generated dartscript registers sub-package barrels '
        'with onlyOwnPackage [2026-11-15]', () {
      final content = generateDartscriptFileContent(
        BridgeConfig(
          name: _main,
          modules: [
            ModuleConfig(
              name: 'all',
              barrelFiles: ['lib/$_main.dart'],
              outputPath: 'lib/src/bridges/all_bridges.b.dart',
            ),
          ],
        ),
        dartscriptPath: 'lib/dartscript.b.dart',
        packageName: _main,
      );
      expect(
        content,
        contains(
          'all_bridges.AllBridge.registerBridges(d4rt, barrel, '
          'onlyOwnPackage: true);',
        ),
      );
    });

    Future<String> run(String script, {required bool onlyOwn}) async {
      final bin = Directory(p.join(root.path, 'bin'))
        ..createSync(recursive: true);
      File(p.join(bin.path, 'run.dart')).writeAsStringSync(_runner);
      final result = await Process.run(Platform.resolvedExecutable, [
        '--packages=${p.join('.dart_tool', 'package_config.json')}',
        p.join('bin', 'run.dart'),
        script,
        onlyOwn ? 'own' : 'all',
      ], workingDirectory: root.path);
      expect(result.exitCode, 0, reason: '${result.stdout}\n${result.stderr}');
      return (result.stdout as String).trim().split('\n').last;
    }

    const subBarrel = 'package:$_sub/$_sub.dart';

    test(
      'GHF2-3: through the sub-package barrel a script gets what the '
      'sub-package declares - a class, a function, a constant [2026-11-15]',
      () async {
        expect(
          await run(
            _script(
              subBarrel,
              "[SubThing().name, subGreeting(), subConstant].join(',')",
            ),
            onlyOwn: true,
          ),
          'RESULT=sub,hello from sub,sub constant',
        );
      },
      timeout: const Timeout(Duration(minutes: 3)),
    );

    test(
      'GHF2-4: the module\'s own class is undefined through the sub-package '
      'barrel, as in Dart; without onlyOwnPackage it leaked [2026-11-15]',
      () async {
        final script = _script(subBarrel, 'MainThing().name');
        final refused = await run(script, onlyOwn: true);
        expect(refused, startsWith('ERROR='));
        expect(refused, contains('MainThing'));
        // The registration before the fix, kept as the control.
        expect(await run(script, onlyOwn: false), 'RESULT=main');
        // Through the module's own barrel it is there.
        expect(
          await run(
            _script('package:$_main/$_main.dart', 'MainThing().name'),
            onlyOwn: true,
          ),
          'RESULT=main',
        );
      },
      timeout: const Timeout(Duration(minutes: 3)),
    );
  });
}
