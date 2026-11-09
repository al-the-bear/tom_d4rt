// Pull request al-the-bear/tom_d4rt#8 — type relationships keep their import
// prefix.
//
// Reproduced 2026-11-06 in a tom_d4rt_ast bundle and re-measured 2026-11-09 on
// this tree (1.237.0): `class Child extends imported.Base {}` bound a
// same-named LOCAL `Base`; without a local class of that name the prefixed
// clause was refused (`Superclass 'Base' not found`), for interpreted and
// bridged types alike. The class, mixin and enum declarations looked every
// `extends` / `implements` / `with` / `on` type up by its bare name and dropped
// `NamedType.importPrefix`; a type annotation elsewhere already resolved it.
//
// The cases follow the PR's description and fixture — the six relationship
// positions next to same-named local declarations, show / hide, a barrel, an
// import cycle, explicit `dart:core` / `dart:async` prefixes, a missing name and
// a missing prefix — plus the half filed as prefsuper1 (prefixed clauses with
// no local class of that name, a bridged target, two same-named bridges under
// two prefixes). The fix is this repository's own. GH8-5 and GH8-12 found the
// same dropped prefix in a parameter's binding check, fixed with it.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

const _entry = 'package:rel/main.dart';

/// The libraries every case imports from, plus [entry] as `main.dart`.
Map<String, String> _sources(String entry) => {
  _entry: entry,
  'package:rel/types.dart': '''
class Base {
  int base() => 10;
}

abstract class Contract {
  int contract();
}

mixin Feature {
  int feature() => 30;
}

int _privateValue = 41;

int Function() makeReader() {
  final captured = _privateValue;
  return () => captured + 1;
}
''',
  'package:rel/barrel.dart': "export 'types.dart' show Base;",
  'package:rel/cycle_a.dart': '''
import 'cycle_b.dart' as cycle;

class CycleA extends cycle.CycleB {}
''',
  'package:rel/cycle_b.dart': '''
import 'cycle_a.dart' as cycle;

class CycleB {
  int value() => 29;
}
''',
};

Object? _run(String entry, [D4rt? interpreter]) =>
    (interpreter ?? D4rt()).execute(library: _entry, sources: _sources(entry));

/// Throws whose message contains every one of [parts].
Matcher _refusedWith(List<String> parts) => throwsA(
  predicate(
    (Object e) => parts.every(e.toString().contains),
    'an error naming ${parts.join(' and ')}',
  ),
);

abstract class Gh8Shape {}

class _TokenA {}

class _TokenB {}

D4rt _bridged() => D4rt()
  ..registerBridgedClass(
    BridgedClass(nativeType: Gh8Shape, name: 'Gh8Shape', isAbstract: true),
    'package:shapes/shapes.dart',
  )
  ..registerBridgedClass(
    BridgedClass(nativeType: _TokenA, name: 'Gh8Token', isAbstract: true),
    'package:a/a.dart',
  )
  ..registerBridgedClass(
    BridgedClass(nativeType: _TokenB, name: 'Gh8Token', isAbstract: true),
    'package:b/b.dart',
  );

void main() {
  group('PR #8: a prefixed relationship binds the imported type', () {
    test('GH8-1: all six positions, next to same-named local declarations '
        '[2026-11-09]', () {
      // Every local declaration answers -1; the imported ones 10/30 and the
      // implementations 40/50. Native Dart gives 214.
      expect(
        _run('''
import 'package:rel/types.dart' as imported;

class Base {
  int base() => -1;
}

abstract class Contract {
  int contract();
}

mixin Feature {
  int feature() => -1;
}

class Extended extends imported.Base {}

class Implemented implements imported.Contract {
  int contract() => 40;
}

class Mixed with imported.Feature {}

mixin Constrained on imported.Base {
  int constrained() => base();
}

mixin InterfaceMixin implements imported.Contract {
  int contract() => 50;
}

class ConstraintApplied extends imported.Base with Constrained {}

class InterfaceApplied with InterfaceMixin {}

enum Mode with imported.Feature { active }

int main() {
  final reader = imported.makeReader();
  final implementedIsContract = Implemented() is imported.Contract;
  final interfaceAppliedIsContract = InterfaceApplied() is imported.Contract;
  return Extended().base() +
      Implemented().contract() +
      Mixed().feature() +
      ConstraintApplied().constrained() +
      InterfaceApplied().contract() +
      Mode.active.feature() +
      reader() +
      (implementedIsContract ? 1 : 0) +
      (interfaceAppliedIsContract ? 1 : 0);
}
'''),
        214,
      );
    });

    test('GH8-2: the same positions with NO local class of that name '
        '[2026-11-09]', () {
      expect(
        _run('''
import 'package:rel/types.dart' as l;

class X extends l.Base {}

class Y implements l.Contract {
  int contract() => 40;
}

class Z with l.Feature {}

mixin M on l.Base {
  int m() => base() + 1;
}

class W extends l.Base with M {}

enum E implements l.Contract {
  a;
  int contract() => 7;
}

main() => [X().base(), Y().contract(), Y() is l.Contract, Z().feature(),
  W().m(), E.a.contract()];
'''),
        // `E.a is l.Contract` is left out: an enum's `implements` does not make
        // it a subtype even without a prefix (enumtype1_akir).
        [10, 40, true, 30, 11, 7],
      );
    });

    test('GH8-3: through a barrel, an import cycle, and a show-filtered '
        'import whose function keeps its closure [2026-11-09]', () {
      expect(
        _run('''
import 'package:rel/barrel.dart' as barrel;

class Child extends barrel.Base {}

main() => Child().base();
'''),
        10,
      );
      expect(
        _run('''
import 'package:rel/cycle_a.dart' as cycle;

main() => cycle.CycleA().value();
'''),
        29,
      );
      expect(
        _run('''
import 'package:rel/types.dart' as imported show makeReader;

main() => imported.makeReader()();
'''),
        42,
      );
    });

    test('GH8-4: explicit dart:core and dart:async prefixes, alone and '
        'repeated, and the implicit ones [2026-11-09]', () {
      expect(
        _run('''
import 'dart:core' as core;

core.int main() => core.int.parse('7');
'''),
        7,
      );
      expect(
        _run('''
import 'dart:async' as a;

int main() => a.Completer<int>().isCompleted ? 1 : 0;
'''),
        0,
      );
      expect(
        _run('''
import 'dart:core' as first;
import 'dart:core' as second;
import 'dart:async' as firstAsync;
import 'dart:async' as secondAsync;

first.int main() {
  final firstReady = firstAsync.Completer<first.int>().isCompleted ? 1 : 0;
  final secondReady = secondAsync.Completer<second.int>().isCompleted ? 1 : 0;
  return first.int.parse('4') + second.int.parse('5') + firstReady + secondReady;
}
'''),
        9,
      );
      expect(
        _run('''
import 'dart:async';

int main() => int.parse('8') + (Completer<int>().isCompleted ? 1 : 0);
'''),
        8,
      );
    });

    test('GH8-5: a bridged type through its prefix, and two same-named '
        'bridges under two prefixes [2026-11-09]', () {
      expect(
        _run('''
import 'package:shapes/shapes.dart' as s;
import 'package:a/a.dart' as a;
import 'package:b/b.dart' as b;

class Square implements s.Gh8Shape {}

class X implements a.Gh8Token {}

String takeA(a.Gh8Token t) => 'a';

main() => [Square() is s.Gh8Shape, takeA(X()), X() is a.Gh8Token,
  X() is b.Gh8Token];
''', _bridged()),
        [true, 'a', true, false],
      );
      expect(
        () => _run('''
import 'package:a/a.dart' as a;
import 'package:b/b.dart' as b;

class X implements a.Gh8Token {}

String takeB(b.Gh8Token t) => 'b';

main() => takeB(X());
''', _bridged()),
        _refusedWith(["is not a subtype of type 'Gh8Token'"]),
      );
    });

    test('GH8-12: a prefixed parameter type is checked against the imported '
        'type, not a same-named local one [2026-11-09]', () {
      // The binding check resolved `l.Base` by its bare name: next to a local
      // `Base` it refused the imported instance, and without one it checked
      // nothing at all.
      const declarations = '''
import 'package:rel/types.dart' as l;

class Base {}

String take(l.Base b) => 'taken';
''';
      expect(_run('${declarations}main() => take(l.Base());'), 'taken');
      expect(
        () => _run('${declarations}main() => take(Base());'),
        _refusedWith(["is not a subtype of type 'Base' of 'b'"]),
      );
      expect(
        () => _run('''
import 'package:rel/types.dart' as l;

String take(l.Base b) => 'taken';

main() => take(5);
'''),
        _refusedWith(["type 'int' is not a subtype of type 'Base' of 'b'"]),
      );
    });
  });

  group('PR #8: a prefixed relationship never falls back to a local or '
      'script name', () {
    test('GH8-6: a name the prefix hides is refused even with a same-named '
        'local class [2026-11-09]', () {
      expect(
        () => _run('''
import 'package:rel/types.dart' as imported hide Base;

class Base {}

class Child extends imported.Base {}

main() => 1;
'''),
        _refusedWith(["Superclass 'Base' not found"]),
      );
      // The same through a bare `source:` entry, whose declarations live in
      // the scope the imported library's exports enclose, and as an
      // expression rather than a clause.
      expect(
        () => D4rt().execute(
          source: '''
import 'package:rel/types.dart' as imported hide Base;

class Base {}

class Child extends imported.Base {}

main() => 1;
''',
          sources: _sources(''),
        ),
        _refusedWith(["Superclass 'Base' not found"]),
      );
      expect(
        () => _run('''
import 'package:rel/types.dart' as imported hide Base;

class Base {}

main() => imported.Base();
'''),
        _refusedWith(["'Base' not found in imported module 'imported'"]),
      );
    });

    test('GH8-7: a name the barrel does not export is refused even with a '
        'same-named local class [2026-11-09]', () {
      expect(
        () => _run('''
import 'package:rel/barrel.dart' as barrel;

class Contract {}

class Child implements barrel.Contract {}

main() => 1;
'''),
        _refusedWith(["Interface 'Contract' not found"]),
      );
    });

    test('GH8-8: a name the library does not declare is refused even with a '
        'same-named local class [2026-11-09]', () {
      expect(
        () => _run('''
import 'package:rel/types.dart' as imported;

class Missing {}

class Child implements imported.Missing {}

main() => 1;
'''),
        _refusedWith(["Interface 'Missing' not found"]),
      );
    });

    test('GH8-9: a prefix nobody imported is refused [2026-11-09]', () {
      expect(
        () => _run('''
import 'package:rel/types.dart' as imported;

class Child extends absent.Base {}

main() => 1;
'''),
        _refusedWith(["Superclass 'Base' not found"]),
      );
    });

    test('GH8-10: a dart:core or dart:math prefix does not reach the '
        "script's own declarations [2026-11-09]", () {
      expect(
        () => _run('''
import 'dart:core' as core;

class ScriptLocal {}

class Child extends core.ScriptLocal {}

core.int main() => 1;
'''),
        _refusedWith(["Superclass 'ScriptLocal' not found"]),
      );
      expect(
        () => _run('''
import 'dart:core' as core;

class ScriptLocal {}

core.Object main() => core.ScriptLocal();
'''),
        _refusedWith(["'ScriptLocal' not found in imported module 'core'"]),
      );
      // A stdlib library of its own reaches its exports only.
      expect(
        _run('''
import 'dart:math' as m;

main() => m.max(3, 4);
'''),
        4,
      );
      expect(
        () => _run('''
import 'dart:math' as m;

class ScriptLocal {}

class Child extends m.ScriptLocal {}

main() => 1;
'''),
        _refusedWith(["Superclass 'ScriptLocal' not found"]),
      );
    });

    test('GH8-11: dynamic and Record are not relationship targets '
        '[2026-11-09]', () {
      for (final relation in ['extends', 'implements']) {
        for (final type in ['dynamic', 'Record']) {
          expect(
            () => _run('class Child $relation $type {}\n\nmain() => 1;'),
            throwsA(
              predicate(
                (Object e) =>
                    e.toString().contains("'$type'") &&
                    (e.toString().contains('not found') ||
                        e.toString().contains('not a class')),
              ),
            ),
            reason: 'class Child $relation $type',
          );
        }
      }
    });
  });
}
