/// SCE139 mirror coverage for `tom_d4rt_ast`, running against the WORKING TREE.
///
/// The resumption branches for a return statement and for an invocation with
/// awaits in its arguments re-evaluated the node inside
/// `_determineNextNodeAfterAwait`. That evaluation's suspension cannot be
/// registered with the state machine, so it was discarded and the node was
/// executed again anyway — every await site the machine had not yet resolved
/// ran twice per pass, and the discarded pass CONSUMED the value its site
/// should have received.
///
/// WHY THIS FILE EXISTS RATHER THAN LEANING ON THE EXEC PORT. The script-level
/// reproduction lives in `tom_d4rt/test/sce139_multi_await_resumption_test.dart`
/// and can be ported to `tom_d4rt_exec`, but exec resolves `tom_d4rt_ast` **from
/// pub.dev** (DGUC6) — so a port certifies the published interpreter, not the
/// mirrored fix in this tree. Same reasoning as
/// `scc40_per_await_site_resumption_test.dart`, and the same technique: the
/// bundle is hand-built from `SAstNode`s, so it needs no parser and no publish.
///
/// HOW A DOUBLED EVALUATION IS VISIBLE WITHOUT A COUNTER. `next()` takes the
/// front of a queue of POWERS OF TWO, so every consumption pattern produces a
/// distinct sum and the value alone says what happened: 1+2 = 3 is one call per
/// site, while the pre-fix 1+4 = 5 is the second site's value being eaten by
/// the discarded pass. A counter would need a mutable top-level variable, which
/// is a great deal of hand-built AST for no extra discrimination.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  SSimpleIdentifier id(String name) =>
      SSimpleIdentifier(offset: 0, length: name.length, name: name);

  /// `var <name> = <initializer>;`
  SVariableDeclarationStatement declare(String name, SExpression initializer) =>
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
              name: id(name),
              initializer: initializer,
            ),
          ],
        ),
      );

  /// `var q = <int>[1, 2, 4, 8];` — powers of two, so the sum of any two
  /// elements names which two were taken.
  SVariableDeclarationStatement declareQueue() => declare(
    'q',
    SListLiteral(
      offset: 0,
      length: 0,
      elements: [
        for (final v in [1, 2, 4, 8])
          SIntegerLiteral(offset: 0, length: 1, value: v),
      ],
    ),
  );

  /// `Future<int> next() async { return q.removeAt(0); }`
  SFunctionDeclarationStatement declareNext() => SFunctionDeclarationStatement(
    offset: 0,
    length: 0,
    functionDeclaration: SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: id('next'),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          isAsync: true,
          block: SBlock(
            offset: 0,
            length: 0,
            statements: [
              SReturnStatement(
                offset: 0,
                length: 0,
                expression: SMethodInvocation(
                  offset: 0,
                  length: 0,
                  target: id('q'),
                  operator: '.',
                  methodName: id('removeAt'),
                  argumentList: SArgumentList(
                    offset: 0,
                    length: 0,
                    arguments: [
                      SIntegerLiteral(offset: 0, length: 1, value: 0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  /// `int add(int a, int b) => a + b;`
  SFunctionDeclarationStatement declareAdd() => SFunctionDeclarationStatement(
    offset: 0,
    length: 0,
    functionDeclaration: SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: id('add'),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(
          offset: 0,
          length: 0,
          parameters: [
            SSimpleFormalParameter(offset: 0, length: 0, name: id('a')),
            SSimpleFormalParameter(offset: 0, length: 0, name: id('b')),
          ],
        ),
        body: SExpressionFunctionBody(
          offset: 0,
          length: 0,
          expression: SBinaryExpression(
            offset: 0,
            length: 0,
            leftOperand: id('a'),
            operator: '+',
            rightOperand: id('b'),
          ),
        ),
      ),
    ),
  );

  /// `await next()` — each site gets its own `(offset, length)`, as a real
  /// parse would produce.
  SAwaitExpression awaitNext(int offset) => SAwaitExpression(
    offset: offset,
    length: 12,
    expression: SMethodInvocation(
      offset: offset,
      length: 6,
      methodName: id('next'),
      argumentList: SArgumentList(offset: 0, length: 0),
    ),
  );

  /// A bundle whose async `main` is the queue, `next`, any extra declarations,
  /// and `return <returned>`.
  AstBundle bundleReturning(
    SExpression returned, {
    List<SStatement> extra = const [],
  }) {
    const entryUri = 'package:t/main.dart';
    return AstBundle(
      entryPointUri: entryUri,
      modules: {
        entryUri: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            SFunctionDeclaration(
              offset: 0,
              length: 0,
              name: id('main'),
              functionExpression: SFunctionExpression(
                offset: 0,
                length: 0,
                parameters: SFormalParameterList(offset: 0, length: 0),
                body: SBlockFunctionBody(
                  offset: 0,
                  length: 0,
                  isAsync: true,
                  block: SBlock(
                    offset: 0,
                    length: 0,
                    statements: [
                      declareQueue(),
                      declareNext(),
                      ...extra,
                      SReturnStatement(
                        offset: 0,
                        length: 0,
                        expression: returned,
                      ),
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

  group('SCE139/AST: one evaluation per resumption pass', () {
    test('F-SCE139-AST-1: a return with two awaits takes one queue entry per '
        'site [2026-09-22]', () async {
      // Pre-fix: 5 — the discarded pass ate the 2, so the second site got 4.
      final result = await D4rtRunner().executeBundleAsAsync<int>(
        bundleReturning(
          SBinaryExpression(
            offset: 0,
            length: 0,
            leftOperand: awaitNext(100),
            operator: '+',
            rightOperand: awaitNext(200),
          ),
        ),
      );
      expect(result, equals(3));
    });

    test('F-SCE139-AST-2: awaits in the arguments of a returned invocation '
        'take one queue entry per site [2026-09-22]', () async {
      // Pre-fix: 5. This is the invocation branch rather than the return
      // branch — the await context is lifted to the nearest enclosing
      // invocation before either branch is chosen.
      final result = await D4rtRunner().executeBundleAsAsync<int>(
        bundleReturning(
          SMethodInvocation(
            offset: 0,
            length: 0,
            methodName: id('add'),
            argumentList: SArgumentList(
              offset: 0,
              length: 0,
              arguments: [awaitNext(300), awaitNext(400)],
            ),
          ),
          extra: [declareAdd()],
        ),
      );
      expect(result, equals(3));
    });

    test('F-SCE139-AST-3: CONTROL — the declaration route is unchanged '
        '[2026-09-22]', () async {
      // SCD121 already handed declarations back to the state machine, so this
      // was green before the change and must stay green: a repair that moved
      // the double evaluation onto this route would otherwise look like a fix.
      final result = await D4rtRunner().executeBundleAsAsync<int>(
        bundleReturning(
          id('s'),
          extra: [
            declare(
              's',
              SBinaryExpression(
                offset: 0,
                length: 0,
                leftOperand: awaitNext(500),
                operator: '+',
                rightOperand: awaitNext(600),
              ),
            ),
          ],
        ),
      );
      expect(result, equals(3));
    });
  });
}
