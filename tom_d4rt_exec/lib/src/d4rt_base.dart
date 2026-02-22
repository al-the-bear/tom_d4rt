import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_exec/src/module_loader.dart';

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
  final List<Map<String, LibraryExtension>> _bridgedExtensions = [];
  InterpretedInstance? _interpretedInstance;
  InterpreterVisitor? _visitor;
  final Map<Type, BridgedClass> _bridgedDefLookupByType = {};
  final Set<Permission> _grantedPermissions = {};

  /// Callback for parsing source code into an SAstNode tree.
  /// Must be provided before calling [execute] or other methods that
  /// require source code parsing. Typically backed by tom_d4rt_astgen.
  final SCompilationUnit Function(String sourceCode, {String? path})?
      parseSourceCallback;

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
  final List<Map<String, LibrarySetter>> _librarySetters = [];

  late ModuleLoader _moduleLoader;
  bool _hasExecutedOnce = false;

  /// Creates a D4rt interpreter instance.
  ///
  /// [parseSourceCallback] is required when the interpreter needs to parse
  /// source code strings (e.g., for [execute] with `source:` parameter or
  /// for module loading). Typically backed by tom_d4rt_astgen's AstConverter.
  /// Can be null when working exclusively with pre-parsed [SCompilationUnit] trees.
  D4rt({this.parseSourceCallback});

  /// Parses source code to an [SCompilationUnit] using the registered callback.
  /// Throws [StateError] if no [parseSourceCallback] is registered.
  SCompilationUnit _parseSourceToAst(String sourceCode, {String? path}) {
    if (parseSourceCallback == null) {
      throw StateError('D4rt: no parseSourceCallback provided. '
          'Cannot parse source code. '
          'Provide a parseSourceCallback to the D4rt constructor.');
    }
    return parseSourceCallback!(sourceCode, path: path);
  }

  /// Registers a bridged enum definition for use in interpreted code.
  ///
  /// [definition] The enum definition containing the native enum type and its values.
  /// [library] The library identifier where this enum should be available.
  /// [sourceUri] The canonical source URI where this enum is defined.
  ///   Used for deduplication when the same enum is exported through multiple barrels.
  void registerBridgedEnum(BridgedEnumDefinition definition, String library,
      {String? sourceUri}) {
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
  void registerBridgedClass(BridgedClass definition, String library,
      {String? sourceUri}) {
    final libClass = LibraryClass(definition, sourceUri: sourceUri);
    _bridgedClases.add({library: libClass});
    _bridgedDefLookupByType[definition.nativeType] = definition;
  }

  /// Registers a bridged extension for use in interpreted code.
  ///
  /// When the corresponding library is imported in a D4rt script, the extension
  /// is converted to an [InterpretedExtension] and added to the environment,
  /// making its methods/getters/setters discoverable via [findExtensionMember].
  ///
  /// [definition] The extension definition containing methods, getters, and the target type name.
  /// [library] The library identifier where this extension should be available.
  /// [sourceUri] The canonical source URI where this extension is defined.
  void registerBridgedExtension(
      BridgedExtensionDefinition definition, String library,
      {String? sourceUri}) {
    final libExt = LibraryExtension(definition, sourceUri: sourceUri);
    _bridgedExtensions.add({library: libExt});
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
  void registertopLevelFunction(
      String? name, NativeFunctionImpl function, String library,
      {String? sourceUri, String? signature}) {
    final nativeFunc = NativeFunction(function, name: name, arity: 0);
    final libFunc =
        LibraryFunction(nativeFunc, sourceUri: sourceUri, signature: signature);
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
  void registerGlobalVariable(String name, Object? value, String library,
      {String? sourceUri}) {
    _libraryVariables
        .add({library: LibraryVariable(name, value, sourceUri: sourceUri)});
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
  void registerGlobalGetter(
      String name, Object? Function() getter, String library,
      {String? sourceUri}) {
    _libraryGetters
        .add({library: LibraryGetter(name, getter, sourceUri: sourceUri)});
  }

  /// Registers a global setter for a top-level setter in a specific library.
  ///
  /// This enables assignment to top-level variables that have setter definitions.
  /// The setter is paired with a corresponding getter (registered via
  /// [registerGlobalGetter]) to enable full read-write access.
  ///
  /// [name] The name of the setter (without 'set' keyword).
  /// [setter] A function that receives the assigned value and updates the native state.
  /// [library] The library URI where this setter is defined.
  /// [sourceUri] The canonical source URI where this setter is defined.
  ///   Used for deduplication when the same setter is exported through multiple barrels.
  ///
  /// ## Example:
  /// ```dart
  /// int _counter = 0;
  ///
  /// final interpreter = D4rt();
  /// interpreter.registerGlobalGetter('counter', () => _counter, 'package:my_app/my_app.dart');
  /// interpreter.registerGlobalSetter('counter', (v) => _counter = v as int, 'package:my_app/my_app.dart');
  /// ```
  void registerGlobalSetter(
      String name, void Function(Object?) setter, String library,
      {String? sourceUri}) {
    _librarySetters
        .add({library: LibrarySetter(name, setter, sourceUri: sourceUri)});
  }

  ModuleLoader _initModule(Map<String, String>? sources,
      {String? basePath,
      bool allowFileSystemImports = false,
      bool collectRegistrationErrors = false}) {
    final moduleLoader = ModuleLoader(
      Environment(),
      sources ?? {},
      _bridgedEnumDefinitions,
      _bridgedClases,
      libraryFunctions: _libraryFunctions,
      libraryVariables: _libraryVariables,
      libraryGetters: _libraryGetters,
      librarySetters: _librarySetters,
      bridgedExtensions: _bridgedExtensions,
      d4rt: this,
      collectRegistrationErrors: collectRegistrationErrors,
      parseSourceCallback: parseSourceCallback != null
          ? (sourceCode, uri) =>
              parseSourceCallback!(sourceCode, path: uri.toString())
          : null,
    );
    _visitor = InterpreterVisitor(
        globalEnvironment: moduleLoader.globalEnvironment,
        moduleContext: moduleLoader);
    Stdlib(moduleLoader.globalEnvironment).register();
    return moduleLoader;
  }

  /// Validates all bridge registrations by running the given init script
  /// and collecting all registration errors without aborting on the first one.
  ///
  /// This is useful for checking that all bridges are correctly configured
  /// and there are no duplicate element names across modules.
  ///
  /// Returns a list of registration error messages. An empty list means
  /// all registrations are valid.
  ///
  /// [source] The source code that imports all bridge modules (typically
  ///   all the import statements plus `void main() {}`).
  ///
  /// ## Example:
  /// ```dart
  /// final d4rt = D4rt();
  /// // ... register bridges ...
  /// final errors = d4rt.validateRegistrations(
  ///   source: """
  ///     import 'package:my_pkg/my_pkg.dart';
  ///     import 'package:other_pkg/other_pkg.dart';
  ///     void main() {}
  ///   """,
  /// );
  /// if (errors.isNotEmpty) {
  ///   print('Registration errors:');
  ///   for (final error in errors) {
  ///     print('  - $error');
  ///   }
  /// }
  /// ```
  List<String> validateRegistrations({
    required String source,
    Map<String, String>? sources,
    String? basePath,
    bool allowFileSystemImports = false,
  }) {
    // Initialize module loader in error-collecting mode
    _moduleLoader = _initModule(sources,
        basePath: basePath,
        allowFileSystemImports: allowFileSystemImports,
        collectRegistrationErrors: true);

    try {
      // Parse source — this triggers import processing and registration
      final compilationUnit = _parseSource(source: source);

      // Execute main to complete initialization
      final executionEnvironment = _moduleLoader.globalEnvironment;
      _executeInEnvironment(
        compilationUnit: compilationUnit,
        executionEnvironment: executionEnvironment,
        name: 'main',
      );
    } catch (e) {
      // If there are non-registration errors (e.g., parse errors),
      // add them to the accumulated list
      if (_moduleLoader.accumulatedRegistrationErrors.isEmpty) {
        return ['Unexpected error during validation: $e'];
      }
    }

    _hasExecutedOnce = true;
    return List.unmodifiable(_moduleLoader.accumulatedRegistrationErrors);
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
      for (final MapEntry(key: libraryUri, value: variable) in entry.entries) {
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
      throw ArgumentD4rtException(
          'Cannot use both "args" (deprecated) and "positionalArgs". Use only "positionalArgs".');
    }
    if (args != null) {
      Logger.warn(
          '[D4rt.execute] The "args" parameter is deprecated. Use "positionalArgs" instead.');
      positionalArgs = [args];
    }

    // Initialize a fresh module loader (resets global environment)
    InterpretedFunction.clearParentMap();
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
      throw RuntimeD4rtException(
          'continuedExecute() requires an existing execution context. Call execute() first.');
    }

    Logger.debug(
        "[D4rt.continuedExecute] Continuing execution in existing context. library: $library");

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

  /// Parse source code into a SCompilationUnit.
  SCompilationUnit _parseSource({String? source, String? library}) {
    if (library != null) {
      Logger.debug(
          "[D4rt._parseSource] Attempting to load source via ModuleLoader for URI: $library");

      if (!_moduleLoader.sources.containsKey(library.toString())) {
        final errorMessage =
            "[D4rt._parseSource] The source URI '$library' was not found in sources.";
        Logger.error(errorMessage);
        throw SourceCodeD4rtException(errorMessage);
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
        if (e is SourceCodeD4rtException || e is RuntimeD4rtException) {
          rethrow;
        } else {
          throw RuntimeD4rtException(
              "Unexpected failure to load initial module $library: $e");
        }
      }
    } else {
      if (source == null) {
        throw RuntimeD4rtException('Source content must be provided');
      }
      Logger.debug(
          "[D4rt._parseSource] Parsing the provided source string directly (no source URI).");
      final unit = _parseSourceToAst(source);
      Logger.debug(
          "[D4rt._parseSource] Direct source string parsed successfully.");
      return unit;
    }
  }

  /// Execute a parsed SCompilationUnit in the given environment.
  dynamic _executeInEnvironment({
    required SCompilationUnit compilationUnit,
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
        moduleContext: _moduleLoader,
        initialLibrary: library != null ? Uri.parse(library) : null);
    Object? functionResult;
    try {
      Logger.debug("[_executeInEnvironment] Starting Pass 2: Interpretation");
      Logger.debug(
          "[_executeInEnvironment] Processing directives (imports, exports, etc.)...");
      for (final directive in compilationUnit.directives) {
        if (directive is SImportDirective) {
          Logger.debug(
              "[_executeInEnvironment]   - Processing SImportDirective: ${(directive.uri is SSimpleStringLiteral) ? (directive.uri as SSimpleStringLiteral).value : null}");
          _visitor!.visitImportDirective(directive);
        } else {
          Logger.debug(
              "[_executeInEnvironment]   - Skipping directive of type: ${directive.runtimeType}");
        }
      }
      Logger.debug("[_executeInEnvironment] Finished processing directives.");

      Logger.debug(
          "[_executeInEnvironment] Processing ALL declarations sequentially");

      Logger.debug(
          "[_executeInEnvironment] Top-level declarations for Pass 2:");
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
          throw RuntimeD4rtException(
              "'$name' function accepts at most $expectedArity positional argument(s), but ${interpreterArgs.length} were provided.");
        }

        Logger.debug(
            "[_executeInEnvironment] Calling '$name' with positionalArgs: $interpreterArgs, namedArgs: $interpreterNamedArgs");

        functionResult = functionCallable.call(
            _visitor!, interpreterArgs, interpreterNamedArgs);
      } else {
        throw RuntimeD4rtException(
            "No callable '$name' function found in the test source code.");
      }
      Logger.debug("[_executeInEnvironment] Finished Pass 2: Interpretation");
    } on InternalInterpreterD4rtException catch (e) {
      if (e.originalThrownValue is RuntimeD4rtException) {
        throw e.originalThrownValue as RuntimeD4rtException;
      } else {
        throw e.originalThrownValue!;
      }
    } catch (e) {
      if (e is RuntimeD4rtException) {
        rethrow;
      } else {
        throw RuntimeD4rtException('Unexpected error: $e');
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
      } on InternalInterpreterD4rtException catch (e) {
        if (e.originalThrownValue is RuntimeD4rtException) {
          throw e.originalThrownValue as RuntimeD4rtException;
        } else {
          throw e.originalThrownValue!;
        }
      } catch (e) {
        if (e is RuntimeD4rtException) {
          rethrow;
        } else {
          throw RuntimeD4rtException('Unexpected error: $e');
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
      throw ArgumentD4rtException(
          'Cannot use both "args" (deprecated) and "positionalArgs". Use only "positionalArgs".');
    }
    if (args != null) {
      Logger.warn(
          '[D4rt._executeClassic] The "args" parameter is deprecated. Use "positionalArgs" instead.');
      positionalArgs = [args];
    }
    _moduleLoader = _initModule(sources,
        basePath: basePath, allowFileSystemImports: allowFileSystemImports);
    Logger.debug(
        "[D4rt._executeClassic] Starting execution. library: $library");
    SCompilationUnit compilationUnit;

    if (library != null) {
      Logger.debug(
          "[D4rt._executeClassic] Attempting to load the $name source via ModuleLoader for URI: $library");

      if (!_moduleLoader.sources.containsKey(library.toString())) {
        final errorMessage =
            "[D4rt._executeClassic] The $name source URI '$library' was not found in sources.";
        Logger.error(errorMessage);
        throw SourceCodeD4rtException(errorMessage);
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
        if (e is SourceCodeD4rtException || e is RuntimeD4rtException) {
          rethrow;
        } else {
          throw RuntimeD4rtException(
              "Unexpected failure to load initial module $library: $e");
        }
      }
    } else {
      if (source == null) {
        throw RuntimeD4rtException('Source content must be provided');
      }
      Logger.debug(
          "[D4rt._executeClassic] Executing the provided source string directly (no source URI).");
      compilationUnit = _parseSourceToAst(source);
      Logger.debug(
          "[D4rt._executeClassic] Direct source string parsed successfully.");
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
        moduleContext: _moduleLoader,
        initialLibrary: library != null ? Uri.parse(library) : null);
    Object? functionResult;
    try {
      Logger.debug(" [_executeClassic] Starting Pass 2: Interpretation");
      Logger.debug(
          " [_executeClassic] Processing directives (imports, exports, etc.)...");
      for (final directive in compilationUnit.directives) {
        if (directive is SImportDirective) {
          Logger.debug(
              " [_executeClassic]   - Processing SImportDirective: ${(directive.uri is SSimpleStringLiteral) ? (directive.uri as SSimpleStringLiteral).value : null}");
          _visitor!.visitImportDirective(directive);
        } else {
          Logger.debug(
              " [_executeClassic]   - Skipping directive of type: ${directive.runtimeType}");
        }
      }
      Logger.debug(" [_executeClassic] Finished processing directives.");

      Logger.debug(
          " [_executeClassic] Processing ALL declarations sequentially");

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
          throw RuntimeD4rtException(
              "'$name' function accepts at most $expectedArity positional argument(s), but ${interpreterArgs.length} were provided.");
        }

        Logger.debug(
            "[_executeClassic] Calling '$name' with positionalArgs: $interpreterArgs, namedArgs: $interpreterNamedArgs");

        functionResult = functionCallable.call(
            _visitor!, interpreterArgs, interpreterNamedArgs);
      } else {
        throw RuntimeD4rtException(
            "No callable '$name' function found in the test source code.");
      }
      Logger.debug(" [_executeClassic] Finished Pass 2: Interpretation");
    } on InternalInterpreterD4rtException catch (e) {
      if (e.originalThrownValue is RuntimeD4rtException) {
        throw e.originalThrownValue as RuntimeD4rtException;
      } else {
        throw e.originalThrownValue!;
      }
    } catch (e) {
      if (e is RuntimeD4rtException) {
        rethrow;
      } else {
        throw RuntimeD4rtException('Unexpected error: $e');
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
      } on InternalInterpreterD4rtException catch (e) {
        if (e.originalThrownValue is RuntimeD4rtException) {
          throw e.originalThrownValue as RuntimeD4rtException;
        } else {
          throw e.originalThrownValue!;
        }
      } catch (e) {
        if (e is RuntimeD4rtException) {
          rethrow;
        } else {
          throw RuntimeD4rtException('Unexpected error: $e');
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

    final compilationUnit = _parseSourceToAst(source);

    // Library-scoped globals are registered via ModuleLoader when imports are processed
    final Environment executionEnvironment = _moduleLoader.globalEnvironment;

    // Pass 1: Declaration
    final declarationVisitor = DeclarationVisitor(executionEnvironment);
    for (final declaration in compilationUnit.declarations) {
      declaration.accept<void>(declarationVisitor);
    }

    // Pass 2: Process imports and interpret declarations (for variable values)
    _visitor = InterpreterVisitor(
        globalEnvironment: executionEnvironment, moduleContext: _moduleLoader);

    for (final directive in compilationUnit.directives) {
      if (directive is SImportDirective) {
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
      throw RuntimeD4rtException(
          'eval() requires an existing execution context. Call execute() first.');
    }

    Logger.debug("[D4rt.eval] Evaluating: $expression");
    final executionEnvironment = _moduleLoader.globalEnvironment;

    // First, try to parse as a top-level declaration (function, class, variable)
    final declarationParseResult = _parseSourceToAst(expression);

    // Only treat as declarations if there are no parse errors.
    // The analyzer's error recovery may produce declarations from bare
    // expressions (e.g., "true" → TopLevelVariableDeclaration), which would
    // incorrectly return null instead of the expression's value.
    if (!declarationParseResult.hasParseErrors &&
        declarationParseResult.declarations.isNotEmpty) {
      // It's a declaration - process it directly in the global environment
      final compilationUnit = declarationParseResult;

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

      final parseResult = _parseSourceToAst(wrappedSource);

      {
        // Execute as expression with return value
        final compilationUnit = parseResult;

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
          } on InternalInterpreterD4rtException catch (e) {
            if (e.originalThrownValue is RuntimeD4rtException) {
              throw e.originalThrownValue as RuntimeD4rtException;
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

    final statementParseResult = _parseSourceToAst(statementSource);

    {
      final compilationUnit = statementParseResult;

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
        } on InternalInterpreterD4rtException catch (e) {
          if (e.originalThrownValue is RuntimeD4rtException) {
            throw e.originalThrownValue as RuntimeD4rtException;
          }
          throw e.originalThrownValue ?? e;
        }
      }

      Logger.debug("[D4rt.eval] Executed statement");
      return null;
    }
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
      throw RuntimeD4rtException(
          "No interpreted instance found. Call setInterpretedInstance first.");
    }
    if (_visitor == null) {
      throw RuntimeD4rtException("No visitor found. Call setVisitor first.");
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
            return staticMethodAdapter.call(_visitor!,
                interpreterPositionalArgs, interpreterNamedArgs, null);
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

      throw RuntimeD4rtException(
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
    // Convert InterpretedRecord to native Dart records when possible
    // For positional-only records up to 9 elements, we can create native records
    // For records with named fields or more than 9 positional fields, we return
    // InterpretedRecord with unwrapped field values
    if (interpreterValue is InterpretedRecord) {
      final pos = interpreterValue.positionalFields
          .map(_bridgeInterpreterValueToNative)
          .toList();
      final named = interpreterValue.namedFields;

      // Only convert to native record if there are no named fields
      if (named.isEmpty) {
        switch (pos.length) {
          case 0:
            return ();
          case 1:
            return (pos[0],);
          case 2:
            return (pos[0], pos[1]);
          case 3:
            return (pos[0], pos[1], pos[2]);
          case 4:
            return (pos[0], pos[1], pos[2], pos[3]);
          case 5:
            return (pos[0], pos[1], pos[2], pos[3], pos[4]);
          case 6:
            return (pos[0], pos[1], pos[2], pos[3], pos[4], pos[5]);
          case 7:
            return (pos[0], pos[1], pos[2], pos[3], pos[4], pos[5], pos[6]);
          case 8:
            return (
              pos[0],
              pos[1],
              pos[2],
              pos[3],
              pos[4],
              pos[5],
              pos[6],
              pos[7]
            );
          case 9:
            return (
              pos[0],
              pos[1],
              pos[2],
              pos[3],
              pos[4],
              pos[5],
              pos[6],
              pos[7],
              pos[8]
            );
          default:
            // More than 9 positional fields - return InterpretedRecord with unwrapped values
            return InterpretedRecord(pos, {});
        }
      }

      // Has named fields - can't convert to native record, return with unwrapped values
      return InterpretedRecord(
        pos,
        named.map((key, value) =>
            MapEntry(key, _bridgeInterpreterValueToNative(value))),
      );
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
      if (e is InternalInterpreterD4rtException &&
          e.originalThrownValue != null) {
        throw e.originalThrownValue!;
      }
      throw "$error : $e";
    }
  }
}
