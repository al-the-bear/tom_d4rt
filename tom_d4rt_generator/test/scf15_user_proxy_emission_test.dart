// SCF15: `@D4rtUserProxy` directives now reach the proxy emitter.
//
// SCE47 wired the directive scan up, but only the RELAXER half had somewhere
// to go: `generateProxies` was keyed by class name and had no notion of a
// concrete instantiation, so a proxy directive produced a warning and nothing
// else. Now `ProxyClassConfig.instantiations` carries the tuples a directive
// expands to, the emitter writes one `typedef D4rt<Base><Args>` alias per tuple
// plus a factory arm selected by the script's reified `extends Base<...>`
// arguments, and `bridge_api` folds the directives in — even for a package
// that never asked for proxies in its config, because the directive IS the
// request.
//
// The end-to-end half runs `bridge_api.generateBridges` over a synthesised
// package and analyses the result, as GEN-121 does; the anti-vacuity twin is
// the same package without the directive file, which must emit no proxy file.
@Tags(['generation'])
library;

import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/src/bridge_api.dart' as api;
import 'package:tom_d4rt_generator/src/bridge_config.dart';
import 'package:tom_d4rt_generator/src/user_proxy_relaxer_scanner.dart';
import 'package:tom_d4rt_generator/src/user_variant_sites.dart';
import 'package:tom_d4rt_generator/src/verification/generated_output_analysis.dart';

import 'support/generated_code.dart';
import 'synthesised_package.dart';

const _package = 'zom_scf15';

/// Builds the fixture package and runs the orchestrated generator over it.
///
/// [withDirective] decides whether `lib/src/d4rt_user_proxies/` carries the
/// `@D4rtUserProxy` directive; nothing else differs between the two builds.
Future<(Directory, api.GenerationResult)> _buildPackage({
  required bool withDirective,
}) async {
  final root = Directory.systemTemp.createTempSync('scf15_');
  File(p.join(root.path, 'pubspec.yaml')).writeAsStringSync(
    'name: $_package\n'
    'environment:\n'
    "  sdk: '>=3.0.0 <4.0.0'\n",
  );
  final libDir = Directory(p.join(root.path, 'lib'))..createSync();
  File(p.join(libDir.path, 'forms.dart')).writeAsStringSync('''
class ZomCustomer {
  ZomCustomer(this.id);

  final int id;
}

class ZomCustomerForm {
  ZomCustomerForm(this.title);

  final String title;
}

/// An invariant two-parameter generic delegate: a script extends it with
/// concrete arguments, so the native proxy must carry those arguments.
abstract class ZomFormList<T, F> {
  ZomFormList();

  F formFor(T item);

  int get size => 0;
}
''');
  File(
    p.join(libDir.path, '$_package.dart'),
  ).writeAsStringSync("export 'forms.dart';\n");

  if (withDirective) {
    final dir = Directory(p.join(libDir.path, 'src', 'd4rt_user_proxies'))
      ..createSync(recursive: true);
    File(p.join(dir.path, 'zom_form_list_proxy.dart')).writeAsStringSync('''
library;

import 'package:tom_d4rt/d4rt.dart';

@D4rtUserProxy(
  'package:$_package/forms.dart',
  'ZomFormList',
  variants: ['ZomCustomer, ZomCustomerForm'],
)
class ZomFormListUserProxy extends D4UserProxy {}
''');
  }

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
          barrelFiles: ['package:$_package/$_package.dart'],
          outputPath: 'lib/src/bridges/${_package}_bridges.b.dart',
        ),
      ],
    ),
  );
  return (root, result);
}

void main() {
  group('SCF15: a directive becomes a proxy instantiation', () {
    UserVariantDirective directive(
      List<String> variants, {
      UserVariantKind kind = UserVariantKind.proxy,
    }) => UserVariantDirective.parse(
      kind: kind,
      libraryPath: 'package:zom/forms.dart',
      baseClass: 'ZomFormList',
      variants: variants,
      directiveClassName: 'ZomFormListUserProxy',
      sourceFile: 'zom_form_list_proxy.dart',
    );

    test('G-SCF15-1: an unconfigured base gets an entry with the directive\'s '
        'library and tuples [2026-09-29] (PASS)', () {
      final classes = proxyClassesWithDirectives(const [], [
        directive(['ZomCustomer, ZomCustomerForm', 'ZomOrder, ZomOrderForm']),
      ], const []);
      expect(classes, hasLength(1));
      expect(classes.single.className, 'ZomFormList');
      expect(classes.single.libraryPath, 'package:zom/forms.dart');
      expect(classes.single.instantiations, [
        ['ZomCustomer', 'ZomCustomerForm'],
        ['ZomOrder', 'ZomOrderForm'],
      ]);
    });

    test('G-SCF15-2: a configured base keeps its settings and gains the '
        'tuples, without duplicates [2026-09-29] (PASS)', () {
      final classes = proxyClassesWithDirectives(
        const [
          ProxyClassConfig(
            className: 'ZomFormList',
            proxyName: 'MyFormListProxy',
            instantiations: [
              ['ZomCustomer', 'ZomCustomerForm'],
            ],
          ),
        ],
        [
          directive(['ZomCustomer, ZomCustomerForm', 'ZomOrder, ZomOrderForm']),
        ],
        const [],
      );
      expect(classes, hasLength(1));
      expect(classes.single.proxyName, 'MyFormListProxy');
      expect(classes.single.instantiations, hasLength(2));
      expect(
        classes.single.instantiationProxyName(['ZomOrder', 'ZomOrderForm']),
        'MyFormListProxyZomOrderZomOrderForm',
      );
    });

    test('G-SCF15-3: relaxer directives and an empty directive list add '
        'nothing [2026-09-29] (PASS)', () {
      expect(proxyClassesWithDirectives(const [], const [], const []), isEmpty);
      expect(
        proxyClassesWithDirectives(const [], [
          directive([
            'ZomCustomer, ZomCustomerForm',
          ], kind: UserVariantKind.relaxer),
        ], const []),
        isEmpty,
      );
    });

    test('G-SCF15-4: instantiations round-trip through buildkit.yaml JSON '
        '[2026-09-29] (PASS)', () {
      final config = ProxyClassConfig.fromJson({
        'className': 'ZomFormList',
        'instantiations': [
          ['ZomCustomer', 'ZomCustomerForm'],
        ],
      });
      expect(config.instantiations, [
        ['ZomCustomer', 'ZomCustomerForm'],
      ]);
      expect(
        ProxyClassConfig.fromJson(config.toJson()).instantiations,
        config.instantiations,
      );
    });
  });

  group('SCF15: a package with a directive and no configured proxy', () {
    late Directory withDirective;
    late Directory withoutDirective;
    late api.GenerationResult withResult;
    late api.GenerationResult withoutResult;

    setUpAll(() async {
      (withDirective, withResult) = await _buildPackage(withDirective: true);
      (withoutDirective, withoutResult) = await _buildPackage(
        withDirective: false,
      );
    });

    tearDownAll(() {
      for (final dir in [withDirective, withoutDirective]) {
        try {
          dir.deleteSync(recursive: true);
        } catch (_) {}
      }
    });

    File proxiesIn(Directory root) =>
        File(p.join(root.path, 'lib', 'src', 'proxies.b.dart'));

    test('G-SCF15-5: emits a proxy for the declared variant '
        '[2026-09-29] (PASS)', () {
      expect(withResult.errors, isEmpty);
      final file = proxiesIn(withDirective);
      expect(
        file.existsSync(),
        isTrue,
        reason:
            'the directive is the request: no generateProxies flag and no '
            'proxiesOutputPath were configured',
      );
      final source = readGeneratedCodeSync(file.path);
      expect(
        source,
        contains('class D4rtZomFormList<T, F> extends ZomFormList<T, F>'),
      );
      expect(
        source,
        contains(
          'typedef D4rtZomFormListZomCustomerZomCustomerForm = '
          'D4rtZomFormList<ZomCustomer, ZomCustomerForm>;',
        ),
      );
      expect(
        source,
        contains("case 'ZomCustomer, ZomCustomerForm':"),
        reason: 'the factory must pick the variant the script declared',
      );
      expect(
        source,
        contains('return D4rtZomFormListZomCustomerZomCustomerForm('),
      );
      expect(
        withResult.warnings.where((w) => w.contains('@D4rtUserProxy')),
        isEmpty,
        reason: 'the old "discovered but not emitted" warning is gone',
      );
    });

    test('G-SCF15-6: the emitted package analyses clean '
        '[2026-09-29] (PASS)', () async {
      final List<Diagnostic> diagnostics;
      try {
        diagnostics = await analyzePaths([withDirective.path]);
      } on AnalyzeInvocationException catch (e) {
        fail('$e');
      }
      final fatal = fatalDiagnostics(diagnostics);
      expect(fatal, isEmpty, reason: 'Offenders:\n${fatal.join('\n')}');
    }, timeout: const Timeout(Duration(minutes: 5)));

    test('G-SCF15-7: the same package without the directive emits no proxy '
        '[2026-09-29] (PASS)', () {
      // Anti-vacuity: G-SCF15-5 would pass just as well if the fixture
      // produced proxies by some other route.
      expect(withoutResult.errors, isEmpty);
      expect(proxiesIn(withoutDirective).existsSync(), isFalse);
    });
  });
}
