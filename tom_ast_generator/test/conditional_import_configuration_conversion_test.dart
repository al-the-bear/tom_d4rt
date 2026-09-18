// SCE49: conditional import/export branches must survive the analyzer →
// mirror-AST conversion.
//
// `_convertImportDirective` read `uri`, `prefix`, `combinators` and
// `deferredKeyword`, and never `node.configurations` — because the mirror had
// no field to put them in. `_convertExportDirective` was the same. So
//
//     import 'stub.dart' if (dart.library.io) 'io.dart';
//
// reached every consumer as `import 'stub.dart';`: a well-formed import of the
// default URI, with nothing anywhere recording that a branch had been
// discarded. Conditional imports are the standard Dart mechanism for VM-vs-web
// divergence, so the symptom surfaces on one platform, far from the cause.
//
// These tests go through [parseSource], which round-trips the tree through
// JSON — so they pin conversion AND serialisation in one step. A branch that
// converts but does not serialise is just as lost.
//
// The conditions are copied, not evaluated: which branch applies depends on the
// target platform, which this converter does not know.

import 'package:test/test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart';

import 'test_helpers.dart';

SImportDirective importOf(String source) =>
    parseSource(source).directives.whereType<SImportDirective>().single;

SExportDirective exportOf(String source) =>
    parseSource(source).directives.whereType<SExportDirective>().single;

void main() {
  group('SCE49: import configuration conversion', () {
    test('F-SCE49-GEN-1: a conditional branch survives with its condition and '
        'its URI [2026-09-18] (PASS)', () {
      final directive = importOf('''
import 'stub.dart' if (dart.library.io) 'io.dart';
''');

      expect(directive.uri!.stringValue, 'stub.dart');
      expect(directive.configurations, hasLength(1));
      expect(directive.configurations.single.name!.name, 'dart.library.io');
      expect(directive.configurations.single.uri!.stringValue, 'io.dart');
    });

    test(
      'F-SCE49-GEN-2: several branches survive, in source order [2026-09-18] '
      '(PASS)',
      () {
        final directive = importOf('''
import 'stub.dart'
    if (dart.library.io) 'io.dart'
    if (dart.library.js_interop) 'web.dart';
''');

        expect(directive.configurations.map((c) => c.name!.name), [
          'dart.library.io',
          'dart.library.js_interop',
        ]);
        expect(directive.configurations.map((c) => c.uri!.stringValue), [
          'io.dart',
          'web.dart',
        ]);
      },
    );

    test(
      'F-SCE49-GEN-3: an explicit `== value` test is kept, and its absence is '
      'kept as absent [2026-09-18] (PASS)',
      () {
        final directive = importOf('''
import 'stub.dart'
    if (dart.library.io) 'io.dart'
    if (dart.library.io == 'false') 'other.dart';
''');

        expect(directive.configurations[0].value, isNull);
        expect(directive.configurations[1].value!.stringValue, 'false');
      },
    );

    test('F-SCE49-GEN-4: configurations coexist with a prefix, `deferred` and '
        'combinators [2026-09-18] (PASS)', () {
      final directive = importOf('''
import 'stub.dart'
    if (dart.library.io) 'io.dart'
    deferred as impl show Foo hide Bar;
''');

      expect(directive.configurations, hasLength(1));
      expect(directive.prefix!.name, 'impl');
      expect(directive.isDeferred, isTrue);
      expect(directive.combinators, hasLength(2));
    });

    test(
      'F-SCE49-GEN-5: an unconditional import converts to an empty list, not '
      'a null [2026-09-18] (PASS)',
      () {
        expect(importOf("import 'a.dart';").configurations, isEmpty);
      },
    );
  });

  group('SCE49: export configuration conversion', () {
    test('F-SCE49-GEN-6: a conditional export branch survives [2026-09-18] '
        '(PASS)', () {
      final directive = exportOf('''
export 'stub.dart' if (dart.library.io) 'io.dart' show Foo;
''');

      expect(directive.configurations, hasLength(1));
      expect(directive.configurations.single.name!.name, 'dart.library.io');
      expect(directive.configurations.single.uri!.stringValue, 'io.dart');
      expect(directive.combinators, hasLength(1));
    });
  });

  group('SCE49: the dispatch chain', () {
    test(
      'F-SCE49-GEN-7: a Configuration is converted by its own converter, not '
      'dropped into the unknown-node placeholder [2026-09-18] (PASS)',
      () {
        // `_nodesAs<SConfiguration>` filters on the element type, so a node
        // type missing from the `convert()` dispatch chain deserialises to the
        // opaque placeholder and is silently dropped from the list — which is
        // exactly how DGUB8 lost every record-type field.
        final configuration = importOf('''
import 'stub.dart' if (dart.library.io) 'io.dart';
''').configurations.single;

        expect(configuration.nodeType, 'Configuration');
        expect(configuration.name!.nodeType, 'DottedName');
        expect(configuration.name!.components.map((c) => c.name), [
          'dart',
          'library',
          'io',
        ]);
      },
    );
  });
}
