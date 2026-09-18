/// SCE20 mirror coverage for `tom_d4rt_ast`, running against the WORKING TREE.
///
/// The script-level reproductions live in
/// `tom_d4rt/test/sce20_braceless_if_else_test.dart`. `tom_d4rt_exec` resolves
/// this package from pub.dev (DGUC6) and sce162 blocks publishing, so a port
/// there would measure an interpreter without this fix. These bundles are built
/// from `SAstNode`s by hand, like
/// `scc40_per_await_site_resumption_test.dart`, so they need no parser.
///
/// WHAT IS PINNED. `_findNextSequentialNode` returned null for the end of a
/// BRACELESS `then` branch whenever an `else` was present — "there is no next
/// sequential node after the then if there is an else". There is: the else is
/// the branch not taken, and control resumes after the if. Null stopped the
/// state machine, so the function completed with whatever it had last
/// evaluated. Braced branches end at the block-end case instead and were never
/// affected, which is why this survived: almost all Dart is braced.
///
/// The loop case is the one worth having by hand. There a wrong value became NO
/// value: the loop never advanced and the function answered null.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  var offset = 0;
  int next() => offset += 7;

  SSimpleIdentifier id(String name) =>
      SSimpleIdentifier(offset: next(), length: name.length, name: name);

  SSimpleStringLiteral str(String v) =>
      SSimpleStringLiteral(offset: next(), length: v.length, value: v);

  /// `log.add(<value>);` as a single (braceless-capable) statement.
  SExpressionStatement logAdd(String value) => SExpressionStatement(
    offset: next(),
    length: 0,
    expression: SMethodInvocation(
      offset: next(),
      length: 0,
      target: id('log'),
      operator: '.',
      methodName: id('add'),
      argumentList: SArgumentList(
        offset: next(),
        length: 0,
        arguments: [str(value)],
      ),
    ),
  );

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
          name: id('log'),
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
      target: id('log'),
      operator: '.',
      methodName: id('join'),
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
              name: id('main'),
              functionExpression: SFunctionExpression(
                offset: next(),
                length: 0,
                parameters: SFormalParameterList(offset: next(), length: 0),
                body: SBlockFunctionBody(
                  offset: next(),
                  length: 0,
                  block: SBlock(
                    offset: next(),
                    length: 0,
                    statements: statements,
                  ),
                  isAsync: true,
                ),
              ),
            ),
          ],
        ),
      },
    );
  }

  group('SCE20/AST: a braceless then with an else continues after the if', () {
    test(
      'F-SCE20-AST-1: the statement after the if still runs [2026-09-18]',
      () async {
        // main() async {
        //   var log = [];
        //   if (true) log.add('t'); else log.add('e');
        //   log.add('after');
        //   return log.join(',');
        // }
        final bundle = bundleOf([
          declareLog(),
          SIfStatement(
            offset: next(),
            length: 0,
            condition: SBooleanLiteral(offset: next(), length: 4, value: true),
            thenStatement: logAdd('t'),
            elseStatement: logAdd('e'),
          ),
          logAdd('after'),
          returnJoin(),
        ]);
        final result = await D4rtRunner().executeBundleAsAsync<String>(bundle);
        // Pre-SCE20 this answered 't' — the machine stopped at the end of the
        // then branch and the function completed with the last value evaluated.
        expect(result, equals('t,after'));
      },
    );

    test(
      'F-SCE20-AST-2: the else branch was always fine [2026-09-18]',
      () async {
        // The half that was RIGHT. The fix makes the two halves identical, so
        // this is what says which one moved if they ever diverge again.
        final bundle = bundleOf([
          declareLog(),
          SIfStatement(
            offset: next(),
            length: 0,
            condition: SBooleanLiteral(offset: next(), length: 5, value: false),
            thenStatement: logAdd('t'),
            elseStatement: logAdd('e'),
          ),
          logAdd('after'),
          returnJoin(),
        ]);
        final result = await D4rtRunner().executeBundleAsAsync<String>(bundle);
        expect(result, equals('e,after'));
      },
    );

    test('F-SCE20-AST-3: a braceless if/else in a loop body returns to the '
        'loop [2026-09-18]', () async {
      // while (log.length < 2) { if (true) log.add('a'); else log.add('b'); }
      //
      // Here a wrong value became NO value: the loop never advanced. If this
      // regresses it HANGS rather than failing — hence the timeout — because
      // the while condition never becomes false.
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
              prefix: id('log'),
              identifier: id('length'),
            ),
            operator: '<',
            rightOperand: SIntegerLiteral(offset: next(), length: 1, value: 2),
          ),
          body: SBlock(
            offset: next(),
            length: 0,
            statements: [
              SIfStatement(
                offset: next(),
                length: 0,
                condition: SBooleanLiteral(
                  offset: next(),
                  length: 4,
                  value: true,
                ),
                thenStatement: logAdd('a'),
                elseStatement: logAdd('b'),
              ),
            ],
          ),
        ),
        returnJoin(),
      ]);
      final result = await D4rtRunner().executeBundleAsAsync<String>(bundle);
      expect(result, equals('a,a'));
    }, timeout: const Timeout(Duration(seconds: 20)));
  });
}
