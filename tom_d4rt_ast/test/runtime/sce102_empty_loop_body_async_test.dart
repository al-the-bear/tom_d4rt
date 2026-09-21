/// SCE102 mirror coverage for `tom_d4rt_ast`, running against the WORKING TREE.
///
/// The script-level reproductions live in
/// `tom_d4rt/test/sce102_empty_loop_body_async_test.dart`. `tom_d4rt_exec`
/// resolves this package from pub.dev (DGUC6) and sce162 blocks publishing, so
/// a port there would measure an interpreter without this fix. These bundles
/// are built from `SAstNode`s by hand, like
/// `sce19_do_while_first_body_run_test.dart`, so they need no parser.
///
/// WHAT IS PINNED. The async state machine entered a loop body by taking the
/// body's first statement; for `{}` that is null, and the machine's own loop is
/// `while (currentNode != null)`, so the FUNCTION ended there. Everything after
/// the loop was skipped and the return value was whatever `lastResult` held —
/// null after a for-in, the CONDITION after the two forms that had just
/// evaluated one.
///
/// THE THREE FORMS HERE ARE THE THREE THAT FAILED DIFFERENTLY: a for-in
/// returned null, a C-style `for` returned `true`, and a `while` returned null.
/// A do-while was already correct — SCE19 fixed that entry, and its fallback is
/// the pattern the other five sites were made to match — so the reference file
/// keeps it as a control and it is not repeated here.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  var offset = 0;
  int next() => offset += 7;

  SSimpleStringLiteral str(String v) =>
      SSimpleStringLiteral(offset: next(), length: v.length, value: v);

  SIntegerLiteral int_(int v) =>
      SIntegerLiteral(offset: next(), length: 1, value: v);

  SSimpleIdentifier id(String n) =>
      SSimpleIdentifier(offset: next(), length: n.length, name: n);

  SBlock block(List<SStatement> statements) =>
      SBlock(offset: next(), length: 0, statements: statements);

  /// `log.add(<value>);`
  SExpressionStatement logAdd(SExpression value) => SExpressionStatement(
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
        arguments: [value],
      ),
    ),
  );

  /// `var log = [];`
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

  /// `return log.join(',');`
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

  /// `for (final x in [1, 2]) <body>`
  SForStatement forIn(SStatement body) => SForStatement(
    offset: next(),
    length: 0,
    forLoopParts: SForEachPartsWithDeclaration(
      offset: next(),
      length: 0,
      loopVariable: SDeclaredIdentifier(
        offset: next(),
        length: 0,
        identifier: id('x'),
        isFinal: true,
      ),
      iterable: SListLiteral(
        offset: next(),
        length: 0,
        elements: [int_(1), int_(2)],
      ),
    ),
    body: body,
  );

  /// `for (var i = 0; i < 2; i = i + 1) <body>`
  SForStatement cStyleFor(SStatement body) => SForStatement(
    offset: next(),
    length: 0,
    forLoopParts: SForPartsWithDeclarations(
      offset: next(),
      length: 0,
      variables: SVariableDeclarationList(
        offset: next(),
        length: 0,
        variables: [
          SVariableDeclaration(
            offset: next(),
            length: 0,
            name: id('i'),
            initializer: int_(0),
          ),
        ],
      ),
      condition: SBinaryExpression(
        offset: next(),
        length: 0,
        leftOperand: id('i'),
        operator: '<',
        rightOperand: int_(2),
      ),
      updaters: [
        SAssignmentExpression(
          offset: next(),
          length: 0,
          leftHandSide: id('i'),
          operator: '=',
          rightHandSide: SBinaryExpression(
            offset: next(),
            length: 0,
            leftOperand: id('i'),
            operator: '+',
            rightOperand: int_(1),
          ),
        ),
      ],
    ),
    body: body,
  );

  /// `var j = 0; while (j < 2) <body>` — the declaration is returned beside it.
  (SVariableDeclarationStatement, SWhileStatement) whileLoop(SStatement body) {
    final declare = SVariableDeclarationStatement(
      offset: next(),
      length: 0,
      variables: SVariableDeclarationList(
        offset: next(),
        length: 0,
        variables: [
          SVariableDeclaration(
            offset: next(),
            length: 0,
            name: id('j'),
            initializer: int_(0),
          ),
        ],
      ),
    );
    // `j = j + 1` lives in the CONDITION so the body can stay empty and the
    // loop still terminate — an empty body with a constant condition would
    // hang, which is correct behaviour and a useless test.
    final loop = SWhileStatement(
      offset: next(),
      length: 0,
      condition: SBinaryExpression(
        offset: next(),
        length: 0,
        leftOperand: SAssignmentExpression(
          offset: next(),
          length: 0,
          leftHandSide: id('j'),
          operator: '=',
          rightHandSide: SBinaryExpression(
            offset: next(),
            length: 0,
            leftOperand: id('j'),
            operator: '+',
            rightOperand: int_(1),
          ),
        ),
        operator: '<',
        rightOperand: int_(3),
      ),
      body: body,
    );
    return (declare, loop);
  }

  Future<String?> runAsync(AstBundle bundle) =>
      D4rtRunner().executeBundleAsAsync<String>(bundle);

  group('SCE102/AST: an empty loop body does not end the function', () {
    test(
      'F-SCE102-AST-1: a for-in with an empty body [2026-09-22] (PASS)',
      () async {
        // main() async { var log = []; for (final x in [1,2]) {}
        //                log.add('ran'); return log.join(','); }
        final result = await runAsync(
          bundleOf([
            declareLog(),
            forIn(block([])),
            logAdd(str('ran')),
            returnJoin(),
          ]),
        );
        // null is the pre-fix answer: the function ended at the empty body.
        expect(result, equals('ran'));
      },
    );

    test('F-SCE102-AST-2: a C-style for with an empty body [2026-09-22] '
        '(PASS)', () async {
      final result = await runAsync(
        bundleOf([
          declareLog(),
          cStyleFor(block([])),
          logAdd(str('ran')),
          returnJoin(),
        ]),
      );
      // `true` — the condition just evaluated — is the pre-fix answer here,
      // which is why the reference file pins the three forms separately.
      expect(result, equals('ran'));
    });

    test(
      'F-SCE102-AST-3: a while with an empty body [2026-09-22] (PASS)',
      () async {
        final (declare, loop) = whileLoop(block([]));
        final result = await runAsync(
          bundleOf([
            declareLog(),
            declare,
            loop,
            logAdd(str('ran')),
            returnJoin(),
          ]),
        );
        expect(result, equals('ran'));
      },
    );

    test('F-SCE102-AST-4 (control): a non-empty body was always correct '
        '[2026-09-22] (PASS)', () async {
      // The defect is the empty-block dispatch alone. A fix that routed every
      // body through the loop node would lose these.
      final result = await runAsync(
        bundleOf([
          declareLog(),
          forIn(block([logAdd(str('in'))])),
          logAdd(str('ran')),
          returnJoin(),
        ]),
      );
      expect(result, equals('in,in,ran'));
    });
  });
}
