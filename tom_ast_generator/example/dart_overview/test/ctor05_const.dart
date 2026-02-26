// D4rt test: CTOR05 - Const constructor
// Verifies const constructors are bridged and usable.
import 'package:dart_overview/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Color has a const constructor
  var c = Color(255, 128, 0);
  if (c.r != 255) {
    errors.add('Color.r expected 255, got ${c.r}');
  }
  if (c.g != 128) {
    errors.add('Color.g expected 128, got ${c.g}');
  }
  if (c.b != 0) {
    errors.add('Color.b expected 0, got ${c.b}');
  }

  // Static const fields (predefined colors)
  if (Color.red.r != 255) {
    errors.add('Color.red.r expected 255, got ${Color.red.r}');
  }
  if (Color.green.g != 255) {
    errors.add('Color.green.g expected 255, got ${Color.green.g}');
  }
  if (Color.blue.b != 255) {
    errors.add('Color.blue.b expected 255, got ${Color.blue.b}');
  }

  if (errors.isEmpty) {
    print('CTOR05_PASSED');
  } else {
    print('CTOR05_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
