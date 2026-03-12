// D4rt test: CLS10 - Explicit setter
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Rectangle.scale setter
  var rect = Rectangle(4.0, 2.0);
  rect.scale = 2.0;

  if (rect.width != 8.0) {
    errors.add('Rectangle.width after scale=2.0 expected 8.0, got ${rect.width}');
  }
  if (rect.height != 4.0) {
    errors.add('Rectangle.height after scale=2.0 expected 4.0, got ${rect.height}');
  }

  // Test scale again
  rect.scale = 0.5;
  if (rect.width != 4.0) {
    errors.add('Rectangle.width after scale=0.5 expected 4.0, got ${rect.width}');
  }
  if (rect.height != 2.0) {
    errors.add('Rectangle.height after scale=0.5 expected 2.0, got ${rect.height}');
  }

  if (errors.isEmpty) {
    print('CLS10_PASSED');
  } else {
    print('CLS10_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
