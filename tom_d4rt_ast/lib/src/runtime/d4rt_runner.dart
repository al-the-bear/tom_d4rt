import 'dart:convert';
import 'dart:io';

import 'package:tom_d4rt_ast/ast.dart';
import 'package:tom_d4rt_ast/src/runtime/ast_bundle.dart';
import 'package:tom_d4rt_ast/src/runtime/ast_module_loader.dart';
import 'package:tom_d4rt_ast/src/runtime/bridge/bridged_types.dart';
import 'package:tom_d4rt_ast/src/runtime/bridge/registration.dart';
import 'package:tom_d4rt_ast/src/runtime/callable.dart';
import 'package:tom_d4rt_ast/src/runtime/declaration_visitor.dart';
import 'package:tom_d4rt_ast/src/runtime/environment.dart';
import 'package:tom_d4rt_ast/src/runtime/exceptions.dart';
import 'package:tom_d4rt_ast/src/runtime/interpreter_visitor.dart';
import 'package:tom_d4rt_ast/src/runtime/module_context.dart';
import 'package:tom_d4rt_ast/src/runtime/security/permissions.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/stdlib.dart';
import 'package:tom_d4rt_ast/src/runtime/utils/logger/logger.dart';

/// Wrapper class for library-scoped variables.
class LibraryVariable {
  final String name;
  final Object? value;
  final String? sourceUri;

  const LibraryVariable(this.name, this.value, {this.sourceUri});
}

/// Wrapper class for library-scoped getters.
class LibraryGetter {
  final String name;
  final Object? Function() getter;
  final String? sourceUri;

  const LibraryGetter(this.name, this.getter, {this.sourceUri});
}

/// Wrapper class for library-scoped setters.
class LibrarySetter {
  final String name;
  final void Function(Object? value) setter;
  final String? sourceUri;

  const LibrarySetter(this.name, this.setter, {this.sourceUri});
}

/// Wrapper class for library-scoped functions.
class LibraryFunction {
  final NativeFunction function;
  final String? sourceUri;
  final String? signature;

  const LibraryFunction(this.function, {this.sourceUri, this.signature});
  String get name => function.name;
}

/// Wrapper class for library-scoped bridged classes.
class LibraryClass {
  final BridgedClass bridgedClass;
  final String? sourceUri;

  const LibraryClass(this.bridgedClass, {this.sourceUri});
  String get name => bridgedClass.name;
}

/// Wrapper class for library-scoped bridged enums.
class LibraryEnum {
  final BridgedEnumDefinition enumDefinition;
  final String? sourceUri;

  const LibraryEnum(this.enumDefinition, {this.sourceUri});
  String get name => enumDefinition.name;
}

/// Wrapper class for library-scoped bridged extensions.
class LibraryExtension {
  final BridgedExtensionDefinition extensionDefinition;
  final String? sourceUri;

  const LibraryExtension(this.extensionDefinition, {this.sourceUri});
  String? get name => extensionDefinition.name;
}

/// D4rtRunner - Execute pre-parsed AST trees without analyzer dependency.
///
/// This class provides the core interpreter functionality for executing
/// SAstNode trees. Unlike the full D4rt class in tom_d4rt_exec, D4rtRunner
/// works exclusively with pre-parsed AST and does not require the analyzer.
///
/// ## Use Cases
/// - Execute AST loaded from JSON files
/// - Execute AST from precompiled scripts
/// - Embedded interpreter without heavy analyzer dependency
///
/// ## Example:
/// ```dart
/// // From JSON string
/// final runner = D4rtRunner();
/// final ast = runner.parseJson(jsonString);
/// final result = runner.execute(ast: ast);
///
/// // From JSON file
/// final result = await runner.executeFromJsonFile('script.ast.json');
/// ```
///
/// For source code parsing and execution, use the D4rt class from
/// tom_d4rt_exec which provides full integration with tom_d4rt_astgen.
class D4rtRunner {
  final List<Map<String, LibraryEnum>> _bridgedEnumDefinitions = [];
  final List<Map<String, LibraryClass>> _bridgedClasses = [];
  final List<Map<String, LibraryExtension>> _bridgedExtensions = [];
  final List<Map<String, LibraryFunction>> _libraryFunctions = [];
  final List<Map<String, LibraryVariable>> _libraryVariables = [];
  final List<Map<String, LibraryGetter>> _libraryGetters = [];
  final List<Map<String, LibrarySetter>> _librarySetters = [];
  final Map<Type, BridgedClass> _bridgedDefLookupByType = {};
  final Set<Permission> _grantedPermissions = {};

  InterpreterVisitor? _visitor;
  Environment? _globalEnvironment;
  bool _hasExecutedOnce = false;

  /// Creates a D4rtRunner instance for executing pre-parsed AST.
  D4rtRunner();

  /// Gets the current interpreter visitor instance.
  InterpreterVisitor? get visitor => _visitor;

  // =========================================================================
  // Bridge Data Access (for AstModuleLoader)
  // =========================================================================

  /// Registered bridged enum definitions keyed by library URI.
  List<Map<String, LibraryEnum>> get bridgedEnumDefinitions =>
      _bridgedEnumDefinitions;

  /// Registered bridged class definitions keyed by library URI.
  List<Map<String, LibraryClass>> get bridgedClasses => _bridgedClasses;

  /// Registered bridged extension definitions keyed by library URI.
  List<Map<String, LibraryExtension>> get bridgedExtensions =>
      _bridgedExtensions;

  /// Registered library functions keyed by library URI.
  List<Map<String, LibraryFunction>> get libraryFunctions => _libraryFunctions;

  /// Registered library variables keyed by library URI.
  List<Map<String, LibraryVariable>> get libraryVariables => _libraryVariables;

  /// Registered library getters keyed by library URI.
  List<Map<String, LibraryGetter>> get libraryGetters => _libraryGetters;

  /// Registered library setters keyed by library URI.
  List<Map<String, LibrarySetter>> get librarySetters => _librarySetters;

  // =========================================================================
  // Bridge Registration
  // =========================================================================

  /// Registers a bridged enum definition.
  void registerBridgedEnum(
    BridgedEnumDefinition definition,
    String library, {
    String? sourceUri,
  }) {
    final libEnum = LibraryEnum(definition, sourceUri: sourceUri);
    _bridgedEnumDefinitions.add({library: libEnum});
  }

  /// Registers a bridged class definition.
  void registerBridgedClass(
    BridgedClass definition,
    String library, {
    String? sourceUri,
  }) {
    final libClass = LibraryClass(definition, sourceUri: sourceUri);
    _bridgedClasses.add({library: libClass});
    _bridgedDefLookupByType[definition.nativeType] = definition;
  }

  /// Registers a bridged extension.
  void registerBridgedExtension(
    BridgedExtensionDefinition definition,
    String library, {
    String? sourceUri,
  }) {
    final libExt = LibraryExtension(definition, sourceUri: sourceUri);
    _bridgedExtensions.add({library: libExt});
  }

  /// Registers a top-level native function.
  void registerTopLevelFunction(
    String? name,
    NativeFunctionImpl function,
    String library, {
    String? sourceUri,
    String? signature,
  }) {
    final nativeFunc = NativeFunction(function, name: name, arity: 0);
    final libFunc = LibraryFunction(
      nativeFunc,
      sourceUri: sourceUri,
      signature: signature,
    );
    _libraryFunctions.add({library: libFunc});
  }

  /// Registers a global variable.
  void registerGlobalVariable(
    String name,
    Object? value,
    String library, {
    String? sourceUri,
  }) {
    _libraryVariables.add({
      library: LibraryVariable(name, value, sourceUri: sourceUri),
    });
  }

  /// Registers a global getter.
  void registerGlobalGetter(
    String name,
    Object? Function() getter,
    String library, {
    String? sourceUri,
  }) {
    _libraryGetters.add({
      library: LibraryGetter(name, getter, sourceUri: sourceUri),
    });
  }

  /// Registers a global setter.
  void registerGlobalSetter(
    String name,
    void Function(Object?) setter,
    String library, {
    String? sourceUri,
  }) {
    _librarySetters.add({
      library: LibrarySetter(name, setter, sourceUri: sourceUri),
    });
  }

  // =========================================================================
  // Permissions
  // =========================================================================

  /// Enables or disables debug logging.
  void setDebug(bool enabled) => Logger.setDebug(enabled);

  /// Grants a permission.
  void grant(Permission permission) {
    _grantedPermissions.add(permission);
    Logger.debug(
      "[D4rtRunner.grant] Granted permission: ${permission.description}",
    );
  }

  /// Revokes a permission.
  void revoke(Permission permission) {
    _grantedPermissions.remove(permission);
    Logger.debug(
      "[D4rtRunner.revoke] Revoked permission: ${permission.description}",
    );
  }

  /// Checks if a specific permission is granted.
  bool hasPermission(Permission permission) {
    return _grantedPermissions.contains(permission);
  }

  /// Checks if any permission allows the given operation.
  bool checkPermission(dynamic operation) {
    for (final permission in _grantedPermissions) {
      if (permission.allows(operation)) {
        return true;
      }
    }
    return false;
  }

  // =========================================================================
  // JSON Parsing
  // =========================================================================

  /// Parses an AST from a JSON string.
  ///
  /// The JSON should be in the format produced by tom_d4rt_astgen's
  /// AstConverter.toJson() method.
  SCompilationUnit parseJson(String jsonString) {
    final json = jsonDecode(jsonString);
    if (json is! Map<String, dynamic>) {
      throw ArgumentD4rtException('Invalid AST JSON: expected object');
    }
    return SCompilationUnit.fromJson(json);
  }

  /// Parses an AST from a JSON file.
  ///
  /// Supports both plain .json and gzipped .json.gz files.
  Future<SCompilationUnit> parseJsonFile(String path) async {
    final file = File(path);
    if (!file.existsSync()) {
      throw ArgumentD4rtException('AST file not found: $path');
    }

    List<int> bytes = await file.readAsBytes();

    // Decompress if gzipped
    if (path.endsWith('.gz')) {
      bytes = gzip.decode(bytes);
    }

    final jsonString = utf8.decode(bytes);
    return parseJson(jsonString);
  }

  // =========================================================================
  // Execution
  // =========================================================================

  /// Initializes the execution environment.
  Environment _initEnvironment() {
    final globalEnv = Environment();
    _globalEnvironment = globalEnv;

    // Register standard library
    Stdlib(globalEnv).register();

    // Register bridged definitions
    _registerBridgedDefinitions(globalEnv);

    return globalEnv;
  }

  /// Registers all bridged definitions into the environment.
  void _registerBridgedDefinitions(Environment env) {
    // Register bridged enums
    for (final entry in _bridgedEnumDefinitions) {
      for (final e in entry.entries) {
        final bridgedEnum = e.value.enumDefinition.buildBridgedEnum();
        env.defineBridgedEnum(bridgedEnum);
      }
    }

    // Register bridged classes
    for (final entry in _bridgedClasses) {
      for (final e in entry.entries) {
        env.defineBridge(e.value.bridgedClass);
      }
    }

    // Register library functions
    for (final entry in _libraryFunctions) {
      for (final e in entry.entries) {
        final name = e.value.function.name;
        // Skip default "<native>" names - only define named functions
        if (name != '<native>') {
          env.define(name, e.value.function);
        }
      }
    }

    // Register library variables
    for (final entry in _libraryVariables) {
      for (final e in entry.entries) {
        env.define(e.value.name, e.value.value);
      }
    }

    // Register library getters (with optional setters)
    // Match getter and setter by name
    final setterMap = <String, LibrarySetter>{};
    for (final entry in _librarySetters) {
      for (final e in entry.entries) {
        setterMap[e.value.name] = e.value;
      }
    }

    for (final entry in _libraryGetters) {
      for (final e in entry.entries) {
        final getter = e.value;
        final setter = setterMap[getter.name];
        env.define(
          getter.name,
          GlobalGetter(getter.getter, setter: setter?.setter),
        );
      }
    }

    // Register any remaining setters without corresponding getters
    // (These would be write-only properties, which is unusual but supported)
    final registeredGetterNames = <String>{};
    for (final entry in _libraryGetters) {
      for (final e in entry.entries) {
        registeredGetterNames.add(e.value.name);
      }
    }
    for (final entry in _librarySetters) {
      for (final e in entry.entries) {
        if (!registeredGetterNames.contains(e.value.name)) {
          // Write-only property - use a GlobalGetter with null getter
          env.define(
            e.value.name,
            GlobalGetter(
              () => throw RuntimeD4rtException(
                'Property ${e.value.name} is write-only',
              ),
              setter: e.value.setter,
            ),
          );
        }
      }
    }
  }

  /// Execute an AST.
  ///
  /// [ast] The parsed SCompilationUnit to execute.
  /// [name] The function to call (default: 'main').
  /// [positionalArgs] Positional arguments to pass to the function.
  /// [namedArgs] Named arguments to pass to the function.
  ///
  /// Returns the result of the function call.
  dynamic execute({
    required SCompilationUnit ast,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    // Initialize fresh environment
    InterpretedFunction.clearParentMap();
    final executionEnvironment = _initEnvironment();

    // Create module context with permission checking
    final moduleContext = NoOpModuleContext(
      globalEnvironment: executionEnvironment,
      permissionChecker: checkPermission,
    );

    // Execute
    return _executeInEnvironment(
      compilationUnit: ast,
      executionEnvironment: executionEnvironment,
      moduleContext: moduleContext,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
  }

  /// Execute from a JSON string.
  ///
  /// Convenience method that parses JSON and executes.
  dynamic executeFromJson({
    required String jsonString,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    final ast = parseJson(jsonString);
    return execute(
      ast: ast,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
  }

  /// Execute from a JSON file.
  ///
  /// Convenience method that loads and parses a JSON file and executes.
  /// Supports both plain .json and gzipped .json.gz files.
  Future<dynamic> executeFromJsonFile({
    required String path,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) async {
    final ast = await parseJsonFile(path);
    return execute(
      ast: ast,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
  }

  /// Execute an [AstBundle] with full import resolution.
  ///
  /// Unlike [execute], this method supports cross-module imports by creating
  /// an [AstModuleLoader] that resolves imports from the bundle's module map.
  ///
  /// The entry point module is determined by:
  /// 1. The [entryPoint] parameter (if provided)
  /// 2. The bundle's [AstBundle.entryPointUri]
  ///
  /// ## Example
  /// ```dart
  /// final runner = D4rtRunner();
  /// // register bridges...
  /// final bundle = AstBundle.fromFile('app.d4rtbundle');
  /// final result = runner.executeBundle(bundle);
  /// ```
  dynamic executeBundle(
    AstBundle bundle, {
    String? entryPoint,
    String name = 'main',
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    // Determine entry point URI
    final entryUri = entryPoint ?? bundle.entryPointUri;
    final entryAst = bundle.modules[entryUri];
    if (entryAst == null) {
      throw ArgumentD4rtException(
        'Entry point "$entryUri" not found in bundle. '
        'Available: ${bundle.modules.keys.join(", ")}',
      );
    }

    // Initialize environment
    InterpretedFunction.clearParentMap();
    final executionEnvironment = _initEnvironment();

    // Create AstModuleLoader for import resolution
    final moduleLoader = AstModuleLoader(
      modules: bundle.modules,
      globalEnvironment: executionEnvironment,
      runner: this,
    );
    moduleLoader.currentLibrary = Uri.parse(entryUri);

    Logger.debug(
      '[D4rtRunner.executeBundle] Entry point: $entryUri '
      '(${bundle.modules.length} modules in bundle)',
    );

    // Execute with full module context
    return _executeInEnvironment(
      compilationUnit: entryAst,
      executionEnvironment: executionEnvironment,
      moduleContext: moduleLoader,
      name: name,
      positionalArgs: positionalArgs,
      namedArgs: namedArgs,
    );
  }

  /// Evaluate an expression in the current context.
  ///
  /// Requires a previous call to [execute] to establish the context.
  /// This is useful for REPL-style execution.
  dynamic eval(String expression) {
    if (!_hasExecutedOnce || _visitor == null || _globalEnvironment == null) {
      throw RuntimeD4rtException(
        'eval() requires an established execution context. Call execute() first.',
      );
    }

    // The expression needs to be parsed - but we don't have a parser here
    // This would need a parseSourceCallback or work with pre-parsed expressions
    throw UnsupportedError(
      'eval() is not supported in D4rtRunner. '
      'Use D4rt from tom_d4rt_exec for source code evaluation.',
    );
  }

  /// Execute in the given environment.
  dynamic _executeInEnvironment({
    required SCompilationUnit compilationUnit,
    required Environment executionEnvironment,
    required ModuleContext moduleContext,
    required String name,
    List<Object?>? positionalArgs,
    Map<String, Object?>? namedArgs,
  }) {
    Logger.debug("[_executeInEnvironment] Starting Pass 1: Declaration");
    final declarationVisitor = DeclarationVisitor(executionEnvironment);
    for (final declaration in compilationUnit.declarations) {
      declaration.accept<void>(declarationVisitor);
    }
    Logger.debug("[_executeInEnvironment] Finished Pass 1: Declaration");

    _visitor = InterpreterVisitor(
      globalEnvironment: executionEnvironment,
      moduleContext: moduleContext,
    );

    Object? functionResult;
    try {
      Logger.debug("[_executeInEnvironment] Starting Pass 2: Interpretation");

      // Process import directives through the module context
      for (final directive in compilationUnit.directives) {
        if (directive is SImportDirective) {
          if (moduleContext is NoOpModuleContext) {
            Logger.warn(
              "[_executeInEnvironment] Import directive found but "
              "this execution context doesn't support imports. "
              "Use executeBundle() or D4rt from tom_d4rt_exec.",
            );
          } else {
            directive.accept<Object?>(_visitor!);
          }
        }
      }

      Logger.debug("[_executeInEnvironment] Processing declarations");
      for (final declaration in compilationUnit.declarations) {
        declaration.accept<Object?>(_visitor!);
      }
      Logger.debug("[_executeInEnvironment] Finished processing declarations");

      Logger.debug("[_executeInEnvironment] Looking for $name function");
      final functionCallable = executionEnvironment.get(name);
      if (functionCallable is Callable) {
        List<Object?> interpreterArgs = positionalArgs ?? [];
        final Map<String, Object?> interpreterNamedArgs = namedArgs ?? {};

        // Special handling for 'main' function
        final expectedArity = functionCallable.arity;
        if (name == 'main' &&
            expectedArity > 0 &&
            interpreterArgs.isEmpty &&
            namedArgs?.isEmpty != false) {
          interpreterArgs = [<String>[]];
          Logger.debug(
            "[_executeInEnvironment] 'main' expects arguments but none provided. Passing empty list.",
          );
        }

        // Validate arity
        if (interpreterArgs.length > expectedArity) {
          throw RuntimeD4rtException(
            "'$name' function accepts at most $expectedArity positional argument(s), but ${interpreterArgs.length} were provided.",
          );
        }

        Logger.debug(
          "[_executeInEnvironment] Calling '$name' with positionalArgs: $interpreterArgs, namedArgs: $interpreterNamedArgs",
        );

        functionResult = functionCallable.call(
          _visitor!,
          interpreterArgs,
          interpreterNamedArgs,
        );
      } else {
        throw RuntimeD4rtException(
          "No callable '$name' function found in the AST.",
        );
      }
      Logger.debug("[_executeInEnvironment] Finished Pass 2: Interpretation");
    } on InternalInterpreterD4rtException catch (e) {
      if (e.originalThrownValue is RuntimeD4rtException) {
        throw e.originalThrownValue as RuntimeD4rtException;
      } else {
        throw e.originalThrownValue!;
      }
    }

    _hasExecutedOnce = true;
    return functionResult;
  }
}
