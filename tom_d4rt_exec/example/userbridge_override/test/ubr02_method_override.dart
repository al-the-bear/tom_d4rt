// D4rt test: UBR02 - User bridge method override
//
// Tests that user bridge method overrides work on MyList.
// The operator[] and operator[]= on MyList are overridden by
// MyListUserBridge to handle generic type issues.

import 'package:userbridge_override_example/userbridge_override_example.dart';

void main() {
  var errors = <String>[];

  // ── MyList construction and basic methods (auto-generated) ───────

  var list = MyList();
  list.add(10);
  list.add(20);
  list.add(30);

  if (list.length != 3) errors.add('length expected 3, got ${list.length}');
  if (list.isEmpty) errors.add('isEmpty should be false');

  // ── operator[] (user bridge override) ────────────────────────────

  var first = list[0];
  if (first != 10) errors.add('list[0] expected 10, got $first');

  var second = list[1];
  if (second != 20) errors.add('list[1] expected 20, got $second');

  var third = list[2];
  if (third != 30) errors.add('list[2] expected 30, got $third');

  // ── operator[]= (user bridge override) ───────────────────────────

  list[1] = 99;
  var updated = list[1];
  if (updated != 99) errors.add('list[1] after set expected 99, got $updated');

  // ── remove() (auto-generated) ────────────────────────────────────

  list.remove(10);
  if (list.length != 2) errors.add('length after remove expected 2, got ${list.length}');

  // ── clear() (auto-generated) ─────────────────────────────────────

  list.clear();
  if (!list.isEmpty) errors.add('isEmpty after clear should be true');
  if (list.length != 0) errors.add('length after clear expected 0, got ${list.length}');

  // ── Summary ──────────────────────────────────────────────────────

  if (errors.isEmpty) {
    print('UBR02_PASSED');
  } else {
    print('UBR02_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
