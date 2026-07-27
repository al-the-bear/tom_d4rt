// DFUB10: support circular module imports and exports in AstModuleLoader.
//
// Circular imports and circular exports are both LEGAL in real Dart and run
// correctly. `AstModuleLoader.loadModule` used to only write to `_moduleCache`
// at the very END — after recursing through every import and export directive.
// A cycle A->B->A therefore re-entered `loadModule(A)` while A was still in
// progress, the cache guard missed, and the recursion never bottomed out.
//
// DELIBERATE DIVERGENCE FROM UPSTREAM: upstream kodjodevf/d4rt f6e1257 fixes
// the same crash by DETECTING the cycle and throwing "Circular module
// dependency detected". That rejects valid Dart, so we do not adopt it — we
// support the cycle instead, by publishing a partial module entry before
// walking the directives, exactly as a real Dart front end does.
//
// Twin of tom_d4rt/test/dfub10_circular_module_load_test.dart; the
// end-to-end (real source) conformance lives in tom_d4rt_exec.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  SSimpleIdentifier ident(String name) =>
      SSimpleIdentifier(offset: 0, length: name.length, name: name);

  SSimpleStringLiteral strLit(String value) =>
      SSimpleStringLiteral(offset: 0, length: value.length + 2, value: value);

  SImportDirective importDirective(String uri) => SImportDirective(
        offset: 0,
        length: 0,
        uri: strLit(uri),
        combinators: const [],
      );

  SExportDirective exportDirective(String uri) => SExportDirective(
        offset: 0,
        length: 0,
        uri: strLit(uri),
        combinators: const [],
      );

  /// `int name() { return <body>; }`
  SFunctionDeclaration functionDecl(String name, SExpression body) {
    return SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: ident(name),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          block: SBlock(
            offset: 0,
            length: 0,
            statements: [
              SReturnStatement(offset: 0, length: 0, expression: body),
            ],
          ),
        ),
      ),
    );
  }

  SIntegerLiteral intLit(int value) =>
      SIntegerLiteral(offset: 0, length: 1, value: value);

  /// `callee()`
  SMethodInvocation callTo(String callee) => SMethodInvocation(
        offset: 0,
        length: 0,
        methodName: ident(callee),
        argumentList: SArgumentList(offset: 0, length: 0),
      );

  SCompilationUnit unit({
    List<SDirective> directives = const [],
    List<SCompilationUnitMember> declarations = const [],
  }) =>
      SCompilationUnit(
        offset: 0,
        length: 0,
        directives: directives,
        declarations: declarations,
      );

  AstModuleLoader createLoader(Map<String, SCompilationUnit> modules) {
    final env = Environment();
    Stdlib(env).register();
    return AstModuleLoader(
      modules: modules,
      globalEnvironment: env,
      runner: D4rtRunner(),
    );
  }

  /// Invokes the zero-arg top-level function [name] exported by [module].
  Object? invoke(AstModuleLoader loader, LoadedModule module, String name) {
    final fn = module.exportedEnvironment.get(name) as InterpretedFunction;
    return fn.call(
      InterpreterVisitor(
        globalEnvironment: module.exportedEnvironment,
        moduleContext: loader,
        initialLibrary: module.uri,
      ),
      const [],
      const {},
    );
  }

  group('DFUB10: circular module load (AstModuleLoader)', () {
    test('F-DFUB10-AST-1: import cycle A<->B resolves [2026-07-27]', () {
      // a.dart: import 'b.dart'; int fromA() => 1; int callB() => fromB();
      // b.dart: import 'a.dart'; int fromB() => fromA();
      final modules = {
        'mem:/a.dart': unit(
          directives: [importDirective('mem:/b.dart')],
          declarations: [
            functionDecl('fromA', intLit(1)),
            functionDecl('callB', callTo('fromB')),
          ],
        ),
        'mem:/b.dart': unit(
          directives: [importDirective('mem:/a.dart')],
          declarations: [functionDecl('fromB', callTo('fromA'))],
        ),
      };

      final loader = createLoader(modules);
      final a = loader.loadModule(Uri.parse('mem:/a.dart'));

      // fromB's closure environment must see fromA by the time it runs — that
      // is what the deferred-merge replay guarantees.
      expect(invoke(loader, a, 'callB'), equals(1));
    });

    test('F-DFUB10-AST-2: export cycle A<->B resolves [2026-07-27]', () {
      final modules = {
        'mem:/a.dart': unit(
          directives: [exportDirective('mem:/b.dart')],
          declarations: [functionDecl('fromA', intLit(1))],
        ),
        'mem:/b.dart': unit(
          directives: [exportDirective('mem:/a.dart')],
          declarations: [functionDecl('fromB', intLit(2))],
        ),
      };

      final loader = createLoader(modules);
      final a = loader.loadModule(Uri.parse('mem:/a.dart'));

      expect(invoke(loader, a, 'fromA'), equals(1));
      expect(invoke(loader, a, 'fromB'), equals(2));
    });

    test('F-DFUB10-AST-3: self-import is a degenerate cycle [2026-07-27]', () {
      final modules = {
        'mem:/self.dart': unit(
          directives: [importDirective('mem:/self.dart')],
          declarations: [functionDecl('greet', intLit(7))],
        ),
      };

      final loader = createLoader(modules);
      final self = loader.loadModule(Uri.parse('mem:/self.dart'));

      expect(invoke(loader, self, 'greet'), equals(7));
    });

    test('F-DFUB10-AST-4: three-module cycle A->B->C->A [2026-07-27]', () {
      final modules = {
        'mem:/a.dart': unit(
          directives: [importDirective('mem:/b.dart')],
          declarations: [
            functionDecl('fromA', intLit(3)),
            functionDecl('callB', callTo('fromB')),
          ],
        ),
        'mem:/b.dart': unit(
          directives: [importDirective('mem:/c.dart')],
          declarations: [functionDecl('fromB', callTo('fromC'))],
        ),
        'mem:/c.dart': unit(
          directives: [importDirective('mem:/a.dart')],
          declarations: [functionDecl('fromC', callTo('fromA'))],
        ),
      };

      final loader = createLoader(modules);
      final a = loader.loadModule(Uri.parse('mem:/a.dart'));

      expect(invoke(loader, a, 'callB'), equals(3));
    });

    test('F-DFUB10-AST-5: cyclic modules load exactly once [2026-07-27]', () {
      final modules = {
        'mem:/a.dart': unit(
          directives: [importDirective('mem:/b.dart')],
          declarations: [functionDecl('fromA', intLit(1))],
        ),
        'mem:/b.dart': unit(
          directives: [importDirective('mem:/a.dart')],
          declarations: [functionDecl('fromB', intLit(2))],
        ),
      };

      final loader = createLoader(modules);
      final a = loader.loadModule(Uri.parse('mem:/a.dart'));

      // Both modules cached, and a re-request returns the identical instance
      // the cyclic importer was handed while the load was still in flight.
      expect(loader.loadedModuleCount, equals(2));
      expect(loader.loadModule(Uri.parse('mem:/a.dart')), same(a));
    });
  });
}
