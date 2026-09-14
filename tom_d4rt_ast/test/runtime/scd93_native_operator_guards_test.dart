// SCD93/AST — a native operand reaches the SDK operator in the analyzer-free
// tree too.
//
// The mirror of `tom_d4rt/test/scd93_native_operator_guards_test.dart`, and
// deliberately much smaller. That file runs source, so it can spell eighteen
// cases across five guard families cheaply. This package cannot execute source
// at all — it interprets pre-parsed `SAstNode` trees — so every case here is a
// bundle built by hand.
//
// WHAT IS PINNED HERE IS THE CLAIM, NOT THE CATALOGUE: that the delegation is
// live in THIS interpreter — that the six bitwise arms and the six list-index
// guards hand their operands to the SDK rather than pre-empting it — and that
// the fast paths they front still work.
//
// The four cases are the minimum that cannot pass by accident:
//
//   -1 `1 & 2.0` is the SDK's TypeError   — the defect itself, in the family
//                                           with the most sites
//   -2 `6 & 3` is still 3                 — the fast arm the fallback fronts
//   -3 `[1][5]` is the SDK's RangeError,
//      worded `(length)`                  — the list guard, and the exact
//                                           wording only delegation produces
//   -4 `[7][0]` is still 7                — deleting a bounds test is only
//                                           safe if the read still lands
//
// A "throw TypeError whenever the operands disagree" shortcut passes -1 and
// fails -3. A guard corrected to raise `RangeError` by hand passes -1, -2 and
// -4 and fails -3, because `(length)` is what the SDK says and `(index)` is
// what every hand-written version of this said.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String name) =>
    SSimpleIdentifier(offset: 0, length: 0, name: name);

/// The bundle for `Object? main() => <expression>;`.
AstBundle exprBundle(SExpression expression) {
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
            name: _id('main'),
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
                expression: expression,
              ),
            ),
          ),
        ],
      ),
    },
  );
}

SExpression intLit(int v) => SIntegerLiteral(offset: 0, length: 0, value: v);
SExpression dblLit(double v) => SDoubleLiteral(offset: 0, length: 0, value: v);

SExpression binary(SExpression l, String op, SExpression r) =>
    SBinaryExpression(
      offset: 0,
      length: 0,
      leftOperand: l,
      operator: op,
      rightOperand: r,
    );

SExpression indexOf(List<SExpression> elements, SExpression index) =>
    SIndexExpression(
      offset: 0,
      length: 0,
      target: SListLiteral(offset: 0, length: 0, elements: elements),
      index: index,
    );

void main() {
  Object? run(SExpression e) =>
      D4rtRunner().executeBundleAs<Object?>(exprBundle(e));

  group('SCD93/AST: native operands reach the SDK operator', () {
    test('F-SCD93-AST-1: `1 & 2.0` raises the SDK TypeError '
        '[2026-09-14] (PASS)', () {
      // Before the sweep this arm threw `RuntimeD4rtException('Unsupported
      // binary operator "AMPERSAND"')` — a type no `on` clause can name,
      // naming the TokenType rather than the operator.
      expect(
        () => run(binary(intLit(1), '&', dblLit(2.0))),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'message',
            "type 'double' is not a subtype of type 'int' of 'other'",
          ),
        ),
      );
    });

    test('F-SCD93-AST-2: the fast arm the fallback fronts still works '
        '[2026-09-14] (PASS)', () {
      expect(run(binary(intLit(6), '&', intLit(3))), 2);
      expect(run(binary(intLit(1), '<<', intLit(3))), 8);
    });

    test('F-SCD93-AST-3: an out-of-range list read is the SDK RangeError, '
        'worded `(length)` [2026-09-14] (PASS)', () {
      // The deleted guard said `(index)`. Only handing the index to the SDK's
      // own `List.[]` produces `(length)`, so this assertion cannot be
      // satisfied by a corrected hand-written guard — which is the point of
      // asserting the whole sentence rather than the type.
      expect(
        () => run(indexOf([intLit(1)], intLit(5))),
        throwsA(
          isA<RangeError>().having(
            (e) => e.toString(),
            'message',
            'RangeError (length): Invalid value: Only valid value is 0: 5',
          ),
        ),
      );
    });

    test('F-SCD93-AST-4: indexing still lands on the element '
        '[2026-09-14] (PASS)', () {
      expect(run(indexOf([intLit(7), intLit(8)], intLit(1))), 8);
    });
  });
}
