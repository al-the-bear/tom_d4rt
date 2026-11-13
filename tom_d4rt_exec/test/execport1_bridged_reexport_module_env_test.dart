/// A bridged declaration that two barrels re-export reaches a library importing
/// either barrel, in exec as in tom_d4rt.
///
/// Measured 2026-11-13: exec's module loader kept its "already registered from
/// this source" maps on the loader, across the module environments it builds
/// per bridged library. The first barrel registered the declaration; the
/// second found it registered and skipped it, so ITS module env never held it
/// and a library importing only the second barrel read
/// `Undefined variable: E`. tom_d4rt answered `[x, y]` for the same script.
/// The maps are now per module env. The same loader also refused an enum name
/// registered from two different sources (ghissues21's shape), which
/// `ghissues21_bridged_enum_type_test.dart` covers.
///
/// Exec-only: the defect was in exec's own copy of the loader, which tom_d4rt
/// does not share.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

enum E { x, y }

class Thing {
  Thing(this.v);
  final int v;
}

const _canonical = 'package:w/src/decls.dart';

/// [E], [Thing], `twice` and `answer` registered from the barrels
/// `package:w/a.dart` and `package:w/b.dart`, both naming [_canonical] as
/// their source, as generated bridges do for a re-export.
D4rt _interpreter() {
  final d4rt = D4rt();
  for (final barrel in ['package:w/a.dart', 'package:w/b.dart']) {
    d4rt
      ..registerBridgedEnum(
        BridgedEnumDefinition<E>(name: 'E', values: E.values),
        barrel,
        sourceUri: _canonical,
      )
      ..registerBridgedClass(
        BridgedClass(
          nativeType: Thing,
          name: 'Thing',
          constructors: {
            '': (visitor, positional, named) => Thing(positional[0] as int),
          },
          getters: {'v': (visitor, target) => (target as Thing).v},
        ),
        barrel,
        sourceUri: _canonical,
      )
      ..registertopLevelFunction(
        'twice',
        (visitor, positional, named, typeArgs) => (positional[0] as int) * 2,
        barrel,
        sourceUri: _canonical,
      )
      ..registerGlobalVariable('answer', 42, barrel, sourceUri: _canonical);
  }
  return d4rt;
}

Object? _run(String libBody) => _interpreter().execute(
  library: 'package:p/main.dart',
  sources: {
    'package:p/main.dart':
        "import 'package:w/a.dart';\n"
        "import 'package:p/lib.dart';\n"
        'main() => [E.x.name, Thing(1).v, twice(1), answer, other()];',
    'package:p/lib.dart': "import 'package:w/b.dart';\n$libBody",
  },
);

void main() {
  group('EXECPORT1: a declaration two barrels re-export reaches both', () {
    test('F-EXECPORT1-1: an enum, through the second barrel [2026-11-13]', () {
      expect(_run('String other() => E.y.name;'), ['x', 1, 2, 42, 'y']);
    });

    test('F-EXECPORT1-2: a class, through the second barrel [2026-11-13]', () {
      expect(_run('int other() => Thing(7).v;'), ['x', 1, 2, 42, 7]);
    });

    test('F-EXECPORT1-3: a function and a variable, through the second '
        'barrel [2026-11-13]', () {
      expect(_run('int other() => twice(answer);'), ['x', 1, 2, 42, 84]);
    });
  });
}
