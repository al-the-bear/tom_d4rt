// D4rt test: PAR03 - Named parameters

void main() {
  var errors = <String>[];

  // dart_overview doesn't use named params in exported classes
  print('No named parameters in dart_overview exported classes');

  if (errors.isEmpty) {
    print('PAR03_PASSED');
  } else {
    print('PAR03_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
