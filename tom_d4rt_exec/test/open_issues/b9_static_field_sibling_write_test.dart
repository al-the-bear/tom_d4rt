/// Repro + regression for OPEN B.9 — a static-field write performed inside a
/// sibling static method must persist to the class's static slot, so a later
/// static call observes the updated value.
///
/// Historic failure: `Counter.bump()` assigning `value = value + 1` inside a
/// static method did not survive across calls; `Counter.read()` kept seeing
/// the initializer value. Distinct from initializer-ordering (`2b836ca6`).
///
/// Mirrors the analyzer-based twin — see
/// `tom_d4rt/test/open_issues/b9_static_field_sibling_write_test.dart`. This is
/// the analyzer-free AST runtime: source is compiled to a bundle via the
/// `tom_d4rt_exec` front end, then interpreted by `D4rtRunner`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

void main() {
  group('OPEN B.9 — static-field write from a sibling static method (AST)', () {
    test('write in a sibling static method persists across calls', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
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
      final runner = D4rtRunner();
      final result = runner.executeBundle(bundle);
      expect(result, 3);
    });

    test('compound assignment (+=) in a sibling static method persists',
        () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
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
      final runner = D4rtRunner();
      final result = runner.executeBundle(bundle);
      expect(result, 22);
    });

    test('write is observable directly via the static getter', () async {
      final d4rt = D4rt();
      final bundle = await d4rt.createBundleFromSource('''
class Flag {
  static bool ready = false;
  static void arm() { ready = true; }
}
bool main() {
  Flag.arm();
  return Flag.ready;
}
''');
      final runner = D4rtRunner();
      final result = runner.executeBundle(bundle);
      expect(result, true);
    });
  });
}
