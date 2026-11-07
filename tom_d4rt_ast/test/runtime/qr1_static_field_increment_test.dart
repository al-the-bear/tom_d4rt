// QR1/AST — `++` / `--` on a static field updates the static, in the
// analyzer-free tree.
//
// The mirror of `tom_d4rt/test/qr1_static_field_increment_test.dart`, which
// runs source and covers every shape. Here each script is a hand-built
// bundle, so the set is the shapes that carry the defect's three causes:
//
// * a bare static name through implicit `this` (constructor, instance
//   method): the write minted a per-instance field (QR1-AST-1, -4);
// * a bare static name in a static member: the write touched only the
//   static-field snapshot the member runs in (QR1-AST-3);
// * a class target, `Box2.made++`: refused outright (QR1-AST-2);
//
// plus the two found while fixing it: a parameter of the static's name in a
// static member wrote through to the static (QR1-AST-5), and prefix `++c` on
// an ordinary instance field threw (QR1-AST-6).

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SArgumentList _args([List<SExpression> a = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

SFormalParameterList _params([List<SFormalParameter> p = const []]) =>
    SFormalParameterList(offset: 0, length: 0, parameters: p);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SBlock _block(List<SStatement> s) =>
    SBlock(offset: 0, length: 0, statements: s);

SExpressionStatement _stmt(SExpression e) =>
    SExpressionStatement(offset: 0, length: 0, expression: e);

SReturnStatement _ret(SExpression e) =>
    SReturnStatement(offset: 0, length: 0, expression: e);

SPostfixExpression _post(SExpression operand, String op) =>
    SPostfixExpression(offset: 0, length: 0, operand: operand, operator: op);

SPrefixExpression _pre(String op, SExpression operand) =>
    SPrefixExpression(offset: 0, length: 0, operator: op, operand: operand);

/// `Class.member`
SPrefixedIdentifier _qual(String prefix, String name) => SPrefixedIdentifier(
  offset: 0,
  length: 0,
  prefix: _id(prefix),
  identifier: _id(name),
);

SInstanceCreationExpression _new(String type) => SInstanceCreationExpression(
  offset: 0,
  length: 0,
  constructorName: SConstructorName(offset: 0, length: 0, type: _type(type)),
  argumentList: _args(),
);

SMethodInvocation _call(
  SExpression? target,
  String method, [
  List<SExpression> args = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(method),
  argumentList: _args(args),
);

SListLiteral _list(List<SExpression> e) =>
    SListLiteral(offset: 0, length: 0, elements: e);

SFieldDeclaration _field(String name, int init, {bool isStatic = true}) =>
    SFieldDeclaration(
      offset: 0,
      length: 0,
      isStatic: isStatic,
      fields: SVariableDeclarationList(
        offset: 0,
        length: 0,
        type: _type('int'),
        variables: [
          SVariableDeclaration(
            offset: 0,
            length: 0,
            name: _id(name),
            initializer: _int(init),
          ),
        ],
      ),
    );

SConstructorDeclaration _ctor(String className, List<SStatement> body) =>
    SConstructorDeclaration(
      offset: 0,
      length: 0,
      typeName: _id(className),
      parameters: _params(),
      body: SBlockFunctionBody(offset: 0, length: 0, block: _block(body)),
    );

SMethodDeclaration _method(
  String name,
  List<SStatement> body, {
  bool isStatic = false,
  List<SFormalParameter> params = const [],
}) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  isStatic: isStatic,
  parameters: _params(params),
  body: SBlockFunctionBody(offset: 0, length: 0, block: _block(body)),
);

/// A bundle with class [className] (its [members]) and a `main` running
/// [mainBody].
AstBundle _bundle(
  String className,
  List<SClassMember> members,
  List<SStatement> mainBody,
) {
  const entry = 'package:probe/main.dart';
  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [
          SClassDeclaration(
            offset: 0,
            length: 0,
            namePart: SNameWithTypeParameters(
              offset: 0,
              length: 0,
              typeName: _id(className),
            ),
            body: SBlockClassBody(offset: 0, length: 0, members: members),
          ),
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: _params(),
              body: SBlockFunctionBody(
                offset: 0,
                length: 0,
                block: _block(mainBody),
              ),
            ),
          ),
        ],
      ),
    },
  );
}

Object? _run(AstBundle bundle) => D4rtRunner().executeBundle(bundle);

void main() {
  group('QR1/AST: increment / decrement of a static field', () {
    test(
      'QR1-AST-1: bare n++ in a constructor counts constructions [2026-11-07]',
      () {
        // class A { static int n = 0; A() { n++; } }
        // main() { A(); A(); return A.n; }
        expect(
          _run(
            _bundle(
              'A',
              [
                _field('n', 0),
                _ctor('A', [_stmt(_post(_id('n'), '++'))]),
              ],
              [_stmt(_new('A')), _stmt(_new('A')), _ret(_qual('A', 'n'))],
            ),
          ),
          2,
        );
      },
    );

    test('QR1-AST-2: qualified Box2.made++ in a constructor [2026-11-07]', () {
      expect(
        _run(
          _bundle(
            'Box2',
            [
              _field('made', 0),
              _ctor('Box2', [_stmt(_post(_qual('Box2', 'made'), '++'))]),
            ],
            [
              _stmt(_new('Box2')),
              _stmt(_new('Box2')),
              _ret(_qual('Box2', 'made')),
            ],
          ),
        ),
        2,
      );
    });

    test('QR1-AST-3: bare n++ and --n in static methods update the static '
        '[2026-11-07]', () {
      // class E { static int n = 0; static void inc() { n++; }
      //   static void dec() { --n; } }
      // main() { E.inc(); E.inc(); E.inc(); E.dec(); return E.n; }
      expect(
        _run(
          _bundle(
            'E',
            [
              _field('n', 0),
              _method('inc', [_stmt(_post(_id('n'), '++'))], isStatic: true),
              _method('dec', [_stmt(_pre('--', _id('n')))], isStatic: true),
            ],
            [
              _stmt(_call(_id('E'), 'inc')),
              _stmt(_call(_id('E'), 'inc')),
              _stmt(_call(_id('E'), 'inc')),
              _stmt(_call(_id('E'), 'dec')),
              _ret(_qual('E', 'n')),
            ],
          ),
        ),
        2,
      );
    });

    test('QR1-AST-4: prefix ++n in an instance method reads back the static '
        '[2026-11-07]', () {
      // class C { static int n = 0; List go() { ++n; return [n, C.n]; } }
      // main() { C().go(); return C().go(); }
      expect(
        _run(
          _bundle(
            'C',
            [
              _field('n', 0),
              // A hand-built bundle synthesises no default constructor.
              _ctor('C', const []),
              _method('go', [
                _stmt(_pre('++', _id('n'))),
                _ret(_list([_id('n'), _qual('C', 'n')])),
              ]),
            ],
            [_stmt(_call(_new('C'), 'go')), _ret(_call(_new('C'), 'go'))],
          ),
        ),
        [2, 2],
      );
    });

    test(
      'QR1-AST-5: a parameter named like the static, incremented in a static '
      'method, leaves the static alone [2026-11-07]',
      () {
        // class L { static int n = 5; static int f(int n) { n++; return n; } }
        // main() { return [L.f(1), L.n]; }
        expect(
          _run(
            _bundle(
              'L',
              [
                _field('n', 5),
                _method(
                  'f',
                  [_stmt(_post(_id('n'), '++')), _ret(_id('n'))],
                  isStatic: true,
                  params: [
                    SRegularFormalParameter(
                      offset: 0,
                      length: 0,
                      name: _id('n'),
                      type: _type('int'),
                    ),
                  ],
                ),
              ],
              [
                _ret(
                  _list([
                    _call(_id('L'), 'f', [_int(1)]),
                    _qual('L', 'n'),
                  ]),
                ),
              ],
            ),
          ),
          [2, 5],
        );
      },
    );

    test('QR1-AST-6: prefix ++c / --c on an instance field [2026-11-07]', () {
      // class K { int c = 0; int inc() { ++c; ++c; --c; return c; } }
      // main() => K().inc();
      expect(
        _run(
          _bundle(
            'K',
            [
              _field('c', 0, isStatic: false),
              _ctor('K', const []),
              _method('inc', [
                _stmt(_pre('++', _id('c'))),
                _stmt(_pre('++', _id('c'))),
                _stmt(_pre('--', _id('c'))),
                _ret(_id('c')),
              ]),
            ],
            [_ret(_call(_new('K'), 'inc'))],
          ),
        ),
        1,
      );
    });
  });
}
