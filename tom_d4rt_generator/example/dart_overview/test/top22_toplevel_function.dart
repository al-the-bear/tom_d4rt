// D4rt test: TOP22 - Top-level functions

void main() {
  var errors = <String>[];

  // No top-level functions in dart_overview barrel (they're all main() which is hidden)
  print('No top-level functions in dart_overview barrel');

  if (errors.isEmpty) {
    print('TOP22_PASSED');
  } else {
    print('TOP22_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
