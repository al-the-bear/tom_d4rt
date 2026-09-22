/// SCE109 mirror coverage for `tom_d4rt_ast`, running against the WORKING TREE.
///
/// The script-level cases live in `tom_d4rt/test/sce109_sdk_error_types_test.dart`.
/// `tom_d4rt_exec` resolves this package from pub.dev (DGUC6) and sce162 blocks
/// publishing, so a port there would measure an interpreter without this fix.
/// These bundles are built from `SAstNode`s by hand, like
/// `sce19_do_while_first_body_run_test.dart`.
///
/// WHAT IS PINNED. Two adapters reported a runtime condition of the SCRIPT with
/// an interpreter exception rather than the SDK's Error, and
/// `RuntimeD4rtException` is not an `Error` at all — so `on RangeError` and
/// `on StateError` were skipped and the script fell through to a bare `catch`.
///
/// THE CATCH IS THE PROPERTY, so every case here runs a real `on <SdkError>`
/// clause inside the interpreted program rather than asserting a type on the
/// host side. A host-side matcher sees the exception object and would report a
/// type the interpreted `on` clause still fails to select, which is exactly the
/// distinction the defect turned on.
///
/// THE TWO CASES ARE THE TWO CAUSES, and they are unrelated: `elementAt` had no
/// guard and was rewritten at the DISPATCH boundary by SCB28's arity heuristic,
/// while `firstWhere` was a hand-rolled loop with an invented contract. The
/// third case is the rail — a fix of "throw StateError from everything"
/// satisfies the first two and fails it.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  var offset = 0;
  int next() => offset += 7;

  SSimpleIdentifier id(String n) =>
      SSimpleIdentifier(offset: next(), length: n.length, name: n);
  SSimpleStringLiteral str(String v) =>
      SSimpleStringLiteral(offset: next(), length: v.length, value: v);
  SIntegerLiteral int_(int v) =>
      SIntegerLiteral(offset: next(), length: 1, value: v);
  SBlock block(List<SStatement> statements) =>
      SBlock(offset: next(), length: 0, statements: statements);
  SReturnStatement ret(String v) =>
      SReturnStatement(offset: next(), length: 0, expression: str(v));

  /// `<target>.<method>(<args>)` as a statement.
  SExpressionStatement call(
    SExpression target,
    String method,
    List<SExpression> args,
  ) => SExpressionStatement(
    offset: next(),
    length: 0,
    expression: SMethodInvocation(
      offset: next(),
      length: 0,
      target: target,
      operator: '.',
      methodName: id(method),
      argumentList: SArgumentList(offset: next(), length: 0, arguments: args),
    ),
  );

  /// `Object? main() { try { <body> } on <error> { return 'caught'; }
  ///                  catch (e) { return 'fell through'; } return 'no throw'; }`
  AstBundle catchBundle(SStatement body, String error) {
    const entry = 'package:probe/main.dart';
    return AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: next(),
          length: 0,
          directives: const [],
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
                  block: block([
                    STryStatement(
                      offset: next(),
                      length: 0,
                      body: block([body]),
                      catchClauses: [
                        SCatchClause(
                          offset: next(),
                          length: 0,
                          exceptionType: SNamedType(
                            offset: next(),
                            length: 0,
                            name: id(error),
                          ),
                          body: block([ret('caught')]),
                        ),
                        SCatchClause(
                          offset: next(),
                          length: 0,
                          exceptionParameter: id('e'),
                          body: block([ret('fell through')]),
                        ),
                      ],
                    ),
                    ret('no throw'),
                  ]),
                ),
              ),
            ),
          ],
        ),
      },
    );
  }

  SExpression oneElementList() =>
      SListLiteral(offset: next(), length: 0, elements: [int_(1)]);

  String? run(SStatement body, String error) =>
      D4rtRunner().executeBundleAs<String>(catchBundle(body, error));

  group('SCE109/AST: a runtime condition raises the SDK Error', () {
    test('F-SCE109-AST-1: an out-of-range elementAt is caught by '
        '`on RangeError` [2026-09-22] (PASS)', () {
      // SCB28's heuristic restated this as an arity failure AND changed its
      // type, so the clause did not select and the answer was 'fell through'.
      expect(
        run(call(oneElementList(), 'elementAt', [int_(5)]), 'RangeError'),
        'caught',
      );
    });

    test('F-SCE109-AST-2: a firstWhere with no match is caught by '
        '`on StateError` [2026-09-22] (PASS)', () {
      // `(e) => e == 9` over `[1]`.
      final test9 = SFunctionExpression(
        offset: next(),
        length: 0,
        parameters: SFormalParameterList(
          offset: next(),
          length: 0,
          parameters: [
            SSimpleFormalParameter(offset: next(), length: 0, name: id('e')),
          ],
        ),
        body: SExpressionFunctionBody(
          offset: next(),
          length: 0,
          expression: SBinaryExpression(
            offset: next(),
            length: 0,
            leftOperand: id('e'),
            operator: '==',
            rightOperand: int_(9),
          ),
        ),
      );
      expect(
        run(call(oneElementList(), 'firstWhere', [test9]), 'StateError'),
        'caught',
      );
    });

    test('F-SCE109-AST-3 (control): a correct call still returns '
        '[2026-09-22] (PASS)', () {
      // The rail. "Throw StateError from everything" passes -1 and -2 and
      // fails this.
      expect(
        run(call(oneElementList(), 'elementAt', [int_(0)]), 'RangeError'),
        'no throw',
      );
    });
  });
}
