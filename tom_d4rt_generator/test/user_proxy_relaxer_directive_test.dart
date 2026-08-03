/// Pure (analyzer-free) tests for the annotation-driven proxy/relaxer directive
/// core.
///
/// These pin the new multi-type-parameter + wildcard-pattern *expansion-to-
/// source* logic in [UserVariantDirective] and
/// [renderUserVariantInstantiationBlock], independently of the analyzer
/// element-walker (which is exercised in `user_proxy_relaxer_scanner_test.dart`).
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

UserVariantDirective directive({
  UserVariantKind kind = UserVariantKind.relaxer,
  String baseClass = 'TomFormList',
  required List<String> variants,
}) =>
    UserVariantDirective.parse(
      kind: kind,
      libraryPath: 'package:my_pkg/forms.dart',
      baseClass: baseClass,
      variants: variants,
      directiveClassName: '${baseClass}UserDirective',
      sourceFile: 'lib/src/d4rt_user_relaxers/forms.dart',
    );

void main() {
  group('UserVariantDirective.parse', () {
    test('G-UPR-1: explicit single-param variant parses with arity 1', () {
      final d = directive(baseClass: 'ValueNotifier', variants: ['Color']);
      expect(d.arity, 1);
      expect(d.hasPattern, isFalse);
      expect(d.variantSpecs, hasLength(1));
    });

    test('G-UPR-2: explicit multi-param variants parse with arity 2', () {
      final d = directive(variants: [
        'Customer, CustomerDetailForm',
        'Order, OrderForm',
      ]);
      expect(d.arity, 2);
      expect(d.hasPattern, isFalse);
      expect(d.variantSpecs, hasLength(2));
    });

    test('G-UPR-3: wildcard-pattern variant is flagged as pattern-driven', () {
      final d = directive(variants: [r'*DO, $1Form']);
      expect(d.arity, 2);
      expect(d.hasPattern, isTrue);
    });

    test('G-UPR-4: empty variants → arity 0, no patterns', () {
      final d = directive(baseClass: 'Box', variants: const []);
      expect(d.arity, 0);
      expect(d.hasPattern, isFalse);
    });

    test('G-UPR-5: mismatched arity across variants throws ArgumentError', () {
      expect(
        () => directive(variants: ['Customer, CustomerForm', 'Order']),
        throwsArgumentError,
      );
    });

    test('G-UPR-6: malformed pattern (>1 wildcard) throws FormatException', () {
      expect(
        () => directive(variants: [r'*DO*, $1Form']),
        throwsFormatException,
      );
    });

    test('G-UPR-7: \$0/\$1 template with no wildcard slot throws', () {
      expect(
        () => directive(variants: [r'Customer, $1Form']),
        throwsFormatException,
      );
    });
  });

  group('UserVariantDirective.expand', () {
    test('G-UPR-8: explicit multi-param variants ignore candidates', () {
      final d = directive(variants: [
        'Customer, CustomerDetailForm',
        'Order, OrderForm',
      ]);
      final tuples = d.expand(const ['Anything', 'Else']);
      expect(tuples, [
        ['Customer', 'CustomerDetailForm'],
        ['Order', 'OrderForm'],
      ]);
    });

    test('G-UPR-9: wildcard pattern expands per matching candidate', () {
      final d = directive(variants: [r'*DO, $1Form']);
      final tuples = d.expand(const ['CustomerDO', 'OrderDO', 'NotMatching']);
      expect(tuples, [
        ['CustomerDO', 'CustomerForm'],
        ['OrderDO', 'OrderForm'],
      ]);
    });

    test('G-UPR-10: \$0 resolves to the full matched name', () {
      final d = directive(variants: [r'*DO, $0View']);
      final tuples = d.expand(const ['CustomerDO']);
      expect(tuples, [
        ['CustomerDO', 'CustomerDOView'],
      ]);
    });

    test('G-UPR-11: explicit + pattern variants de-duplicate, order kept', () {
      final d = directive(variants: [
        'CustomerDO, CustomerForm',
        r'*DO, $1Form',
      ]);
      final tuples = d.expand(const ['CustomerDO', 'OrderDO']);
      // The explicit tuple appears first and is not duplicated by the pattern.
      expect(tuples, [
        ['CustomerDO', 'CustomerForm'],
        ['OrderDO', 'OrderForm'],
      ]);
    });
  });

  group('UserVariantDirective.renderInstantiations', () {
    test('G-UPR-12: renders multi-param concrete generic instantiations', () {
      final d = directive(variants: ['Customer, CustomerDetailForm']);
      expect(
        d.renderInstantiations(const []),
        ['TomFormList<Customer, CustomerDetailForm>'],
      );
    });

    test('G-UPR-13: wildcard pattern renders one instantiation per match', () {
      final d = directive(variants: [r'*DO, $1Form']);
      expect(
        d.renderInstantiations(const ['CustomerDO', 'OrderDO', 'Nope']),
        [
          'TomFormList<CustomerDO, CustomerForm>',
          'TomFormList<OrderDO, OrderForm>',
        ],
      );
    });

    test('G-UPR-14: single-param relaxer renders <V> instantiation', () {
      final d = directive(baseClass: 'ValueNotifier', variants: ['Color']);
      expect(d.renderInstantiations(const []), ['ValueNotifier<Color>']);
    });
  });

  group('renderUserVariantInstantiationBlock golden', () {
    test('G-UPR-15: golden block groups directives with kind/base headers', () {
      final directives = [
        directive(
          kind: UserVariantKind.proxy,
          variants: ['Customer, CustomerDetailForm', 'Order, OrderForm'],
        ),
        directive(
          kind: UserVariantKind.relaxer,
          baseClass: 'TomFormList',
          variants: [r'*DO, $1Form'],
        ),
      ];
      final block = renderUserVariantInstantiationBlock(
        directives,
        const ['CustomerDO', 'OrderDO'],
      );
      expect(block, '''
// proxy TomFormList
//   TomFormList<Customer, CustomerDetailForm>
//   TomFormList<Order, OrderForm>
// relaxer TomFormList
//   TomFormList<CustomerDO, CustomerForm>
//   TomFormList<OrderDO, OrderForm>
''');
    });

    test('G-UPR-16: directive with no matching candidates is noted', () {
      final block = renderUserVariantInstantiationBlock(
        [directive(variants: [r'*DO, $1Form'])],
        const ['NoMatch'],
      );
      expect(block, '''
// relaxer TomFormList
//   (no matching candidates)
''');
    });
  });
}
