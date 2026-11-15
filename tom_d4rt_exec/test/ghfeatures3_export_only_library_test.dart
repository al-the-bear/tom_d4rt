// ghfeatures3 — a bridged library whose bridges are only re-exports, class
// aliases or function typedefs is importable.
//
// Measured 2026-11-15 on tom_d4rt 1.264.0 (tree): with only
// `registerClassAlias('A', 'T', 'package:x/m.dart')` and
// `registerLibraryReExport('package:x/m.dart', 'package:x/w.dart')` for m.dart,
// `import 'package:x/m.dart'` threw `SourceCodeException: Package module
// source not preloaded for URI: package:x/m.dart`. The loader decided whether
// a URI is a bridged library from classes, enums, functions, variables,
// getters, setters and extensions only, so a pure export barrel
// (`export 'src/a.dart'; export 'src/b.dart';`) - whose bridges register
// nothing but re-exports - could not be imported. Re-exports, aliases and
// typedefs now count. The same in tom_d4rt_ast
// (test/runtime/ghfeatures3_export_only_library_test.dart).
//
// Name resolution: a library with only re-exports, aliases or typedefs is
// now a bridged library.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

class Gh3A {
  String get name => 'a';
}

class Gh3B {
  String get name => 'b';
}

const _a = 'package:gh3/src/a.dart';
const _b = 'package:gh3/src/b.dart';
const _barrel = 'package:gh3/gh3.dart';
const _aliases = 'package:gh3/legacy.dart';
const _typedefs = 'package:gh3/callbacks.dart';

BridgedClass _bridge(Type type, String name, Object Function() create) =>
    BridgedClass(
      nativeType: type,
      name: name,
      constructors: {'': (visitor, positional, named) => create()},
      getters: {'name': (visitor, target) => (target as dynamic).name},
    );

D4rt _d4rt() => D4rt()
  ..registerBridgedClass(_bridge(Gh3A, 'Gh3A', Gh3A.new), _a)
  ..registerBridgedClass(_bridge(Gh3B, 'Gh3B', Gh3B.new), _b)
  // A pure export barrel: `export 'src/a.dart'; export 'src/b.dart';`.
  ..registerLibraryReExport(_barrel, _a)
  ..registerLibraryReExport(_barrel, _b)
  // A library of deprecated aliases: `typedef OldA = Gh3A;` plus the export
  // that brings Gh3A in.
  ..registerClassAlias('OldA', 'Gh3A', _aliases)
  ..registerLibraryReExport(_aliases, _a)
  // A library of callback typedefs only.
  ..registerFunctionTypedef(
    'Gh3Callback',
    _typedefs,
    requiredPositional: 0,
    maxPositional: 0,
  );

Object? _run(String import, String main) =>
    _d4rt().execute(source: "import '$import';\n$main");

void main() {
  group('ghfeatures3: export-only bridged libraries', () {
    test('GHF3-1: a pure export barrel offers what it re-exports '
        '[2026-11-15]', () {
      expect(_run(_barrel, 'main() => [Gh3A().name, Gh3B().name];'), [
        'a',
        'b',
      ]);
    });

    test('GHF3-2: a library of aliases and one re-export: the alias and the '
        're-exported class resolve [2026-11-15]', () {
      expect(
        _run(
          _aliases,
          'main() { OldA x = OldA(); return [x.name, x is Gh3A]; }',
        ),
        ['a', true],
      );
    });

    test('GHF3-3: a library of typedefs only: its typedef names a type '
        '[2026-11-15]', () {
      expect(
        _run(
          _typedefs,
          "String call(Gh3Callback f) { f(); return 'called'; }\n"
          'main() => call(() {});',
        ),
        'called',
      );
    });

    test('GHF3-4: a URI with nothing registered is still not a bridged '
        'library [2026-11-15]', () {
      expect(
        () => _run('package:gh3/missing.dart', 'main() => 1;'),
        throwsA(predicate((e) => '$e'.contains('package:gh3/missing.dart'))),
      );
    });
  });
}
