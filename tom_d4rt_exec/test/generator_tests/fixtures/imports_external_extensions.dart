/// Test fixture: Source file that imports external extensions.
/// Used to test GEN-049: Extension methods on bridged classes from imports.

// Import the file containing extensions - this tests import-based discovery
import 'external_extensions.dart';

// Re-export to ensure extensions are in scope
export 'external_extensions.dart';

/// A simple class to be bridged
class TestClass {
  final String name;
  final int value;
  
  TestClass(this.name, this.value);
  
  /// Use the imported extension to verify it works
  int get doubledValue => value.doubled;
}

/// A function that uses the imported extension
int processValue(int x) {
  return x.doubled + x.plus(10);
}
