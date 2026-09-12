// SCD62/AST — `is` honours the nullable `?` suffix in the analyzer-free tree.
//
// The mirror of `tom_d4rt/test/scd62_nullable_is_test.dart`, and deliberately
// much smaller. That file runs source, so it can pin ten operator cases and
// three pattern contexts cheaply. This package cannot execute source at all —
// it interprets pre-parsed `SAstNode` trees — so every case here is a bundle
// built by hand, and each one costs a dozen lines.
//
// WHAT IS PINNED HERE IS THE CLAIM, NOT THE CATALOGUE: that the fix is live in
// THIS interpreter, in both directions. `_valueHasType` is one predicate and
// the pattern contexts reach it through the same call, so a mirror that proves
// the predicate answers correctly proves the rest by construction — where the
// reference tree's value is that it demonstrates the pattern paths for real.
//
// The three cases are the minimum that cannot pass by accident: a nullable
// type must accept null, the SAME type without the suffix must reject it, and
// `Object?` must accept it. A fix of "return true when the value is null"
// passes the first and third and fails the second.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// `Object? main() => null is <typeName>[?];`
AstBundle isNullBundle(String typeName, {required bool nullable}) {
  const entry = 'package:probe/main.dart';
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
              body: SExpressionFunctionBody(
                offset: 0,
                length: 0,
                expression: SIsExpression(
                  offset: 0,
                  length: 0,
                  expression: SNullLiteral(offset: 0, length: 0),
                  type: SNamedType(
                    offset: 0,
                    length: 0,
                    name: SSimpleIdentifier(
                      offset: 0,
                      length: 0,
                      name: typeName,
                    ),
                    isNullable: nullable,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    },
  );
}

void main() {
  Object? run(String typeName, {required bool nullable}) => D4rtRunner()
      .executeBundleAs<Object?>(isNullBundle(typeName, nullable: nullable));

  group('SCD62/AST: the nullable suffix on `is`', () {
    test(
      'F-SCD62-AST-1: null satisfies a nullable type [2026-09-12] (PASS)',
      () {
        expect(run('String', nullable: true), isTrue);
        expect(run('int', nullable: true), isTrue);
      },
    );

    test('F-SCD62-AST-2: null still fails the same type without the suffix '
        '[2026-09-12] (PASS)', () {
      // The half that separates the fix from "answer true whenever the value
      // is null", which would pass -1 and -3 and be wrong.
      expect(run('String', nullable: false), isFalse);
      expect(run('int', nullable: false), isFalse);
    });

    test('F-SCD62-AST-3: `Object?` accepts null and `Object` does not '
        '[2026-09-12] (PASS)', () {
      // `null is Object?` is the case with no correct false answer.
      expect(run('Object', nullable: true), isTrue);
      expect(run('Object', nullable: false), isFalse);
    });
  });
}
