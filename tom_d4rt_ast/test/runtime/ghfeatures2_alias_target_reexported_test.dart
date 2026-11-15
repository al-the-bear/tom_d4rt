// ghfeatures2/AST — a bridged class alias whose target comes from a library
// its own library re-exports, in the analyzer-free tree.
//
// The mirror of `tom_d4rt/test/ghfeatures2_alias_target_reexported_test.dart`,
// which runs source; here each script is a hand-built bundle. A bridged
// module's environment registered its aliases before merging its re-exports,
// so `material.dart`'s `MaterialStateProperty` (an alias of `widgets.dart`'s
// `WidgetStateProperty`) found no target - measured 2026-11-15 in both
// Flutter twins once a sub-package barrel no longer received the whole
// module. The loader now parks an alias without a target while it builds a
// module's environment and defines it once the re-exports are merged.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class Gh2Target {
  String get name => 'target';
}

/// A class of the alias's own library, as the twins' material library has
/// one (an alias-only library is tested in ghfeatures3_*).
class Gh2Own {}

const _entry = 'package:p/main.dart';
const _widgets = 'package:gh2/widgets.dart';
const _material = 'package:gh2/material.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

/// `<name>()`.
SMethodInvocation _new(String name) => SMethodInvocation(
  offset: 0,
  length: 0,
  methodName: _id(name),
  argumentList: SArgumentList(offset: 0, length: 0, arguments: const []),
);

SPropertyAccess _get(SExpression target, String name) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(name),
);

SIsExpression _is(SExpression e, String type) => SIsExpression(
  offset: 0,
  length: 0,
  expression: e,
  type: SNamedType(offset: 0, length: 0, name: _id(type)),
);

D4rtRunner _runner() => D4rtRunner()
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

/// Runs `main() => <body>;` in a bundle importing [import].
Object? _run(String import, SExpression body) => _runner().executeBundle(
  AstBundle(
    entryPointUri: _entry,
    modules: {
      _entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [
          SImportDirective(
            offset: 0,
            length: 0,
            uri: SSimpleStringLiteral(
              offset: 0,
              length: import.length + 2,
              value: import,
            ),
          ),
        ],
        declarations: [
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: SFormalParameterList(
                offset: 0,
                length: 0,
                parameters: const [],
              ),
              body: SExpressionFunctionBody(
                offset: 0,
                length: 0,
                expression: body,
              ),
            ),
          ),
        ],
      ),
    },
  ),
);

void main() {
  group('ghfeatures2/AST: an alias whose target is re-exported', () {
    test('GHF2-AST-A1: the alias resolves through its library, as a '
        'constructor and as a type [2026-11-15]', () {
      expect(
        _run(
          _material,
          SListLiteral(
            offset: 0,
            length: 0,
            elements: [
              _get(_new('Gh2Alias'), 'name'),
              _is(_new('Gh2Alias'), 'Gh2Alias'),
              _is(_new('Gh2Alias'), 'Gh2Target'),
            ],
          ),
        ),
        ['target', true, true],
      );
    });

    test('GHF2-AST-A2: the alias is not visible through the target\'s own '
        'library, which does not declare it [2026-11-15]', () {
      expect(
        () => _run(_widgets, _get(_new('Gh2Alias'), 'name')),
        throwsA(predicate((e) => '$e'.contains('Gh2Alias'))),
      );
      expect(_run(_widgets, _get(_new('Gh2Target'), 'name')), 'target');
    });
  });
}
