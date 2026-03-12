// D4rt test: TOP29 - Mixin application (class = with)
// Verifies mixin application syntax works via bridges.
import 'package:d4_example/dart_overview.dart';

void main() {
  var errors = <String>[];

  // SerializablePrintable = Printable with Serializable
  var sp = SerializablePrintable();

  // Should have Printable's printInfo() method
  sp.printInfo(); // Just verify no crash

  // Should have Serializable's serialize() method
  var serialized = sp.serialize();
  if (serialized.isEmpty) {
    errors.add('serialize() returned empty string');
  }

  // Verify the combined type has methods from both
  // If we got here without errors, types work correctly

  if (errors.isEmpty) {
    print('TOP29_PASSED');
  } else {
    print('TOP29_FAILED');
    for (var e in errors) {
      print('  - $e');
    }
  }
}
