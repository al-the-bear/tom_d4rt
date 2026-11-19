// GEN-135 - a private native class wrapped as its bridged superclass still
// answers the members of the bridged interface it implements (addtestscl2).
//
// `Material.of(context)` returns a `_RenderInkFeatures extends RenderProxyBox
// implements MaterialInkController`. The interpreter wraps it as the deeper
// bridged class, `RenderProxyBox`, and before the fix `color`, `vsync` and
// `addInkFeature` - members of `MaterialInkController` only - were undefined
// even though the script declared the local as a `MaterialInkController`.
// Reduced here to `_Impl extends Cl2Base implements Cl2Ink`. The AST twin:
// `tom_d4rt_ast/test/runtime/addtestscl2_bridged_interface_members_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

class Cl2Base {
  String get base => 'base';
}

abstract interface class Cl2Ink {
  String get color;
  String paint(String what);
}

abstract interface class Cl2Other {
  String get other;
}

class _Impl extends Cl2Base implements Cl2Ink {
  @override
  String get color => 'amber';

  @override
  String paint(String what) => 'painted $what';
}

Object? _run(String body) {
  final d4rt = D4rt()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Cl2Base,
        name: 'Cl2Base',
        isAssignable: (v) => v is Cl2Base,
        hierarchyDepth: 2,
        getters: {'base': (visitor, target) => (target as Cl2Base).base},
        staticMethods: {
          'make': (visitor, positional, named, typeArgs) => _Impl(),
        },
      ),
      'package:g/g.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Cl2Ink,
        name: 'Cl2Ink',
        isAssignable: (v) => v is Cl2Ink,
        hierarchyDepth: 1,
        getters: {'color': (visitor, target) => (target as Cl2Ink).color},
        methods: {
          'paint': (visitor, target, positional, named, typeArgs) =>
              (target as Cl2Ink).paint(positional.single as String),
        },
      ),
      'package:g/g.dart',
    )
    ..registerBridgedClass(
      BridgedClass(
        nativeType: Cl2Other,
        name: 'Cl2Other',
        isAssignable: (v) => v is Cl2Other,
        hierarchyDepth: 1,
        getters: {'other': (visitor, target) => (target as Cl2Other).other},
      ),
      'package:g/g.dart',
    );
  return d4rt.execute(
    library: 'package:p/main.dart',
    sources: {
      'package:p/main.dart':
          "import 'package:g/g.dart';\n\nObject? main() {\n$body\n}\n",
    },
  );
}

void main() {
  group('GEN-135: members of a bridged interface of a private class', () {
    test('CL2-1: the superclass member still reads [2026-11-18]', () {
      expect(_run('  return Cl2Base.make().base;'), 'base');
    });

    test('CL2-2: a getter of the implemented bridged interface reads, '
        'through a local typed by the interface too [2026-11-18]', () {
      expect(_run('  return Cl2Base.make().color;'), 'amber');
      expect(
        _run('  final Cl2Ink ink = Cl2Base.make();\n  return ink.color;'),
        'amber',
      );
    });

    test('CL2-3: a method of the implemented bridged interface calls, and '
        'tears off [2026-11-18]', () {
      expect(_run("  return Cl2Base.make().paint('ink');"), 'painted ink');
      expect(
        _run("  final f = Cl2Base.make().paint;\n  return f('off');"),
        'painted off',
      );
    });

    test('CL2-4: a member of a bridged interface it does NOT implement '
        'stays undefined [2026-11-18]', () {
      expect(
        () => _run('  return (Cl2Base.make() as dynamic).other;'),
        throwsA(
          predicate(
            (Object? e) => e.toString().contains(
              "Undefined property or method 'other'",
            ),
            'the undefined-member error for other',
          ),
        ),
      );
    });
  });
}
