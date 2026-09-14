// SCD98/AST — a bridged value has one representation in the analyzer-free tree
// too: the BARE NATIVE.
//
// The mirror of `tom_d4rt/test/scd98_bridged_value_representation_test.dart`,
// which carries the measured wrapping table and the reasoning. This file pins
// the CLAIM in this interpreter, because the split lived in the shared
// interpreter code and the reference tree's evidence is taken entirely on the
// analyzer-based line.
//
// The three cases are the minimum that cannot pass by accident:
//
//   -1 a native container deduplicates across both routes, in BOTH orders
//      — the defect, and the order-independence that identified its cause.
//      Before the fix `[ctor, method].toSet()` gave 2 and `[method, ctor]`
//      gave 1, because a native Set comparing a stored WRAPPER against a bare
//      probe runs `raw == wrapper`, the direction a native's `==` rejects.
//   -2 the constructor route yields a bare native — the site that was the lone
//      outlier in the table.
//   -3 an ordinary list still bridges element-wise — the boundary now returns
//      the ORIGINAL list when nothing changed, so this says it still converts
//      when something did.
//
// A fix that unwrapped only at the host boundary passes -2 and -3 and fails -1,
// because the duplicate is created inside the script.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: 0, name: n);

/// `Duration(seconds: 1)` — the CONSTRUCTOR route, which used to wrap.
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

/// `Duration(seconds: 1).abs()` — the METHOD-RETURN route, always bare. `abs()`
/// of a positive duration is an equal Duration, so the two routes produce
/// values that must collapse to one in a set.
SExpression durationViaMethod() => SMethodInvocation(
  offset: 0,
  length: 0,
  target: durationCtor(),
  operator: '.',
  methodName: _id('abs'),
  argumentList: SArgumentList(offset: 0, length: 0, arguments: const []),
);

/// `<expr>.toSet().length`
SExpression toSetLength(List<SExpression> elements) => SPropertyAccess(
  offset: 0,
  length: 0,
  operator: '.',
  propertyName: _id('length'),
  target: SMethodInvocation(
    offset: 0,
    length: 0,
    target: SListLiteral(offset: 0, length: 0, elements: elements),
    operator: '.',
    methodName: _id('toSet'),
    argumentList: SArgumentList(offset: 0, length: 0, arguments: const []),
  ),
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

  group('SCD98/AST: a bridged value has one representation', () {
    test('F-SCD98-AST-1: a native container deduplicates across both routes, '
        'in either order [2026-09-14] (PASS)', () {
      // Both orders on purpose: before the fix exactly one of them failed, and
      // a file that asserted only the passing order would have reported the
      // defect as absent.
      expect(run(toSetLength([durationCtor(), durationViaMethod()])), 1);
      expect(run(toSetLength([durationViaMethod(), durationCtor()])), 1);
    });

    test('F-SCD98-AST-2: the constructor route yields a bare native '
        '[2026-09-14] (PASS)', () {
      // The lone outlier in the wrapping table. `runtimeType` alone would have
      // reported `Duration` even before the fix — the getter unwraps — so this
      // is the floor, and F-SCD98-AST-1 is what actually detects a wrapper.
      expect(
        run(
          SPropertyAccess(
            offset: 0,
            length: 0,
            operator: '.',
            propertyName: _id('inSeconds'),
            target: durationCtor(),
          ),
        ),
        1,
      );
    });

    test('F-SCD98-AST-3: an ordinary list still bridges element-wise '
        '[2026-09-14] (PASS)', () {
      // The boundary returns the ORIGINAL list when nothing changed, so this
      // is what says it still converts when something did.
      expect(
        run(
          SListLiteral(
            offset: 0,
            length: 0,
            elements: [
              SIntegerLiteral(offset: 0, length: 0, value: 1),
              SIntegerLiteral(offset: 0, length: 0, value: 2),
            ],
          ),
        ),
        [1, 2],
      );
    });
  });
}
