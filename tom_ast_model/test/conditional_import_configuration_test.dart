// SCE49: conditional import/export branches must survive the mirror AST.
//
// `SImportDirective` used to carry `uri`, `prefix`, `combinators`, `isDeferred`
// and `metadata` — and no `configurations`. `SExportDirective` was the same. So
// `import 'stub.dart' if (dart.library.io) 'io.dart';` survived the copy as
// `import 'stub.dart';`: the branch was not reported, not warned about, and not
// recorded anywhere, leaving every consumer downstream looking at a well-formed
// import of the default URI with no way to learn a branch had been discarded.
//
// `SConfiguration` (with `SDottedName` for its condition) is that missing node.
// These tests pin what a consumer reads back out — the tested name, the
// optional `== '...'` value, and the branch URI — and pin all three surviving a
// round-trip through `SAstNodeFactory`, which is where a node type that was
// never REGISTERED disappears: `listFromJson` filters on the element type, so
// an unregistered `Configuration` deserialises to the unknown-node placeholder
// and is dropped from the list without an error.
//
// The conditions are PRESERVED, not evaluated. Which branch applies depends on
// the target platform, which this model does not know.

import 'package:test/test.dart';
import 'package:tom_ast_model/ast.dart';

SStringLiteral _str(String value) =>
    SSimpleStringLiteral(offset: 0, length: value.length + 2, value: value);

SDottedName _dotted(String name) => SDottedName(
  offset: 0,
  length: name.length,
  components: [
    for (final part in name.split('.'))
      SSimpleIdentifier(offset: 0, length: part.length, name: part),
  ],
);

/// Builds `import 'stub.dart' if (dart.library.io) 'io.dart' if
/// (dart.library.html == 'true') 'web.dart';`.
SImportDirective conditionalImport() => SImportDirective(
  offset: 0,
  length: 96,
  uri: _str('stub.dart'),
  configurations: [
    SConfiguration(
      offset: 20,
      length: 34,
      name: _dotted('dart.library.io'),
      uri: _str('io.dart'),
    ),
    SConfiguration(
      offset: 55,
      length: 41,
      name: _dotted('dart.library.html'),
      value: _str('true'),
      uri: _str('web.dart'),
    ),
  ],
);

T _roundTrip<T extends SAstNode>(T node) =>
    SAstNodeFactory.fromJson(node.toJson()) as T;

void main() {
  group('SCE49: import configurations', () {
    test('F-SCE49-1: every branch of a conditional import survives the round '
        'trip [2026-09-18] (PASS)', () {
      final restored = _roundTrip(conditionalImport());

      expect(restored.uri!.stringValue, 'stub.dart');
      expect(restored.configurations, hasLength(2));
      expect(restored.configurations.map((c) => c.name!.name), [
        'dart.library.io',
        'dart.library.html',
      ]);
      expect(restored.configurations.map((c) => c.uri!.stringValue), [
        'io.dart',
        'web.dart',
      ]);
    });

    test('F-SCE49-2: the optional `== value` test is distinguished from its '
        'absence [2026-09-18] (PASS)', () {
      final restored = _roundTrip(conditionalImport());

      expect(restored.configurations[0].value, isNull);
      expect(restored.configurations[1].value!.stringValue, 'true');
    });

    test(
      'F-SCE49-3: a conditional import is structurally equal to itself after '
      'a JSON round trip [2026-09-18] (PASS)',
      () {
        final log = <String>[];
        expect(
          conditionalImport().equals(_roundTrip(conditionalImport()), log),
          isTrue,
          reason: log.join('\n'),
        );
      },
    );

    test('F-SCE49-4: two imports differing only in a branch URI are not equal '
        '[2026-09-18] (PASS)', () {
      // Without `configurations` in `toJson` these two serialise identically,
      // which is exactly the silence this todo is about.
      final other = SImportDirective(
        offset: 0,
        length: 96,
        uri: _str('stub.dart'),
        configurations: [
          SConfiguration(
            offset: 20,
            length: 34,
            name: _dotted('dart.library.io'),
            uri: _str('OTHER.dart'),
          ),
          conditionalImport().configurations[1],
        ],
      );

      expect(conditionalImport().equals(other), isFalse);
    });

    test('F-SCE49-5: configurations reach a visitor [2026-09-18] (PASS)', () {
      final seen = <String>[];
      conditionalImport().visitChildren(_CollectingVisitor(seen));

      expect(seen, contains('Configuration'));
    });
  });

  group('SCE49: export configurations', () {
    test('F-SCE49-6: every branch of a conditional export survives the round '
        'trip [2026-09-18] (PASS)', () {
      final restored = _roundTrip(
        SExportDirective(
          offset: 0,
          length: 60,
          uri: _str('stub.dart'),
          configurations: [
            SConfiguration(
              offset: 20,
              length: 34,
              name: _dotted('dart.library.io'),
              uri: _str('io.dart'),
            ),
          ],
        ),
      );

      expect(restored.configurations, hasLength(1));
      expect(restored.configurations.single.name!.name, 'dart.library.io');
      expect(restored.configurations.single.uri!.stringValue, 'io.dart');
    });
  });

  group('SCE49: dotted names', () {
    test('F-SCE49-7: a dotted name keeps its components and joins them back '
        '[2026-09-18] (PASS)', () {
      final restored = _roundTrip(_dotted('dart.library.io'));

      expect(restored.components.map((c) => c.name), ['dart', 'library', 'io']);
      expect(restored.name, 'dart.library.io');
    });
  });
}

class _CollectingVisitor extends SAstVisitor<void> {
  _CollectingVisitor(this.seen);

  final List<String> seen;

  @override
  void visitNode(SAstNode node) => seen.add(node.nodeType);
}
