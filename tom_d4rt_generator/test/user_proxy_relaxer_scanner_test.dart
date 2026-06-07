/// Resolution-based tests for the annotation-driven proxy/relaxer element-walker
/// (P&R #6, sub-step b).
///
/// These resolve the `user_proxy_relaxer_source.dart` fixture to a real
/// [LibraryElement] — exactly as `_preScanUserBridges` does in `bridge_api.dart`
/// — and assert that [UserProxyRelaxerScanner] discovers the `@D4rtUserProxy` /
/// `@D4rtUserRelaxer` directives with the correct fields. The analyzer-free
/// parse/expand/render core is exercised separately in
/// `user_proxy_relaxer_directive_test.dart`.
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

void main() {
  group('UserProxyRelaxerScanner (P&R#6)', () {
    late UserProxyRelaxerScanner scanner;
    late List<String> warnings;

    setUpAll(() async {
      final fixture = p.join(
        Directory.current.path,
        'test',
        'fixtures',
        'user_proxy_relaxer_source.dart',
      );

      warnings = [];
      scanner = UserProxyRelaxerScanner(onWarning: warnings.add);

      final collection = AnalysisContextCollection(
        includedPaths: [fixture],
      );
      final context = collection.contextFor(fixture);
      final result =
          await context.currentSession.getResolvedLibrary(fixture);
      if (result is! ResolvedLibraryResult) {
        fail('Failed to resolve fixture (${result.runtimeType})');
      }
      scanner.scanLibrary(result.element, fixture);
    });

    test('G-UPS-1: discovers both proxy directives and relaxers', () {
      expect(scanner.proxyDirectives, hasLength(1));
      expect(scanner.relaxerDirectives, hasLength(2));
    });

    test('G-UPS-2: explicit multi-param proxy parses with arity 2', () {
      final proxy = scanner.proxyDirectives.single;
      expect(proxy.kind, UserVariantKind.proxy);
      expect(proxy.baseClass, 'TomFormList');
      expect(proxy.libraryPath, 'package:my_pkg/forms.dart');
      expect(proxy.directiveClassName, 'TomFormListUserProxy');
      expect(proxy.arity, 2);
      expect(proxy.hasPattern, isFalse);
      expect(proxy.renderInstantiations(const []), [
        'TomFormList<Customer, CustomerDetailForm>',
        'TomFormList<Order, OrderForm>',
      ]);
    });

    test('G-UPS-3: wildcard-pattern relaxer expands against candidates', () {
      final relaxer = scanner.relaxerDirectives.firstWhere(
        (d) => d.baseClass == 'TomFormList',
      );
      expect(relaxer.kind, UserVariantKind.relaxer);
      expect(relaxer.hasPattern, isTrue);
      expect(relaxer.arity, 2);
      expect(
        relaxer.renderInstantiations(const ['CustomerDO', 'OrderDO', 'Nope']),
        [
          'TomFormList<CustomerDO, CustomerForm>',
          'TomFormList<OrderDO, OrderForm>',
        ],
      );
    });

    test('G-UPS-4: single-param relaxer parses with arity 1', () {
      final relaxer = scanner.relaxerDirectives.firstWhere(
        (d) => d.baseClass == 'ValueNotifier',
      );
      expect(relaxer.arity, 1);
      expect(relaxer.hasPattern, isFalse);
      expect(relaxer.renderInstantiations(const []), ['ValueNotifier<Color>']);
    });

    test('G-UPS-5: every marker-base class is recorded for exclusion', () {
      expect(scanner.shouldExcludeClass('TomFormListUserProxy'), isTrue);
      expect(scanner.shouldExcludeClass('TomFormListUserRelaxer'), isTrue);
      expect(scanner.shouldExcludeClass('ValueNotifierUserRelaxer'), isTrue);
      expect(scanner.shouldExcludeClass('UnannotatedUserProxy'), isTrue);
      expect(scanner.shouldExcludeClass('NotADirective'), isFalse);
    });

    test('G-UPS-6: un-annotated marker-base class warns and is skipped', () {
      expect(
        warnings.any((w) => w.contains('UnannotatedUserProxy')),
        isTrue,
        reason: 'should warn about the marker-base class with no annotation',
      );
      expect(
        scanner.proxyDirectives
            .any((d) => d.directiveClassName == 'UnannotatedUserProxy'),
        isFalse,
      );
    });

    test('G-UPS-7: directiveClassNames lists every proxy + relaxer class', () {
      expect(scanner.directiveClassNames, {
        'TomFormListUserProxy',
        'TomFormListUserRelaxer',
        'ValueNotifierUserRelaxer',
        'UnannotatedUserProxy',
      });
    });
  });
}
