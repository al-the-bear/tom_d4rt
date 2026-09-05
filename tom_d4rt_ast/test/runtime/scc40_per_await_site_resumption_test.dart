/// SCC40 mirror coverage for `tom_d4rt_ast`, running against the WORKING TREE.
///
/// SCC40 replaced the single per-frame `lastAwaitResult` slot with
/// `AsyncExecutionState.resolvedAwaitResults`, a map from await site to the
/// value that site resolved to. Resuming a statement re-evaluates it from the
/// top, so without that map every `await` in the statement read the same slot
/// and `(await a) + (await b)` returned `'AA'` — a silent wrong answer.
///
/// WHY THIS FILE EXISTS RATHER THAN LEANING ON THE EXEC PORT. The script-level
/// reproductions live in `tom_d4rt/test/scb14_await_receiver_position_test.dart`
/// and are ported to `tom_d4rt_exec`, but that port resolves `tom_d4rt_ast`
/// **from pub.dev** (DGUC6) — so its four multi-await cases are skipped until
/// the next publish, and the mirrored fix in THIS tree has no test that runs
/// against the working copy. A regression here would currently be caught by
/// nothing. This case closes that window: it needs no parser and no publish,
/// because the bundle is hand-built from `SAstNode`s the way
/// `execute_bundle_as_test.dart` already does. Verified to fail with `'AA'`
/// when the pre-SCC40 short-circuit is reinstated.
///
/// WHY THE MAP IS `Map.identity()`, and what this file does NOT claim.
/// `SAstNode` overrides `==` with `equals()`, which serializes both sides via
/// `toJson()` and deep-diffs them. Identity keying buys two things: an O(1)
/// lookup instead of a full JSON deep-diff on every await resumption — a hot
/// interpreter path — and immunity to two await sites fusing when their entire
/// subtrees serialize identically.
///
/// The second of those is deliberately NOT pinned here. Constructing it needs
/// two await sites with identical subtrees but different values, i.e. a
/// stateful operand such as `await next()` written twice — and that shape
/// currently hits an unrelated open defect on the variable-declaration
/// resumption route, which binds the first awaited value straight to the
/// variable and never evaluates the rest of the initializer. A test written
/// against it would be red for a reason that has nothing to do with identity
/// keying. SCD121 carries the reproduction; pin the identity claim there, once
/// the route is fixed.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  /// `Future.value(<value>)` as an expression node.
  SMethodInvocation futureValue(String value) => SMethodInvocation(
    offset: 0,
    length: 0,
    target: SSimpleIdentifier(offset: 0, length: 6, name: 'Future'),
    operator: '.',
    methodName: SSimpleIdentifier(offset: 0, length: 5, name: 'value'),
    argumentList: SArgumentList(
      offset: 0,
      length: 0,
      arguments: [SSimpleStringLiteral(offset: 0, length: 3, value: value)],
    ),
  );

  /// `var <name> = <initializer>;` as a statement node.
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
              name: SSimpleIdentifier(
                offset: 0,
                length: name.length,
                name: name,
              ),
              initializer: initializer,
            ),
          ],
        ),
      );

  /// A bundle whose async `main` is:
  ///
  ///     main() async {
  ///       var a = Future.value('A');
  ///       var b = Future.value('B');
  ///       return (await a) + (await b);
  ///     }
  ///
  /// The two await nodes are given distinct `(offset, length)` pairs, as a real
  /// parse would produce.
  AstBundle twoAwaitBundle() {
    const firstAwait = (10, 7);
    const secondAwait = (20, 7);
    const entryUri = 'package:t/main.dart';
    final body = SBlock(
      offset: 0,
      length: 0,
      statements: [
        declare('a', futureValue('A')),
        declare('b', futureValue('B')),
        SReturnStatement(
          offset: 0,
          length: 0,
          expression: SBinaryExpression(
            offset: 0,
            length: 0,
            leftOperand: SAwaitExpression(
              offset: firstAwait.$1,
              length: firstAwait.$2,
              expression: SSimpleIdentifier(offset: 0, length: 1, name: 'a'),
            ),
            operator: '+',
            rightOperand: SAwaitExpression(
              offset: secondAwait.$1,
              length: secondAwait.$2,
              expression: SSimpleIdentifier(offset: 0, length: 1, name: 'b'),
            ),
          ),
        ),
      ],
    );
    final mainFn = SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: SSimpleIdentifier(offset: 0, length: 4, name: 'main'),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          block: body,
          isAsync: true,
        ),
      ),
    );
    return AstBundle(
      entryPointUri: entryUri,
      modules: {
        entryUri: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [mainFn],
        ),
      },
    );
  }

  group('SCC40/AST: each await site resumes with its own value', () {
    test('F-SCC40-AST-1: two awaits in one statement keep their own '
        'results', () async {
      final runner = D4rtRunner();
      final result = await runner.executeBundleAsAsync<String>(
        twoAwaitBundle(),
      );
      // 'AA' is the pre-SCC40 answer: both awaits reading the one
      // `lastAwaitResult` slot the frame used to carry.
      expect(result, equals('AB'));
    });
  });
}
