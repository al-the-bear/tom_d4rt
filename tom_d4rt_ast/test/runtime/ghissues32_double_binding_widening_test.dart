// GH32/AST — an int bound to a declared `double` holds a double, wherever it
// is bound, in the analyzer-free tree (ghissues32).
//
// The mirror of `tom_d4rt/test/ghissues32_double_binding_widening_test.dart`,
// which runs source. Here each script is a hand-built bundle. Before the fix
// only a local declaration and a typed parameter widened (through
// `ResolvedBinding.bind`); a field initializer, a static or top-level
// variable, a field formal and an initializer-list assignment stored the int.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

/// `[static] [final] double <name> [= <value>];` as a field.
SFieldDeclaration _field(
  String name, {
  int? value,
  bool isStatic = false,
  bool isFinal = false,
}) => SFieldDeclaration(
  offset: 0,
  length: 0,
  isStatic: isStatic,
  fields: SVariableDeclarationList(
    offset: 0,
    length: 0,
    type: _type('double'),
    isFinal: isFinal,
    variables: [
      SVariableDeclaration(
        offset: 0,
        length: 0,
        name: _id(name),
        isFinal: isFinal,
        initializer: value == null ? null : _int(value),
      ),
    ],
  ),
);

SConstructorDeclaration _ctor(
  String cls, {
  List<SFormalParameter> parameters = const [],
  List<SConstructorInitializer> initializers = const [],
}) => SConstructorDeclaration(
  offset: 0,
  length: 0,
  typeName: _id(cls),
  parameters: SFormalParameterList(
    offset: 0,
    length: 0,
    parameters: parameters,
  ),
  initializers: initializers,
  body: SEmptyFunctionBody(offset: 0, length: 0),
);

SClassDeclaration _class(String name, List<SClassMember> members) =>
    SClassDeclaration(
      offset: 0,
      length: 0,
      namePart: SNameWithTypeParameters(
        offset: 0,
        length: 0,
        typeName: _id(name),
      ),
      body: SBlockClassBody(offset: 0, length: 0, members: members),
    );

SMethodInvocation _new(String name, [List<SExpression> args = const []]) =>
    SMethodInvocation(
      offset: 0,
      length: 0,
      methodName: _id(name),
      argumentList: SArgumentList(offset: 0, length: 0, arguments: args),
    );

SPropertyAccess _get(SExpression target, String name) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(name),
);

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

final Matcher _double0 = allOf(isA<double>(), 0.0);

void main() {
  group('GH32/AST: an int bound to a declared double holds a double', () {
    test('F-GH32-AST-1: an instance field initializer [2026-11-10]', () {
      expect(
        _run([
          _class('C', [_field('f', value: 0)]),
        ], _get(_new('C'), 'f')),
        _double0,
      );
    });

    test('F-GH32-AST-2: a static field and a top-level variable '
        '[2026-11-10]', () {
      expect(
        _run(
          [
            _class('C', [_field('s', value: 0, isStatic: true)]),
          ],
          SPrefixedIdentifier(
            offset: 0,
            length: 0,
            prefix: _id('C'),
            identifier: _id('s'),
          ),
        ),
        _double0,
      );
      expect(
        _run([
          STopLevelVariableDeclaration(
            offset: 0,
            length: 0,
            variables: SVariableDeclarationList(
              offset: 0,
              length: 0,
              type: _type('double'),
              variables: [
                SVariableDeclaration(
                  offset: 0,
                  length: 0,
                  name: _id('t'),
                  initializer: _int(0),
                ),
              ],
            ),
          ),
        ], _id('t')),
        _double0,
      );
    });

    test('F-GH32-AST-3: a field formal with a default and with a passed int '
        '[2026-11-10]', () {
      final declarations = [
        // class W { W([this.radius = 14]); final double radius; }
        _class('W', [
          _field('radius', isFinal: true),
          _ctor(
            'W',
            parameters: [
              SFieldFormalParameter(
                offset: 0,
                length: 0,
                name: _id('radius'),
                isRequired: false,
                defaultClause: SFormalParameterDefaultClause(
                  offset: 0,
                  length: 0,
                  value: _int(14),
                ),
              ),
            ],
          ),
        ]),
      ];
      expect(
        _run(declarations, _get(_new('W'), 'radius')),
        allOf(isA<double>(), 14.0),
      );
      expect(
        _run(declarations, _get(_new('W', [_int(7)]), 'radius')),
        allOf(isA<double>(), 7.0),
      );
    });

    test('F-GH32-AST-4: an initializer-list assignment [2026-11-10]', () {
      // class C { C() : x = 0; final double x; }
      expect(
        _run([
          _class('C', [
            _field('x', isFinal: true),
            _ctor(
              'C',
              initializers: [
                SConstructorFieldInitializer(
                  offset: 0,
                  length: 0,
                  fieldName: _id('x'),
                  expression: _int(0),
                ),
              ],
            ),
          ]),
        ], _get(_new('C'), 'x')),
        _double0,
      );
    });
  });
}
