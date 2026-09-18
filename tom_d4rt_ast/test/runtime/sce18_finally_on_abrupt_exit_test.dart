/// SCE18 mirror coverage for `tom_d4rt_ast`, running against the WORKING TREE.
///
/// The script-level reproductions live in
/// `tom_d4rt/test/sce18_finally_on_abrupt_exit_test.dart`. `tom_d4rt_exec`
/// resolves this package from pub.dev (DGUC6) and sce162 blocks publishing, so
/// a port there would measure an interpreter without this fix. These bundles
/// are built from `SAstNode`s by hand, like
/// `scc40_per_await_site_resumption_test.dart`, so they need no parser.
///
/// WHAT IS PINNED. A `return` inside a `try` with a non-empty `finally` used to
/// be dropped when anything followed the try: the finally ran and the machine
/// carried on with the next statement, whose value won. Worse in the nested
/// case, where a statement BETWEEN the inner try and an outer finally also ran.
/// A function that is unwinding must execute nothing but the finally blocks
/// between the return and the function boundary.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  var offset = 0;
  int next() => offset += 7;

  /// `log.add('<value>');` as a statement node.
  SExpressionStatement logAdd(String value) => SExpressionStatement(
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
        arguments: [
          SSimpleStringLiteral(
            offset: next(),
            length: value.length,
            value: value,
          ),
        ],
      ),
    ),
  );

  SReturnStatement returns(SExpression value) =>
      SReturnStatement(offset: next(), length: 0, expression: value);

  SSimpleStringLiteral str(String v) =>
      SSimpleStringLiteral(offset: next(), length: v.length, value: v);

  SBlock block(List<SStatement> statements) =>
      SBlock(offset: next(), length: 0, statements: statements);

  /// `var log = <String>[];` as a statement node.
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

  /// `log.join(',')` as an expression node.
  SMethodInvocation logJoin() => SMethodInvocation(
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
  );

  AstBundle bundleOf(List<SStatement> statements) {
    const entryUri = 'package:t/main.dart';
    final mainFn = SFunctionDeclaration(
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

  group('SCE18/AST: a return unwinds through the finallys it crosses', () {
    test('F-SCE18-AST-1: a return before a trailing statement survives '
        '[2026-09-18]', () async {
      // main() async {
      //   var log = []; try { return 'r'; } finally { log.add('f'); }
      //   return 'end';
      // }
      final bundle = bundleOf([
        declareLog(),
        STryStatement(
          offset: next(),
          length: 0,
          body: block([returns(str('r'))]),
          finallyBlock: block([logAdd('f')]),
        ),
        returns(str('end')),
      ]);
      final result = await D4rtRunner().executeBundleAsAsync<String>(bundle);
      // 'end' is the pre-SCE18 answer: the return recorded, the finally run,
      // and then the statement after the try winning.
      expect(result, equals('r'));
    });

    test('F-SCE18-AST-2: a statement between the inner try and the outer '
        'finally is skipped [2026-09-18]', () async {
      // The case that makes this an unwind rather than a lost value: 'MID'
      // must not run, and both finallys must.
      final bundle = bundleOf([
        declareLog(),
        STryStatement(
          offset: next(),
          length: 0,
          body: block([
            STryStatement(
              offset: next(),
              length: 0,
              body: block([returns(str('x'))]),
              finallyBlock: block([logAdd('A')]),
            ),
            logAdd('MID'),
          ]),
          finallyBlock: block([logAdd('B')]),
        ),
        returns(logJoin()),
      ]);
      final result = await D4rtRunner().executeBundleAsAsync<String>(bundle);
      expect(result, equals('x'));
    });

    test('F-SCE18-AST-3: an ordinary try/finally with no return is unaffected '
        '[2026-09-18]', () async {
      // Without this, a fix that simply stopped the machine whenever a finally
      // ended would pass the two cases above and break every other try.
      final bundle = bundleOf([
        declareLog(),
        STryStatement(
          offset: next(),
          length: 0,
          body: block([logAdd('t')]),
          finallyBlock: block([logAdd('f')]),
        ),
        logAdd('after'),
        returns(logJoin()),
      ]);
      final result = await D4rtRunner().executeBundleAsAsync<String>(bundle);
      expect(result, equals('t,f,after'));
    });
  });
}
