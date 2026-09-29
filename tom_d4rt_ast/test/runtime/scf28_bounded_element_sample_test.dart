// SCF28/AST — the analyzer-free twin of
// `tom_d4rt/test/scf28_bounded_element_sample_test.dart`.
//
// The element-type derivation behind SCD92's type-argument check reads
// `Environment.elementTypeSample` elements instead of all of them. The READ
// COUNT is pinned in the reference file with a counting host list;
// `_homogeneousElementType` is held body-identical across the two trees by
// SCD199, so this file pins the one answer the bound changes and one it must
// not, on this tree's own interpreter (DGUC6).

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

import 'scd92_applied_parameter_type_test.dart'
    show appliedParameterBundle, intLit, strLit;

void main() {
  Object? run(String? typeArgument, List<SExpression> elements) =>
      D4rtRunner().executeBundleAs<Object?>(
        appliedParameterBundle(typeArgument: typeArgument, elements: elements),
      );

  final eightInts = [for (var i = 1; i <= 8; i++) intLit(i)];

  group('SCF28/AST: the element-type derivation reads a bounded prefix', () {
    test('F-SCF28-AST-1: the sample is 8 [2026-09-29] (PASS)', () {
      expect(Environment.elementTypeSample, 8);
    });

    test('F-SCF28-AST-2: a disagreement only AFTER the prefix is checked '
        'against the prefix [2026-09-29] (PASS)', () {
      expect(
        () => run('String', [...eightInts, strLit('late')]),
        throwsA(isA<TypeError>()),
      );
    });

    test('F-SCF28-AST-3: a disagreement WITHIN the prefix still passes as '
        'heterogeneous [2026-09-29] (PASS)', () {
      expect(run('String', [intLit(1), strLit('a')]), [1, 'a']);
    });
  });
}
