// DFUB13 (AST tree): a failed import/export must produce an ACTIONABLE
// diagnostic — the twin of `tom_d4rt/test/dfub13_import_export_diagnostics_test.dart`.
//
// The bundle loader differs from the filesystem loader in one way that matters
// here: a module it cannot find is reported as a `RuntimeD4rtException`, where
// the filesystem loader raises a `SourceCodeD4rtException`. That divergence is
// why `wrapDirectiveError` keys off the `D4rtException` base class and
// reconstructs the concrete type — a wrap written against one subtype only
// would be dead code in this tree, which is exactly what the first draft was.
//
// The type divergence itself is left alone here and tracked separately; these
// tests pin the *diagnostics*, not the taxonomy.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  SCompilationUnit unit({List<SDirective> directives = const []}) =>
      SCompilationUnit(offset: 0, length: 0, directives: directives);

  SSimpleStringLiteral strLit(String value) =>
      SSimpleStringLiteral(offset: 0, length: value.length + 2, value: value);

  SImportDirective importDirective(String uri) =>
      SImportDirective(offset: 0, length: 0, uri: strLit(uri));

  SExportDirective exportDirective(String uri) =>
      SExportDirective(offset: 0, length: 0, uri: strLit(uri));

  AstModuleLoader loaderFor(Map<String, SCompilationUnit> modules) {
    final env = Environment();
    Stdlib(env).register();
    return AstModuleLoader(
      modules: modules,
      globalEnvironment: env,
      runner: D4rtRunner(),
    );
  }

  group('DFUB13/AST: missing import/export diagnostics', () {
    test('F-DFUB13-AST-1: a missing package module says how to fix it '
        '[2026-07-27]', () {
      // GAP 2. "not found in bundle" has two quite different causes with two
      // different fixes — the library was never bundled, or it is meant to come
      // from a native bridge. Naming both is what makes the message actionable.
      final loader = loaderFor({});

      expect(
        () => loader.loadModule(Uri.parse('package:nope/missing.dart')),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            allOf(
              contains('package:nope/missing.dart'),
              contains('not found in bundle'),
              contains('register a bridge'),
            ),
          ),
        ),
      );
    });

    test('F-DFUB13-AST-2: a failed import names the OWNER and the target '
        '[2026-07-27]', () {
      // GAP 3. `helper.dart` is the file holding the bad directive — the one
      // the user has to edit. Without this the message names only the target.
      final loader = loaderFor({
        'package:app/helper.dart': unit(
          directives: [importDirective('package:nope/missing.dart')],
        ),
      });

      expect(
        () => loader.loadModule(Uri.parse('package:app/helper.dart')),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            allOf(
              contains('Failed to load import'),
              contains('package:nope/missing.dart'),
              contains('package:app/helper.dart'),
            ),
          ),
        ),
      );
    });

    test('F-DFUB13-AST-3: a failed export names the OWNER and the target '
        '[2026-07-27]', () {
      // Barrels are where owner context earns its keep: the failing barrel is
      // rarely the file the user was editing.
      final loader = loaderFor({
        'package:app/barrel.dart': unit(
          directives: [exportDirective('package:nope/gone.dart')],
        ),
      });

      expect(
        () => loader.loadModule(Uri.parse('package:app/barrel.dart')),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            allOf(
              contains('Failed to load export'),
              contains('package:nope/gone.dart'),
              contains('package:app/barrel.dart'),
            ),
          ),
        ),
      );
    });

    test('F-DFUB13-AST-4: directive context is added ONCE, at the innermost '
        'failure [2026-07-27]', () {
      // loadModule recurses, so every frame on the way out could prepend its
      // own "Failed to load ..." prefix. For a deep barrel chain that repeats
      // one cause N times and buries the frame that matters — the innermost,
      // which names the file that actually contains the bad directive.
      final loader = loaderFor({
        'package:app/a.dart': unit(
          directives: [exportDirective('package:app/b.dart')],
        ),
        'package:app/b.dart': unit(
          directives: [exportDirective('package:app/c.dart')],
        ),
        'package:app/c.dart': unit(
          directives: [importDirective('package:nope/deep.dart')],
        ),
      });

      String message;
      try {
        loader.loadModule(Uri.parse('package:app/a.dart'));
        fail('expected the missing module to be reported');
      } on D4rtException catch (e) {
        message = e.toString();
      }

      expect(
        message,
        contains('package:app/c.dart'),
        reason: 'the innermost owner is the file with the bad directive',
      );
      expect(
        'Failed to load'.allMatches(message).length,
        equals(1),
        reason:
            'one directive-context prefix, not one per frame in the '
            'import chain. Got:\n$message',
      );
    });
  });
}
