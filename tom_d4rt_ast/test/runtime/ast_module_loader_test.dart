import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  // ===========================================================================
  // Test Helpers
  // ===========================================================================

  /// Creates a minimal empty [SCompilationUnit].
  SCompilationUnit emptyUnit() =>
      SCompilationUnit(offset: 0, length: 0);

  /// Creates an [SSimpleIdentifier] with the given [name].
  SSimpleIdentifier ident(String name) =>
      SSimpleIdentifier(offset: 0, length: name.length, name: name);

  /// Creates an [SSimpleStringLiteral] with the given [value].
  SSimpleStringLiteral strLit(String value) =>
      SSimpleStringLiteral(offset: 0, length: value.length + 2, value: value);

  /// Creates an [SImportDirective] for the given [uri].
  SImportDirective importDirective(
    String uri, {
    String? prefix,
    List<String>? show,
    List<String>? hide,
  }) {
    return SImportDirective(
      offset: 0,
      length: 0,
      uri: strLit(uri),
      prefix: prefix != null ? ident(prefix) : null,
      combinators: [
        if (show != null)
          SShowCombinator(
            offset: 0,
            length: 0,
            shownNames: show.map(ident).toList(),
          ),
        if (hide != null)
          SHideCombinator(
            offset: 0,
            length: 0,
            hiddenNames: hide.map(ident).toList(),
          ),
      ],
    );
  }

  /// Creates an [SExportDirective] for the given [uri].
  SExportDirective exportDirective(
    String uri, {
    List<String>? show,
    List<String>? hide,
  }) {
    return SExportDirective(
      offset: 0,
      length: 0,
      uri: strLit(uri),
      combinators: [
        if (show != null)
          SShowCombinator(
            offset: 0,
            length: 0,
            shownNames: show.map(ident).toList(),
          ),
        if (hide != null)
          SHideCombinator(
            offset: 0,
            length: 0,
            hiddenNames: hide.map(ident).toList(),
          ),
      ],
    );
  }

  /// Creates a function declaration: `int name() { return value; }`
  SFunctionDeclaration functionDecl(String name, int returnValue) {
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
              SReturnStatement(
                offset: 0,
                length: 0,
                expression:
                    SIntegerLiteral(offset: 0, length: 1, value: returnValue),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Creates a top-level variable: `var name = value;`
  STopLevelVariableDeclaration varDecl(String name, int value) {
    return STopLevelVariableDeclaration(
      offset: 0,
      length: 0,
      variables: SVariableDeclarationList(
        offset: 0,
        length: 0,
        variables: [
          SVariableDeclaration(
            offset: 0,
            length: 0,
            name: ident(name),
            initializer: SIntegerLiteral(offset: 0, length: 1, value: value),
          ),
        ],
      ),
    );
  }

  /// Creates an [Environment] with stdlib pre-registered (like D4rtRunner does).
  Environment initStdlibEnvironment() {
    final env = Environment();
    Stdlib(env).register();
    return env;
  }

  /// Creates an [AstModuleLoader] with default settings.
  AstModuleLoader createLoader({
    Map<String, SCompilationUnit>? modules,
    D4rtRunner? runner,
    Environment? environment,
  }) {
    final r = runner ?? D4rtRunner();
    final env = environment ?? initStdlibEnvironment();
    return AstModuleLoader(
      modules: modules ?? {},
      globalEnvironment: env,
      runner: r,
    );
  }

  // ===========================================================================
  // Constructor
  // ===========================================================================

  group('AstModuleLoader constructor', () {
    test('stores modules map', () {
      final modules = {'a.dart': emptyUnit()};
      final loader = createLoader(modules: modules);
      expect(loader.modules, same(modules));
    });

    test('stores global environment', () {
      final env = initStdlibEnvironment();
      final loader = createLoader(environment: env);
      expect(loader.globalEnvironment, same(env));
    });

    test('stores runner reference', () {
      final runner = D4rtRunner();
      final loader = createLoader(runner: runner);
      expect(loader.runner, same(runner));
    });

    test('currentLibrary is initially null', () {
      final loader = createLoader();
      expect(loader.currentLibrary, isNull);
    });
  });

  // ===========================================================================
  // Permission Delegation
  // ===========================================================================

  group('checkPermission', () {
    test('delegates to runner', () {
      final runner = D4rtRunner();
      final loader = createLoader(runner: runner);

      // No permissions granted
      expect(loader.checkPermission('anything'), isFalse);
    });

    test('reflects runner permission changes', () {
      final runner = D4rtRunner();
      final loader = createLoader(runner: runner);

      runner.grant(FilesystemPermission.read);
      final readOp = {'type': 'filesystem', 'read': true};
      final writeOp = {'type': 'filesystem', 'write': true};

      expect(loader.checkPermission(readOp), isTrue);
      expect(loader.checkPermission(writeOp), isFalse);

      runner.revoke(FilesystemPermission.read);
      expect(loader.checkPermission(readOp), isFalse);
    });
  });

  // ===========================================================================
  // Module Caching
  // ===========================================================================

  group('module caching', () {
    test('returns cached module on second call', () {
      final modules = {'package:app/a.dart': emptyUnit()};
      final loader = createLoader(modules: modules);
      final uri = Uri.parse('package:app/a.dart');

      final first = loader.loadModule(uri);
      final second = loader.loadModule(uri);

      expect(identical(first, second), isTrue);
    });

    test('caches stdlib modules', () {
      final loader = createLoader();
      final uri = Uri.parse('dart:math');

      final first = loader.loadModule(uri);
      final second = loader.loadModule(uri);

      expect(identical(first, second), isTrue);
    });
  });

  // ===========================================================================
  // Stdlib Loading
  // ===========================================================================

  group('stdlib loading', () {
    test('loads dart:core without error', () {
      final loader = createLoader();
      final module = loader.loadModule(Uri.parse('dart:core'));

      expect(module, isNotNull);
      expect(module.uri.toString(), 'dart:core');
    });

    test('loads dart:async without error', () {
      final loader = createLoader();
      final module = loader.loadModule(Uri.parse('dart:async'));

      expect(module, isNotNull);
      expect(module.uri.toString(), 'dart:async');
    });

    test('loads dart:math and makes math available', () {
      final env = initStdlibEnvironment();
      final loader = createLoader(environment: env);
      final module = loader.loadModule(Uri.parse('dart:math'));

      expect(module, isNotNull);
      // After loading dart:math, env should have math symbols
      // MathStdlib.register() adds 'pi', 'e', 'sqrt', etc.
      expect(env.get('pi'), isNotNull);
    });

    test('loads dart:convert', () {
      final env = initStdlibEnvironment();
      final loader = createLoader(environment: env);
      final module = loader.loadModule(Uri.parse('dart:convert'));

      expect(module, isNotNull);
      expect(module.uri.toString(), 'dart:convert');
    });

    test('loads dart:collection', () {
      final loader = createLoader();
      final module = loader.loadModule(Uri.parse('dart:collection'));

      expect(module, isNotNull);
      expect(module.uri.toString(), 'dart:collection');
    });

    test('loads dart:typed_data', () {
      final loader = createLoader();
      final module = loader.loadModule(Uri.parse('dart:typed_data'));

      expect(module, isNotNull);
      expect(module.uri.toString(), 'dart:typed_data');
    });

    test('loads dart:io', () {
      final loader = createLoader();
      final module = loader.loadModule(Uri.parse('dart:io'));

      expect(module, isNotNull);
      expect(module.uri.toString(), 'dart:io');
    });

    test('loads dart:isolate', () {
      final loader = createLoader();
      final module = loader.loadModule(Uri.parse('dart:isolate'));

      expect(module, isNotNull);
      expect(module.uri.toString(), 'dart:isolate');
    });

    test('throws for unsupported dart library', () {
      final loader = createLoader();

      expect(
        () => loader.loadModule(Uri.parse('dart:nonexistent')),
        throwsA(isA<RuntimeD4rtException>().having(
          (e) => e.toString(),
          'message',
          contains('dart:nonexistent'),
        )),
      );
    });

    test('does not register same stdlib twice', () {
      final env = initStdlibEnvironment();
      final loader = createLoader(environment: env);

      // Load twice — should not throw
      loader.loadModule(Uri.parse('dart:math'));
      loader.loadModule(Uri.parse('dart:math'));

      expect(env.get('pi'), isNotNull);
    });

    test('returns empty AST for stdlib modules', () {
      final loader = createLoader();
      final module = loader.loadModule(Uri.parse('dart:math'));

      // Stdlib modules return an empty compilation unit
      expect(module.ast.declarations, isEmpty);
      expect(module.ast.directives, isEmpty);
    });
  });

  // ===========================================================================
  // Missing Module
  // ===========================================================================

  group('missing module', () {
    test('throws for URI not in bundle', () {
      final loader = createLoader(modules: {});

      expect(
        () => loader.loadModule(Uri.parse('package:app/missing.dart')),
        throwsA(isA<RuntimeD4rtException>().having(
          (e) => e.toString(),
          'message',
          contains('not found in bundle'),
        )),
      );
    });

    test('error message lists available modules', () {
      final loader = createLoader(modules: {
        'package:app/a.dart': emptyUnit(),
        'package:app/b.dart': emptyUnit(),
      });

      expect(
        () => loader.loadModule(Uri.parse('package:app/missing.dart')),
        throwsA(isA<RuntimeD4rtException>().having(
          (e) => e.toString(),
          'message',
          allOf(
            contains('package:app/a.dart'),
            contains('package:app/b.dart'),
          ),
        )),
      );
    });
  });

  // ===========================================================================
  // Bundle Module Loading
  // ===========================================================================

  group('bundle module loading', () {
    test('loads module with function declaration', () {
      final modules = {
        'package:app/util.dart': SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [functionDecl('getValue', 42)],
        ),
      };
      final loader = createLoader(modules: modules);
      final module = loader.loadModule(Uri.parse('package:app/util.dart'));

      expect(module.uri.toString(), 'package:app/util.dart');
      expect(module.ast, same(modules['package:app/util.dart']));
    });

    test('loads module with top-level variable', () {
      final modules = {
        'package:app/consts.dart': SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [varDecl('myConst', 99)],
        ),
      };
      final loader = createLoader(modules: modules);
      final module = loader.loadModule(Uri.parse('package:app/consts.dart'));

      expect(module.uri.toString(), 'package:app/consts.dart');
      // The exported environment should have the variable
      expect(module.exportedEnvironment.get('myConst'), 99);
    });

    test('restores currentLibrary after loading', () {
      final modules = {
        'package:app/a.dart': SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [functionDecl('fa', 1)],
        ),
      };
      final loader = createLoader(modules: modules);
      final originalUri = Uri.parse('package:app/main.dart');
      loader.currentLibrary = originalUri;

      loader.loadModule(Uri.parse('package:app/a.dart'));

      expect(loader.currentLibrary, originalUri);
    });
  });

  // ===========================================================================
  // Import Processing
  // ===========================================================================

  group('import processing', () {
    test('processes import directive in module', () {
      // Module B has a function 'getValue' returning 42.
      // Module A imports module B and should get access to 'getValue'.
      final moduleB = SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [functionDecl('getValue', 42)],
      );
      final moduleA = SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [importDirective('package:app/b.dart')],
        declarations: [functionDecl('mainFunc', 1)],
      );

      final modules = {
        'package:app/a.dart': moduleA,
        'package:app/b.dart': moduleB,
      };
      final loader = createLoader(modules: modules);
      final loaded = loader.loadModule(Uri.parse('package:app/a.dart'));

      // Module A should have both its own function and B's function
      expect(loaded.exportedEnvironment.get('mainFunc'), isNotNull);
      expect(loaded.exportedEnvironment.get('getValue'), isNotNull);
    });

    test('processes import with dart:math stdlib', () {
      final moduleA = SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [importDirective('dart:math')],
        declarations: [functionDecl('myFunc', 1)],
      );

      final modules = {'package:app/a.dart': moduleA};
      final loader = createLoader(modules: modules);
      final loaded = loader.loadModule(Uri.parse('package:app/a.dart'));

      // Module A should have imported dart:math symbols
      expect(loaded.exportedEnvironment.get('pi'), isNotNull);
    });

    test('handles chained imports (A imports B, B imports C)', () {
      final moduleC = SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [varDecl('cValue', 100)],
      );
      final moduleB = SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [importDirective('package:app/c.dart')],
        declarations: [varDecl('bValue', 200)],
      );
      final moduleA = SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [importDirective('package:app/b.dart')],
        declarations: [varDecl('aValue', 300)],
      );

      final modules = {
        'package:app/a.dart': moduleA,
        'package:app/b.dart': moduleB,
        'package:app/c.dart': moduleC,
      };
      final loader = createLoader(modules: modules);
      final loaded = loader.loadModule(Uri.parse('package:app/a.dart'));

      // A gets its own value + B's exported values (which includes C's via import)
      expect(loaded.exportedEnvironment.get('aValue'), 300);
      expect(loaded.exportedEnvironment.get('bValue'), 200);
      // Note: C's values are not directly exported from B (no re-export),
      // but they are imported into B's module environment
    });
  });

  // ===========================================================================
  // Export Processing
  // ===========================================================================

  group('export processing', () {
    test('processes export directive', () {
      final moduleB = SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [varDecl('exportedValue', 77)],
      );
      final moduleA = SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [exportDirective('package:app/b.dart')],
        declarations: [varDecl('ownValue', 88)],
      );

      final modules = {
        'package:app/a.dart': moduleA,
        'package:app/b.dart': moduleB,
      };
      final loader = createLoader(modules: modules);
      final loaded = loader.loadModule(Uri.parse('package:app/a.dart'));

      // A's exported environment should have both its own symbols and B's exports
      expect(loaded.exportedEnvironment.get('ownValue'), 88);
      expect(loaded.exportedEnvironment.get('exportedValue'), 77);
    });

    test('export with show combinator', () {
      final moduleB = SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [
          varDecl('shown', 1),
          varDecl('hidden', 2),
        ],
      );
      final moduleA = SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [exportDirective('package:app/b.dart', show: ['shown'])],
        declarations: [varDecl('aVal', 3)],
      );

      final modules = {
        'package:app/a.dart': moduleA,
        'package:app/b.dart': moduleB,
      };
      final loader = createLoader(modules: modules);
      final loaded = loader.loadModule(Uri.parse('package:app/a.dart'));

      expect(loaded.exportedEnvironment.get('aVal'), 3);
      expect(loaded.exportedEnvironment.get('shown'), 1);
      // 'hidden' should NOT be in exported environment of A
      expect(
        () => loaded.exportedEnvironment.get('hidden'),
        throwsA(anything),
      );
    });

    test('export with hide combinator', () {
      final moduleB = SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [
          varDecl('kept', 10),
          varDecl('removed', 20),
        ],
      );
      final moduleA = SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [
          exportDirective('package:app/b.dart', hide: ['removed']),
        ],
        declarations: [varDecl('aVal', 30)],
      );

      final modules = {
        'package:app/a.dart': moduleA,
        'package:app/b.dart': moduleB,
      };
      final loader = createLoader(modules: modules);
      final loaded = loader.loadModule(Uri.parse('package:app/a.dart'));

      expect(loaded.exportedEnvironment.get('kept'), 10);
      expect(loaded.exportedEnvironment.get('aVal'), 30);
      // 'removed' should NOT be in exported environment of A
      expect(
        () => loaded.exportedEnvironment.get('removed'),
        throwsA(anything),
      );
    });
  });

  // ===========================================================================
  // URI Resolution
  // ===========================================================================

  group('URI resolution', () {
    test('resolves relative imports against current module URI', () {
      final helper = SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [varDecl('helperVal', 55)],
      );
      final main = SCompilationUnit(
        offset: 0,
        length: 0,
        // Relative import from package:app/src/main.dart to ../utils/helper.dart
        // resolves to package:app/utils/helper.dart
        directives: [importDirective('../utils/helper.dart')],
        declarations: [varDecl('mainVal', 11)],
      );

      final modules = {
        'package:app/src/main.dart': main,
        'package:app/utils/helper.dart': helper,
      };
      final loader = createLoader(modules: modules);
      final loaded = loader.loadModule(Uri.parse('package:app/src/main.dart'));

      expect(loaded.exportedEnvironment.get('mainVal'), 11);
      expect(loaded.exportedEnvironment.get('helperVal'), 55);
    });

    test('absolute package: URIs are not resolved relatively', () {
      final util = SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [varDecl('utilVal', 66)],
      );
      final main = SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [importDirective('package:other/util.dart')],
        declarations: [varDecl('mainVal', 22)],
      );

      final modules = {
        'package:app/main.dart': main,
        'package:other/util.dart': util,
      };
      final loader = createLoader(modules: modules);
      final loaded = loader.loadModule(Uri.parse('package:app/main.dart'));

      expect(loaded.exportedEnvironment.get('utilVal'), 66);
    });
  });

  // ===========================================================================
  // Show/Hide Filtering (shouldInclude)
  // ===========================================================================

  group('show/hide filtering', () {
    test('import with show combinator', () {
      final moduleB = SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [
          varDecl('visible', 1),
          varDecl('invisible', 2),
        ],
      );
      final moduleA = SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [
          importDirective('package:app/b.dart', show: ['visible']),
        ],
        declarations: [varDecl('aVal', 3)],
      );

      final modules = {
        'package:app/a.dart': moduleA,
        'package:app/b.dart': moduleB,
      };
      final loader = createLoader(modules: modules);
      final loaded = loader.loadModule(Uri.parse('package:app/a.dart'));

      expect(loaded.exportedEnvironment.get('aVal'), 3);
      // 'visible' from B should be accessible in A's environment
      expect(loaded.exportedEnvironment.get('visible'), 1);
    });

    test('import with hide combinator', () {
      final moduleB = SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [
          varDecl('kept', 10),
          varDecl('excluded', 20),
        ],
      );
      final moduleA = SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [
          importDirective('package:app/b.dart', hide: ['excluded']),
        ],
        declarations: [varDecl('aVal', 30)],
      );

      final modules = {
        'package:app/a.dart': moduleA,
        'package:app/b.dart': moduleB,
      };
      final loader = createLoader(modules: modules);
      final loaded = loader.loadModule(Uri.parse('package:app/a.dart'));

      expect(loaded.exportedEnvironment.get('aVal'), 30);
      expect(loaded.exportedEnvironment.get('kept'), 10);
    });
  });

  // ===========================================================================
  // D4rtRunner.executeBundle Integration
  // ===========================================================================

  group('D4rtRunner.executeBundle', () {
    test('executes single-module bundle', () {
      final runner = D4rtRunner();
      final bundle = AstBundle(
        entryPointUri: 'package:app/main.dart',
        modules: {
          'package:app/main.dart': SCompilationUnit(
            offset: 0,
            length: 0,
            declarations: [functionDecl('main', 42)],
          ),
        },
      );

      final result = runner.executeBundle(bundle);
      expect(result, 42);
    });

    test('executes multi-module bundle with imports', () {
      final runner = D4rtRunner();
      final bundle = AstBundle(
        entryPointUri: 'package:app/main.dart',
        modules: {
          'package:app/main.dart': SCompilationUnit(
            offset: 0,
            length: 0,
            directives: [importDirective('package:app/util.dart')],
            declarations: [functionDecl('main', 1)],
          ),
          'package:app/util.dart': SCompilationUnit(
            offset: 0,
            length: 0,
            declarations: [varDecl('utilValue', 99)],
          ),
        },
      );

      // main returns 1, but util module is loaded without error
      final result = runner.executeBundle(bundle);
      expect(result, 1);
    });

    test('throws for missing entry point override', () {
      final runner = D4rtRunner();
      final bundle = AstBundle(
        entryPointUri: 'package:app/other.dart',
        modules: {
          'package:app/other.dart': emptyUnit(),
        },
      );

      expect(
        () => runner.executeBundle(
          bundle,
          entryPoint: 'package:app/main.dart',
        ),
        throwsA(isA<ArgumentD4rtException>().having(
          (e) => e.toString(),
          'message',
          contains('not found in bundle'),
        )),
      );
    });

    test('uses custom entry point override', () {
      final runner = D4rtRunner();
      final bundle = AstBundle(
        entryPointUri: 'package:app/main.dart',
        modules: {
          'package:app/main.dart': SCompilationUnit(
            offset: 0,
            length: 0,
            declarations: [functionDecl('main', 1)],
          ),
          'package:app/alt.dart': SCompilationUnit(
            offset: 0,
            length: 0,
            declarations: [functionDecl('main', 99)],
          ),
        },
      );

      final result =
          runner.executeBundle(bundle, entryPoint: 'package:app/alt.dart');
      expect(result, 99);
    });

    test('calls named function from bundle', () {
      final runner = D4rtRunner();
      final bundle = AstBundle(
        entryPointUri: 'package:app/main.dart',
        modules: {
          'package:app/main.dart': SCompilationUnit(
            offset: 0,
            length: 0,
            declarations: [
              functionDecl('main', 1),
              functionDecl('compute', 77),
            ],
          ),
        },
      );

      final result = runner.executeBundle(bundle, name: 'compute');
      expect(result, 77);
    });

    test('supports dart:math import in bundle', () {
      final runner = D4rtRunner();
      final bundle = AstBundle(
        entryPointUri: 'package:app/main.dart',
        modules: {
          'package:app/main.dart': SCompilationUnit(
            offset: 0,
            length: 0,
            directives: [importDirective('dart:math')],
            declarations: [functionDecl('main', 314)],
          ),
        },
      );

      // Should not throw when dart:math import is encountered
      final result = runner.executeBundle(bundle);
      expect(result, 314);
    });

    test('throws for missing function in entry point', () {
      final runner = D4rtRunner();
      final bundle = AstBundle(
        entryPointUri: 'package:app/main.dart',
        modules: {
          'package:app/main.dart': SCompilationUnit(
            offset: 0,
            length: 0,
            declarations: [functionDecl('other', 1)],
          ),
        },
      );

      expect(
        () => runner.executeBundle(bundle),
        throwsA(isA<RuntimeD4rtException>().having(
          (e) => e.toString(),
          'message',
          contains('main'),
        )),
      );
    });
  });
}
