// SCD99/AST — `runtimeType` names the bridged type here too, and the answer is
// usable in a comparison.
//
// The mirror of `tom_d4rt/test/scd99_runtimetype_reporting_test.dart`, which
// carries the measurement and the reasoning. The defect lived in shared
// interpreter code (`visitBinaryExpression`), so the reference tree's evidence
// says nothing about the analyzer-free line on its own.
//
// The three cases are the minimum that cannot pass by accident:
//
//   -1 `Duration(seconds: 1).runtimeType == Duration` is TRUE — the defect. It
//      was false, because `toBridgedInstance` succeeds on a `Type` object, so
//      the bridged-operator dispatch invoked an `==` adapter on the WRAPPER and
//      never reached the Type-vs-BridgedClass reconciliation below it.
//   -2 `runtimeType.toString()` is `'Duration'` — the symptom the todo reported,
//      which was already correct. It is the floor: a fix that made the
//      comparison true by breaking the name would pass -1 and fail this.
//   -3 equality on an ordinary receiver still works — the hoist runs BEFORE the
//      bridged dispatch, so this is what says it does not intercept anything it
//      should not.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: 0, name: n);

/// `Duration(seconds: 1)`
SExpression durationCtor() => SMethodInvocation(
  offset: 0,
  length: 0,
  methodName: _id('Duration'),
  argumentList: SArgumentList(
    offset: 0,
    length: 0,
    arguments: [
      SNamedExpression(
        offset: 0,
        length: 0,
        name: SLabel(offset: 0, length: 0, label: _id('seconds')),
        expression: SIntegerLiteral(offset: 0, length: 0, value: 1),
      ),
    ],
  ),
);

SExpression propertyOf(SExpression target, String name) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(name),
);

SExpression callOn(SExpression target, String name) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  methodName: _id(name),
  argumentList: SArgumentList(offset: 0, length: 0, arguments: const []),
);

SExpression binary(SExpression l, String op, SExpression r) =>
    SBinaryExpression(
      offset: 0,
      length: 0,
      leftOperand: l,
      operator: op,
      rightOperand: r,
    );

/// The bundle for `Object? main() => <expression>;`
AstBundle bundleOf(SExpression expression) {
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

void main() {
  Object? run(SExpression e) =>
      D4rtRunner().executeBundleAs<Object?>(bundleOf(e));

  group('SCD99/AST: runtimeType names the bridged type', () {
    test('F-SCD99-AST-1: runtimeType compares equal to the type literal '
        '[2026-09-14] (PASS)', () {
      // `Duration(seconds: 1).runtimeType == Duration`. Was false here too.
      expect(
        run(
          binary(
            propertyOf(durationCtor(), 'runtimeType'),
            '==',
            _id('Duration'),
          ),
        ),
        isTrue,
      );
      // And the reverse order, which already worked — asserted so a
      // regression that only restores one direction cannot pass.
      expect(
        run(
          binary(
            _id('Duration'),
            '==',
            propertyOf(durationCtor(), 'runtimeType'),
          ),
        ),
        isTrue,
      );
    });

    test('F-SCD99-AST-2: and it still READS as the native type '
        '[2026-09-14] (PASS)', () {
      // The symptom the todo reported, which was already correct. The floor: a
      // fix that made -1 true by breaking the name would fail here.
      expect(
        run(callOn(propertyOf(durationCtor(), 'runtimeType'), 'toString')),
        'Duration',
      );
    });

    test('F-SCD99-AST-3: equality on an ordinary receiver is unaffected '
        '[2026-09-14] (PASS)', () {
      // The reconciliation is hoisted ABOVE the bridged-operator dispatch, so
      // this says it does not intercept comparisons that are none of its
      // business.
      expect(
        run(
          binary(
            SIntegerLiteral(offset: 0, length: 0, value: 1),
            '==',
            SIntegerLiteral(offset: 0, length: 0, value: 1),
          ),
        ),
        isTrue,
      );
      expect(
        run(
          binary(
            SSimpleStringLiteral(offset: 0, length: 0, value: 'a'),
            '==',
            SSimpleStringLiteral(offset: 0, length: 0, value: 'b'),
          ),
        ),
        isFalse,
      );
    });
  });
}
