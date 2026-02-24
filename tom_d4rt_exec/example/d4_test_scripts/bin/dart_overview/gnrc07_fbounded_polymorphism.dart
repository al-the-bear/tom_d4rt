// D4rt test: GNRC07 - F-bounded polymorphism
// Verifies classes with Comparable<Self> (F-bounded) pattern work.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // SortablePerson implements Comparable<SortablePerson>
  // This is the F-bounded polymorphism pattern
  var alice = SortablePerson('Alice', 30);
  var bob = SortablePerson('Bob', 25);
  var charlie = SortablePerson('Charlie', 30);

  // Test compareTo returns expected type
  var cmp = alice.compareTo(bob);
  if (cmp.runtimeType != int) {
    errors.add('compareTo should return int, got ${cmp.runtimeType}');
  }

  // Test sorting (uses Comparable<SortablePerson>)
  var people = [charlie, alice, bob];
  people.sort();

  // After sort: Bob(25), Alice(30), Charlie(30)
  if (people[0].name != 'Bob') {
    errors.add('After sort, [0] expected Bob, got ${people[0].name}');
  }
  if (people[1].name != 'Alice') {
    errors.add('After sort, [1] expected Alice, got ${people[1].name}');
  }
  if (people[2].name != 'Charlie') {
    errors.add('After sort, [2] expected Charlie, got ${people[2].name}');
  }

  if (errors.isEmpty) {
    print('GNRC07_PASSED');
  } else {
    print('GNRC07_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
