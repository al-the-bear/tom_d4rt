/// Annotation for D4rt user bridge classes.
///
/// This annotation marks a class as a user bridge override for a specific
/// library or class. User bridges allow custom implementations for bridge
/// members that the generator cannot handle correctly.
///
/// ## Usage
///
/// Apply this annotation to classes extending `D4UserBridge`:
///
/// ```dart
/// // Override all elements from a specific library
/// @D4rtUserBridge('package:tom_basics/src/log/tom_log.dart')
/// class TomLogUserBridge extends D4UserBridge {
///   static Object? overrideMethodLog(...) { ... }
/// }
///
/// // Override a specific class in a library (for same-name classes)
/// @D4rtUserBridge('package:tom_basics/src/log/tom_log.dart', 'TomLog')
/// class TomLogUserBridge extends D4UserBridge {
///   static Object? overrideMethodLog(...) { ... }
/// }
/// ```
///
/// ## Parameters
///
/// - `libraryPath`: The full package URI of the library containing the
///   elements to override. Format: `package:package_name/path/to/file.dart`
///
/// - `className` (optional): The specific class name to override. If not
///   provided, the bridge can provide overrides for any class in the library.
///   Use this when multiple classes in different libraries have the same name.
///
/// ## Placement
///
/// User bridge classes should be placed in the `lib/src/d4rt_user_bridges/`
/// folder (or `lib/d4rt_user_bridges/` for console apps) of the project
/// that generates the bridges (the project with build.yaml).
library;

/// Annotation to mark a class as a D4rt user bridge override.
///
/// User bridges provide custom implementations for specific bridge members
/// that the generator cannot handle correctly (e.g., operators, complex
/// generics, or classes needing `nativeNames`).
///
/// Example:
/// ```dart
/// @D4rtUserBridge('package:tom_basics/src/log/tom_log.dart')
/// class TomLogUserBridge extends D4UserBridge {
///   static List<String> get nativeNames => ['_TomLogImpl'];
///
///   static Object? overrideMethodLog(
///     Object? visitor,
///     Object? target,
///     List<Object?> positional,
///     Map<String, Object?> named,
///   ) {
///     // Custom implementation
///   }
/// }
/// ```
class D4rtUserBridge {
  /// The library path containing the elements to override.
  ///
  /// Format: `package:package_name/path/to/file.dart`
  final String libraryPath;

  /// Optional: The specific class name to override.
  ///
  /// If not provided, the bridge can provide overrides for any class
  /// in the library. Use this when multiple classes in different
  /// libraries have the same name.
  final String? className;

  /// Creates a D4rtUserBridge annotation.
  ///
  /// - [libraryPath]: The full package URI of the library to override.
  /// - [className]: Optional specific class name to override.
  const D4rtUserBridge(this.libraryPath, [this.className]);
}

/// Annotation to mark a class as a D4rt globals user bridge override.
///
/// Globals user bridges provide custom implementations for top-level
/// functions, variables, and getters from a specific library.
///
/// Example:
/// ```dart
/// @D4rtGlobalsUserBridge('package:tom_basics/src/utils/helpers.dart')
/// class HelpersGlobalsUserBridge extends D4UserBridge {
///   static Object? overrideGlobalFunctionHelper(...) { ... }
/// }
/// ```
class D4rtGlobalsUserBridge {
  /// The library path containing the global elements to override.
  ///
  /// Format: `package:package_name/path/to/file.dart`
  final String libraryPath;

  /// Creates a D4rtGlobalsUserBridge annotation.
  ///
  /// - [libraryPath]: The full package URI of the library with globals.
  const D4rtGlobalsUserBridge(this.libraryPath);
}
