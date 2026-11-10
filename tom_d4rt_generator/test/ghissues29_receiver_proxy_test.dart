// ghissues29 — generated proxies become receivers: a script class extending
// an abstract bridged class gets its proxy as its native object, so the
// members it inherits run natively instead of answering null.
//
// Measured 2026-11-10 in the Flutter AST twin (published tom_d4rt_ast
// 0.212.1): on script subclasses of Decoration, FlowDelegate,
// MultiChildLayoutDelegate and CustomPainter, `padding`, `isComplex`,
// `getSize(constraints)` and `shouldRebuildSemantics(old)` all answered null
// (Dart: EdgeInsets.zero, false, the constraints' biggest size, false). The
// generator now marks every generated proxy with `D4.markProxyIsReceiver`
// (tom_d4rt 1.251.0 / tom_d4rt_ast 0.231.0) unless `receiverProxies: false`
// or the class is in `receiverProxyExclude`, and guards its overridable
// members: a forward in progress is not forwarded again, and a script
// override's `super.m()` - dispatched to the proxy, which would forward to the
// override again - runs natively through `D4ReceiverProxy.d4rtSuperCall`. It
// emits receivers only when the project resolves an interpreter that has the
// mark and the interface.

import 'dart:convert';
import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

/// A project whose `.dart_tool/package_config.json` resolves [package] to a
/// scratch package root at [version].
Directory _projectResolving(String package, String version) {
  final root = Directory.systemTemp.createTempSync('ghi29_project_');
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

Future<(ProxyGenerationResult, String)> _generate({
  required String projectPath,
  bool receiverProxies = true,
  List<String> exclude = const [],
}) async {
  final tempDir = Directory.systemTemp.createTempSync('ghi29_out_');
  final outputFile = p.join(tempDir.path, 'proxies.b.dart');
  final result = await generateProxies(
    config: BridgeConfig(
      name: 'ghi29_receivers',
      d4rtImport: 'package:tom_d4rt/d4rt.dart',
      generateProxies: true,
      proxiesOutputPath: outputFile,
      receiverProxies: receiverProxies,
      receiverProxyExclude: exclude,
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
  group('ghissues29: the interpreter a project resolves decides', () {
    test('GHI29-1: tom_d4rt from 1.251.0 and tom_d4rt_ast from 0.231.0 have '
        'receivers; older, other or unreadable resolutions do not '
        '[2026-11-10]', () {
      bool supports(String pkg, String version, String? import) =>
          interpreterSupportsReceivers(
            _projectResolving(pkg, version).path,
            import,
          );
      expect(
        supports('tom_d4rt', '1.251.0', 'package:tom_d4rt/d4rt.dart'),
        isTrue,
      );
      expect(
        supports('tom_d4rt', '1.251.3', null),
        isTrue,
        reason: 'no d4rtImport means tom_d4rt',
      );
      expect(
        supports('tom_d4rt', '1.250.0', 'package:tom_d4rt/d4rt.dart'),
        isFalse,
      );
      expect(
        supports('tom_d4rt_ast', '0.231.0', 'package:tom_d4rt_ast/d4rt.dart'),
        isTrue,
      );
      expect(
        supports('tom_d4rt_ast', '0.230.0', 'package:tom_d4rt_ast/d4rt.dart'),
        isFalse,
      );
      expect(
        supports('tom_d4rt_exec', '9.0.0', 'package:tom_d4rt_exec/d4rt.dart'),
        isFalse,
      );
      expect(
        interpreterSupportsReceivers(
          Directory.systemTemp.createTempSync('ghi29_bare_').path,
          'package:tom_d4rt/d4rt.dart',
        ),
        isFalse,
        reason: 'no package_config.json',
      );
    });

    test('GHI29-2: the config defaults to receivers and can exclude a class '
        'or turn them off [2026-11-10]', () {
      const on = BridgeConfig(
        name: 'a',
        modules: [],
        receiverProxyExclude: ['RouterDelegate'],
      );
      expect(on.isReceiverProxy('CustomPainter'), isTrue);
      expect(on.isReceiverProxy('RouterDelegate'), isFalse);
      expect(
        const BridgeConfig(
          name: 'b',
          modules: [],
          receiverProxies: false,
        ).isReceiverProxy('CustomPainter'),
        isFalse,
      );
      final parsed = BridgeConfig.fromJson({
        'name': 'c',
        'modules': [],
        'receiverProxies': false,
        'receiverProxyExclude': ['Decoration'],
      });
      expect(parsed.receiverProxies, isFalse);
      expect(parsed.receiverProxyExclude, ['Decoration']);
      expect(parsed.toJson()['receiverProxyExclude'], ['Decoration']);
      expect(
        BridgeConfig.fromJson({'name': 'd', 'modules': []}).receiverProxies,
        isTrue,
      );
    });
  });

  group('ghissues29: emitted receivers', () {
    test('GHI29-3: with a receiver-capable interpreter the proxy is marked and '
        'its overridable members are guarded [2026-11-10]', () async {
      final (result, code) = await _generate(
        projectPath: _projectResolving('tom_d4rt', '1.251.0').path,
      );
      expect(result.errors, isEmpty);
      expect(result.proxies.single.isReceiver, isTrue);
      expect(code, contains("D4.markProxyIsReceiver('FileSystemEntity');"));
      expect(
        code,
        contains(
          'classD4rtFileSystemEntityextendsFileSystemEntityimplementsD4ReceiverProxy{',
        ),
      );
      expect(
        code,
        contains('Rd4rtSuperCall<R>(Stringmember,RFunction()call){'),
      );
      // `stat` is overridable: forwarded unless absent or re-entered; one
      // final field holds the members forwarding (the base may be @immutable).
      expect(code, contains('finalSet<String>_d4rtForwarding=<String>{};'));
      expect(
        code,
        contains(
          "if(d4rtForward==null||_d4rtForwarding.contains('stat')){"
          'returnsuper.stat();}',
        ),
      );
      expect(code, contains("_d4rtForwarding.contains('getparent')"));
      // `exists` is abstract: forwarded unconditionally, as before.
      expect(code, contains('Future<bool>exists()=>onExists();'));
      expect(result.warnings, isEmpty);
    });

    test('GHI29-4: an excluded class, receivers turned off, and an older '
        'interpreter emit the proxy as before [2026-11-10]', () async {
      for (final (label, run) in [
        (
          'excluded',
          () => _generate(
            projectPath: _projectResolving('tom_d4rt', '1.251.0').path,
            exclude: const ['FileSystemEntity'],
          ),
        ),
        (
          'off',
          () => _generate(
            projectPath: _projectResolving('tom_d4rt', '1.251.0').path,
            receiverProxies: false,
          ),
        ),
        (
          'older interpreter',
          () => _generate(
            projectPath: _projectResolving('tom_d4rt', '1.250.0').path,
          ),
        ),
      ]) {
        final (result, code) = await run();
        expect(result.proxies.single.isReceiver, isFalse, reason: label);
        expect(code, isNot(contains('markProxyIsReceiver')), reason: label);
        expect(code, isNot(contains('_d4rtForwarding')), reason: label);
        expect(code, isNot(contains('D4ReceiverProxy')), reason: label);
        expect(
          code,
          contains('onStat!=null?onStat!():super.stat()'),
          reason: label,
        );
        expect(
          result.warnings.any((w) => w.contains('receiverProxies')),
          label == 'older interpreter',
          reason: '$label: only a requested-but-unsupported receiver warns',
        );
      }
    });
  });
}
