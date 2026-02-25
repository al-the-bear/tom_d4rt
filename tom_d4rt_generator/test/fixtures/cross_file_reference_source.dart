/// Test fixture: Class that references types from another file.
/// Used to test GEN-055: Cross-file type resolution in method parameters.
///
/// This file imports [Interpreter] and [RuntimeConfig] from cross_file_type.dart
/// and uses them as method parameter types. The generator must resolve these
/// types to the correct import prefix (from cross_file_type.dart), not use
/// this file's prefix.

import 'cross_file_type.dart';

// Re-export so the type is technically available through this file too
export 'cross_file_type.dart';

/// A bridge registration class that has a static method accepting
/// a type from another file. This reproduces the bug where the generator
/// uses the declaring file's prefix instead of the type's actual source.
class BridgeRegistry {
  /// Register bridges with an optional interpreter from another file.
  /// The [interpreter] parameter type must resolve to cross_file_type.dart's
  /// import prefix, not this file's prefix.
  static void register([Interpreter? interpreter]) {
    // stub
  }

  /// Another method with a cross-file type parameter.
  static String getInfo(RuntimeConfig config) {
    return 'verbose: ${config.verbose}';
  }
}

/// A regular class that also uses cross-file types in instance methods.
class Worker {
  final String id;

  Worker(this.id);

  /// Method with cross-file type as parameter.
  void initialize(Interpreter interpreter, {RuntimeConfig? config}) {
    // stub
  }

  /// Method returning a cross-file type.
  RuntimeConfig getDefaultConfig() {
    return RuntimeConfig();
  }
}
