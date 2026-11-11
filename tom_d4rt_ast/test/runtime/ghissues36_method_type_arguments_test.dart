// GH36/AST — a generic method call's type arguments reach the callee as
// written, with their `?` and their own type arguments, in the analyzer-free
// tree (ghissues36).
//
// The mirror of `tom_d4rt/test/ghissues36_method_type_arguments_test.dart`,
// which runs source. Here each script is a hand-built bundle. Before the fix
// `whereType<int?>()` arrived as `whereType<int>()` and dropped null,
// `[null].cast<int>().first` answered null and `[['a']].cast<List<int>>()`
// judged the nested list only as a list.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

/// `<name>[<args>][?]`
SNamedType _type(
  String n, {
  bool nullable = false,
  List<SNamedType> args = const [],
}) => SNamedType(
  offset: 0,
  length: 0,
  name: _id(n),
  isNullable: nullable,
  typeArguments: args.isEmpty
      ? null
      : STypeArgumentList(offset: 0, length: 0, arguments: args),
);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SNullLiteral _null() => SNullLiteral(offset: 0, length: 4);

SListLiteral _list(List<SExpression> elements) =>
    SListLiteral(offset: 0, length: 0, elements: elements);

/// `<target>.<method><<typeArg>>()`
SMethodInvocation _call(
  SExpression target,
  String method, [
  SNamedType? typeArg,
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  methodName: _id(method),
  typeArguments: typeArg == null
      ? null
      : STypeArgumentList(offset: 0, length: 0, arguments: [typeArg]),
  argumentList: SArgumentList(offset: 0, length: 0),
);

SPropertyAccess _get(SExpression target, String name) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(name),
);

Object? _run(SExpression result) {
  const entry = 'package:p/main.dart';
  return D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
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

final Matcher _castError = throwsA(
  predicate(
    (Object? e) => e.toString().contains('in type cast'),
    'a cast TypeError',
  ),
);

void main() {
  group('GH36/AST: a type argument keeps its ? and its own type arguments', () {
    test('F-GH36-AST-1: whereType<int?> keeps null, whereType<int> drops it '
        '[2026-11-11]', () {
      final xs = _list([_int(1), _null(), _str('a')]);
      expect(
        _run(
          _list([
            _call(
              _call(xs, 'whereType', _type('int', nullable: true)),
              'toList',
            ),
            _call(_call(xs, 'whereType', _type('int')), 'toList'),
          ]),
        ),
        [
          [1, null],
          [1],
        ],
      );
    });

    test('F-GH36-AST-2: cast<int> throws on a null element, cast<int?> does '
        'not [2026-11-11]', () {
      expect(
        () =>
            _run(_get(_call(_list([_null()]), 'cast', _type('int')), 'first')),
        _castError,
      );
      expect(
        _run(
          _call(
            _call(
              _list([_int(1), _null()]),
              'cast',
              _type('int', nullable: true),
            ),
            'toList',
          ),
        ),
        [1, null],
      );
    });

    test('F-GH36-AST-3: cast<List<int>> checks the nested elements '
        '[2026-11-11]', () {
      final listOfInt = _type('List', args: [_type('int')]);
      expect(
        () => _run(
          _get(
            _call(
              _list([
                _list([_str('a')]),
              ]),
              'cast',
              listOfInt,
            ),
            'first',
          ),
        ),
        _castError,
      );
      expect(
        _run(
          _get(
            _call(
              _list([
                _list([_int(1), _int(2)]),
              ]),
              'cast',
              listOfInt,
            ),
            'first',
          ),
        ),
        [1, 2],
      );
    });
  });
}
