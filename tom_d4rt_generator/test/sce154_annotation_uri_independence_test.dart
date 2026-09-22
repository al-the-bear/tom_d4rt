/// SCE154 — the proxy/relaxer scanner identifies a directive by NAME, not by
/// the library its annotation was declared in.
///
/// ## Why this is a property worth pinning
///
/// `tom_d4rt_ast/lib/src/runtime/generator/d4.dart` tells its consumers, in
/// the doc comment on `D4UserProxy`, to "extend this class (and apply
/// `@D4rtUserProxy`)". For as long as that comment existed the annotation was
/// declared only in `tom_d4rt`, so an analyzer-free bridge package could not
/// follow the instruction its own dependency gave it. SCE154 mirrored
/// `d4rt_user_proxy_annotation.dart` into the AST tree and exported it from
/// `runtime.dart`.
///
/// Mirroring the class is only half the fix, and it is the half that is
/// visible. The other half is this: the generator has to accept it. If
/// [UserProxyRelaxerScanner] resolved the annotation's library URI — the
/// obvious way to write such a scanner, and the way that would make a copy in
/// a second package invisible — the doc comment would stay just as
/// unfollowable, only less obviously so. Measured before mirroring: it matches
/// on `type.element.name` and `supertype?.element.name` and asks nothing about
/// where either came from.
///
/// ## What this file adds that `user_proxy_relaxer_scanner_test.dart` cannot
///
/// That file's fixture imports `package:tom_d4rt/d4rt.dart`, so every
/// directive the scanner had ever been tested against carried a REFERENCE
/// annotation. It passes identically whether the scanner is URI-blind or
/// hard-coded to that one URI, which makes it silent on exactly the question
/// the mirroring depends on.
///
/// The fixture here declares the annotations and marker bases locally. See its
/// own header for why that is a stronger claim than importing the AST
/// package's copy would be, and why the generator could not import it anyway.
/// Presence and shape of the mirrored copy are held by
/// `tom_d4rt/test/scd134_barrel_surface_parity_test.dart` (exported surface)
/// and `scd183` / `scd199` (bodies); this holds that the generator does not
/// care which package it came from.
library;

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:path/path.dart' as p;
import 'package:test/test.dart';
import 'package:tom_d4rt_generator/tom_d4rt_generator.dart';

String _fixturePath() => p.join(
  Directory.current.path,
  'test',
  'fixtures',
  'user_proxy_relaxer_foreign_source.dart',
);

void main() {
  group(
    'SCE154: directive discovery is independent of the annotation library',
    () {
      late UserProxyRelaxerScanner scanner;
      late List<String> warnings;

      setUpAll(() async {
        final fixture = _fixturePath();
        warnings = [];
        scanner = UserProxyRelaxerScanner(onWarning: warnings.add);

        final collection = AnalysisContextCollection(includedPaths: [fixture]);
        final context = collection.contextFor(fixture);
        final result = await context.currentSession.getResolvedLibrary(fixture);
        if (result is! ResolvedLibraryResult) {
          fail('Failed to resolve fixture (${result.runtimeType})');
        }
        scanner.scanLibrary(result.element, fixture);
      });

      test('F-SCE154-1: an annotation from an unrelated library is still a '
          'directive, parsed in full', () {
        expect(
          scanner.proxyDirectives,
          hasLength(1),
          reason:
              'the proxy directive carries a `@D4rtUserProxy` declared in the '
              'fixture itself. A scanner that resolved the annotation library '
              'would find nothing here, and an AST-line bridge package would '
              'hit the same wall',
        );
        expect(scanner.relaxerDirectives, hasLength(1));
        expect(warnings, isEmpty);

        final proxy = scanner.proxyDirectives.single;
        expect(proxy.kind, UserVariantKind.proxy);
        expect(proxy.baseClass, 'AstFormList');
        expect(proxy.libraryPath, 'package:ast_line_pkg/forms.dart');
        expect(proxy.directiveClassName, 'AstFormListUserProxy');
        expect(proxy.arity, 2);
        expect(proxy.renderInstantiations(const []), [
          'AstFormList<Customer, CustomerDetailForm>',
          'AstFormList<Order, OrderForm>',
        ]);

        // The wildcard path too, so this is not merely "the constructor was
        // read" — the whole directive pipeline runs on a foreign annotation.
        final relaxer = scanner.relaxerDirectives.single;
        expect(relaxer.hasPattern, isTrue);
        expect(
          relaxer.renderInstantiations(const ['CustomerDO', 'OrderDO', 'Nope']),
          [
            'AstFormList<CustomerDO, CustomerForm>',
            'AstFormList<OrderDO, OrderForm>',
          ],
        );

        expect(
          scanner.directiveClassNames,
          containsAll(<String>[
            'AstFormListUserProxy',
            'AstFormListUserRelaxer',
          ]),
          reason:
              'directive classes are excluded from normal bridge generation by '
              'name; a foreign-annotated one must be excluded too or the '
              'generator emits a bridge for the directive itself',
        );
      });

      test('F-SCE154-2 (control): the fixture really does import neither '
          'interpreter', () {
        final source = File(_fixturePath()).readAsStringSync();
        final imports = <String>[
          for (final line in source.split('\n'))
            if (line.trimLeft().startsWith('import ')) line.trim(),
        ];
        expect(
          imports,
          isEmpty,
          reason:
              'F-SCE154-1 asserts nothing once the fixture imports an '
              'interpreter — it silently becomes a second copy of G-UPS-1. This '
              'is what notices somebody "fixing" the fixture by adding the '
              "import its sibling has:\n  ${imports.join('\n  ')}",
        );
        expect(
          source.contains('class D4rtUserProxy'),
          isTrue,
          reason: 'the fixture must DECLARE the annotation, not merely name it',
        );
        expect(source.contains('class D4rtUserRelaxer'), isTrue);
      });
    },
  );
}
