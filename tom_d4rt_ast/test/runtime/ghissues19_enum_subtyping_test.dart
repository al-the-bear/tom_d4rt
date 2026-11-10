// GHI19/AST — an enum's `implements` and `with` clauses make it a subtype, in
// the analyzer-free tree (ghissues19).
//
// The mirror of `tom_d4rt/test/ghissues19_enum_subtyping_test.dart`, which runs
// source. Here each script is a hand-built bundle: `enum E implements C` and
// `enum E with F`, asked through `is`, a typed parameter, `is Enum`, a bridged
// interface, and an undefined interface, which is reported. Before the fix
// every subtype question about an enum value answered no except for the enum
// itself and Object, and the `implements` clause was never read.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SFormalParameterList _params([List<SFormalParameter> p = const []]) =>
    SFormalParameterList(offset: 0, length: 0, parameters: p);

SExpressionFunctionBody _arrow(SExpression e) =>
    SExpressionFunctionBody(offset: 0, length: 0, expression: e);

/// `int <name>() => <value>;`, or abstract without [value].
SMethodDeclaration _method(String name, [int? value]) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  returnType: _type('int'),
  isAbstract: value == null,
  parameters: _params(),
  body: value == null
      ? SEmptyFunctionBody(offset: 0, length: 0)
      : _arrow(_int(value)),
);

/// `abstract class C { int c(); }`
SClassDeclaration get _abstractC => SClassDeclaration(
  offset: 0,
  length: 0,
  isAbstract: true,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id('C')),
  body: SBlockClassBody(offset: 0, length: 0, members: [_method('c')]),
);

/// `mixin F { int f() => 3; }`
SMixinDeclaration get _mixinF => SMixinDeclaration(
  offset: 0,
  length: 0,
  name: _id('F'),
  body: SBlockClassBody(offset: 0, length: 0, members: [_method('f', 3)]),
);

/// `enum E [with <mixins>] [implements <interfaces>] { a; <members> }`
SEnumDeclaration _enum({
  List<String> withTypes = const [],
  List<String> implementsTypes = const [],
  List<SClassMember> members = const [],
}) => SEnumDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id('E')),
  withClause: withTypes.isEmpty
      ? null
      : SWithClause(
          offset: 0,
          length: 0,
          mixinTypes: [for (final t in withTypes) _type(t)],
        ),
  implementsClause: implementsTypes.isEmpty
      ? null
      : SImplementsClause(
          offset: 0,
          length: 0,
          interfaces: [for (final t in implementsTypes) _type(t)],
        ),
  body: SBlockEnumBody(
    offset: 0,
    length: 0,
    constants: [SEnumConstantDeclaration(offset: 0, length: 0, name: _id('a'))],
    members: members,
  ),
);

/// `E.a`
SPrefixedIdentifier get _ea => SPrefixedIdentifier(
  offset: 0,
  length: 0,
  prefix: _id('E'),
  identifier: _id('a'),
);

SIsExpression _is(SExpression e, String type) =>
    SIsExpression(offset: 0, length: 0, expression: e, type: _type(type));

/// `<type> take(<paramType> x) => x.<method>();`
SFunctionDeclaration _take(
  String paramType,
  String method,
  String returnType,
) => SFunctionDeclaration(
  offset: 0,
  length: 0,
  name: _id('take'),
  returnType: _type(returnType),
  functionExpression: SFunctionExpression(
    offset: 0,
    length: 0,
    parameters: _params([
      SRegularFormalParameter(
        offset: 0,
        length: 0,
        name: _id('x'),
        type: _type(paramType),
      ),
    ]),
    body: _arrow(
      SMethodInvocation(
        offset: 0,
        length: 0,
        target: _id('x'),
        operator: '.',
        methodName: _id(method),
        argumentList: SArgumentList(offset: 0, length: 0),
      ),
    ),
  ),
);

/// `take(E.a)`
SMethodInvocation get _takeEa => SMethodInvocation(
  offset: 0,
  length: 0,
  methodName: _id('take'),
  argumentList: SArgumentList(offset: 0, length: 0, arguments: [_ea]),
);

/// Runs `main() => [<results>]` after [declarations].
Object? _run(
  List<SCompilationUnitMember> declarations,
  List<SExpression> results, {
  D4rtRunner? runner,
  List<SDirective> directives = const [],
}) {
  const entry = 'package:p/main.dart';
  return (runner ?? D4rtRunner()).executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          directives: directives,
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
}

abstract class Gh13Shape {
  int shape();
}

void main() {
  group(
    'GHI19/AST: an enum is a subtype of what it implements and mixes in',
    () {
      test('F-GHI19-AST-1: an implemented interface, through `is` and a typed '
          'parameter, and Enum [2026-11-09]', () {
        expect(
          _run(
            [
              _abstractC,
              _enum(implementsTypes: ['C'], members: [_method('c', 7)]),
              _take('C', 'c', 'int'),
            ],
            [_is(_ea, 'C'), _takeEa, _is(_ea, 'Enum')],
          ),
          [true, 7, true],
        );
      });

      test('F-GHI19-AST-2: an applied mixin [2026-11-09]', () {
        expect(
          _run(
            [
              _mixinF,
              _enum(withTypes: ['F']),
              _take('F', 'f', 'int'),
            ],
            [_is(_ea, 'F'), _takeEa],
          ),
          [true, 3],
        );
      });

      test('F-GHI19-AST-3: a bridged interface [2026-11-09]', () {
        final runner = D4rtRunner()
          ..registerBridgedClass(
            BridgedClass(
              nativeType: Gh13Shape,
              name: 'Gh13Shape',
              isAbstract: true,
            ),
            'package:shapes/shapes.dart',
          );
        expect(
          _run(
            [
              _enum(
                implementsTypes: ['Gh13Shape'],
                members: [_method('shape', 4)],
              ),
              _take('Gh13Shape', 'shape', 'int'),
            ],
            [_is(_ea, 'Gh13Shape'), _takeEa],
            runner: runner,
            directives: [
              SImportDirective(
                offset: 0,
                length: 0,
                uri: SSimpleStringLiteral(
                  offset: 0,
                  length: 0,
                  value: 'package:shapes/shapes.dart',
                ),
              ),
            ],
          ),
          [true, 4],
        );
      });

      test('F-GHI19-AST-4: an unrelated class is not a supertype, and an '
          'undefined interface is reported [2026-11-09]', () {
        expect(_run([_abstractC, _enum()], [_is(_ea, 'C')]), [false]);
        expect(
          () => _run(
            [
              _enum(implementsTypes: ['Missing']),
            ],
            [_int(1)],
          ),
          throwsA(
            predicate(
              (Object e) => e.toString().contains(
                "Interface 'Missing' not found for enum 'E'",
              ),
            ),
          ),
        );
      });
    },
  );
}
