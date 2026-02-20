// D4rt test: CLS05 - Nullable field
// Verifies nullable fields (String?, int?) are handled correctly via bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // NullableFields has String? name, int? age, List<String>? tags
  var nf = NullableFields();

  // Initially all null
  if (nf.name != null) {
    errors.add('NullableFields().name expected null, got ${nf.name}');
  }
  if (nf.age != null) {
    errors.add('NullableFields().age expected null, got ${nf.age}');
  }

  // Set values
  nf.name = 'Alice';
  nf.age = 30;
  nf.tags = ['dart', 'test'];

  if (nf.name != 'Alice') {
    errors.add('name after set expected "Alice", got ${nf.name}');
  }
  if (nf.age != 30) {
    errors.add('age after set expected 30, got ${nf.age}');
  }
  if (nf.tags?.length != 2) {
    errors.add('tags after set expected length 2, got ${nf.tags?.length}');
  }

  // Set back to null
  nf.name = null;
  nf.age = null;
  if (nf.name != null) {
    errors.add('name after null assignment expected null, got ${nf.name}');
  }
  if (nf.age != null) {
    errors.add('age after null assignment expected null, got ${nf.age}');
  }

  // Constructor with named params
  var nf2 = NullableFields(name: 'Bob', age: 25);
  if (nf2.name != 'Bob') {
    errors.add('NullableFields(name: "Bob").name expected "Bob", got ${nf2.name}');
  }

  // Also test top-level nullable (currentUser is String?)
  var saved = currentUser;
  currentUser = null;
  if (currentUser != null) {
    errors.add('currentUser after null expected null, got $currentUser');
  }
  currentUser = 'Test';
  if (currentUser != 'Test') {
    errors.add('currentUser after "Test" expected "Test", got $currentUser');
  }
  currentUser = saved;

  if (errors.isEmpty) {
    print('CLS05_PASSED');
  } else {
    print('CLS05_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
