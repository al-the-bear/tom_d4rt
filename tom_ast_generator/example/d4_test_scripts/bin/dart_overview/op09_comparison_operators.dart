// D4rt test: OP09 - Comparison operators (via Comparable)
// Verifies compareTo on bridged Comparable classes.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // SortablePerson implements Comparable<SortablePerson>
  var alice = SortablePerson('Alice', 30);
  var bob = SortablePerson('Bob', 25);
  var charlie = SortablePerson('Charlie', 30);

  // Bob (25) < Alice (30)
  var cmp1 = bob.compareTo(alice);
  if (cmp1 >= 0) {
    errors.add('Bob(25).compareTo(Alice(30)) expected negative, got $cmp1');
  }

  // Alice (30) > Bob (25)
  var cmp2 = alice.compareTo(bob);
  if (cmp2 <= 0) {
    errors.add('Alice(30).compareTo(Bob(25)) expected positive, got $cmp2');
  }

  // Alice (30) vs Charlie (30) — same age, compare by name: A < C
  var cmp3 = alice.compareTo(charlie);
  if (cmp3 >= 0) {
    errors.add('Alice(30).compareTo(Charlie(30)) expected negative (A < C), got $cmp3');
  }

  if (errors.isEmpty) {
    print('OP09_PASSED');
  } else {
    print('OP09_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
