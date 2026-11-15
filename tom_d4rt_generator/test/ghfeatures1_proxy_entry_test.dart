// ghfeatures1 — generated proxies enter the script through
// `D4.enterInterpreted` (GitHub #19, per-execution hooks).
//
// A proxy's calls into its script instance are entries of interpreted code
// from native code; with hooks, every such entry passes the run's `onEntry`
// with kind `proxyMethod` and the name `Class.member`, is refused after
// `revoke()`, and runs in the run's Zone. The generator emits
// `D4.enterInterpreted(visitor, callable, [args], {named},
// D4rtEntryKind.proxyMethod, 'Class.member')` instead of
// `callable.call(visitor, [args], {named})` - and a function a proxy member
// returns enters with kind `callback` - when the project resolves an
// interpreter that has it (tom_d4rt 1.264.0 / tom_d4rt_ast 0.244.0); against
// an older one it emits the plain call, so the file always compiles. The
// runtime side is tested in tom_d4rt (ghfeatures1_execution_hooks_test.dart,
// EH-10) and tom_d4rt_ast.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// A project whose `.dart_tool/package_config.json` resolves [package] to a
/// scratch package root at [version].
Directory _projectResolving(String package, String version) {
  final root = Directory.systemTemp.createTempSync('ghf1_project_');
  final pkg = Directory(p.join(root.path, 'resolved', package))
    ..createSync(recursive: true);
  File(
    p.join(pkg.path, 'pubspec.yaml'),
  ).writeAsStringSync('name: $package\nversion: $version\n');
  Directory(p.join(root.path, '.dart_tool')).createSync();
  File(
    p.join(root.path, '.dart_tool', 'package_config.json'),
  ).writeAsStringSync(
    jsonEncode({
      'configVersion': 2,
      'packages': [
        {
          'name': package,
          'rootUri': '../resolved/$package',
          'packageUri': 'lib/',
          'languageVersion': '3.9',
        },
      ],
    }),
  );
  return root;
}

Future<(ProxyGenerationResult, String)> _generate(String projectPath) async {
  final tempDir = Directory.systemTemp.createTempSync('ghf1_out_');
  final outputFile = p.join(tempDir.path, 'proxies.b.dart');
  final result = await generateProxies(
    config: BridgeConfig(
      name: 'ghf1_entries',
      d4rtImport: 'package:tom_d4rt/d4rt.dart',
      generateProxies: true,
      proxiesOutputPath: outputFile,
      proxyClasses: const [ProxyClassConfig(className: 'FileSystemEntity')],
      modules: const [
        ModuleConfig(
          name: 'dart_io',
          barrelFiles: ['dart:io'],
          outputPath: 'unused_bridges.b.dart',
          barrelImport: 'dart:io',
        ),
      ],
    ),
    projectPath: projectPath,
  );
  final code = result.outputFile == null
      ? ''
      : (await File(
          result.outputFile!,
        ).readAsString()).replaceAll(RegExp(r'\s+'), '');
  return (result, code);
}

void main() {
  group('ghfeatures1: proxies enter the run', () {
    test('GHF1-GEN-1: tom_d4rt from 1.264.0 and tom_d4rt_ast from 0.244.0 '
        'have D4.enterInterpreted; older or other resolutions do not '
        '[2026-11-15]', () {
      bool at(String pkg, String version, String? import) => interpreterAtLeast(
        _projectResolving(pkg, version).path,
        import,
        entryInterpreterFloors,
      );
      expect(at('tom_d4rt', '1.264.0', 'package:tom_d4rt/d4rt.dart'), isTrue);
      expect(at('tom_d4rt', '1.263.0', null), isFalse);
      expect(
        at('tom_d4rt_ast', '0.244.0', 'package:tom_d4rt_ast/runtime.dart'),
        isTrue,
      );
      expect(
        at('tom_d4rt_ast', '0.243.0', 'package:tom_d4rt_ast/runtime.dart'),
        isFalse,
      );
      expect(
        at('tom_d4rt_exec', '9.0.0', 'package:tom_d4rt_exec/d4rt.dart'),
        isFalse,
      );
    });

    test('GHF1-GEN-2: with such an interpreter every call into the script '
        'is a proxyMethod entry named Class.member [2026-11-15]', () async {
      final (result, code) = await _generate(
        _projectResolving('tom_d4rt', '1.264.0').path,
      );
      expect(result.errors, isEmpty);
      expect(result.proxies.single.usesEntries, isTrue);
      expect(
        code,
        contains(
          'D4.enterInterpreted(visitor,method.bind(instance),[],{},'
          "D4rtEntryKind.proxyMethod,'FileSystemEntity.exists',)",
        ),
      );
      expect(
        code,
        contains(
          'D4.enterInterpreted(visitor,getter.bind(instance),[],{},'
          "D4rtEntryKind.proxyMethod,'FileSystemEntity.path',)",
        ),
      );
      expect(code, isNot(contains('.bind(instance).call(visitor,')));
    });

    test('GHF1-GEN-3: against an older interpreter the proxy calls the '
        'script as before [2026-11-15]', () async {
      final (result, code) = await _generate(
        _projectResolving('tom_d4rt', '1.263.0').path,
      );
      expect(result.errors, isEmpty);
      expect(result.proxies.single.usesEntries, isFalse);
      expect(code, contains('method.bind(instance).call(visitor,[],{})'));
      expect(code, isNot(contains('D4.enterInterpreted')));
    });
  });
}
