/// Test fixture: Type defined in a separate file.
/// Used to test GEN-055: Cross-file type resolution in method parameters.
///
/// This file defines a type that will be referenced by a class
/// in another source file. The generator must resolve the type
/// to this file's import, not the importing file's import.

/// A type defined in this file, used as a parameter type in another file.
class Interpreter {
  final String name;

  Interpreter(this.name);

  void execute(String code) {
    // stub
  }
}

/// Another cross-file type for testing.
class RuntimeConfig {
  final bool verbose;
  final int timeout;

  RuntimeConfig({this.verbose = false, this.timeout = 30});
}
