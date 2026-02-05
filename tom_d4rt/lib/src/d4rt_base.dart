import 'package:analyzer/dart/analysis/features.dart';
import 'package:analyzer/dart/analysis/utilities.dart';
import 'package:analyzer/error/error.dart';
import 'package:tom_d4rt/src/bridge/bridged_enum.dart';
import 'package:tom_d4rt/src/utils/logger/logger.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:tom_d4rt/src/bridge/bridged_types.dart';
import 'package:tom_d4rt/src/runtime_types.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:tom_d4rt/src/environment.dart';
import 'package:tom_d4rt/src/interpreter_visitor.dart';
import 'package:tom_d4rt/src/module_loader.dart';
import 'package:tom_d4rt/src/exceptions.dart';
import 'package:tom_d4rt/src/callable.dart';
import 'package:tom_d4rt/src/declaration_visitor.dart';
import 'package:tom_d4rt/src/stdlib/stdlib.dart';
import 'package:tom_d4rt/src/bridge/registration.dart';
import 'package:tom_d4rt/src/security/permissions.dart';
import 'package:tom_d4rt/src/introspection.dart';

/// Wrapper class for library-scoped variables.
/// Stores a variable name, its value, and optionally its canonical source URI
/// for deduplication across re-exports.
class LibraryVariable {
  final String name;
  final Object? value;
  
  /// The canonical source URI where this variable is defined.
  /// 
  /// Used for deduplication: when the same variable is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server both
  /// re-export tom_basics), we need to recognize they're the same element.
  /// Format: `package:pkg_name/path/to/source.dart`
  final String? sourceUri;
  
  const LibraryVariable(this.name, this.value, {this.sourceUri});
}

/// Wrapper class for library-scoped getters.
/// Stores a getter name, its function, and optionally its canonical source URI
/// for deduplication across re-exports.
class LibraryGetter {
  final String name;
  final Object? Function() getter;
  
  /// The canonical source URI where this getter is defined.
  /// See [LibraryVariable.sourceUri] for details.
  final String? sourceUri;
  
  const LibraryGetter(this.name, this.getter, {this.sourceUri});
}

/// Wrapper class for library-scoped functions.
/// Stores a native function with its canonical source URI for deduplication.
class LibraryFunction {
  final NativeFunction function;
  
  /// The canonical source URI where this function is defined.
  /// See [LibraryVariable.sourceUri] for details.
  final String? sourceUri;

  /// The full signature of the function as a display string.
  final String? signature;
  
  const LibraryFunction(this.function, {this.sourceUri, this.signature});
  
  /// Convenience getter for the function name.
  String get name => function.name;
}

/// Wrapper class for library-scoped bridged classes.
/// Stores a bridged class with its canonical source URI for deduplication.
class LibraryClass {
  final BridgedClass bridgedClass;
  
  /// The canonical source URI where this class is defined.
  /// See [LibraryVariable.sourceUri] for details.
  final String? sourceUri;
  
  const LibraryClass(this.bridgedClass, {this.sourceUri});
  
  /// Convenience getter for the class name.
  String get name => bridgedClass.name;
}

/// Wrapper class for library-scoped bridged enums.
/// Stores a bridged enum with its canonical source URI for deduplication.
class LibraryEnum {
  final BridgedEnumDefinition enumDefinition;
  
  /// The canonical source URI where this enum is defined.
  /// See [LibraryVariable.sourceUri] for details.
  final String? sourceUri;
  
  const LibraryEnum(this.enumDefinition, {this.sourceUri});
  
  /// Convenience getter for the enum name.
  String get name => enumDefinition.name;
}

/// The main D4rt interpreter class.
///
/// This class provides the primary interface for executing Dart code at runtime.
/// It manages the interpretation environment, handles bridged types, and provides
/// methods for code execution with proper error handling and debugging support.
///
/// ## Example:
/// ```dart
/// final interpreter = D4rt();
///
/// // Register a bridged class to make native types available in interpreted code
/// interpreter.registerBridgedClass(myBridgedClass, 'my_library');
///
/// // Execute Dart code
/// final result = await interpreter.execute(source: '''
///   void main() {
///     print("Hello from D4rt!");
///   }
/// ''');
/// ```
class D4rt {
  final List<Map<String, LibraryEnum>> _bridgedEnumDefinitions = [];
  final List<Map<String, LibraryClass>> _bridgedClases = [];
  InterpretedInstance? _interpretedInstance;
  InterpreterVisitor? _visitor;
  final Map<Type, BridgedClass> _bridgedDefLookupByType = {};
  final Set<Permission> _grantedPermissions = {};

  /// Gets the current interpreter visitor instance.
  ///
  /// Returns null if no execution is currently in progress.
  InterpreterVisitor? get visitor => _visitor;
  
  // Library-scoped globals (registered with library path) - added when import is processed
  // Structure matches classes/enums: List of {libraryPath: definition}
  // For functions: use LibraryFunction wrapper that includes sourceUri for deduplication
  // For variables/getters: wrapper classes contain name, value/getter, and sourceUri
  final List<Map<String, LibraryFunction>> _libraryFunctions = [];
  final List<Map<String, LibraryVariable>> _libraryVariables = [];
  final List<Map<String, LibraryGetter>> _libraryGetters = [];

  late ModuleLoader _moduleLoader;
  bool _hasExecutedOnce = false;

  /// Registers a bridged enum definition for use in interpreted code.
  ///
  /// [definition] The enum definition containing the native enum type and its values.
  /// [library] The library identifier where this enum should be available.
  /// [sourceUri] The canonical source URI where this enum is defined.
  ///   Used for deduplication when the same enum is exported through multiple barrels.
  void registerBridgedEnum(BridgedEnumDefinition definition, String library, {String? sourceUri}) {
    final libEnum = LibraryEnum(definition, sourceUri: sourceUri);
    _bridgedEnumDefinitions.add({library: libEnum});
  }

  /// Registers a bridged class definition for use in interpreted code.
  ///
  /// This allows native Dart classes to be accessible and instantiable
  /// from within interpreted code, enabling seamless integration between
  /// native and interpreted environments.
  ///
  /// [definition] The class definition containing constructors, methods, and properties.
  /// [library] The library identifier where this class should be available.
  /// [sourceUri] The canonical source URI where this class is defined.
  ///   Used for deduplication when the same class is exported through multiple barrels.
  void registerBridgedClass(BridgedClass definition, String library, {String? sourceUri}) {
    final libClass = LibraryClass(definition, sourceUri: sourceUri);
    _bridgedClases.add({library: libClass});
    _bridgedDefLookupByType[definition.nativeType] = definition;
  }

  /// Registers a top-level native function for use in interpreted code.
  ///
  /// [name] The name by which the function will be accessible in interpreted code.
  /// [function] The native function implementation to be called.
  /// [library] The library path (package URI) where this function is exported from.
  ///   The function is only added to the environment when this library is imported.
  /// [sourceUri] The canonical source URI where this function is defined.
  ///   Used for deduplication when the same function is exported through multiple barrels.
  /// [signature] The full signature of the function as a display string.
  void registertopLevelFunction(String? name, NativeFunctionImpl function, String library, {String? sourceUri, String? signature}) {
    final nativeFunc = NativeFunction(function, name: name, arity: 0);
    final libFunc = LibraryFunction(nativeFunc, sourceUri: sourceUri, signature: signature);
    _libraryFunctions.add({library: libFunc});
  }

  /// Registers a global variable for use in interpreted code.
  ///
  /// This allows native Dart objects to be accessible as top-level variables
  /// in interpreted code when the corresponding library is imported.
  ///
  /// [name] The name by which the variable will be accessible in interpreted code.
  /// [value] The value to bind to the variable. Can be any Dart object.
  /// [library] The library path (package URI) where this variable is exported from.
  ///   The variable is only added to the environment when this library is imported.
  /// [sourceUri] The canonical source URI where this variable is defined.
  ///   Used for deduplication when the same variable is exported through multiple barrels.
  ///
  /// ## Example:
  /// ```dart
  /// final interpreter = D4rt();
  /// interpreter.registerGlobalVariable('config', {'debug': true}, 'package:my_app/my_app.dart');
  /// interpreter.registerGlobalVariable('appName', 'MyApp', 'package:my_app/my_app.dart');
  /// ```
  void registerGlobalVariable(String name, Object? value, String library, {String? sourceUri}) {
    _libraryVariables.add({library: LibraryVariable(name, value, sourceUri: sourceUri)});
  }

  /// Registers a global getter for use in interpreted code.
  ///
  /// Unlike [registerGlobalVariable], this registers a getter function that
  /// is evaluated each time the variable is accessed. This is useful for
  /// variables whose values may not be available at registration time, or
  /// whose values may change over time.
  ///
  /// [name] The name by which the variable will be accessible in interpreted code.
  /// [getter] A function that returns the current value when called.
  /// [library] The library path (package URI) where this getter is exported from.
  ///   The getter is only added to the environment when this library is imported.
  /// [sourceUri] The canonical source URI where this getter is defined.
  ///   Used for deduplication when the same getter is exported through multiple barrels.
  ///
  /// ## Example:
  /// ```dart
  /// final interpreter = D4rt();
  /// interpreter.registerGlobalGetter('currentTime', () => DateTime.now(), 'package:my_app/my_app.dart');
  /// ```
  void registerGlobalGetter(String name, Object? Function() getter, String library, {String? sourceUri}) {
    _libraryGetters.add({library: LibraryGetter(name, getter, sourceUri: sourceUri)});
  }

  ModuleLoader _initModule(Map<String, String>? sources,
      {String? basePath, bool allowFileSystemImports = false}) {
    final moduleLoader = ModuleLoader(
      Environment(),
      sources ?? {},
      _bridgedEnumDefinitions,
      _bridgedClases,
      libraryFunctions: _libraryFunctions,
      libraryVariables: _libraryVariables,
      libraryGetters: _libraryGetters,
      d4rt: this,
    );
    _visitor = InterpreterVisitor(
        globalEnvironment: moduleLoader.globalEnvironment,
        moduleLoader: moduleLoader);
    Stdlib(moduleLoader.globalEnvironment).register();
    return moduleLoader;
  }

  /// Enables or disables debug logging for the interpreter.
  ///
  /// When enabled, the interpreter will output detailed information about
  /// execution flow, variable lookups, method calls, and other internal operations.
  ///
  /// [enabled] Whether to enable debug logging.
  void setDebug(bool enabled) => Logger.setDebug(enabled);

  /// Grants a permission for security-sensitive operations.
  ///
  /// This method allows granting specific permissions that are required for
  /// accessing dangerous modules like dart:io, dart:isolate, or performing
  /// file system operations, network access, or process execution.
  ///
  /// [permission] The permission to grant.
  ///
  /// ## Example:
  /// ```dart
  /// final interpreter = D4rt();
  /// interpreter.grant(FilesystemPermission.any);
  /// interpreter.grant(NetworkPermission.any);
  /// ```
  void grant(Permission permission) {
    _grantedPermissions.add(permission);
    Logger.debug("[D4rt.grant] Granted permission: ${permission.description}");
  }

  /// Revokes a previously granted permission.
  ///
  /// [permission] The permission to revoke.
  void revoke(Permission permission) {
    _grantedPermissions.remove(permission);
    Logger.debug("[D4rt.revoke] Revoked permission: ${permission.description}");
  }

  /// Checks if a specific permission is granted.
  ///
  /// [permission] The permission to check.
  /// Returns true if the permission is granted, false otherwise.
  bool hasPermission(Permission permission) {
    return _grantedPermissions.contains(permission);
  }

  /// Checks if any permission in the granted set allows the given operation.
  ///
  /// [operation] The operation to check permissions for.
  /// Returns true if any granted permission allows the operation.
  bool checkPermission(dynamic operation) {
    for (final permission in _grantedPermissions) {
      if (permission.allows(operation)) {
        return true;
      }
    }
    return false;
  }

  /// Returns a complete configuration snapshot of this interpreter instance.
  ///
  /// This method provides a comprehensive view of the interpreter's current state,
  /// including all registered bridges (classes, enums), permissions, global variables,
  /// and other settings.
  ///
  /// ## Example:
  /// ```dart
  /// final interpreter = D4rt();
  /// interpreter.registerBridgedClass(myClass, 'package:my_lib/my_lib.dart');
  /// interpreter.grant(FilesystemPermission.read);
  /// interpreter.registerGlobalVariable('config', {'debug': true});
  ///
  /// final config = interpreter.getConfiguration();
  /// print(jsonEncode(config.toJson()));
  /// ```
  D4rtConfiguration getConfiguration() {
    // Build imports map from registered bridges
    final importsMap = <String, ImportConfiguration>{};

    // Process bridged classes
    for (final entry in _bridgedClases) {
      for (final MapEntry(:key, :value) in entry.entries) {
        final importPath = key;
        final libClass = value;
        final bridgedClass = libClass.bridgedClass;

        final classInfo = BridgedClassInfo(
          name: bridgedClass.name,
          nativeTypeName: bridgedClass.nativeType.toString(),
          constructors: bridgedClass.constructors.keys.toList(),
          methods: bridgedClass.methods.keys.toList(),
          getters: bridgedClass.getters.keys.toList(),
          setters: bridgedClass.setters.keys.toList(),
          staticMethods: bridgedClass.staticMethods.keys.toList(),
          staticGetters: bridgedClass.staticGetters.keys.toList(),
          staticSetters: bridgedClass.staticSetters.keys.toList(),
          constructorSignatures: bridgedClass.constructorSignatures,
          methodSignatures: bridgedClass.methodSignatures,
          getterSignatures: bridgedClass.getterSignatures,
          setterSignatures: bridgedClass.setterSignatures,
          staticMethodSignatures: bridgedClass.staticMethodSignatures,
          staticGetterSignatures: bridgedClass.staticGetterSignatures,
          staticSetterSignatures: bridgedClass.staticSetterSignatures,
        );

        if (importsMap.containsKey(importPath)) {
          final existing = importsMap[importPath]!;
          importsMap[importPath] = ImportConfiguration(
            importPath: importPath,
            classes: [...existing.classes, classInfo],
            enums: existing.enums,
          );
        } else {
          importsMap[importPath] = ImportConfiguration(
            importPath: importPath,
            classes: [classInfo],
            enums: [],
          );
        }
      }
    }

    // Process bridged enums
    for (final entry in _bridgedEnumDefinitions) {
      for (final MapEntry(:key, :value) in entry.entries) {
        final importPath = key;
        final libEnum = value;
        final enumDef = libEnum.enumDefinition;

        final enumInfo = BridgedEnumInfo(
          name: enumDef.name,
          values: enumDef.values.map((e) => e.name).toList(),
        );

        if (importsMap.containsKey(importPath)) {
          final existing = importsMap[importPath]!;
          importsMap[importPath] = ImportConfiguration(
            importPath: importPath,
            classes: existing.classes,
            enums: [...existing.enums, enumInfo],
          );
        } else {
          importsMap[importPath] = ImportConfiguration(
            importPath: importPath,
            classes: [],
            enums: [enumInfo],
          );
        }
      }
    }

    // Build permissions list
    final permissions = _grantedPermissions
        .map((p) => PermissionInfo(
              type: p.type,
              description: p.description,
            ))
        .toList();

    // Build global variables list from library-scoped variables
    final globalVariables = <GlobalVariableInfo>[];
    for (final entry in _libraryVariables) {
      for (final MapEntry(key: libraryUri, value: variable)
          in entry.entries) {
        globalVariables.add(GlobalVariableInfo(
          name: variable.name,
          valueType: variable.value?.runtimeType.toString() ?? 'Null',
          libraryUri: libraryUri,
        ));
      }
    }

    // Build global getters list from library-scoped getters
    final globalGetters = <GlobalGetterInfo>[];
    for (final entry in _libraryGetters) {
      for (final MapEntry(key: libraryUri, value: getter) in entry.entries) {
        globalGetters.add(GlobalGetterInfo(
          name: getter.name,
          libraryUri: libraryUri,
        ));
      }
    }

    // Build global functions list from library-scoped functions
    final globalFunctions = <GlobalFunctionInfo>[];
    final seenFunctions = <String>{};
    for (final entry in _libraryFunctions) {
      for (final MapEntry(key: libraryUri, value: func) in entry.entries) {
        final name = func.name;
        if (name != '<native>' && !seenFunctions.contains(name)) {
          seenFunctions.add(name);
          globalFunctions.add(GlobalFunctionInfo(
            name: name,
            libraryUri: libraryUri,
            signature: func.signature,
          ));
        }
      }
    }

    return D4rtConfiguration(
      imports: importsMap.values.toList(),
      permissions: permissions,
      globalVariables: globalVariables,
      globalGetters: globalGetters,
      globalFunctions: globalFunctions,
      debugEnabled: Logger.debugEnabled,
    );
  }

  /// Returns the current state of the global environment.
  ///
  /// This captures what variables, bridged classes, and bridged enums
  /// are currently defined in the interpreter's global environment.
  /// This is useful for debugging and introspection to see what names
  /// are actually available for use in scripts.
  ///
  /// Returns null if no execution has occurred yet.
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  /// d4rt.addBridges(SomeBridges.bridges);
  /// d4rt.execute(source: 'var x = 42;');
  /// final state = d4rt.getEnvironmentState();
  /// print(state?.variables); // Shows 'x' and any registered globals
  /// print(state?.bridgedClasses); // Shows registered bridged classes
  /// ```
  EnvironmentState? getEnvironmentState() {
    if (!_hasExecutedOnce) {
      return null;
    }

    final globalEnv = _moduleLoader.globalEnvironment;

    // Get all variables from the global environment
    final variables = <EnvironmentVariableInfo>[];
    for (final entry in globalEnv.values.entries) {
      variables.add(EnvironmentVariableInfo(
        name: entry.key,
        valueType: entry.value?.runtimeType.toString() ?? 'Null',
        isNull: entry.value == null,
      ));
    }

    // Get bridged class names
    final bridgedClasses = globalEnv.bridgedClassNames;

    // Get bridged enum names
    final bridgedEnums = globalEnv.bridgedEnumNames;

    return EnvironmentState(
      variables: variables,
      bridgedClasses: bridgedClasses,
      bridgedEnums: bridgedEnums,
    );
  }

  /// Execute the given source code.
  ///
  /// [source] The source code to execute. If not provided, the main source will be loaded from the given library.
  ///
  /// [name] The name of the function to call. Defaults to 'main'.
  ///
  /// [positionalArgs] The positional arguments to pass to the function.
  ///
  /// [namedArgs] The named arguments to pass to the function.
  ///
  /// [args] @deprecated Use [positionalArgs] instead. Legacy argument passing (will be wrapped in a list).
  ///
  /// [library] The URI of the named function source to load. example: 'package:my_package/main.dart' (if provided, the source parameter will be ignored).
  ///
  /// [sources] The sources to load. example: {'package:my_package/main.dart': 'main() { return "Hello, World!"; }'}
  ///
  /// [basePath] Base directory path for resolving relative imports from the filesystem.
  /// When provided, relative imports (e.g., './utils.dart', '../models/user.dart')
  /// will be resolved against this path.
  ///
  /// [allowFileSystemImports] Whether to allow loading modules from the filesystem.
  /// When true, relative imports and file:// URIs will be resolved and loaded from disk.
  /// Requires FilesystemPermission when using D4rt's permission system.
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  ///
  /// // Simple execution
  /// d4rt.execute(source: 'main() => "Hello";');
  ///
  /// // With positional arguments
  /// d4rt.execute(
  ///   source: 'greet(String name, int age) => "Hello \$name, you are \$age";',
  ///   name: 'greet',
  ///   positionalArgs: ['John', 25],
  /// );
  ///
  /// // With named arguments
  /// d4rt.execute(
  ///   source: 'greet({required String name, int age = 0}) => "Hello \$name, \$age";',
  ///   name: 'greet',
  ///   namedArgs: {'name': 'John', 'age': 30},
  /// );
  ///
  /// // Mixed positional and named arguments
  /// d4rt.execute(
  ///   source: 'greet(String greeting, {required String name}) => "\$greeting \$name";',
  ///   name: 'greet',
  ///   positionalArgs: ['Hello'],
  ///   namedArgs: {'name': 'World'},
  /// );
  ///
  /// // With relative imports from filesystem
  /// d4rt.grant(FilesystemPermission.any);
  /// d4rt.execute(
  ///   source: '''
  ///     import './utils.dart';
  ///     main() => greetFromUtils();
  ///   ''',
  ///   basePath: '/path/to/project/lib',
  ///   allowFileSystemImports: true,
  /// );
  /// ```
  dynamic execute({
    String? source,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
    @Deprecated('Use positionalArgs instead') Object? args,
    String? library,
    Map<String, String>? sources,
    String? basePath,
    bool allowFileSystemImports = false,
  }) {
    // Handle deprecated args parameter
    if (args != null && positionalArgs != null) {
      throw ArgumentError(
          'Cannot use both "args" (deprecated) and "positionalArgs". Use only "positionalArgs".');
    }
    if (args != null) {
      Logger.warn(
          '[D4rt.execute] The "args" parameter is deprecated. Use "positionalArgs" instead.');
      positionalArgs = [args];
    }

    // Initialize a fresh module loader (resets global environment)
    _moduleLoader = _initModule(sources,
        basePath: basePath, allowFileSystemImports: allowFileSystemImports);

    // Parse the source
    final compilationUnit = _parseSource(source: source, library: library);

    // Library-scoped globals are registered via ModuleLoader when imports are processed
    final executionEnvironment = _moduleLoader.globalEnvironment;

    // Execute and return result
    return _executeInEnvironment(
      compilationUnit: compilationUnit,
      executionEnvironment: executionEnvironment,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
      library: library,
    );
  }

  /// Execute additional source code in the existing global context.
  ///
  /// Unlike [execute], this method does NOT reset the global environment.
  /// It reuses the existing module loader and environment from a previous
  /// [execute] call, allowing you to add more declarations and call functions
  /// while preserving all previously defined variables, functions, and classes.
  ///
  /// **Important**: You must call [execute] at least once before calling
  /// [continuedExecute] to establish the execution context.
  ///
  /// [source] The source code to execute.
  ///
  /// [name] The name of the function to call. Defaults to 'main'.
  ///
  /// [positionalArgs] The positional arguments to pass to the function.
  ///
  /// [namedArgs] The named arguments to pass to the function.
  ///
  /// [library] The URI of the named function source to load.
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  ///
  /// // Initial execution sets up context
  /// d4rt.execute(source: 'void main() {}');
  ///
  /// // Add more declarations without resetting
  /// d4rt.continuedExecute(source: '''
  ///   int square(int x) => x * x;
  ///   void main() {}
  /// ''');
  ///
  /// // The square function is now available
  /// final result = d4rt.eval('square(5)'); // Returns 25
  /// ```
  dynamic continuedExecute({
    String? source,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
    String? library,
  }) {
    if (!_hasExecutedOnce) {
      throw RuntimeError(
          'continuedExecute() requires an existing execution context. Call execute() first.');
    }

    Logger.debug("[D4rt.continuedExecute] Continuing execution in existing context. library: $library");

    // Parse the source (reuses existing module loader for library resolution)
    final compilationUnit = _parseSource(source: source, library: library);

    // Reuse existing environment - don't register globals again
    final executionEnvironment = _moduleLoader.globalEnvironment;

    // Execute and return result
    return _executeInEnvironment(
      compilationUnit: compilationUnit,
      executionEnvironment: executionEnvironment,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
      library: library,
    );
  }

  /// Parse source code into a CompilationUnit.
  CompilationUnit _parseSource({String? source, String? library}) {
    if (library != null) {
      Logger.debug(
          "[D4rt._parseSource] Attempting to load source via ModuleLoader for URI: $library");

      if (!_moduleLoader.sources.containsKey(library.toString())) {
        final errorMessage =
            "[D4rt._parseSource] The source URI '$library' was not found in sources.";
        Logger.error(errorMessage);
        throw SourceCodeException(errorMessage);
      }

      if (source?.isNotEmpty ?? false) {
        Logger.warn(
            "[D4rt._parseSource] The 'source' parameter is not empty but 'library' ($library) is used to load from sources. The 'source' string will be ignored.");
      }

      try {
        final loadedRootModule = _moduleLoader.loadModule(Uri.parse(library));
        Logger.debug(
            "[D4rt._parseSource] Source loaded and parsed successfully via ModuleLoader for $library.");
        return loadedRootModule.ast;
      } catch (e) {
        Logger.error(
            "[D4rt._parseSource] Failed to load source $library via ModuleLoader: $e");
        if (e is SourceCodeException || e is RuntimeError) {
          rethrow;
        } else {
          throw Exception(
              "Unexpected failure to load initial module $library: $e");
        }
      }
    } else {
      if (source == null) {
        throw Exception('Source content must be provided');
      }
      Logger.debug(
          "[D4rt._parseSource] Parsing the provided source string directly (no source URI).");
      final result = parseString(
        content: source,
        throwIfDiagnostics: false,
        featureSet: FeatureSet.fromEnableFlags2(
          sdkLanguageVersion: Version(3, 10, 0),
          flags: [
            'non-nullable',
            'null-aware-elements',
            'triple-shift',
            'spread-collections',
            'control-flow-collections',
            'extension-methods',
            'extension-types',
          'digit-separators',
          ],
        ),
      );

      final errors = result.errors
          .where((e) => e.errorCode.errorSeverity == ErrorSeverity.ERROR)
          .toList();
      if (errors.isNotEmpty) {
        final errorMessages = errors.map((e) {
          final location = result.lineInfo.getLocation(e.offset);
          return "- ${e.message} (line ${location.lineNumber}, column ${location.columnNumber})";
        }).join("\n");
        Logger.error("Parsing errors for the direct source:\n$errorMessages");
        throw SourceCodeException(
            'Fatal parsing errors for the direct source:\n$errorMessages', source);
      }
      Logger.debug("[D4rt._parseSource] Direct source string parsed successfully.");
      return result.unit;
    }
  }

  /// Execute a parsed CompilationUnit in the given environment.
  dynamic _executeInEnvironment({
    required CompilationUnit compilationUnit,
    required Environment executionEnvironment,
    required String name,
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
    String? library,
  }) {
    Logger.debug("[_executeInEnvironment] Starting Pass 1: Declaration");
    final declarationVisitor = DeclarationVisitor(executionEnvironment);
    for (final declaration in compilationUnit.declarations) {
      declaration.accept<void>(declarationVisitor);
    }
    Logger.debug("[_executeInEnvironment] Finished Pass 1: Declaration");

    _visitor = InterpreterVisitor(
        globalEnvironment: executionEnvironment,
        moduleLoader: _moduleLoader,
        initiallibrary: library != null ? Uri.parse(library) : null);
    Object? functionResult;
    try {
      Logger.debug("[_executeInEnvironment] Starting Pass 2: Interpretation");
      Logger.debug(
          "[_executeInEnvironment] Processing directives (imports, exports, etc.)...");
      for (final directive in compilationUnit.directives) {
        if (directive is ImportDirective) {
          Logger.debug(
              "[_executeInEnvironment]   - Processing ImportDirective: ${directive.uri.stringValue}");
          _visitor!.visitImportDirective(directive);
        } else {
          Logger.debug(
              "[_executeInEnvironment]   - Skipping directive of type: ${directive.runtimeType}");
        }
      }
      Logger.debug("[_executeInEnvironment] Finished processing directives.");

      Logger.debug("[_executeInEnvironment] Processing ALL declarations sequentially");

      Logger.debug("[_executeInEnvironment] Top-level declarations for Pass 2:");
      for (final declaration in compilationUnit.declarations) {
        Logger.debug("[_executeInEnvironment]   - ${declaration.runtimeType}");
      }

      for (final declaration in compilationUnit.declarations) {
        declaration.accept<Object?>(_visitor!);
      }
      Logger.debug("[_executeInEnvironment] Finished processing declarations");
      Logger.debug("[_executeInEnvironment] Looking for $name function");
      final functionCallable = executionEnvironment.get(name);
      if (functionCallable is Callable) {
        List<Object?> interpreterArgs = positionalArgs ?? [];
        final Map<String, Object?> interpreterNamedArgs = namedArgs ?? {};

        // Special handling for 'main' function: if it expects args but none provided,
        // pass an empty list automatically (standard Dart behavior)
        final expectedArity = functionCallable.arity;
        if (name == 'main' &&
            expectedArity > 0 &&
            interpreterArgs.isEmpty &&
            namedArgs?.isEmpty != false) {
          // main expects args but none were provided - pass empty list
          interpreterArgs = [<String>[]];
          Logger.debug(
              "[_executeInEnvironment] 'main' expects arguments but none provided. Passing empty list.");
        }

        // Validate arity (only for positional args, named args are validated by the function itself)
        if (interpreterArgs.length > expectedArity) {
          throw RuntimeError(
              "'$name' function accepts at most $expectedArity positional argument(s), but ${interpreterArgs.length} were provided.");
        }

        Logger.debug(
            "[_executeInEnvironment] Calling '$name' with positionalArgs: $interpreterArgs, namedArgs: $interpreterNamedArgs");

        functionResult = functionCallable.call(
            _visitor!, interpreterArgs, interpreterNamedArgs);
      } else {
        throw Exception(
            "No callable '$name' function found in the test source code.");
      }
      Logger.debug("[_executeInEnvironment] Finished Pass 2: Interpretation");
    } on InternalInterpreterException catch (e) {
      if (e.originalThrownValue is RuntimeError) {
        throw e.originalThrownValue as RuntimeError;
      } else {
        throw e.originalThrownValue!;
      }
    } catch (e) {
      if (e is RuntimeError) {
        rethrow;
      } else {
        throw RuntimeError('Unexpected error: $e');
      }
    }
    if (functionResult is InterpretedInstance) {
      _interpretedInstance = functionResult;
    }
    final resultValue = _bridgeInterpreterValueToNative(functionResult);
    if (resultValue is Future) {
      try {
        _hasExecutedOnce = true;
        return resultValue
            .then((value) => _bridgeInterpreterValueToNative(value));
      } on InternalInterpreterException catch (e) {
        if (e.originalThrownValue is RuntimeError) {
          throw e.originalThrownValue as RuntimeError;
        } else {
          throw e.originalThrownValue!;
        }
      } catch (e) {
        if (e is RuntimeError) {
          rethrow;
        } else {
          throw RuntimeError('Unexpected error: $e');
        }
      }
    }
    _hasExecutedOnce = true;
    return resultValue;
  }

  // ============================================================================
  // _executeClassic - PRESERVED FOR DEBUGGING REFERENCE
  // ============================================================================
  // DO NOT MODIFY OR DELETE THIS METHOD!
  // This is a backup copy of the original execute() implementation before
  // refactoring. It is kept for reference during debugging in case the
  // refactored version has issues that need comparison with the original logic.
  // ============================================================================
  // TODO: Remove this legacy method once all code uses the new execution path
  // and has been thoroughly tested in production.
  // ignore: unused_element
  dynamic _executeClassic({
    String? source,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
    @Deprecated('Use positionalArgs instead') Object? args,
    String? library,
    Map<String, String>? sources,
    String? basePath,
    bool allowFileSystemImports = false,
  }) {
    // Handle deprecated args parameter
    if (args != null && positionalArgs != null) {
      throw ArgumentError(
          'Cannot use both "args" (deprecated) and "positionalArgs". Use only "positionalArgs".');
    }
    if (args != null) {
      Logger.warn(
          '[D4rt._executeClassic] The "args" parameter is deprecated. Use "positionalArgs" instead.');
      positionalArgs = [args];
    }
    _moduleLoader = _initModule(sources,
        basePath: basePath, allowFileSystemImports: allowFileSystemImports);
    Logger.debug("[D4rt._executeClassic] Starting execution. library: $library");
    CompilationUnit compilationUnit;

    if (library != null) {
      Logger.debug(
          "[D4rt._executeClassic] Attempting to load the $name source via ModuleLoader for URI: $library");

      if (!_moduleLoader.sources.containsKey(library.toString())) {
        final errorMessage =
            "[D4rt._executeClassic] The $name source URI '$library' was not found in sources.";
        Logger.error(errorMessage);
        throw SourceCodeException(errorMessage);
      }

      if (source?.isNotEmpty ?? false) {
        Logger.warn(
            "[D4rt._executeClassic] The 'source' parameter is not empty but 'library' ($library) is used to load from sources. The 'source' string will be ignored.");
      }

      try {
        final loadedRootModule = _moduleLoader.loadModule(Uri.parse(library));
        compilationUnit = loadedRootModule.ast;
        Logger.debug(
            "[D4rt._executeClassic] $name source loaded and parsed successfully via ModuleLoader for $library.");
      } catch (e) {
        Logger.error(
            "[D4rt._executeClassic] Failed to load $name source $library via ModuleLoader: $e");
        if (e is SourceCodeException || e is RuntimeError) {
          rethrow;
        } else {
          throw Exception(
              "Unexpected failure to load initial module $library: $e");
        }
      }
    } else {
      if (source == null) {
        throw Exception('Source content must be provided');
      }
      Logger.debug(
          "[D4rt._executeClassic] Executing the provided source string directly (no source URI).");
      final result = parseString(
        content: source,
        throwIfDiagnostics: false,
        featureSet: FeatureSet.fromEnableFlags2(
          sdkLanguageVersion: Version(3, 10, 0),
          flags: [
            'non-nullable',
            'null-aware-elements',
            'triple-shift',
            'spread-collections',
            'control-flow-collections',
            'extension-methods',
            'extension-types',
          'digit-separators',
          ],
        ),
      );

      final errors = result.errors
          .where((e) => e.errorCode.errorSeverity == ErrorSeverity.ERROR)
          .toList();
      if (errors.isNotEmpty) {
        final errorMessages = errors.map((e) {
          final location = result.lineInfo.getLocation(e.offset);
          return "- ${e.message} (line ${location.lineNumber}, column ${location.columnNumber})";
        }).join("\n");
        Logger.error("Parsing errors for the direct source:\n$errorMessages");
        throw SourceCodeException(
            'Fatal parsing errors for the direct source:\n$errorMessages', source);
      }
      compilationUnit = result.unit;
      Logger.debug("[D4rt._executeClassic] Direct source string parsed successfully.");
    }

    // Library-scoped globals are registered via ModuleLoader when imports are processed
    final Environment executionEnvironment = _moduleLoader.globalEnvironment;
    
    Logger.debug("[_executeClassic] Starting Pass 1: Declaration");
    final declarationVisitor = DeclarationVisitor(executionEnvironment);
    for (final declaration in compilationUnit.declarations) {
      declaration.accept<void>(declarationVisitor);
    }
    Logger.debug("[_executeClassic] Finished Pass 1: Declaration");

    _visitor = InterpreterVisitor(
        globalEnvironment: executionEnvironment,
        moduleLoader: _moduleLoader,
        initiallibrary: library != null ? Uri.parse(library) : null);
    Object? functionResult;
    try {
      Logger.debug(" [_executeClassic] Starting Pass 2: Interpretation");
      Logger.debug(
          " [_executeClassic] Processing directives (imports, exports, etc.)...");
      for (final directive in compilationUnit.directives) {
        if (directive is ImportDirective) {
          Logger.debug(
              " [_executeClassic]   - Processing ImportDirective: ${directive.uri.stringValue}");
          _visitor!.visitImportDirective(directive);
        } else {
          Logger.debug(
              " [_executeClassic]   - Skipping directive of type: ${directive.runtimeType}");
        }
      }
      Logger.debug(" [_executeClassic] Finished processing directives.");

      Logger.debug(" [_executeClassic] Processing ALL declarations sequentially");

      Logger.debug(" [_executeClassic] Top-level declarations for Pass 2:");
      for (final declaration in compilationUnit.declarations) {
        Logger.debug(" [_executeClassic]   - ${declaration.runtimeType}");
      }

      for (final declaration in compilationUnit.declarations) {
        declaration.accept<Object?>(_visitor!);
      }
      Logger.debug(" [_executeClassic] Finished processing declarations");
      Logger.debug("[_executeClassic] Looking for $name function");
      final functionCallable = executionEnvironment.get(name);
      if (functionCallable is Callable) {
        List<Object?> interpreterArgs = positionalArgs ?? [];
        final Map<String, Object?> interpreterNamedArgs = namedArgs ?? {};

        // Special handling for 'main' function: if it expects args but none provided,
        // pass an empty list automatically (standard Dart behavior)
        final expectedArity = functionCallable.arity;
        if (name == 'main' &&
            expectedArity > 0 &&
            interpreterArgs.isEmpty &&
            namedArgs?.isEmpty != false) {
          // main expects args but none were provided - pass empty list
          interpreterArgs = [<String>[]];
          Logger.debug(
              "[_executeClassic] 'main' expects arguments but none provided. Passing empty list.");
        }

        // Validate arity (only for positional args, named args are validated by the function itself)
        if (interpreterArgs.length > expectedArity) {
          throw RuntimeError(
              "'$name' function accepts at most $expectedArity positional argument(s), but ${interpreterArgs.length} were provided.");
        }

        Logger.debug(
            "[_executeClassic] Calling '$name' with positionalArgs: $interpreterArgs, namedArgs: $interpreterNamedArgs");

        functionResult = functionCallable.call(
            _visitor!, interpreterArgs, interpreterNamedArgs);
      } else {
        throw Exception(
            "No callable '$name' function found in the test source code.");
      }
      Logger.debug(" [_executeClassic] Finished Pass 2: Interpretation");
    } on InternalInterpreterException catch (e) {
      if (e.originalThrownValue is RuntimeError) {
        throw e.originalThrownValue as RuntimeError;
      } else {
        throw e.originalThrownValue!;
      }
    } catch (e) {
      if (e is RuntimeError) {
        rethrow;
      } else {
        throw RuntimeError('Unexpected error: $e');
      }
    }
    if (functionResult is InterpretedInstance) {
      _interpretedInstance = functionResult;
    }
    final resultValue = _bridgeInterpreterValueToNative(functionResult);
    if (resultValue is Future) {
      try {
        _hasExecutedOnce = true;
        return resultValue
            .then((value) => _bridgeInterpreterValueToNative(value));
      } on InternalInterpreterException catch (e) {
        if (e.originalThrownValue is RuntimeError) {
          throw e.originalThrownValue as RuntimeError;
        } else {
          throw e.originalThrownValue!;
        }
      } catch (e) {
        if (e is RuntimeError) {
          rethrow;
        } else {
          throw RuntimeError('Unexpected error: $e');
        }
      }
    }
    _hasExecutedOnce = true;
    return resultValue;
  }

  /// Analyzes the given source code and returns introspection information
  /// about all declared functions, classes, variables, enums, and extensions.
  ///
  /// This method parses and processes the source code without executing any function,
  /// allowing you to inspect what declarations are available.
  ///
  /// [source] The source code to analyze.
  ///
  /// [sources] Additional sources for multi-file analysis.
  ///
  /// [includeBuiltins] Whether to include built-in types and functions in the result.
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  /// final result = d4rt.analyze(source: '''
  ///   class Person {
  ///     String name;
  ///     int age;
  ///     Person(this.name, this.age);
  ///     String greet() => "Hello, I'm \$name";
  ///   }
  ///
  ///   int add(int a, int b) => a + b;
  ///
  ///   final greeting = "Hello";
  /// ''');
  ///
  /// print(result.classes); // [ClassInfo(Person)]
  /// print(result.functions); // [FunctionInfo(add)]
  /// print(result.variables); // [VariableInfo(greeting)]
  /// ```
  IntrospectionResult analyze({
    required String source,
    Map<String, String>? sources,
    bool includeBuiltins = false,
  }) {
    Logger.debug("[D4rt.analyze] Starting analysis...");

    _moduleLoader = _initModule(sources);

    final parseResult = parseString(
      content: source,
      throwIfDiagnostics: false,
      featureSet: FeatureSet.fromEnableFlags2(
        sdkLanguageVersion: Version(3, 10, 0),
        flags: [
          'non-nullable',
          'null-aware-elements',
          'triple-shift',
          'spread-collections',
          'control-flow-collections',
          'extension-methods',
          'extension-types',
          'digit-separators',
        ],
      ),
    );

    final errors = parseResult.errors
        .where((e) => e.errorCode.errorSeverity == ErrorSeverity.ERROR)
        .toList();
    if (errors.isNotEmpty) {
      final errorMessages = errors.map((e) {
        final location = parseResult.lineInfo.getLocation(e.offset);
        return "- ${e.message} (line ${location.lineNumber}, column ${location.columnNumber})";
      }).join("\n");
      throw SourceCodeException('Parsing errors:\n$errorMessages', source);
    }

    final compilationUnit = parseResult.unit;
    
    // Library-scoped globals are registered via ModuleLoader when imports are processed
    final Environment executionEnvironment = _moduleLoader.globalEnvironment;

    // Pass 1: Declaration
    final declarationVisitor = DeclarationVisitor(executionEnvironment);
    for (final declaration in compilationUnit.declarations) {
      declaration.accept<void>(declarationVisitor);
    }

    // Pass 2: Process imports and interpret declarations (for variable values)
    _visitor = InterpreterVisitor(
        globalEnvironment: executionEnvironment, moduleLoader: _moduleLoader);

    for (final directive in compilationUnit.directives) {
      if (directive is ImportDirective) {
        _visitor!.visitImportDirective(directive);
      }
    }

    for (final declaration in compilationUnit.declarations) {
      declaration.accept<Object?>(_visitor!);
    }

    Logger.debug("[D4rt.analyze] Analysis complete.");
    return IntrospectionBuilder.buildFromEnvironment(
      executionEnvironment,
      includeBuiltins: includeBuiltins,
      compilationUnit: compilationUnit,
    );
  }

  /// Evaluates an expression or statement in the context of previously executed code.
  ///
  /// This method allows you to execute additional code in the same environment
  /// as a previous `execute()` call, similar to a REPL experience.
  ///
  /// **Important**: You must call `execute()` at least once before calling `eval()`
  /// to establish the execution context.
  ///
  /// [expression] The Dart expression or statement to evaluate.
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  ///
  /// // First, set up the context
  /// d4rt.execute(source: '''
  ///   var counter = 0;
  ///   void increment() { counter++; }
  ///   int getCounter() => counter;
  /// ''', name: 'getCounter');
  ///
  /// // Now use eval to interact with the established context
  /// d4rt.eval('increment()');
  /// d4rt.eval('increment()');
  /// final result = d4rt.eval('getCounter()'); // Returns 2
  ///
  /// // You can also define new functions
  /// d4rt.eval('int double(int x) => x * 2;');
  /// final doubled = d4rt.eval('double(counter)'); // Returns 4
  /// ```
  dynamic eval(String expression) {
    if (_visitor == null || !_hasExecutedOnce) {
      throw RuntimeError(
          'eval() requires an existing execution context. Call execute() first.');
    }

    Logger.debug("[D4rt.eval] Evaluating: $expression");
    final executionEnvironment = _moduleLoader.globalEnvironment;

    // First, try to parse as a top-level declaration (function, class, variable)
    final declarationParseResult = parseString(
      content: expression,
      throwIfDiagnostics: false,
      featureSet: FeatureSet.fromEnableFlags2(
        sdkLanguageVersion: Version(3, 10, 0),
        flags: [
          'non-nullable',
          'null-aware-elements',
          'triple-shift',
          'spread-collections',
          'control-flow-collections',
          'extension-methods',
          'extension-types',
          'digit-separators',
        ],
      ),
    );

    // Check if it parses as valid declaration(s)
    final declErrors = declarationParseResult.errors
        .where((e) => e.errorCode.errorSeverity == ErrorSeverity.ERROR)
        .toList();

    if (declErrors.isEmpty &&
        declarationParseResult.unit.declarations.isNotEmpty) {
      // It's a declaration - process it directly in the global environment
      final compilationUnit = declarationParseResult.unit;

      // Declaration pass
      final declarationVisitor = DeclarationVisitor(executionEnvironment);
      for (final declaration in compilationUnit.declarations) {
        declaration.accept<void>(declarationVisitor);
      }

      // Interpretation pass
      for (final declaration in compilationUnit.declarations) {
        declaration.accept<Object?>(_visitor!);
      }

      Logger.debug("[D4rt.eval] Processed declaration(s)");
      return null;
    }

    // Check if this looks like multiple statements (contains ; followed by more code)
    // This heuristic helps us choose the right wrapper: statements vs expression
    final trimmedExpr = expression.trim();
    final looksLikeMultiStatement = RegExp(r';\s*\S').hasMatch(trimmedExpr);

    // For single expressions, try wrapping with return to get the value
    if (!looksLikeMultiStatement) {
      final wrappedSource = '''
        dynamic __eval__() {
          return $expression;
        }
      ''';

      final parseResult = parseString(
        content: wrappedSource,
        throwIfDiagnostics: false,
        featureSet: FeatureSet.fromEnableFlags2(
          sdkLanguageVersion: Version(3, 10, 0),
          flags: [
            'non-nullable',
            'null-aware-elements',
            'triple-shift',
            'spread-collections',
            'control-flow-collections',
            'extension-methods',
            'extension-types',
          'digit-separators',
          ],
        ),
      );

      if (parseResult.errors.isEmpty) {
        // Execute as expression with return value
        final compilationUnit = parseResult.unit;

        final declarationVisitor = DeclarationVisitor(executionEnvironment);
        for (final declaration in compilationUnit.declarations) {
          declaration.accept<void>(declarationVisitor);
        }

        for (final declaration in compilationUnit.declarations) {
          declaration.accept<Object?>(_visitor!);
        }

        // Call the __eval__ function
        final evalFunc = executionEnvironment.get('__eval__');
        Object? result;
        if (evalFunc is Callable) {
          try {
            result = evalFunc.call(_visitor!, [], {});
          } on InternalInterpreterException catch (e) {
            if (e.originalThrownValue is RuntimeError) {
              throw e.originalThrownValue as RuntimeError;
            }
            throw e.originalThrownValue ?? e;
          }
        }

        final bridgedResult = _bridgeInterpreterValueToNative(result);
        Logger.debug("[D4rt.eval] Result: $bridgedResult");

        if (bridgedResult is Future) {
          return bridgedResult
              .then((value) => _bridgeInterpreterValueToNative(value));
        }

        return bridgedResult;
      }
    }

    // Try parsing as statement(s) (no return value expected)
    // This is used for multi-statement code or when expression wrapper fails
    final statementSource = '''
      void __eval__() {
        $expression
      }
    ''';

    final statementParseResult = parseString(
      content: statementSource,
      throwIfDiagnostics: false,
      featureSet: FeatureSet.fromEnableFlags2(
        sdkLanguageVersion: Version(3, 10, 0),
        flags: [
          'non-nullable',
          'null-aware-elements',
          'triple-shift',
          'spread-collections',
          'control-flow-collections',
          'extension-methods',
          'extension-types',
          'digit-separators',
        ],
      ),
    );

    if (statementParseResult.errors.isEmpty) {
      final compilationUnit = statementParseResult.unit;

      final declarationVisitor = DeclarationVisitor(executionEnvironment);
      for (final declaration in compilationUnit.declarations) {
        declaration.accept<void>(declarationVisitor);
      }

      for (final declaration in compilationUnit.declarations) {
        declaration.accept<Object?>(_visitor!);
      }

      // Call the __eval__ function
      final evalFunc = executionEnvironment.get('__eval__');
      if (evalFunc is Callable) {
        try {
          evalFunc.call(_visitor!, [], {});
        } on InternalInterpreterException catch (e) {
          if (e.originalThrownValue is RuntimeError) {
            throw e.originalThrownValue as RuntimeError;
          }
          throw e.originalThrownValue ?? e;
        }
      }

      Logger.debug("[D4rt.eval] Executed statement");
      return null;
    }

    // All parsing attempts failed
    final errorMessages = declErrors.map((e) {
      final location = declarationParseResult.lineInfo.getLocation(e.offset);
      return "- ${e.message} (line ${location.lineNumber}, column ${location.columnNumber})";
    }).join("\n");
    throw SourceCodeException('Failed to parse expression:\n$errorMessages', expression);
  }

  /// Invoke a property or method on the given instance.
  ///
  /// String name : The name of the property or method to invoke.
  ///
  /// List&lt;Object?&gt; positionalArgs : The positional arguments to pass to the property or method.
  ///
  /// Map&lt;String, Object?&gt; namedArgs = const {} : The named arguments to pass to the property or method.
  ///
  /// Map&lt;String, String&gt;? sources : The sources to load. example: {'package:my_package/main.dart': 'main() { return "Hello, World!"; }'}
  dynamic invoke(
    String name,
    List<Object?> positionalArgs, [
    Map<String, Object?> namedArgs = const {},
    Map<String, String>? sources,
  ]) {
    if (_interpretedInstance == null) {
      throw RuntimeError(
          "No interpreted instance found. Call setInterpretedInstance first.");
    }
    if (_visitor == null) {
      throw RuntimeError("No visitor found. Call setVisitor first.");
    }
    final globalEnv = _visitor!.globalEnvironment;
    final instance = _interpretedInstance!;
    final klass = instance.klass;

    InterpretedFunction? interpretedFunction;
    interpretedFunction = klass.findInstanceMethod(name);
    interpretedFunction ??= klass.findInstanceGetter(name);
    interpretedFunction ??= klass.findStaticMethod(name);
    interpretedFunction ??= klass.findStaticGetter(name);
    interpretedFunction ??= klass.findInstanceSetter(name);
    interpretedFunction ??= klass.findStaticSetter(name);
    result() {
      if (interpretedFunction != null) {
        final interpreterPositionalArgs = positionalArgs
            .map((v) => _bridgeNativeValueToInterpreter(v, globalEnv))
            .toList();

        final interpreterNamedArgs = namedArgs.map((key, value) =>
            MapEntry(key, _bridgeNativeValueToInterpreter(value, globalEnv)));
        return _tryFunction(() {
          return interpretedFunction!
              .bind(instance)
              .call(_visitor!, interpreterPositionalArgs, interpreterNamedArgs);
        }, "Error invoking interpreted Method or getter '$name' on '${klass.name}'");
      }

      final bridgedSuperclass = klass.bridgedSuperclass;
      final nativeSuperObject = instance.bridgedSuperObject;

      if (bridgedSuperclass != null) {
        final interpreterPositionalArgs = positionalArgs
            .map((v) => _bridgeNativeValueToInterpreter(v, globalEnv))
            .toList();
        final interpreterNamedArgs = namedArgs.map((key, value) =>
            MapEntry(key, _bridgeNativeValueToInterpreter(value, globalEnv)));

        if (nativeSuperObject != null) {
          final methodAdapter =
              bridgedSuperclass.findInstanceMethodAdapter(name);

          if (methodAdapter != null) {
            return _tryFunction(() {
              return methodAdapter.call(_visitor!, nativeSuperObject,
                  interpreterPositionalArgs, interpreterNamedArgs, null);
            }, "Error invoking bridged method '$name' on superclass '${bridgedSuperclass.name}'");
          }

          final getterAdapter =
              bridgedSuperclass.findInstanceGetterAdapter(name);
          if (getterAdapter != null) {
            return _tryFunction(() {
              return getterAdapter.call(_visitor!, nativeSuperObject);
            }, "Error invoking bridged getter '$name' on superclass '${bridgedSuperclass.name}'");
          }
          final setterAdapter =
              bridgedSuperclass.findInstanceSetterAdapter(name);
          if (setterAdapter != null) {
            return _tryFunction(() {
              setterAdapter.call(
                  _visitor!, nativeSuperObject, interpreterPositionalArgs[0]);
              return null;
            }, "Error invoking bridged setter '$name' on superclass '${bridgedSuperclass.name}'");
          }
        }

        final staticMethodAdapter =
            bridgedSuperclass.findStaticMethodAdapter(name);
        if (staticMethodAdapter != null) {
          return _tryFunction(() {
            return staticMethodAdapter.call(
                _visitor!, interpreterPositionalArgs, interpreterNamedArgs, null);
          }, "Error invoking bridged static method '$name' on superclass '${bridgedSuperclass.name}'");
        }

        final getterStaticAdapter =
            bridgedSuperclass.findStaticGetterAdapter(name);
        if (getterStaticAdapter != null) {
          return _tryFunction(() {
            return getterStaticAdapter.call(_visitor!);
          }, "Error invoking bridged static getter '$name' on superclass '${bridgedSuperclass.name}'");
        }

        final staticSetterAdapter =
            bridgedSuperclass.findStaticSetterAdapter(name);
        if (staticSetterAdapter != null) {
          return _tryFunction(() {
            staticSetterAdapter.call(_visitor!, interpreterPositionalArgs[0]);
            return null;
          }, "Error invoking bridged staticsetter '$name' on superclass '${bridgedSuperclass.name}'");
        }
      }

      throw RuntimeError(
          'Method or getter "$name" not found on instance of class "${klass.name}" or its bridged superclass.');
    }

    return result();
  }

  Object? _bridgeNativeValueToInterpreter(
      Object? nativeValue, Environment globalEnv) {
    if (nativeValue == null ||
        nativeValue is String ||
        nativeValue is num ||
        nativeValue is bool) {
      return nativeValue;
    }
    if (nativeValue is List) {
      return nativeValue
          .map((v) => _bridgeNativeValueToInterpreter(v, globalEnv))
          .toList();
    }
    if (nativeValue is Map) {
      return nativeValue.map((key, value) => MapEntry(
          _bridgeNativeValueToInterpreter(key, globalEnv),
          _bridgeNativeValueToInterpreter(value, globalEnv)));
    }

    final nativeType = nativeValue.runtimeType;
    final bridgedDef = _bridgedDefLookupByType[nativeType];

    if (bridgedDef != null) {
      final bridgedClass = globalEnv.get(bridgedDef.name);
      if (bridgedClass is BridgedClass) {
        return BridgedInstance(bridgedClass, nativeValue);
      } else {
        Logger.warn(
            "BridgedClass '${bridgedDef.name}' not found in global env during bridging.");
        return nativeValue;
      }
    }

    if (nativeValue is Function || nativeValue is Callable) {
      return nativeValue;
    }

    Logger.warn(
        "Passing unknown native type $nativeType directly to interpreter.");
    return nativeValue;
  }

  Object? _bridgeInterpreterValueToNative(Object? interpreterValue) {
    if (interpreterValue == null ||
        interpreterValue is String ||
        interpreterValue is num ||
        interpreterValue is bool) {
      return interpreterValue;
    }
    if (interpreterValue is BridgedInstance) {
      return interpreterValue.nativeObject;
    }

    if (interpreterValue is BridgedEnumValue) {
      return interpreterValue.nativeValue;
    }
    if (interpreterValue is List) {
      return interpreterValue.map(_bridgeInterpreterValueToNative).toList();
    }
    if (interpreterValue is Map) {
      return interpreterValue.map((key, value) => MapEntry(
          _bridgeInterpreterValueToNative(key),
          _bridgeInterpreterValueToNative(value)));
    }
    if (interpreterValue is InterpretedInstance ||
        interpreterValue is InterpretedFunction ||
        interpreterValue is NativeFunction ||
        interpreterValue is Callable) {
      return interpreterValue;
    }

    return interpreterValue;
  }

  dynamic _tryFunction(dynamic Function() fn, String error) {
    try {
      final result = fn.call();
      if (result is Future) {
        return result.then((value) => _bridgeInterpreterValueToNative(value));
      }
      return _bridgeInterpreterValueToNative(result);
    } catch (e) {
      if (e is ReturnException) {
        return _bridgeInterpreterValueToNative(e.value);
      }
      if (e is InternalInterpreterException && e.originalThrownValue != null) {
        throw e.originalThrownValue!;
      }
      throw "$error : $e";
    }
  }
}
