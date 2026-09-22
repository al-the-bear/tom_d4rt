// SCE125/AST — the analyzer-free twin of
// `tom_d4rt/test/sce125_bare_static_write_test.dart`.
//
// A bare write to a static field from an instance method landed on the
// INSTANCE: `thisInstance.set(name, …)` creates a field when none exists, so
// the write minted a per-instance shadow and `Box.v` never moved. The method
// could read its own write back, which is what kept it silent.
//
// WHAT THIS SIDE UNIQUELY ANSWERS: `visitAssignmentExpression` is this tree's
// own copy, and so is `InterpretedInstance.get`'s class-chain walk that the
// fix mirrors. The reference suite runs neither.
//
// ABLATED 2026-09-22 by removing the `_staticFieldOwner` short-circuit:
// F-SCE125-AST-1 and -2 fail, -3 passes — it is the rail that holds the
// per-instance field the fix must NOT capture.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SArgumentList _args([List<SExpression> a = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

SFormalParameterList _noParams() =>
    SFormalParameterList(offset: 0, length: 0, parameters: const []);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

/// `[static] int <name> = <init>;`
SFieldDeclaration _field(String name, int init, {required bool isStatic}) =>
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

/// `void go() { <name> += 1; }` — the BARE write under test.
SMethodDeclaration _bareIncrement(String name) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id('go'),
  returnType: _type('void'),
  parameters: _noParams(),
  body: SBlockFunctionBody(
    offset: 0,
    length: 0,
    block: SBlock(
      offset: 0,
      length: 0,
      statements: [
        SExpressionStatement(
          offset: 0,
          length: 0,
          expression: SAssignmentExpression(
            offset: 0,
            length: 0,
            leftHandSide: _id(name),
            operator: '+=',
            rightHandSide: _int(1),
          ),
        ),
      ],
    ),
  ),
);

/// `int peek() => <name>;`
SMethodDeclaration _peek(String name) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id('peek'),
  returnType: _type('int'),
  parameters: _noParams(),
  body: SExpressionFunctionBody(offset: 0, length: 0, expression: _id(name)),
);

/// `main() { var a = Box(); a.go(); return <result>; }`
AstBundle _bundle({required bool isStatic, required SExpression result}) {
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
            name: _id('Box'),
            members: [
              _field('v', 1, isStatic: isStatic),
              SConstructorDeclaration(
                offset: 0,
                length: 0,
                returnType: _id('Box'),
                parameters: _noParams(),
                body: SBlockFunctionBody(
                  offset: 0,
                  length: 0,
                  block: SBlock(offset: 0, length: 0, statements: const []),
                ),
              ),
              _bareIncrement('v'),
              _peek('v'),
            ],
          ),
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: _noParams(),
              body: SBlockFunctionBody(
                offset: 0,
                length: 0,
                block: SBlock(
                  offset: 0,
                  length: 0,
                  statements: [
                    SVariableDeclarationStatement(
                      offset: 0,
                      length: 0,
                      variables: SVariableDeclarationList(
                        offset: 0,
                        length: 0,
                        variables: [
                          SVariableDeclaration(
                            offset: 0,
                            length: 0,
                            name: _id('a'),
                            initializer: SInstanceCreationExpression(
                              offset: 0,
                              length: 0,
                              constructorName: SConstructorName(
                                offset: 0,
                                length: 0,
                                type: _type('Box'),
                              ),
                              argumentList: _args(),
                            ),
                          ),
                          SVariableDeclaration(
                            offset: 0,
                            length: 0,
                            name: _id('b'),
                            initializer: SInstanceCreationExpression(
                              offset: 0,
                              length: 0,
                              constructorName: SConstructorName(
                                offset: 0,
                                length: 0,
                                type: _type('Box'),
                              ),
                              argumentList: _args(),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SExpressionStatement(
                      offset: 0,
                      length: 0,
                      expression: SMethodInvocation(
                        offset: 0,
                        length: 0,
                        target: _id('a'),
                        operator: '.',
                        methodName: _id('go'),
                        argumentList: _args(),
                      ),
                    ),
                    SReturnStatement(offset: 0, length: 0, expression: result),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    },
  );
}

/// `Box.v` — the QUALIFIED read, which never saw the shadow.
SExpression get _qualified => SPrefixedIdentifier(
  offset: 0,
  length: 0,
  prefix: _id('Box'),
  identifier: _id('v'),
);

/// `b.peek()` — the other instance, which saw its own copy.
SExpression get _otherPeek => SMethodInvocation(
  offset: 0,
  length: 0,
  target: _id('b'),
  operator: '.',
  methodName: _id('peek'),
  argumentList: _args(),
);

Object? _run({required bool isStatic, required SExpression result}) =>
    D4rtRunner().executeBundle(_bundle(isStatic: isStatic, result: result));

void main() {
  group('SCE125/AST: a bare static write from an instance method', () {
    test('F-SCE125-AST-1: the static is updated, read from outside '
        '[2026-09-22] (PASS)', () {
      expect(_run(isStatic: true, result: _qualified), 2);
    });

    test('F-SCE125-AST-2: the other instance sees the same value '
        '[2026-09-22] (PASS)', () {
      // The sharpest statement of the old behaviour: `b` answered 1 for a
      // field the class declares `static`, because `a`'s write minted a
      // shadow on `a`.
      expect(_run(isStatic: true, result: _otherPeek), 2);
    });

    test('F-SCE125-AST-3 (rail): a per-instance field stays per-instance '
        '[2026-09-22] (PASS)', () {
      // The same bundle with `static` dropped. `a.go()` must move `a` only,
      // which is what the fix has to leave alone.
      expect(_run(isStatic: false, result: _otherPeek), 1);
    });
  });
}
