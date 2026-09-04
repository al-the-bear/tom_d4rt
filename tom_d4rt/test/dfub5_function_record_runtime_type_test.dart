// DFUB5: runtime type checks for FunctionType + RecordType `is`/return checks.
//
// Ports upstream kodjodevf/d4rt 848f03d (runtime type annotations). Before this
// fix the interpreter modelled only NamedType at runtime: an `is`/`as` against a
// GenericFunctionType or RecordTypeAnnotation fell into an `else` that threw
// "Type check for <node> not implemented", and function/record return-type
// validation was skipped entirely (the value's runtime type came back null, so
// the subtype check was bypassed and mismatched functions/records were returned
// silently).
//
// The fix adds FunctionRuntimeType / RecordRuntimeType (structural subtyping),
// resolves GenericFunctionType / RecordTypeAnnotation annotations into them,
// gives every Callable a `callableRuntimeType`, and derives a RecordRuntimeType
// from an InterpretedRecord's field values — so `is` and return checks compare
// real shapes.

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? execute(String code) {
  final d4rt = D4rt();
  return d4rt.execute(source: code);
}

void main() {
  group('DFUB5: function/record runtime type checks', () {
    test(
      'F-DFUB5-1: `is` FunctionType matches a tear-off [2026-07-23] (PASS)',
      () {
        const code = '''
int addOne(int x) => x + 1;

List main() {
  var f = addOne;
  return [f is int Function(int), f(41)];
}
''';
        expect(execute(code), equals([true, 42]));
      },
    );

    test(
      'F-DFUB5-2: `is` FunctionType rejects wrong return [2026-07-23] (PASS)',
      () {
        const code = '''
int addOne(int x) => x + 1;

bool main() {
  var f = addOne;
  return f is String Function(int);
}
''';
        expect(execute(code), equals(false));
      },
    );

    test(
      'F-DFUB5-3: function return-type mismatch throws [2026-07-23] (PASS)',
      () {
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
      },
    );

    test(
      'F-DFUB5-4: matching function return still works [2026-07-23] (PASS)',
      () {
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
      },
    );

    test('F-DFUB5-5: `is` RecordType matches a record [2026-07-23] (PASS)', () {
      const code = '''
List main() {
  var rec = (42, label: 'answer');
  return [rec is (int, {String label}), rec.\$1, rec.label];
}
''';
      expect(execute(code), equals([true, 42, 'answer']));
    });

    test(
      'F-DFUB5-6: `is` RecordType rejects wrong shape [2026-07-23] (PASS)',
      () {
        const code = '''
bool main() {
  var rec = (42, label: 'answer');
  return rec is (String, {int label});
}
''';
        expect(execute(code), equals(false));
      },
    );

    test(
      'F-DFUB5-7: record return-type mismatch throws [2026-07-23] (PASS)',
      () {
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
      },
    );

    test(
      'F-DFUB5-8: matching record return still works [2026-07-23] (PASS)',
      () {
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
      },
    );
  });
}
