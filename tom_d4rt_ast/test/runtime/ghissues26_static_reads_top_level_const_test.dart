// GH26/AST — a static field reads the top-level constants declared before its
// class, in the analyzer-free tree (ghissues26).
//
// The mirror of `tom_d4rt/test/ghissues26_static_reads_top_level_const_test.dart`,
// which runs source. Here each script is a hand-built bundle. tom_d4rt_ast
// 0.212.1 (published) and every release before 0.214.0 ran a class's static
// initializers when the class was loaded, before the top-level variables were
// initialized, so `static const List<int> xs = <int>[_a, _b]` held nulls
// (GEN-131: a Flutter State's static const list of top-level Colors). 0.214.0
// initializes a static or top-level variable on its first read (GitHub #10).

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n, [List<String> args = const []]) => SNamedType(
  offset: 0,
  length: 0,
  name: _id(n),
  typeArguments: args.isEmpty
      ? null
      : STypeArgumentList(
          offset: 0,
          length: 0,
          arguments: [for (final a in args) _type(a)],
        ),
);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SFormalParameterList _params([List<SFormalParameter> p = const []]) =>
    SFormalParameterList(offset: 0, length: 0, parameters: p);

SExpressionFunctionBody _arrow(SExpression e) =>
    SExpressionFunctionBody(offset: 0, length: 0, expression: e);

SVariableDeclarationList _constVar(
  String name,
  String type,
  SExpression init,
) => SVariableDeclarationList(
  offset: 0,
  length: 0,
  type: _type(type),
  isConst: true,
  variables: [
    SVariableDeclaration(
      offset: 0,
      length: 0,
      name: _id(name),
      initializer: init,
      isConst: true,
    ),
  ],
);

/// `const <type> <name> = <init>;`
STopLevelVariableDeclaration _topConst(
  String name,
  String type,
  SExpression init,
) => STopLevelVariableDeclaration(
  offset: 0,
  length: 0,
  variables: _constVar(name, type, init),
);

/// `class C { static const List<T> xs = <T>[...]; T get first => xs[0]; }`
SClassDeclaration _classC(String elementType, List<String> elements) =>
    SClassDeclaration(
      offset: 0,
      length: 0,
      namePart: SNameWithTypeParameters(
        offset: 0,
        length: 0,
        typeName: _id('C'),
      ),
      body: SBlockClassBody(
        offset: 0,
        length: 0,
        members: [
          SFieldDeclaration(
            offset: 0,
            length: 0,
            isStatic: true,
            fields: SVariableDeclarationList(
              offset: 0,
              length: 0,
              type: _type('List', [elementType]),
              isConst: true,
              variables: [
                SVariableDeclaration(
                  offset: 0,
                  length: 0,
                  name: _id('xs'),
                  isConst: true,
                  initializer: SListLiteral(
                    offset: 0,
                    length: 0,
                    isConst: true,
                    typeArguments: STypeArgumentList(
                      offset: 0,
                      length: 0,
                      arguments: [_type(elementType)],
                    ),
                    elements: [for (final e in elements) _id(e)],
                  ),
                ),
              ],
            ),
          ),
          SMethodDeclaration(
            offset: 0,
            length: 0,
            name: _id('first'),
            isGetter: true,
            returnType: _type(elementType),
            body: _arrow(
              SIndexExpression(
                offset: 0,
                length: 0,
                target: _id('xs'),
                index: _int(0),
              ),
            ),
          ),
        ],
      ),
    );

/// `class P { const P(this.v); final int v; }`
final SClassDeclaration _classP = SClassDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id('P')),
  body: SBlockClassBody(
    offset: 0,
    length: 0,
    members: [
      SFieldDeclaration(
        offset: 0,
        length: 0,
        fields: SVariableDeclarationList(
          offset: 0,
          length: 0,
          type: _type('int'),
          isFinal: true,
          variables: [
            SVariableDeclaration(
              offset: 0,
              length: 0,
              name: _id('v'),
              isFinal: true,
            ),
          ],
        ),
      ),
      SConstructorDeclaration(
        offset: 0,
        length: 0,
        typeName: _id('P'),
        isConst: true,
        parameters: _params([
          SFieldFormalParameter(
            offset: 0,
            length: 0,
            name: _id('v'),
            isRequired: true,
          ),
        ]),
        body: SEmptyFunctionBody(offset: 0, length: 0),
      ),
    ],
  ),
);

SMethodInvocation _call(String name, [List<SExpression> args = const []]) =>
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
  group('GH26/AST: a static field reads earlier top-level constants', () {
    test('F-GH26-AST-1: a static const list of top-level int constants, read '
        'directly and from an instance getter [2026-11-10]', () {
      expect(
        _run(
          [
            _topConst('_a', 'int', _int(7)),
            _topConst('_b', 'int', _int(8)),
            _classC('int', ['_a', '_b']),
          ],
          SListLiteral(
            offset: 0,
            length: 0,
            elements: [
              SPrefixedIdentifier(
                offset: 0,
                length: 0,
                prefix: _id('C'),
                identifier: _id('xs'),
              ),
              _get(_call('C'), 'first'),
            ],
          ),
        ),
        [
          [7, 8],
          7,
        ],
      );
    });

    test('F-GH26-AST-2: a static const list of a top-level const object '
        '[2026-11-10]', () {
      expect(
        _run([
          _classP,
          _topConst('_a', 'P', _call('P', [_int(7)])),
          _classC('P', ['_a']),
        ], _get(_get(_call('C'), 'first'), 'v')),
        7,
      );
    });
  });
}
