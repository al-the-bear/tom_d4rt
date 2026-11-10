// GH22/AST — `whereType<T>()` keeps exactly the elements that are a `T`, in
// the analyzer-free tree (ghissues22).
//
// The mirror of `tom_d4rt/test/ghissues22_where_type_test.dart`, which runs
// source. Here each script is a hand-built bundle. Before the fix the stdlib
// bridges called the native `whereType()` without the call's type argument,
// so `[1, 'a', 2.5].whereType<int>()` kept all three; and `E.a is E` threw for
// a script enum (`is` had no arm for one).

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SArgumentList _args([List<SExpression> a = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

SFormalParameterList _params() => SFormalParameterList(offset: 0, length: 0);

SExpressionFunctionBody _arrow(SExpression e) =>
    SExpressionFunctionBody(offset: 0, length: 0, expression: e);

SListLiteral _list(List<SExpression> elements) =>
    SListLiteral(offset: 0, length: 0, elements: elements);

/// `<target>.<method><<typeArg>>()`
SMethodInvocation _call(SExpression target, String method, [String? typeArg]) =>
    SMethodInvocation(
      offset: 0,
      length: 0,
      target: target,
      operator: '.',
      methodName: _id(method),
      typeArguments: typeArg == null
          ? null
          : STypeArgumentList(
              offset: 0,
              length: 0,
              arguments: [_type(typeArg)],
            ),
      argumentList: _args(),
    );

/// `<target>.length`
SPropertyAccess _length(SExpression target) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id('length'),
);

/// `<name>()`
SMethodInvocation _new(String name) => SMethodInvocation(
  offset: 0,
  length: 0,
  methodName: _id(name),
  argumentList: _args(),
);

/// `class <name> [extends <superclass>] {}`
SClassDeclaration _class(String name, [String? superclass]) =>
    SClassDeclaration(
      offset: 0,
      length: 0,
      namePart: SNameWithTypeParameters(
        offset: 0,
        length: 0,
        typeName: _id(name),
      ),
      extendsClause: superclass == null
          ? null
          : SExtendsClause(offset: 0, length: 0, superclass: _type(superclass)),
      body: SBlockClassBody(offset: 0, length: 0),
    );

/// `enum E { a, b }`
final SEnumDeclaration _enumE = SEnumDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id('E')),
  body: SBlockEnumBody(
    offset: 0,
    length: 0,
    constants: [
      SEnumConstantDeclaration(offset: 0, length: 0, name: _id('a')),
      SEnumConstantDeclaration(offset: 0, length: 0, name: _id('b')),
    ],
  ),
);

SPrefixedIdentifier _e(String value) => SPrefixedIdentifier(
  offset: 0,
  length: 0,
  prefix: _id('E'),
  identifier: _id(value),
);

/// Runs `main() => <result>` after [declarations].
Object? _run(List<SCompilationUnitMember> declarations, SExpression result) {
  const entry = 'package:p/main.dart';
  return D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            ...declarations,
            SFunctionDeclaration(
              offset: 0,
              length: 0,
              name: _id('main'),
              functionExpression: SFunctionExpression(
                offset: 0,
                length: 0,
                parameters: _params(),
                body: _arrow(result),
              ),
            ),
          ],
        ),
      },
    ),
  );
}

void main() {
  group('GH22/AST: whereType<T>() keeps the T elements', () {
    test('F-GH22-AST-1: by int and String on a List, and on a Set '
        '[2026-11-10]', () {
      final mixed = _list([_int(1), _str('a'), _int(2)]);
      expect(
        _run(
          [],
          _list([
            _call(_call(mixed, 'whereType', 'int'), 'toList'),
            _call(_call(mixed, 'whereType', 'String'), 'toList'),
            _length(_call(_call(mixed, 'toSet'), 'whereType', 'int')),
          ]),
        ),
        [
          [1, 2],
          ['a'],
          2,
        ],
      );
    });

    test('F-GH22-AST-2: by an interpreted class and its subclass '
        '[2026-11-10]', () {
      final objects = _list([_new('B'), _new('A'), _int(1)]);
      expect(
        _run(
          [_class('A'), _class('B', 'A')],
          _list([
            _length(_call(objects, 'whereType', 'A')),
            _length(_call(objects, 'whereType', 'B')),
          ]),
        ),
        [2, 1],
      );
    });

    test('F-GH22-AST-3: `is` and whereType on a script enum [2026-11-10]', () {
      expect(
        _run(
          [_enumE],
          _list([
            SIsExpression(
              offset: 0,
              length: 0,
              expression: _e('a'),
              type: _type('E'),
            ),
            _length(
              _call(_list([_e('a'), _int(1), _e('b')]), 'whereType', 'E'),
            ),
          ]),
        ),
        [true, 2],
      );
    });
  });
}
