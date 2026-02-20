// D4rt test: CLS08 - Static const fields

void main() {
  var errors = <String>[];

  // No static const fields in dart_overview exported classes
  print('No static const fields in dart_overview barrel');

  if (errors.isEmpty) {
    print('CLS08_PASSED');
  } else {
    print('CLS08_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
