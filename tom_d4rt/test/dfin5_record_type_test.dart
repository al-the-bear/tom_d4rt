// DFIN5 (dguc7): `Record` is a type.
//
// `x is Record` raised "Undefined variable: Record" and a `Record` return type
// raised "Type 'Record' not found." in both interpreters, although every record
// is a Record in Dart and RecordRuntimeType.isSubtypeOf already accepted the
// name. Measured 2026-10-03 in tom_d4rt and tom_d4rt_exec.
//
// Twin: tom_d4rt_exec ports this file verbatim.
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

Object? _run(String source) => D4rt().execute(source: source);

void main() {
  group('DFIN5: Record', () {
    test('DFIN5-R1: a record is a Record, a non-record is not '
        '[2026-10-03]', () {
      expect(
        _run('''
List<bool> main() {
  final r = (1, 'a');
  final n = (x: 1);
  return [r is Record, n is Record, 1 is Record, 'r' is Record, null is Record];
}
'''),
        [true, true, false, false, false],
      );
    });

    test('DFIN5-R2: Record as a return and a parameter type [2026-10-03]', () {
      expect(
        _run('''
Record make() => (1, 'a');
int count(Record r) => r is (int, String) ? 2 : 0;
int main() => count(make());
'''),
        2,
      );
    });

    test('DFIN5-R3: `as Record` passes a record and refuses anything else '
        '[2026-10-03]', () {
      expect(_run("Object main() => ((1, 2) as Record) is Record;"), isTrue);
      expect(() => _run("Object main() => (1 as Record);"), throwsA(anything));
    });
  });
}
