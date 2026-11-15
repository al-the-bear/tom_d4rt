// ghfeatures2 — a bridged class alias whose target comes from a library its
// own library re-exports.
//
// Measured 2026-11-15 in both Flutter twins, with bridges generated so that a
// sub-package barrel no longer receives the whole module: `material.dart`
// registers `MaterialStateProperty` as an alias of `WidgetStateProperty`,
// which `widgets.dart` declares and `material.dart` re-exports, and four
// corpus scripts failed with `Undefined variable: MaterialStateProperty`
// (also `ExpansionTileController`, `MaterialStateMouseCursor`). A bridged
// module's environment registered its aliases before merging its
// re-exports, so the target was not there yet; it used to work only because
// every module was also registered under one shared sub-package barrel. The
// loader now parks an alias without a target while it builds a module's
// environment and defines it once the re-exports are merged. The same in
// tom_d4rt_ast (test/runtime/ghfeatures2_alias_target_reexported_test.dart).
//
// Name resolution: an alias resolves through its library's re-exports.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

class Gh2Target {
  String get name => 'target';
}

/// A class of the alias's own library, as the twins' material library has
/// one (an alias-only library is tested in ghfeatures3_*).
class Gh2Own {}

const _widgets = 'package:gh2/widgets.dart';
const _material = 'package:gh2/material.dart';

D4rt _d4rt() => D4rt()
  ..registerBridgedClass(
    BridgedClass(
      nativeType: Gh2Target,
      name: 'Gh2Target',
      constructors: {'': (visitor, positional, named) => Gh2Target()},
      getters: {'name': (visitor, target) => (target as Gh2Target).name},
    ),
    _widgets,
  )
  ..registerBridgedClass(
    BridgedClass(nativeType: Gh2Own, name: 'Gh2Own'),
    _material,
  )
  ..registerClassAlias('Gh2Alias', 'Gh2Target', _material)
  ..registerLibraryReExport(_material, _widgets);

void main() {
  group('ghfeatures2: an alias whose target is re-exported', () {
    test('GHF2-A1: the alias resolves through its library, as a constructor '
        'and as a type [2026-11-15]', () {
      expect(
        _d4rt().execute(
          source:
              "import '$_material';\n"
              'main() { Gh2Alias a = Gh2Alias(); '
              "return [a.name, a is Gh2Alias, a is Gh2Target]; }",
        ),
        ['target', true, true],
      );
    });

    test('GHF2-A2: the alias is not visible through the target\'s own '
        'library, which does not declare it [2026-11-15]', () {
      expect(
        () => _d4rt().execute(
          source: "import '$_widgets';\nmain() => Gh2Alias().name;",
        ),
        throwsA(predicate((e) => '$e'.contains('Gh2Alias'))),
      );
      expect(
        _d4rt().execute(
          source: "import '$_widgets';\nmain() => Gh2Target().name;",
        ),
        'target',
      );
    });
  });
}
