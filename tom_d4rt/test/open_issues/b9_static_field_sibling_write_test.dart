/// Repro + regression for OPEN B.9 — a static-field write performed inside a
/// sibling static method must persist to the class's static slot, so a later
/// static call observes the updated value.
///
/// Historic failure: `Counter.bump()` assigning `value = value + 1` inside a
/// static method did not survive across calls; `Counter.read()` kept seeing
/// the initializer value. Distinct from initializer-ordering (`2b836ca6`).
///
/// Mirrors the analyzer-free twin — see
/// `tom_d4rt_exec/test/open_issues/b9_static_field_sibling_write_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  group('OPEN B.9 — static-field write from a sibling static method', () {
    test('write in a sibling static method persists across calls', () async {
      final d4rt = D4rt();
      final result = await d4rt.execute(source: '''
class Counter {
  static int value = 0;
  static void bump() { value = value + 1; }
  static int read() => value;
}
int main() {
  Counter.bump();
  Counter.bump();
  Counter.bump();
  return Counter.read();
}
''');
      expect(result, 3);
    });

    test('compound assignment (+=) in a sibling static method persists',
        () async {
      final d4rt = D4rt();
      final result = await d4rt.execute(source: '''
class Acc {
  static int total = 10;
  static void add(int n) { total += n; }
  static int read() => total;
}
int main() {
  Acc.add(5);
  Acc.add(7);
  return Acc.read();
}
''');
      expect(result, 22);
    });

    test('write is observable directly via the static getter', () async {
      final d4rt = D4rt();
      final result = await d4rt.execute(source: '''
class Flag {
  static bool ready = false;
  static void arm() { ready = true; }
}
bool main() {
  Flag.arm();
  return Flag.ready;
}
''');
      expect(result, true);
    });
  });
}
