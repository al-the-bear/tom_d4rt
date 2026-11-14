// GH48/AST — GitHub #15: an explicitly instantiated generic function
// reference keeps its type arguments, in the analyzer-free tree (ghissues48).
//
// The mirror of `tom_d4rt/test/ghissues48_instantiated_function_reference_test.dart`,
// which runs source. Here each script is a hand-built bundle. Before the fix
// visitFunctionReference evaluated only the referenced function and dropped
// the SFunctionReference's type arguments: `typeOf<String>` called later saw
// `T` unbound, and a bridged function got no type arguments. A parameter typed
// `T` with `T = int?` also refused null.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

const _entry = 'package:p/main.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

/// `<name>[<arguments>][?]`
SNamedType _type(
  String name, {
  List<STypeAnnotation> arguments = const [],
  bool nullable = false,
}) => SNamedType(
  offset: 0,
  length: 0,
  name: _id(name),
  isNullable: nullable,
  typeArguments: arguments.isEmpty
      ? null
      : STypeArgumentList(offset: 0, length: 0, arguments: arguments),
);

/// `List<int?>`
SNamedType _listOfNullableInt() => _type(
  'List',
  arguments: [_type('int', nullable: true)],
);

/// `<function><<types>>` (a reference, not called)
SFunctionReference _ref(String function, List<STypeAnnotation> types) =>
    SFunctionReference(
      offset: 0,
      length: 0,
      function: _id(function),
      typeArguments: STypeArgumentList(offset: 0, length: 0, arguments: types),
    );

/// `<function>(<args>)` where [function] is an expression.
SFunctionExpressionInvocation _invoke(
  SExpression function, {
  List<SExpression> args = const [],
  List<STypeAnnotation>? types,
}) => SFunctionExpressionInvocation(
  offset: 0,
  length: 0,
  function: function,
  typeArguments: types == null
      ? null
      : STypeArgumentList(offset: 0, length: 0, arguments: types),
  argumentList: SArgumentList(offset: 0, length: 0, arguments: args),
);

/// `<receiver>.toString()`
SMethodInvocation _toString(SExpression receiver) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: receiver,
  operator: '.',
  methodName: _id('toString'),
  argumentList: SArgumentList(offset: 0, length: 0),
);

/// A generic top-level function `<name><T>(<parameter>) => <body>`.
SFunctionDeclaration _generic(
  String name,
  SExpression body, {
  bool takesValue = false,
}) => SFunctionDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  functionExpression: SFunctionExpression(
    offset: 0,
    length: 0,
    typeParameters: STypeParameterList(
      offset: 0,
      length: 0,
      typeParameters: [STypeParameter(offset: 0, length: 0, name: _id('T'))],
    ),
    parameters: SFormalParameterList(
      offset: 0,
      length: 0,
      parameters: [
        if (takesValue)
          SRegularFormalParameter(
            offset: 0,
            length: 0,
            name: _id('value'),
            type: _type('T'),
          ),
      ],
    ),
    body: SExpressionFunctionBody(offset: 0, length: 0, expression: body),
  ),
);

/// Runs `main() => <result>` with `Type typeOf<T>() => T;` and
/// `String take<T>(T value) => 'ok';` declared, and the bridged `nameOf`.
Object? _run(SExpression result) {
  final runner = D4rtRunner()
    ..registerTopLevelFunction(
      'nameOf',
      (visitor, positional, named, typeArgs) => typeArgs!.single.name,
      'package:n/n.dart',
    );
  return runner.executeBundle(
    AstBundle(
      entryPointUri: _entry,
      modules: {
        _entry: SCompilationUnit(
          offset: 0,
          length: 0,
          directives: [
            SImportDirective(offset: 0, length: 0, uri: _str('package:n/n.dart')),
          ],
          declarations: [
            _generic('typeOf', _id('T')),
            _generic('take', _str('ok'), takesValue: true),
            SFunctionDeclaration(
              offset: 0,
              length: 0,
              name: _id('main'),
              functionExpression: SFunctionExpression(
                offset: 0,
                length: 0,
                parameters: SFormalParameterList(offset: 0, length: 0),
                body: SExpressionFunctionBody(
                  offset: 0,
                  length: 0,
                  expression: result,
                ),
              ),
            ),
          ],
        ),
      },
    ),
  );
}

void main() {
  group('GH48/AST: an instantiated generic function reference', () {
    test('F-GH48-AST-1: a reference to an interpreted generic function binds '
        'T, nested and nullable (GitHub #15) [2026-11-14]', () {
      expect(
        _run(_toString(_invoke(_ref('typeOf', [_type('String')])))),
        'String',
      );
      expect(
        _run(_toString(_invoke(_ref('typeOf', [_listOfNullableInt()])))),
        'List<int?>',
      );
    });

    test('F-GH48-AST-2: a reference to a bridged generic function passes its '
        'type arguments [2026-11-14]', () {
      expect(_run(_invoke(_ref('nameOf', [_listOfNullableInt()]))), 'List<int?>');
    });

    test('F-GH48-AST-3: a parameter typed T with T = int? admits null '
        '[2026-11-14]', () {
      expect(
        _run(
          _invoke(
            _id('take'),
            types: [_type('int', nullable: true)],
            args: [SNullLiteral(offset: 0, length: 0)],
          ),
        ),
        'ok',
      );
    });

    test('F-GH48-AST-4: an instantiated reference takes no type arguments '
        'again [2026-11-14]', () {
      expect(
        () => _run(
          _invoke(_ref('typeOf', [_type('String')]), types: [_type('int')]),
        ),
        throwsA(
          predicate(
            (Object e) => e.toString().contains('already instantiated'),
            'refused as instantiated twice',
          ),
        ),
      );
    });
  });
}
