// DGUB8: a record type ANNOTATION must resolve to its real shape.
//
// The record branch of the type resolver used to rebuild the annotation from
// its ARITY alone: every field type became `dynamic` and every named key became
// a synthetic `$named0`, `$named1`, … That was not a cosmetic placeholder. The
// record VALUE side derives its `RecordRuntimeType` from the actual
// `InterpretedRecord`, so it carries the REAL key — and a real key never equals
// a synthetic one. The measured consequences were:
//
//   * a positional-only record matched on arity while IGNORING field types, so
//     `(1, 'a') is (String, int)` answered true — unsound;
//   * a record with ANY named field matched NOTHING in either direction, so
//     `(42, label: 'answer') is (int, {String label})` answered false;
//   * `as` accepted casts it should have rejected.
//
// `SRecordTypeField` (tom_ast_model 0.2.0) makes the field types and named keys
// reachable, and the resolver now reads them. These tests assert the resolved
// shape end-to-end through the interpreter rather than by poking the private
// resolver, because the value/annotation KEY AGREEMENT is precisely what broke.
//
// The analyzer-free package cannot parse Dart source, so each program is
// hand-built from `SAstNode`s — the same approach as
// `execute_bundle_as_test.dart`. The source-level twin of this suite is
// `tom_d4rt_exec/test/dfub5_function_record_runtime_type_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

// ---------------------------------------------------------------------------
// AST construction helpers
// ---------------------------------------------------------------------------

SSimpleIdentifier ident(String name) =>
    SSimpleIdentifier(offset: 0, length: name.length, name: name);

SNamedType namedType(String name, {bool isNullable = false}) => SNamedType(
  offset: 0,
  length: name.length,
  name: ident(name),
  isNullable: isNullable,
);

/// Builds a record type annotation, e.g.
/// `recordType(positional: ['int'], named: {'label': 'String'})` →
/// `(int, {String label})`.
SRecordTypeAnnotation recordType({
  List<STypeAnnotation> positional = const [],
  Map<String, STypeAnnotation> named = const {},
}) => SRecordTypeAnnotation(
  offset: 0,
  length: 0,
  positionalFields: [
    for (final type in positional)
      SRecordTypeField(offset: 0, length: 0, type: type),
  ],
  namedFields: [
    for (final entry in named.entries)
      SRecordTypeField(
        offset: 0,
        length: 0,
        type: entry.value,
        name: ident(entry.key),
      ),
  ],
);

/// Builds a record literal, e.g. `(42, label: 'answer')`.
SRecordLiteral recordLiteral({
  List<SExpression> positional = const [],
  Map<String, SExpression> named = const {},
}) => SRecordLiteral(
  offset: 0,
  length: 0,
  fields: [
    ...positional,
    for (final entry in named.entries)
      SNamedExpression(
        offset: 0,
        length: 0,
        name: SLabel(offset: 0, length: 0, label: ident(entry.key)),
        expression: entry.value,
      ),
  ],
);

SIntegerLiteral intLit(int value) =>
    SIntegerLiteral(offset: 0, length: 1, value: value);

SSimpleStringLiteral strLit(String value) =>
    SSimpleStringLiteral(offset: 0, length: value.length + 2, value: value);

SBooleanLiteral boolLit(bool value) =>
    SBooleanLiteral(offset: 0, length: 4, value: value);

/// Wraps [expression] into a bundle whose `main()` returns it.
AstBundle bundleReturning(SExpression expression) {
  const entryUri = 'package:t/main.dart';
  final mainFn = SFunctionDeclaration(
    offset: 0,
    length: 0,
    name: ident('main'),
    functionExpression: SFunctionExpression(
      offset: 0,
      length: 0,
      parameters: SFormalParameterList(offset: 0, length: 0),
      body: SBlockFunctionBody(
        offset: 0,
        length: 0,
        block: SBlock(
          offset: 0,
          length: 0,
          statements: [
            SReturnStatement(offset: 0, length: 0, expression: expression),
          ],
        ),
      ),
    ),
  );
  return AstBundle(
    entryPointUri: entryUri,
    modules: {
      entryUri: SCompilationUnit(offset: 0, length: 0, declarations: [mainFn]),
    },
  );
}

/// Runs `value is type` (or `value as type`) and returns the result.
Object? runIs(SExpression value, STypeAnnotation type, {bool isNot = false}) =>
    D4rtRunner().executeBundle(
      bundleReturning(
        SIsExpression(
          offset: 0,
          length: 0,
          expression: value,
          type: type,
          isNot: isNot,
        ),
      ),
    );

Object? runAs(SExpression value, STypeAnnotation type) =>
    D4rtRunner().executeBundle(
      bundleReturning(
        SAsExpression(offset: 0, length: 0, expression: value, type: type),
      ),
    );

void main() {
  /// `(42, label: 'answer')`
  SRecordLiteral answerRecord() => recordLiteral(
    positional: [intLit(42)],
    named: {'label': strLit('answer')},
  );

  group('DGUB8: record type annotation resolution — named fields', () {
    test(
      'F-DGUB8-AST-1: a named-field record matches its own shape [2026-07-28] '
      '(PASS)',
      () {
        // The headline regression: this answered `false` while the annotation
        // key was synthesised as `$named0` and the value key was `label`.
        expect(
          runIs(
            answerRecord(),
            recordType(
              positional: [namedType('int')],
              named: {'label': namedType('String')},
            ),
          ),
          isTrue,
        );
      },
    );

    test('F-DGUB8-AST-2: swapped named/positional field types are rejected '
        '[2026-07-28] (PASS)', () {
      expect(
        runIs(
          answerRecord(),
          recordType(
            positional: [namedType('String')],
            named: {'label': namedType('int')},
          ),
        ),
        isFalse,
      );
    });

    test('F-DGUB8-AST-3: a differently NAMED field is rejected even when the '
        'types line up [2026-07-28] (PASS)', () {
      // Distinguishes "the key is read" from "the key is ignored". With the
      // key ignored this would answer true, which is the unsound direction.
      expect(
        runIs(
          answerRecord(),
          recordType(
            positional: [namedType('int')],
            named: {'caption': namedType('String')},
          ),
        ),
        isFalse,
      );
    });

    test('F-DGUB8-AST-4: named-field count must agree [2026-07-28] (PASS)', () {
      expect(
        runIs(
          answerRecord(),
          recordType(
            positional: [namedType('int')],
            named: {'label': namedType('String'), 'flag': namedType('bool')},
          ),
        ),
        isFalse,
      );
    });
  });

  group('DGUB8: record type annotation resolution — positional fields', () {
    /// `(1, 'a')`
    SRecordLiteral pair() =>
        recordLiteral(positional: [intLit(1), strLit('a')]);

    test('F-DGUB8-AST-5: a positional-only record matches its own field types '
        '[2026-07-28] (PASS)', () {
      expect(
        runIs(
          pair(),
          recordType(positional: [namedType('int'), namedType('String')]),
        ),
        isTrue,
      );
    });

    test('F-DGUB8-AST-6: positional field types are checked, not just arity '
        '[2026-07-28] (PASS)', () {
      // The other unsound case: with all field types degraded to `dynamic`,
      // any 2-field record matched any 2-field annotation, so this answered
      // true.
      expect(
        runIs(
          pair(),
          recordType(positional: [namedType('String'), namedType('int')]),
        ),
        isFalse,
      );
    });

    test(
      'F-DGUB8-AST-7: positional arity must still agree [2026-07-28] (PASS)',
      () {
        expect(
          runIs(
            pair(),
            recordType(
              positional: [
                namedType('int'),
                namedType('String'),
                namedType('int'),
              ],
            ),
          ),
          isFalse,
        );
      },
    );

    test('F-DGUB8-AST-8: a nested record field type is compared structurally '
        '[2026-07-28] (PASS)', () {
      // `((1, 'a'), true)` against `((int, String), bool)` — proves the
      // resolver recurses into the field type instead of stopping at the
      // outer arity.
      final nested = recordLiteral(
        positional: [
          recordLiteral(positional: [intLit(1), strLit('a')]),
          boolLit(true),
        ],
      );
      expect(
        runIs(
          nested,
          recordType(
            positional: [
              recordType(positional: [namedType('int'), namedType('String')]),
              namedType('bool'),
            ],
          ),
        ),
        isTrue,
      );
      expect(
        runIs(
          recordLiteral(
            positional: [
              recordLiteral(positional: [intLit(1), strLit('a')]),
              boolLit(true),
            ],
          ),
          recordType(
            positional: [
              recordType(positional: [namedType('String'), namedType('int')]),
              namedType('bool'),
            ],
          ),
        ),
        isFalse,
      );
    });

    test('F-DGUB8-AST-9: `is!` negates the result [2026-07-28] (PASS)', () {
      expect(
        runIs(
          pair(),
          recordType(positional: [namedType('String'), namedType('int')]),
          isNot: true,
        ),
        isTrue,
      );
    });
  });

  group('DGUB8: record type annotation resolution — as casts', () {
    test('F-DGUB8-AST-10: a matching record cast succeeds and keeps its fields '
        '[2026-07-28] (PASS)', () {
      // The runner converts the interpreted record to a native Dart record
      // on the way out, so the cast is observed through the field values.
      final result = runAs(
        recordLiteral(positional: [intLit(1), strLit('a')]),
        recordType(positional: [namedType('int'), namedType('String')]),
      );
      expect(result, (1, 'a'));
    });

    test('F-DGUB8-AST-11: a mismatched record cast now throws instead of being '
        'accepted [2026-07-28] (PASS)', () {
      // `(1, 'a') as (String, int)` used to return the record untouched,
      // because both sides degraded to two `dynamic` fields.
      //
      // SCB10 CONTRACT CHANGE: a failing `as` now raises `TypeError` rather
      // than `RuntimeD4rtException`, matching what real Dart raises. This
      // test's subject is *that the cast throws at all*, so the assertion is
      // retargeted at the type the cast site raises today, not relaxed to
      // `isA<Object>()`.
      expect(
        () => runAs(
          recordLiteral(positional: [intLit(1), strLit('a')]),
          recordType(positional: [namedType('String'), namedType('int')]),
        ),
        throwsA(isA<TypeError>()),
      );
    });
  });
}
