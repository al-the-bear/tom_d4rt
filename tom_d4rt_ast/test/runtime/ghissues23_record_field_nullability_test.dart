// GH23/AST — a record type annotation keeps its fields' `?` in the
// analyzer-free tree, so a nullable field accepts null (ghissues23).
//
// The mirror of `tom_d4rt/test/ghissues23_record_field_nullability_test.dart`,
// which runs source. Here each script is a hand-built bundle. Before the fix
// both resolvers built the field types without the field's `?`:
// `final (String, int?) r = ('a', null)` was refused with
// `type '(String, Null)' is not a subtype of type '(String, int)' of 'r'`, and
// `('a', null) is (String, int?)` answered false.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n, {bool nullable = false}) =>
    SNamedType(offset: 0, length: 0, name: _id(n), isNullable: nullable);

/// `(<positional>, {<named>})`, `?` when [nullable].
SRecordTypeAnnotation _record({
  List<STypeAnnotation> positional = const [],
  Map<String, STypeAnnotation> named = const {},
  bool nullable = false,
}) => SRecordTypeAnnotation(
  offset: 0,
  length: 0,
  isNullable: nullable,
  positionalFields: [
    for (final t in positional) SRecordTypeField(offset: 0, length: 0, type: t),
  ],
  namedFields: [
    for (final e in named.entries)
      SRecordTypeField(offset: 0, length: 0, type: e.value, name: _id(e.key)),
  ],
);

SRecordLiteral _recordLit({
  List<SExpression> positional = const [],
  Map<String, SExpression> named = const {},
}) => SRecordLiteral(
  offset: 0,
  length: 0,
  fields: [
    ...positional,
    for (final e in named.entries)
      SRecordLiteralNamedField(
        offset: 0,
        length: 0,
        name: _id(e.key),
        fieldExpression: e.value,
      ),
  ],
);

SNullLiteral _null() => SNullLiteral(offset: 0, length: 4);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

/// `<target>.<field>`
SPropertyAccess _field(SExpression target, String field) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(field),
);

SIsExpression _is(SExpression e, STypeAnnotation t) =>
    SIsExpression(offset: 0, length: 0, expression: e, type: t);

/// `final <type> <name> = <init>;`
SVariableDeclarationStatement _final(
  String name,
  STypeAnnotation type,
  SExpression init,
) => SVariableDeclarationStatement(
  offset: 0,
  length: 0,
  variables: SVariableDeclarationList(
    offset: 0,
    length: 0,
    type: type,
    isFinal: true,
    variables: [
      SVariableDeclaration(
        offset: 0,
        length: 0,
        name: _id(name),
        initializer: init,
        isFinal: true,
      ),
    ],
  ),
);

/// `main() { <statements> return <result>; }` after [declarations].
Object? _run(
  List<SStatement> statements,
  SExpression result, [
  List<SCompilationUnitMember> declarations = const [],
]) {
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
                parameters: SFormalParameterList(offset: 0, length: 0),
                body: SBlockFunctionBody(
                  offset: 0,
                  length: 0,
                  block: SBlock(
                    offset: 0,
                    length: 0,
                    statements: [
                      ...statements,
                      SReturnStatement(
                        offset: 0,
                        length: 0,
                        expression: result,
                      ),
                    ],
                  ),
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
  // `(String, int?)` and `({String name, int? n})`
  final positional = _record(
    positional: [_type('String'), _type('int', nullable: true)],
  );
  final named = _record(
    named: {'name': _type('String'), 'n': _type('int', nullable: true)},
  );

  group('GH23/AST: a record type keeps its fields\' `?`', () {
    test('F-GH23-AST-1: a variable with a nullable positional and named '
        'field, given null and a value [2026-11-10]', () {
      expect(
        _run(
          [
            _final(
              'a',
              positional,
              _recordLit(positional: [_str('a'), _null()]),
            ),
            _final(
              'b',
              positional,
              _recordLit(positional: [_str('b'), _int(2)]),
            ),
            _final(
              'c',
              named,
              _recordLit(named: {'name': _str('c'), 'n': _null()}),
            ),
          ],
          SListLiteral(
            offset: 0,
            length: 0,
            elements: [
              _field(_id('a'), r'$2'),
              _field(_id('b'), r'$2'),
              _field(_id('c'), 'n'),
            ],
          ),
        ),
        [null, 2, null],
      );
    });

    test('F-GH23-AST-2: a parameter [2026-11-10]', () {
      // `int? f((String, int?) r) => r.$2;`
      final f = SFunctionDeclaration(
        offset: 0,
        length: 0,
        name: _id('f'),
        functionExpression: SFunctionExpression(
          offset: 0,
          length: 0,
          parameters: SFormalParameterList(
            offset: 0,
            length: 0,
            parameters: [
              SRegularFormalParameter(
                offset: 0,
                length: 0,
                name: _id('r'),
                type: positional,
              ),
            ],
          ),
          body: SExpressionFunctionBody(
            offset: 0,
            length: 0,
            expression: _field(_id('r'), r'$2'),
          ),
        ),
      );
      expect(
        _run(
          [],
          SMethodInvocation(
            offset: 0,
            length: 0,
            methodName: _id('f'),
            argumentList: SArgumentList(
              offset: 0,
              length: 0,
              arguments: [
                _recordLit(positional: [_str('x'), _null()]),
              ],
            ),
          ),
          [f],
        ),
        isNull,
      );
    });

    test('F-GH23-AST-3: `is`, a nested nullable record, and a non-null field '
        'refusing null [2026-11-10]', () {
      final withNull = _recordLit(positional: [_str('a'), _null()]);
      expect(
        _run(
          [],
          SListLiteral(
            offset: 0,
            length: 0,
            elements: [
              _is(withNull, positional),
              _is(
                withNull,
                _record(positional: [_type('String'), _type('int')]),
              ),
              // `((int?,), {(int?,)? x})` against `((null,), x: null)`
              _is(
                _recordLit(
                  positional: [
                    _recordLit(positional: [_null()]),
                  ],
                  named: {'x': _null()},
                ),
                _record(
                  positional: [
                    _record(positional: [_type('int', nullable: true)]),
                  ],
                  named: {
                    'x': _record(
                      positional: [_type('int', nullable: true)],
                      nullable: true,
                    ),
                  },
                ),
              ),
            ],
          ),
        ),
        [true, false, true],
      );
    });
  });
}
