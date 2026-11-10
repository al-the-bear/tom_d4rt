// GH21/AST — a bridged enum is one type in the analyzer-free tree: `is`
// accepts it, and an alias or a second registration of it is the same type
// (ghissues21).
//
// The mirror of `tom_d4rt/test/ghissues21_bridged_enum_type_test.dart`, which
// runs source. Here each script is a hand-built bundle over one native enum
// defined twice (as two Flutter bridge files define WidgetState), under
// `package:w/widgets.dart` and `package:w/material.dart`, with an alias beside
// the second (as `MaterialState` is). Before the fix `E.a is E` threw
// (`Type 'Gh21AstState' not found or is not a BridgedEnumValue.`), and a
// parameter of the alias type refused a value of the enum
// (`type 'Gh21AstState' is not a subtype of type 'Gh21AstState'`).

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

enum Gh21AstState { hovered, focused }

const _entry = 'package:p/main.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SImportDirective _import(String uri) =>
    SImportDirective(offset: 0, length: 0, uri: _str(uri));

SFormalParameterList _params([List<SFormalParameter> p = const []]) =>
    SFormalParameterList(offset: 0, length: 0, parameters: p);

SExpressionFunctionBody _arrow(SExpression e) =>
    SExpressionFunctionBody(offset: 0, length: 0, expression: e);

/// `<prefix>.<name>`
SPrefixedIdentifier _dot(String prefix, String name) => SPrefixedIdentifier(
  offset: 0,
  length: 0,
  prefix: _id(prefix),
  identifier: _id(name),
);

SIsExpression _is(SExpression e, String type) =>
    SIsExpression(offset: 0, length: 0, expression: e, type: _type(type));

/// `String takes(Gh21AstMaterialState s) => s.name;`
final SFunctionDeclaration _takes = SFunctionDeclaration(
  offset: 0,
  length: 0,
  name: _id('takes'),
  returnType: _type('String'),
  functionExpression: SFunctionExpression(
    offset: 0,
    length: 0,
    parameters: _params([
      SRegularFormalParameter(
        offset: 0,
        length: 0,
        name: _id('s'),
        type: _type('Gh21AstMaterialState'),
      ),
    ]),
    body: _arrow(_dot('s', 'name')),
  ),
);

D4rtRunner _runner() => D4rtRunner()
  ..registerBridgedEnum(
    BridgedEnumDefinition<Gh21AstState>(
      name: 'Gh21AstState',
      values: Gh21AstState.values,
    ),
    'package:w/widgets.dart',
  )
  ..registerBridgedEnum(
    BridgedEnumDefinition<Gh21AstState>(
      name: 'Gh21AstState',
      values: Gh21AstState.values,
    ),
    'package:w/material.dart',
  )
  ..registerClassAlias(
    'Gh21AstMaterialState',
    'Gh21AstState',
    'package:w/material.dart',
  );

/// Runs `main() => [<results>]` with both libraries imported and `takes`.
Object? _run(List<SExpression> results) => _runner().executeBundle(
  AstBundle(
    entryPointUri: _entry,
    modules: {
      _entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [
          _import('package:w/material.dart'),
          _import('package:w/widgets.dart'),
        ],
        declarations: [
          _takes,
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: _params(),
              body: _arrow(
                SListLiteral(offset: 0, length: 0, elements: results),
              ),
            ),
          ),
        ],
      ),
    },
  ),
);

void main() {
  group('GH21/AST: a bridged enum is one type', () {
    test('F-GH21-AST-1: `is` accepts a bridged enum type and its alias, and '
        'refuses another value [2026-11-10]', () {
      expect(
        _run([
          _is(_dot('Gh21AstState', 'hovered'), 'Gh21AstState'),
          _is(_dot('Gh21AstState', 'hovered'), 'Gh21AstMaterialState'),
          _is(_dot('Gh21AstMaterialState', 'focused'), 'Gh21AstState'),
          _is(_str('x'), 'Gh21AstState'),
        ]),
        [true, true, true, false],
      );
    });

    test('F-GH21-AST-2: a parameter of the alias type takes a value of the '
        'enum [2026-11-10]', () {
      expect(
        _run([
          SMethodInvocation(
            offset: 0,
            length: 0,
            methodName: _id('takes'),
            argumentList: SArgumentList(
              offset: 0,
              length: 0,
              arguments: [_dot('Gh21AstState', 'hovered')],
            ),
          ),
        ]),
        ['hovered'],
      );
    });
  });
}
