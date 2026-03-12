// D4rt test: CLS02 - Mutable field setters
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // Test Rectangle mutable fields (explicit ctor, not GEN-042)
  var rect = Rectangle(1.0, 1.0);
  rect.width = 5.0;
  if (rect.width != 5.0) {
    errors.add('Rectangle.width after set expected 5.0, got ${rect.width}');
  }
  rect.height = 3.0;
  if (rect.height != 3.0) {
    errors.add('Rectangle.height after set expected 3.0, got ${rect.height}');
  }

  // Test Wrapper mutable value
  var wrapper = Wrapper(1);
  wrapper.value = 99;
  if (wrapper.value != 99) {
    errors.add('Wrapper.value after set expected 99, got ${wrapper.value}');
  }

  if (errors.isEmpty) {
    print('CLS02_PASSED');
  } else {
    print('CLS02_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
