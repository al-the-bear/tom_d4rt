// DFUB5 conformance (DGUB7): FunctionType / RecordType runtime checks —
// verified against the ANALYZER-FREE interpreter.
//
// Mirror of tom_d4rt/test/dfub5_function_record_runtime_type_test.dart. DFUB5
// added FunctionRuntimeType / RecordRuntimeType with structural subtyping, so
// `is`/`as` against a GenericFunctionType or RecordTypeAnnotation resolves
// instead of throwing "not implemented", and function/record return types are
// actually validated. This file is the guard that the ast tree agrees.
//
// Both halves now agree with the analyzer tree. The record half went through a
// publish lag: `tom_ast_generator` used to drop every `RecordTypeAnnotationField`
// into an opaque unknown node, so a record type ANNOTATION reached the ast tree
// carrying only its arity, and the record cases below were pinned to that
// degraded answer. DGUB8 fixed it and the fix reached this package with
// `tom_d4rt_ast >=0.14.0` / `tom_ast_generator >=0.1.5`; the pins are tightened
// to the analyzer-tree expectations. See the group comment for what each case
// now discriminates.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

import 'interpreter_test.dart';

void main() {
  group('DFUB5 (exec): function runtime type checks', () {
    test('F-DFUB5-EXEC-1: `is` FunctionType matches a tear-off [2026-07-27] '
        '(PASS)', () {
      const code = '''
int addOne(int x) => x + 1;

List main() {
  var f = addOne;
  return [f is int Function(int), f(41)];
}
''';
      expect(execute(code), equals([true, 42]));
    });

    test('F-DFUB5-EXEC-2: `is` FunctionType rejects wrong return [2026-07-27] '
        '(PASS)', () {
      const code = '''
int addOne(int x) => x + 1;

bool main() {
  var f = addOne;
  return f is String Function(int);
}
''';
      expect(execute(code), equals(false));
    });

    test('F-DFUB5-EXEC-3: function return-type mismatch throws [2026-07-27] '
        '(PASS)', () {
      const code = '''
String greet(int x) => 'hi';

int Function(int) makeFn() {
  return greet;
}

int main() {
  var fn = makeFn();
  return fn(1);
}
''';
      expect(
        () => execute(code),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains("can't be returned"),
          ),
        ),
      );
    });

    test('F-DFUB5-EXEC-4: matching function return still works [2026-07-27] '
        '(PASS)', () {
      const code = '''
int addOne(int x) => x + 1;

int Function(int) makeFn() {
  return addOne;
}

int main() {
  var fn = makeFn();
  return fn(41);
}
''';
      expect(execute(code), equals(42));
    });
  });

  // The record cases match the analyzer tree exactly. Getting here took a fix in
  // three packages, and the cases are chosen to discriminate between the two
  // distinct failures that fix corrected — so a regression in either one is
  // identifiable from which case goes red, not just "records broke".
  //
  // WHAT WAS WRONG. `tom_ast_generator` dropped every
  // `RecordTypeAnnotationField` into an opaque unknown node, so a record type
  // ANNOTATION reached the ast tree carrying only its arity — no field types and
  // no named-field keys — and the resolver rebuilt it with `dynamic` field types
  // and SYNTHETIC named keys (`$named0`, `$named1`, ...). Because the record
  // VALUE side derives its RecordRuntimeType from the actual `InterpretedRecord`
  // it carries the REAL key, so `{label: String}` never equalled
  // `{$named0: dynamic}`. Two failures, opposite in kind:
  //   * a record with ANY named field matched NOTHING, in either direction — a
  //     false negative (now F-DFUB5-EXEC-5);
  //   * a positional-only record matched on ARITY while ignoring field types, so
  //     `(1, 'a') is (String, int)` answered true — unsound, and the reason a
  //     record return-type mismatch was never caught (now -9 and -7).
  //
  // WHAT FIXED IT. `SRecordTypeField` (tom_ast_model 0.2.0) carries the field
  // type and named key, the `tom_ast_generator` converter populates it
  // recursively, and both `tom_d4rt_ast` resolvers read it. The unit-level proof
  // lives in `tom_d4rt_ast/test/runtime/dgub8_record_type_annotation_test.dart`
  // (F-DGUB8-AST-1..11, hand-built bundles); this group is the end-to-end guard
  // that the same answers survive the analyzer -> mirror-AST conversion.
  //
  // Requires `tom_d4rt_ast >=0.14.0` and `tom_ast_generator >=0.1.5`. Against
  // anything older these five cases answer `[false, ...]`, `false`,
  // `returnsNormally`, `1`, `[true, true, false]` respectively.
  group('DFUB5 (exec): record runtime type checks', () {
    test('F-DFUB5-EXEC-5: `is` RecordType matches a named-field record '
        '[2026-07-28] (PASS)', () {
      // Agrees with the analyzer tree (F-DFUB5-5) and with F-DGUB8-AST-1. This
      // is the false-negative half: the annotation's real key `label` is now
      // reachable, so it can equal the value's key. Field ACCESS was never
      // affected, which is why `rec.$1` / `rec.label` are read alongside the
      // type check — they anchor that only the check was ever at fault.
      const code = '''
List main() {
  var rec = (42, label: 'answer');
  return [rec is (int, {String label}), rec.\$1, rec.label];
}
''';
      expect(execute(code), equals([true, 42, 'answer']));
    });

    test('F-DFUB5-EXEC-6: `is` RecordType rejects wrong shape [2026-07-28] '
        '(PASS)', () {
      // Agrees with the analyzer tree (F-DFUB5-6) and with F-DGUB8-AST-2. The
      // one record expectation whose ANSWER did not change across the fix — but
      // its REASON did: it used to be rejected on a synthetic named key, and is
      // now rejected on the field types (`int` vs `String` both ways round).
      // Paired with -5 it separates "the key matched" from "the types matched".
      const code = '''
bool main() {
  var rec = (42, label: 'answer');
  return rec is (String, {int label});
}
''';
      expect(execute(code), equals(false));
    });

    test('F-DFUB5-EXEC-7: record return-type mismatch throws [2026-07-28] '
        '(PASS)', () {
      // Agrees with the analyzer tree (F-DFUB5-7); F-DGUB8-AST-6 shows the same
      // field-type comparison at the unit level. This is the unsound half: both
      // records are 2-positional, so while the annotation's field types were
      // `dynamic` the return was accepted unchecked. -8 is its vacuity anchor.
      const code = '''
(int, String) makeRecord() {
  return ('wrong', 'shape');
}

Object main() {
  return makeRecord();
}
''';
      expect(
        () => execute(code),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.message,
            'message',
            contains("can't be returned"),
          ),
        ),
      );
    });

    test('F-DFUB5-EXEC-8: matching record return still works [2026-07-28] '
        '(PASS)', () {
      // The vacuity anchor for -7: the tightened check must still ACCEPT a
      // genuinely matching record, so -7's throw is not merely "record returns
      // are now rejected wholesale".
      const code = '''
(int, String) makeRecord() {
  return (1, 'a');
}

int main() {
  var r = makeRecord();
  return r.\$1;
}
''';
      expect(execute(code), equals(1));
    });

    test('F-DFUB5-EXEC-9: positional-only records match on field types, not '
        'arity alone [2026-07-28] (PASS)', () {
      // The discriminating case for the unsound half; F-DGUB8-AST-5/-6/-7 pin
      // the same three answers. All three annotations are positional-only, so no
      // named key is involved and arity alone cannot explain the result: the
      // second answer is `false` ONLY because `(int, String)` and `(String, int)`
      // are compared field by field. The third keeps arity in the picture.
      const code = '''
List main() {
  var r = (1, 'a');
  return [r is (int, String), r is (String, int), r is (int, String, int)];
}
''';
      expect(execute(code), equals([true, false, false]));
    });
  });
}
