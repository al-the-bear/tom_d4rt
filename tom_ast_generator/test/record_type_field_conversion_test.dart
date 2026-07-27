// DGUB8: record type ANNOTATION fields must survive the analyzer → mirror-AST
// conversion.
//
// `_convertRecordTypeAnnotation` used to call the generic `convert()` on each
// `analyzer.RecordTypeAnnotationField`. That class was never in the dispatch
// chain, so every field fell through to the opaque unknown-node placeholder:
// the annotation reached the interpreter carrying only its ARITY — no field
// types, and no named-field keys. Downstream, that is what made
// `(42, label: 'answer') is (int, {String label})` unanswerable.
//
// These tests go through [parseSource], which round-trips the tree through
// JSON, so they pin conversion AND serialisation in one step — a field that
// converts correctly but does not serialise is just as lost.

import 'package:test/test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart';

import 'test_helpers.dart';

/// Returns the record-type return annotation of the single top-level function
/// declared in [source].
SRecordTypeAnnotation recordReturnTypeOf(String source) {
  final unit = parseSource(source);
  final fn = unit.declarations.whereType<SFunctionDeclaration>().single;
  return fn.returnType as SRecordTypeAnnotation;
}

void main() {
  group('DGUB8: RecordTypeAnnotationField conversion', () {
    test(
      'F-DGUB8-GEN-1: positional field types survive conversion [2026-07-28] '
      '(PASS)',
      () {
        final rec = recordReturnTypeOf('''
(int, String) f() => (1, 'a');
''');
        expect(rec.namedFields, isEmpty);
        expect(
          rec.positionalFields
              .map((f) => (f.type as SNamedType).name!.name)
              .toList(),
          ['int', 'String'],
        );
        expect(rec.positionalFields.every((f) => f.name == null), isTrue);
      },
    );

    test(
      'F-DGUB8-GEN-2: named field keys and types survive conversion '
      '[2026-07-28] (PASS)',
      () {
        // The named KEY is the part that was previously lost outright — the
        // resolver downstream had to invent `$named0`, which then failed to
        // match the real key on the record value.
        final rec = recordReturnTypeOf('''
(int, {String label, bool flag}) f() => (1, label: 'a', flag: true);
''');
        expect(rec.positionalFields, hasLength(1));
        expect(
          rec.namedFields.map((f) => f.name!.name).toList(),
          ['label', 'flag'],
        );
        expect(
          rec.namedFields.map((f) => (f.type as SNamedType).name!.name).toList(),
          ['String', 'bool'],
        );
      },
    );

    test(
      'F-DGUB8-GEN-3: a nested record field type is itself converted, not '
      'flattened [2026-07-28] (PASS)',
      () {
        // Guards the recursion: the field's type goes through the same
        // dispatch, so a record inside a record keeps its structure rather
        // than degrading to an opaque node one level down.
        final rec = recordReturnTypeOf('''
((int, String), {(bool,) inner}) f() => ((1, 'a'), inner: (true,));
''');
        final outerPositional =
            rec.positionalFields.single.type as SRecordTypeAnnotation;
        expect(
          outerPositional.positionalFields
              .map((f) => (f.type as SNamedType).name!.name)
              .toList(),
          ['int', 'String'],
        );
        final nestedNamed =
            rec.namedFields.single.type as SRecordTypeAnnotation;
        expect(rec.namedFields.single.name!.name, 'inner');
        expect(
          (nestedNamed.positionalFields.single.type as SNamedType).name!.name,
          'bool',
        );
      },
    );

    test(
      'F-DGUB8-GEN-4: generic and nullable field types keep their arguments '
      '[2026-07-28] (PASS)',
      () {
        final rec = recordReturnTypeOf('''
(List<int>, {String? label}) f() => (<int>[], label: null);
''');
        final listField = rec.positionalFields.single.type as SNamedType;
        expect(listField.name!.name, 'List');
        expect(
          (listField.typeArguments!.arguments.single as SNamedType).name!.name,
          'int',
        );
        final labelField = rec.namedFields.single.type as SNamedType;
        expect(labelField.name!.name, 'String');
        expect(labelField.isNullable, isTrue);
      },
    );

    test(
      'F-DGUB8-GEN-5: a nullable record annotation keeps its own question mark '
      '[2026-07-28] (PASS)',
      () {
        final rec = recordReturnTypeOf('''
(int, String)? f() => null;
''');
        expect(rec.isNullable, isTrue);
        expect(rec.positionalFields, hasLength(2));
      },
    );
  });
}
