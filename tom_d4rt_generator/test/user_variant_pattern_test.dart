// Unit tests for the @D4rtUserProxy / @D4rtUserRelaxer variant-pattern engine
// (cleanup_todos #27 / P&R #6, sub-steps a + c + d).
//
// Test IDs: G-UVP-N (Generator — User Variant Pattern).

import 'package:tom_d4rt_generator/src/user_variant_pattern.dart';
import 'package:test/test.dart';

void main() {
  group('WildcardPattern parsing (G-UVP-1..5)', () {
    test('G-UVP-1: leading "*" parses to an endsWith match', () {
      final p = WildcardPattern.parse('*DO');
      expect(p.kind, WildcardMatchKind.endsWith);
      expect(p.literal, 'DO');
    });

    test('G-UVP-2: trailing "*" parses to a startsWith match', () {
      final p = WildcardPattern.parse('Customer*');
      expect(p.kind, WildcardMatchKind.startsWith);
      expect(p.literal, 'Customer');
    });

    test('G-UVP-3: a bare "*" matches everything (empty literal, endsWith)', () {
      final p = WildcardPattern.parse('*');
      expect(p.kind, WildcardMatchKind.endsWith);
      expect(p.literal, '');
      expect(p.match('Anything')?.full, 'Anything');
      expect(p.match('Anything')?.captured, 'Anything');
    });

    test('G-UVP-4: missing "*" is rejected', () {
      expect(() => WildcardPattern.parse('Customer'),
          throwsA(isA<FormatException>()));
    });

    test('G-UVP-5: more than one "*" or a mid-slot "*" is rejected', () {
      expect(() => WildcardPattern.parse('*DO*'),
          throwsA(isA<FormatException>()));
      expect(() => WildcardPattern.parse('Cust*DO'),
          throwsA(isA<FormatException>()));
    });
  });

  group('WildcardPattern matching + \$0/\$1 capture (G-UVP-6..9)', () {
    test('G-UVP-6: endsWith match captures the prefix as \$1', () {
      final cap = WildcardPattern.parse('*DO').match('CustomerDO');
      expect(cap, isNotNull);
      expect(cap!.full, 'CustomerDO'); // $0
      expect(cap.captured, 'Customer'); // $1
    });

    test('G-UVP-7: startsWith match captures the suffix as \$1', () {
      final cap = WildcardPattern.parse('Customer*').match('CustomerForm');
      expect(cap!.full, 'CustomerForm');
      expect(cap.captured, 'Form');
    });

    test('G-UVP-8: a non-matching candidate yields null', () {
      expect(WildcardPattern.parse('*DO').match('CustomerForm'), isNull);
      expect(WildcardPattern.parse('Customer*').match('OrderDO'), isNull);
    });

    test('G-UVP-9: expandTemplate substitutes \$0 and \$1', () {
      final cap = const WildcardCapture(full: 'CustomerDO', captured: 'Customer');
      expect(cap.expandTemplate(r'$1Form'), 'CustomerForm');
      expect(cap.expandTemplate(r'$0Wrapper'), 'CustomerDOWrapper');
      expect(cap.expandTemplate(r'Map<$1, $0>'), 'Map<Customer, CustomerDO>');
      expect(cap.expandTemplate('RenderBox'), 'RenderBox'); // literal unchanged
    });
  });

  group('TypeArgVariantSpec — explicit variants (G-UVP-10..12)', () {
    test('G-UVP-10: single-slot explicit variant yields one literal tuple', () {
      final spec = TypeArgVariantSpec.parse('Customer');
      expect(spec.isPattern, isFalse);
      expect(spec.arity, 1);
      expect(spec.expand(const ['Ignored']), [
        ['Customer'],
      ]);
    });

    test('G-UVP-11: multi-slot explicit variant preserves slot order', () {
      final spec = TypeArgVariantSpec.parse('Customer, CustomerDetailForm');
      expect(spec.arity, 2);
      expect(spec.isPattern, isFalse);
      expect(spec.expand(const []), [
        ['Customer', 'CustomerDetailForm'],
      ]);
    });

    test('G-UVP-12: a \$-template with no wildcard slot is rejected', () {
      expect(() => TypeArgVariantSpec.parse(r'Customer, $1Form'),
          throwsA(isA<FormatException>()));
    });
  });

  group('TypeArgVariantSpec — pattern variants (G-UVP-13..17)', () {
    const candidates = [
      'CustomerDO',
      'OrderDO',
      'ProductDO',
      'CustomerForm', // not a *DO — must not match the driver
      'Unrelated',
    ];

    test('G-UVP-13: single-param pattern expands the driver to the full name',
        () {
      final spec = TypeArgVariantSpec.parse('*DO');
      expect(spec.isPattern, isTrue);
      expect(spec.driverIndex, 0);
      expect(spec.expand(candidates), [
        ['CustomerDO'],
        ['OrderDO'],
        ['ProductDO'],
      ]);
    });

    test('G-UVP-14: two-param pattern derives the second slot from \$1', () {
      final spec = TypeArgVariantSpec.parse(r'*DO, $1Form');
      expect(spec.arity, 2);
      expect(spec.driverIndex, 0);
      expect(spec.expand(candidates), [
        ['CustomerDO', 'CustomerForm'],
        ['OrderDO', 'OrderForm'],
        ['ProductDO', 'ProductForm'],
      ]);
    });

    test('G-UVP-15: the wildcard slot may sit in a non-first position', () {
      final spec = TypeArgVariantSpec.parse(r'$1Form, *DO');
      expect(spec.driverIndex, 1);
      expect(spec.expand(const ['CustomerDO', 'OrderDO']), [
        ['CustomerForm', 'CustomerDO'],
        ['OrderForm', 'OrderDO'],
      ]);
    });

    test('G-UVP-16: literal slots in a pattern variant stay constant', () {
      final spec = TypeArgVariantSpec.parse(r'*DO, RenderBox, $1Form');
      expect(spec.expand(const ['CustomerDO']), [
        ['CustomerDO', 'RenderBox', 'CustomerForm'],
      ]);
    });

    test('G-UVP-17: a startsWith driver with a \$1 suffix template', () {
      final spec = TypeArgVariantSpec.parse(r'Tom*, $1Model');
      expect(spec.expand(const ['TomCustomer', 'TomOrder', 'Other']), [
        ['TomCustomer', 'CustomerModel'],
        ['TomOrder', 'OrderModel'],
      ]);
    });
  });

  group('TypeArgVariantSpec — malformed rejection (G-UVP-18..20)', () {
    test('G-UVP-18: more than one wildcard slot is rejected', () {
      expect(() => TypeArgVariantSpec.parse('*DO, *Form'),
          throwsA(isA<FormatException>()));
    });

    test('G-UVP-19: an empty slot is rejected', () {
      expect(() => TypeArgVariantSpec.parse('Customer, '),
          throwsA(isA<FormatException>()));
      expect(() => TypeArgVariantSpec.fromSlots(const []),
          throwsA(isA<FormatException>()));
    });

    test('G-UVP-20: a malformed driver pattern propagates the FormatException',
        () {
      expect(() => TypeArgVariantSpec.parse('Cust*DO, RenderBox'),
          throwsA(isA<FormatException>()));
    });
  });

  group('expandUserVariants — multi-spec aggregation (G-UVP-21..24)', () {
    const candidates = ['CustomerDO', 'OrderDO'];

    test('G-UVP-21: explicit + pattern specs are concatenated in order', () {
      final specs = [
        TypeArgVariantSpec.parse('Legacy, LegacyForm'),
        TypeArgVariantSpec.parse(r'*DO, $1Form'),
      ];
      expect(expandUserVariants(specs, candidates), [
        ['Legacy', 'LegacyForm'],
        ['CustomerDO', 'CustomerForm'],
        ['OrderDO', 'OrderForm'],
      ]);
    });

    test('G-UVP-22: duplicate tuples are de-duplicated, first-seen order kept',
        () {
      final specs = [
        TypeArgVariantSpec.parse('CustomerDO, CustomerForm'),
        TypeArgVariantSpec.parse(r'*DO, $1Form'), // re-emits CustomerDO tuple
      ];
      expect(expandUserVariants(specs, candidates), [
        ['CustomerDO', 'CustomerForm'],
        ['OrderDO', 'OrderForm'],
      ]);
    });

    test('G-UVP-23: mismatched arity across specs is rejected', () {
      final specs = [
        TypeArgVariantSpec.parse('Customer'),
        TypeArgVariantSpec.parse('Order, OrderForm'),
      ];
      expect(() => expandUserVariants(specs, candidates),
          throwsA(isA<ArgumentError>()));
    });

    test('G-UVP-24: an empty spec list yields an empty result', () {
      expect(expandUserVariants(const [], candidates), isEmpty);
    });
  });
}
