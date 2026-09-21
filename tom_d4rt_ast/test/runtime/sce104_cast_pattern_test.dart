/// SCE104 mirror coverage for `tom_d4rt_ast`, running against the WORKING TREE.
///
/// The script-level cases live in `tom_d4rt/test/sce104_cast_pattern_test.dart`.
/// `tom_d4rt_exec` resolves this package from pub.dev (DGUC6) and sce162 blocks
/// publishing, so a port there would measure an interpreter without this fix.
/// These bundles are built from `SAstNode`s by hand, like
/// `scd64_grouping_and_null_patterns_test.dart`, whose helpers this follows.
///
/// WHAT IS PINNED. `case var x as T` raised `PatternMatchD4rtException` when the
/// cast failed, and every arm-selection site catches exactly that and reads it
/// as "this arm did not match" — so a program that should stop took `default`.
///
/// THE THREE CASES ARE THE MINIMUM THAT CANNOT PASS BY ACCIDENT: a failing cast
/// must throw, a SUCCEEDING one must still select its arm, and the throw must
/// not be swallowed by a later arm that would have matched. A fix of "make the
/// cast pattern never match" passes the first and third and fails the second;
/// the pre-fix code fails the first and third and passes the second.
///
/// The reference file carries the rest — the eight-row agreement table between
/// the cast pattern and the cast expression, the `int`→`double` promotion the
/// bound value now carries, type aliases, and the script-class permissiveness
/// that is deliberately unchanged.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// `Object? main()` switching over [scrutinee] with one `case <pattern>:` arm
/// returning `'HIT'`, an optional second arm returning `'later'`, and a
/// `default` returning `'miss'`.
AstBundle switchBundle({
  required SDartPattern pattern,
  required SExpression scrutinee,
  SDartPattern? secondArm,
}) {
  const entry = 'package:probe/main.dart';
  SReturnStatement ret(String v) => SReturnStatement(
    offset: 0,
    length: 0,
    expression: SSimpleStringLiteral(offset: 0, length: 0, value: v),
  );
  SSwitchPatternCase arm(SDartPattern p, String value) => SSwitchPatternCase(
    offset: 0,
    length: 0,
    guardedPattern: SGuardedPattern(offset: 0, length: 0, pattern: p),
    statements: [ret(value)],
  );

  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: const [],
        declarations: [
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: SSimpleIdentifier(offset: 0, length: 0, name: 'main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: SFormalParameterList(
                offset: 0,
                length: 0,
                parameters: const [],
              ),
              body: SBlockFunctionBody(
                offset: 0,
                length: 0,
                block: SBlock(
                  offset: 0,
                  length: 0,
                  statements: [
                    SSwitchStatement(
                      offset: 0,
                      length: 0,
                      expression: scrutinee,
                      members: [
                        arm(pattern, 'HIT'),
                        if (secondArm != null) arm(secondArm, 'later'),
                        SSwitchDefault(
                          offset: 0,
                          length: 0,
                          statements: [ret('miss')],
                        ),
                      ],
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

SNamedType namedType(String name) => SNamedType(
  offset: 0,
  length: 0,
  name: SSimpleIdentifier(offset: 0, length: 0, name: name),
);

/// `var n as <type>`
SDartPattern castPattern(String type) => SCastPattern(
  offset: 0,
  length: 0,
  type: namedType(type),
  pattern: SDeclaredVariablePattern(offset: 0, length: 0, name: 'n'),
);

/// `<type> _`
SDartPattern typedWildcard(String type) =>
    SWildcardPattern(offset: 0, length: 0, name: '_', type: namedType(type));

void main() {
  Object? run(
    SDartPattern pattern,
    SExpression scrutinee, {
    SDartPattern? secondArm,
  }) => D4rtRunner().executeBundleAs<Object?>(
    switchBundle(pattern: pattern, scrutinee: scrutinee, secondArm: secondArm),
  );

  final intOne = SIntegerLiteral(offset: 0, length: 0, value: 1);
  final strS = SSimpleStringLiteral(offset: 0, length: 0, value: 's');

  Matcher throwsCastError(String from, String to) => throwsA(
    isA<TypeError>().having(
      (e) => e.toString(),
      'message',
      "type '$from' is not a subtype of type '$to' in type cast",
    ),
  );

  group('SCE104/AST: a failing cast pattern throws', () {
    test('F-SCE104-AST-1: the failure is a TypeError, not a missed arm '
        '[2026-09-22] (PASS)', () {
      expect(
        () => run(castPattern('int'), strS),
        throwsCastError('String', 'int'),
      );
    });

    test('F-SCE104-AST-2 (control): a succeeding cast still selects its arm '
        '[2026-09-22] (PASS)', () {
      // The rail. "Never match" satisfies -1 and -3 and fails this.
      expect(run(castPattern('int'), intOne), 'HIT');
    });

    test('F-SCE104-AST-3: the throw is not caught by arm selection '
        '[2026-09-22] (PASS)', () {
      // The sharpest form: a LATER arm that would have matched. While the
      // failure was a `PatternMatchD4rtException` this returned 'later' and
      // nothing looked wrong.
      expect(
        () => run(castPattern('int'), strS, secondArm: typedWildcard('String')),
        throwsCastError('String', 'int'),
      );
    });
  });
}
