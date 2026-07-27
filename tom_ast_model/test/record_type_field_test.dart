// DGUB8: record type ANNOTATION fields must survive the mirror AST.
//
// `SRecordTypeAnnotation` used to hold its fields as bare `List<SAstNode>`,
// and nothing in this model could actually represent one — so a converter had
// no node to build and dropped every field into an opaque placeholder. The
// arity survived; the field TYPES and the named-field KEYS did not. Downstream
// that made `(42, label: 'answer') is (int, {String label})` unanswerable.
//
// `SRecordTypeField` is that missing node. These tests pin the three things the
// interpreter actually reads back out — the field type, the named-field name,
// and both of them surviving a JSON round-trip through `SAstNodeFactory`.

import 'package:test/test.dart';
import 'package:tom_ast_model/ast.dart';

/// Builds `(int, {String label})`.
SRecordTypeAnnotation intWithNamedLabel() => SRecordTypeAnnotation(
  offset: 0,
  length: 22,
  positionalFields: [
    SRecordTypeField(
      offset: 1,
      length: 3,
      type: SNamedType(
        offset: 1,
        length: 3,
        name: SSimpleIdentifier(offset: 1, length: 3, name: 'int'),
      ),
    ),
  ],
  namedFields: [
    SRecordTypeField(
      offset: 7,
      length: 12,
      type: SNamedType(
        offset: 7,
        length: 6,
        name: SSimpleIdentifier(offset: 7, length: 6, name: 'String'),
      ),
      name: SSimpleIdentifier(offset: 14, length: 5, name: 'label'),
    ),
  ],
);

void main() {
  group('DGUB8: SRecordTypeField', () {
    test(
      'F-DGUB8-1: a positional field carries its type and has no name '
      '[2026-07-28] (PASS)',
      () {
        final field = intWithNamedLabel().positionalFields.single;
        expect(field.name, isNull);
        expect((field.type as SNamedType).name!.name, 'int');
      },
    );

    test(
      'F-DGUB8-2: a named field carries both its type and its name '
      '[2026-07-28] (PASS)',
      () {
        final field = intWithNamedLabel().namedFields.single;
        expect(field.name!.name, 'label');
        expect((field.type as SNamedType).name!.name, 'String');
      },
    );

    test('F-DGUB8-3: nodeType is RecordTypeField [2026-07-28] (PASS)', () {
      expect(intWithNamedLabel().positionalFields.single.nodeType,
          'RecordTypeField');
    });

    test(
      'F-DGUB8-4: the field node round-trips through SAstNodeFactory '
      '[2026-07-28] (PASS)',
      () {
        // Goes through the *factory* rather than SRecordTypeField.fromJson so
        // this also asserts the node is registered under its nodeType — an
        // unregistered node deserialises to null and silently loses the field.
        final original = intWithNamedLabel().namedFields.single;
        final restored =
            SAstNodeFactory.fromJson(original.toJson()) as SRecordTypeField;
        expect(restored.name!.name, 'label');
        expect((restored.type as SNamedType).name!.name, 'String');
        expect(restored.offset, original.offset);
        expect(restored.length, original.length);
      },
    );

    test(
      'F-DGUB8-5: the enclosing annotation round-trips with typed fields '
      '[2026-07-28] (PASS)',
      () {
        final restored = SRecordTypeAnnotation.fromJson(
          intWithNamedLabel().toJson(),
        );
        expect(restored.positionalFields, hasLength(1));
        expect(restored.namedFields, hasLength(1));
        expect(
          (restored.positionalFields.single.type as SNamedType).name!.name,
          'int',
        );
        expect(restored.namedFields.single.name!.name, 'label');
        expect(
          (restored.namedFields.single.type as SNamedType).name!.name,
          'String',
        );
      },
    );

    test(
      'F-DGUB8-6: a field with no declared type round-trips as null, not as a '
      'crash [2026-07-28] (PASS)',
      () {
        // Reachable from malformed source (`(,)`) and from bundles serialised
        // before this node existed, where the field was an opaque placeholder
        // carrying neither type nor name.
        final restored = SRecordTypeField.fromJson(
          SRecordTypeField(offset: 3, length: 0).toJson(),
        );
        expect(restored.type, isNull);
        expect(restored.name, isNull);
      },
    );

    test(
      'F-DGUB8-7: visitRecordTypeField is dispatched and children are visited '
      '[2026-07-28] (PASS)',
      () {
        final visitor = _FieldCollector();
        intWithNamedLabel().accept(visitor);
        expect(visitor.visitedFieldNames, ['<positional>', 'label']);
      },
    );
  });
}

/// Walks an annotation and records every record-type field it is dispatched to.
class _FieldCollector extends SAstVisitor<void> {
  final visitedFieldNames = <String>[];

  @override
  void visitNode(SAstNode node) => node.visitChildren(this);

  @override
  void visitRecordTypeField(SRecordTypeField node) {
    visitedFieldNames.add(node.name?.name ?? '<positional>');
    node.visitChildren(this);
  }
}
