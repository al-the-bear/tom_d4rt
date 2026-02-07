// D4rt Bridge - Generated file, do not edit
// Sources: 9 files
// Generated: 2026-02-07T14:57:22.774455

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';
import 'dart:io';

import 'package:tom_d4rt/src/introspection.dart' as ext_tom_d4rt_introspection;
import 'package:tom_d4rt/src/d4rt_base.dart' as ext_tom_d4rt_d4rt_base;
import 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart' as $pkg;

/// Bridge class for cli_api module.
class CliApiBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createD4rtCliApiBridge(),
      _createD4rtCliControllerBridge(),
      _createCliGlobalHolderBridge(),
      _createCliExceptionBridge(),
      _createCliFileNotFoundExceptionBridge(),
      _createDirectoryNotFoundExceptionBridge(),
      _createExecutionExceptionBridge(),
      _createReplayExceptionBridge(),
      _createInvalidMultilineModeExceptionBridge(),
      _createMaxNestingDepthExceptionBridge(),
      _createCliNotInitializedExceptionBridge(),
      _createExecuteResultBridge(),
      _createImportInfoBridge(),
      _createSymbolInfoBridge(),
      _createCliRuntimeBridge(),
      _createCliRuntimeImplBridge(),
      _createCliStateBridge(),
      _createVerificationFailureBridge(),
      _createExecutionContextBridge(),
      _createContextStackBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'D4rtCliApi': 'package:tom_d4rt_dcli/src/api/cli_api.dart',
      'D4rtCliController': 'package:tom_d4rt_dcli/src/api/cli_controller.dart',
      'CliGlobalHolder': 'package:tom_d4rt_dcli/src/api/cli_controller.dart',
      'CliException': 'package:tom_d4rt_dcli/src/api/cli_exceptions.dart',
      'CliFileNotFoundException': 'package:tom_d4rt_dcli/src/api/cli_exceptions.dart',
      'DirectoryNotFoundException': 'package:tom_d4rt_dcli/src/api/cli_exceptions.dart',
      'ExecutionException': 'package:tom_d4rt_dcli/src/api/cli_exceptions.dart',
      'ReplayException': 'package:tom_d4rt_dcli/src/api/cli_exceptions.dart',
      'InvalidMultilineModeException': 'package:tom_d4rt_dcli/src/api/cli_exceptions.dart',
      'MaxNestingDepthException': 'package:tom_d4rt_dcli/src/api/cli_exceptions.dart',
      'CliNotInitializedException': 'package:tom_d4rt_dcli/src/api/cli_exceptions.dart',
      'ExecuteResult': 'package:tom_d4rt_dcli/src/api/cli_result_types.dart',
      'ImportInfo': 'package:tom_d4rt_dcli/src/api/cli_result_types.dart',
      'SymbolInfo': 'package:tom_d4rt_dcli/src/api/cli_result_types.dart',
      'CliRuntime': 'package:tom_d4rt_dcli/src/api/cli_runtime.dart',
      'CliRuntimeImpl': 'package:tom_d4rt_dcli/src/api/cli_runtime.dart',
      'CliState': 'package:tom_d4rt_dcli/src/api/cli_state.dart',
      'VerificationFailure': 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
      'ExecutionContext': 'package:tom_d4rt_dcli/src/api/execution_context.dart',
      'ContextStack': 'package:tom_d4rt_dcli/src/api/execution_context.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$pkg.SymbolKind>(
        name: 'SymbolKind',
        values: $pkg.SymbolKind.values,
      ),
      BridgedEnumDefinition<$pkg.MultilineMode>(
        name: 'MultilineMode',
        values: $pkg.MultilineMode.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'SymbolKind': 'package:tom_d4rt_dcli/src/api/cli_result_types.dart',
      'MultilineMode': 'package:tom_d4rt_dcli/src/api/execution_context.dart',
    };
  }

  /// Registers all bridges with an interpreter.
  ///
  /// [importPath] is the package import path that D4rt scripts will use
  /// to access these classes (e.g., 'package:tom_build/tom.dart').
  static void registerBridges(D4rt interpreter, String importPath) {
    // Register bridged classes with source URIs for deduplication
    final classes = bridgeClasses();
    final classSources = classSourceUris();
    for (final bridge in classes) {
      interpreter.registerBridgedClass(bridge, importPath, sourceUri: classSources[bridge.name]);
    }

    // Register bridged enums with source URIs for deduplication
    final enums = bridgedEnums();
    final enumSources = enumSourceUris();
    for (final enumDef in enums) {
      interpreter.registerBridgedEnum(enumDef, importPath, sourceUri: enumSources[enumDef.name]);
    }

    // Register global variables
    registerGlobalVariables(interpreter, importPath);

    // Register global functions with source URIs for deduplication
    final funcs = globalFunctions();
    final funcSources = globalFunctionSourceUris();
    final funcSigs = globalFunctionSignatures();
    for (final entry in funcs.entries) {
      interpreter.registertopLevelFunction(entry.key, entry.value, importPath, sourceUri: funcSources[entry.key], signature: funcSigs[entry.key]);
    }
  }

  /// Registers all global variables with the interpreter.
  ///
  /// [importPath] is the package import path for library-scoped registration.
  /// Collects all registration errors and throws a single exception
  /// with all error details if any registrations fail.
  static void registerGlobalVariables(D4rt interpreter, String importPath) {
    final errors = <String>[];

    try {
      interpreter.registerGlobalVariable('cliLibrary', $pkg.cliLibrary, importPath, sourceUri: 'package:tom_d4rt_dcli/src/api/cli_bridge.dart');
    } catch (e) {
      errors.add('Failed to register variable "cliLibrary": $e');
    }
    try {
      interpreter.registerGlobalVariable('cliGlobalHolder', $pkg.cliGlobalHolder, importPath, sourceUri: 'package:tom_d4rt_dcli/src/api/cli_bridge.dart');
    } catch (e) {
      errors.add('Failed to register variable "cliGlobalHolder": $e');
    }
    interpreter.registerGlobalGetter('verificationFailures', () => $pkg.verificationFailures, importPath, sourceUri: 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (cli_api):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'registerCliBridge': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'registerCliBridge');
        final d4rt = D4.getRequiredArg<ext_tom_d4rt_d4rt_base.D4rt>(positional, 0, 'd4rt', 'registerCliBridge');
        return $pkg.registerCliBridge(d4rt);
      },
      'registerCliShortcuts': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'registerCliShortcuts');
        final d4rt = D4.getRequiredArg<ext_tom_d4rt_d4rt_base.D4rt>(positional, 0, 'd4rt', 'registerCliShortcuts');
        return $pkg.registerCliShortcuts(d4rt);
      },
      'clearVerificationFailures': (visitor, positional, named, typeArgs) {
        return $pkg.clearVerificationFailures();
      },
      'verify': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'verify');
        final condition = D4.getRequiredArg<bool>(positional, 0, 'condition', 'verify');
        final errorMessage = D4.getRequiredArg<String>(positional, 1, 'errorMessage', 'verify');
        return $pkg.verify(condition, errorMessage);
      },
      'verifyEquals': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'verifyEquals');
        final actual = D4.getRequiredArg<Object?>(positional, 0, 'actual', 'verifyEquals');
        final expected = D4.getRequiredArg<Object?>(positional, 1, 'expected', 'verifyEquals');
        final message = positional.length > 2 ? positional[2] as String? : null;
        return $pkg.verifyEquals(actual, expected, message);
      },
      'verifyNotNull': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'verifyNotNull');
        final value = D4.getRequiredArg<Object?>(positional, 0, 'value', 'verifyNotNull');
        final message = positional.length > 1 ? positional[1] as String? : null;
        return $pkg.verifyNotNull(value, message);
      },
      'verifyNull': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'verifyNull');
        final value = D4.getRequiredArg<Object?>(positional, 0, 'value', 'verifyNull');
        final message = positional.length > 1 ? positional[1] as String? : null;
        return $pkg.verifyNull(value, message);
      },
      'verifyContains': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'verifyContains');
        final actual = D4.getRequiredArg<String>(positional, 0, 'actual', 'verifyContains');
        final substring = D4.getRequiredArg<String>(positional, 1, 'substring', 'verifyContains');
        final message = positional.length > 2 ? positional[2] as String? : null;
        return $pkg.verifyContains(actual, substring, message);
      },
      'verifyMatches': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'verifyMatches');
        final actual = D4.getRequiredArg<String>(positional, 0, 'actual', 'verifyMatches');
        final pattern = D4.getRequiredArg<String>(positional, 1, 'pattern', 'verifyMatches');
        final message = positional.length > 2 ? positional[2] as String? : null;
        return $pkg.verifyMatches(actual, pattern, message);
      },
      'verifyNotEmpty': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'verifyNotEmpty');
        final list = D4.getRequiredArg<List>(positional, 0, 'list', 'verifyNotEmpty');
        final message = positional.length > 1 ? positional[1] as String? : null;
        return $pkg.verifyNotEmpty(list, message);
      },
      'verifyLength': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'verifyLength');
        final list = D4.getRequiredArg<List>(positional, 0, 'list', 'verifyLength');
        final length = D4.getRequiredArg<int>(positional, 1, 'length', 'verifyLength');
        final message = positional.length > 2 ? positional[2] as String? : null;
        return $pkg.verifyLength(list, length, message);
      },
      'verifyThrows': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'verifyThrows');
        final fn = D4.getRequiredArg<void Function()>(positional, 0, 'fn', 'verifyThrows');
        final message = positional.length > 1 ? positional[1] as String? : null;
        return $pkg.verifyThrows(fn, message);
      },
      'testSummary': (visitor, positional, named, typeArgs) {
        return $pkg.testSummary();
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'registerCliBridge': 'package:tom_d4rt_dcli/src/api/cli_bridge.dart',
      'registerCliShortcuts': 'package:tom_d4rt_dcli/src/api/cli_bridge.dart',
      'clearVerificationFailures': 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
      'verify': 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
      'verifyEquals': 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
      'verifyNotNull': 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
      'verifyNull': 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
      'verifyContains': 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
      'verifyMatches': 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
      'verifyNotEmpty': 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
      'verifyLength': 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
      'verifyThrows': 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
      'testSummary': 'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'registerCliBridge': 'void registerCliBridge(D4rt d4rt)',
      'registerCliShortcuts': 'void registerCliShortcuts(D4rt d4rt)',
      'clearVerificationFailures': 'void clearVerificationFailures()',
      'verify': 'bool verify(bool condition, String errorMessage)',
      'verifyEquals': 'bool verifyEquals(Object? actual, Object? expected, [String? message])',
      'verifyNotNull': 'bool verifyNotNull(Object? value, [String? message])',
      'verifyNull': 'bool verifyNull(Object? value, [String? message])',
      'verifyContains': 'bool verifyContains(String actual, String substring, [String? message])',
      'verifyMatches': 'bool verifyMatches(String actual, String pattern, [String? message])',
      'verifyNotEmpty': 'bool verifyNotEmpty(List list, [String? message])',
      'verifyLength': 'bool verifyLength(List list, int length, [String? message])',
      'verifyThrows': 'bool verifyThrows(void Function() fn, [String? message])',
      'testSummary': 'bool testSummary()',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:tom_d4rt_dcli/src/api/cli_api.dart',
      'package:tom_d4rt_dcli/src/api/cli_bridge.dart',
      'package:tom_d4rt_dcli/src/api/cli_controller.dart',
      'package:tom_d4rt_dcli/src/api/cli_exceptions.dart',
      'package:tom_d4rt_dcli/src/api/cli_result_types.dart',
      'package:tom_d4rt_dcli/src/api/cli_runtime.dart',
      'package:tom_d4rt_dcli/src/api/cli_state.dart',
      'package:tom_d4rt_dcli/src/api/cli_test_utils.dart',
      'package:tom_d4rt_dcli/src/api/execution_context.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    return "import 'package:tom_d4rt_dcli/tom_d4rt_cli_api.dart';";
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'SymbolKind',
    'MultilineMode',
  ];

}

// =============================================================================
// D4rtCliApi Bridge
// =============================================================================

BridgedClass _createD4rtCliApiBridge() {
  return BridgedClass(
    nativeType: $pkg.D4rtCliApi,
    name: 'D4rtCliApi',
    constructors: {
    },
    getters: {
      'isMultilineMode': (visitor, target) => D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi').isMultilineMode,
      'multilineMode': (visitor, target) => D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi').multilineMode,
      'multilineBuffer': (visitor, target) => D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi').multilineBuffer,
      'd4rt': (visitor, target) => D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi').d4rt,
      'dataDirectory': (visitor, target) => D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi').dataDirectory,
      'toolName': (visitor, target) => D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi').toolName,
      'currentSessionId': (visitor, target) => D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi').currentSessionId,
      'configuration': (visitor, target) => D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi').configuration,
      'runtime': (visitor, target) => D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi').runtime,
    },
    methods: {
      'processPrompt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'processPrompt');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'processPrompt');
        return t.processPrompt(line);
      },
      'processPrompts': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'processPrompts');
        if (positional.isEmpty) {
          throw ArgumentError('processPrompts: Missing required argument "lines" at position 0');
        }
        final lines = D4.coerceList<String>(positional[0], 'lines');
        final continueOnError = D4.getNamedArgWithDefault<bool>(named, 'continueOnError', false);
        return t.processPrompts(lines, continueOnError: continueOnError);
      },
      'help': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.help();
      },
      'info': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        final name = D4.getOptionalArg<String?>(positional, 0, 'name');
        return t.info(name);
      },
      'classes': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.classes();
      },
      'enums': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.enums();
      },
      'methods': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.methods();
      },
      'variables': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.variables();
      },
      'imports': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.imports();
      },
      'registeredClasses': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.registeredClasses();
      },
      'registeredEnums': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.registeredEnums();
      },
      'registeredMethods': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.registeredMethods();
      },
      'registeredVariables': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.registeredVariables();
      },
      'registeredImports': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.registeredImports();
      },
      'showInit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.showInit();
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        t.clear();
        return null;
      },
      'define': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 2, 'define');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'define');
        final template = D4.getRequiredArg<String>(positional, 1, 'template', 'define');
        t.define(name, template);
        return null;
      },
      'undefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'undefine');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'undefine');
        return t.undefine(name);
      },
      'defines': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.defines();
      },
      'loadDefines': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'loadDefines');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadDefines');
        return t.loadDefines(path);
      },
      'invokeDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'invokeDefine');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeDefine');
        final args = positional.length > 1
            ? D4.coerceListOrNull<String>(positional[1], 'args')
            : null;
        return t.invokeDefine(name, args);
      },
      'expandDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'expandDefine');
        final input = D4.getRequiredArg<String>(positional, 0, 'input', 'expandDefine');
        return t.expandDefine(input);
      },
      'sessions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.sessions();
      },
      'scripts': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.scripts();
      },
      'plays': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.plays();
      },
      'executes': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.executes();
      },
      'ls': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        final path = D4.getOptionalArg<String?>(positional, 0, 'path');
        return t.ls(path);
      },
      'cd': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'cd');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'cd');
        return t.cd(path);
      },
      'cwd': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.cwd();
      },
      'home': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.home();
      },
      'startDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        t.startDefine();
        return null;
      },
      'startScript': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        t.startScript();
        return null;
      },
      'startFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        t.startFile();
        return null;
      },
      'startExecute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        t.startExecute();
        return null;
      },
      'end': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        return t.end();
      },
      'clearMultilineBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        t.clearMultilineBuffer();
        return null;
      },
      'execute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'execute');
        final source = D4.getRequiredArg<String>(positional, 0, 'source', 'execute');
        final basePath = D4.getOptionalNamedArg<String?>(named, 'basePath');
        return t.execute(source, basePath: basePath);
      },
      'executeFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'executeFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'executeFile');
        return t.executeFile(path);
      },
      'executeContinued': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'executeContinued');
        final source = D4.getRequiredArg<String>(positional, 0, 'source', 'executeContinued');
        final basePath = D4.getOptionalNamedArg<String?>(named, 'basePath');
        return t.executeContinued(source, basePath: basePath);
      },
      'file': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'file');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'file');
        return t.file(path);
      },
      'script': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'script');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'script');
        return t.script(path);
      },
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'load');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'load');
        return t.load(path);
      },
      'replay': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'replay');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'replay');
        return t.replay(path);
      },
      'session': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'session');
        final sessionId = D4.getRequiredArg<String>(positional, 0, 'sessionId', 'session');
        return t.session(sessionId);
      },
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        final replayPath = D4.getOptionalNamedArg<String?>(named, 'replayPath');
        return t.reset(replayPath: replayPath);
      },
      'loadFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'loadFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadFile');
        return t.loadFile(path);
      },
      'loadScript': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'loadScript');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadScript');
        return t.loadScript(path);
      },
      'loadReplay': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'loadReplay');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadReplay');
        return t.loadReplay(path);
      },
      'loadSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'loadSession');
        final sessionId = D4.getRequiredArg<String>(positional, 0, 'sessionId', 'loadSession');
        return t.loadSession(sessionId);
      },
      'eval': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'eval');
        final expression = D4.getRequiredArg<String>(positional, 0, 'expression', 'eval');
        return t.eval(expression);
      },
      'closeSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliApi>(target, 'D4rtCliApi');
        t.closeSession();
        return null;
      },
    },
    methodSignatures: {
      'processPrompt': 'Future<dynamic> processPrompt(String line)',
      'processPrompts': 'Future<List<dynamic>> processPrompts(List<String> lines, {bool continueOnError = false})',
      'help': 'String help()',
      'info': 'SymbolInfo? info([String? name])',
      'classes': 'List<ClassInfo> classes()',
      'enums': 'List<EnumInfo> enums()',
      'methods': 'List<FunctionInfo> methods()',
      'variables': 'List<VariableInfo> variables()',
      'imports': 'List<ImportInfo> imports()',
      'registeredClasses': 'List<ClassInfo> registeredClasses()',
      'registeredEnums': 'List<EnumInfo> registeredEnums()',
      'registeredMethods': 'List<FunctionInfo> registeredMethods()',
      'registeredVariables': 'List<VariableInfo> registeredVariables()',
      'registeredImports': 'List<ImportInfo> registeredImports()',
      'showInit': 'String showInit()',
      'clear': 'void clear()',
      'define': 'void define(String name, String template)',
      'undefine': 'bool undefine(String name)',
      'defines': 'Map<String, String> defines()',
      'loadDefines': 'int loadDefines(String path)',
      'invokeDefine': 'String? invokeDefine(String name, [List<String>? args])',
      'expandDefine': 'String? expandDefine(String input)',
      'sessions': 'List<String> sessions()',
      'scripts': 'List<String> scripts()',
      'plays': 'List<String> plays()',
      'executes': 'List<String> executes()',
      'ls': 'List<String> ls([String? path])',
      'cd': 'String cd(String path)',
      'cwd': 'String cwd()',
      'home': 'String home()',
      'startDefine': 'void startDefine()',
      'startScript': 'void startScript()',
      'startFile': 'void startFile()',
      'startExecute': 'void startExecute()',
      'end': 'Future<dynamic> end()',
      'clearMultilineBuffer': 'void clearMultilineBuffer()',
      'execute': 'Future<ExecuteResult> execute(String source, {String? basePath})',
      'executeFile': 'Future<ExecuteResult> executeFile(String path)',
      'executeContinued': 'Future<ExecuteResult> executeContinued(String source, {String? basePath})',
      'file': 'Future<ExecuteResult> file(String path)',
      'script': 'Future<int> script(String path)',
      'load': 'Future<int> load(String path)',
      'replay': 'Future<int> replay(String path)',
      'session': 'Future<void> session(String sessionId)',
      'reset': 'Future<void> reset({String? replayPath})',
      'loadFile': 'String loadFile(String path)',
      'loadScript': 'String loadScript(String path)',
      'loadReplay': 'String loadReplay(String path)',
      'loadSession': 'String loadSession(String sessionId)',
      'eval': 'Future<dynamic> eval(String expression)',
      'closeSession': 'void closeSession()',
    },
    getterSignatures: {
      'isMultilineMode': 'bool get isMultilineMode',
      'multilineMode': 'MultilineMode get multilineMode',
      'multilineBuffer': 'List<String> get multilineBuffer',
      'd4rt': 'D4rt get d4rt',
      'dataDirectory': 'String get dataDirectory',
      'toolName': 'String get toolName',
      'currentSessionId': 'String? get currentSessionId',
      'configuration': 'D4rtConfiguration get configuration',
      'runtime': 'CliRuntime get runtime',
    },
  );
}

// =============================================================================
// D4rtCliController Bridge
// =============================================================================

BridgedClass _createD4rtCliControllerBridge() {
  return BridgedClass(
    nativeType: $pkg.D4rtCliController,
    name: 'D4rtCliController',
    constructors: {
      '': (visitor, positional, named) {
        final d4rt = D4.getRequiredNamedArg<ext_tom_d4rt_d4rt_base.D4rt>(named, 'd4rt', 'D4rtCliController');
        final state = D4.getRequiredNamedArg<$pkg.CliState>(named, 'state', 'D4rtCliController');
        final toolName = D4.getRequiredNamedArg<String>(named, 'toolName', 'D4rtCliController');
        final runtime = D4.getOptionalNamedArg<$pkg.CliRuntime?>(named, 'runtime');
        return $pkg.D4rtCliController(d4rt: d4rt, state: state, toolName: toolName, runtime: runtime);
      },
    },
    getters: {
      'd4rt': (visitor, target) => D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController').d4rt,
      'dataDirectory': (visitor, target) => D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController').dataDirectory,
      'toolName': (visitor, target) => D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController').toolName,
      'currentSessionId': (visitor, target) => D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController').currentSessionId,
      'configuration': (visitor, target) => D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController').configuration,
      'runtime': (visitor, target) => D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController').runtime,
      'isMultilineMode': (visitor, target) => D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController').isMultilineMode,
      'multilineMode': (visitor, target) => D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController').multilineMode,
      'multilineBuffer': (visitor, target) => D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController').multilineBuffer,
    },
    methods: {
      'processPrompt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'processPrompt');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'processPrompt');
        return t.processPrompt(line);
      },
      'processPrompts': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'processPrompts');
        if (positional.isEmpty) {
          throw ArgumentError('processPrompts: Missing required argument "lines" at position 0');
        }
        final lines = D4.coerceList<String>(positional[0], 'lines');
        final continueOnError = D4.getNamedArgWithDefault<bool>(named, 'continueOnError', false);
        return t.processPrompts(lines, continueOnError: continueOnError);
      },
      'help': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.help();
      },
      'info': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        final name = D4.getOptionalArg<String?>(positional, 0, 'name');
        return t.info(name);
      },
      'classes': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.classes();
      },
      'enums': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.enums();
      },
      'methods': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.methods();
      },
      'variables': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.variables();
      },
      'imports': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.imports();
      },
      'registeredClasses': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.registeredClasses();
      },
      'registeredEnums': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.registeredEnums();
      },
      'registeredMethods': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.registeredMethods();
      },
      'registeredVariables': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.registeredVariables();
      },
      'registeredImports': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.registeredImports();
      },
      'showInit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.showInit();
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        t.clear();
        return null;
      },
      'define': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 2, 'define');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'define');
        final template = D4.getRequiredArg<String>(positional, 1, 'template', 'define');
        t.define(name, template);
        return null;
      },
      'undefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'undefine');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'undefine');
        return t.undefine(name);
      },
      'defines': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.defines();
      },
      'loadDefines': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'loadDefines');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadDefines');
        return t.loadDefines(path);
      },
      'invokeDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'invokeDefine');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeDefine');
        final args = positional.length > 1
            ? D4.coerceListOrNull<String>(positional[1], 'args')
            : null;
        return t.invokeDefine(name, args);
      },
      'expandDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'expandDefine');
        final input = D4.getRequiredArg<String>(positional, 0, 'input', 'expandDefine');
        return t.expandDefine(input);
      },
      'sessions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.sessions();
      },
      'scripts': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.scripts();
      },
      'plays': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.plays();
      },
      'executes': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.executes();
      },
      'ls': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        final path = D4.getOptionalArg<String?>(positional, 0, 'path');
        return t.ls(path);
      },
      'cd': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'cd');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'cd');
        return t.cd(path);
      },
      'cwd': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.cwd();
      },
      'home': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.home();
      },
      'startDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        t.startDefine();
        return null;
      },
      'startScript': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        t.startScript();
        return null;
      },
      'startFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        t.startFile();
        return null;
      },
      'startExecute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        t.startExecute();
        return null;
      },
      'end': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        return t.end();
      },
      'clearMultilineBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        t.clearMultilineBuffer();
        return null;
      },
      'execute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'execute');
        final source = D4.getRequiredArg<String>(positional, 0, 'source', 'execute');
        final basePath = D4.getOptionalNamedArg<String?>(named, 'basePath');
        return t.execute(source, basePath: basePath);
      },
      'executeFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'executeFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'executeFile');
        return t.executeFile(path);
      },
      'executeContinued': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'executeContinued');
        final source = D4.getRequiredArg<String>(positional, 0, 'source', 'executeContinued');
        final basePath = D4.getOptionalNamedArg<String?>(named, 'basePath');
        return t.executeContinued(source, basePath: basePath);
      },
      'file': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'file');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'file');
        return t.file(path);
      },
      'script': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'script');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'script');
        return t.script(path);
      },
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'load');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'load');
        return t.load(path);
      },
      'replay': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'replay');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'replay');
        return t.replay(path);
      },
      'session': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'session');
        final sessionId = D4.getRequiredArg<String>(positional, 0, 'sessionId', 'session');
        return t.session(sessionId);
      },
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        final replayPath = D4.getOptionalNamedArg<String?>(named, 'replayPath');
        return t.reset(replayPath: replayPath);
      },
      'closeSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        t.closeSession();
        return null;
      },
      'loadFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'loadFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadFile');
        return t.loadFile(path);
      },
      'loadScript': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'loadScript');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadScript');
        return t.loadScript(path);
      },
      'loadReplay': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'loadReplay');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadReplay');
        return t.loadReplay(path);
      },
      'loadSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'loadSession');
        final sessionId = D4.getRequiredArg<String>(positional, 0, 'sessionId', 'loadSession');
        return t.loadSession(sessionId);
      },
      'eval': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.D4rtCliController>(target, 'D4rtCliController');
        D4.requireMinArgs(positional, 1, 'eval');
        final expression = D4.getRequiredArg<String>(positional, 0, 'expression', 'eval');
        return t.eval(expression);
      },
    },
    constructorSignatures: {
      '': 'D4rtCliController({required D4rt d4rt, required CliState state, required String toolName, CliRuntime? runtime})',
    },
    methodSignatures: {
      'processPrompt': 'Future<dynamic> processPrompt(String line)',
      'processPrompts': 'Future<List<dynamic>> processPrompts(List<String> lines, {bool continueOnError = false})',
      'help': 'String help()',
      'info': 'SymbolInfo? info([String? name])',
      'classes': 'List<ClassInfo> classes()',
      'enums': 'List<EnumInfo> enums()',
      'methods': 'List<FunctionInfo> methods()',
      'variables': 'List<VariableInfo> variables()',
      'imports': 'List<ImportInfo> imports()',
      'registeredClasses': 'List<ClassInfo> registeredClasses()',
      'registeredEnums': 'List<EnumInfo> registeredEnums()',
      'registeredMethods': 'List<FunctionInfo> registeredMethods()',
      'registeredVariables': 'List<VariableInfo> registeredVariables()',
      'registeredImports': 'List<ImportInfo> registeredImports()',
      'showInit': 'String showInit()',
      'clear': 'void clear()',
      'define': 'void define(String name, String template)',
      'undefine': 'bool undefine(String name)',
      'defines': 'Map<String, String> defines()',
      'loadDefines': 'int loadDefines(String path)',
      'invokeDefine': 'String? invokeDefine(String name, [List<String>? args])',
      'expandDefine': 'String? expandDefine(String input)',
      'sessions': 'List<String> sessions()',
      'scripts': 'List<String> scripts()',
      'plays': 'List<String> plays()',
      'executes': 'List<String> executes()',
      'ls': 'List<String> ls([String? path])',
      'cd': 'String cd(String path)',
      'cwd': 'String cwd()',
      'home': 'String home()',
      'startDefine': 'void startDefine()',
      'startScript': 'void startScript()',
      'startFile': 'void startFile()',
      'startExecute': 'void startExecute()',
      'end': 'Future<dynamic> end()',
      'clearMultilineBuffer': 'void clearMultilineBuffer()',
      'execute': 'Future<ExecuteResult> execute(String source, {String? basePath})',
      'executeFile': 'Future<ExecuteResult> executeFile(String path)',
      'executeContinued': 'Future<ExecuteResult> executeContinued(String source, {String? basePath})',
      'file': 'Future<ExecuteResult> file(String path)',
      'script': 'Future<int> script(String path)',
      'load': 'Future<int> load(String path)',
      'replay': 'Future<int> replay(String path)',
      'session': 'Future<void> session(String sessionId)',
      'reset': 'Future<void> reset({String? replayPath})',
      'closeSession': 'void closeSession()',
      'loadFile': 'String loadFile(String path)',
      'loadScript': 'String loadScript(String path)',
      'loadReplay': 'String loadReplay(String path)',
      'loadSession': 'String loadSession(String sessionId)',
      'eval': 'Future<dynamic> eval(String expression)',
    },
    getterSignatures: {
      'd4rt': 'D4rt get d4rt',
      'dataDirectory': 'String get dataDirectory',
      'toolName': 'String get toolName',
      'currentSessionId': 'String? get currentSessionId',
      'configuration': 'D4rtConfiguration get configuration',
      'runtime': 'CliRuntime get runtime',
      'isMultilineMode': 'bool get isMultilineMode',
      'multilineMode': 'MultilineMode get multilineMode',
      'multilineBuffer': 'List<String> get multilineBuffer',
    },
  );
}

// =============================================================================
// CliGlobalHolder Bridge
// =============================================================================

BridgedClass _createCliGlobalHolderBridge() {
  return BridgedClass(
    nativeType: $pkg.CliGlobalHolder,
    name: 'CliGlobalHolder',
    constructors: {
    },
    getters: {
      'controller': (visitor, target) => D4.validateTarget<$pkg.CliGlobalHolder>(target, 'CliGlobalHolder').controller,
      'isInitialized': (visitor, target) => D4.validateTarget<$pkg.CliGlobalHolder>(target, 'CliGlobalHolder').isInitialized,
    },
    methods: {
      'initialize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliGlobalHolder>(target, 'CliGlobalHolder');
        D4.requireMinArgs(positional, 1, 'initialize');
        final controller = D4.getRequiredArg<$pkg.D4rtCliController>(positional, 0, 'controller', 'initialize');
        t.initialize(controller);
        return null;
      },
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliGlobalHolder>(target, 'CliGlobalHolder');
        t.reset();
        return null;
      },
    },
    methodSignatures: {
      'initialize': 'void initialize(D4rtCliController controller)',
      'reset': 'void reset()',
    },
    getterSignatures: {
      'controller': 'D4rtCliController get controller',
      'isInitialized': 'bool get isInitialized',
    },
  );
}

// =============================================================================
// CliException Bridge
// =============================================================================

BridgedClass _createCliExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.CliException,
    name: 'CliException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CliException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'CliException');
        final command = D4.getOptionalNamedArg<String?>(named, 'command');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        return $pkg.CliException(message, command: command, stackTrace: stackTrace);
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<$pkg.CliException>(target, 'CliException').command,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.CliException>(target, 'CliException').stackTrace,
      'message': (visitor, target) => D4.validateTarget<$pkg.CliException>(target, 'CliException').message,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliException>(target, 'CliException');
        return t.toString();
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliException>(target, 'CliException');
        return t.revoke();
      },
    },
    constructorSignatures: {
      '': 'CliException(String message, {String? command, StackTrace? stackTrace})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'revoke': 'bool revoke()',
    },
    getterSignatures: {
      'command': 'String? get command',
      'stackTrace': 'StackTrace? get stackTrace',
      'message': 'String get message',
    },
  );
}

// =============================================================================
// CliFileNotFoundException Bridge
// =============================================================================

BridgedClass _createCliFileNotFoundExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.CliFileNotFoundException,
    name: 'CliFileNotFoundException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CliFileNotFoundException');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'CliFileNotFoundException');
        return $pkg.CliFileNotFoundException(path);
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<$pkg.CliFileNotFoundException>(target, 'CliFileNotFoundException').command,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.CliFileNotFoundException>(target, 'CliFileNotFoundException').stackTrace,
      'message': (visitor, target) => D4.validateTarget<$pkg.CliFileNotFoundException>(target, 'CliFileNotFoundException').message,
      'path': (visitor, target) => D4.validateTarget<$pkg.CliFileNotFoundException>(target, 'CliFileNotFoundException').path,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliFileNotFoundException>(target, 'CliFileNotFoundException');
        return t.toString();
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliFileNotFoundException>(target, 'CliFileNotFoundException');
        return t.revoke();
      },
    },
    constructorSignatures: {
      '': 'CliFileNotFoundException(String path)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'revoke': 'bool revoke()',
    },
    getterSignatures: {
      'command': 'String? get command',
      'stackTrace': 'StackTrace? get stackTrace',
      'message': 'String get message',
      'path': 'String get path',
    },
  );
}

// =============================================================================
// DirectoryNotFoundException Bridge
// =============================================================================

BridgedClass _createDirectoryNotFoundExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.DirectoryNotFoundException,
    name: 'DirectoryNotFoundException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DirectoryNotFoundException');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'DirectoryNotFoundException');
        return $pkg.DirectoryNotFoundException(path);
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<$pkg.DirectoryNotFoundException>(target, 'DirectoryNotFoundException').command,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.DirectoryNotFoundException>(target, 'DirectoryNotFoundException').stackTrace,
      'message': (visitor, target) => D4.validateTarget<$pkg.DirectoryNotFoundException>(target, 'DirectoryNotFoundException').message,
      'path': (visitor, target) => D4.validateTarget<$pkg.DirectoryNotFoundException>(target, 'DirectoryNotFoundException').path,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DirectoryNotFoundException>(target, 'DirectoryNotFoundException');
        return t.toString();
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DirectoryNotFoundException>(target, 'DirectoryNotFoundException');
        return t.revoke();
      },
    },
    constructorSignatures: {
      '': 'DirectoryNotFoundException(String path)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'revoke': 'bool revoke()',
    },
    getterSignatures: {
      'command': 'String? get command',
      'stackTrace': 'StackTrace? get stackTrace',
      'message': 'String get message',
      'path': 'String get path',
    },
  );
}

// =============================================================================
// ExecutionException Bridge
// =============================================================================

BridgedClass _createExecutionExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.ExecutionException,
    name: 'ExecutionException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ExecutionException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'ExecutionException');
        final command = D4.getOptionalNamedArg<String?>(named, 'command');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        return $pkg.ExecutionException(message, command: command, stackTrace: stackTrace);
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<$pkg.ExecutionException>(target, 'ExecutionException').command,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.ExecutionException>(target, 'ExecutionException').stackTrace,
      'message': (visitor, target) => D4.validateTarget<$pkg.ExecutionException>(target, 'ExecutionException').message,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ExecutionException>(target, 'ExecutionException');
        return t.toString();
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ExecutionException>(target, 'ExecutionException');
        return t.revoke();
      },
    },
    constructorSignatures: {
      '': 'ExecutionException(String message, {String? command, StackTrace? stackTrace})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'revoke': 'bool revoke()',
    },
    getterSignatures: {
      'command': 'String? get command',
      'stackTrace': 'StackTrace? get stackTrace',
      'message': 'String get message',
    },
  );
}

// =============================================================================
// ReplayException Bridge
// =============================================================================

BridgedClass _createReplayExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.ReplayException,
    name: 'ReplayException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'ReplayException');
        final file = D4.getRequiredArg<String>(positional, 0, 'file', 'ReplayException');
        final line = D4.getRequiredArg<int>(positional, 1, 'line', 'ReplayException');
        final cause = D4.getRequiredArg<$pkg.CliException>(positional, 2, 'cause', 'ReplayException');
        return $pkg.ReplayException(file, line, cause);
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<$pkg.ReplayException>(target, 'ReplayException').command,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.ReplayException>(target, 'ReplayException').stackTrace,
      'message': (visitor, target) => D4.validateTarget<$pkg.ReplayException>(target, 'ReplayException').message,
      'file': (visitor, target) => D4.validateTarget<$pkg.ReplayException>(target, 'ReplayException').file,
      'line': (visitor, target) => D4.validateTarget<$pkg.ReplayException>(target, 'ReplayException').line,
      'cause': (visitor, target) => D4.validateTarget<$pkg.ReplayException>(target, 'ReplayException').cause,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ReplayException>(target, 'ReplayException');
        return t.toString();
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ReplayException>(target, 'ReplayException');
        return t.revoke();
      },
    },
    constructorSignatures: {
      '': 'ReplayException(String file, int line, CliException cause)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'revoke': 'bool revoke()',
    },
    getterSignatures: {
      'command': 'String? get command',
      'stackTrace': 'StackTrace? get stackTrace',
      'message': 'String get message',
      'file': 'String get file',
      'line': 'int get line',
      'cause': 'CliException get cause',
    },
  );
}

// =============================================================================
// InvalidMultilineModeException Bridge
// =============================================================================

BridgedClass _createInvalidMultilineModeExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.InvalidMultilineModeException,
    name: 'InvalidMultilineModeException',
    constructors: {
      '': (visitor, positional, named) {
        final currentMode = D4.getRequiredNamedArg<String>(named, 'currentMode', 'InvalidMultilineModeException');
        final attemptedMethod = D4.getRequiredNamedArg<String>(named, 'attemptedMethod', 'InvalidMultilineModeException');
        return $pkg.InvalidMultilineModeException(currentMode: currentMode, attemptedMethod: attemptedMethod);
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<$pkg.InvalidMultilineModeException>(target, 'InvalidMultilineModeException').command,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.InvalidMultilineModeException>(target, 'InvalidMultilineModeException').stackTrace,
      'message': (visitor, target) => D4.validateTarget<$pkg.InvalidMultilineModeException>(target, 'InvalidMultilineModeException').message,
      'currentMode': (visitor, target) => D4.validateTarget<$pkg.InvalidMultilineModeException>(target, 'InvalidMultilineModeException').currentMode,
      'attemptedMethod': (visitor, target) => D4.validateTarget<$pkg.InvalidMultilineModeException>(target, 'InvalidMultilineModeException').attemptedMethod,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidMultilineModeException>(target, 'InvalidMultilineModeException');
        return t.toString();
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidMultilineModeException>(target, 'InvalidMultilineModeException');
        return t.revoke();
      },
    },
    constructorSignatures: {
      '': 'InvalidMultilineModeException({required String currentMode, required String attemptedMethod})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'revoke': 'bool revoke()',
    },
    getterSignatures: {
      'command': 'String? get command',
      'stackTrace': 'StackTrace? get stackTrace',
      'message': 'String get message',
      'currentMode': 'String get currentMode',
      'attemptedMethod': 'String get attemptedMethod',
    },
  );
}

// =============================================================================
// MaxNestingDepthException Bridge
// =============================================================================

BridgedClass _createMaxNestingDepthExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.MaxNestingDepthException,
    name: 'MaxNestingDepthException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MaxNestingDepthException');
        final maxDepth = D4.getRequiredArg<int>(positional, 0, 'maxDepth', 'MaxNestingDepthException');
        return $pkg.MaxNestingDepthException(maxDepth);
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<$pkg.MaxNestingDepthException>(target, 'MaxNestingDepthException').command,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.MaxNestingDepthException>(target, 'MaxNestingDepthException').stackTrace,
      'message': (visitor, target) => D4.validateTarget<$pkg.MaxNestingDepthException>(target, 'MaxNestingDepthException').message,
      'maxDepth': (visitor, target) => D4.validateTarget<$pkg.MaxNestingDepthException>(target, 'MaxNestingDepthException').maxDepth,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MaxNestingDepthException>(target, 'MaxNestingDepthException');
        return t.toString();
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MaxNestingDepthException>(target, 'MaxNestingDepthException');
        return t.revoke();
      },
    },
    constructorSignatures: {
      '': 'MaxNestingDepthException(int maxDepth)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'revoke': 'bool revoke()',
    },
    getterSignatures: {
      'command': 'String? get command',
      'stackTrace': 'StackTrace? get stackTrace',
      'message': 'String get message',
      'maxDepth': 'int get maxDepth',
    },
  );
}

// =============================================================================
// CliNotInitializedException Bridge
// =============================================================================

BridgedClass _createCliNotInitializedExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.CliNotInitializedException,
    name: 'CliNotInitializedException',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.CliNotInitializedException();
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<$pkg.CliNotInitializedException>(target, 'CliNotInitializedException').command,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.CliNotInitializedException>(target, 'CliNotInitializedException').stackTrace,
      'message': (visitor, target) => D4.validateTarget<$pkg.CliNotInitializedException>(target, 'CliNotInitializedException').message,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliNotInitializedException>(target, 'CliNotInitializedException');
        return t.toString();
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliNotInitializedException>(target, 'CliNotInitializedException');
        return t.revoke();
      },
    },
    constructorSignatures: {
      '': 'CliNotInitializedException()',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'revoke': 'bool revoke()',
    },
    getterSignatures: {
      'command': 'String? get command',
      'stackTrace': 'StackTrace? get stackTrace',
      'message': 'String get message',
    },
  );
}

// =============================================================================
// ExecuteResult Bridge
// =============================================================================

BridgedClass _createExecuteResultBridge() {
  return BridgedClass(
    nativeType: $pkg.ExecuteResult,
    name: 'ExecuteResult',
    constructors: {
      '': (visitor, positional, named) {
        final success = D4.getRequiredNamedArg<bool>(named, 'success', 'ExecuteResult');
        final result = D4.getOptionalNamedArg<dynamic>(named, 'result');
        final error = D4.getOptionalNamedArg<String?>(named, 'error');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        final sourcesLoaded = D4.getNamedArgWithDefault<int>(named, 'sourcesLoaded', 1);
        return $pkg.ExecuteResult(success: success, result: result, error: error, stackTrace: stackTrace, sourcesLoaded: sourcesLoaded);
      },
      'success': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ExecuteResult');
        final result = D4.getRequiredArg<dynamic>(positional, 0, 'result', 'ExecuteResult');
        return $pkg.ExecuteResult.success(result);
      },
      'failure': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ExecuteResult');
        final error = D4.getRequiredArg<String?>(positional, 0, 'error', 'ExecuteResult');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        return $pkg.ExecuteResult.failure(error, stackTrace: stackTrace);
      },
    },
    getters: {
      'success': (visitor, target) => D4.validateTarget<$pkg.ExecuteResult>(target, 'ExecuteResult').success,
      'result': (visitor, target) => D4.validateTarget<$pkg.ExecuteResult>(target, 'ExecuteResult').result,
      'error': (visitor, target) => D4.validateTarget<$pkg.ExecuteResult>(target, 'ExecuteResult').error,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.ExecuteResult>(target, 'ExecuteResult').stackTrace,
      'sourcesLoaded': (visitor, target) => D4.validateTarget<$pkg.ExecuteResult>(target, 'ExecuteResult').sourcesLoaded,
    },
    constructorSignatures: {
      '': 'const ExecuteResult({required bool success, dynamic result, String? error, StackTrace? stackTrace, int sourcesLoaded = 1})',
      'success': 'const ExecuteResult.success(dynamic result)',
      'failure': 'ExecuteResult.failure(String? error, {StackTrace? stackTrace})',
    },
    getterSignatures: {
      'success': 'bool get success',
      'result': 'dynamic get result',
      'error': 'String? get error',
      'stackTrace': 'StackTrace? get stackTrace',
      'sourcesLoaded': 'int get sourcesLoaded',
    },
  );
}

// =============================================================================
// ImportInfo Bridge
// =============================================================================

BridgedClass _createImportInfoBridge() {
  return BridgedClass(
    nativeType: $pkg.ImportInfo,
    name: 'ImportInfo',
    constructors: {
      '': (visitor, positional, named) {
        final path = D4.getRequiredNamedArg<String>(named, 'path', 'ImportInfo');
        final classes = named.containsKey('classes') && named['classes'] != null
            ? D4.coerceList<String>(named['classes'], 'classes')
            : const <String>[];
        final enums = named.containsKey('enums') && named['enums'] != null
            ? D4.coerceList<String>(named['enums'], 'enums')
            : const <String>[];
        final functions = named.containsKey('functions') && named['functions'] != null
            ? D4.coerceList<String>(named['functions'], 'functions')
            : const <String>[];
        final variables = named.containsKey('variables') && named['variables'] != null
            ? D4.coerceList<String>(named['variables'], 'variables')
            : const <String>[];
        return $pkg.ImportInfo(path: path, classes: classes, enums: enums, functions: functions, variables: variables);
      },
    },
    getters: {
      'path': (visitor, target) => D4.validateTarget<$pkg.ImportInfo>(target, 'ImportInfo').path,
      'classes': (visitor, target) => D4.validateTarget<$pkg.ImportInfo>(target, 'ImportInfo').classes,
      'enums': (visitor, target) => D4.validateTarget<$pkg.ImportInfo>(target, 'ImportInfo').enums,
      'functions': (visitor, target) => D4.validateTarget<$pkg.ImportInfo>(target, 'ImportInfo').functions,
      'variables': (visitor, target) => D4.validateTarget<$pkg.ImportInfo>(target, 'ImportInfo').variables,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ImportInfo>(target, 'ImportInfo');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const ImportInfo({required String path, List<String> classes = const [], List<String> enums = const [], List<String> functions = const [], List<String> variables = const []})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'path': 'String get path',
      'classes': 'List<String> get classes',
      'enums': 'List<String> get enums',
      'functions': 'List<String> get functions',
      'variables': 'List<String> get variables',
    },
  );
}

// =============================================================================
// SymbolInfo Bridge
// =============================================================================

BridgedClass _createSymbolInfoBridge() {
  return BridgedClass(
    nativeType: $pkg.SymbolInfo,
    name: 'SymbolInfo',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'SymbolInfo');
        final kind = D4.getRequiredNamedArg<$pkg.SymbolKind>(named, 'kind', 'SymbolInfo');
        final documentation = D4.getOptionalNamedArg<String?>(named, 'documentation');
        final details = named.containsKey('details') && named['details'] != null
            ? D4.coerceMap<String, dynamic>(named['details'], 'details')
            : const <String, dynamic>{};
        return $pkg.SymbolInfo(name: name, kind: kind, documentation: documentation, details: details);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.SymbolInfo>(target, 'SymbolInfo').name,
      'kind': (visitor, target) => D4.validateTarget<$pkg.SymbolInfo>(target, 'SymbolInfo').kind,
      'documentation': (visitor, target) => D4.validateTarget<$pkg.SymbolInfo>(target, 'SymbolInfo').documentation,
      'details': (visitor, target) => D4.validateTarget<$pkg.SymbolInfo>(target, 'SymbolInfo').details,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.SymbolInfo>(target, 'SymbolInfo');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'const SymbolInfo({required String name, required SymbolKind kind, String? documentation, Map<String, dynamic> details = const {}})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'name': 'String get name',
      'kind': 'SymbolKind get kind',
      'documentation': 'String? get documentation',
      'details': 'Map<String, dynamic> get details',
    },
  );
}

// =============================================================================
// CliRuntime Bridge
// =============================================================================

BridgedClass _createCliRuntimeBridge() {
  return BridgedClass(
    nativeType: $pkg.CliRuntime,
    name: 'CliRuntime',
    constructors: {
    },
    getters: {
      'processDirectory': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').processDirectory,
      'processDirectoryObject': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').processDirectoryObject,
      'pid': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').pid,
      'executable': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').executable,
      'resolvedExecutable': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').resolvedExecutable,
      'executableArguments': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').executableArguments,
      'script': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').script,
      'version': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').version,
      'environment': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').environment,
      'operatingSystem': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').operatingSystem,
      'operatingSystemVersion': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').operatingSystemVersion,
      'numberOfProcessors': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').numberOfProcessors,
      'localHostname': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').localHostname,
      'pathSeparator': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').pathSeparator,
      'isLinux': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').isLinux,
      'isMacOS': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').isMacOS,
      'isWindows': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').isWindows,
      'isAndroid': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').isAndroid,
      'isIOS': (visitor, target) => D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').isIOS,
    },
    setters: {
      'processDirectory': (visitor, target, value) => 
        D4.validateTarget<$pkg.CliRuntime>(target, 'CliRuntime').processDirectory = value as dynamic,
    },
    getterSignatures: {
      'processDirectory': 'String get processDirectory',
      'processDirectoryObject': 'io.Directory get processDirectoryObject',
      'pid': 'int get pid',
      'executable': 'String get executable',
      'resolvedExecutable': 'String get resolvedExecutable',
      'executableArguments': 'List<String> get executableArguments',
      'script': 'Uri get script',
      'version': 'String get version',
      'environment': 'Map<String, String> get environment',
      'operatingSystem': 'String get operatingSystem',
      'operatingSystemVersion': 'String get operatingSystemVersion',
      'numberOfProcessors': 'int get numberOfProcessors',
      'localHostname': 'String get localHostname',
      'pathSeparator': 'String get pathSeparator',
      'isLinux': 'bool get isLinux',
      'isMacOS': 'bool get isMacOS',
      'isWindows': 'bool get isWindows',
      'isAndroid': 'bool get isAndroid',
      'isIOS': 'bool get isIOS',
    },
    setterSignatures: {
      'processDirectory': 'set processDirectory(String value)',
    },
  );
}

// =============================================================================
// CliRuntimeImpl Bridge
// =============================================================================

BridgedClass _createCliRuntimeImplBridge() {
  return BridgedClass(
    nativeType: $pkg.CliRuntimeImpl,
    name: 'CliRuntimeImpl',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.CliRuntimeImpl();
      },
    },
    getters: {
      'processDirectory': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').processDirectory,
      'processDirectoryObject': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').processDirectoryObject,
      'pid': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').pid,
      'executable': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').executable,
      'resolvedExecutable': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').resolvedExecutable,
      'executableArguments': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').executableArguments,
      'script': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').script,
      'version': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').version,
      'environment': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').environment,
      'operatingSystem': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').operatingSystem,
      'operatingSystemVersion': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').operatingSystemVersion,
      'numberOfProcessors': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').numberOfProcessors,
      'localHostname': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').localHostname,
      'pathSeparator': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').pathSeparator,
      'isLinux': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').isLinux,
      'isMacOS': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').isMacOS,
      'isWindows': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').isWindows,
      'isAndroid': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').isAndroid,
      'isIOS': (visitor, target) => D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').isIOS,
    },
    setters: {
      'processDirectory': (visitor, target, value) => 
        D4.validateTarget<$pkg.CliRuntimeImpl>(target, 'CliRuntimeImpl').processDirectory = value as dynamic,
    },
    constructorSignatures: {
      '': 'CliRuntimeImpl()',
    },
    getterSignatures: {
      'processDirectory': 'String get processDirectory',
      'processDirectoryObject': 'io.Directory get processDirectoryObject',
      'pid': 'int get pid',
      'executable': 'String get executable',
      'resolvedExecutable': 'String get resolvedExecutable',
      'executableArguments': 'List<String> get executableArguments',
      'script': 'Uri get script',
      'version': 'String get version',
      'environment': 'Map<String, String> get environment',
      'operatingSystem': 'String get operatingSystem',
      'operatingSystemVersion': 'String get operatingSystemVersion',
      'numberOfProcessors': 'int get numberOfProcessors',
      'localHostname': 'String get localHostname',
      'pathSeparator': 'String get pathSeparator',
      'isLinux': 'bool get isLinux',
      'isMacOS': 'bool get isMacOS',
      'isWindows': 'bool get isWindows',
      'isAndroid': 'bool get isAndroid',
      'isIOS': 'bool get isIOS',
    },
    setterSignatures: {
      'processDirectory': 'set processDirectory(String value)',
    },
  );
}

// =============================================================================
// CliState Bridge
// =============================================================================

BridgedClass _createCliStateBridge() {
  return BridgedClass(
    nativeType: $pkg.CliState,
    name: 'CliState',
    constructors: {
      '': (visitor, positional, named) {
        final dataDirectory = D4.getRequiredNamedArg<String>(named, 'dataDirectory', 'CliState');
        final initialDirectory = D4.getOptionalNamedArg<String?>(named, 'initialDirectory');
        return $pkg.CliState(dataDirectory: dataDirectory, initialDirectory: initialDirectory);
      },
    },
    getters: {
      'dataDirectory': (visitor, target) => D4.validateTarget<$pkg.CliState>(target, 'CliState').dataDirectory,
      'contextStack': (visitor, target) => D4.validateTarget<$pkg.CliState>(target, 'CliState').contextStack,
      'sessionFile': (visitor, target) => D4.validateTarget<$pkg.CliState>(target, 'CliState').sessionFile,
      'currentSessionId': (visitor, target) => D4.validateTarget<$pkg.CliState>(target, 'CliState').currentSessionId,
      'cwd': (visitor, target) => D4.validateTarget<$pkg.CliState>(target, 'CliState').cwd,
      'defines': (visitor, target) => D4.validateTarget<$pkg.CliState>(target, 'CliState').defines,
      'hasActiveSession': (visitor, target) => D4.validateTarget<$pkg.CliState>(target, 'CliState').hasActiveSession,
      'multilineMode': (visitor, target) => D4.validateTarget<$pkg.CliState>(target, 'CliState').multilineMode,
      'isMultilineMode': (visitor, target) => D4.validateTarget<$pkg.CliState>(target, 'CliState').isMultilineMode,
      'multilineBuffer': (visitor, target) => D4.validateTarget<$pkg.CliState>(target, 'CliState').multilineBuffer,
    },
    setters: {
      'sessionFile': (visitor, target, value) => 
        D4.validateTarget<$pkg.CliState>(target, 'CliState').sessionFile = value as RandomAccessFile?,
      'currentSessionId': (visitor, target, value) => 
        D4.validateTarget<$pkg.CliState>(target, 'CliState').currentSessionId = value as String?,
    },
    methods: {
      'cd': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'cd');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'cd');
        return t.cd(path);
      },
      'home': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        return t.home();
      },
      'resolvePath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'resolvePath');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'resolvePath');
        return t.resolvePath(path);
      },
      'getDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'getDefine');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getDefine');
        return t.getDefine(name);
      },
      'setDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 2, 'setDefine');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'setDefine');
        final value = D4.getRequiredArg<String?>(positional, 1, 'value', 'setDefine');
        t.setDefine(name, value);
        return null;
      },
      'removeDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'removeDefine');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'removeDefine');
        t.removeDefine(name);
        return null;
      },
      'clearDefines': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        t.clearDefines();
        return null;
      },
      'getSessionPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'getSessionPath');
        final sessionId = D4.getRequiredArg<String>(positional, 0, 'sessionId', 'getSessionPath');
        return t.getSessionPath(sessionId);
      },
      'startSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'startSession');
        final sessionId = D4.getRequiredArg<String>(positional, 0, 'sessionId', 'startSession');
        return t.startSession(sessionId);
      },
      'closeSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        t.closeSession();
        return null;
      },
      'recordToSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'recordToSession');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'recordToSession');
        t.recordToSession(command);
        return null;
      },
      'clearMultilineBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        t.clearMultilineBuffer();
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        t.dispose();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CliState>(target, 'CliState');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'CliState({required String dataDirectory, String? initialDirectory})',
    },
    methodSignatures: {
      'cd': 'String cd(String path)',
      'home': 'String home()',
      'resolvePath': 'String resolvePath(String path)',
      'getDefine': 'String? getDefine(String name)',
      'setDefine': 'void setDefine(String name, String? value)',
      'removeDefine': 'void removeDefine(String name)',
      'clearDefines': 'void clearDefines()',
      'getSessionPath': 'String getSessionPath(String sessionId)',
      'startSession': 'bool startSession(String sessionId)',
      'closeSession': 'void closeSession()',
      'recordToSession': 'void recordToSession(String command)',
      'clearMultilineBuffer': 'void clearMultilineBuffer()',
      'dispose': 'void dispose()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'dataDirectory': 'String get dataDirectory',
      'contextStack': 'ContextStack get contextStack',
      'sessionFile': 'RandomAccessFile? get sessionFile',
      'currentSessionId': 'String? get currentSessionId',
      'cwd': 'String get cwd',
      'defines': 'Map<String, String> get defines',
      'hasActiveSession': 'bool get hasActiveSession',
      'multilineMode': 'MultilineMode get multilineMode',
      'isMultilineMode': 'bool get isMultilineMode',
      'multilineBuffer': 'List<String> get multilineBuffer',
    },
    setterSignatures: {
      'sessionFile': 'set sessionFile(dynamic value)',
      'currentSessionId': 'set currentSessionId(dynamic value)',
    },
  );
}

// =============================================================================
// VerificationFailure Bridge
// =============================================================================

BridgedClass _createVerificationFailureBridge() {
  return BridgedClass(
    nativeType: $pkg.VerificationFailure,
    name: 'VerificationFailure',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'VerificationFailure');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'VerificationFailure');
        return $pkg.VerificationFailure(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.VerificationFailure>(target, 'VerificationFailure').message,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.VerificationFailure>(target, 'VerificationFailure');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'VerificationFailure(String message)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'message': 'String get message',
    },
  );
}

// =============================================================================
// ExecutionContext Bridge
// =============================================================================

BridgedClass _createExecutionContextBridge() {
  return BridgedClass(
    nativeType: $pkg.ExecutionContext,
    name: 'ExecutionContext',
    constructors: {
      '': (visitor, positional, named) {
        final workingDirectory = D4.getRequiredNamedArg<String>(named, 'workingDirectory', 'ExecutionContext');
        final sourceFile = D4.getOptionalNamedArg<String?>(named, 'sourceFile');
        final recordToSession = D4.getNamedArgWithDefault<bool>(named, 'recordToSession', true);
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        final parent = D4.getOptionalNamedArg<$pkg.ExecutionContext?>(named, 'parent');
        return $pkg.ExecutionContext(workingDirectory: workingDirectory, sourceFile: sourceFile, recordToSession: recordToSession, silent: silent, parent: parent);
      },
    },
    getters: {
      'workingDirectory': (visitor, target) => D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext').workingDirectory,
      'sourceFile': (visitor, target) => D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext').sourceFile,
      'recordToSession': (visitor, target) => D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext').recordToSession,
      'silent': (visitor, target) => D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext').silent,
      'parent': (visitor, target) => D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext').parent,
      'multilineMode': (visitor, target) => D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext').multilineMode,
      'multilineBuffer': (visitor, target) => D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext').multilineBuffer,
      'isMultilineMode': (visitor, target) => D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext').isMultilineMode,
      'isRoot': (visitor, target) => D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext').isRoot,
      'depth': (visitor, target) => D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext').depth,
    },
    setters: {
      'multilineMode': (visitor, target, value) => 
        D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext').multilineMode = value as $pkg.MultilineMode,
    },
    methods: {
      'clearMultilineBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext');
        t.clearMultilineBuffer();
        return null;
      },
      'startMultilineMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext');
        D4.requireMinArgs(positional, 1, 'startMultilineMode');
        final mode = D4.getRequiredArg<$pkg.MultilineMode>(positional, 0, 'mode', 'startMultilineMode');
        t.startMultilineMode(mode);
        return null;
      },
      'addMultilineLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext');
        D4.requireMinArgs(positional, 1, 'addMultilineLine');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'addMultilineLine');
        t.addMultilineLine(line);
        return null;
      },
      'getMultilineCode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext');
        return t.getMultilineCode();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ExecutionContext>(target, 'ExecutionContext');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'ExecutionContext({required String workingDirectory, String? sourceFile, bool recordToSession = true, bool silent = false, ExecutionContext? parent})',
    },
    methodSignatures: {
      'clearMultilineBuffer': 'void clearMultilineBuffer()',
      'startMultilineMode': 'void startMultilineMode(MultilineMode mode)',
      'addMultilineLine': 'void addMultilineLine(String line)',
      'getMultilineCode': 'String getMultilineCode()',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'workingDirectory': 'String get workingDirectory',
      'sourceFile': 'String? get sourceFile',
      'recordToSession': 'bool get recordToSession',
      'silent': 'bool get silent',
      'parent': 'ExecutionContext? get parent',
      'multilineMode': 'MultilineMode get multilineMode',
      'multilineBuffer': 'List<String> get multilineBuffer',
      'isMultilineMode': 'bool get isMultilineMode',
      'isRoot': 'bool get isRoot',
      'depth': 'int get depth',
    },
    setterSignatures: {
      'multilineMode': 'set multilineMode(dynamic value)',
    },
  );
}

// =============================================================================
// ContextStack Bridge
// =============================================================================

BridgedClass _createContextStackBridge() {
  return BridgedClass(
    nativeType: $pkg.ContextStack,
    name: 'ContextStack',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ContextStack');
        final initialWorkingDirectory = D4.getRequiredArg<String>(positional, 0, 'initialWorkingDirectory', 'ContextStack');
        return $pkg.ContextStack(initialWorkingDirectory);
      },
    },
    getters: {
      'current': (visitor, target) => D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack').current,
      'root': (visitor, target) => D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack').root,
      'cwd': (visitor, target) => D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack').cwd,
      'silent': (visitor, target) => D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack').silent,
      'recordToSession': (visitor, target) => D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack').recordToSession,
      'multilineMode': (visitor, target) => D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack').multilineMode,
      'isMultilineMode': (visitor, target) => D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack').isMultilineMode,
      'multilineBuffer': (visitor, target) => D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack').multilineBuffer,
      'depth': (visitor, target) => D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack').depth,
      'isRoot': (visitor, target) => D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack').isRoot,
      'length': (visitor, target) => D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack').length,
    },
    methods: {
      'push': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack');
        D4.requireMinArgs(positional, 1, 'push');
        final context = D4.getRequiredArg<$pkg.ExecutionContext>(positional, 0, 'context', 'push');
        t.push(context);
        return null;
      },
      'pop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack');
        return t.pop();
      },
      'popToRoot': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack');
        t.popToRoot();
        return null;
      },
      'updateWorkingDirectory': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack');
        D4.requireMinArgs(positional, 1, 'updateWorkingDirectory');
        final newDirectory = D4.getRequiredArg<String>(positional, 0, 'newDirectory', 'updateWorkingDirectory');
        t.updateWorkingDirectory(newDirectory);
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ContextStack>(target, 'ContextStack');
        return t.toString();
      },
    },
    staticGetters: {
      'maxDepth': (visitor) => $pkg.ContextStack.maxDepth,
    },
    constructorSignatures: {
      '': 'ContextStack(String initialWorkingDirectory)',
    },
    methodSignatures: {
      'push': 'void push(ExecutionContext context)',
      'pop': 'ExecutionContext pop()',
      'popToRoot': 'void popToRoot()',
      'updateWorkingDirectory': 'void updateWorkingDirectory(String newDirectory)',
      'toString': 'String toString()',
    },
    getterSignatures: {
      'current': 'ExecutionContext get current',
      'root': 'ExecutionContext get root',
      'cwd': 'String get cwd',
      'silent': 'bool get silent',
      'recordToSession': 'bool get recordToSession',
      'multilineMode': 'MultilineMode get multilineMode',
      'isMultilineMode': 'bool get isMultilineMode',
      'multilineBuffer': 'List<String> get multilineBuffer',
      'depth': 'int get depth',
      'isRoot': 'bool get isRoot',
      'length': 'int get length',
    },
    staticGetterSignatures: {
      'maxDepth': 'int get maxDepth',
    },
  );
}

