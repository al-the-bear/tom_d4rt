import 'environment.dart';
import 'package:tom_d4rt_ast/ast.dart';

/// Callback signature for permission checking.
///
/// Returns true if the permission operation is allowed.
typedef PermissionChecker = bool Function(dynamic operation);

/// A loaded module with its AST and exported environment.
///
/// This class represents the result of loading a module via [ModuleContext].
class LoadedModule {
  /// The parsed AST of the module.
  final SCompilationUnit ast;

  /// The environment exported by this module.
  final Environment exportedEnvironment;

  /// The URI of the module.
  final Uri uri;

  LoadedModule({
    required this.ast,
    required this.exportedEnvironment,
    required this.uri,
  });
}

/// Abstract interface for module loading and context tracking.
///
/// This interface decouples the interpreter from the concrete module loading
/// implementation, allowing:
/// - tom_d4rt_ast to work with pre-parsed AST without analyzer dependency
/// - tom_d4rt_exec to provide full module loading with parser callback
///
/// The interpreter uses this interface to:
/// - Resolve relative import URIs against the current library
/// - Load modules when processing import directives
/// - Check permissions for security-sensitive operations
abstract class ModuleContext {
  /// The current library URI being executed.
  ///
  /// Used for resolving relative import URIs in import directives.
  /// Returns null if no base URI is set.
  Uri? get currentLibrary;

  /// Sets the current library URI.
  set currentLibrary(Uri? uri);

  /// The global environment shared across all modules.
  Environment get globalEnvironment;

  /// Checks if a permission is granted for the given operation.
  ///
  /// The operation can be any object (typically a Map or enum describing
  /// the type of permission needed).
  ///
  /// Returns true if the operation is allowed, false otherwise.
  /// Returns true by default if no permission checking is configured.
  bool checkPermission(dynamic operation);

  /// Loads a module from the given URI.
  ///
  /// [uri] The resolved URI of the module to load (package:, dart:, or file:).
  /// [showNames] Optional set of names to show (import ... show x, y).
  /// [hideNames] Optional set of names to hide (import ... hide x, y).
  ///
  /// Returns a [LoadedModule] containing the AST and exported environment.
  ///
  /// Throws [RuntimeD4rtException] if the module cannot be loaded.
  LoadedModule loadModule(
    Uri uri, {
    Set<String>? showNames,
    Set<String>? hideNames,
  });
}

/// A no-op module context for executing pre-parsed AST without import support.
///
/// Use this when:
/// - Executing single-file scripts without imports
/// - All imports are already resolved and inlined in the AST
/// - Testing interpreter functionality without module loading
///
/// Any attempt to load a module will throw an exception.
/// All permission checks return true (permissive mode).
class NoOpModuleContext implements ModuleContext {
  final Environment _globalEnvironment;
  final PermissionChecker? _permissionChecker;

  @override
  Uri? currentLibrary;

  NoOpModuleContext({
    Environment? globalEnvironment,
    PermissionChecker? permissionChecker,
  }) : _globalEnvironment = globalEnvironment ?? Environment(),
       _permissionChecker = permissionChecker;

  @override
  Environment get globalEnvironment => _globalEnvironment;

  @override
  bool checkPermission(dynamic operation) {
    // If a permission checker is provided, use it
    if (_permissionChecker != null) {
      return _permissionChecker(operation);
    }
    // Otherwise, be permissive (allow all)
    return true;
  }

  @override
  LoadedModule loadModule(
    Uri uri, {
    Set<String>? showNames,
    Set<String>? hideNames,
  }) {
    throw UnsupportedError(
      'NoOpModuleContext does not support module loading. '
      'Use a full ModuleContext implementation for import support.',
    );
  }
}
