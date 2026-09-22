/// SCE103 mirror coverage for `tom_d4rt_ast`, running against the WORKING TREE.
///
/// The script-level cases live in `tom_d4rt/test/sce103_typed_local_test.dart`.
/// `tom_d4rt_exec` resolves this package from pub.dev (DGUC6) and sce162 blocks
/// publishing, so a port there would measure an interpreter without this check.
/// These bundles are built from `SAstNode`s by hand, like
/// `sce19_do_while_first_body_run_test.dart`, so they need no parser.
///
/// WHAT IS PINNED. A typed local was the fourth and last binding site that
/// asked "does this value fit this written type" and never checked, after
/// SCC29's parameters, SCC18's typed patterns and SCD63's for-each variable.
/// `int x = 'two';` bound the String, and so did every later `x = 'two';`.
///
/// THE TWO CASES ARE THE TWO MOMENTS, which is the whole structural difference
/// from the other three sites: they check once and remember nothing, this one
/// has to carry the declared type from the declaration to every later write.
/// The control is what stops the check from being "reject everything".
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  var offset = 0;
  int next() => offset += 7;

  SSimpleIdentifier id(String n) =>
      SSimpleIdentifier(offset: next(), length: n.length, name: n);

  SNamedType named(String n) =>
      SNamedType(offset: next(), length: 0, name: id(n));

  /// `<type> <name> = <init>;`
  SVariableDeclarationStatement declare(
    String type,
    String name,
    SExpression init,
  ) => SVariableDeclarationStatement(
    offset: next(),
    length: 0,
    variables: SVariableDeclarationList(
      offset: next(),
      length: 0,
      type: named(type),
      variables: [
        SVariableDeclaration(
          offset: next(),
          length: 0,
          name: id(name),
          initializer: init,
        ),
      ],
    ),
  );

  /// `<type> <name>;` — SCE131: a declaration with NO initialiser.
  SVariableDeclarationStatement declareNoInit(String type, String name) =>
      SVariableDeclarationStatement(
        offset: next(),
        length: 0,
        variables: SVariableDeclarationList(
          offset: next(),
          length: 0,
          type: named(type),
          variables: [
            SVariableDeclaration(offset: next(), length: 0, name: id(name)),
          ],
        ),
      );

  /// `<name> = <value>;`
  SExpressionStatement assign(String name, SExpression value) =>
      SExpressionStatement(
        offset: next(),
        length: 0,
        expression: SAssignmentExpression(
          offset: next(),
          length: 0,
          leftHandSide: id(name),
          operator: '=',
          rightHandSide: value,
        ),
      );

  SReturnStatement returnName(String name) =>
      SReturnStatement(offset: next(), length: 0, expression: id(name));

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
                ),
              ),
            ),
          ],
        ),
      },
    );
  }

  SSimpleStringLiteral str(String v) =>
      SSimpleStringLiteral(offset: next(), length: v.length, value: v);
  SIntegerLiteral int_(int v) =>
      SIntegerLiteral(offset: next(), length: 1, value: v);

  Object? run(AstBundle bundle) => D4rtRunner().executeBundle(bundle);

  group('SCE103/AST: a typed local is checked', () {
    test('F-SCE103-AST-1: the declaration initialiser is checked '
        '[2026-09-22] (PASS)', () {
      // main() { int x = 'two'; return x; }
      expect(
        () => run(bundleOf([declare('int', 'x', str('two')), returnName('x')])),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'message',
            "type 'String' is not a subtype of type 'int' of 'x'",
          ),
        ),
      );
    });

    test('F-SCE103-AST-2: every later write is checked too [2026-09-22] '
        '(PASS)', () {
      // main() { int x = 0; x = 'two'; return x; }
      //
      // The declaration is correct here, so this case reaches the check only
      // through the type the declaration left behind — which is the half the
      // other three binding sites do not need.
      expect(
        () => run(
          bundleOf([
            declare('int', 'x', int_(0)),
            assign('x', str('two')),
            returnName('x'),
          ]),
        ),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'message',
            "type 'String' is not a subtype of type 'int' of 'x'",
          ),
        ),
      );
    });

    test('F-SCE103-AST-3 (control): a correct program is unaffected '
        '[2026-09-22] (PASS)', () {
      expect(
        run(
          bundleOf([
            declare('int', 'x', int_(1)),
            assign('x', int_(2)),
            returnName('x'),
          ]),
        ),
        2,
      );
      // An unannotated local admits anything, which is what keeps the check
      // from being a name comparison.
      expect(
        run(bundleOf([declare('var', 'v', str('two')), returnName('v')])),
        'two',
      );
    });
    test('F-SCE103-AST-4: an uninitialised declaration is not accused, and '
        'still records its type [2026-09-22] (PASS)', () {
      // sce131. The exemption and the half that keeps it from being a hole,
      // in one case because the pair is the claim: `int x;` must bind null
      // without complaint, and the write that eventually supplies the value
      // must still be checked against the type the declaration left behind.
      //
      // main() { int x; return x; }
      expect(
        run(bundleOf([declareNoInit('int', 'x'), returnName('x')])),
        isNull,
      );
      // main() { int x; x = 'two'; return x; }
      expect(
        () => run(
          bundleOf([
            declareNoInit('int', 'x'),
            assign('x', str('two')),
            returnName('x'),
          ]),
        ),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'message',
            "type 'String' is not a subtype of type 'int' of 'x'",
          ),
        ),
      );
    });
  });
}
