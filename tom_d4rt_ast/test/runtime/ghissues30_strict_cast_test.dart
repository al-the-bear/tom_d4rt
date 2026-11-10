// GH30/AST — `cast<T>()` on a stdlib collection checks its elements against
// T, in the analyzer-free tree (ghissues30).
//
// The mirror of `tom_d4rt/test/ghissues30_strict_cast_test.dart`, which runs
// source and pins the legitimate casts that must keep working. Here each
// script is a hand-built bundle. Before the fix the stdlib bridges answered
// the native `cast<dynamic>()`, so `[1, 'a'].cast<int>().toList()` answered
// `[1, a]`; and a chained `.first` on the view read every element, because
// `visitPropertyAccess` stringified its target for a debug line.

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

/// `<target>.<method><<typeArgs>>()`
SMethodInvocation _call(
  SExpression target,
  String method, [
  List<String> typeArgs = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  methodName: _id(method),
  typeArguments: typeArgs.isEmpty
      ? null
      : STypeArgumentList(
          offset: 0,
          length: 0,
          arguments: [for (final t in typeArgs) _type(t)],
        ),
  argumentList: _args(),
);

/// `<target>.<name>`
SPropertyAccess _get(SExpression target, String name) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(name),
);

/// `<target>[<index>]`
SIndexExpression _index(SExpression target, SExpression index) =>
    SIndexExpression(offset: 0, length: 0, target: target, index: index);

/// `{<key>: <value>, ...}`
SSetOrMapLiteral _map(Map<String, SExpression> entries) => SSetOrMapLiteral(
  offset: 0,
  length: 0,
  isMap: true,
  elements: [
    for (final e in entries.entries)
      SMapLiteralEntry(offset: 0, length: 0, key: _str(e.key), value: e.value),
  ],
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

Matcher _castError(String valueType, String type) => throwsA(
  predicate(
    (Object? e) => e.toString().contains(
      "type '$valueType' is not a subtype of type '$type' in type cast",
    ),
    'a cast TypeError naming $valueType and $type',
  ),
);

void main() {
  group('GH30/AST: cast<T>() checks its elements', () {
    final mixed = _list([_int(1), _str('a')]);

    test('F-GH30-AST-1: a List cast throws on reading a non-T element '
        '[2026-11-10]', () {
      expect(
        () => _run([], _call(_call(mixed, 'cast', ['int']), 'toList')),
        _castError('String', 'int'),
      );
      expect(
        () => _run(
          [],
          _call(_call(_call(mixed, 'toSet'), 'cast', ['int']), 'toList'),
        ),
        _castError('String', 'int'),
      );
    });

    test('F-GH30-AST-2: the view is lazy, also when chained '
        '[2026-11-10]', () {
      final view = _call(mixed, 'cast', ['int']);
      expect(_run([], _list([_get(view, 'first'), _get(view, 'length')])), [
        1,
        2,
      ]);
    });

    test('F-GH30-AST-3: a script class and enum are judged; a subclass '
        'passes [2026-11-10]', () {
      final declarations = <SCompilationUnitMember>[
        _class('A'),
        _class('B', 'A'),
        _enumE,
      ];
      expect(
        () => _run(
          declarations,
          _call(_call(_list([_new('B'), _new('A')]), 'cast', ['B']), 'toList'),
        ),
        _castError('A', 'B'),
      );
      expect(
        _run(
          declarations,
          _list([
            _get(
              _call(
                _call(_list([_new('B'), _new('B')]), 'cast', ['A']),
                'toList',
              ),
              'length',
            ),
            _get(
              _call(_call(_list([_e('a'), _e('b')]), 'cast', ['E']), 'toList'),
              'length',
            ),
          ]),
        ),
        [2, 2],
      );
    });

    test('F-GH30-AST-4: a Map cast checks the value it answers '
        '[2026-11-10]', () {
      final map = _map({'a': _int(1), 'b': _str('x')});
      final view = _call(map, 'cast', ['String', 'int']);
      expect(_run([], _index(view, _str('a'))), 1);
      expect(
        () => _run([], _index(view, _str('b'))),
        _castError('String', 'int'),
      );
    });
  });
}
