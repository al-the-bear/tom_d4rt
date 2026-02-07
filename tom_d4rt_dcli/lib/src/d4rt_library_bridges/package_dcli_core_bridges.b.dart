// D4rt Bridge - Generated file, do not edit
// Sources: 29 files
// Generated: 2026-02-07T09:29:51.538307

// ignore_for_file: unused_import, deprecated_member_use

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';
import 'dart:io';

import 'package:dcli_core/dcli_core.dart' as $pkg;

/// Bridge class for package_dcli_core module.
class PackageDcliCoreBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createRestoreFileExceptionBridge(),
      _createBackupFileExceptionBridge(),
      _createCatBridge(),
      _createCatExceptionBridge(),
      _createCopyExceptionBridge(),
      _createCopyTreeExceptionBridge(),
      _createCreateDirExceptionBridge(),
      _createDCliFunctionBridge(),
      _createDCliFunctionExceptionBridge(),
      _createDeleteExceptionBridge(),
      _createDeleteDirExceptionBridge(),
      _createEnvBridge(),
      _createFindBridge(),
      _createPatternMatcherBridge(),
      _createFindItemBridge(),
      _createFindExceptionBridge(),
      _createFindConfigBridge(),
      _createFindAsyncBridge(),
      _createHeadExceptionBridge(),
      _createMoveExceptionBridge(),
      _createMoveDirExceptionBridge(),
      _createMoveTreeExceptionBridge(),
      _createTailExceptionBridge(),
      _createTouchExceptionBridge(),
      _createWhichBridge(),
      _createWhichSearchBridge(),
      _createDCliExceptionBridge(),
      _createDCliPlatformBridge(),
      _createLimitedStreamControllerBridge(),
      _createLineFileBridge(),
      _createRunExceptionBridge(),
      _createStackListBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'RestoreFileException': 'package:dcli_core/src/functions/backup.dart',
      'BackupFileException': 'package:dcli_core/src/functions/backup.dart',
      'Cat': 'package:dcli_core/src/functions/cat.dart',
      'CatException': 'package:dcli_core/src/functions/cat.dart',
      'CopyException': 'package:dcli_core/src/functions/copy.dart',
      'CopyTreeException': 'package:dcli_core/src/functions/copy_tree.dart',
      'CreateDirException': 'package:dcli_core/src/functions/create_dir.dart',
      'DCliFunction': 'package:dcli_core/src/functions/dcli_function.dart',
      'DCliFunctionException': 'package:dcli_core/src/functions/dcli_function.dart',
      'DeleteException': 'package:dcli_core/src/functions/delete.dart',
      'DeleteDirException': 'package:dcli_core/src/functions/delete_dir.dart',
      'Env': 'package:dcli_core/src/functions/env.dart',
      'Find': 'package:dcli_core/src/functions/find.dart',
      'PatternMatcher': 'package:dcli_core/src/functions/find.dart',
      'FindItem': 'package:dcli_core/src/functions/find.dart',
      'FindException': 'package:dcli_core/src/functions/find.dart',
      'FindConfig': 'package:dcli_core/src/functions/find.dart',
      'FindAsync': 'package:dcli_core/src/functions/find_async.dart',
      'HeadException': 'package:dcli_core/src/functions/head.dart',
      'MoveException': 'package:dcli_core/src/functions/move.dart',
      'MoveDirException': 'package:dcli_core/src/functions/move_dir.dart',
      'MoveTreeException': 'package:dcli_core/src/functions/move_tree.dart',
      'TailException': 'package:dcli_core/src/functions/tail.dart',
      'TouchException': 'package:dcli_core/src/functions/touch.dart',
      'Which': 'package:dcli_core/src/functions/which.dart',
      'WhichSearch': 'package:dcli_core/src/functions/which.dart',
      'DCliException': 'package:dcli_core/src/util/dcli_exception.dart',
      'DCliPlatform': 'package:dcli_core/src/util/dcli_platform.dart',
      'LimitedStreamController': 'package:dcli_core/src/util/limited_stream_controller.dart',
      'LineFile': 'package:dcli_core/src/util/line_file.dart',
      'RunException': 'package:dcli_core/src/util/run_exception.dart',
      'StackList': 'package:dcli_core/src/util/stack_list.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$pkg.DCliPlatformOS>(
        name: 'DCliPlatformOS',
        values: $pkg.DCliPlatformOS.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'DCliPlatformOS': 'package:dcli_core/src/util/dcli_platform.dart',
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

    interpreter.registerGlobalGetter('env', () => $pkg.env, importPath, sourceUri: 'package:dcli_core/src/functions/env.dart');
    interpreter.registerGlobalGetter('PATH', () => $pkg.PATH, importPath, sourceUri: 'package:dcli_core/src/functions/env.dart');
    interpreter.registerGlobalGetter('HOME', () => $pkg.HOME, importPath, sourceUri: 'package:dcli_core/src/functions/env.dart');
    interpreter.registerGlobalGetter('envs', () => $pkg.envs, importPath, sourceUri: 'package:dcli_core/src/functions/env.dart');
    interpreter.registerGlobalGetter('pwd', () => $pkg.pwd, importPath, sourceUri: 'package:dcli_core/src/functions/pwd.dart');
    interpreter.registerGlobalGetter('eol', () => $pkg.eol, importPath, sourceUri: 'package:dcli_core/src/util/platform.dart');
    interpreter.registerGlobalGetter('rootPath', () => $pkg.rootPath, importPath, sourceUri: 'package:dcli_core/src/util/truepath.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (package_dcli_core):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'withFileProtectionAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'withFileProtectionAsync');
        final protected = D4.getRequiredArg<List<String>>(positional, 0, 'protected', 'withFileProtectionAsync');
        final action = D4.getRequiredArg<Future<dynamic> Function()>(positional, 1, 'action', 'withFileProtectionAsync');
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        return $pkg.withFileProtectionAsync<dynamic>(protected, action, workingDirectory: workingDirectory);
      },
      'withTempDirAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'withTempDirAsync');
        final action = D4.getRequiredArg<Future<dynamic> Function(String)>(positional, 0, 'action', 'withTempDirAsync');
        final keep = D4.getNamedArgWithDefault<bool>(named, 'keep', false);
        final pathToTempDir = D4.getOptionalNamedArg<String?>(named, 'pathToTempDir');
        return $pkg.withTempDirAsync<dynamic>(action, keep: keep, pathToTempDir: pathToTempDir);
      },
      'isOnPATH': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isOnPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isOnPATH');
        return $pkg.isOnPATH(path);
      },
      'withEnvironmentAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'withEnvironmentAsync');
        final callback = D4.getRequiredArg<Future<dynamic> Function()>(positional, 0, 'callback', 'withEnvironmentAsync');
        final environment = D4.getRequiredNamedArg<Map<String, String>>(named, 'environment', 'withEnvironmentAsync');
        return $pkg.withEnvironmentAsync<dynamic>(callback, environment: environment);
      },
      'withEnvironment': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'withEnvironment');
        final callback = D4.getRequiredArg<dynamic Function()>(positional, 0, 'callback', 'withEnvironment');
        final environment = D4.getRequiredNamedArg<Map<String, String>>(named, 'environment', 'withEnvironment');
        return $pkg.withEnvironment<dynamic>(callback, environment: environment);
      },
      'findAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findAsync');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'findAsync');
        final caseSensitive = D4.getNamedArgWithDefault<bool>(named, 'caseSensitive', false);
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', true);
        final includeHidden = D4.getNamedArgWithDefault<bool>(named, 'includeHidden', false);
        final workingDirectory = D4.getNamedArgWithDefault<String>(named, 'workingDirectory', '.');
        if (!named.containsKey('types')) {
          return $pkg.findAsync(pattern, caseSensitive: caseSensitive, recursive: recursive, includeHidden: includeHidden, workingDirectory: workingDirectory);
        }
        if (named.containsKey('types')) {
          final types = D4.getRequiredNamedArg<List<FileSystemEntityType>>(named, 'types', 'findAsync');
          return $pkg.findAsync(pattern, caseSensitive: caseSensitive, recursive: recursive, includeHidden: includeHidden, workingDirectory: workingDirectory, types: types);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'devNull': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'devNull');
        final line = D4.getRequiredArg<String?>(positional, 0, 'line', 'devNull');
        return $pkg.devNull(line);
      },
      'withTempFileAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'withTempFileAsync');
        final action = D4.getRequiredArg<Future<dynamic> Function(String)>(positional, 0, 'action', 'withTempFileAsync');
        final suffix = D4.getOptionalNamedArg<String?>(named, 'suffix');
        final pathToTempDir = D4.getOptionalNamedArg<String?>(named, 'pathToTempDir');
        final create = D4.getNamedArgWithDefault<bool>(named, 'create', true);
        final keep = D4.getNamedArgWithDefault<bool>(named, 'keep', false);
        return $pkg.withTempFileAsync<dynamic>(action, suffix: suffix, pathToTempDir: pathToTempDir, create: create, keep: keep);
      },
      'withOpenLineFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'withOpenLineFile');
        final pathToFile = D4.getRequiredArg<String>(positional, 0, 'pathToFile', 'withOpenLineFile');
        final action = D4.getRequiredArg<dynamic Function($pkg.LineFile)>(positional, 1, 'action', 'withOpenLineFile');
        final fileMode = D4.getNamedArgWithDefault<FileMode>(named, 'fileMode', FileMode.writeOnlyAppend);
        return $pkg.withOpenLineFile<dynamic>(pathToFile, action, fileMode: fileMode);
      },
      'truepath': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'truepath');
        final part1 = D4.getRequiredArg<String>(positional, 0, 'part1', 'truepath');
        final part2 = positional.length > 1 ? positional[1] as String? : null;
        final part3 = positional.length > 2 ? positional[2] as String? : null;
        final part4 = positional.length > 3 ? positional[3] as String? : null;
        final part5 = positional.length > 4 ? positional[4] as String? : null;
        final part6 = positional.length > 5 ? positional[5] as String? : null;
        final part7 = positional.length > 6 ? positional[6] as String? : null;
        return $pkg.truepath(part1, part2, part3, part4, part5, part6, part7);
      },
      'privatePath': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'privatePath');
        final part1 = D4.getRequiredArg<String>(positional, 0, 'part1', 'privatePath');
        final part2 = positional.length > 1 ? positional[1] as String? : null;
        final part3 = positional.length > 2 ? positional[2] as String? : null;
        final part4 = positional.length > 3 ? positional[3] as String? : null;
        final part5 = positional.length > 4 ? positional[4] as String? : null;
        final part6 = positional.length > 5 ? positional[5] as String? : null;
        final part7 = positional.length > 6 ? positional[6] as String? : null;
        return $pkg.privatePath(part1, part2, part3, part4, part5, part6, part7);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'withFileProtectionAsync': 'package:dcli_core/src/functions/backup.dart',
      'withTempDirAsync': 'package:dcli_core/src/functions/create_dir.dart',
      'isOnPATH': 'package:dcli_core/src/functions/env.dart',
      'withEnvironmentAsync': 'package:dcli_core/src/functions/env.dart',
      'withEnvironment': 'package:dcli_core/src/functions/env.dart',
      'findAsync': 'package:dcli_core/src/functions/find_async.dart',
      'devNull': 'package:dcli_core/src/util/dev_null.dart',
      'withTempFileAsync': 'package:dcli_core/src/util/file.dart',
      'withOpenLineFile': 'package:dcli_core/src/util/line_file.dart',
      'truepath': 'package:dcli_core/src/util/truepath.dart',
      'privatePath': 'package:dcli_core/src/util/truepath.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'withFileProtectionAsync': 'Future<R> withFileProtectionAsync(List<String> protected, Future<R> Function() action, {String? workingDirectory})',
      'withTempDirAsync': 'Future<R> withTempDirAsync(Future<R> Function(String tempDir) action, {bool keep = false, String? pathToTempDir})',
      'isOnPATH': 'bool isOnPATH(String path)',
      'withEnvironmentAsync': 'Future<R> withEnvironmentAsync(Future<R> Function() callback, {required Map<String, String> environment})',
      'withEnvironment': 'R withEnvironment(R Function() callback, {required Map<String, String> environment})',
      'findAsync': 'Stream<FindItem> findAsync(String pattern, {bool caseSensitive = false, bool recursive = true, bool includeHidden = false, String workingDirectory = \'.\', List<FileSystemEntityType> types = const [Find.file]})',
      'devNull': 'void devNull(String? line)',
      'withTempFileAsync': 'Future<R> withTempFileAsync(Future<R> Function(String tempFile) action, {String? suffix, String? pathToTempDir, bool create = true, bool keep = false})',
      'withOpenLineFile': 'R withOpenLineFile(String pathToFile, R Function(LineFile) action, {FileMode fileMode = FileMode.writeOnlyAppend})',
      'truepath': 'String truepath(String part1, [String? part2, String? part3, String? part4, String? part5, String? part6, String? part7])',
      'privatePath': 'String privatePath(String part1, [String? part2, String? part3, String? part4, String? part5, String? part6, String? part7])',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:dcli_core/src/functions/backup.dart',
      'package:dcli_core/src/functions/cat.dart',
      'package:dcli_core/src/functions/copy.dart',
      'package:dcli_core/src/functions/copy_tree.dart',
      'package:dcli_core/src/functions/create_dir.dart',
      'package:dcli_core/src/functions/dcli_function.dart',
      'package:dcli_core/src/functions/delete.dart',
      'package:dcli_core/src/functions/delete_dir.dart',
      'package:dcli_core/src/functions/env.dart',
      'package:dcli_core/src/functions/find.dart',
      'package:dcli_core/src/functions/find_async.dart',
      'package:dcli_core/src/functions/head.dart',
      'package:dcli_core/src/functions/move.dart',
      'package:dcli_core/src/functions/move_dir.dart',
      'package:dcli_core/src/functions/move_tree.dart',
      'package:dcli_core/src/functions/pwd.dart',
      'package:dcli_core/src/functions/tail.dart',
      'package:dcli_core/src/functions/touch.dart',
      'package:dcli_core/src/functions/which.dart',
      'package:dcli_core/src/util/dcli_exception.dart',
      'package:dcli_core/src/util/dcli_platform.dart',
      'package:dcli_core/src/util/dev_null.dart',
      'package:dcli_core/src/util/file.dart',
      'package:dcli_core/src/util/limited_stream_controller.dart',
      'package:dcli_core/src/util/line_file.dart',
      'package:dcli_core/src/util/platform.dart',
      'package:dcli_core/src/util/run_exception.dart',
      'package:dcli_core/src/util/stack_list.dart',
      'package:dcli_core/src/util/truepath.dart',
    ];
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'DCliPlatformOS',
  ];

}

// =============================================================================
// RestoreFileException Bridge
// =============================================================================

BridgedClass _createRestoreFileExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.RestoreFileException,
    name: 'RestoreFileException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'RestoreFileException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'RestoreFileException');
        return $pkg.RestoreFileException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.RestoreFileException>(target, 'RestoreFileException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.RestoreFileException>(target, 'RestoreFileException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.RestoreFileException>(target, 'RestoreFileException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.RestoreFileException>(target, 'RestoreFileException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.RestoreFileException>(target, 'RestoreFileException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.RestoreFileException>(target, 'RestoreFileException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.RestoreFileException>(target, 'RestoreFileException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.RestoreFileException>(target, 'RestoreFileException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'RestoreFileException(String message)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// BackupFileException Bridge
// =============================================================================

BridgedClass _createBackupFileExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.BackupFileException,
    name: 'BackupFileException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BackupFileException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'BackupFileException');
        return $pkg.BackupFileException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.BackupFileException>(target, 'BackupFileException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.BackupFileException>(target, 'BackupFileException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.BackupFileException>(target, 'BackupFileException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.BackupFileException>(target, 'BackupFileException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.BackupFileException>(target, 'BackupFileException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.BackupFileException>(target, 'BackupFileException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.BackupFileException>(target, 'BackupFileException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.BackupFileException>(target, 'BackupFileException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'BackupFileException(String message)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// Cat Bridge
// =============================================================================

BridgedClass _createCatBridge() {
  return BridgedClass(
    nativeType: $pkg.Cat,
    name: 'Cat',
    constructors: {
    },
    methods: {
      'cat': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Cat>(target, 'Cat');
        D4.requireMinArgs(positional, 1, 'cat');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'cat');
        if (!named.containsKey('stdout')) {
          t.cat(path);
          return null;
        }
        if (named.containsKey('stdout')) {
          final stdout = D4.getRequiredNamedArg<void Function(String)>(named, 'stdout', 'cat');
          t.cat(path, stdout: stdout);
          return null;
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    methodSignatures: {
      'cat': 'void cat(String path, {LineAction stdout = print})',
    },
  );
}

// =============================================================================
// CatException Bridge
// =============================================================================

BridgedClass _createCatExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.CatException,
    name: 'CatException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CatException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'CatException');
        final stacktrace = D4.getOptionalArg<dynamic>(positional, 1, 'stacktrace');
        return $pkg.CatException(reason, stacktrace);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.CatException>(target, 'CatException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.CatException>(target, 'CatException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.CatException>(target, 'CatException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.CatException>(target, 'CatException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CatException>(target, 'CatException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CatException>(target, 'CatException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CatException>(target, 'CatException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CatException>(target, 'CatException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'CatException(String reason, [InvalidType stacktrace])',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// CopyException Bridge
// =============================================================================

BridgedClass _createCopyExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.CopyException,
    name: 'CopyException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CopyException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'CopyException');
        return $pkg.CopyException(reason);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.CopyException>(target, 'CopyException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.CopyException>(target, 'CopyException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.CopyException>(target, 'CopyException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.CopyException>(target, 'CopyException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CopyException>(target, 'CopyException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CopyException>(target, 'CopyException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CopyException>(target, 'CopyException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CopyException>(target, 'CopyException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'CopyException(String reason)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// CopyTreeException Bridge
// =============================================================================

BridgedClass _createCopyTreeExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.CopyTreeException,
    name: 'CopyTreeException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CopyTreeException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'CopyTreeException');
        return $pkg.CopyTreeException(reason);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.CopyTreeException>(target, 'CopyTreeException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.CopyTreeException>(target, 'CopyTreeException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.CopyTreeException>(target, 'CopyTreeException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.CopyTreeException>(target, 'CopyTreeException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CopyTreeException>(target, 'CopyTreeException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CopyTreeException>(target, 'CopyTreeException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CopyTreeException>(target, 'CopyTreeException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CopyTreeException>(target, 'CopyTreeException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'CopyTreeException(String reason)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// CreateDirException Bridge
// =============================================================================

BridgedClass _createCreateDirExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.CreateDirException,
    name: 'CreateDirException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CreateDirException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'CreateDirException');
        return $pkg.CreateDirException(reason);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.CreateDirException>(target, 'CreateDirException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.CreateDirException>(target, 'CreateDirException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.CreateDirException>(target, 'CreateDirException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.CreateDirException>(target, 'CreateDirException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CreateDirException>(target, 'CreateDirException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CreateDirException>(target, 'CreateDirException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CreateDirException>(target, 'CreateDirException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.CreateDirException>(target, 'CreateDirException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'CreateDirException(String reason)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// DCliFunction Bridge
// =============================================================================

BridgedClass _createDCliFunctionBridge() {
  return BridgedClass(
    nativeType: $pkg.DCliFunction,
    name: 'DCliFunction',
    constructors: {
    },
  );
}

// =============================================================================
// DCliFunctionException Bridge
// =============================================================================

BridgedClass _createDCliFunctionExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.DCliFunctionException,
    name: 'DCliFunctionException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DCliFunctionException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DCliFunctionException');
        final stackTrace = D4.getOptionalArg<dynamic>(positional, 1, 'stackTrace');
        return $pkg.DCliFunctionException(message, stackTrace);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.DCliFunctionException>(target, 'DCliFunctionException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.DCliFunctionException>(target, 'DCliFunctionException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.DCliFunctionException>(target, 'DCliFunctionException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.DCliFunctionException>(target, 'DCliFunctionException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DCliFunctionException>(target, 'DCliFunctionException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DCliFunctionException>(target, 'DCliFunctionException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DCliFunctionException>(target, 'DCliFunctionException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DCliFunctionException>(target, 'DCliFunctionException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'DCliFunctionException(String message, [InvalidType stackTrace])',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// DeleteException Bridge
// =============================================================================

BridgedClass _createDeleteExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.DeleteException,
    name: 'DeleteException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DeleteException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'DeleteException');
        return $pkg.DeleteException(reason);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.DeleteException>(target, 'DeleteException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.DeleteException>(target, 'DeleteException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.DeleteException>(target, 'DeleteException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.DeleteException>(target, 'DeleteException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DeleteException>(target, 'DeleteException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DeleteException>(target, 'DeleteException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DeleteException>(target, 'DeleteException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DeleteException>(target, 'DeleteException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'DeleteException(String reason)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// DeleteDirException Bridge
// =============================================================================

BridgedClass _createDeleteDirExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.DeleteDirException,
    name: 'DeleteDirException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DeleteDirException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'DeleteDirException');
        return $pkg.DeleteDirException(reason);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.DeleteDirException>(target, 'DeleteDirException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.DeleteDirException>(target, 'DeleteDirException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.DeleteDirException>(target, 'DeleteDirException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.DeleteDirException>(target, 'DeleteDirException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DeleteDirException>(target, 'DeleteDirException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DeleteDirException>(target, 'DeleteDirException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DeleteDirException>(target, 'DeleteDirException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DeleteDirException>(target, 'DeleteDirException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'DeleteDirException(String reason)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// Env Bridge
// =============================================================================

BridgedClass _createEnvBridge() {
  return BridgedClass(
    nativeType: $pkg.Env,
    name: 'Env',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Env();
      },
      'forScope': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Env');
        if (positional.isEmpty) {
          throw ArgumentError('Env: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, String>(positional[0], 'map');
        return $pkg.Env.forScope(map);
      },
    },
    getters: {
      'caseSensitive': (visitor, target) => D4.validateTarget<$pkg.Env>(target, 'Env').caseSensitive,
      'entries': (visitor, target) => D4.validateTarget<$pkg.Env>(target, 'Env').entries,
      'HOME': (visitor, target) => D4.validateTarget<$pkg.Env>(target, 'Env').HOME,
      'delimiterForPATH': (visitor, target) => D4.validateTarget<$pkg.Env>(target, 'Env').delimiterForPATH,
    },
    methods: {
      'addAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'addAll');
        if (positional.isEmpty) {
          throw ArgumentError('addAll: Missing required argument "other" at position 0');
        }
        final other = D4.coerceMap<String, String>(positional[0], 'other');
        t.addAll(other);
        return null;
      },
      'exists': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'exists');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'exists');
        return t.exists(key);
      },
      'appendToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'appendToPATH');
        final newPath = D4.getRequiredArg<String>(positional, 0, 'newPath', 'appendToPATH');
        t.appendToPATH(newPath);
        return null;
      },
      'prependToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'prependToPATH');
        final newPath = D4.getRequiredArg<String>(positional, 0, 'newPath', 'prependToPATH');
        t.prependToPATH(newPath);
        return null;
      },
      'removeFromPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'removeFromPATH');
        final oldPath = D4.getRequiredArg<String>(positional, 0, 'oldPath', 'removeFromPATH');
        t.removeFromPATH(oldPath);
        return null;
      },
      'addToPATHIfAbsent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'addToPATHIfAbsent');
        final newPath = D4.getRequiredArg<String>(positional, 0, 'newPath', 'addToPATHIfAbsent');
        t.addToPATHIfAbsent(newPath);
        return null;
      },
      'isOnPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'isOnPATH');
        final checkPath = D4.getRequiredArg<String>(positional, 0, 'checkPath', 'isOnPATH');
        return t.isOnPATH(checkPath);
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Env>(target, 'Env');
        return t.toJson();
      },
      'fromJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'fromJson');
        final json = D4.getRequiredArg<String>(positional, 0, 'json', 'fromJson');
        t.fromJson(json);
        return null;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Env>(target, 'Env');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Env>(target, 'Env');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<String?>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    staticGetters: {
      'scopeKey': (visitor) => $pkg.Env.scopeKey,
    },
    constructorSignatures: {
      '': 'factory Env()',
      'forScope': 'factory Env.forScope(Map<String, String> map)',
    },
    methodSignatures: {
      'addAll': 'void addAll(Map<String, String> other)',
      'exists': 'bool exists(String key)',
      'appendToPATH': 'void appendToPATH(String newPath)',
      'prependToPATH': 'void prependToPATH(String newPath)',
      'removeFromPATH': 'void removeFromPATH(String oldPath)',
      'addToPATHIfAbsent': 'void addToPATHIfAbsent(String newPath)',
      'isOnPATH': 'bool isOnPATH(String checkPath)',
      'toJson': 'String toJson()',
      'fromJson': 'void fromJson(String json)',
    },
    getterSignatures: {
      'caseSensitive': 'bool get caseSensitive',
      'entries': 'Iterable<MapEntry<String, String>> get entries',
      'HOME': 'String get HOME',
      'delimiterForPATH': 'String get delimiterForPATH',
    },
    staticGetterSignatures: {
      'scopeKey': 'ScopeKey<Env> get scopeKey',
    },
    staticSetterSignatures: {
      'scopeKey': 'set scopeKey(dynamic value)',
    },
  );
}

// =============================================================================
// Find Bridge
// =============================================================================

BridgedClass _createFindBridge() {
  return BridgedClass(
    nativeType: $pkg.Find,
    name: 'Find',
    constructors: {
    },
    staticGetters: {
      'file': (visitor) => $pkg.Find.file,
      'directory': (visitor) => $pkg.Find.directory,
      'link': (visitor) => $pkg.Find.link,
    },
    staticGetterSignatures: {
      'file': 'dynamic get file',
      'directory': 'dynamic get directory',
      'link': 'dynamic get link',
    },
  );
}

// =============================================================================
// PatternMatcher Bridge
// =============================================================================

BridgedClass _createPatternMatcherBridge() {
  return BridgedClass(
    nativeType: $pkg.PatternMatcher,
    name: 'PatternMatcher',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PatternMatcher');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'PatternMatcher');
        final workingDirectory = D4.getRequiredNamedArg<String>(named, 'workingDirectory', 'PatternMatcher');
        final caseSensitive = D4.getRequiredNamedArg<bool>(named, 'caseSensitive', 'PatternMatcher');
        return $pkg.PatternMatcher(pattern, workingDirectory: workingDirectory, caseSensitive: caseSensitive);
      },
    },
    getters: {
      'pattern': (visitor, target) => D4.validateTarget<$pkg.PatternMatcher>(target, 'PatternMatcher').pattern,
      'workingDirectory': (visitor, target) => D4.validateTarget<$pkg.PatternMatcher>(target, 'PatternMatcher').workingDirectory,
      'regEx': (visitor, target) => D4.validateTarget<$pkg.PatternMatcher>(target, 'PatternMatcher').regEx,
      'caseSensitive': (visitor, target) => D4.validateTarget<$pkg.PatternMatcher>(target, 'PatternMatcher').caseSensitive,
      'directoryParts': (visitor, target) => D4.validateTarget<$pkg.PatternMatcher>(target, 'PatternMatcher').directoryParts,
    },
    setters: {
      'pattern': (visitor, target, value) => 
        D4.validateTarget<$pkg.PatternMatcher>(target, 'PatternMatcher').pattern = value as String,
      'workingDirectory': (visitor, target, value) => 
        D4.validateTarget<$pkg.PatternMatcher>(target, 'PatternMatcher').workingDirectory = value as String,
      'regEx': (visitor, target, value) => 
        D4.validateTarget<$pkg.PatternMatcher>(target, 'PatternMatcher').regEx = value as RegExp,
      'caseSensitive': (visitor, target, value) => 
        D4.validateTarget<$pkg.PatternMatcher>(target, 'PatternMatcher').caseSensitive = value as bool,
    },
    methods: {
      'match': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PatternMatcher>(target, 'PatternMatcher');
        D4.requireMinArgs(positional, 1, 'match');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'match');
        return t.match(path);
      },
      'buildRegEx': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PatternMatcher>(target, 'PatternMatcher');
        return t.buildRegEx();
      },
    },
    constructorSignatures: {
      '': 'PatternMatcher(String pattern, {required String workingDirectory, required bool caseSensitive})',
    },
    methodSignatures: {
      'match': 'bool match(String path)',
      'buildRegEx': 'RegExp buildRegEx()',
    },
    getterSignatures: {
      'pattern': 'String get pattern',
      'workingDirectory': 'String get workingDirectory',
      'regEx': 'RegExp get regEx',
      'caseSensitive': 'bool get caseSensitive',
      'directoryParts': 'int get directoryParts',
    },
    setterSignatures: {
      'pattern': 'set pattern(dynamic value)',
      'workingDirectory': 'set workingDirectory(dynamic value)',
      'regEx': 'set regEx(dynamic value)',
      'caseSensitive': 'set caseSensitive(dynamic value)',
    },
  );
}

// =============================================================================
// FindItem Bridge
// =============================================================================

BridgedClass _createFindItemBridge() {
  return BridgedClass(
    nativeType: $pkg.FindItem,
    name: 'FindItem',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FindItem');
        final pathTo = D4.getRequiredArg<String>(positional, 0, 'pathTo', 'FindItem');
        final type = D4.getRequiredArg<FileSystemEntityType>(positional, 1, 'type', 'FindItem');
        return $pkg.FindItem(pathTo, type);
      },
    },
    getters: {
      'pathTo': (visitor, target) => D4.validateTarget<$pkg.FindItem>(target, 'FindItem').pathTo,
      'type': (visitor, target) => D4.validateTarget<$pkg.FindItem>(target, 'FindItem').type,
    },
    setters: {
      'pathTo': (visitor, target, value) => 
        D4.validateTarget<$pkg.FindItem>(target, 'FindItem').pathTo = value as String,
      'type': (visitor, target, value) => 
        D4.validateTarget<$pkg.FindItem>(target, 'FindItem').type = value as FileSystemEntityType,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FindItem>(target, 'FindItem');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'FindItem(String pathTo, FileSystemEntityType type)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'pathTo': 'String get pathTo',
      'type': 'FileSystemEntityType get type',
    },
    setterSignatures: {
      'pathTo': 'set pathTo(dynamic value)',
      'type': 'set type(dynamic value)',
    },
  );
}

// =============================================================================
// FindException Bridge
// =============================================================================

BridgedClass _createFindExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.FindException,
    name: 'FindException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FindException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'FindException');
        return $pkg.FindException(reason);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.FindException>(target, 'FindException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.FindException>(target, 'FindException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.FindException>(target, 'FindException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.FindException>(target, 'FindException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FindException>(target, 'FindException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FindException>(target, 'FindException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FindException>(target, 'FindException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FindException>(target, 'FindException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'FindException(String reason)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// FindConfig Bridge
// =============================================================================

BridgedClass _createFindConfigBridge() {
  return BridgedClass(
    nativeType: $pkg.FindConfig,
    name: 'FindConfig',
    constructors: {
      'build': (visitor, positional, named) {
        final pattern = D4.getRequiredNamedArg<String>(named, 'pattern', 'FindConfig');
        final workingDirectory = D4.getRequiredNamedArg<String>(named, 'workingDirectory', 'FindConfig');
        final includeHidden = D4.getRequiredNamedArg<bool>(named, 'includeHidden', 'FindConfig');
        final caseSensitive = D4.getRequiredNamedArg<bool>(named, 'caseSensitive', 'FindConfig');
        return $pkg.FindConfig.build(pattern: pattern, workingDirectory: workingDirectory, includeHidden: includeHidden, caseSensitive: caseSensitive);
      },
    },
    getters: {
      'workingDirectory': (visitor, target) => D4.validateTarget<$pkg.FindConfig>(target, 'FindConfig').workingDirectory,
      'pattern': (visitor, target) => D4.validateTarget<$pkg.FindConfig>(target, 'FindConfig').pattern,
      'includeHidden': (visitor, target) => D4.validateTarget<$pkg.FindConfig>(target, 'FindConfig').includeHidden,
      'caseSensitive': (visitor, target) => D4.validateTarget<$pkg.FindConfig>(target, 'FindConfig').caseSensitive,
      'matcher': (visitor, target) => D4.validateTarget<$pkg.FindConfig>(target, 'FindConfig').matcher,
    },
    setters: {
      'workingDirectory': (visitor, target, value) => 
        D4.validateTarget<$pkg.FindConfig>(target, 'FindConfig').workingDirectory = value as String,
      'pattern': (visitor, target, value) => 
        D4.validateTarget<$pkg.FindConfig>(target, 'FindConfig').pattern = value as String,
      'includeHidden': (visitor, target, value) => 
        D4.validateTarget<$pkg.FindConfig>(target, 'FindConfig').includeHidden = value as bool,
      'caseSensitive': (visitor, target, value) => 
        D4.validateTarget<$pkg.FindConfig>(target, 'FindConfig').caseSensitive = value as bool,
      'matcher': (visitor, target, value) => 
        D4.validateTarget<$pkg.FindConfig>(target, 'FindConfig').matcher = value as $pkg.PatternMatcher,
    },
    constructorSignatures: {
      'build': 'factory FindConfig.build({required String pattern, required String workingDirectory, required bool includeHidden, required bool caseSensitive})',
    },
    getterSignatures: {
      'workingDirectory': 'String get workingDirectory',
      'pattern': 'String get pattern',
      'includeHidden': 'bool get includeHidden',
      'caseSensitive': 'bool get caseSensitive',
      'matcher': 'PatternMatcher get matcher',
    },
    setterSignatures: {
      'workingDirectory': 'set workingDirectory(dynamic value)',
      'pattern': 'set pattern(dynamic value)',
      'includeHidden': 'set includeHidden(dynamic value)',
      'caseSensitive': 'set caseSensitive(dynamic value)',
      'matcher': 'set matcher(dynamic value)',
    },
  );
}

// =============================================================================
// FindAsync Bridge
// =============================================================================

BridgedClass _createFindAsyncBridge() {
  return BridgedClass(
    nativeType: $pkg.FindAsync,
    name: 'FindAsync',
    constructors: {
    },
    staticGetters: {
      'file': (visitor) => $pkg.FindAsync.file,
      'directory': (visitor) => $pkg.FindAsync.directory,
      'link': (visitor) => $pkg.FindAsync.link,
    },
    staticGetterSignatures: {
      'file': 'dynamic get file',
      'directory': 'dynamic get directory',
      'link': 'dynamic get link',
    },
  );
}

// =============================================================================
// HeadException Bridge
// =============================================================================

BridgedClass _createHeadExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.HeadException,
    name: 'HeadException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'HeadException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'HeadException');
        return $pkg.HeadException(reason);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.HeadException>(target, 'HeadException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.HeadException>(target, 'HeadException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.HeadException>(target, 'HeadException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.HeadException>(target, 'HeadException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.HeadException>(target, 'HeadException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.HeadException>(target, 'HeadException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.HeadException>(target, 'HeadException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.HeadException>(target, 'HeadException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'HeadException(String reason)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// MoveException Bridge
// =============================================================================

BridgedClass _createMoveExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.MoveException,
    name: 'MoveException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MoveException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'MoveException');
        return $pkg.MoveException(reason);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.MoveException>(target, 'MoveException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.MoveException>(target, 'MoveException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.MoveException>(target, 'MoveException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.MoveException>(target, 'MoveException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MoveException>(target, 'MoveException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MoveException>(target, 'MoveException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MoveException>(target, 'MoveException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MoveException>(target, 'MoveException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'MoveException(String reason)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// MoveDirException Bridge
// =============================================================================

BridgedClass _createMoveDirExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.MoveDirException,
    name: 'MoveDirException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MoveDirException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'MoveDirException');
        return $pkg.MoveDirException(reason);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.MoveDirException>(target, 'MoveDirException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.MoveDirException>(target, 'MoveDirException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.MoveDirException>(target, 'MoveDirException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.MoveDirException>(target, 'MoveDirException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MoveDirException>(target, 'MoveDirException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MoveDirException>(target, 'MoveDirException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MoveDirException>(target, 'MoveDirException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MoveDirException>(target, 'MoveDirException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'MoveDirException(String reason)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// MoveTreeException Bridge
// =============================================================================

BridgedClass _createMoveTreeExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.MoveTreeException,
    name: 'MoveTreeException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MoveTreeException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'MoveTreeException');
        return $pkg.MoveTreeException(reason);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.MoveTreeException>(target, 'MoveTreeException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.MoveTreeException>(target, 'MoveTreeException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.MoveTreeException>(target, 'MoveTreeException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.MoveTreeException>(target, 'MoveTreeException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MoveTreeException>(target, 'MoveTreeException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MoveTreeException>(target, 'MoveTreeException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MoveTreeException>(target, 'MoveTreeException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.MoveTreeException>(target, 'MoveTreeException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'MoveTreeException(String reason)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// TailException Bridge
// =============================================================================

BridgedClass _createTailExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.TailException,
    name: 'TailException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TailException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'TailException');
        return $pkg.TailException(reason);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.TailException>(target, 'TailException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.TailException>(target, 'TailException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.TailException>(target, 'TailException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.TailException>(target, 'TailException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TailException>(target, 'TailException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TailException>(target, 'TailException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TailException>(target, 'TailException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TailException>(target, 'TailException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'TailException(String reason)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// TouchException Bridge
// =============================================================================

BridgedClass _createTouchExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.TouchException,
    name: 'TouchException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TouchException');
        final reason = D4.getRequiredArg<String>(positional, 0, 'reason', 'TouchException');
        return $pkg.TouchException(reason);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.TouchException>(target, 'TouchException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.TouchException>(target, 'TouchException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.TouchException>(target, 'TouchException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.TouchException>(target, 'TouchException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TouchException>(target, 'TouchException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TouchException>(target, 'TouchException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TouchException>(target, 'TouchException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TouchException>(target, 'TouchException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'TouchException(String reason)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// Which Bridge
// =============================================================================

BridgedClass _createWhichBridge() {
  return BridgedClass(
    nativeType: $pkg.Which,
    name: 'Which',
    constructors: {
    },
    getters: {
      'progress': (visitor, target) => D4.validateTarget<$pkg.Which>(target, 'Which').progress,
      'path': (visitor, target) => D4.validateTarget<$pkg.Which>(target, 'Which').path,
      'paths': (visitor, target) => D4.validateTarget<$pkg.Which>(target, 'Which').paths,
      'found': (visitor, target) => D4.validateTarget<$pkg.Which>(target, 'Which').found,
      'notfound': (visitor, target) => D4.validateTarget<$pkg.Which>(target, 'Which').notfound,
    },
    setters: {
      'progress': (visitor, target, value) => 
        D4.validateTarget<$pkg.Which>(target, 'Which').progress = value as Stream<String>,
    },
    getterSignatures: {
      'progress': 'Stream<String>? get progress',
      'path': 'String? get path',
      'paths': 'List<String> get paths',
      'found': 'bool get found',
      'notfound': 'bool get notfound',
    },
    setterSignatures: {
      'progress': 'set progress(dynamic value)',
    },
  );
}

// =============================================================================
// WhichSearch Bridge
// =============================================================================

BridgedClass _createWhichSearchBridge() {
  return BridgedClass(
    nativeType: $pkg.WhichSearch,
    name: 'WhichSearch',
    constructors: {
      'found': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'WhichSearch');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'WhichSearch');
        final exePath = D4.getRequiredArg<String?>(positional, 1, 'exePath', 'WhichSearch');
        return $pkg.WhichSearch.found(path, exePath);
      },
      'notfound': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'WhichSearch');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'WhichSearch');
        return $pkg.WhichSearch.notfound(path);
      },
    },
    getters: {
      'path': (visitor, target) => D4.validateTarget<$pkg.WhichSearch>(target, 'WhichSearch').path,
      'found': (visitor, target) => D4.validateTarget<$pkg.WhichSearch>(target, 'WhichSearch').found,
      'exePath': (visitor, target) => D4.validateTarget<$pkg.WhichSearch>(target, 'WhichSearch').exePath,
    },
    setters: {
      'path': (visitor, target, value) => 
        D4.validateTarget<$pkg.WhichSearch>(target, 'WhichSearch').path = value as String,
      'found': (visitor, target, value) => 
        D4.validateTarget<$pkg.WhichSearch>(target, 'WhichSearch').found = value as bool,
      'exePath': (visitor, target, value) => 
        D4.validateTarget<$pkg.WhichSearch>(target, 'WhichSearch').exePath = value as String?,
    },
    constructorSignatures: {
      'found': 'WhichSearch.found(String path, String? exePath)',
      'notfound': 'WhichSearch.notfound(String path)',
    },
    getterSignatures: {
      'path': 'String get path',
      'found': 'bool get found',
      'exePath': 'String? get exePath',
    },
    setterSignatures: {
      'path': 'set path(dynamic value)',
      'found': 'set found(dynamic value)',
      'exePath': 'set exePath(dynamic value)',
    },
  );
}

// =============================================================================
// DCliException Bridge
// =============================================================================

BridgedClass _createDCliExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.DCliException,
    name: 'DCliException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DCliException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DCliException');
        final stackTrace = D4.getOptionalArg<dynamic>(positional, 1, 'stackTrace');
        return $pkg.DCliException(message, stackTrace);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DCliException');
        final jsonStr = D4.getRequiredArg<String>(positional, 0, 'jsonStr', 'DCliException');
        return $pkg.DCliException.fromJson(jsonStr);
      },
      'from': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DCliException');
        final cause = D4.getRequiredArg<Object?>(positional, 0, 'cause', 'DCliException');
        final stackTrace = D4.getRequiredArg<dynamic>(positional, 1, 'stackTrace', 'DCliException');
        return $pkg.DCliException.from(cause, stackTrace);
      },
      'fromException': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DCliException');
        final cause = D4.getRequiredArg<Object?>(positional, 0, 'cause', 'DCliException');
        return $pkg.DCliException.fromException(cause);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.DCliException>(target, 'DCliException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.DCliException>(target, 'DCliException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.DCliException>(target, 'DCliException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.DCliException>(target, 'DCliException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DCliException>(target, 'DCliException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DCliException>(target, 'DCliException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DCliException>(target, 'DCliException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DCliException>(target, 'DCliException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'DCliException(String message, [Trace? stackTrace])',
      'fromJson': 'factory DCliException.fromJson(String jsonStr)',
      'from': 'DCliException.from(Object? cause, InvalidType stackTrace)',
      'fromException': 'DCliException.fromException(Object? cause)',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'Trace get stackTrace',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
    },
  );
}

// =============================================================================
// DCliPlatform Bridge
// =============================================================================

BridgedClass _createDCliPlatformBridge() {
  return BridgedClass(
    nativeType: $pkg.DCliPlatform,
    name: 'DCliPlatform',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.DCliPlatform();
      },
      'forScope': (visitor, positional, named) {
        final overriddenPlatform = D4.getOptionalNamedArg<$pkg.DCliPlatformOS?>(named, 'overriddenPlatform');
        return $pkg.DCliPlatform.forScope(overriddenPlatform: overriddenPlatform);
      },
    },
    getters: {
      'overriddenPlatform': (visitor, target) => D4.validateTarget<$pkg.DCliPlatform>(target, 'DCliPlatform').overriddenPlatform,
      'isMacOS': (visitor, target) => D4.validateTarget<$pkg.DCliPlatform>(target, 'DCliPlatform').isMacOS,
      'isLinux': (visitor, target) => D4.validateTarget<$pkg.DCliPlatform>(target, 'DCliPlatform').isLinux,
      'isWindows': (visitor, target) => D4.validateTarget<$pkg.DCliPlatform>(target, 'DCliPlatform').isWindows,
    },
    setters: {
      'overriddenPlatform': (visitor, target, value) => 
        D4.validateTarget<$pkg.DCliPlatform>(target, 'DCliPlatform').overriddenPlatform = value as $pkg.DCliPlatformOS?,
    },
    staticGetters: {
      'scopeKey': (visitor) => $pkg.DCliPlatform.scopeKey,
    },
    constructorSignatures: {
      '': 'factory DCliPlatform()',
      'forScope': 'factory DCliPlatform.forScope({DCliPlatformOS? overriddenPlatform})',
    },
    getterSignatures: {
      'overriddenPlatform': 'DCliPlatformOS? get overriddenPlatform',
      'isMacOS': 'bool get isMacOS',
      'isLinux': 'bool get isLinux',
      'isWindows': 'bool get isWindows',
    },
    setterSignatures: {
      'overriddenPlatform': 'set overriddenPlatform(dynamic value)',
    },
    staticGetterSignatures: {
      'scopeKey': 'ScopeKey<DCliPlatform> get scopeKey',
    },
    staticSetterSignatures: {
      'scopeKey': 'set scopeKey(dynamic value)',
    },
  );
}

// =============================================================================
// LimitedStreamController Bridge
// =============================================================================

BridgedClass _createLimitedStreamControllerBridge() {
  return BridgedClass(
    nativeType: $pkg.LimitedStreamController,
    name: 'LimitedStreamController',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LimitedStreamController');
        final limit = D4.getRequiredArg<int>(positional, 0, '_limit', 'LimitedStreamController');
        final onListenRaw = named['onListen'];
        final onCancelRaw = named['onCancel'];
        final sync = D4.getNamedArgWithDefault<bool>(named, 'sync', false);
        return $pkg.LimitedStreamController(limit, onListen: onListenRaw == null ? null : () { (onListenRaw as InterpretedFunction).call(visitor, []); }, onCancel: onCancelRaw == null ? null : () { (onCancelRaw as InterpretedFunction).call(visitor, []); }, sync: sync);
      },
    },
    getters: {
      'length': (visitor, target) => D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').length,
      'isClosed': (visitor, target) => D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').isClosed,
      'hasListener': (visitor, target) => D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').hasListener,
      'isPaused': (visitor, target) => D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').isPaused,
      'stream': (visitor, target) => D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').stream,
      'done': (visitor, target) => D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').done,
      'sink': (visitor, target) => D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').sink,
      'onListen': (visitor, target) => D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').onListen,
      'onPause': (visitor, target) => D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').onPause,
      'onResume': (visitor, target) => D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').onResume,
      'onCancel': (visitor, target) => D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').onCancel,
    },
    setters: {
      'onListen': (visitor, target, value) => 
        D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').onListen = value as dynamic,
      'onPause': (visitor, target, value) => 
        D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').onPause = value as dynamic,
      'onResume': (visitor, target, value) => 
        D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').onResume = value as dynamic,
      'onCancel': (visitor, target, value) => 
        D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController').onCancel = value as dynamic,
    },
    methods: {
      'add': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController');
        D4.requireMinArgs(positional, 1, 'add');
        final event = D4.getRequiredArg<dynamic>(positional, 0, 'event', 'add');
        t.add(event);
        return null;
      },
      'asyncAdd': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController');
        D4.requireMinArgs(positional, 1, 'asyncAdd');
        final event = D4.getRequiredArg<dynamic>(positional, 0, 'event', 'asyncAdd');
        return t.asyncAdd(event);
      },
      'addError': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController');
        D4.requireMinArgs(positional, 1, 'addError');
        final error = D4.getRequiredArg<Object>(positional, 0, 'error', 'addError');
        final stackTrace = D4.getOptionalArg<StackTrace?>(positional, 1, 'stackTrace');
        t.addError(error, stackTrace);
        return null;
      },
      'addStream': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController');
        D4.requireMinArgs(positional, 1, 'addStream');
        final source = D4.getRequiredArg<Stream<dynamic>>(positional, 0, 'source', 'addStream');
        final cancelOnError = D4.getNamedArgWithDefault<bool?>(named, 'cancelOnError', true);
        return t.addStream(source, cancelOnError: cancelOnError);
      },
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LimitedStreamController>(target, 'LimitedStreamController');
        return t.close();
      },
    },
    constructorSignatures: {
      '': 'LimitedStreamController(int _limit, {void Function()? onListen, void Function()? onCancel, bool sync = false})',
    },
    methodSignatures: {
      'add': 'void add(T event)',
      'asyncAdd': 'Future<void> asyncAdd(T event)',
      'addError': 'void addError(Object error, [StackTrace? stackTrace])',
      'addStream': 'Future<bool> addStream(Stream<T> source, {bool? cancelOnError = true})',
      'close': 'Future<dynamic> close()',
    },
    getterSignatures: {
      'length': 'int get length',
      'isClosed': 'bool get isClosed',
      'hasListener': 'bool get hasListener',
      'isPaused': 'bool get isPaused',
      'stream': 'Stream<T> get stream',
      'done': 'Future<dynamic> get done',
      'sink': 'StreamSink<T> get sink',
      'onListen': 'ControllerCallback? get onListen',
      'onPause': 'ControllerCallback? get onPause',
      'onResume': 'ControllerCallback? get onResume',
      'onCancel': 'ControllerCancelCallback? get onCancel',
    },
    setterSignatures: {
      'onListen': 'set onListen(void Function()? value)',
      'onPause': 'set onPause(void Function()? value)',
      'onResume': 'set onResume(void Function()? value)',
      'onCancel': 'set onCancel(void Function()? value)',
    },
  );
}

// =============================================================================
// LineFile Bridge
// =============================================================================

BridgedClass _createLineFileBridge() {
  return BridgedClass(
    nativeType: $pkg.LineFile,
    name: 'LineFile',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LineFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'LineFile');
        final fileMode = D4.getNamedArgWithDefault<FileMode>(named, 'fileMode', FileMode.writeOnlyAppend);
        return $pkg.LineFile(path, fileMode: fileMode);
      },
    },
    getters: {
      'length': (visitor, target) => D4.validateTarget<$pkg.LineFile>(target, 'LineFile').length,
    },
    methods: {
      'flush': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LineFile>(target, 'LineFile');
        t.flush();
        return null;
      },
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LineFile>(target, 'LineFile');
        t.close();
        return null;
      },
      'readAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LineFile>(target, 'LineFile');
        D4.requireMinArgs(positional, 1, 'readAll');
        if (positional.isEmpty) {
          throw ArgumentError('readAll: Missing required argument "handleLine" at position 0');
        }
        final handleLineRaw = positional[0];
        t.readAll((String p0) { return (handleLineRaw as InterpretedFunction).call(visitor, [p0]) as bool; });
        return null;
      },
      'write': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LineFile>(target, 'LineFile');
        D4.requireMinArgs(positional, 1, 'write');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'write');
        final newline = D4.getOptionalNamedArg<String?>(named, 'newline');
        t.write(line, newline: newline);
        return null;
      },
      'append': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LineFile>(target, 'LineFile');
        D4.requireMinArgs(positional, 1, 'append');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'append');
        final newline = D4.getOptionalNamedArg<String?>(named, 'newline');
        t.append(line, newline: newline);
        return null;
      },
      'read': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LineFile>(target, 'LineFile');
        final lineDelimiter = D4.getOptionalNamedArg<String?>(named, 'lineDelimiter');
        return t.read(lineDelimiter: lineDelimiter);
      },
      'truncate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LineFile>(target, 'LineFile');
        t.truncate();
        return null;
      },
      'open': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LineFile>(target, 'LineFile');
        t.open();
        return null;
      },
    },
    constructorSignatures: {
      '': 'LineFile(String path, {FileMode fileMode = FileMode.writeOnlyAppend})',
    },
    methodSignatures: {
      'flush': 'void flush()',
      'close': 'void close()',
      'readAll': 'void readAll(bool Function(String) handleLine)',
      'write': 'void write(String line, {String? newline})',
      'append': 'void append(String line, {String? newline})',
      'read': 'String? read({String? lineDelimiter})',
      'truncate': 'void truncate()',
      'open': 'void open()',
    },
    getterSignatures: {
      'length': 'int get length',
    },
  );
}

// =============================================================================
// RunException Bridge
// =============================================================================

BridgedClass _createRunExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg.RunException,
    name: 'RunException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'RunException');
        final cmdLine = D4.getRequiredArg<String>(positional, 0, 'cmdLine', 'RunException');
        final exitCode = D4.getRequiredArg<int?>(positional, 1, 'exitCode', 'RunException');
        final reason = D4.getRequiredArg<String>(positional, 2, 'reason', 'RunException');
        final stackTrace = D4.getOptionalNamedArg<dynamic>(named, 'stackTrace');
        return $pkg.RunException(cmdLine, exitCode, reason, stackTrace: stackTrace);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'RunException');
        if (positional.isEmpty) {
          throw ArgumentError('RunException: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg.RunException.fromJson(json);
      },
      'fromJsonString': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'RunException');
        final jsonString = D4.getRequiredArg<String>(positional, 0, 'jsonString', 'RunException');
        return $pkg.RunException.fromJsonString(jsonString);
      },
      'withArgs': (visitor, positional, named) {
        D4.requireMinArgs(positional, 4, 'RunException');
        final cmd = D4.getRequiredArg<String?>(positional, 0, 'cmd', 'RunException');
        if (positional.length <= 1) {
          throw ArgumentError('RunException: Missing required argument "args" at position 1');
        }
        final args = D4.coerceList<String?>(positional[1], 'args');
        final exitCode = D4.getRequiredArg<int?>(positional, 2, 'exitCode', 'RunException');
        final reason = D4.getRequiredArg<String>(positional, 3, 'reason', 'RunException');
        final stackTrace = D4.getOptionalNamedArg<dynamic>(named, 'stackTrace');
        return $pkg.RunException.withArgs(cmd, args, exitCode, reason, stackTrace: stackTrace);
      },
      'fromException': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'RunException');
        final exception = D4.getRequiredArg<Object>(positional, 0, 'exception', 'RunException');
        final cmd = D4.getRequiredArg<String?>(positional, 1, 'cmd', 'RunException');
        if (positional.length <= 2) {
          throw ArgumentError('RunException: Missing required argument "args" at position 2');
        }
        final args = D4.coerceList<String?>(positional[2], 'args');
        final stackTrace = D4.getOptionalNamedArg<dynamic>(named, 'stackTrace');
        return $pkg.RunException.fromException(exception, cmd, args, stackTrace: stackTrace);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.RunException>(target, 'RunException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.RunException>(target, 'RunException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.RunException>(target, 'RunException').stackTrace,
      'cmdLine': (visitor, target) => D4.validateTarget<$pkg.RunException>(target, 'RunException').cmdLine,
      'exitCode': (visitor, target) => D4.validateTarget<$pkg.RunException>(target, 'RunException').exitCode,
      'reason': (visitor, target) => D4.validateTarget<$pkg.RunException>(target, 'RunException').reason,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.RunException>(target, 'RunException').stackTrace = value as dynamic,
      'cmdLine': (visitor, target, value) => 
        D4.validateTarget<$pkg.RunException>(target, 'RunException').cmdLine = value as String,
      'exitCode': (visitor, target, value) => 
        D4.validateTarget<$pkg.RunException>(target, 'RunException').exitCode = value as int?,
      'reason': (visitor, target, value) => 
        D4.validateTarget<$pkg.RunException>(target, 'RunException').reason = value as String,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.RunException>(target, 'RunException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.RunException>(target, 'RunException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.RunException>(target, 'RunException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.RunException>(target, 'RunException');
        return t.toJsonString();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.RunException>(target, 'RunException');
        return t.toJsonMap();
      },
    },
    constructorSignatures: {
      '': 'RunException(String cmdLine, int? exitCode, String reason, {Trace? stackTrace})',
      'fromJson': 'RunException.fromJson(Map<String, dynamic> json)',
      'fromJsonString': 'factory RunException.fromJsonString(String jsonString)',
      'withArgs': 'RunException.withArgs(String? cmd, List<String?> args, int? exitCode, String reason, {Trace? stackTrace})',
      'fromException': 'RunException.fromException(Object exception, String? cmd, List<String?> args, {Trace? stackTrace})',
    },
    methodSignatures: {
      'toString': 'String toString()',
      'printStackTrace': 'void printStackTrace()',
      'toJson': 'Map<String, dynamic> toJson()',
      'toJsonString': 'String toJsonString()',
      'toJsonMap': 'Map<String, dynamic> toJsonMap()',
    },
    getterSignatures: {
      'message': 'String get message',
      'cause': 'Object? get cause',
      'stackTrace': 'InvalidType get stackTrace',
      'cmdLine': 'String get cmdLine',
      'exitCode': 'int? get exitCode',
      'reason': 'String get reason',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
      'cmdLine': 'set cmdLine(dynamic value)',
      'exitCode': 'set exitCode(dynamic value)',
      'reason': 'set reason(dynamic value)',
    },
  );
}

// =============================================================================
// StackList Bridge
// =============================================================================

BridgedClass _createStackListBridge() {
  return BridgedClass(
    nativeType: $pkg.StackList,
    name: 'StackList',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.StackList();
      },
      'fromList': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'StackList');
        if (positional.isEmpty) {
          throw ArgumentError('StackList: Missing required argument "initialStack" at position 0');
        }
        final initialStack = D4.coerceList<dynamic>(positional[0], 'initialStack');
        return $pkg.StackList.fromList(initialStack);
      },
    },
    getters: {
      'isEmpty': (visitor, target) => D4.validateTarget<$pkg.StackList>(target, 'StackList').isEmpty,
    },
    methods: {
      'push': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.StackList>(target, 'StackList');
        D4.requireMinArgs(positional, 1, 'push');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'push');
        t.push(item);
        return null;
      },
      'pop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.StackList>(target, 'StackList');
        return t.pop();
      },
      'peek': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.StackList>(target, 'StackList');
        return t.peek();
      },
      'asList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.StackList>(target, 'StackList');
        return t.asList();
      },
    },
    constructorSignatures: {
      '': 'StackList()',
      'fromList': 'StackList.fromList(List<T> initialStack)',
    },
    methodSignatures: {
      'push': 'void push(T item)',
      'pop': 'T pop()',
      'peek': 'T peek()',
      'asList': 'List<T> asList()',
    },
    getterSignatures: {
      'isEmpty': 'bool get isEmpty',
    },
  );
}

