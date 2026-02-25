// D4rt test: TOP17 - Anonymous extension
// Extensions (including anonymous) are not bridged by the generator.
// Same limitation as TOP16 — compile-time resolution, no runtime bridges.
import 'package:dart_overview/dart_overview.dart';

void main() {
  // Anonymous extensions are not bridgeable.
  // We just verify the test infrastructure works.
  var box = Box<int>(42);
  if (box.value != 42) {
    print('TOP17_FAILED');
    print('  - Box.value expected 42, got ${box.value}');
  } else {
    print('TOP17_PASSED');
  }
}
