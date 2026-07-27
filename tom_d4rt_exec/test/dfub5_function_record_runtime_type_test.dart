// DFUB5 conformance (DGUB7): FunctionType / RecordType runtime checks —
// verified against the ANALYZER-FREE interpreter.
//
// Mirror of tom_d4rt/test/dfub5_function_record_runtime_type_test.dart. DFUB5
// added FunctionRuntimeType / RecordRuntimeType with structural subtyping, so
// `is`/`as` against a GenericFunctionType or RecordTypeAnnotation resolves
// instead of throwing "not implemented", and function/record return types are
// actually validated. This file is the guard that the ast tree agrees.
//
// The function half agrees exactly. The RECORD half does not, and the
// divergence is pinned rather than skipped — see the group comment below.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

import 'interpreter_test.dart';

void main() {
  group('DFUB5 (exec): function runtime type checks', () {
    test(
        'F-DFUB5-EXEC-1: `is` FunctionType matches a tear-off [2026-07-27] '
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

    test(
        'F-DFUB5-EXEC-2: `is` FunctionType rejects wrong return [2026-07-27] '
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

    test(
        'F-DFUB5-EXEC-3: function return-type mismatch throws [2026-07-27] '
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
          throwsA(isA<RuntimeD4rtException>().having(
              (e) => e.message, 'message', contains("can't be returned"))));
    });

    test(
        'F-DFUB5-EXEC-4: matching function return still works [2026-07-27] '
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

  // The record cases are KNOWN-DIVERGENT from the analyzer tree. The root cause
  // is upstream of this interpreter: `tom_ast_generator` drops every
  // `RecordTypeAnnotationField` into an opaque `_SUnknownNode`, so a record type
  // ANNOTATION reaches the ast tree carrying only its arity — no field types and
  // no named-field keys. `_resolveTypeAnnotationWithEnvironment` therefore
  // rebuilds it with `dynamic` field types and SYNTHETIC named keys (`$named0`,
  // `$named1`, ...). That is tracked as dgub8.
  //
  // MEASURED CONSEQUENCE, which is sharper than "arity-only" and is the reason
  // these cases are worth pinning at all: the record VALUE side derives its
  // RecordRuntimeType from the actual `InterpretedRecord`, so it carries the
  // REAL key (`label`). Comparing `{label: String}` against `{$named0: dynamic}`
  // fails on the key. So:
  //   * a record with ONLY positional fields matches by arity, ignoring field
  //     types (`(1, 'a') is (String, int)` is true — F-DFUB5-EXEC-9);
  //   * a record with ANY named field NEVER matches, in either direction
  //     (F-DFUB5-EXEC-5 and -6 both answer false).
  // The second is a false NEGATIVE, i.e. the conservative direction, which is
  // why it is left alone here rather than "fixed" by ignoring named keys too —
  // that would trade a restrictive answer for an unsound one, and dgub8 removes
  // the guesswork entirely.
  //
  // These are pinned to the measured behaviour rather than skipped. A skip
  // records nothing and stays silent forever; a pin states exactly how far the
  // analyzer-free tree currently gets, and goes RED the moment dgub8 lands —
  // precisely when each case should be tightened back to the analyzer-tree
  // expectation quoted on it.
  group('DFUB5 (exec): record runtime type checks — degraded, see dgub8', () {
    test(
        'F-DFUB5-EXEC-5: `is` RecordType cannot yet match a named-field record '
        '[2026-07-27] (PASS)', () {
      // ANALYZER TREE EXPECTS `[true, 42, 'answer']` (F-DFUB5-5). The ast tree
      // answers false: annotation key `$named0` vs value key `label`. Field
      // ACCESS is unaffected — only the type check degrades. Tighten to `true`
      // when dgub8 lands.
      const code = '''
List main() {
  var rec = (42, label: 'answer');
  return [rec is (int, {String label}), rec.\$1, rec.label];
}
''';
      expect(execute(code), equals([false, 42, 'answer']));
    });

    test(
        'F-DFUB5-EXEC-6: `is` RecordType rejects wrong shape [2026-07-27] '
        '(PASS)', () {
      // Agrees with the analyzer tree (F-DFUB5-6) — but for the wrong reason:
      // it is rejected on the synthetic named key, not on the field types. It
      // must stay `false` once dgub8 lands, so this case is the one record
      // expectation that does NOT change then.
      const code = '''
bool main() {
  var rec = (42, label: 'answer');
  return rec is (String, {int label});
}
''';
      expect(execute(code), equals(false));
    });

    test(
        'F-DFUB5-EXEC-7: record return-type mismatch is not yet caught '
        '[2026-07-27] (PASS)', () {
      // ANALYZER TREE EXPECTS a throw (F-DFUB5-7): `('wrong', 'shape')` is not
      // a `(int, String)`. Both are 2-positional records and the annotation's
      // field types degraded to `dynamic`, which accepts anything — so the
      // value is returned unchecked. Tighten to
      // `throwsA(... "can't be returned")` when dgub8 lands.
      const code = '''
(int, String) makeRecord() {
  return ('wrong', 'shape');
}

Object main() {
  return makeRecord();
}
''';
      expect(() => execute(code), returnsNormally);
    });

    test(
        'F-DFUB5-EXEC-8: matching record return still works [2026-07-27] '
        '(PASS)', () {
      // The vacuity anchor for -7: the degraded check must still ACCEPT a
      // genuinely matching record, so -7's non-throw is not merely "record
      // returns are never validated at all".
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

    test(
        'F-DFUB5-EXEC-9: positional-only records match on arity alone, named '
        'keys are what break [2026-07-27] (PASS)', () {
      // The discriminating case, and the evidence for the group comment: it
      // separates "record `is` is wholly broken" from "the synthetic named key
      // is what fails". Positional-only annotations carry no keys to synthesize,
      // so they still match — by arity, ignoring field types (hence `(String,
      // int)` also answering true, which dgub8 must tighten to false).
      const code = '''
List main() {
  var r = (1, 'a');
  return [r is (int, String), r is (String, int), r is (int, String, int)];
}
''';
      expect(execute(code), equals([true, true, false]));
    });
  });
}
