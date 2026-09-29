// SCF16: the bundler resolves conditional imports for its target.
//
// SCE49 made `import 'stub.dart' if (dart.library.io) 'io.dart';` survive the
// copy with both branches. The bundler still read only `directive.uri`, so the
// io branch was never bundled and a script that switches implementation by
// platform got the stub everywhere.
//
// Decided for BUNDLE time (option A): `AstBundlerConfig.target` names the
// platform, each configured directive is rewritten to the branch that platform
// selects, and only that module is bundled. So a bundle is specific to its
// target — these tests pin that each target's bundle holds its own branch and
// not the other's, and that the rewritten bundle actually runs that branch.
import 'package:test/test.dart';
import 'package:tom_ast_generator/src/bundler/ast_bundler.dart';
import 'package:tom_d4rt_ast/ast.dart';
import 'package:tom_d4rt_ast/runtime.dart' show AstBundle, D4rtRunner;

const _main = '''
import 'impl.dart' if (dart.library.io) 'impl_io.dart';

String main() => platformName();
''';

const _sources = {
  'impl.dart': "String platformName() => 'stub';",
  'impl_io.dart': "String platformName() => 'io';",
};

Future<AstBundle> _bundleFor(BundleTarget target, {String source = _main}) =>
    AstBundler(
      explicitSources: _sources,
      config: AstBundlerConfig(target: target),
    ).createFromSource(source);

void main() {
  group('SCF16: conditional imports are resolved at bundle time', () {
    test('F-SCF16-1: a VM bundle holds the io branch and not the default '
        '[2026-09-29] (PASS)', () async {
      final bundle = await _bundleFor(BundleTarget.vm);
      expect(bundle.modules.keys, containsAll(['main.dart', 'impl_io.dart']));
      expect(bundle.modules.keys, isNot(contains('impl.dart')));
    });

    test('F-SCF16-2: a web bundle holds the default and not the io branch '
        '[2026-09-29] (PASS)', () async {
      final bundle = await _bundleFor(BundleTarget.web);
      expect(bundle.modules.keys, containsAll(['main.dart', 'impl.dart']));
      expect(bundle.modules.keys, isNot(contains('impl_io.dart')));
    });

    test('F-SCF16-3: the directive is rewritten to the chosen branch and '
        'carries no configurations [2026-09-29] (PASS)', () async {
      // The runtime resolves imports by the directive's URI alone, so a
      // directive still naming the default would look for a module the VM
      // bundle does not contain.
      for (final (target, uri) in [
        (BundleTarget.vm, 'impl_io.dart'),
        (BundleTarget.web, 'impl.dart'),
      ]) {
        final bundle = await _bundleFor(target);
        final directive = bundle.modules['main.dart']!.directives
            .whereType<SImportDirective>()
            .single;
        expect(directive.uri!.stringValue, uri, reason: '$target');
        expect(directive.configurations, isEmpty, reason: '$target');
      }
    });

    test('F-SCF16-4: each bundle executes its own branch '
        '[2026-09-29] (PASS)', () async {
      expect(
        D4rtRunner().executeBundle(await _bundleFor(BundleTarget.vm)),
        'io',
      );
      expect(
        D4rtRunner().executeBundle(await _bundleFor(BundleTarget.web)),
        'stub',
      );
    });

    test('F-SCF16-5: the default target is the VM [2026-09-29] (PASS)', () {
      expect(const AstBundlerConfig().target, BundleTarget.vm);
    });

    test('F-SCF16-6: the first branch that holds wins, and an explicit '
        "`== 'value'` test is honoured [2026-09-29] (PASS)", () async {
      const source = '''
import 'impl.dart'
    if (dart.library.js_interop) 'impl_web.dart'
    if (app.flavor == 'io') 'impl_io.dart';

String main() => platformName();
''';
      final sources = {
        ..._sources,
        'impl_web.dart': "String platformName() => 'web';",
      };
      Future<Set<String>> modulesFor(BundleTarget target) async =>
          (await AstBundler(
            explicitSources: sources,
            config: AstBundlerConfig(target: target),
          ).createFromSource(source)).modules.keys.toSet();

      expect(await modulesFor(BundleTarget.web), contains('impl_web.dart'));
      expect(
        await modulesFor(
          const BundleTarget(
            'flavoured-vm',
            libraries: {'core', 'io'},
            declarations: {'app.flavor': 'io'},
          ),
        ),
        contains('impl_io.dart'),
      );
      expect(
        await modulesFor(
          const BundleTarget(
            'other-flavour',
            libraries: {'core'},
            declarations: {'app.flavor': 'web'},
          ),
        ),
        allOf(contains('impl.dart'), isNot(contains('impl_io.dart'))),
      );
    });

    test('F-SCF16-7: a conditional export is resolved the same way '
        '[2026-09-29] (PASS)', () async {
      final bundle =
          await AstBundler(
            explicitSources: {
              ..._sources,
              'api.dart':
                  "export 'impl.dart' if (dart.library.io) 'impl_io.dart';",
            },
          ).createFromSource('''
import 'api.dart';

String main() => platformName();
''');
      expect(bundle.modules.keys, contains('impl_io.dart'));
      expect(bundle.modules.keys, isNot(contains('impl.dart')));
      expect(D4rtRunner().executeBundle(bundle), 'io');
    });
  });
}
