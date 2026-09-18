/// SCE19 mirror coverage for `tom_d4rt_ast`, running against the WORKING TREE.
///
/// The script-level reproductions live in
/// `tom_d4rt/test/sce19_do_while_first_body_run_test.dart`. `tom_d4rt_exec`
/// resolves this package from pub.dev (DGUC6) and sce162 blocks publishing, so
/// a port there would measure an interpreter without this fix. These bundles
/// are built from `SAstNode`s by hand, like
/// `scc40_per_await_site_resumption_test.dart`, so they need no parser.
///
/// WHAT IS PINNED. `do { log.add('x'); } while (false);` never ran its body: the
/// state machine re-enters a `SDoStatement` for two different reasons and
/// assumed the "back from the body" one every time. A loop whose condition is
/// true on entry was unaffected, which is why it survived.
///
/// The second case is the one the bookkeeping exists for. Membership of
/// `doBodiesStarted` must be forgotten when the loop is left, or a `do` nested
/// in another loop checks its condition before its body from the outer loop's
/// second iteration onwards — the same defect, one level in.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  var offset = 0;
  int next() => offset += 7;

  SExpressionStatement logAdd(SExpression value) => SExpressionStatement(
    offset: next(),
    length: 0,
    expression: SMethodInvocation(
      offset: next(),
      length: 0,
      target: SSimpleIdentifier(offset: next(), length: 3, name: 'log'),
      operator: '.',
      methodName: SSimpleIdentifier(offset: next(), length: 3, name: 'add'),
      argumentList: SArgumentList(
        offset: next(),
        length: 0,
        arguments: [value],
      ),
    ),
  );

  SSimpleStringLiteral str(String v) =>
      SSimpleStringLiteral(offset: next(), length: v.length, value: v);

  SBlock block(List<SStatement> statements) =>
      SBlock(offset: next(), length: 0, statements: statements);

  SVariableDeclarationStatement declareLog() => SVariableDeclarationStatement(
    offset: next(),
    length: 0,
    variables: SVariableDeclarationList(
      offset: next(),
      length: 0,
      variables: [
        SVariableDeclaration(
          offset: next(),
          length: 0,
          name: SSimpleIdentifier(offset: next(), length: 3, name: 'log'),
          initializer: SListLiteral(offset: next(), length: 0, elements: []),
        ),
      ],
    ),
  );

  SReturnStatement returnJoin() => SReturnStatement(
    offset: next(),
    length: 0,
    expression: SMethodInvocation(
      offset: next(),
      length: 0,
      target: SSimpleIdentifier(offset: next(), length: 3, name: 'log'),
      operator: '.',
      methodName: SSimpleIdentifier(offset: next(), length: 4, name: 'join'),
      argumentList: SArgumentList(
        offset: next(),
        length: 0,
        arguments: [str(',')],
      ),
    ),
  );

  AstBundle bundleOf(List<SStatement> statements) {
    const entryUri = 'package:t/main.dart';
    return AstBundle(
      entryPointUri: entryUri,
      modules: {
        entryUri: SCompilationUnit(
          offset: next(),
          length: 0,
          declarations: [
            SFunctionDeclaration(
              offset: next(),
              length: 0,
              name: SSimpleIdentifier(offset: next(), length: 4, name: 'main'),
              functionExpression: SFunctionExpression(
                offset: next(),
                length: 0,
                parameters: SFormalParameterList(offset: next(), length: 0),
                body: SBlockFunctionBody(
                  offset: next(),
                  length: 0,
                  block: block(statements),
                  isAsync: true,
                ),
              ),
            ),
          ],
        ),
      },
    );
  }

  group('SCE19/AST: a do body runs before its condition', () {
    test('F-SCE19-AST-1: a false condition still runs the body once '
        '[2026-09-18]', () async {
      // main() async { var log = []; do { log.add('x'); } while (false);
      //                return log.join(','); }
      final bundle = bundleOf([
        declareLog(),
        SDoStatement(
          offset: next(),
          length: 0,
          body: block([logAdd(str('x'))]),
          condition: SBooleanLiteral(offset: next(), length: 5, value: false),
        ),
        returnJoin(),
      ]);
      final result = await D4rtRunner().executeBundleAsAsync<String>(bundle);
      // '' is the pre-SCE19 answer: the condition decided before the body ran.
      expect(result, equals('x'));
    });

    test(
      'F-SCE19-AST-2: nested do loops each run their body [2026-09-18]',
      () async {
        final bundle = bundleOf([
          declareLog(),
          SDoStatement(
            offset: next(),
            length: 0,
            body: block([
              SDoStatement(
                offset: next(),
                length: 0,
                body: block([logAdd(str('i'))]),
                condition: SBooleanLiteral(
                  offset: next(),
                  length: 5,
                  value: false,
                ),
              ),
              logAdd(str('o')),
            ]),
            condition: SBooleanLiteral(offset: next(), length: 5, value: false),
          ),
          returnJoin(),
        ]);
        final result = await D4rtRunner().executeBundleAsAsync<String>(bundle);
        expect(result, equals('i,o'));
      },
    );

    test('F-SCE19-AST-3: a do inside a while runs its body every iteration '
        '[2026-09-18]', () async {
      // while (log.length < 2) { do { log.add('x'); } while (false); }
      //
      // The re-entry case. Without forgetting the started-mark when the loop
      // exits, the second pass finds it already "started", checks the false
      // condition and skips the body — so the while never terminates. If this
      // regresses it HANGS rather than failing, which is what the timeout is
      // for.
      final bundle = bundleOf([
        declareLog(),
        SWhileStatement(
          offset: next(),
          length: 0,
          condition: SBinaryExpression(
            offset: next(),
            length: 0,
            leftOperand: SPrefixedIdentifier(
              offset: next(),
              length: 0,
              prefix: SSimpleIdentifier(offset: next(), length: 3, name: 'log'),
              identifier: SSimpleIdentifier(
                offset: next(),
                length: 6,
                name: 'length',
              ),
            ),
            operator: '<',
            rightOperand: SIntegerLiteral(offset: next(), length: 1, value: 2),
          ),
          body: block([
            SDoStatement(
              offset: next(),
              length: 0,
              body: block([logAdd(str('x'))]),
              condition: SBooleanLiteral(
                offset: next(),
                length: 5,
                value: false,
              ),
            ),
          ]),
        ),
        returnJoin(),
      ]);
      final result = await D4rtRunner().executeBundleAsAsync<String>(bundle);
      expect(result, equals('x,x'));
    }, timeout: const Timeout(Duration(seconds: 20)));
  });
}
