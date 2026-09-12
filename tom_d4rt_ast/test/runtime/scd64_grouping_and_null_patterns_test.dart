// SCD64/AST — the three pattern kinds `_matchAndBind` had no branch for, in
// the analyzer-free tree.
//
// The mirror of `tom_d4rt/test/scd64_grouping_and_null_patterns_test.dart`,
// and deliberately much smaller. That file runs source, so it can put three
// pattern kinds through six contexts and re-run the whole audit as a control
// cheaply. This package cannot execute source at all — it interprets
// pre-parsed `SAstNode` trees — so every case here is a bundle built by hand.
//
// WHAT IS PINNED HERE IS THE CLAIM, NOT THE CATALOGUE: that all three branches
// are live in THIS interpreter, and that the two null patterns answer
// OPPOSITELY for null. Those four cases are the minimum that cannot pass by
// accident:
//
//   -1  `(int _)` matches an int and not a String   — grouping recurses
//   -2  `int n?` with null MISSES, quietly           — no throw
//   -3  `int n!` with null THROWS a TypeError        — cannot select an arm
//   -4  the same `int n!` with a non-null matches    — it is not "always throw"
//
// A branch that treated `p!` as a match failure passes -1, -2 and -4 and fails
// only -3 — which is exactly the mistake worth a test, because it turns a
// program that should stop into one that quietly takes `default`. And the
// exception TYPE is what decides that: arm selection catches
// `PatternMatchD4rtException` and nothing else.
//
// `tom_ast_generator` already emits all three nodes (verified while closing
// SCD64), so the analyzer-free line is complete end to end rather than
// complete only in the interpreter.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// The bundle for `Object? main()` whose body is a switch over [scrutinee]
/// with one `case` arm carrying [pattern] and returning `'HIT'`, and a
/// `default` arm returning `'miss'`.
AstBundle switchBundle({
  required SDartPattern pattern,
  required SExpression scrutinee,
}) {
  const entry = 'package:probe/main.dart';
  SReturnStatement ret(String v) => SReturnStatement(
    offset: 0,
    length: 0,
    expression: SSimpleStringLiteral(offset: 0, length: 0, value: v),
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
                        SSwitchPatternCase(
                          offset: 0,
                          length: 0,
                          guardedPattern: SGuardedPattern(
                            offset: 0,
                            length: 0,
                            pattern: pattern,
                          ),
                          statements: [ret('HIT')],
                        ),
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

/// `int _`
SDartPattern typedWildcard(String type) =>
    SWildcardPattern(offset: 0, length: 0, name: '_', type: namedType(type));

/// `int n`
SDartPattern typedVariable(String type) => SDeclaredVariablePattern(
  offset: 0,
  length: 0,
  name: 'n',
  type: namedType(type),
);

void main() {
  Object? run(SDartPattern pattern, SExpression scrutinee) =>
      D4rtRunner().executeBundleAs<Object?>(
        switchBundle(pattern: pattern, scrutinee: scrutinee),
      );

  final intOne = SIntegerLiteral(offset: 0, length: 0, value: 1);
  final strS = SSimpleStringLiteral(offset: 0, length: 0, value: 's');
  final nullLit = SNullLiteral(offset: 0, length: 0);

  group('SCD64/AST: grouping and null patterns', () {
    test('F-SCD64-AST-1: `(p)` matches exactly what `p` matches '
        '[2026-09-12] (PASS)', () {
      SDartPattern paren(SDartPattern inner) =>
          SParenthesizedPattern(offset: 0, length: 0, pattern: inner);
      expect(run(paren(typedWildcard('int')), intOne), 'HIT');
      expect(run(paren(typedWildcard('int')), strS), 'miss');
      // Nesting changes nothing: the branch recurses rather than unwrapping
      // one level and stopping.
      expect(run(paren(paren(typedWildcard('int'))), intOne), 'HIT');
    });

    test('F-SCD64-AST-2: `p?` misses on null, quietly [2026-09-12] (PASS)', () {
      SDartPattern check() => SNullCheckPattern(
        offset: 0,
        length: 0,
        pattern: typedVariable('int'),
        operator: '?',
      );
      expect(run(check(), intOne), 'HIT');
      expect(run(check(), nullLit), 'miss');
      expect(run(check(), strS), 'miss');
    });

    test('F-SCD64-AST-3: `p!` throws on null instead of selecting another arm '
        '[2026-09-12] (PASS)', () {
      expect(
        () => run(
          SNullAssertPattern(
            offset: 0,
            length: 0,
            pattern: typedVariable('int'),
            operator: '!',
          ),
          nullLit,
        ),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'message',
            'Null check operator used on a null value',
          ),
        ),
      );
    });

    test('F-SCD64-AST-4: `p!` is not "always throw" [2026-09-12] (PASS)', () {
      SDartPattern assertP() => SNullAssertPattern(
        offset: 0,
        length: 0,
        pattern: typedVariable('int'),
        operator: '!',
      );
      // The same pattern over a non-null value matches…
      expect(run(assertP(), intOne), 'HIT');
      // …and a non-null value of the wrong type still MISSES rather than
      // throwing: only the null case is an error.
      expect(run(assertP(), strS), 'miss');
    });
  });
}
