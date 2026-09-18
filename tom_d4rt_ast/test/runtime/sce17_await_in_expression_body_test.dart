/// SCE17 mirror coverage for `tom_d4rt_ast`, running against the WORKING TREE.
///
/// The script-level reproductions live in
/// `tom_d4rt/test/sce17_await_in_expression_body_test.dart`. `tom_d4rt_exec`
/// resolves this package from pub.dev (DGUC6), so a port there measures the
/// PUBLISHED interpreter, not this one — and sce162 blocks publishing. These
/// cases build their bundles from `SAstNode`s by hand, the way
/// `scc40_per_await_site_resumption_test.dart` does, so they need no parser and
/// no publish: they are the only way this tree's copy of the fix is covered.
///
/// WHAT IS PINNED. An `await` inside an expression-bodied async function
/// (`=> ...`) used to collapse the whole expression to the awaited value:
/// `=> "x${await a()}y"` answered `2` rather than `x2y`. A BLOCK body never
/// did, because a statement is re-run with per-site replay (SCC40) and an
/// expression body had no statement to re-run. The repair hands the body
/// expression back to the state machine as that unit.
///
/// OFFSETS MATTER HERE. `SAstNode.==` is a structural comparison that includes
/// `offset`, and the per-await-site map is keyed by node. Two await sites built
/// with the same offset and the same shape would be ONE site to it, and the
/// second would replay the first's value — which is the very bug SCC40 fixed.
/// Every node below takes a fresh offset.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  var offset = 0;
  int next() => offset += 7;

  /// `Future.value(<value>)` as an expression node.
  SMethodInvocation futureValue(int value) => SMethodInvocation(
    offset: next(),
    length: 0,
    target: SSimpleIdentifier(offset: next(), length: 6, name: 'Future'),
    operator: '.',
    methodName: SSimpleIdentifier(offset: next(), length: 5, name: 'value'),
    argumentList: SArgumentList(
      offset: next(),
      length: 0,
      arguments: [SIntegerLiteral(offset: next(), length: 1, value: value)],
    ),
  );

  SAwaitExpression awaited(int value) => SAwaitExpression(
    offset: next(),
    length: 0,
    expression: futureValue(value),
  );

  /// A bundle whose `main` is `main() async => <expression>;`.
  AstBundle expressionBodyBundle(SExpression expression) {
    const entryUri = 'package:t/main.dart';
    final mainFn = SFunctionDeclaration(
      offset: next(),
      length: 0,
      name: SSimpleIdentifier(offset: next(), length: 4, name: 'main'),
      functionExpression: SFunctionExpression(
        offset: next(),
        length: 0,
        parameters: SFormalParameterList(offset: next(), length: 0),
        body: SExpressionFunctionBody(
          offset: next(),
          length: 0,
          expression: expression,
          isAsync: true,
        ),
      ),
    );
    return AstBundle(
      entryPointUri: entryUri,
      modules: {
        entryUri: SCompilationUnit(
          offset: next(),
          length: 0,
          declarations: [mainFn],
        ),
      },
    );
  }

  group('SCE17/AST: an await in an expression body keeps its expression', () {
    test('F-SCE17-AST-1: interpolation keeps the surrounding string '
        '[2026-09-18]', () async {
      // `main() async => "x${await Future.value(2)}y";`
      final bundle = expressionBodyBundle(
        SStringInterpolation(
          offset: next(),
          length: 0,
          elements: [
            SInterpolationString(offset: next(), length: 1, value: 'x'),
            SInterpolationExpression(
              offset: next(),
              length: 0,
              expression: awaited(2),
            ),
            SInterpolationString(offset: next(), length: 1, value: 'y'),
          ],
        ),
      );
      final result = await D4rtRunner().executeBundleAsAsync<String>(bundle);
      // '2' is the pre-SCE17 answer: the whole expression collapsing to the
      // value that was awaited.
      expect(result, equals('x2y'));
    });

    test('F-SCE17-AST-2: two awaits in one interpolation keep their places '
        '[2026-09-18]', () async {
      // `main() async => "${await Future.value(2)}|${await Future.value(3)}";`
      // Distinct offsets are what make these two SITES rather than one; see the
      // note in the library doc.
      final bundle = expressionBodyBundle(
        SStringInterpolation(
          offset: next(),
          length: 0,
          elements: [
            SInterpolationExpression(
              offset: next(),
              length: 0,
              expression: awaited(2),
            ),
            SInterpolationString(offset: next(), length: 1, value: '|'),
            SInterpolationExpression(
              offset: next(),
              length: 0,
              expression: awaited(3),
            ),
          ],
        ),
      );
      final result = await D4rtRunner().executeBundleAsAsync<String>(bundle);
      expect(result, equals('2|3'));
    });

    test(
      'F-SCE17-AST-3: an await in an arithmetic expression [2026-09-18]',
      () async {
        // `main() async => (await Future.value(2)) + 10;` — no string involved,
        // which is what says the defect was never about interpolation.
        final bundle = expressionBodyBundle(
          SBinaryExpression(
            offset: next(),
            length: 0,
            leftOperand: awaited(2),
            operator: '+',
            rightOperand: SIntegerLiteral(offset: next(), length: 2, value: 10),
          ),
        );
        final result = await D4rtRunner().executeBundleAsAsync<int>(bundle);
        expect(result, equals(12));
      },
    );

    test('F-SCE17-AST-4: the body IS the await [2026-09-18]', () async {
      // Answered correctly before the fix, by accident — the machine stopped
      // and the awaited value happened to be the whole expression. Pinned so
      // the new route cannot break the easy case.
      final bundle = expressionBodyBundle(awaited(2));
      final result = await D4rtRunner().executeBundleAsAsync<int>(bundle);
      expect(result, equals(2));
    });
  });
}
