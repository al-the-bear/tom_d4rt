// D4rt Bridge - Generated file, do not edit
// Sources: 71 files
// Generated: 2026-02-14T21:33:00.617059

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:crypto/src/digest.dart' as $crypto_1;
import 'package:dcli/src/functions/ask.dart' as $dcli_1;
import 'package:dcli/src/functions/backup.dart' as $dcli_2;
import 'package:dcli/src/functions/confirm.dart' as $dcli_3;
import 'package:dcli/src/functions/delete.dart' as $dcli_4;
import 'package:dcli/src/functions/echo.dart' as $dcli_5;
import 'package:dcli/src/functions/fetch.dart' as $dcli_6;
import 'package:dcli/src/functions/file_list.dart' as $dcli_7;
import 'package:dcli/src/functions/find.dart' as $dcli_8;
import 'package:dcli/src/functions/head.dart' as $dcli_9;
import 'package:dcli/src/functions/is.dart' as $dcli_10;
import 'package:dcli/src/functions/menu.dart' as $dcli_11;
import 'package:dcli/src/functions/read.dart' as $dcli_12;
import 'package:dcli/src/functions/replace.dart' as $dcli_13;
import 'package:dcli/src/functions/run.dart' as $dcli_14;
import 'package:dcli/src/functions/sleep.dart' as $dcli_15;
import 'package:dcli/src/functions/tail.dart' as $dcli_16;
import 'package:dcli/src/functions/which.dart' as $dcli_17;
import 'package:dcli/src/progress/progress.dart' as $dcli_18;
import 'package:dcli/src/resources/packed_resource.dart' as $dcli_19;
import 'package:dcli/src/resources/resources.dart' as $dcli_20;
import 'package:dcli/src/script/dart_project.dart' as $dcli_21;
import 'package:dcli/src/script/dart_script.dart' as $dcli_22;
import 'package:dcli/src/script/dart_sdk.dart' as $dcli_23;
import 'package:dcli/src/settings.dart' as $dcli_24;
import 'package:dcli/src/shell/shell.dart' as $dcli_25;
import 'package:dcli/src/shell/shell_detection.dart' as $dcli_26;
import 'package:dcli/src/shell/unknown_shell.dart' as $dcli_27;
import 'package:dcli/src/util/capture.dart' as $dcli_28;
import 'package:dcli/src/util/dcli_paths.dart' as $dcli_29;
import 'package:dcli/src/util/digest_helper.dart' as $dcli_30;
import 'package:dcli/src/util/editor.dart' as $dcli_31;
import 'package:dcli/src/util/exceptions.dart' as $dcli_32;
import 'package:dcli/src/util/file_sort.dart' as $dcli_33;
import 'package:dcli/src/util/file_sync.dart' as $dcli_34;
import 'package:dcli/src/util/file_util.dart' as $dcli_35;
import 'package:dcli/src/util/named_lock.dart' as $dcli_36;
import 'package:dcli/src/util/process_helper.dart' as $dcli_37;
import 'package:dcli/src/util/pub_cache.dart' as $dcli_38;
import 'package:dcli/src/util/remote.dart' as $dcli_39;
import 'package:dcli/src/util/runnable_process.dart' as $dcli_40;
import 'package:dcli/src/util/string_as_process.dart' as $dcli_41;
import 'package:dcli_core/src/functions/cat.dart' as $dcli_core_1;
import 'package:dcli_core/src/functions/copy.dart' as $dcli_core_2;
import 'package:dcli_core/src/functions/copy_tree.dart' as $dcli_core_3;
import 'package:dcli_core/src/functions/create_dir.dart' as $dcli_core_4;
import 'package:dcli_core/src/functions/dcli_function.dart' as $dcli_core_5;
import 'package:dcli_core/src/functions/delete_dir.dart' as $dcli_core_6;
import 'package:dcli_core/src/functions/env.dart' as $dcli_core_7;
import 'package:dcli_core/src/functions/find.dart' as $dcli_core_8;
import 'package:dcli_core/src/functions/is.dart' as $dcli_core_9;
import 'package:dcli_core/src/functions/move.dart' as $dcli_core_10;
import 'package:dcli_core/src/functions/move_dir.dart' as $dcli_core_11;
import 'package:dcli_core/src/functions/move_tree.dart' as $dcli_core_12;
import 'package:dcli_core/src/functions/pwd.dart' as $dcli_core_13;
import 'package:dcli_core/src/functions/touch.dart' as $dcli_core_14;
import 'package:dcli_core/src/functions/which.dart' as $dcli_core_15;
import 'package:dcli_core/src/settings.dart' as $dcli_core_16;
import 'package:dcli_core/src/util/dcli_exception.dart' as $dcli_core_17;
import 'package:dcli_core/src/util/dev_null.dart' as $dcli_core_18;
import 'package:dcli_core/src/util/file.dart' as $dcli_core_19;
import 'package:dcli_core/src/util/line_action.dart' as $dcli_core_20;
import 'package:dcli_core/src/util/platform.dart' as $dcli_core_21;
import 'package:dcli_core/src/util/run_exception.dart' as $dcli_core_22;
import 'package:dcli_core/src/util/stack_list.dart' as $dcli_core_23;
import 'package:dcli_core/src/util/truepath.dart' as $dcli_core_24;
import 'package:dcli_terminal/src/ansi.dart' as $dcli_terminal_1;
import 'package:dcli_terminal/src/ansi_color.dart' as $dcli_terminal_2;
import 'package:dcli_terminal/src/format.dart' as $dcli_terminal_3;
import 'package:dcli_terminal/src/terminal.dart' as $dcli_terminal_4;
import 'package:dcli/dcli.dart' as $aux_dcli;
import 'package:dcli/src/util/parser.dart' as $aux_dcli_5;

/// Bridge class for dcli module.
class DcliBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createDigestBridge(),
      _createCatExceptionBridge(),
      _createCopyExceptionBridge(),
      _createCreateDirExceptionBridge(),
      _createDCliFunctionBridge(),
      _createDCliFunctionExceptionBridge(),
      _createDeleteDirExceptionBridge(),
      _createEnvBridge(),
      _createFindItemBridge(),
      _createMoveExceptionBridge(),
      _createMoveDirExceptionBridge(),
      _createMoveTreeExceptionBridge(),
      _createDCliExceptionBridge(),
      _createRunExceptionBridge(),
      _createStackListBridge(),
      _createAnsiBridge(),
      _createAnsiColorBridge(),
      _createFormatBridge(),
      _createTerminalBridge(),
      _createAskBridge(),
      _createAskValidatorExceptionBridge(),
      _createAskValidatorBridge(),
      _createAskValidatorIPAddressBridge(),
      _createConfirmBridge(),
      _createFetchDataBridge(),
      _createFetchUrlBridge(),
      _createFetchProgressBridge(),
      _createFetchExceptionBridge(),
      _createReadExceptionBridge(),
      _createProgressBridge(),
      _createPackedResourceBridge(),
      _createResourcesBridge(),
      _createResourceExceptionBridge(),
      _createDartProjectBridge(),
      _createDartProjectExceptionBridge(),
      _createTemplateNotFoundExceptionBridge(),
      _createInvalidProjectTemplateExceptionBridge(),
      _createDartScriptBridge(),
      _createDartSdkBridge(),
      _createSettingsBridge(),
      _createShellBridge(),
      _createShellExceptionBridge(),
      _createShellDetectionBridge(),
      _createUnknownShellBridge(),
      _createDCliPathsBridge(),
      _createInvalidArgumentExceptionBridge(),
      _createInvalidTemplateExceptionBridge(),
      _createInstallExceptionBridge(),
      _createProcessSyncExceptionBridge(),
      _createFileSortBridge(),
      _createColumnBridge(),
      _createFileSyncBridge(),
      _createFileNotFoundExceptionBridge(),
      _createNotAFileExceptionBridge(),
      _createNamedLockBridge(),
      _createLockExceptionBridge(),
      _createProcessDetailsBridge(),
      _createPubCacheBridge(),
      _createRemoteBridge(),
      _createFindProgressBridge(),
      _createHeadProgressBridge(),
      _createTailProgressBridge(),
      _createWhichBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'Digest': 'package:crypto/src/digest.dart',
      'CatException': 'package:dcli_core/src/functions/cat.dart',
      'CopyException': 'package:dcli_core/src/functions/copy.dart',
      'CreateDirException': 'package:dcli_core/src/functions/create_dir.dart',
      'DCliFunction': 'package:dcli_core/src/functions/dcli_function.dart',
      'DCliFunctionException': 'package:dcli_core/src/functions/dcli_function.dart',
      'DeleteDirException': 'package:dcli_core/src/functions/delete_dir.dart',
      'Env': 'package:dcli_core/src/functions/env.dart',
      'FindItem': 'package:dcli_core/src/functions/find.dart',
      'MoveException': 'package:dcli_core/src/functions/move.dart',
      'MoveDirException': 'package:dcli_core/src/functions/move_dir.dart',
      'MoveTreeException': 'package:dcli_core/src/functions/move_tree.dart',
      'DCliException': 'package:dcli_core/src/util/dcli_exception.dart',
      'RunException': 'package:dcli_core/src/util/run_exception.dart',
      'StackList': 'package:dcli_core/src/util/stack_list.dart',
      'Ansi': 'package:dcli_terminal/src/ansi.dart',
      'AnsiColor': 'package:dcli_terminal/src/ansi_color.dart',
      'Format': 'package:dcli_terminal/src/format.dart',
      'Terminal': 'package:dcli_terminal/src/terminal.dart',
      'Ask': 'package:dcli/src/functions/ask.dart',
      'AskValidatorException': 'package:dcli/src/functions/ask.dart',
      'AskValidator': 'package:dcli/src/functions/ask.dart',
      'AskValidatorIPAddress': 'package:dcli/src/functions/ask.dart',
      'Confirm': 'package:dcli/src/functions/confirm.dart',
      'FetchData': 'package:dcli/src/functions/fetch.dart',
      'FetchUrl': 'package:dcli/src/functions/fetch.dart',
      'FetchProgress': 'package:dcli/src/functions/fetch.dart',
      'FetchException': 'package:dcli/src/functions/fetch.dart',
      'ReadException': 'package:dcli/src/functions/read.dart',
      'Progress': 'package:dcli/src/progress/progress.dart',
      'PackedResource': 'package:dcli/src/resources/packed_resource.dart',
      'Resources': 'package:dcli/src/resources/resources.dart',
      'ResourceException': 'package:dcli/src/resources/resources.dart',
      'DartProject': 'package:dcli/src/script/dart_project.dart',
      'DartProjectException': 'package:dcli/src/script/dart_project.dart',
      'TemplateNotFoundException': 'package:dcli/src/script/dart_project.dart',
      'InvalidProjectTemplateException': 'package:dcli/src/script/dart_project.dart',
      'DartScript': 'package:dcli/src/script/dart_script.dart',
      'DartSdk': 'package:dcli/src/script/dart_sdk.dart',
      'Settings': 'package:dcli/src/settings.dart',
      'Shell': 'package:dcli/src/shell/shell.dart',
      'ShellException': 'package:dcli/src/shell/shell.dart',
      'ShellDetection': 'package:dcli/src/shell/shell_detection.dart',
      'UnknownShell': 'package:dcli/src/shell/unknown_shell.dart',
      'DCliPaths': 'package:dcli/src/util/dcli_paths.dart',
      'InvalidArgumentException': 'package:dcli/src/util/exceptions.dart',
      'InvalidTemplateException': 'package:dcli/src/util/exceptions.dart',
      'InstallException': 'package:dcli/src/util/exceptions.dart',
      'ProcessSyncException': 'package:dcli/src/util/exceptions.dart',
      'FileSort': 'package:dcli/src/util/file_sort.dart',
      'Column': 'package:dcli/src/util/file_sort.dart',
      'FileSync': 'package:dcli/src/util/file_sync.dart',
      'FileNotFoundException': 'package:dcli/src/util/file_util.dart',
      'NotAFileException': 'package:dcli/src/util/file_util.dart',
      'NamedLock': 'package:dcli/src/util/named_lock.dart',
      'LockException': 'package:dcli/src/util/named_lock.dart',
      'ProcessDetails': 'package:dcli/src/util/process_helper.dart',
      'PubCache': 'package:dcli/src/util/pub_cache.dart',
      'Remote': 'package:dcli/src/util/remote.dart',
      'FindProgress': 'package:dcli/src/functions/find.dart',
      'HeadProgress': 'package:dcli/src/functions/head.dart',
      'TailProgress': 'package:dcli/src/functions/tail.dart',
      'Which': 'package:dcli_core/src/functions/which.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$dcli_terminal_3.TableAlignment>(
        name: 'TableAlignment',
        values: $dcli_terminal_3.TableAlignment.values,
      ),
      BridgedEnumDefinition<$dcli_terminal_4.TerminalClearMode>(
        name: 'TerminalClearMode',
        values: $dcli_terminal_4.TerminalClearMode.values,
      ),
      BridgedEnumDefinition<$dcli_6.FetchMethod>(
        name: 'FetchMethod',
        values: $dcli_6.FetchMethod.values,
      ),
      BridgedEnumDefinition<$dcli_6.FetchStatus>(
        name: 'FetchStatus',
        values: $dcli_6.FetchStatus.values,
      ),
      BridgedEnumDefinition<$dcli_15.Interval>(
        name: 'Interval',
        values: $dcli_15.Interval.values,
      ),
      BridgedEnumDefinition<$dcli_33.SortDirection>(
        name: 'SortDirection',
        values: $dcli_33.SortDirection.values,
      ),
    ];
  }

  /// Returns a map of enum names to their canonical source URIs.
  ///
  /// Used for deduplication when the same enum is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> enumSourceUris() {
    return {
      'TableAlignment': 'package:dcli_terminal/src/format.dart',
      'TerminalClearMode': 'package:dcli_terminal/src/terminal.dart',
      'FetchMethod': 'package:dcli/src/functions/fetch.dart',
      'FetchStatus': 'package:dcli/src/functions/fetch.dart',
      'Interval': 'package:dcli/src/functions/sleep.dart',
      'SortDirection': 'package:dcli/src/util/file_sort.dart',
    };
  }

  /// Returns all bridged extension definitions.
  static List<BridgedExtensionDefinition> bridgedExtensions() {
    return [
      BridgedExtensionDefinition(
        name: 'PlatformEx',
        onTypeName: 'Platform',
        getters: {
          'eol': (visitor, target) => (target as Platform).eol,
        },
      ),
      BridgedExtensionDefinition(
        name: 'PlatformEx',
        onTypeName: 'Platform',
        getters: {
          'eol': (visitor, target) => (target as Platform).eol,
        },
      ),
      BridgedExtensionDefinition(
        name: 'DigestHelper',
        onTypeName: 'Digest',
        methods: {
          'hexEncode': (visitor, target, positional, named, typeArgs) {
            final t = target as $crypto_1.Digest;
            return Function.apply(t.hexEncode, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
      BridgedExtensionDefinition(
        name: 'StringAsProcess',
        onTypeName: 'String',
        getters: {
          'run': (visitor, target) => (target as String).run,
          'firstLine': (visitor, target) => (target as String).firstLine,
          'lastLine': (visitor, target) => (target as String).lastLine,
        },
        methods: {
          'start': (visitor, target, positional, named, typeArgs) {
            final t = target as String;
            return Function.apply(t.start, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
          'forEach': (visitor, target, positional, named, typeArgs) {
            final t = target as String;
            D4.requireMinArgs(positional, 1, 'forEach');
            if (positional.length <= 0) {
              throw ArgumentError('forEach: Missing required argument "stdout" at position 0');
            }
            final stdoutRaw = positional[0];
            final stdout = (String p0) { D4.callInterpreterCallback(visitor, stdoutRaw, [p0]); };
            final wrappedNamed = <Symbol, dynamic>{};
            final stderrRaw = named['stderr'];
            if (stderrRaw != null) {
              wrappedNamed[#stderr] = (String p0) { D4.callInterpreterCallback(visitor, stderrRaw, [p0]); };
            }
            if (named.containsKey('runInShell')) {
              wrappedNamed[#runInShell] = named['runInShell'];
            }
            if (named.containsKey('extensionSearch')) {
              wrappedNamed[#extensionSearch] = named['extensionSearch'];
            }
            if (named.containsKey('encoding')) {
              wrappedNamed[#encoding] = named['encoding'];
            }
            Function.apply(t.forEach, [stdout], wrappedNamed);
            return null;
          },
          'toList': (visitor, target, positional, named, typeArgs) {
            final t = target as String;
            return Function.apply(t.toList, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
          'toParagraph': (visitor, target, positional, named, typeArgs) {
            final t = target as String;
            return Function.apply(t.toParagraph, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
          'parser': (visitor, target, positional, named, typeArgs) {
            final t = target as String;
            return Function.apply(t.parser, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
          'write': (visitor, target, positional, named, typeArgs) {
            final t = target as String;
            return Function.apply(t.write, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
          'truncate': (visitor, target, positional, named, typeArgs) {
            final t = target as String;
            return Function.apply(t.truncate, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
          'append': (visitor, target, positional, named, typeArgs) {
            final t = target as String;
            return Function.apply(t.append, positional, named.map((k, v) => MapEntry(Symbol(k), v)));
          },
        },
      ),
    ];
  }

  /// Returns a map of extension identifiers to their canonical source URIs.
  static Map<String, String> extensionSourceUris() {
    return {
      'PlatformEx': 'package:dcli_core/src/util/platform.dart',
      'PlatformEx': 'package:dcli_core/src/util/platform.dart',
      'DigestHelper': 'package:dcli/src/util/digest_helper.dart',
      'StringAsProcess': 'package:dcli/src/util/string_as_process.dart',
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

    // Register bridged extensions with source URIs for deduplication
    final extensions = bridgedExtensions();
    final extSources = extensionSourceUris();
    for (final extDef in extensions) {
      final extKey = extDef.name ?? '<unnamed>@${extDef.onTypeName}';
      interpreter.registerBridgedExtension(extDef, importPath, sourceUri: extSources[extKey]);
    }
  }

  /// Registers all global variables with the interpreter.
  ///
  /// [importPath] is the package import path for library-scoped registration.
  /// Collects all registration errors and throws a single exception
  /// with all error details if any registrations fail.
  static void registerGlobalVariables(D4rt interpreter, String importPath) {
    final errors = <String>[];

    interpreter.registerGlobalGetter('env', () => $dcli_core_7.env, importPath, sourceUri: 'package:dcli_core/src/functions/env.dart');
    interpreter.registerGlobalGetter('PATH', () => $dcli_core_7.PATH, importPath, sourceUri: 'package:dcli_core/src/functions/env.dart');
    interpreter.registerGlobalGetter('HOME', () => $dcli_core_7.HOME, importPath, sourceUri: 'package:dcli_core/src/functions/env.dart');
    interpreter.registerGlobalGetter('envs', () => $dcli_core_7.envs, importPath, sourceUri: 'package:dcli_core/src/functions/env.dart');
    interpreter.registerGlobalGetter('pwd', () => $dcli_core_13.pwd, importPath, sourceUri: 'package:dcli_core/src/functions/pwd.dart');
    interpreter.registerGlobalGetter('eol', () => $dcli_core_21.eol, importPath, sourceUri: 'package:dcli_core/src/util/platform.dart');
    interpreter.registerGlobalGetter('rootPath', () => $dcli_core_24.rootPath, importPath, sourceUri: 'package:dcli_core/src/util/truepath.dart');
    interpreter.registerGlobalGetter('fileList', () => $dcli_7.fileList, importPath, sourceUri: 'package:dcli/src/functions/file_list.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (dcli):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'cat': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cat');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'cat');
        if (!named.containsKey('stdout')) {
          $dcli_core_1.cat(path);
          return null;
        }
        if (named.containsKey('stdout')) {
          final stdoutRaw = named['stdout'];
          final stdout = (String p0) { D4.callInterpreterCallback(visitor, stdoutRaw, [p0]); };
          $dcli_core_1.cat(path, stdout: stdout);
          return null;
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'copy': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'copy');
        final from = D4.getRequiredArg<String>(positional, 0, 'from', 'copy');
        final to = D4.getRequiredArg<String>(positional, 1, 'to', 'copy');
        final overwrite = D4.getNamedArgWithDefault<bool>(named, 'overwrite', false);
        return $dcli_core_2.copy(from, to, overwrite: overwrite);
      },
      'copyTree': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'copyTree');
        final from = D4.getRequiredArg<String>(positional, 0, 'from', 'copyTree');
        final to = D4.getRequiredArg<String>(positional, 1, 'to', 'copyTree');
        final overwrite = D4.getNamedArgWithDefault<bool>(named, 'overwrite', false);
        final includeHidden = D4.getNamedArgWithDefault<bool>(named, 'includeHidden', false);
        final includeEmpty = D4.getNamedArgWithDefault<bool>(named, 'includeEmpty', true);
        final includeLinks = D4.getNamedArgWithDefault<bool>(named, 'includeLinks', true);
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', true);
        if (!named.containsKey('filter')) {
          $dcli_core_3.copyTree(from, to, overwrite: overwrite, includeHidden: includeHidden, includeEmpty: includeEmpty, includeLinks: includeLinks, recursive: recursive);
          return null;
        }
        if (named.containsKey('filter')) {
          final filterRaw = named['filter'];
          final filter = (String p0) { return D4.callInterpreterCallback(visitor, filterRaw, [p0]) as bool; };
          $dcli_core_3.copyTree(from, to, overwrite: overwrite, includeHidden: includeHidden, includeEmpty: includeEmpty, includeLinks: includeLinks, recursive: recursive, filter: filter);
          return null;
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'createDir': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'createDir');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'createDir');
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', false);
        return $dcli_core_4.createDir(path, recursive: recursive);
      },
      'withTempDirAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'withTempDirAsync');
        if (positional.isEmpty) {
          throw ArgumentError('withTempDirAsync: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        final action = (String p0) { return D4.callInterpreterCallback(visitor, actionRaw, [p0]) as Future<dynamic>; };
        final keep = D4.getNamedArgWithDefault<bool>(named, 'keep', false);
        final pathToTempDir = D4.getOptionalNamedArg<String?>(named, 'pathToTempDir');
        return $dcli_core_4.withTempDirAsync<dynamic>(action, keep: keep, pathToTempDir: pathToTempDir);
      },
      'createTempDir': (visitor, positional, named, typeArgs) {
        return $dcli_core_4.createTempDir();
      },
      'deleteDir': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'deleteDir');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'deleteDir');
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', true);
        return $dcli_core_6.deleteDir(path, recursive: recursive);
      },
      'isOnPATH': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isOnPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isOnPATH');
        return $dcli_core_7.isOnPATH(path);
      },
      'withEnvironmentAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'withEnvironmentAsync');
        if (positional.isEmpty) {
          throw ArgumentError('withEnvironmentAsync: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        final callback = () { return D4.callInterpreterCallback(visitor, callbackRaw, []) as Future<dynamic>; };
        final environment = D4.getRequiredNamedArg<Map<String, String>>(named, 'environment', 'withEnvironmentAsync');
        return $dcli_core_7.withEnvironmentAsync<dynamic>(callback, environment: environment);
      },
      'isFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isFile');
        return $dcli_core_9.isFile(path);
      },
      'isDirectory': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isDirectory');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isDirectory');
        return $dcli_core_9.isDirectory(path);
      },
      'isLink': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isLink');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isLink');
        return $dcli_core_9.isLink(path);
      },
      'exists': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'exists');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'exists');
        final followLinks = D4.getNamedArgWithDefault<bool>(named, 'followLinks', true);
        return $dcli_core_9.exists(path, followLinks: followLinks);
      },
      'isEmpty': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isEmpty');
        final pathToDirectory = D4.getRequiredArg<String>(positional, 0, 'pathToDirectory', 'isEmpty');
        return $dcli_core_9.isEmpty(pathToDirectory);
      },
      'move': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'move');
        final from = D4.getRequiredArg<String>(positional, 0, 'from', 'move');
        final to = D4.getRequiredArg<String>(positional, 1, 'to', 'move');
        final overwrite = D4.getNamedArgWithDefault<bool>(named, 'overwrite', false);
        return $dcli_core_10.move(from, to, overwrite: overwrite);
      },
      'moveDir': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'moveDir');
        final from = D4.getRequiredArg<String>(positional, 0, 'from', 'moveDir');
        final to = D4.getRequiredArg<String>(positional, 1, 'to', 'moveDir');
        return $dcli_core_11.moveDir(from, to);
      },
      'moveTree': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'moveTree');
        final from = D4.getRequiredArg<String>(positional, 0, 'from', 'moveTree');
        final to = D4.getRequiredArg<String>(positional, 1, 'to', 'moveTree');
        final overwrite = D4.getNamedArgWithDefault<bool>(named, 'overwrite', false);
        final includeHidden = D4.getNamedArgWithDefault<bool>(named, 'includeHidden', false);
        if (!named.containsKey('filter')) {
          $dcli_core_12.moveTree(from, to, overwrite: overwrite, includeHidden: includeHidden);
          return null;
        }
        if (named.containsKey('filter')) {
          final filterRaw = named['filter'];
          final filter = (String p0) { return D4.callInterpreterCallback(visitor, filterRaw, [p0]) as bool; };
          $dcli_core_12.moveTree(from, to, overwrite: overwrite, includeHidden: includeHidden, filter: filter);
          return null;
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'touch': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'touch');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'touch');
        final create = D4.getNamedArgWithDefault<bool>(named, 'create', false);
        return $dcli_core_14.touch(path, create: create);
      },
      'verbose': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'verbose');
        if (positional.isEmpty) {
          throw ArgumentError('verbose: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        final callback = () { return D4.callInterpreterCallback(visitor, callbackRaw, []) as String; };
        return $dcli_core_16.verbose(callback);
      },
      'devNull': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'devNull');
        final line = D4.getRequiredArg<String?>(positional, 0, 'line', 'devNull');
        return $dcli_core_18.devNull(line);
      },
      'createTempFilename': (visitor, positional, named, typeArgs) {
        final suffix = D4.getOptionalNamedArg<String?>(named, 'suffix');
        final pathToTempDir = D4.getOptionalNamedArg<String?>(named, 'pathToTempDir');
        return $dcli_core_19.createTempFilename(suffix: suffix, pathToTempDir: pathToTempDir);
      },
      'createTempFile': (visitor, positional, named, typeArgs) {
        final suffix = D4.getOptionalNamedArg<String?>(named, 'suffix');
        return $dcli_core_19.createTempFile(suffix: suffix);
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
        return $dcli_core_24.truepath(part1, part2, part3, part4, part5, part6, part7);
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
        return $dcli_core_24.privatePath(part1, part2, part3, part4, part5, part6, part7);
      },
      'red': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'red');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'red');
        final background = D4.getNamedArgWithDefault<$dcli_terminal_2.AnsiColor>(named, 'background', $dcli_terminal_2.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $dcli_terminal_2.red(text, background: background, bold: bold);
      },
      'black': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'black');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'black');
        final background = D4.getNamedArgWithDefault<$dcli_terminal_2.AnsiColor>(named, 'background', $dcli_terminal_2.AnsiColor.white);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $dcli_terminal_2.black(text, background: background, bold: bold);
      },
      'green': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'green');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'green');
        final background = D4.getNamedArgWithDefault<$dcli_terminal_2.AnsiColor>(named, 'background', $dcli_terminal_2.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $dcli_terminal_2.green(text, background: background, bold: bold);
      },
      'blue': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'blue');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'blue');
        final background = D4.getNamedArgWithDefault<$dcli_terminal_2.AnsiColor>(named, 'background', $dcli_terminal_2.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $dcli_terminal_2.blue(text, background: background, bold: bold);
      },
      'yellow': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'yellow');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'yellow');
        final background = D4.getNamedArgWithDefault<$dcli_terminal_2.AnsiColor>(named, 'background', $dcli_terminal_2.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $dcli_terminal_2.yellow(text, background: background, bold: bold);
      },
      'magenta': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'magenta');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'magenta');
        final background = D4.getNamedArgWithDefault<$dcli_terminal_2.AnsiColor>(named, 'background', $dcli_terminal_2.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $dcli_terminal_2.magenta(text, background: background, bold: bold);
      },
      'cyan': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cyan');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'cyan');
        final background = D4.getNamedArgWithDefault<$dcli_terminal_2.AnsiColor>(named, 'background', $dcli_terminal_2.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $dcli_terminal_2.cyan(text, background: background, bold: bold);
      },
      'white': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'white');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'white');
        final background = D4.getNamedArgWithDefault<$dcli_terminal_2.AnsiColor>(named, 'background', $dcli_terminal_2.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $dcli_terminal_2.white(text, background: background, bold: bold);
      },
      'orange': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'orange');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'orange');
        final background = D4.getNamedArgWithDefault<$dcli_terminal_2.AnsiColor>(named, 'background', $dcli_terminal_2.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $dcli_terminal_2.orange(text, background: background, bold: bold);
      },
      'grey': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'grey');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'grey');
        final level = D4.getNamedArgWithDefault<double>(named, 'level', 0.5);
        final background = D4.getNamedArgWithDefault<$dcli_terminal_2.AnsiColor>(named, 'background', $dcli_terminal_2.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $dcli_terminal_2.grey(text, level: level, background: background, bold: bold);
      },
      'ask': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'ask');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'ask');
        final toLower = D4.getNamedArgWithDefault<bool>(named, 'toLower', false);
        final hidden = D4.getNamedArgWithDefault<bool>(named, 'hidden', false);
        final required = D4.getNamedArgWithDefault<bool>(named, 'required', true);
        final defaultValue = D4.getOptionalNamedArg<String?>(named, 'defaultValue');
        final validator = D4.getNamedArgWithDefault<$dcli_1.AskValidator>(named, 'validator', $aux_dcli.Ask.dontCare);
        final customErrorMessage = D4.getOptionalNamedArg<String?>(named, 'customErrorMessage');
        if (!named.containsKey('customPrompt')) {
          return $dcli_1.ask(prompt, toLower: toLower, hidden: hidden, required: required, defaultValue: defaultValue, validator: validator, customErrorMessage: customErrorMessage);
        }
        if (named.containsKey('customPrompt')) {
          final customPromptRaw = named['customPrompt'];
          final customPrompt = (String p0, String? p1, bool p2) { return D4.callInterpreterCallback(visitor, customPromptRaw, [p0, p1, p2]) as String; };
          return $dcli_1.ask(prompt, toLower: toLower, hidden: hidden, required: required, defaultValue: defaultValue, validator: validator, customErrorMessage: customErrorMessage, customPrompt: customPrompt);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'backupFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'backupFile');
        final pathToFile = D4.getRequiredArg<String>(positional, 0, 'pathToFile', 'backupFile');
        final ignoreMissing = D4.getNamedArgWithDefault<bool>(named, 'ignoreMissing', false);
        return $dcli_2.backupFile(pathToFile, ignoreMissing: ignoreMissing);
      },
      'restoreFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'restoreFile');
        final pathToFile = D4.getRequiredArg<String>(positional, 0, 'pathToFile', 'restoreFile');
        final ignoreMissing = D4.getNamedArgWithDefault<bool>(named, 'ignoreMissing', false);
        return $dcli_2.restoreFile(pathToFile, ignoreMissing: ignoreMissing);
      },
      'withFileProtectionAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'withFileProtectionAsync');
        final protected = D4.getRequiredArg<List<String>>(positional, 0, 'protected', 'withFileProtectionAsync');
        if (positional.length <= 1) {
          throw ArgumentError('withFileProtectionAsync: Missing required argument "action" at position 1');
        }
        final actionRaw = positional[1];
        final action = () { return D4.callInterpreterCallback(visitor, actionRaw, []) as Future<dynamic>; };
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        return $dcli_2.withFileProtectionAsync<dynamic>(protected, action, workingDirectory: workingDirectory);
      },
      'confirm': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'confirm');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'confirm');
        final defaultValue = D4.getOptionalNamedArg<bool?>(named, 'defaultValue');
        if (!named.containsKey('customPrompt')) {
          return $dcli_3.confirm(prompt, defaultValue: defaultValue);
        }
        if (named.containsKey('customPrompt')) {
          final customPromptRaw = named['customPrompt'];
          final customPrompt = (String p0, bool? p1) { return D4.callInterpreterCallback(visitor, customPromptRaw, [p0, p1]) as String; };
          return $dcli_3.confirm(prompt, defaultValue: defaultValue, customPrompt: customPrompt);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'delete': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'delete');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'delete');
        final ask = D4.getNamedArgWithDefault<bool>(named, 'ask', false);
        return $dcli_4.delete(path, ask: ask);
      },
      'echo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'echo');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'echo');
        final newline = D4.getNamedArgWithDefault<bool>(named, 'newline', false);
        return $dcli_5.echo(text, newline: newline);
      },
      'fetch': (visitor, positional, named, typeArgs) {
        final url = D4.getRequiredNamedArg<String>(named, 'url', 'fetch');
        final saveToPath = D4.getRequiredNamedArg<String>(named, 'saveToPath', 'fetch');
        final method = D4.getNamedArgWithDefault<$dcli_6.FetchMethod>(named, 'method', $dcli_6.FetchMethod.get);
        final headers = D4.getOptionalNamedArg<Map<String, String>?>(named, 'headers');
        final data = D4.getOptionalNamedArg<$dcli_6.FetchData?>(named, 'data');
        if (!named.containsKey('fetchProgress')) {
          return $dcli_6.fetch(url: url, saveToPath: saveToPath, method: method, headers: headers, data: data);
        }
        if (named.containsKey('fetchProgress')) {
          final fetchProgressRaw = named['fetchProgress'];
          final fetchProgress = ($dcli_6.FetchProgress p0) { D4.callInterpreterCallback(visitor, fetchProgressRaw, [p0]); };
          return $dcli_6.fetch(url: url, saveToPath: saveToPath, method: method, headers: headers, data: data, fetchProgress: fetchProgress);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'fetchMultiple': (visitor, positional, named, typeArgs) {
        if (!named.containsKey('urls') || named['urls'] == null) {
          throw ArgumentError('fetchMultiple: Missing required named argument "urls"');
        }
        final urls = D4.coerceList<$dcli_6.FetchUrl>(named['urls'], 'urls');
        return $dcli_6.fetchMultiple(urls: urls);
      },
      'find': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'find');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'find');
        final caseSensitive = D4.getNamedArgWithDefault<bool>(named, 'caseSensitive', false);
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', true);
        final includeHidden = D4.getNamedArgWithDefault<bool>(named, 'includeHidden', false);
        final workingDirectory = D4.getNamedArgWithDefault<String>(named, 'workingDirectory', '.');
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        if (!named.containsKey('types')) {
          return $dcli_8.find(pattern, caseSensitive: caseSensitive, recursive: recursive, includeHidden: includeHidden, workingDirectory: workingDirectory, progress: progress);
        }
        if (named.containsKey('types')) {
          final types = D4.coerceList<FileSystemEntityType>(named['types'], 'types');
          return $dcli_8.find(pattern, caseSensitive: caseSensitive, recursive: recursive, includeHidden: includeHidden, workingDirectory: workingDirectory, progress: progress, types: types);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'head': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'head');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'head');
        final lines = D4.getRequiredArg<int>(positional, 1, 'lines', 'head');
        return $dcli_9.head(path, lines);
      },
      'isWritable': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isWritable');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isWritable');
        return $dcli_10.isWritable(path);
      },
      'isReadable': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isReadable');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isReadable');
        return $dcli_10.isReadable(path);
      },
      'isExecutable': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isExecutable');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isExecutable');
        return $dcli_10.isExecutable(path);
      },
      'isMemberOfGroup': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isMemberOfGroup');
        final group = D4.getRequiredArg<String>(positional, 0, 'group', 'isMemberOfGroup');
        return $dcli_10.isMemberOfGroup(group);
      },
      'menu': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'menu');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'menu');
        if (!named.containsKey('options') || named['options'] == null) {
          throw ArgumentError('menu: Missing required named argument "options"');
        }
        final options = D4.coerceList<dynamic>(named['options'], 'options');
        final defaultOption = D4.getOptionalNamedArg<dynamic>(named, 'defaultOption');
        final limit = D4.getOptionalNamedArg<int?>(named, 'limit');
        final formatRaw = named['format'];
        final format = formatRaw == null ? null : (dynamic p0) { return D4.callInterpreterCallback(visitor, formatRaw, [p0]) as String; };
        final fromStart = D4.getNamedArgWithDefault<bool>(named, 'fromStart', true);
        if (!named.containsKey('customPrompt')) {
          return $dcli_11.menu(prompt, options: options, defaultOption: defaultOption, limit: limit, format: format, fromStart: fromStart);
        }
        if (named.containsKey('customPrompt')) {
          final customPromptRaw = named['customPrompt'];
          final customPrompt = (String p0, String? p1) { return D4.callInterpreterCallback(visitor, customPromptRaw, [p0, p1]) as String; };
          return $dcli_11.menu(prompt, options: options, defaultOption: defaultOption, limit: limit, format: format, fromStart: fromStart, customPrompt: customPrompt);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'read': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'read');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'read');
        final delim = D4.getNamedArgWithDefault<String>(named, 'delim', '\n');
        return $dcli_12.read(path, delim: delim);
      },
      'readStdin': (visitor, positional, named, typeArgs) {
        return $dcli_12.readStdin();
      },
      'replace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'replace');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'replace');
        final existing = D4.getRequiredArg<Pattern>(positional, 1, 'existing', 'replace');
        final replacement = D4.getRequiredArg<String>(positional, 2, 'replacement', 'replace');
        final all = D4.getNamedArgWithDefault<bool>(named, 'all', false);
        return $dcli_13.replace(path, existing, replacement, all: all);
      },
      'run': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'run');
        final commandLine = D4.getRequiredArg<String>(positional, 0, 'commandLine', 'run');
        final runInShell = D4.getNamedArgWithDefault<bool>(named, 'runInShell', false);
        final nothrow = D4.getNamedArgWithDefault<bool>(named, 'nothrow', false);
        final privileged = D4.getNamedArgWithDefault<bool>(named, 'privileged', false);
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final extensionSearch = D4.getNamedArgWithDefault<bool>(named, 'extensionSearch', true);
        if (!named.containsKey('encoding')) {
          return $dcli_14.run(commandLine, runInShell: runInShell, nothrow: nothrow, privileged: privileged, workingDirectory: workingDirectory, extensionSearch: extensionSearch);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'run');
          return $dcli_14.run(commandLine, runInShell: runInShell, nothrow: nothrow, privileged: privileged, workingDirectory: workingDirectory, extensionSearch: extensionSearch, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'startFromArgs': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'startFromArgs');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'startFromArgs');
        final args = D4.getRequiredArg<List<String>>(positional, 1, 'args', 'startFromArgs');
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        final runInShell = D4.getNamedArgWithDefault<bool>(named, 'runInShell', false);
        final detached = D4.getNamedArgWithDefault<bool>(named, 'detached', false);
        final terminal = D4.getNamedArgWithDefault<bool>(named, 'terminal', false);
        final privileged = D4.getNamedArgWithDefault<bool>(named, 'privileged', false);
        final nothrow = D4.getNamedArgWithDefault<bool>(named, 'nothrow', false);
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final extensionSearch = D4.getNamedArgWithDefault<bool>(named, 'extensionSearch', true);
        final includeParentEnvironment = D4.getNamedArgWithDefault<bool>(named, 'includeParentEnvironment', true);
        if (!named.containsKey('encoding')) {
          return $dcli_14.startFromArgs(command, args, progress: progress, runInShell: runInShell, detached: detached, terminal: terminal, privileged: privileged, nothrow: nothrow, workingDirectory: workingDirectory, extensionSearch: extensionSearch, includeParentEnvironment: includeParentEnvironment);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'startFromArgs');
          return $dcli_14.startFromArgs(command, args, progress: progress, runInShell: runInShell, detached: detached, terminal: terminal, privileged: privileged, nothrow: nothrow, workingDirectory: workingDirectory, extensionSearch: extensionSearch, includeParentEnvironment: includeParentEnvironment, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'start': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'start');
        final commandLine = D4.getRequiredArg<String>(positional, 0, 'commandLine', 'start');
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        final runInShell = D4.getNamedArgWithDefault<bool>(named, 'runInShell', false);
        final detached = D4.getNamedArgWithDefault<bool>(named, 'detached', false);
        final terminal = D4.getNamedArgWithDefault<bool>(named, 'terminal', false);
        final nothrow = D4.getNamedArgWithDefault<bool>(named, 'nothrow', false);
        final privileged = D4.getNamedArgWithDefault<bool>(named, 'privileged', false);
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final extensionSearch = D4.getNamedArgWithDefault<bool>(named, 'extensionSearch', true);
        final includeParentEnvironment = D4.getNamedArgWithDefault<bool>(named, 'includeParentEnvironment', true);
        if (!named.containsKey('encoding')) {
          return $dcli_14.start(commandLine, progress: progress, runInShell: runInShell, detached: detached, terminal: terminal, nothrow: nothrow, privileged: privileged, workingDirectory: workingDirectory, extensionSearch: extensionSearch, includeParentEnvironment: includeParentEnvironment);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'start');
          return $dcli_14.start(commandLine, progress: progress, runInShell: runInShell, detached: detached, terminal: terminal, nothrow: nothrow, privileged: privileged, workingDirectory: workingDirectory, extensionSearch: extensionSearch, includeParentEnvironment: includeParentEnvironment, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'sleep': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'sleep');
        final duration = D4.getRequiredArg<int>(positional, 0, 'duration', 'sleep');
        final interval = D4.getNamedArgWithDefault<$dcli_15.Interval>(named, 'interval', $dcli_15.Interval.seconds);
        return $dcli_15.sleep(duration, interval: interval);
      },
      'sleepAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'sleepAsync');
        final duration = D4.getRequiredArg<int>(positional, 0, 'duration', 'sleepAsync');
        final interval = D4.getNamedArgWithDefault<$dcli_15.Interval>(named, 'interval', $dcli_15.Interval.seconds);
        return $dcli_15.sleepAsync(duration, interval: interval);
      },
      'tail': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'tail');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'tail');
        final lines = D4.getRequiredArg<int>(positional, 1, 'lines', 'tail');
        return $dcli_16.tail(path, lines);
      },
      'which': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'which');
        final appname = D4.getRequiredArg<String>(positional, 0, 'appname', 'which');
        final first = D4.getNamedArgWithDefault<bool>(named, 'first', true);
        final verbose = D4.getNamedArgWithDefault<bool>(named, 'verbose', false);
        final extensionSearch = D4.getNamedArgWithDefault<bool>(named, 'extensionSearch', true);
        final progress = D4.getOptionalNamedArg<Sink<String>?>(named, 'progress');
        return $dcli_17.which(appname, first: first, verbose: verbose, extensionSearch: extensionSearch, progress: progress);
      },
      'addUnitTestOverrides': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addUnitTestOverrides');
        final pathToProject = D4.getRequiredArg<String>(positional, 0, 'pathToProject', 'addUnitTestOverrides');
        return $dcli_21.addUnitTestOverrides(pathToProject);
      },
      'capture': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'capture');
        if (positional.isEmpty) {
          throw ArgumentError('capture: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        final action = () { return D4.callInterpreterCallback(visitor, actionRaw, []) as Future<dynamic>; };
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        return $dcli_28.capture<dynamic>(action, progress: progress);
      },
      'showEditor': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'showEditor');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'showEditor');
        return $dcli_31.showEditor(path);
      },
      'withOpenFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'withOpenFile');
        final pathToFile = D4.getRequiredArg<String>(positional, 0, 'pathToFile', 'withOpenFile');
        if (positional.length <= 1) {
          throw ArgumentError('withOpenFile: Missing required argument "action" at position 1');
        }
        final actionRaw = positional[1];
        final action = ($dcli_34.FileSync p0) { return D4.callInterpreterCallback(visitor, actionRaw, [p0]) as dynamic; };
        final fileMode = D4.getNamedArgWithDefault<FileMode>(named, 'fileMode', FileMode.writeOnlyAppend);
        return $dcli_34.withOpenFile<dynamic>(pathToFile, action, fileMode: fileMode);
      },
      'createSymLink': (visitor, positional, named, typeArgs) {
        final targetPath = D4.getRequiredNamedArg<String>(named, 'targetPath', 'createSymLink');
        final linkPath = D4.getRequiredNamedArg<String>(named, 'linkPath', 'createSymLink');
        return $dcli_34.createSymLink(targetPath: targetPath, linkPath: linkPath);
      },
      'deleteSymlink': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'deleteSymlink');
        final linkPath = D4.getRequiredArg<String>(positional, 0, 'linkPath', 'deleteSymlink');
        return $dcli_34.deleteSymlink(linkPath);
      },
      'resolveSymLink': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'resolveSymLink');
        final pathToLink = D4.getRequiredArg<String>(positional, 0, 'pathToLink', 'resolveSymLink');
        return $dcli_34.resolveSymLink(pathToLink);
      },
      'stat': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'stat');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'stat');
        return $dcli_35.stat(path);
      },
      'fileLength': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fileLength');
        final pathToFile = D4.getRequiredArg<String>(positional, 0, 'pathToFile', 'fileLength');
        return $dcli_35.fileLength(pathToFile);
      },
      'calculateHash': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'calculateHash');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'calculateHash');
        return $dcli_35.calculateHash(path);
      },
      'printerr': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'printerr');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'printerr');
        return $dcli_40.printerr(object);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'cat': 'package:dcli_core/src/functions/cat.dart',
      'copy': 'package:dcli_core/src/functions/copy.dart',
      'copyTree': 'package:dcli_core/src/functions/copy_tree.dart',
      'createDir': 'package:dcli_core/src/functions/create_dir.dart',
      'withTempDirAsync': 'package:dcli_core/src/functions/create_dir.dart',
      'createTempDir': 'package:dcli_core/src/functions/create_dir.dart',
      'deleteDir': 'package:dcli_core/src/functions/delete_dir.dart',
      'isOnPATH': 'package:dcli_core/src/functions/env.dart',
      'withEnvironmentAsync': 'package:dcli_core/src/functions/env.dart',
      'isFile': 'package:dcli_core/src/functions/is.dart',
      'isDirectory': 'package:dcli_core/src/functions/is.dart',
      'isLink': 'package:dcli_core/src/functions/is.dart',
      'exists': 'package:dcli_core/src/functions/is.dart',
      'isEmpty': 'package:dcli_core/src/functions/is.dart',
      'move': 'package:dcli_core/src/functions/move.dart',
      'moveDir': 'package:dcli_core/src/functions/move_dir.dart',
      'moveTree': 'package:dcli_core/src/functions/move_tree.dart',
      'touch': 'package:dcli_core/src/functions/touch.dart',
      'verbose': 'package:dcli_core/src/settings.dart',
      'devNull': 'package:dcli_core/src/util/dev_null.dart',
      'createTempFilename': 'package:dcli_core/src/util/file.dart',
      'createTempFile': 'package:dcli_core/src/util/file.dart',
      'truepath': 'package:dcli_core/src/util/truepath.dart',
      'privatePath': 'package:dcli_core/src/util/truepath.dart',
      'red': 'package:dcli_terminal/src/ansi_color.dart',
      'black': 'package:dcli_terminal/src/ansi_color.dart',
      'green': 'package:dcli_terminal/src/ansi_color.dart',
      'blue': 'package:dcli_terminal/src/ansi_color.dart',
      'yellow': 'package:dcli_terminal/src/ansi_color.dart',
      'magenta': 'package:dcli_terminal/src/ansi_color.dart',
      'cyan': 'package:dcli_terminal/src/ansi_color.dart',
      'white': 'package:dcli_terminal/src/ansi_color.dart',
      'orange': 'package:dcli_terminal/src/ansi_color.dart',
      'grey': 'package:dcli_terminal/src/ansi_color.dart',
      'ask': 'package:dcli/src/functions/ask.dart',
      'backupFile': 'package:dcli/src/functions/backup.dart',
      'restoreFile': 'package:dcli/src/functions/backup.dart',
      'withFileProtectionAsync': 'package:dcli/src/functions/backup.dart',
      'confirm': 'package:dcli/src/functions/confirm.dart',
      'delete': 'package:dcli/src/functions/delete.dart',
      'echo': 'package:dcli/src/functions/echo.dart',
      'fetch': 'package:dcli/src/functions/fetch.dart',
      'fetchMultiple': 'package:dcli/src/functions/fetch.dart',
      'find': 'package:dcli/src/functions/find.dart',
      'head': 'package:dcli/src/functions/head.dart',
      'isWritable': 'package:dcli/src/functions/is.dart',
      'isReadable': 'package:dcli/src/functions/is.dart',
      'isExecutable': 'package:dcli/src/functions/is.dart',
      'isMemberOfGroup': 'package:dcli/src/functions/is.dart',
      'menu': 'package:dcli/src/functions/menu.dart',
      'read': 'package:dcli/src/functions/read.dart',
      'readStdin': 'package:dcli/src/functions/read.dart',
      'replace': 'package:dcli/src/functions/replace.dart',
      'run': 'package:dcli/src/functions/run.dart',
      'startFromArgs': 'package:dcli/src/functions/run.dart',
      'start': 'package:dcli/src/functions/run.dart',
      'sleep': 'package:dcli/src/functions/sleep.dart',
      'sleepAsync': 'package:dcli/src/functions/sleep.dart',
      'tail': 'package:dcli/src/functions/tail.dart',
      'which': 'package:dcli/src/functions/which.dart',
      'addUnitTestOverrides': 'package:dcli/src/script/dart_project_creator.dart',
      'capture': 'package:dcli/src/util/capture.dart',
      'showEditor': 'package:dcli/src/util/editor.dart',
      'withOpenFile': 'package:dcli/src/util/file_sync.dart',
      'createSymLink': 'package:dcli/src/util/file_sync.dart',
      'deleteSymlink': 'package:dcli/src/util/file_sync.dart',
      'resolveSymLink': 'package:dcli/src/util/file_sync.dart',
      'stat': 'package:dcli/src/util/file_util.dart',
      'fileLength': 'package:dcli/src/util/file_util.dart',
      'calculateHash': 'package:dcli/src/util/file_util.dart',
      'printerr': 'package:dcli/src/util/runnable_process.dart',
    };
  }

  /// Returns a map of global function names to their display signatures.
  static Map<String, String> globalFunctionSignatures() {
    return {
      'cat': 'void cat(String path, {LineAction stdout = print})',
      'copy': 'void copy(String from, String to, {bool overwrite = false})',
      'copyTree': 'void copyTree(String from, String to, {bool overwrite = false, bool includeHidden = false, bool includeEmpty = true, bool includeLinks = true, bool recursive = true, bool Function(String file) filter = _allowAll})',
      'createDir': 'String createDir(String path, {bool recursive = false})',
      'withTempDirAsync': 'Future<R> withTempDirAsync(Future<R> Function(String tempDir) action, {bool keep = false, String? pathToTempDir})',
      'createTempDir': 'String createTempDir()',
      'deleteDir': 'void deleteDir(String path, {bool recursive = true})',
      'isOnPATH': 'bool isOnPATH(String path)',
      'withEnvironmentAsync': 'Future<R> withEnvironmentAsync(Future<R> Function() callback, {required Map<String, String> environment})',
      'isFile': 'bool isFile(String path)',
      'isDirectory': 'bool isDirectory(String path)',
      'isLink': 'bool isLink(String path)',
      'exists': 'bool exists(String path, {bool followLinks = true})',
      'isEmpty': 'bool isEmpty(String pathToDirectory)',
      'move': 'void move(String from, String to, {bool overwrite = false})',
      'moveDir': 'void moveDir(String from, String to)',
      'moveTree': 'void moveTree(String from, String to, {bool overwrite = false, bool includeHidden = false, bool Function(String file) filter = _allowAll})',
      'touch': 'String touch(String path, {bool create = false})',
      'verbose': 'void verbose(String Function() callback)',
      'devNull': 'void devNull(String? line)',
      'createTempFilename': 'String createTempFilename({String? suffix, String? pathToTempDir})',
      'createTempFile': 'String createTempFile({String? suffix})',
      'truepath': 'String truepath(String part1, [String? part2, String? part3, String? part4, String? part5, String? part6, String? part7])',
      'privatePath': 'String privatePath(String part1, [String? part2, String? part3, String? part4, String? part5, String? part6, String? part7])',
      'red': 'String red(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'black': 'String black(String text, {AnsiColor background = AnsiColor.white, bool bold = true})',
      'green': 'String green(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'blue': 'String blue(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'yellow': 'String yellow(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'magenta': 'String magenta(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'cyan': 'String cyan(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'white': 'String white(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'orange': 'String orange(String text, {AnsiColor background = AnsiColor.none, bool bold = true})',
      'grey': 'String grey(String text, {double level = 0.5, AnsiColor background = AnsiColor.none, bool bold = true})',
      'ask': 'String ask(String prompt, {bool toLower = false, bool hidden = false, bool required = true, String? defaultValue, CustomAskPrompt customPrompt = Ask.defaultPrompt, AskValidator validator = Ask.dontCare, String? customErrorMessage})',
      'backupFile': 'void backupFile(String pathToFile, {bool ignoreMissing = false})',
      'restoreFile': 'void restoreFile(String pathToFile, {bool ignoreMissing = false})',
      'withFileProtectionAsync': 'Future<R> withFileProtectionAsync(List<String> protected, Future<R> Function() action, {String? workingDirectory})',
      'confirm': 'bool confirm(String prompt, {bool? defaultValue, CustomConfirmPrompt customPrompt = Confirm.defaultPrompt})',
      'delete': 'void delete(String path, {bool ask = false})',
      'echo': 'void echo(String text, {bool newline = false})',
      'fetch': 'Future<void> fetch({required String url, required String saveToPath, FetchMethod method = FetchMethod.get, Map<String, String>? headers, OnFetchProgress fetchProgress = _devNull, FetchData? data})',
      'fetchMultiple': 'Future<void> fetchMultiple({required List<FetchUrl> urls})',
      'find': 'FindProgress find(String pattern, {bool caseSensitive = false, bool recursive = true, bool includeHidden = false, String workingDirectory = \'.\', Progress? progress, List<FileSystemEntityType> types = const [Find.file]})',
      'head': 'HeadProgress head(String path, int lines)',
      'isWritable': 'bool isWritable(String path)',
      'isReadable': 'bool isReadable(String path)',
      'isExecutable': 'bool isExecutable(String path)',
      'isMemberOfGroup': 'bool isMemberOfGroup(String group)',
      'menu': 'T menu(String prompt, {required List<T> options, T? defaultOption, CustomMenuPrompt customPrompt = Menu.defaultPrompt, int? limit, String Function(T)? format, bool fromStart = true})',
      'read': 'Progress read(String path, {String delim = \'\\n\'})',
      'readStdin': 'Progress readStdin()',
      'replace': 'int replace(String path, Pattern existing, String replacement, {bool all = false})',
      'run': 'int? run(String commandLine, {bool runInShell = false, bool nothrow = false, bool privileged = false, String? workingDirectory, bool extensionSearch = true, Encoding encoding = utf8})',
      'startFromArgs': 'Progress startFromArgs(String command, List<String> args, {Progress? progress, bool runInShell = false, bool detached = false, bool terminal = false, bool privileged = false, bool nothrow = false, String? workingDirectory, bool extensionSearch = true, bool includeParentEnvironment = true, Encoding encoding = utf8})',
      'start': 'Progress start(String commandLine, {Progress? progress, bool runInShell = false, bool detached = false, bool terminal = false, bool nothrow = false, bool privileged = false, String? workingDirectory, bool extensionSearch = true, bool includeParentEnvironment = true, Encoding encoding = utf8})',
      'sleep': 'void sleep(int duration, {Interval interval = Interval.seconds})',
      'sleepAsync': 'Future<void> sleepAsync(int duration, {Interval interval = Interval.seconds})',
      'tail': 'TailProgress tail(String path, int lines)',
      'which': 'core.Which which(String appname, {bool first = true, bool verbose = false, bool extensionSearch = true, Sink<String>? progress})',
      'addUnitTestOverrides': 'void addUnitTestOverrides(String pathToProject)',
      'capture': 'Future<Progress> capture(Future<R> Function() action, {Progress? progress})',
      'showEditor': 'void showEditor(String path)',
      'withOpenFile': 'R withOpenFile(String pathToFile, R Function(FileSync) action, {FileMode fileMode = FileMode.writeOnlyAppend})',
      'createSymLink': 'void createSymLink({required String targetPath, required String linkPath})',
      'deleteSymlink': 'void deleteSymlink(String linkPath)',
      'resolveSymLink': 'String resolveSymLink(String pathToLink)',
      'stat': 'FileStat stat(String path)',
      'fileLength': 'int fileLength(String pathToFile)',
      'calculateHash': 'Digest calculateHash(String path)',
      'printerr': 'void printerr(Object? object)',
    };
  }

  /// Returns the list of canonical source library URIs.
  ///
  /// These are the actual source locations of all elements in this bridge,
  /// used for deduplication when the same libraries are exported through
  /// multiple barrels.
  static List<String> sourceLibraries() {
    return [
      'package:crypto/src/digest.dart',
      'package:dcli/src/functions/ask.dart',
      'package:dcli/src/functions/backup.dart',
      'package:dcli/src/functions/confirm.dart',
      'package:dcli/src/functions/delete.dart',
      'package:dcli/src/functions/echo.dart',
      'package:dcli/src/functions/fetch.dart',
      'package:dcli/src/functions/file_list.dart',
      'package:dcli/src/functions/find.dart',
      'package:dcli/src/functions/head.dart',
      'package:dcli/src/functions/is.dart',
      'package:dcli/src/functions/menu.dart',
      'package:dcli/src/functions/read.dart',
      'package:dcli/src/functions/replace.dart',
      'package:dcli/src/functions/run.dart',
      'package:dcli/src/functions/sleep.dart',
      'package:dcli/src/functions/tail.dart',
      'package:dcli/src/functions/which.dart',
      'package:dcli/src/progress/progress.dart',
      'package:dcli/src/resources/packed_resource.dart',
      'package:dcli/src/resources/resources.dart',
      'package:dcli/src/script/dart_project.dart',
      'package:dcli/src/script/dart_project_creator.dart',
      'package:dcli/src/script/dart_script.dart',
      'package:dcli/src/script/dart_sdk.dart',
      'package:dcli/src/settings.dart',
      'package:dcli/src/shell/shell.dart',
      'package:dcli/src/shell/shell_detection.dart',
      'package:dcli/src/shell/unknown_shell.dart',
      'package:dcli/src/util/capture.dart',
      'package:dcli/src/util/dcli_paths.dart',
      'package:dcli/src/util/editor.dart',
      'package:dcli/src/util/exceptions.dart',
      'package:dcli/src/util/file_sort.dart',
      'package:dcli/src/util/file_sync.dart',
      'package:dcli/src/util/file_util.dart',
      'package:dcli/src/util/named_lock.dart',
      'package:dcli/src/util/process_helper.dart',
      'package:dcli/src/util/pub_cache.dart',
      'package:dcli/src/util/remote.dart',
      'package:dcli/src/util/runnable_process.dart',
      'package:dcli_core/src/functions/cat.dart',
      'package:dcli_core/src/functions/copy.dart',
      'package:dcli_core/src/functions/copy_tree.dart',
      'package:dcli_core/src/functions/create_dir.dart',
      'package:dcli_core/src/functions/dcli_function.dart',
      'package:dcli_core/src/functions/delete_dir.dart',
      'package:dcli_core/src/functions/env.dart',
      'package:dcli_core/src/functions/find.dart',
      'package:dcli_core/src/functions/is.dart',
      'package:dcli_core/src/functions/move.dart',
      'package:dcli_core/src/functions/move_dir.dart',
      'package:dcli_core/src/functions/move_tree.dart',
      'package:dcli_core/src/functions/pwd.dart',
      'package:dcli_core/src/functions/touch.dart',
      'package:dcli_core/src/functions/which.dart',
      'package:dcli_core/src/settings.dart',
      'package:dcli_core/src/util/dcli_exception.dart',
      'package:dcli_core/src/util/dev_null.dart',
      'package:dcli_core/src/util/file.dart',
      'package:dcli_core/src/util/platform.dart',
      'package:dcli_core/src/util/run_exception.dart',
      'package:dcli_core/src/util/stack_list.dart',
      'package:dcli_core/src/util/truepath.dart',
      'package:dcli_terminal/src/ansi.dart',
      'package:dcli_terminal/src/ansi_color.dart',
      'package:dcli_terminal/src/format.dart',
      'package:dcli_terminal/src/terminal.dart',
    ];
  }

  /// Returns the import statement needed for D4rt scripts.
  ///
  /// Use this in your D4rt initialization script to make all
  /// bridged classes available to scripts.
  static String getImportBlock() {
    final imports = StringBuffer();
    imports.writeln("import 'package:dcli/dcli.dart';");
    imports.writeln("import 'package:crypto/crypto.dart';");
    imports.writeln("import 'package:dcli_core/dcli_core.dart';");
    imports.writeln("import 'package:dcli_terminal/dcli_terminal.dart';");
    return imports.toString();
  }

  /// Returns barrel import URIs for sub-packages discovered through re-exports.
  ///
  /// When a module follows re-exports into sub-packages (e.g., dcli re-exports
  /// dcli_core), D4rt scripts may import those sub-packages directly.
  /// These barrels need to be registered with the interpreter separately
  /// so that module resolution finds content for those URIs.
  static List<String> subPackageBarrels() {
    return [
      'package:crypto/crypto.dart',
      'package:dcli_core/dcli_core.dart',
      'package:dcli_terminal/dcli_terminal.dart',
    ];
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'TableAlignment',
    'TerminalClearMode',
    'FetchMethod',
    'FetchStatus',
    'Interval',
    'SortDirection',
  ];

}

// =============================================================================
// Digest Bridge
// =============================================================================

BridgedClass _createDigestBridge() {
  return BridgedClass(
    nativeType: $crypto_1.Digest,
    name: 'Digest',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Digest');
        if (positional.isEmpty) {
          throw ArgumentError('Digest: Missing required argument "bytes" at position 0');
        }
        final bytes = D4.coerceList<int>(positional[0], 'bytes');
        return $crypto_1.Digest(bytes);
      },
    },
    getters: {
      'bytes': (visitor, target) => D4.validateTarget<$crypto_1.Digest>(target, 'Digest').bytes,
      'hashCode': (visitor, target) => D4.validateTarget<$crypto_1.Digest>(target, 'Digest').hashCode,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$crypto_1.Digest>(target, 'Digest');
        return t.toString();
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$crypto_1.Digest>(target, 'Digest');
        final other = D4.getRequiredArg<Object>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'Digest(List<int> bytes)',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'bytes': 'List<int> get bytes',
      'hashCode': 'int get hashCode',
    },
  );
}

// =============================================================================
// CatException Bridge
// =============================================================================

BridgedClass _createCatExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_core_1.CatException,
    name: 'CatException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CatException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'CatException');
        final stacktrace = D4.getOptionalArg<dynamic>(positional, 1, 'stacktrace');
        return $dcli_core_1.CatException(message, stacktrace);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_core_1.CatException>(target, 'CatException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_core_1.CatException>(target, 'CatException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_core_1.CatException>(target, 'CatException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_1.CatException>(target, 'CatException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_1.CatException>(target, 'CatException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_1.CatException>(target, 'CatException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_1.CatException>(target, 'CatException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_1.CatException>(target, 'CatException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'CatException(String message, [InvalidType stacktrace])',
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
    nativeType: $dcli_core_2.CopyException,
    name: 'CopyException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CopyException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'CopyException');
        return $dcli_core_2.CopyException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_core_2.CopyException>(target, 'CopyException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_core_2.CopyException>(target, 'CopyException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_core_2.CopyException>(target, 'CopyException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_2.CopyException>(target, 'CopyException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_2.CopyException>(target, 'CopyException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_2.CopyException>(target, 'CopyException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_2.CopyException>(target, 'CopyException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_2.CopyException>(target, 'CopyException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'CopyException(String message)',
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
    nativeType: $dcli_core_4.CreateDirException,
    name: 'CreateDirException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CreateDirException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'CreateDirException');
        return $dcli_core_4.CreateDirException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_core_4.CreateDirException>(target, 'CreateDirException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_core_4.CreateDirException>(target, 'CreateDirException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_core_4.CreateDirException>(target, 'CreateDirException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_4.CreateDirException>(target, 'CreateDirException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_4.CreateDirException>(target, 'CreateDirException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_4.CreateDirException>(target, 'CreateDirException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_4.CreateDirException>(target, 'CreateDirException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_4.CreateDirException>(target, 'CreateDirException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'CreateDirException(String message)',
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
    nativeType: $dcli_core_5.DCliFunction,
    name: 'DCliFunction',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_core_5.DCliFunction();
      },
    },
    constructorSignatures: {
      '': 'DCliFunction()',
    },
  );
}

// =============================================================================
// DCliFunctionException Bridge
// =============================================================================

BridgedClass _createDCliFunctionExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_core_5.DCliFunctionException,
    name: 'DCliFunctionException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DCliFunctionException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DCliFunctionException');
        final stackTrace = D4.getOptionalArg<dynamic>(positional, 1, 'stackTrace');
        return $dcli_core_5.DCliFunctionException(message, stackTrace);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_core_5.DCliFunctionException>(target, 'DCliFunctionException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_core_5.DCliFunctionException>(target, 'DCliFunctionException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_core_5.DCliFunctionException>(target, 'DCliFunctionException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_5.DCliFunctionException>(target, 'DCliFunctionException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_5.DCliFunctionException>(target, 'DCliFunctionException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_5.DCliFunctionException>(target, 'DCliFunctionException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_5.DCliFunctionException>(target, 'DCliFunctionException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_5.DCliFunctionException>(target, 'DCliFunctionException');
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
// DeleteDirException Bridge
// =============================================================================

BridgedClass _createDeleteDirExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_core_6.DeleteDirException,
    name: 'DeleteDirException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DeleteDirException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DeleteDirException');
        return $dcli_core_6.DeleteDirException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_core_6.DeleteDirException>(target, 'DeleteDirException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_core_6.DeleteDirException>(target, 'DeleteDirException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_core_6.DeleteDirException>(target, 'DeleteDirException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_6.DeleteDirException>(target, 'DeleteDirException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_6.DeleteDirException>(target, 'DeleteDirException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_6.DeleteDirException>(target, 'DeleteDirException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_6.DeleteDirException>(target, 'DeleteDirException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_6.DeleteDirException>(target, 'DeleteDirException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'DeleteDirException(String message)',
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
    nativeType: $dcli_core_7.Env,
    name: 'Env',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_core_7.Env();
      },
      'forScope': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Env');
        if (positional.isEmpty) {
          throw ArgumentError('Env: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, String>(positional[0], 'map');
        return $dcli_core_7.Env.forScope(map);
      },
    },
    getters: {
      'caseSensitive': (visitor, target) => D4.validateTarget<$dcli_core_7.Env>(target, 'Env').caseSensitive,
      'entries': (visitor, target) => D4.validateTarget<$dcli_core_7.Env>(target, 'Env').entries,
      'HOME': (visitor, target) => D4.validateTarget<$dcli_core_7.Env>(target, 'Env').HOME,
      'delimiterForPATH': (visitor, target) => D4.validateTarget<$dcli_core_7.Env>(target, 'Env').delimiterForPATH,
    },
    methods: {
      'addAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_7.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'addAll');
        if (positional.isEmpty) {
          throw ArgumentError('addAll: Missing required argument "other" at position 0');
        }
        final other = D4.coerceMap<String, String>(positional[0], 'other');
        t.addAll(other);
        return null;
      },
      'exists': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_7.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'exists');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'exists');
        return t.exists(key);
      },
      'appendToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_7.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'appendToPATH');
        final newPath = D4.getRequiredArg<String>(positional, 0, 'newPath', 'appendToPATH');
        t.appendToPATH(newPath);
        return null;
      },
      'prependToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_7.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'prependToPATH');
        final newPath = D4.getRequiredArg<String>(positional, 0, 'newPath', 'prependToPATH');
        t.prependToPATH(newPath);
        return null;
      },
      'removeFromPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_7.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'removeFromPATH');
        final oldPath = D4.getRequiredArg<String>(positional, 0, 'oldPath', 'removeFromPATH');
        t.removeFromPATH(oldPath);
        return null;
      },
      'addToPATHIfAbsent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_7.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'addToPATHIfAbsent');
        final newPath = D4.getRequiredArg<String>(positional, 0, 'newPath', 'addToPATHIfAbsent');
        t.addToPATHIfAbsent(newPath);
        return null;
      },
      'isOnPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_7.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'isOnPATH');
        final checkPath = D4.getRequiredArg<String>(positional, 0, 'checkPath', 'isOnPATH');
        return t.isOnPATH(checkPath);
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_7.Env>(target, 'Env');
        return t.toJson();
      },
      'fromJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_7.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'fromJson');
        final json = D4.getRequiredArg<String>(positional, 0, 'json', 'fromJson');
        t.fromJson(json);
        return null;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_7.Env>(target, 'Env');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_7.Env>(target, 'Env');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<String?>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    staticGetters: {
      'scopeKey': (visitor) => $dcli_core_7.Env.scopeKey,
    },
    staticSetters: {
      'scopeKey': (visitor, value) => 
        $dcli_core_7.Env.scopeKey = value as dynamic,
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
      'scopeKey': 'dynamic get scopeKey',
    },
    staticSetterSignatures: {
      'scopeKey': 'set scopeKey(dynamic value)',
    },
  );
}

// =============================================================================
// FindItem Bridge
// =============================================================================

BridgedClass _createFindItemBridge() {
  return BridgedClass(
    nativeType: $dcli_core_8.FindItem,
    name: 'FindItem',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FindItem');
        final pathTo = D4.getRequiredArg<String>(positional, 0, 'pathTo', 'FindItem');
        final type = D4.getRequiredArg<FileSystemEntityType>(positional, 1, 'type', 'FindItem');
        return $dcli_core_8.FindItem(pathTo, type);
      },
    },
    getters: {
      'pathTo': (visitor, target) => D4.validateTarget<$dcli_core_8.FindItem>(target, 'FindItem').pathTo,
      'type': (visitor, target) => D4.validateTarget<$dcli_core_8.FindItem>(target, 'FindItem').type,
    },
    setters: {
      'pathTo': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_8.FindItem>(target, 'FindItem').pathTo = value as String,
      'type': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_8.FindItem>(target, 'FindItem').type = value as FileSystemEntityType,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_8.FindItem>(target, 'FindItem');
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
// MoveException Bridge
// =============================================================================

BridgedClass _createMoveExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_core_10.MoveException,
    name: 'MoveException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MoveException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'MoveException');
        return $dcli_core_10.MoveException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_core_10.MoveException>(target, 'MoveException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_core_10.MoveException>(target, 'MoveException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_core_10.MoveException>(target, 'MoveException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_10.MoveException>(target, 'MoveException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_10.MoveException>(target, 'MoveException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_10.MoveException>(target, 'MoveException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_10.MoveException>(target, 'MoveException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_10.MoveException>(target, 'MoveException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'MoveException(String message)',
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
    nativeType: $dcli_core_11.MoveDirException,
    name: 'MoveDirException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MoveDirException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'MoveDirException');
        return $dcli_core_11.MoveDirException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_core_11.MoveDirException>(target, 'MoveDirException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_core_11.MoveDirException>(target, 'MoveDirException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_core_11.MoveDirException>(target, 'MoveDirException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_11.MoveDirException>(target, 'MoveDirException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_11.MoveDirException>(target, 'MoveDirException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_11.MoveDirException>(target, 'MoveDirException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_11.MoveDirException>(target, 'MoveDirException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_11.MoveDirException>(target, 'MoveDirException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'MoveDirException(String message)',
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
    nativeType: $dcli_core_12.MoveTreeException,
    name: 'MoveTreeException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MoveTreeException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'MoveTreeException');
        return $dcli_core_12.MoveTreeException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_core_12.MoveTreeException>(target, 'MoveTreeException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_core_12.MoveTreeException>(target, 'MoveTreeException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_core_12.MoveTreeException>(target, 'MoveTreeException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_12.MoveTreeException>(target, 'MoveTreeException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_12.MoveTreeException>(target, 'MoveTreeException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_12.MoveTreeException>(target, 'MoveTreeException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_12.MoveTreeException>(target, 'MoveTreeException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_12.MoveTreeException>(target, 'MoveTreeException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'MoveTreeException(String message)',
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
// DCliException Bridge
// =============================================================================

BridgedClass _createDCliExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_core_17.DCliException,
    name: 'DCliException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DCliException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DCliException');
        final stackTrace = D4.getOptionalArg<dynamic>(positional, 1, 'stackTrace');
        return $dcli_core_17.DCliException(message, stackTrace);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DCliException');
        final jsonStr = D4.getRequiredArg<String>(positional, 0, 'jsonStr', 'DCliException');
        return $dcli_core_17.DCliException.fromJson(jsonStr);
      },
      'from': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DCliException');
        final cause = D4.getRequiredArg<Object?>(positional, 0, 'cause', 'DCliException');
        final stackTrace = D4.getRequiredArg<dynamic>(positional, 1, 'stackTrace', 'DCliException');
        return $dcli_core_17.DCliException.from(cause, stackTrace);
      },
      'fromException': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DCliException');
        final cause = D4.getRequiredArg<Object?>(positional, 0, 'cause', 'DCliException');
        return $dcli_core_17.DCliException.fromException(cause);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_core_17.DCliException>(target, 'DCliException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_core_17.DCliException>(target, 'DCliException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_core_17.DCliException>(target, 'DCliException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_17.DCliException>(target, 'DCliException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_17.DCliException>(target, 'DCliException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_17.DCliException>(target, 'DCliException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_17.DCliException>(target, 'DCliException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_17.DCliException>(target, 'DCliException');
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
// RunException Bridge
// =============================================================================

BridgedClass _createRunExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_core_22.RunException,
    name: 'RunException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'RunException');
        final cmdLine = D4.getRequiredArg<String>(positional, 0, 'cmdLine', 'RunException');
        final exitCode = D4.getRequiredArg<int?>(positional, 1, 'exitCode', 'RunException');
        final reason = D4.getRequiredArg<String>(positional, 2, 'reason', 'RunException');
        final stackTrace = D4.getOptionalNamedArg<dynamic>(named, 'stackTrace');
        return $dcli_core_22.RunException(cmdLine, exitCode, reason, stackTrace: stackTrace);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'RunException');
        if (positional.isEmpty) {
          throw ArgumentError('RunException: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $dcli_core_22.RunException.fromJson(json);
      },
      'fromJsonString': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'RunException');
        final jsonString = D4.getRequiredArg<String>(positional, 0, 'jsonString', 'RunException');
        return $dcli_core_22.RunException.fromJsonString(jsonString);
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
        return $dcli_core_22.RunException.withArgs(cmd, args, exitCode, reason, stackTrace: stackTrace);
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
        return $dcli_core_22.RunException.fromException(exception, cmd, args, stackTrace: stackTrace);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException').stackTrace,
      'cmdLine': (visitor, target) => D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException').cmdLine,
      'exitCode': (visitor, target) => D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException').exitCode,
      'reason': (visitor, target) => D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException').reason,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException').stackTrace = value as dynamic,
      'cmdLine': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException').cmdLine = value as String,
      'exitCode': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException').exitCode = value as int?,
      'reason': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException').reason = value as String,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException');
        return t.toJsonString();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_22.RunException>(target, 'RunException');
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
    nativeType: $dcli_core_23.StackList,
    name: 'StackList',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_core_23.StackList();
      },
      'fromList': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'StackList');
        if (positional.isEmpty) {
          throw ArgumentError('StackList: Missing required argument "initialStack" at position 0');
        }
        final initialStack = D4.coerceList<dynamic>(positional[0], 'initialStack');
        return $dcli_core_23.StackList.fromList(initialStack);
      },
    },
    getters: {
      'isEmpty': (visitor, target) => D4.validateTarget<$dcli_core_23.StackList>(target, 'StackList').isEmpty,
    },
    methods: {
      'push': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_23.StackList>(target, 'StackList');
        D4.requireMinArgs(positional, 1, 'push');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'push');
        t.push(item);
        return null;
      },
      'pop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_23.StackList>(target, 'StackList');
        return t.pop();
      },
      'peek': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_23.StackList>(target, 'StackList');
        return t.peek();
      },
      'asList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_core_23.StackList>(target, 'StackList');
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

// =============================================================================
// Ansi Bridge
// =============================================================================

BridgedClass _createAnsiBridge() {
  return BridgedClass(
    nativeType: $dcli_terminal_1.Ansi,
    name: 'Ansi',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_terminal_1.Ansi();
      },
    },
    staticGetters: {
      'isSupported': (visitor) => $dcli_terminal_1.Ansi.isSupported,
      'resetEmitAnsi': (visitor) => $dcli_terminal_1.Ansi.resetEmitAnsi,
      'esc': (visitor) => $dcli_terminal_1.Ansi.esc,
    },
    staticMethods: {
      'strip': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'strip');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'strip');
        return $dcli_terminal_1.Ansi.strip(line);
      },
    },
    staticSetters: {
      'isSupported': (visitor, value) => 
        $dcli_terminal_1.Ansi.isSupported = value as dynamic,
    },
    constructorSignatures: {
      '': 'factory Ansi()',
    },
    staticMethodSignatures: {
      'strip': 'String strip(String line)',
    },
    staticGetterSignatures: {
      'isSupported': 'bool get isSupported',
      'resetEmitAnsi': 'void get resetEmitAnsi',
      'esc': 'dynamic get esc',
    },
    staticSetterSignatures: {
      'isSupported': 'set isSupported(bool value)',
    },
  );
}

// =============================================================================
// AnsiColor Bridge
// =============================================================================

BridgedClass _createAnsiColorBridge() {
  return BridgedClass(
    nativeType: $dcli_terminal_2.AnsiColor,
    name: 'AnsiColor',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AnsiColor');
        final code = D4.getRequiredArg<int>(positional, 0, 'code', 'AnsiColor');
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return $dcli_terminal_2.AnsiColor(code, bold: bold);
      },
    },
    getters: {
      'code': (visitor, target) => D4.validateTarget<$dcli_terminal_2.AnsiColor>(target, 'AnsiColor').code,
      'bold': (visitor, target) => D4.validateTarget<$dcli_terminal_2.AnsiColor>(target, 'AnsiColor').bold,
    },
    methods: {
      'apply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_2.AnsiColor>(target, 'AnsiColor');
        D4.requireMinArgs(positional, 1, 'apply');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'apply');
        if (!named.containsKey('background')) {
          return t.apply(text);
        }
        if (named.containsKey('background')) {
          final background = D4.getRequiredNamedArg<$dcli_terminal_2.AnsiColor>(named, 'background', 'apply');
          return t.apply(text, background: background);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    staticGetters: {
      'codeBlack': (visitor) => $dcli_terminal_2.AnsiColor.codeBlack,
      'codeRed': (visitor) => $dcli_terminal_2.AnsiColor.codeRed,
      'codeGreen': (visitor) => $dcli_terminal_2.AnsiColor.codeGreen,
      'codeYellow': (visitor) => $dcli_terminal_2.AnsiColor.codeYellow,
      'codeBlue': (visitor) => $dcli_terminal_2.AnsiColor.codeBlue,
      'codeMagenta': (visitor) => $dcli_terminal_2.AnsiColor.codeMagenta,
      'codeCyan': (visitor) => $dcli_terminal_2.AnsiColor.codeCyan,
      'codeWhite': (visitor) => $dcli_terminal_2.AnsiColor.codeWhite,
      'codeOrange': (visitor) => $dcli_terminal_2.AnsiColor.codeOrange,
      'codeGrey': (visitor) => $dcli_terminal_2.AnsiColor.codeGrey,
      'black': (visitor) => $dcli_terminal_2.AnsiColor.black,
      'red': (visitor) => $dcli_terminal_2.AnsiColor.red,
      'green': (visitor) => $dcli_terminal_2.AnsiColor.green,
      'yellow': (visitor) => $dcli_terminal_2.AnsiColor.yellow,
      'blue': (visitor) => $dcli_terminal_2.AnsiColor.blue,
      'magenta': (visitor) => $dcli_terminal_2.AnsiColor.magenta,
      'cyan': (visitor) => $dcli_terminal_2.AnsiColor.cyan,
      'white': (visitor) => $dcli_terminal_2.AnsiColor.white,
      'orange': (visitor) => $dcli_terminal_2.AnsiColor.orange,
      'none': (visitor) => $dcli_terminal_2.AnsiColor.none,
    },
    staticMethods: {
      'reset': (visitor, positional, named, typeArgs) {
        return $dcli_terminal_2.AnsiColor.reset();
      },
      'fgReset': (visitor, positional, named, typeArgs) {
        return $dcli_terminal_2.AnsiColor.fgReset();
      },
      'bgReset': (visitor, positional, named, typeArgs) {
        return $dcli_terminal_2.AnsiColor.bgReset();
      },
    },
    constructorSignatures: {
      '': 'const AnsiColor(int code, {bool bold = true})',
    },
    methodSignatures: {
      'apply': 'String apply(String text, {AnsiColor background = none})',
    },
    getterSignatures: {
      'code': 'int get code',
      'bold': 'bool get bold',
    },
    staticMethodSignatures: {
      'reset': 'String reset()',
      'fgReset': 'String fgReset()',
      'bgReset': 'String bgReset()',
    },
    staticGetterSignatures: {
      'codeBlack': 'dynamic get codeBlack',
      'codeRed': 'dynamic get codeRed',
      'codeGreen': 'dynamic get codeGreen',
      'codeYellow': 'dynamic get codeYellow',
      'codeBlue': 'dynamic get codeBlue',
      'codeMagenta': 'dynamic get codeMagenta',
      'codeCyan': 'dynamic get codeCyan',
      'codeWhite': 'dynamic get codeWhite',
      'codeOrange': 'dynamic get codeOrange',
      'codeGrey': 'dynamic get codeGrey',
      'black': 'dynamic get black',
      'red': 'dynamic get red',
      'green': 'dynamic get green',
      'yellow': 'dynamic get yellow',
      'blue': 'dynamic get blue',
      'magenta': 'dynamic get magenta',
      'cyan': 'dynamic get cyan',
      'white': 'dynamic get white',
      'orange': 'dynamic get orange',
      'none': 'dynamic get none',
    },
  );
}

// =============================================================================
// Format Bridge
// =============================================================================

BridgedClass _createFormatBridge() {
  return BridgedClass(
    nativeType: $dcli_terminal_3.Format,
    name: 'Format',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_terminal_3.Format();
      },
    },
    methods: {
      'row': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_3.Format>(target, 'Format');
        D4.requireMinArgs(positional, 1, 'row');
        if (positional.isEmpty) {
          throw ArgumentError('row: Missing required argument "cols" at position 0');
        }
        final cols = D4.coerceList<String?>(positional[0], 'cols');
        final widths = D4.coerceListOrNull<int>(named['widths'], 'widths');
        final alignments = D4.coerceListOrNull<$dcli_terminal_3.TableAlignment>(named['alignments'], 'alignments');
        final delimiter = D4.getOptionalNamedArg<String?>(named, 'delimiter');
        return t.row(cols, widths: widths, alignments: alignments, delimiter: delimiter);
      },
      'limitString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_3.Format>(target, 'Format');
        D4.requireMinArgs(positional, 1, 'limitString');
        final display = D4.getRequiredArg<String>(positional, 0, 'display', 'limitString');
        final width = D4.getNamedArgWithDefault<int>(named, 'width', 40);
        return t.limitString(display, width: width);
      },
      'percentage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_3.Format>(target, 'Format');
        D4.requireMinArgs(positional, 2, 'percentage');
        final progress = D4.getRequiredArg<double>(positional, 0, 'progress', 'percentage');
        final precision = D4.getRequiredArg<int>(positional, 1, 'precision', 'percentage');
        return t.percentage(progress, precision);
      },
      'bytesAsReadable': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_3.Format>(target, 'Format');
        D4.requireMinArgs(positional, 1, 'bytesAsReadable');
        final bytes = D4.getRequiredArg<int>(positional, 0, 'bytes', 'bytesAsReadable');
        final pad = D4.getNamedArgWithDefault<bool>(named, 'pad', true);
        return t.bytesAsReadable(bytes, pad: pad);
      },
    },
    constructorSignatures: {
      '': 'factory Format()',
    },
    methodSignatures: {
      'row': 'String row(List<String?> cols, {List<int>? widths, List<TableAlignment>? alignments, String? delimiter})',
      'limitString': 'String limitString(String display, {int width = 40})',
      'percentage': 'String percentage(double progress, int precision)',
      'bytesAsReadable': 'String bytesAsReadable(int bytes, {bool pad = true})',
    },
  );
}

// =============================================================================
// Terminal Bridge
// =============================================================================

BridgedClass _createTerminalBridge() {
  return BridgedClass(
    nativeType: $dcli_terminal_4.Terminal,
    name: 'Terminal',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_terminal_4.Terminal();
      },
    },
    getters: {
      'isAnsi': (visitor, target) => D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal').isAnsi,
      'column': (visitor, target) => D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal').column,
      'columns': (visitor, target) => D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal').columns,
      'row': (visitor, target) => D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal').row,
      'hasTerminal': (visitor, target) => D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal').hasTerminal,
      'rows': (visitor, target) => D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal').rows,
      'lines': (visitor, target) => D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal').lines,
    },
    setters: {
      'column': (visitor, target, value) => 
        D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal').column = value as dynamic,
      'row': (visitor, target, value) => 
        D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal').row = value as dynamic,
    },
    methods: {
      'clearScreen': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal');
        final mode = D4.getNamedArgWithDefault<$dcli_terminal_4.TerminalClearMode>(named, 'mode', $dcli_terminal_4.TerminalClearMode.all);
        t.clearScreen(mode: mode);
        return null;
      },
      'overwriteLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal');
        D4.requireMinArgs(positional, 1, 'overwriteLine');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'overwriteLine');
        t.overwriteLine(text);
        return null;
      },
      'write': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal');
        D4.requireMinArgs(positional, 1, 'write');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'write');
        t.write(text);
        return null;
      },
      'writeLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal');
        D4.requireMinArgs(positional, 1, 'writeLine');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'writeLine');
        if (!named.containsKey('alignment')) {
          t.writeLine(text);
          return null;
        }
        if (named.containsKey('alignment')) {
          final alignment = D4.getRequiredNamedArg<dynamic>(named, 'alignment', 'writeLine');
          t.writeLine(text, alignment: alignment);
          return null;
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'clearLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal');
        final mode = D4.getNamedArgWithDefault<$dcli_terminal_4.TerminalClearMode>(named, 'mode', $dcli_terminal_4.TerminalClearMode.all);
        t.clearLine(mode: mode);
        return null;
      },
      'showCursor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal');
        final show = D4.getRequiredNamedArg<bool>(named, 'show', 'showCursor');
        t.showCursor(show: show);
        return null;
      },
      'cursorUp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal');
        t.cursorUp();
        return null;
      },
      'cursorDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal');
        t.cursorDown();
        return null;
      },
      'cursorLeft': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal');
        t.cursorLeft();
        return null;
      },
      'cursorRight': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal');
        t.cursorRight();
        return null;
      },
      'startOfLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal');
        t.startOfLine();
        return null;
      },
      'home': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_terminal_4.Terminal>(target, 'Terminal');
        t.home();
        return null;
      },
    },
    staticMethods: {
      'previousLine': (visitor, positional, named, typeArgs) {
        return $dcli_terminal_4.Terminal.previousLine();
      },
    },
    constructorSignatures: {
      '': 'factory Terminal()',
    },
    methodSignatures: {
      'clearScreen': 'void clearScreen({TerminalClearMode mode = TerminalClearMode.all})',
      'overwriteLine': 'void overwriteLine(String text)',
      'write': 'void write(String text)',
      'writeLine': 'void writeLine(String text, {TextAlignment alignment = TextAlignment.left})',
      'clearLine': 'void clearLine({TerminalClearMode mode = TerminalClearMode.all})',
      'showCursor': 'void showCursor({required bool show})',
      'cursorUp': 'void cursorUp()',
      'cursorDown': 'void cursorDown()',
      'cursorLeft': 'void cursorLeft()',
      'cursorRight': 'void cursorRight()',
      'startOfLine': 'void startOfLine()',
      'home': 'void home()',
    },
    getterSignatures: {
      'isAnsi': 'bool get isAnsi',
      'column': 'int get column',
      'columns': 'int get columns',
      'row': 'int get row',
      'hasTerminal': 'bool get hasTerminal',
      'rows': 'int get rows',
      'lines': 'int get lines',
    },
    setterSignatures: {
      'column': 'set column(int value)',
      'row': 'set row(int value)',
    },
    staticMethodSignatures: {
      'previousLine': 'void previousLine()',
    },
  );
}

// =============================================================================
// Ask Bridge
// =============================================================================

BridgedClass _createAskBridge() {
  return BridgedClass(
    nativeType: $dcli_1.Ask,
    name: 'Ask',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_1.Ask();
      },
    },
    staticGetters: {
      'dontCare': (visitor) => $dcli_1.Ask.dontCare,
      'required': (visitor) => $dcli_1.Ask.required,
      'email': (visitor) => $dcli_1.Ask.email,
      'fqdn': (visitor) => $dcli_1.Ask.fqdn,
      'date': (visitor) => $dcli_1.Ask.date,
      'integer': (visitor) => $dcli_1.Ask.integer,
      'decimal': (visitor) => $dcli_1.Ask.decimal,
      'alpha': (visitor) => $dcli_1.Ask.alpha,
      'alphaNumeric': (visitor) => $dcli_1.Ask.alphaNumeric,
    },
    staticMethods: {
      'defaultPrompt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'defaultPrompt');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'defaultPrompt');
        final defaultValue = D4.getRequiredArg<String?>(positional, 1, 'defaultValue', 'defaultPrompt');
        final hidden = D4.getRequiredArg<bool>(positional, 2, 'hidden', 'defaultPrompt');
        return $dcli_1.Ask.defaultPrompt(prompt, defaultValue, hidden);
      },
      'any': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'any');
        if (positional.isEmpty) {
          throw ArgumentError('any: Missing required argument "validators" at position 0');
        }
        final validators = D4.coerceList<$dcli_1.AskValidator>(positional[0], 'validators');
        return $dcli_1.Ask.any(validators);
      },
      'all': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'all');
        if (positional.isEmpty) {
          throw ArgumentError('all: Missing required argument "validators" at position 0');
        }
        final validators = D4.coerceList<$dcli_1.AskValidator>(positional[0], 'validators');
        return $dcli_1.Ask.all(validators);
      },
      'ipAddress': (visitor, positional, named, typeArgs) {
        final version = D4.getNamedArgWithDefault<int>(named, 'version', $aux_dcli.AskValidatorIPAddress.either);
        return $dcli_1.Ask.ipAddress(version: version);
      },
      'regExp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'regExp');
        final regExp = D4.getRequiredArg<String>(positional, 0, 'regExp', 'regExp');
        final error = D4.getOptionalNamedArg<String?>(named, 'error');
        return $dcli_1.Ask.regExp(regExp, error: error);
      },
      'lengthMax': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'lengthMax');
        final maxLength = D4.getRequiredArg<int>(positional, 0, 'maxLength', 'lengthMax');
        return $dcli_1.Ask.lengthMax(maxLength);
      },
      'lengthMin': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'lengthMin');
        final minLength = D4.getRequiredArg<int>(positional, 0, 'minLength', 'lengthMin');
        return $dcli_1.Ask.lengthMin(minLength);
      },
      'lengthRange': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'lengthRange');
        final minLength = D4.getRequiredArg<int>(positional, 0, 'minLength', 'lengthRange');
        final maxLength = D4.getRequiredArg<int>(positional, 1, 'maxLength', 'lengthRange');
        return $dcli_1.Ask.lengthRange(minLength, maxLength);
      },
      'valueRange': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'valueRange');
        final minValue = D4.getRequiredArg<num>(positional, 0, 'minValue', 'valueRange');
        final maxValue = D4.getRequiredArg<num>(positional, 1, 'maxValue', 'valueRange');
        return $dcli_1.Ask.valueRange(minValue, maxValue);
      },
      'inList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'inList');
        if (positional.isEmpty) {
          throw ArgumentError('inList: Missing required argument "validItems" at position 0');
        }
        final validItems = D4.coerceList<Object>(positional[0], 'validItems');
        final caseSensitive = D4.getNamedArgWithDefault<bool>(named, 'caseSensitive', false);
        return $dcli_1.Ask.inList(validItems, caseSensitive: caseSensitive);
      },
      'url': (visitor, positional, named, typeArgs) {
        final protocols = named.containsKey('protocols') && named['protocols'] != null
            ? D4.coerceList<String>(named['protocols'], 'protocols')
            : const ['https'];
        return $dcli_1.Ask.url(protocols: protocols);
      },
    },
    constructorSignatures: {
      '': 'Ask()',
    },
    staticMethodSignatures: {
      'defaultPrompt': 'String defaultPrompt(String prompt, String? defaultValue, bool hidden)',
      'any': 'AskValidator any(List<AskValidator> validators)',
      'all': 'AskValidator all(List<AskValidator> validators)',
      'ipAddress': 'AskValidator ipAddress({int version = AskValidatorIPAddress.either})',
      'regExp': 'AskValidator regExp(String regExp, {String? error})',
      'lengthMax': 'AskValidator lengthMax(int maxLength)',
      'lengthMin': 'AskValidator lengthMin(int minLength)',
      'lengthRange': 'AskValidator lengthRange(int minLength, int maxLength)',
      'valueRange': 'AskValidator valueRange(num minValue, num maxValue)',
      'inList': 'AskValidator inList(List<Object> validItems, {bool caseSensitive = false})',
      'url': 'AskValidator url({List<String> protocols = const [\'https\']})',
    },
    staticGetterSignatures: {
      'dontCare': 'AskValidator get dontCare',
      'required': 'AskValidator get required',
      'email': 'AskValidator get email',
      'fqdn': 'AskValidator get fqdn',
      'date': 'AskValidator get date',
      'integer': 'AskValidator get integer',
      'decimal': 'AskValidator get decimal',
      'alpha': 'AskValidator get alpha',
      'alphaNumeric': 'AskValidator get alphaNumeric',
    },
  );
}

// =============================================================================
// AskValidatorException Bridge
// =============================================================================

BridgedClass _createAskValidatorExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_1.AskValidatorException,
    name: 'AskValidatorException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AskValidatorException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'AskValidatorException');
        return $dcli_1.AskValidatorException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_1.AskValidatorException>(target, 'AskValidatorException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_1.AskValidatorException>(target, 'AskValidatorException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_1.AskValidatorException>(target, 'AskValidatorException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_1.AskValidatorException>(target, 'AskValidatorException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_1.AskValidatorException>(target, 'AskValidatorException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_1.AskValidatorException>(target, 'AskValidatorException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_1.AskValidatorException>(target, 'AskValidatorException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_1.AskValidatorException>(target, 'AskValidatorException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'AskValidatorException(dynamic message)',
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
// AskValidator Bridge
// =============================================================================

BridgedClass _createAskValidatorBridge() {
  return BridgedClass(
    nativeType: $dcli_1.AskValidator,
    name: 'AskValidator',
    constructors: {
    },
  );
}

// =============================================================================
// AskValidatorIPAddress Bridge
// =============================================================================

BridgedClass _createAskValidatorIPAddressBridge() {
  return BridgedClass(
    nativeType: $dcli_1.AskValidatorIPAddress,
    name: 'AskValidatorIPAddress',
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('version')) {
          return $dcli_1.AskValidatorIPAddress();
        }
        if (named.containsKey('version')) {
          final version = D4.getRequiredNamedArg<int>(named, 'version', 'AskValidatorIPAddress');
          return $dcli_1.AskValidatorIPAddress(version: version);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'version': (visitor, target) => D4.validateTarget<$dcli_1.AskValidatorIPAddress>(target, 'AskValidatorIPAddress').version,
    },
    methods: {
      'validate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_1.AskValidatorIPAddress>(target, 'AskValidatorIPAddress');
        D4.requireMinArgs(positional, 1, 'validate');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'validate');
        final customErrorMessage = D4.getOptionalNamedArg<String?>(named, 'customErrorMessage');
        return t.validate(line, customErrorMessage: customErrorMessage);
      },
    },
    staticGetters: {
      'either': (visitor) => $dcli_1.AskValidatorIPAddress.either,
      'ipv4': (visitor) => $dcli_1.AskValidatorIPAddress.ipv4,
      'ipv6': (visitor) => $dcli_1.AskValidatorIPAddress.ipv6,
    },
    constructorSignatures: {
      '': 'const AskValidatorIPAddress({int version = either})',
    },
    methodSignatures: {
      'validate': 'String validate(String line, {String? customErrorMessage})',
    },
    getterSignatures: {
      'version': 'int get version',
    },
    staticGetterSignatures: {
      'either': 'dynamic get either',
      'ipv4': 'dynamic get ipv4',
      'ipv6': 'dynamic get ipv6',
    },
  );
}

// =============================================================================
// Confirm Bridge
// =============================================================================

BridgedClass _createConfirmBridge() {
  return BridgedClass(
    nativeType: $dcli_3.Confirm,
    name: 'Confirm',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_3.Confirm();
      },
    },
    staticMethods: {
      'defaultPrompt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'defaultPrompt');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'defaultPrompt');
        final defaultValue = D4.getRequiredArg<bool?>(positional, 1, 'defaultValue', 'defaultPrompt');
        return $dcli_3.Confirm.defaultPrompt(prompt, defaultValue);
      },
    },
    constructorSignatures: {
      '': 'Confirm()',
    },
    staticMethodSignatures: {
      'defaultPrompt': 'String defaultPrompt(String prompt, bool? defaultValue)',
    },
  );
}

// =============================================================================
// FetchData Bridge
// =============================================================================

BridgedClass _createFetchDataBridge() {
  return BridgedClass(
    nativeType: $dcli_6.FetchData,
    name: 'FetchData',
    constructors: {
      'fromString': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FetchData');
        final string = D4.getRequiredArg<String>(positional, 0, 'string', 'FetchData');
        final mimeType = D4.getNamedArgWithDefault<String>(named, 'mimeType', 'text/plain');
        return $dcli_6.FetchData.fromString(string, mimeType: mimeType);
      },
      'fromFile': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FetchData');
        final pathToData = D4.getRequiredArg<String>(positional, 0, 'pathToData', 'FetchData');
        final mimeType = D4.getOptionalNamedArg<String?>(named, 'mimeType');
        return $dcli_6.FetchData.fromFile(pathToData, mimeType: mimeType);
      },
      'fromBytes': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FetchData');
        if (positional.isEmpty) {
          throw ArgumentError('FetchData: Missing required argument "bytes" at position 0');
        }
        final bytes = D4.coerceList<int>(positional[0], 'bytes');
        final mimeType = D4.getNamedArgWithDefault<String>(named, 'mimeType', 'application/octet-stream');
        return $dcli_6.FetchData.fromBytes(bytes, mimeType: mimeType);
      },
      'fromStream': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FetchData');
        final stream = D4.getRequiredArg<Stream<List<int>>>(positional, 0, 'stream', 'FetchData');
        final mimeType = D4.getNamedArgWithDefault<String>(named, 'mimeType', 'application/octet-stream');
        return $dcli_6.FetchData.fromStream(stream, mimeType: mimeType);
      },
    },
    getters: {
      'mimeType': (visitor, target) => D4.validateTarget<$dcli_6.FetchData>(target, 'FetchData').mimeType,
    },
    constructorSignatures: {
      'fromString': 'FetchData.fromString(String string, {String mimeType = \'text/plain\'})',
      'fromFile': 'FetchData.fromFile(String pathToData, {String? mimeType})',
      'fromBytes': 'FetchData.fromBytes(List<int> bytes, {String mimeType = \'application/octet-stream\'})',
      'fromStream': 'FetchData.fromStream(Stream<List<int>> stream, {String mimeType = \'application/octet-stream\'})',
    },
    getterSignatures: {
      'mimeType': 'String get mimeType',
    },
  );
}

// =============================================================================
// FetchUrl Bridge
// =============================================================================

BridgedClass _createFetchUrlBridge() {
  return BridgedClass(
    nativeType: $dcli_6.FetchUrl,
    name: 'FetchUrl',
    constructors: {
      '': (visitor, positional, named) {
        final url = D4.getRequiredNamedArg<String>(named, 'url', 'FetchUrl');
        final saveToPath = D4.getRequiredNamedArg<String>(named, 'saveToPath', 'FetchUrl');
        final headers = D4.coerceMapOrNull<String, String>(named['headers'], 'headers');
        final method = D4.getNamedArgWithDefault<$dcli_6.FetchMethod>(named, 'method', $dcli_6.FetchMethod.get);
        final data = D4.getOptionalNamedArg<$dcli_6.FetchData?>(named, 'data');
        if (!named.containsKey('progress')) {
          return $dcli_6.FetchUrl(url: url, saveToPath: saveToPath, headers: headers, method: method, data: data);
        }
        if (named.containsKey('progress')) {
          final progressRaw = named['progress'];
          final progress = ($dcli_6.FetchProgress p0) { D4.callInterpreterCallback(visitor, progressRaw, [p0]); };
          return $dcli_6.FetchUrl(url: url, saveToPath: saveToPath, headers: headers, method: method, data: data, progress: progress);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'url': (visitor, target) => D4.validateTarget<$dcli_6.FetchUrl>(target, 'FetchUrl').url,
      'saveToPath': (visitor, target) => D4.validateTarget<$dcli_6.FetchUrl>(target, 'FetchUrl').saveToPath,
      'progress': (visitor, target) => D4.validateTarget<$dcli_6.FetchUrl>(target, 'FetchUrl').progress,
      'method': (visitor, target) => D4.validateTarget<$dcli_6.FetchUrl>(target, 'FetchUrl').method,
      'headers': (visitor, target) => D4.validateTarget<$dcli_6.FetchUrl>(target, 'FetchUrl').headers,
      'data': (visitor, target) => D4.validateTarget<$dcli_6.FetchUrl>(target, 'FetchUrl').data,
    },
    setters: {
      'headers': (visitor, target, value) => 
        D4.validateTarget<$dcli_6.FetchUrl>(target, 'FetchUrl').headers = (value as Map).cast<String, String>(),
      'data': (visitor, target, value) => 
        D4.validateTarget<$dcli_6.FetchUrl>(target, 'FetchUrl').data = value as $dcli_6.FetchData?,
    },
    constructorSignatures: {
      '': 'FetchUrl({required String url, required String saveToPath, Map<String, String>? headers, FetchMethod method = FetchMethod.get, void Function(FetchProgress) progress = _devNull, FetchData? data})',
    },
    getterSignatures: {
      'url': 'String get url',
      'saveToPath': 'String get saveToPath',
      'progress': 'OnFetchProgress get progress',
      'method': 'FetchMethod get method',
      'headers': 'Map<String, String> get headers',
      'data': 'FetchData? get data',
    },
    setterSignatures: {
      'headers': 'set headers(dynamic value)',
      'data': 'set data(dynamic value)',
    },
  );
}

// =============================================================================
// FetchProgress Bridge
// =============================================================================

BridgedClass _createFetchProgressBridge() {
  return BridgedClass(
    nativeType: $dcli_6.FetchProgress,
    name: 'FetchProgress',
    constructors: {
    },
    getters: {
      'headers': (visitor, target) => D4.validateTarget<$dcli_6.FetchProgress>(target, 'FetchProgress').headers,
      'responseCode': (visitor, target) => D4.validateTarget<$dcli_6.FetchProgress>(target, 'FetchProgress').responseCode,
      'status': (visitor, target) => D4.validateTarget<$dcli_6.FetchProgress>(target, 'FetchProgress').status,
      'fetch': (visitor, target) => D4.validateTarget<$dcli_6.FetchProgress>(target, 'FetchProgress').fetch,
      'length': (visitor, target) => D4.validateTarget<$dcli_6.FetchProgress>(target, 'FetchProgress').length,
      'downloaded': (visitor, target) => D4.validateTarget<$dcli_6.FetchProgress>(target, 'FetchProgress').downloaded,
      'progress': (visitor, target) => D4.validateTarget<$dcli_6.FetchProgress>(target, 'FetchProgress').progress,
      'prior': (visitor, target) => D4.validateTarget<$dcli_6.FetchProgress>(target, 'FetchProgress').prior,
    },
    setters: {
      'prior': (visitor, target, value) => 
        D4.validateTarget<$dcli_6.FetchProgress>(target, 'FetchProgress').prior = value as $dcli_6.FetchProgress?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_6.FetchProgress>(target, 'FetchProgress');
        return t.toString();
      },
    },
    staticMethods: {
      'showBytes': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'showBytes');
        final progress = D4.getRequiredArg<$dcli_6.FetchProgress>(positional, 0, 'progress', 'showBytes');
        return $dcli_6.FetchProgress.showBytes(progress);
      },
      'show': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'show');
        final progress = D4.getRequiredArg<$dcli_6.FetchProgress>(positional, 0, 'progress', 'show');
        final formatRaw = named['format'];
        final format = formatRaw == null ? null : ($dcli_6.FetchProgress p0) { return D4.callInterpreterCallback(visitor, formatRaw, [p0]) as String; };
        return $dcli_6.FetchProgress.show(progress, format: format);
      },
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'headers': 'Map<String, List<String>>? get headers',
      'responseCode': 'int? get responseCode',
      'status': 'FetchStatus get status',
      'fetch': 'FetchUrl get fetch',
      'length': 'int get length',
      'downloaded': 'int get downloaded',
      'progress': 'double get progress',
      'prior': 'FetchProgress? get prior',
    },
    setterSignatures: {
      'prior': 'set prior(dynamic value)',
    },
    staticMethodSignatures: {
      'showBytes': 'void showBytes(FetchProgress progress)',
      'show': 'void show(FetchProgress progress, {String Function(FetchProgress progress)? format})',
    },
  );
}

// =============================================================================
// FetchException Bridge
// =============================================================================

BridgedClass _createFetchExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_6.FetchException,
    name: 'FetchException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FetchException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'FetchException');
        return $dcli_6.FetchException(message);
      },
      'fromException': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FetchException');
        final cause = D4.getRequiredArg<SocketException>(positional, 0, 'cause', 'FetchException');
        return $dcli_6.FetchException.fromException(cause);
      },
      'fromHttpError': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FetchException');
        final errorCode = D4.getRequiredArg<int?>(positional, 0, 'errorCode', 'FetchException');
        final reasonPhrase = D4.getRequiredArg<String>(positional, 1, 'reasonPhrase', 'FetchException');
        return $dcli_6.FetchException.fromHttpError(errorCode, reasonPhrase);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_6.FetchException>(target, 'FetchException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_6.FetchException>(target, 'FetchException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_6.FetchException>(target, 'FetchException').stackTrace,
      'errorCode': (visitor, target) => D4.validateTarget<$dcli_6.FetchException>(target, 'FetchException').errorCode,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_6.FetchException>(target, 'FetchException').stackTrace = value as dynamic,
      'errorCode': (visitor, target, value) => 
        D4.validateTarget<$dcli_6.FetchException>(target, 'FetchException').errorCode = value as int?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_6.FetchException>(target, 'FetchException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_6.FetchException>(target, 'FetchException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_6.FetchException>(target, 'FetchException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_6.FetchException>(target, 'FetchException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'FetchException(dynamic message)',
      'fromException': 'FetchException.fromException(SocketException cause)',
      'fromHttpError': 'FetchException.fromHttpError(int? errorCode, String reasonPhrase)',
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
      'errorCode': 'int? get errorCode',
    },
    setterSignatures: {
      'stackTrace': 'set stackTrace(dynamic value)',
      'errorCode': 'set errorCode(dynamic value)',
    },
  );
}

// =============================================================================
// ReadException Bridge
// =============================================================================

BridgedClass _createReadExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_12.ReadException,
    name: 'ReadException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ReadException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'ReadException');
        final stacktrace = D4.getOptionalArg<dynamic>(positional, 1, 'stacktrace');
        return $dcli_12.ReadException(message, stacktrace);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_12.ReadException>(target, 'ReadException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_12.ReadException>(target, 'ReadException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_12.ReadException>(target, 'ReadException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_12.ReadException>(target, 'ReadException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_12.ReadException>(target, 'ReadException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_12.ReadException>(target, 'ReadException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_12.ReadException>(target, 'ReadException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_12.ReadException>(target, 'ReadException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'ReadException(dynamic message, [dynamic stacktrace])',
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
// Progress Bridge
// =============================================================================

BridgedClass _createProgressBridge() {
  return BridgedClass(
    nativeType: $dcli_18.Progress,
    name: 'Progress',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Progress');
        if (positional.isEmpty) {
          throw ArgumentError('Progress: Missing required argument "stdout" at position 0');
        }
        final stdoutRaw = positional[0];
        final captureStdout = D4.getNamedArgWithDefault<bool>(named, 'captureStdout', false);
        final captureStderr = D4.getNamedArgWithDefault<bool>(named, 'captureStderr', false);
        if (!named.containsKey('stderr') && !named.containsKey('encoding')) {
          return $dcli_18.Progress((String p0) { D4.callInterpreterCallback(visitor, stdoutRaw, [p0]); }, captureStdout: captureStdout, captureStderr: captureStderr);
        }
        if (named.containsKey('stderr') && !named.containsKey('encoding')) {
          final stderr = D4.getRequiredNamedArg<dynamic>(named, 'stderr', 'Progress');
          return $dcli_18.Progress((String p0) { D4.callInterpreterCallback(visitor, stdoutRaw, [p0]); }, captureStdout: captureStdout, captureStderr: captureStderr, stderr: stderr);
        }
        if (!named.containsKey('stderr') && named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $dcli_18.Progress((String p0) { D4.callInterpreterCallback(visitor, stdoutRaw, [p0]); }, captureStdout: captureStdout, captureStderr: captureStderr, encoding: encoding);
        }
        if (named.containsKey('stderr') && named.containsKey('encoding')) {
          final stderr = D4.getRequiredNamedArg<dynamic>(named, 'stderr', 'Progress');
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $dcli_18.Progress((String p0) { D4.callInterpreterCallback(visitor, stdoutRaw, [p0]); }, captureStdout: captureStdout, captureStderr: captureStderr, stderr: stderr, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'print': (visitor, positional, named) {
        final capture = D4.getNamedArgWithDefault<bool>(named, 'capture', false);
        if (!named.containsKey('encoding')) {
          return $dcli_18.Progress.print(capture: capture);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $dcli_18.Progress.print(capture: capture, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'both': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Progress');
        if (positional.isEmpty) {
          throw ArgumentError('Progress: Missing required argument "both" at position 0');
        }
        final bothRaw = positional[0];
        if (!named.containsKey('encoding')) {
          return $dcli_18.Progress.both((String p0) { D4.callInterpreterCallback(visitor, bothRaw, [p0]); });
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $dcli_18.Progress.both((String p0) { D4.callInterpreterCallback(visitor, bothRaw, [p0]); }, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'capture': (visitor, positional, named) {
        final captureStdout = D4.getNamedArgWithDefault<bool>(named, 'captureStdout', true);
        final captureStderr = D4.getNamedArgWithDefault<bool>(named, 'captureStderr', true);
        if (!named.containsKey('encoding')) {
          return $dcli_18.Progress.capture(captureStdout: captureStdout, captureStderr: captureStderr);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $dcli_18.Progress.capture(captureStdout: captureStdout, captureStderr: captureStderr, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'devNull': (visitor, positional, named) {
        if (!named.containsKey('encoding')) {
          return $dcli_18.Progress.devNull();
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $dcli_18.Progress.devNull(encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'printStdErr': (visitor, positional, named) {
        final capture = D4.getNamedArgWithDefault<bool>(named, 'capture', false);
        if (!named.containsKey('encoding')) {
          return $dcli_18.Progress.printStdErr(capture: capture);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $dcli_18.Progress.printStdErr(capture: capture, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'printStdOut': (visitor, positional, named) {
        final capture = D4.getNamedArgWithDefault<bool>(named, 'capture', false);
        if (!named.containsKey('encoding')) {
          return $dcli_18.Progress.printStdOut(capture: capture);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $dcli_18.Progress.printStdOut(capture: capture, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'stream': (visitor, positional, named) {
        final includeStderr = D4.getNamedArgWithDefault<bool>(named, 'includeStderr', false);
        if (!named.containsKey('encoding')) {
          return $dcli_18.Progress.stream(includeStderr: includeStderr);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $dcli_18.Progress.stream(includeStderr: includeStderr, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'exitCode': (visitor, target) => D4.validateTarget<$dcli_18.Progress>(target, 'Progress').exitCode,
      'lines': (visitor, target) => D4.validateTarget<$dcli_18.Progress>(target, 'Progress').lines,
      'stream': (visitor, target) => D4.validateTarget<$dcli_18.Progress>(target, 'Progress').stream,
      'firstLine': (visitor, target) => D4.validateTarget<$dcli_18.Progress>(target, 'Progress').firstLine,
    },
    methods: {
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_18.Progress>(target, 'Progress');
        return t.toList();
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_18.Progress>(target, 'Progress');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "print" at position 0');
        }
        final printRaw = positional[0];
        t.forEach((String p0) { D4.callInterpreterCallback(visitor, printRaw, [p0]); });
        return null;
      },
      'toParagraph': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_18.Progress>(target, 'Progress');
        return t.toParagraph();
      },
    },
    constructorSignatures: {
      '': 'factory Progress(LineAction stdout, {LineAction stderr = devNull, bool captureStdout = false, bool captureStderr = false, Encoding encoding = utf8})',
      'print': 'factory Progress.print({bool capture = false, Encoding encoding = utf8})',
      'both': 'factory Progress.both(LineAction both, {Encoding encoding = utf8})',
      'capture': 'factory Progress.capture({bool captureStdout = true, bool captureStderr = true, Encoding encoding = utf8})',
      'devNull': 'factory Progress.devNull({Encoding encoding = utf8})',
      'printStdErr': 'factory Progress.printStdErr({bool capture = false, Encoding encoding = utf8})',
      'printStdOut': 'factory Progress.printStdOut({bool capture = false, Encoding encoding = utf8})',
      'stream': 'factory Progress.stream({bool includeStderr = false, Encoding encoding = utf8})',
    },
    methodSignatures: {
      'toList': 'List<String> toList()',
      'forEach': 'void forEach(void Function(String line) print)',
      'toParagraph': 'String toParagraph()',
    },
    getterSignatures: {
      'exitCode': 'int? get exitCode',
      'lines': 'List<String> get lines',
      'stream': 'Stream<List<int>> get stream',
      'firstLine': 'String? get firstLine',
    },
  );
}

// =============================================================================
// PackedResource Bridge
// =============================================================================

BridgedClass _createPackedResourceBridge() {
  return BridgedClass(
    nativeType: $dcli_19.PackedResource,
    name: 'PackedResource',
    constructors: {
    },
    getters: {
      'content': (visitor, target) => D4.validateTarget<$dcli_19.PackedResource>(target, 'PackedResource').content,
      'checksum': (visitor, target) => D4.validateTarget<$dcli_19.PackedResource>(target, 'PackedResource').checksum,
      'originalPath': (visitor, target) => D4.validateTarget<$dcli_19.PackedResource>(target, 'PackedResource').originalPath,
    },
    methods: {
      'unpack': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_19.PackedResource>(target, 'PackedResource');
        D4.requireMinArgs(positional, 1, 'unpack');
        final pathTo = D4.getRequiredArg<String>(positional, 0, 'pathTo', 'unpack');
        t.unpack(pathTo);
        return null;
      },
    },
    methodSignatures: {
      'unpack': 'void unpack(String pathTo)',
    },
    getterSignatures: {
      'content': 'String get content',
      'checksum': 'String get checksum',
      'originalPath': 'String get originalPath',
    },
  );
}

// =============================================================================
// Resources Bridge
// =============================================================================

BridgedClass _createResourcesBridge() {
  return BridgedClass(
    nativeType: $dcli_20.Resources,
    name: 'Resources',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_20.Resources();
      },
    },
    getters: {
      'pathToRegistry': (visitor, target) => D4.validateTarget<$dcli_20.Resources>(target, 'Resources').pathToRegistry,
      'resourceRoot': (visitor, target) => D4.validateTarget<$dcli_20.Resources>(target, 'Resources').resourceRoot,
      'generatedRoot': (visitor, target) => D4.validateTarget<$dcli_20.Resources>(target, 'Resources').generatedRoot,
    },
    methods: {
      'pack': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_20.Resources>(target, 'Resources');
        t.pack();
        return null;
      },
      'isExcluded': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_20.Resources>(target, 'Resources');
        D4.requireMinArgs(positional, 2, 'isExcluded');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isExcluded');
        if (positional.length <= 1) {
          throw ArgumentError('isExcluded: Missing required argument "excludes" at position 1');
        }
        final excludes = D4.coerceList<String>(positional[1], 'excludes');
        return t.isExcluded(path, excludes);
      },
      'getExcludedPaths': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_20.Resources>(target, 'Resources');
        D4.requireMinArgs(positional, 3, 'getExcludedPaths');
        final yaml = D4.getRequiredArg<dynamic>(positional, 0, 'yaml', 'getExcludedPaths');
        final path = D4.getRequiredArg<String>(positional, 1, 'path', 'getExcludedPaths');
        final index = D4.getRequiredArg<int>(positional, 2, 'index', 'getExcludedPaths');
        return t.getExcludedPaths(yaml, path, index);
      },
    },
    staticGetters: {
      'pathToPackYaml': (visitor) => $dcli_20.Resources.pathToPackYaml,
      'scopeKeyProjectRoot': (visitor) => $dcli_20.Resources.scopeKeyProjectRoot,
      'projectRoot': (visitor) => $dcli_20.Resources.projectRoot,
    },
    constructorSignatures: {
      '': 'Resources()',
    },
    methodSignatures: {
      'pack': 'void pack()',
      'isExcluded': 'bool isExcluded(String path, List<String> excludes)',
      'getExcludedPaths': 'List<String> getExcludedPaths(SettingsYaml yaml, String path, int index)',
    },
    getterSignatures: {
      'pathToRegistry': 'String get pathToRegistry',
      'resourceRoot': 'String get resourceRoot',
      'generatedRoot': 'String get generatedRoot',
    },
    staticGetterSignatures: {
      'pathToPackYaml': 'String get pathToPackYaml',
      'scopeKeyProjectRoot': 'dynamic get scopeKeyProjectRoot',
      'projectRoot': 'String get projectRoot',
    },
  );
}

// =============================================================================
// ResourceException Bridge
// =============================================================================

BridgedClass _createResourceExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_20.ResourceException,
    name: 'ResourceException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ResourceException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'ResourceException');
        return $dcli_20.ResourceException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_20.ResourceException>(target, 'ResourceException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_20.ResourceException>(target, 'ResourceException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_20.ResourceException>(target, 'ResourceException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_20.ResourceException>(target, 'ResourceException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_20.ResourceException>(target, 'ResourceException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_20.ResourceException>(target, 'ResourceException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_20.ResourceException>(target, 'ResourceException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_20.ResourceException>(target, 'ResourceException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'ResourceException(dynamic message)',
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
// DartProject Bridge
// =============================================================================

BridgedClass _createDartProjectBridge() {
  return BridgedClass(
    nativeType: $dcli_21.DartProject,
    name: 'DartProject',
    constructors: {
      'create': (visitor, positional, named) {
        final pathTo = D4.getRequiredNamedArg<String>(named, 'pathTo', 'DartProject');
        final templateName = D4.getRequiredNamedArg<String>(named, 'templateName', 'DartProject');
        return $dcli_21.DartProject.create(pathTo: pathTo, templateName: templateName);
      },
      'fromCache': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DartProject');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DartProject');
        final version = D4.getRequiredArg<String>(positional, 1, 'version', 'DartProject');
        return $dcli_21.DartProject.fromCache(name, version);
      },
      'fromPath': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DartProject');
        final pathToSearchFrom = D4.getRequiredArg<String>(positional, 0, 'pathToSearchFrom', 'DartProject');
        final search = D4.getNamedArgWithDefault<bool>(named, 'search', true);
        return $dcli_21.DartProject.fromPath(pathToSearchFrom, search: search);
      },
    },
    getters: {
      'pubSpec': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pubSpec,
      'pathToProjectRoot': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pathToProjectRoot,
      'pathToDartToolDir': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pathToDartToolDir,
      'pathToDartToolPackageConfig': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pathToDartToolPackageConfig,
      'pathToBinDir': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pathToBinDir,
      'pathToExampleDir': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pathToExampleDir,
      'pathToLibDir': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pathToLibDir,
      'pathToLibSrcDir': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pathToLibSrcDir,
      'pathToTestDir': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pathToTestDir,
      'pathToToolDir': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pathToToolDir,
      'pathToAnalysisOptions': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pathToAnalysisOptions,
      'pathToPubSpec': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pathToPubSpec,
      'pathToPubSpecLock': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').pathToPubSpecLock,
      'isReadyToRun': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').isReadyToRun,
      'isFlutterProject': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').isFlutterProject,
      'hasPubSpec': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').hasPubSpec,
      'hasAnalysisOptions': (visitor, target) => D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject').hasAnalysisOptions,
    },
    methods: {
      'doctor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject');
        t.doctor();
        return null;
      },
      'warmup': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject');
        final background = D4.getNamedArgWithDefault<bool>(named, 'background', false);
        final upgrade = D4.getNamedArgWithDefault<bool>(named, 'upgrade', false);
        return t.warmup(background: background, upgrade: upgrade);
      },
      'clean': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject');
        return t.clean();
      },
      'compile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.DartProject>(target, 'DartProject');
        final install = D4.getNamedArgWithDefault<bool>(named, 'install', false);
        final overwrite = D4.getNamedArgWithDefault<bool>(named, 'overwrite', false);
        return t.compile(install: install, overwrite: overwrite);
      },
    },
    staticGetters: {
      'current': (visitor) => $dcli_21.DartProject.current,
      'self': (visitor) => $dcli_21.DartProject.self,
    },
    staticMethods: {
      'findProject': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findProject');
        final pathToSearchFrom = D4.getRequiredArg<String>(positional, 0, 'pathToSearchFrom', 'findProject');
        final search = D4.getNamedArgWithDefault<bool>(named, 'search', true);
        return $dcli_21.DartProject.findProject(pathToSearchFrom, search: search);
      },
    },
    constructorSignatures: {
      'create': 'factory DartProject.create({required String pathTo, required String templateName})',
      'fromCache': 'DartProject.fromCache(String name, String version)',
      'fromPath': 'DartProject.fromPath(String pathToSearchFrom, {bool search = true})',
    },
    methodSignatures: {
      'doctor': 'void doctor()',
      'warmup': 'Future<void> warmup({bool background = false, bool upgrade = false})',
      'clean': 'Future<void> clean()',
      'compile': 'Future<void> compile({bool install = false, bool overwrite = false})',
    },
    getterSignatures: {
      'pubSpec': 'PubSpec get pubSpec',
      'pathToProjectRoot': 'String get pathToProjectRoot',
      'pathToDartToolDir': 'String get pathToDartToolDir',
      'pathToDartToolPackageConfig': 'String get pathToDartToolPackageConfig',
      'pathToBinDir': 'String get pathToBinDir',
      'pathToExampleDir': 'String get pathToExampleDir',
      'pathToLibDir': 'String get pathToLibDir',
      'pathToLibSrcDir': 'String get pathToLibSrcDir',
      'pathToTestDir': 'String get pathToTestDir',
      'pathToToolDir': 'String get pathToToolDir',
      'pathToAnalysisOptions': 'String get pathToAnalysisOptions',
      'pathToPubSpec': 'String get pathToPubSpec',
      'pathToPubSpecLock': 'String get pathToPubSpecLock',
      'isReadyToRun': 'bool get isReadyToRun',
      'isFlutterProject': 'bool get isFlutterProject',
      'hasPubSpec': 'bool get hasPubSpec',
      'hasAnalysisOptions': 'bool get hasAnalysisOptions',
    },
    staticMethodSignatures: {
      'findProject': 'DartProject? findProject(String pathToSearchFrom, {bool search = true})',
    },
    staticGetterSignatures: {
      'current': 'DartProject get current',
      'self': 'DartProject get self',
    },
  );
}

// =============================================================================
// DartProjectException Bridge
// =============================================================================

BridgedClass _createDartProjectExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_21.DartProjectException,
    name: 'DartProjectException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DartProjectException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'DartProjectException');
        return $dcli_21.DartProjectException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_21.DartProjectException>(target, 'DartProjectException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_21.DartProjectException>(target, 'DartProjectException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_21.DartProjectException>(target, 'DartProjectException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_21.DartProjectException>(target, 'DartProjectException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.DartProjectException>(target, 'DartProjectException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.DartProjectException>(target, 'DartProjectException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.DartProjectException>(target, 'DartProjectException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.DartProjectException>(target, 'DartProjectException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'DartProjectException(dynamic message)',
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
// TemplateNotFoundException Bridge
// =============================================================================

BridgedClass _createTemplateNotFoundExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_21.TemplateNotFoundException,
    name: 'TemplateNotFoundException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TemplateNotFoundException');
        final pathTo = D4.getRequiredArg<String>(positional, 0, 'pathTo', 'TemplateNotFoundException');
        return $dcli_21.TemplateNotFoundException(pathTo);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_21.TemplateNotFoundException>(target, 'TemplateNotFoundException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_21.TemplateNotFoundException>(target, 'TemplateNotFoundException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_21.TemplateNotFoundException>(target, 'TemplateNotFoundException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_21.TemplateNotFoundException>(target, 'TemplateNotFoundException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.TemplateNotFoundException>(target, 'TemplateNotFoundException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.TemplateNotFoundException>(target, 'TemplateNotFoundException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.TemplateNotFoundException>(target, 'TemplateNotFoundException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.TemplateNotFoundException>(target, 'TemplateNotFoundException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'TemplateNotFoundException(String pathTo)',
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
// InvalidProjectTemplateException Bridge
// =============================================================================

BridgedClass _createInvalidProjectTemplateExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_21.InvalidProjectTemplateException,
    name: 'InvalidProjectTemplateException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InvalidProjectTemplateException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'InvalidProjectTemplateException');
        return $dcli_21.InvalidProjectTemplateException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_21.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_21.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_21.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_21.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_21.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'InvalidProjectTemplateException(dynamic message)',
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
// DartScript Bridge
// =============================================================================

BridgedClass _createDartScriptBridge() {
  return BridgedClass(
    nativeType: $dcli_22.DartScript,
    name: 'DartScript',
    constructors: {
      'createScript': (visitor, positional, named) {
        final project = D4.getRequiredNamedArg<$dcli_21.DartProject>(named, 'project', 'DartScript');
        final scriptName = D4.getRequiredNamedArg<String>(named, 'scriptName', 'DartScript');
        final templateName = D4.getRequiredNamedArg<String>(named, 'templateName', 'DartScript');
        return $dcli_22.DartScript.createScript(project: project, scriptName: scriptName, templateName: templateName);
      },
      'fromFile': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DartScript');
        final scriptPathTo = D4.getRequiredArg<String>(positional, 0, 'scriptPathTo', 'DartScript');
        final project = D4.getOptionalNamedArg<$dcli_21.DartProject?>(named, 'project');
        return $dcli_22.DartScript.fromFile(scriptPathTo, project: project);
      },
    },
    getters: {
      'pathToScript': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').pathToScript,
      'scriptName': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').scriptName,
      'pathToScriptDirectory': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').pathToScriptDirectory,
      'pubsecNameKey': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').pubsecNameKey,
      'basename': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').basename,
      'pathToPubSpec': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').pathToPubSpec,
      'isReadyToRun': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').isReadyToRun,
      'isCompiled': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').isCompiled,
      'isInstalled': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').isInstalled,
      'isPubGlobalActivated': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').isPubGlobalActivated,
      'pathToProjectRoot': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').pathToProjectRoot,
      'project': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').project,
      'doctor': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').doctor,
      'pubSpec': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').pubSpec,
      'exeName': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').exeName,
      'pathToExe': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').pathToExe,
      'pathToInstalledExe': (visitor, target) => D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript').pathToInstalledExe,
    },
    methods: {
      'compile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript');
        final install = D4.getNamedArgWithDefault<bool>(named, 'install', false);
        final overwrite = D4.getNamedArgWithDefault<bool>(named, 'overwrite', false);
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        t.compile(install: install, overwrite: overwrite, workingDirectory: workingDirectory);
        return null;
      },
      'run': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript');
        final args = named.containsKey('args') && named['args'] != null
            ? D4.coerceList<String>(named['args'], 'args')
            : const <String>[];
        return t.run(args: args);
      },
      'start': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript');
        final args = named.containsKey('args') && named['args'] != null
            ? D4.coerceList<String>(named['args'], 'args')
            : const <String>[];
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        final runInShell = D4.getNamedArgWithDefault<bool>(named, 'runInShell', false);
        final detached = D4.getNamedArgWithDefault<bool>(named, 'detached', false);
        final terminal = D4.getNamedArgWithDefault<bool>(named, 'terminal', false);
        final privileged = D4.getNamedArgWithDefault<bool>(named, 'privileged', false);
        final nothrow = D4.getNamedArgWithDefault<bool>(named, 'nothrow', false);
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final extensionSearch = D4.getNamedArgWithDefault<bool>(named, 'extensionSearch', true);
        return t.start(args: args, progress: progress, runInShell: runInShell, detached: detached, terminal: terminal, privileged: privileged, nothrow: nothrow, workingDirectory: workingDirectory, extensionSearch: extensionSearch);
      },
      'runPubGet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_22.DartScript>(target, 'DartScript');
        t.runPubGet();
        return null;
      },
    },
    staticGetters: {
      'self': (visitor) => $dcli_22.DartScript.self,
      'current': (visitor) => $dcli_22.DartScript.current,
    },
    staticMethods: {
      'sansRoot': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'sansRoot');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'sansRoot');
        return $dcli_22.DartScript.sansRoot(path);
      },
    },
    constructorSignatures: {
      'createScript': 'factory DartScript.createScript({required DartProject project, required String scriptName, required String templateName})',
      'fromFile': 'DartScript.fromFile(String scriptPathTo, {DartProject? project})',
    },
    methodSignatures: {
      'compile': 'void compile({bool install = false, bool overwrite = false, String? workingDirectory})',
      'run': 'int run({List<String> args = const <String>[]})',
      'start': 'Progress start({List<String> args = const <String>[], Progress? progress, bool runInShell = false, bool detached = false, bool terminal = false, bool privileged = false, bool nothrow = false, String? workingDirectory, bool extensionSearch = true})',
      'runPubGet': 'void runPubGet()',
    },
    getterSignatures: {
      'pathToScript': 'String get pathToScript',
      'scriptName': 'String get scriptName',
      'pathToScriptDirectory': 'String get pathToScriptDirectory',
      'pubsecNameKey': 'String get pubsecNameKey',
      'basename': 'String get basename',
      'pathToPubSpec': 'String get pathToPubSpec',
      'isReadyToRun': 'bool get isReadyToRun',
      'isCompiled': 'bool get isCompiled',
      'isInstalled': 'bool get isInstalled',
      'isPubGlobalActivated': 'bool get isPubGlobalActivated',
      'pathToProjectRoot': 'String get pathToProjectRoot',
      'project': 'DartProject get project',
      'doctor': 'void get doctor',
      'pubSpec': 'PubSpec get pubSpec',
      'exeName': 'String get exeName',
      'pathToExe': 'String get pathToExe',
      'pathToInstalledExe': 'String get pathToInstalledExe',
    },
    staticMethodSignatures: {
      'sansRoot': 'String sansRoot(String path)',
    },
    staticGetterSignatures: {
      'self': 'DartScript get self',
      'current': 'DartScript get current',
    },
  );
}

// =============================================================================
// DartSdk Bridge
// =============================================================================

BridgedClass _createDartSdkBridge() {
  return BridgedClass(
    nativeType: $dcli_23.DartSdk,
    name: 'DartSdk',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_23.DartSdk();
      },
    },
    getters: {
      'pathToSdk': (visitor, target) => D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk').pathToSdk,
      'pathToDartExe': (visitor, target) => D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk').pathToDartExe,
      'pathToPubExe': (visitor, target) => D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk').pathToPubExe,
      'pathToDartToNativeExe': (visitor, target) => D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk').pathToDartToNativeExe,
      'versionMajor': (visitor, target) => D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk').versionMajor,
      'versionMinor': (visitor, target) => D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk').versionMinor,
      'useDartCommand': (visitor, target) => D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk').useDartCommand,
      'useDartDocCommand': (visitor, target) => D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk').useDartDocCommand,
      'version': (visitor, target) => D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk').version,
      'pathToPackageConfig': (visitor, target) => D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk').pathToPackageConfig,
    },
    methods: {
      'getVersion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        return t.getVersion();
      },
      'runDartCompiler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'runDartCompiler');
        final script = D4.getRequiredArg<$dcli_22.DartScript>(positional, 0, 'script', 'runDartCompiler');
        final pathToExe = D4.getRequiredNamedArg<String>(named, 'pathToExe', 'runDartCompiler');
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        t.runDartCompiler(script, pathToExe: pathToExe, progress: progress, workingDirectory: workingDirectory);
        return null;
      },
      'run': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        if (!named.containsKey('args') || named['args'] == null) {
          throw ArgumentError('run: Missing required named argument "args"');
        }
        final args = D4.coerceList<String>(named['args'], 'args');
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        final detached = D4.getNamedArgWithDefault<bool>(named, 'detached', false);
        final terminal = D4.getNamedArgWithDefault<bool>(named, 'terminal', false);
        final nothrow = D4.getNamedArgWithDefault<bool>(named, 'nothrow', false);
        return t.run(args: args, workingDirectory: workingDirectory, progress: progress, detached: detached, terminal: terminal, nothrow: nothrow);
      },
      'runPub': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        if (!named.containsKey('args') || named['args'] == null) {
          throw ArgumentError('runPub: Missing required named argument "args"');
        }
        final args = D4.coerceList<String>(named['args'], 'args');
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        final nothrow = D4.getNamedArgWithDefault<bool>(named, 'nothrow', false);
        return t.runPub(args: args, workingDirectory: workingDirectory, progress: progress, nothrow: nothrow);
      },
      'runDartDoc': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        final pathToProject = D4.getOptionalNamedArg<String?>(named, 'pathToProject');
        final pathToDoc = D4.getOptionalNamedArg<String?>(named, 'pathToDoc');
        final args = named.containsKey('args') && named['args'] != null
            ? D4.coerceList<String>(named['args'], 'args')
            : const <String>[];
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        final nothrow = D4.getNamedArgWithDefault<bool>(named, 'nothrow', false);
        return t.runDartDoc(pathToProject: pathToProject, pathToDoc: pathToDoc, args: args, progress: progress, nothrow: nothrow);
      },
      'isPubGetRequired': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'isPubGetRequired');
        final workingDirectory = D4.getRequiredArg<String>(positional, 0, 'workingDirectory', 'isPubGetRequired');
        return t.isPubGetRequired(workingDirectory);
      },
      'runPubGet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'runPubGet');
        final workingDirectory = D4.getRequiredArg<String?>(positional, 0, 'workingDirectory', 'runPubGet');
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        final compileExecutables = D4.getNamedArgWithDefault<bool>(named, 'compileExecutables', false);
        t.runPubGet(workingDirectory, progress: progress, compileExecutables: compileExecutables);
        return null;
      },
      'runPubUpgrade': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'runPubUpgrade');
        final workingDirectory = D4.getRequiredArg<String?>(positional, 0, 'workingDirectory', 'runPubUpgrade');
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        final compileExecutables = D4.getNamedArgWithDefault<bool>(named, 'compileExecutables', false);
        t.runPubUpgrade(workingDirectory, progress: progress, compileExecutables: compileExecutables);
        return null;
      },
      'installFromArchive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'installFromArchive');
        final defaultDartSdkPath = D4.getRequiredArg<String>(positional, 0, 'defaultDartSdkPath', 'installFromArchive');
        final askUser = D4.getNamedArgWithDefault<bool>(named, 'askUser', true);
        return t.installFromArchive(defaultDartSdkPath, askUser: askUser);
      },
      'resolveArchitecture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        return t.resolveArchitecture();
      },
      'globalActivate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'globalActivate');
        final package = D4.getRequiredArg<String>(positional, 0, 'package', 'globalActivate');
        t.globalActivate(package);
        return null;
      },
      'globalActivateFromPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'globalActivateFromPath');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'globalActivateFromPath');
        t.globalActivateFromPath(path);
        return null;
      },
      'globalDeactivate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'globalDeactivate');
        final package = D4.getRequiredArg<String>(positional, 0, 'package', 'globalDeactivate');
        t.globalDeactivate(package);
        return null;
      },
      'isPackageGloballyActivated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'isPackageGloballyActivated');
        final package = D4.getRequiredArg<String>(positional, 0, 'package', 'isPackageGloballyActivated');
        return t.isPackageGloballyActivated(package);
      },
      'isPackageGlobalActivateFromPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_23.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'isPackageGlobalActivateFromPath');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isPackageGlobalActivateFromPath');
        t.isPackageGlobalActivateFromPath(path);
        return null;
      },
    },
    staticGetters: {
      'dartExeName': (visitor) => $dcli_23.DartSdk.dartExeName,
      'pubExeName': (visitor) => $dcli_23.DartSdk.pubExeName,
      'dart2NativeExeName': (visitor) => $dcli_23.DartSdk.dart2NativeExeName,
      'isUsingDartFromFlutter': (visitor) => $dcli_23.DartSdk.isUsingDartFromFlutter,
    },
    constructorSignatures: {
      '': 'factory DartSdk()',
    },
    methodSignatures: {
      'getVersion': 'Version getVersion()',
      'runDartCompiler': 'void runDartCompiler(DartScript script, {required String pathToExe, Progress? progress, String? workingDirectory})',
      'run': 'Progress run({required List<String> args, String? workingDirectory, Progress? progress, bool detached = false, bool terminal = false, bool nothrow = false})',
      'runPub': 'Progress runPub({required List<String> args, String? workingDirectory, Progress? progress, bool nothrow = false})',
      'runDartDoc': 'Progress runDartDoc({String? pathToProject, String? pathToDoc, List<String> args = const [], Progress? progress, bool nothrow = false})',
      'isPubGetRequired': 'bool isPubGetRequired(String workingDirectory)',
      'runPubGet': 'void runPubGet(String? workingDirectory, {Progress? progress, bool compileExecutables = false})',
      'runPubUpgrade': 'void runPubUpgrade(String? workingDirectory, {Progress? progress, bool compileExecutables = false})',
      'installFromArchive': 'Future<String> installFromArchive(String defaultDartSdkPath, {bool askUser = true})',
      'resolveArchitecture': 'String resolveArchitecture()',
      'globalActivate': 'void globalActivate(String package)',
      'globalActivateFromPath': 'void globalActivateFromPath(String path)',
      'globalDeactivate': 'void globalDeactivate(String package)',
      'isPackageGloballyActivated': 'bool isPackageGloballyActivated(String package)',
      'isPackageGlobalActivateFromPath': 'void isPackageGlobalActivateFromPath(String path)',
    },
    getterSignatures: {
      'pathToSdk': 'String get pathToSdk',
      'pathToDartExe': 'String? get pathToDartExe',
      'pathToPubExe': 'String? get pathToPubExe',
      'pathToDartToNativeExe': 'String? get pathToDartToNativeExe',
      'versionMajor': 'int get versionMajor',
      'versionMinor': 'int get versionMinor',
      'useDartCommand': 'bool get useDartCommand',
      'useDartDocCommand': 'bool get useDartDocCommand',
      'version': 'String get version',
      'pathToPackageConfig': 'String get pathToPackageConfig',
    },
    staticGetterSignatures: {
      'dartExeName': 'String get dartExeName',
      'pubExeName': 'String get pubExeName',
      'dart2NativeExeName': 'String get dart2NativeExeName',
      'isUsingDartFromFlutter': 'bool get isUsingDartFromFlutter',
    },
  );
}

// =============================================================================
// Settings Bridge
// =============================================================================

BridgedClass _createSettingsBridge() {
  return BridgedClass(
    nativeType: $dcli_24.Settings,
    name: 'Settings',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_24.Settings();
      },
      'forScope': (visitor, positional, named) {
        return $dcli_24.Settings.forScope();
      },
    },
    getters: {
      'version': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').version,
      'dcliDir': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').dcliDir,
      'isMacOS': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').isMacOS,
      'isLinux': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').isLinux,
      'isWindows': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').isWindows,
      'pathToScript': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').pathToScript,
      'pathToDCli': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').pathToDCli,
      'pathToDCliBin': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').pathToDCliBin,
      'pathToTemplate': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').pathToTemplate,
      'pathToTemplateProject': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').pathToTemplateProject,
      'pathToTemplateProjectCustom': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').pathToTemplateProjectCustom,
      'pathToTemplateScript': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').pathToTemplateScript,
      'pathToTemplateScriptCustom': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').pathToTemplateScriptCustom,
      'isVerbose': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').isVerbose,
      'logger': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').logger,
      'isInstalled': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').isInstalled,
      'installCompletedIndicator': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').installCompletedIndicator,
      'isStackEmpty': (visitor, target) => D4.validateTarget<$dcli_24.Settings>(target, 'Settings').isStackEmpty,
    },
    setters: {
      'version': (visitor, target, value) => 
        D4.validateTarget<$dcli_24.Settings>(target, 'Settings').version = value as String?,
      'dcliDir': (visitor, target, value) => 
        D4.validateTarget<$dcli_24.Settings>(target, 'Settings').dcliDir = value as dynamic,
    },
    methods: {
      'setVerbose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_24.Settings>(target, 'Settings');
        final enabled = D4.getRequiredNamedArg<bool>(named, 'enabled', 'setVerbose');
        t.setVerbose(enabled: enabled);
        return null;
      },
      'verbose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_24.Settings>(target, 'Settings');
        D4.requireMinArgs(positional, 1, 'verbose');
        final string = D4.getRequiredArg<String?>(positional, 0, 'string', 'verbose');
        t.verbose(string);
        return null;
      },
    },
    staticGetters: {
      'scopeKey': (visitor) => $dcli_24.Settings.scopeKey,
      'templateDir': (visitor) => $dcli_24.Settings.templateDir,
      'dcliAppName': (visitor) => $dcli_24.Settings.dcliAppName,
    },
    staticSetters: {
      'scopeKey': (visitor, value) => 
        $dcli_24.Settings.scopeKey = value as dynamic,
      'mock': (visitor, value) => 
        $dcli_24.Settings.mock = value as dynamic,
    },
    constructorSignatures: {
      '': 'factory Settings()',
      'forScope': 'factory Settings.forScope()',
    },
    methodSignatures: {
      'setVerbose': 'void setVerbose({required bool enabled})',
      'verbose': 'void verbose(String? string)',
    },
    getterSignatures: {
      'version': 'String? get version',
      'dcliDir': 'dynamic get dcliDir',
      'isMacOS': 'bool get isMacOS',
      'isLinux': 'bool get isLinux',
      'isWindows': 'bool get isWindows',
      'pathToScript': 'String get pathToScript',
      'pathToDCli': 'String get pathToDCli',
      'pathToDCliBin': 'String get pathToDCliBin',
      'pathToTemplate': 'String get pathToTemplate',
      'pathToTemplateProject': 'String get pathToTemplateProject',
      'pathToTemplateProjectCustom': 'String get pathToTemplateProjectCustom',
      'pathToTemplateScript': 'String get pathToTemplateScript',
      'pathToTemplateScriptCustom': 'String get pathToTemplateScriptCustom',
      'isVerbose': 'bool get isVerbose',
      'logger': 'Logger get logger',
      'isInstalled': 'bool get isInstalled',
      'installCompletedIndicator': 'String get installCompletedIndicator',
      'isStackEmpty': 'bool get isStackEmpty',
    },
    setterSignatures: {
      'version': 'set version(dynamic value)',
      'dcliDir': 'set dcliDir(dynamic value)',
    },
    staticGetterSignatures: {
      'scopeKey': 'dynamic get scopeKey',
      'templateDir': 'dynamic get templateDir',
      'dcliAppName': 'dynamic get dcliAppName',
    },
    staticSetterSignatures: {
      'scopeKey': 'set scopeKey(dynamic value)',
      'mock': 'set mock(Settings value)',
    },
  );
}

// =============================================================================
// Shell Bridge
// =============================================================================

BridgedClass _createShellBridge() {
  return BridgedClass(
    nativeType: $dcli_25.Shell,
    name: 'Shell',
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').name,
      'hasStartScript': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').hasStartScript,
      'startScriptName': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').startScriptName,
      'pathToStartScript': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').pathToStartScript,
      'canModifyPath': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').canModifyPath,
      'isCompletionSupported': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').isCompletionSupported,
      'isCompletionInstalled': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').isCompletionInstalled,
      'isSudo': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').isSudo,
      'loggedInUser': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').loggedInUser,
      'isPrivilegedUser': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').isPrivilegedUser,
      'isPrivilegedPasswordRequired': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').isPrivilegedPasswordRequired,
      'isPrivilegedProcess': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').isPrivilegedProcess,
      'installInstructions': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').installInstructions,
      'pid': (visitor, target) => D4.validateTarget<$dcli_25.Shell>(target, 'Shell').pid,
    },
    methods: {
      'matchByName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'matchByName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'matchByName');
        return t.matchByName(name);
      },
      'addToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'addToPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'addToPATH');
        return t.addToPATH(path);
      },
      'appendToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'appendToPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'appendToPATH');
        return t.appendToPATH(path);
      },
      'prependToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'prependToPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'prependToPATH');
        return t.prependToPATH(path);
      },
      'addFileAssocation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'addFileAssocation');
        final dcliPath = D4.getRequiredArg<String>(positional, 0, 'dcliPath', 'addFileAssocation');
        t.addFileAssocation(dcliPath);
        return null;
      },
      'installTabCompletion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        final quiet = D4.getNamedArgWithDefault<bool>(named, 'quiet', true);
        t.installTabCompletion(quiet: quiet);
        return null;
      },
      'releasePrivileges': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        t.releasePrivileges();
        return null;
      },
      'restorePrivileges': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        t.restorePrivileges();
        return null;
      },
      'withPrivileges': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'withPrivileges');
        if (positional.isEmpty) {
          throw ArgumentError('withPrivileges: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        final allowUnprivileged = D4.getNamedArgWithDefault<bool>(named, 'allowUnprivileged', false);
        t.withPrivileges(() { D4.callInterpreterCallback(visitor, actionRaw, []); }, allowUnprivileged: allowUnprivileged);
        return null;
      },
      'withPrivilegesAsync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'withPrivilegesAsync');
        if (positional.isEmpty) {
          throw ArgumentError('withPrivilegesAsync: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        final allowUnprivileged = D4.getNamedArgWithDefault<bool>(named, 'allowUnprivileged', false);
        return t.withPrivilegesAsync(() { return D4.callInterpreterCallback(visitor, actionRaw, []) as Future<void>; }, allowUnprivileged: allowUnprivileged);
      },
      'privilegesRequiredMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'privilegesRequiredMessage');
        final appname = D4.getRequiredArg<String>(positional, 0, 'appname', 'privilegesRequiredMessage');
        return t.privilegesRequiredMessage(appname);
      },
      'install': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        final installDart = D4.getNamedArgWithDefault<bool>(named, 'installDart', false);
        return t.install(installDart: installDart);
      },
      'checkInstallPreconditions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.Shell>(target, 'Shell');
        return t.checkInstallPreconditions();
      },
    },
    staticGetters: {
      'current': (visitor) => $dcli_25.Shell.current,
    },
    methodSignatures: {
      'matchByName': 'bool matchByName(String name)',
      'addToPATH': 'bool addToPATH(String path)',
      'appendToPATH': 'bool appendToPATH(String path)',
      'prependToPATH': 'bool prependToPATH(String path)',
      'addFileAssocation': 'void addFileAssocation(String dcliPath)',
      'installTabCompletion': 'void installTabCompletion({bool quiet = true})',
      'releasePrivileges': 'void releasePrivileges()',
      'restorePrivileges': 'void restorePrivileges()',
      'withPrivileges': 'void withPrivileges(RunPrivileged action, {bool allowUnprivileged = false})',
      'withPrivilegesAsync': 'Future<void> withPrivilegesAsync(RunPrivilegedAsync action, {bool allowUnprivileged = false})',
      'privilegesRequiredMessage': 'String privilegesRequiredMessage(String appname)',
      'install': 'Future<bool> install({bool installDart = false})',
      'checkInstallPreconditions': 'String? checkInstallPreconditions()',
    },
    getterSignatures: {
      'name': 'String get name',
      'hasStartScript': 'bool get hasStartScript',
      'startScriptName': 'String get startScriptName',
      'pathToStartScript': 'String? get pathToStartScript',
      'canModifyPath': 'bool get canModifyPath',
      'isCompletionSupported': 'bool get isCompletionSupported',
      'isCompletionInstalled': 'bool get isCompletionInstalled',
      'isSudo': 'bool get isSudo',
      'loggedInUser': 'String? get loggedInUser',
      'isPrivilegedUser': 'bool get isPrivilegedUser',
      'isPrivilegedPasswordRequired': 'bool get isPrivilegedPasswordRequired',
      'isPrivilegedProcess': 'bool get isPrivilegedProcess',
      'installInstructions': 'String get installInstructions',
      'pid': 'int? get pid',
    },
    staticGetterSignatures: {
      'current': 'Shell get current',
    },
  );
}

// =============================================================================
// ShellException Bridge
// =============================================================================

BridgedClass _createShellExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_25.ShellException,
    name: 'ShellException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ShellException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'ShellException');
        return $dcli_25.ShellException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_25.ShellException>(target, 'ShellException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_25.ShellException>(target, 'ShellException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_25.ShellException>(target, 'ShellException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_25.ShellException>(target, 'ShellException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.ShellException>(target, 'ShellException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.ShellException>(target, 'ShellException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.ShellException>(target, 'ShellException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_25.ShellException>(target, 'ShellException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'ShellException(dynamic message)',
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
// ShellDetection Bridge
// =============================================================================

BridgedClass _createShellDetectionBridge() {
  return BridgedClass(
    nativeType: $dcli_26.ShellDetection,
    name: 'ShellDetection',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_26.ShellDetection();
      },
    },
    methods: {
      'identifyShell': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_26.ShellDetection>(target, 'ShellDetection');
        return t.identifyShell();
      },
    },
    constructorSignatures: {
      '': 'factory ShellDetection()',
    },
    methodSignatures: {
      'identifyShell': 'Shell identifyShell()',
    },
  );
}

// =============================================================================
// UnknownShell Bridge
// =============================================================================

BridgedClass _createUnknownShellBridge() {
  return BridgedClass(
    nativeType: $dcli_27.UnknownShell,
    name: 'UnknownShell',
    constructors: {
      'withPid': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'UnknownShell');
        final pid = D4.getRequiredArg<int?>(positional, 0, 'pid', 'UnknownShell');
        final processName = D4.getOptionalNamedArg<String?>(named, 'processName');
        return $dcli_27.UnknownShell.withPid(pid, processName: processName);
      },
    },
    getters: {
      'processName': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').processName,
      'pid': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').pid,
      'canModifyPath': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').canModifyPath,
      'isCompletionInstalled': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').isCompletionInstalled,
      'isCompletionSupported': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').isCompletionSupported,
      'name': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').name,
      'hashCode': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').hashCode,
      'hasStartScript': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').hasStartScript,
      'startScriptName': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').startScriptName,
      'pathToStartScript': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').pathToStartScript,
      'isPrivilegedUser': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').isPrivilegedUser,
      'loggedInUser': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').loggedInUser,
      'isSudo': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').isSudo,
      'isPrivilegedProcess': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').isPrivilegedProcess,
      'isPrivilegedPasswordRequired': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').isPrivilegedPasswordRequired,
      'installInstructions': (visitor, target) => D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell').installInstructions,
    },
    methods: {
      'addToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'addToPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'addToPATH');
        return t.addToPATH(path);
      },
      'appendToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'appendToPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'appendToPATH');
        return t.appendToPATH(path);
      },
      'prependToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'prependToPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'prependToPATH');
        return t.prependToPATH(path);
      },
      'appendPathToMacOsPathd': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'appendPathToMacOsPathd');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'appendPathToMacOsPathd');
        return t.appendPathToMacOsPathd(path);
      },
      'installTabCompletion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        final quiet = D4.getNamedArgWithDefault<bool>(named, 'quiet', false);
        t.installTabCompletion(quiet: quiet);
        return null;
      },
      'privilegesRequiredMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'privilegesRequiredMessage');
        final app = D4.getRequiredArg<String>(positional, 0, 'app', 'privilegesRequiredMessage');
        return t.privilegesRequiredMessage(app);
      },
      'install': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        final installDart = D4.getNamedArgWithDefault<bool>(named, 'installDart', false);
        final activate = D4.getNamedArgWithDefault<bool>(named, 'activate', true);
        return t.install(installDart: installDart, activate: activate);
      },
      'checkInstallPreconditions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        return t.checkInstallPreconditions();
      },
      'releasePrivileges': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        t.releasePrivileges();
        return null;
      },
      'restorePrivileges': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        t.restorePrivileges();
        return null;
      },
      'withPrivileges': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'withPrivileges');
        if (positional.isEmpty) {
          throw ArgumentError('withPrivileges: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        final allowUnprivileged = D4.getNamedArgWithDefault<bool>(named, 'allowUnprivileged', false);
        t.withPrivileges(() { D4.callInterpreterCallback(visitor, actionRaw, []); }, allowUnprivileged: allowUnprivileged);
        return null;
      },
      'withPrivilegesAsync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'withPrivilegesAsync');
        if (positional.isEmpty) {
          throw ArgumentError('withPrivilegesAsync: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        final allowUnprivileged = D4.getNamedArgWithDefault<bool>(named, 'allowUnprivileged', false);
        return t.withPrivilegesAsync(() { return D4.callInterpreterCallback(visitor, actionRaw, []) as Future<void>; }, allowUnprivileged: allowUnprivileged);
      },
      'addFileAssocation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'addFileAssocation');
        final dcliPath = D4.getRequiredArg<String>(positional, 0, 'dcliPath', 'addFileAssocation');
        t.addFileAssocation(dcliPath);
        return null;
      },
      'matchByName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'matchByName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'matchByName');
        return t.matchByName(name);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_27.UnknownShell>(target, 'UnknownShell');
        final other = D4.getRequiredArg<$dcli_27.UnknownShell>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'shellName': (visitor) => $dcli_27.UnknownShell.shellName,
    },
    constructorSignatures: {
      'withPid': 'UnknownShell.withPid(int? pid, {String? processName})',
    },
    methodSignatures: {
      'addToPATH': 'bool addToPATH(String path)',
      'appendToPATH': 'bool appendToPATH(String path)',
      'prependToPATH': 'bool prependToPATH(String path)',
      'appendPathToMacOsPathd': 'bool appendPathToMacOsPathd(String path)',
      'installTabCompletion': 'void installTabCompletion({bool quiet = false})',
      'privilegesRequiredMessage': 'String privilegesRequiredMessage(String app)',
      'install': 'Future<bool> install({bool installDart = false, bool activate = true})',
      'checkInstallPreconditions': 'String? checkInstallPreconditions()',
      'releasePrivileges': 'void releasePrivileges()',
      'restorePrivileges': 'void restorePrivileges()',
      'withPrivileges': 'void withPrivileges(RunPrivileged action, {bool allowUnprivileged = false})',
      'withPrivilegesAsync': 'Future<void> withPrivilegesAsync(RunPrivilegedAsync action, {bool allowUnprivileged = false})',
      'addFileAssocation': 'void addFileAssocation(String dcliPath)',
      'matchByName': 'bool matchByName(String name)',
    },
    getterSignatures: {
      'processName': 'String? get processName',
      'pid': 'int? get pid',
      'canModifyPath': 'bool get canModifyPath',
      'isCompletionInstalled': 'bool get isCompletionInstalled',
      'isCompletionSupported': 'bool get isCompletionSupported',
      'name': 'String get name',
      'hashCode': 'int get hashCode',
      'hasStartScript': 'bool get hasStartScript',
      'startScriptName': 'String get startScriptName',
      'pathToStartScript': 'String get pathToStartScript',
      'isPrivilegedUser': 'bool get isPrivilegedUser',
      'loggedInUser': 'String? get loggedInUser',
      'isSudo': 'bool get isSudo',
      'isPrivilegedProcess': 'bool get isPrivilegedProcess',
      'isPrivilegedPasswordRequired': 'bool get isPrivilegedPasswordRequired',
      'installInstructions': 'String get installInstructions',
    },
    staticGetterSignatures: {
      'shellName': 'dynamic get shellName',
    },
  );
}

// =============================================================================
// DCliPaths Bridge
// =============================================================================

BridgedClass _createDCliPathsBridge() {
  return BridgedClass(
    nativeType: $dcli_29.DCliPaths,
    name: 'DCliPaths',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_29.DCliPaths();
      },
    },
    getters: {
      'dcliName': (visitor, target) => D4.validateTarget<$dcli_29.DCliPaths>(target, 'DCliPaths').dcliName,
      'dcliInstallName': (visitor, target) => D4.validateTarget<$dcli_29.DCliPaths>(target, 'DCliPaths').dcliInstallName,
      'dcliCompleteName': (visitor, target) => D4.validateTarget<$dcli_29.DCliPaths>(target, 'DCliPaths').dcliCompleteName,
      'pathToDCli': (visitor, target) => D4.validateTarget<$dcli_29.DCliPaths>(target, 'DCliPaths').pathToDCli,
    },
    setters: {
      'dcliName': (visitor, target, value) => 
        D4.validateTarget<$dcli_29.DCliPaths>(target, 'DCliPaths').dcliName = value as String,
      'dcliInstallName': (visitor, target, value) => 
        D4.validateTarget<$dcli_29.DCliPaths>(target, 'DCliPaths').dcliInstallName = value as String,
      'dcliCompleteName': (visitor, target, value) => 
        D4.validateTarget<$dcli_29.DCliPaths>(target, 'DCliPaths').dcliCompleteName = value as String,
    },
    constructorSignatures: {
      '': 'factory DCliPaths()',
    },
    getterSignatures: {
      'dcliName': 'String get dcliName',
      'dcliInstallName': 'String get dcliInstallName',
      'dcliCompleteName': 'String get dcliCompleteName',
      'pathToDCli': 'String? get pathToDCli',
    },
    setterSignatures: {
      'dcliName': 'set dcliName(dynamic value)',
      'dcliInstallName': 'set dcliInstallName(dynamic value)',
      'dcliCompleteName': 'set dcliCompleteName(dynamic value)',
    },
  );
}

// =============================================================================
// InvalidArgumentException Bridge
// =============================================================================

BridgedClass _createInvalidArgumentExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_32.InvalidArgumentException,
    name: 'InvalidArgumentException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InvalidArgumentException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'InvalidArgumentException');
        return $dcli_32.InvalidArgumentException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_32.InvalidArgumentException>(target, 'InvalidArgumentException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_32.InvalidArgumentException>(target, 'InvalidArgumentException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_32.InvalidArgumentException>(target, 'InvalidArgumentException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_32.InvalidArgumentException>(target, 'InvalidArgumentException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.InvalidArgumentException>(target, 'InvalidArgumentException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.InvalidArgumentException>(target, 'InvalidArgumentException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.InvalidArgumentException>(target, 'InvalidArgumentException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.InvalidArgumentException>(target, 'InvalidArgumentException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'InvalidArgumentException(dynamic message)',
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
// InvalidTemplateException Bridge
// =============================================================================

BridgedClass _createInvalidTemplateExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_32.InvalidTemplateException,
    name: 'InvalidTemplateException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InvalidTemplateException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'InvalidTemplateException');
        return $dcli_32.InvalidTemplateException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_32.InvalidTemplateException>(target, 'InvalidTemplateException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_32.InvalidTemplateException>(target, 'InvalidTemplateException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_32.InvalidTemplateException>(target, 'InvalidTemplateException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_32.InvalidTemplateException>(target, 'InvalidTemplateException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.InvalidTemplateException>(target, 'InvalidTemplateException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.InvalidTemplateException>(target, 'InvalidTemplateException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.InvalidTemplateException>(target, 'InvalidTemplateException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.InvalidTemplateException>(target, 'InvalidTemplateException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'InvalidTemplateException(dynamic message)',
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
// InstallException Bridge
// =============================================================================

BridgedClass _createInstallExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_32.InstallException,
    name: 'InstallException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InstallException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'InstallException');
        return $dcli_32.InstallException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_32.InstallException>(target, 'InstallException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_32.InstallException>(target, 'InstallException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_32.InstallException>(target, 'InstallException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_32.InstallException>(target, 'InstallException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.InstallException>(target, 'InstallException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.InstallException>(target, 'InstallException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.InstallException>(target, 'InstallException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.InstallException>(target, 'InstallException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'InstallException(dynamic message)',
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
// ProcessSyncException Bridge
// =============================================================================

BridgedClass _createProcessSyncExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_32.ProcessSyncException,
    name: 'ProcessSyncException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ProcessSyncException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'ProcessSyncException');
        return $dcli_32.ProcessSyncException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_32.ProcessSyncException>(target, 'ProcessSyncException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_32.ProcessSyncException>(target, 'ProcessSyncException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_32.ProcessSyncException>(target, 'ProcessSyncException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_32.ProcessSyncException>(target, 'ProcessSyncException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.ProcessSyncException>(target, 'ProcessSyncException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.ProcessSyncException>(target, 'ProcessSyncException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.ProcessSyncException>(target, 'ProcessSyncException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_32.ProcessSyncException>(target, 'ProcessSyncException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'ProcessSyncException(dynamic message)',
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
// FileSort Bridge
// =============================================================================

BridgedClass _createFileSortBridge() {
  return BridgedClass(
    nativeType: $dcli_33.FileSort,
    name: 'FileSort',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 5, 'FileSort');
        final inputPath = D4.getRequiredArg<String>(positional, 0, 'inputPath', 'FileSort');
        final outputPath = D4.getRequiredArg<String>(positional, 1, 'outputPath', 'FileSort');
        if (positional.length <= 2) {
          throw ArgumentError('FileSort: Missing required argument "columns" at position 2');
        }
        final columns = D4.coerceList<$dcli_33.Column>(positional[2], 'columns');
        final fieldDelimiter = D4.getRequiredArg<String?>(positional, 3, 'fieldDelimiter', 'FileSort');
        final lineDelimiter = D4.getRequiredArg<String?>(positional, 4, 'lineDelimiter', 'FileSort');
        final verbose = D4.getNamedArgWithDefault<bool?>(named, 'verbose', false);
        return $dcli_33.FileSort(inputPath, outputPath, columns, fieldDelimiter, lineDelimiter, verbose: verbose);
      },
    },
    getters: {
      'verbose': (visitor, target) => D4.validateTarget<$dcli_33.FileSort>(target, 'FileSort').verbose,
    },
    methods: {
      'sort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_33.FileSort>(target, 'FileSort');
        t.sort();
        return null;
      },
    },
    staticMethods: {
      'expandColumns': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'expandColumns');
        if (positional.isEmpty) {
          throw ArgumentError('expandColumns: Missing required argument "values" at position 0');
        }
        final values = D4.coerceList<String>(positional[0], 'values');
        return $dcli_33.FileSort.expandColumns(values);
      },
    },
    constructorSignatures: {
      '': 'FileSort(String inputPath, String outputPath, List<Column> columns, String? fieldDelimiter, String? lineDelimiter, {bool? verbose = false})',
    },
    methodSignatures: {
      'sort': 'void sort()',
    },
    getterSignatures: {
      'verbose': 'bool? get verbose',
    },
    staticMethodSignatures: {
      'expandColumns': 'List<Column> expandColumns(List<String> values)',
    },
  );
}

// =============================================================================
// Column Bridge
// =============================================================================

BridgedClass _createColumnBridge() {
  return BridgedClass(
    nativeType: $dcli_33.Column,
    name: 'Column',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'Column');
        final ordinal = D4.getRequiredArg<int?>(positional, 0, 'ordinal', 'Column');
        final comparator = D4.getRequiredArg<$dcli_33.ColumnComparator?>(positional, 1, '_comparator', 'Column');
        final sortDirection = D4.getRequiredArg<$dcli_33.SortDirection?>(positional, 2, '_sortDirection', 'Column');
        return $dcli_33.Column(ordinal, comparator, sortDirection);
      },
      'parse': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Column');
        final column = D4.getRequiredArg<String>(positional, 0, 'column', 'Column');
        final ordinalOnly = D4.getNamedArgWithDefault<bool>(named, 'ordinalOnly', false);
        return $dcli_33.Column.parse(column, ordinalOnly: ordinalOnly);
      },
    },
    getters: {
      'ordinal': (visitor, target) => D4.validateTarget<$dcli_33.Column>(target, 'Column').ordinal,
    },
    setters: {
      'ordinal': (visitor, target, value) => 
        D4.validateTarget<$dcli_33.Column>(target, 'Column').ordinal = value as int?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_33.Column>(target, 'Column');
        return t.toString();
      },
    },
    constructorSignatures: {
      '': 'Column(int? ordinal, ColumnComparator? _comparator, SortDirection? _sortDirection)',
      'parse': 'Column.parse(String column, {bool ordinalOnly = false})',
    },
    methodSignatures: {
      'toString': 'String toString()',
    },
    getterSignatures: {
      'ordinal': 'int? get ordinal',
    },
    setterSignatures: {
      'ordinal': 'set ordinal(dynamic value)',
    },
  );
}

// =============================================================================
// FileSync Bridge
// =============================================================================

BridgedClass _createFileSyncBridge() {
  return BridgedClass(
    nativeType: $dcli_34.FileSync,
    name: 'FileSync',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FileSync');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'FileSync');
        final fileMode = D4.getNamedArgWithDefault<FileMode>(named, 'fileMode', FileMode.writeOnlyAppend);
        return $dcli_34.FileSync(path, fileMode: fileMode);
      },
    },
    getters: {
      'path': (visitor, target) => D4.validateTarget<$dcli_34.FileSync>(target, 'FileSync').path,
      'length': (visitor, target) => D4.validateTarget<$dcli_34.FileSync>(target, 'FileSync').length,
    },
    methods: {
      'readLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_34.FileSync>(target, 'FileSync');
        final lineDelimiter = D4.getOptionalNamedArg<String?>(named, 'lineDelimiter');
        return t.readLine(lineDelimiter: lineDelimiter);
      },
      'flush': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_34.FileSync>(target, 'FileSync');
        t.flush();
        return null;
      },
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_34.FileSync>(target, 'FileSync');
        t.close();
        return null;
      },
      'read': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_34.FileSync>(target, 'FileSync');
        D4.requireMinArgs(positional, 1, 'read');
        if (positional.isEmpty) {
          throw ArgumentError('read: Missing required argument "lineAction" at position 0');
        }
        final lineActionRaw = positional[0];
        t.read((String p0) { return D4.callInterpreterCallback(visitor, lineActionRaw, [p0]) as bool; });
        return null;
      },
      'resolveSymLink': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_34.FileSync>(target, 'FileSync');
        return t.resolveSymLink();
      },
      'write': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_34.FileSync>(target, 'FileSync');
        D4.requireMinArgs(positional, 1, 'write');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'write');
        final newline = D4.getOptionalNamedArg<String?>(named, 'newline');
        t.write(line, newline: newline);
        return null;
      },
      'writeFromSync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_34.FileSync>(target, 'FileSync');
        D4.requireMinArgs(positional, 1, 'writeFromSync');
        if (positional.isEmpty) {
          throw ArgumentError('writeFromSync: Missing required argument "buffer" at position 0');
        }
        final buffer = D4.coerceList<int>(positional[0], 'buffer');
        final start = D4.getOptionalArgWithDefault<int>(positional, 1, 'start', 0);
        final end = D4.getOptionalArg<int?>(positional, 2, 'end');
        t.writeFromSync(buffer, start, end);
        return null;
      },
      'readIntoSync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_34.FileSync>(target, 'FileSync');
        D4.requireMinArgs(positional, 1, 'readIntoSync');
        if (positional.isEmpty) {
          throw ArgumentError('readIntoSync: Missing required argument "buffer" at position 0');
        }
        final buffer = D4.coerceList<int>(positional[0], 'buffer');
        final start = D4.getOptionalArgWithDefault<int>(positional, 1, 'start', 0);
        final end = D4.getOptionalArg<int?>(positional, 2, 'end');
        return t.readIntoSync(buffer, start, end);
      },
      'append': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_34.FileSync>(target, 'FileSync');
        D4.requireMinArgs(positional, 1, 'append');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'append');
        final newline = D4.getOptionalNamedArg<String?>(named, 'newline');
        t.append(line, newline: newline);
        return null;
      },
      'truncate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_34.FileSync>(target, 'FileSync');
        t.truncate();
        return null;
      },
    },
    staticMethods: {
      'tempFile': (visitor, positional, named, typeArgs) {
        final suffix = D4.getOptionalNamedArg<String?>(named, 'suffix');
        return $dcli_34.FileSync.tempFile(suffix: suffix);
      },
    },
    constructorSignatures: {
      '': 'FileSync(String path, {FileMode fileMode = FileMode.writeOnlyAppend})',
    },
    methodSignatures: {
      'readLine': 'String? readLine({String? lineDelimiter})',
      'flush': 'void flush()',
      'close': 'void close()',
      'read': 'void read(CancelableLineAction lineAction)',
      'resolveSymLink': 'String resolveSymLink()',
      'write': 'void write(String line, {String? newline})',
      'writeFromSync': 'void writeFromSync(List<int> buffer, [int start = 0, int? end])',
      'readIntoSync': 'int readIntoSync(List<int> buffer, [int start = 0, int? end])',
      'append': 'void append(String line, {String? newline})',
      'truncate': 'void truncate()',
    },
    getterSignatures: {
      'path': 'String get path',
      'length': 'int get length',
    },
    staticMethodSignatures: {
      'tempFile': 'String tempFile({String? suffix})',
    },
  );
}

// =============================================================================
// FileNotFoundException Bridge
// =============================================================================

BridgedClass _createFileNotFoundExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_35.FileNotFoundException,
    name: 'FileNotFoundException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FileNotFoundException');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'FileNotFoundException');
        return $dcli_35.FileNotFoundException(path);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_35.FileNotFoundException>(target, 'FileNotFoundException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_35.FileNotFoundException>(target, 'FileNotFoundException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_35.FileNotFoundException>(target, 'FileNotFoundException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_35.FileNotFoundException>(target, 'FileNotFoundException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_35.FileNotFoundException>(target, 'FileNotFoundException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_35.FileNotFoundException>(target, 'FileNotFoundException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_35.FileNotFoundException>(target, 'FileNotFoundException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_35.FileNotFoundException>(target, 'FileNotFoundException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'FileNotFoundException(String path)',
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
// NotAFileException Bridge
// =============================================================================

BridgedClass _createNotAFileExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_35.NotAFileException,
    name: 'NotAFileException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'NotAFileException');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'NotAFileException');
        return $dcli_35.NotAFileException(path);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_35.NotAFileException>(target, 'NotAFileException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_35.NotAFileException>(target, 'NotAFileException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_35.NotAFileException>(target, 'NotAFileException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_35.NotAFileException>(target, 'NotAFileException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_35.NotAFileException>(target, 'NotAFileException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_35.NotAFileException>(target, 'NotAFileException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_35.NotAFileException>(target, 'NotAFileException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_35.NotAFileException>(target, 'NotAFileException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'NotAFileException(String path)',
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
// NamedLock Bridge
// =============================================================================

BridgedClass _createNamedLockBridge() {
  return BridgedClass(
    nativeType: $dcli_36.NamedLock,
    name: 'NamedLock',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'NamedLock');
        final lockPath = D4.getOptionalNamedArg<String?>(named, 'lockPath');
        final description = D4.getNamedArgWithDefault<String>(named, 'description', '');
        final timeout = D4.getNamedArgWithDefault<Duration>(named, 'timeout', const Duration(seconds: 30));
        return $dcli_36.NamedLock(name: name, lockPath: lockPath, description: description, timeout: timeout);
      },
    },
    getters: {
      'port': (visitor, target) => D4.validateTarget<$dcli_36.NamedLock>(target, 'NamedLock').port,
      'name': (visitor, target) => D4.validateTarget<$dcli_36.NamedLock>(target, 'NamedLock').name,
      'incLockCount': (visitor, target) => D4.validateTarget<$dcli_36.NamedLock>(target, 'NamedLock').incLockCount,
      'decLockCount': (visitor, target) => D4.validateTarget<$dcli_36.NamedLock>(target, 'NamedLock').decLockCount,
    },
    methods: {
      'withLock': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_36.NamedLock>(target, 'NamedLock');
        D4.requireMinArgs(positional, 1, 'withLock');
        if (positional.isEmpty) {
          throw ArgumentError('withLock: Missing required argument "fn" at position 0');
        }
        final fnRaw = positional[0];
        final waiting = D4.getOptionalNamedArg<String?>(named, 'waiting');
        return t.withLock(() { D4.callInterpreterCallback(visitor, fnRaw, []); }, waiting: waiting);
      },
      'withLockAsync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_36.NamedLock>(target, 'NamedLock');
        D4.requireMinArgs(positional, 1, 'withLockAsync');
        if (positional.isEmpty) {
          throw ArgumentError('withLockAsync: Missing required argument "fn" at position 0');
        }
        final fnRaw = positional[0];
        final waiting = D4.getOptionalNamedArg<String?>(named, 'waiting');
        return t.withLockAsync(() { return D4.callInterpreterCallback(visitor, fnRaw, []) as Future<void>; }, waiting: waiting);
      },
    },
    constructorSignatures: {
      '': 'NamedLock({required String name, String? lockPath, String description = \'\', Duration timeout = const Duration(seconds: 30)})',
    },
    methodSignatures: {
      'withLock': 'Future<void> withLock(void Function() fn, {String? waiting})',
      'withLockAsync': 'Future<void> withLockAsync(Future<void> Function() fn, {String? waiting})',
    },
    getterSignatures: {
      'port': 'dynamic get port',
      'name': 'String get name',
      'incLockCount': 'int get incLockCount',
      'decLockCount': 'int get decLockCount',
    },
  );
}

// =============================================================================
// LockException Bridge
// =============================================================================

BridgedClass _createLockExceptionBridge() {
  return BridgedClass(
    nativeType: $dcli_36.LockException,
    name: 'LockException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LockException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'LockException');
        return $dcli_36.LockException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$dcli_36.LockException>(target, 'LockException').message,
      'cause': (visitor, target) => D4.validateTarget<$dcli_36.LockException>(target, 'LockException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$dcli_36.LockException>(target, 'LockException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$dcli_36.LockException>(target, 'LockException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_36.LockException>(target, 'LockException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_36.LockException>(target, 'LockException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_36.LockException>(target, 'LockException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_36.LockException>(target, 'LockException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'LockException(dynamic message)',
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
// ProcessDetails Bridge
// =============================================================================

BridgedClass _createProcessDetailsBridge() {
  return BridgedClass(
    nativeType: $dcli_37.ProcessDetails,
    name: 'ProcessDetails',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'ProcessDetails');
        final pid = D4.getRequiredArg<int>(positional, 0, 'pid', 'ProcessDetails');
        final name = D4.getRequiredArg<String>(positional, 1, 'name', 'ProcessDetails');
        final memory = D4.getRequiredArg<String>(positional, 2, 'memory', 'ProcessDetails');
        return $dcli_37.ProcessDetails(pid, name, memory);
      },
    },
    getters: {
      'pid': (visitor, target) => D4.validateTarget<$dcli_37.ProcessDetails>(target, 'ProcessDetails').pid,
      'name': (visitor, target) => D4.validateTarget<$dcli_37.ProcessDetails>(target, 'ProcessDetails').name,
      'memoryUnits': (visitor, target) => D4.validateTarget<$dcli_37.ProcessDetails>(target, 'ProcessDetails').memoryUnits,
      'memory': (visitor, target) => D4.validateTarget<$dcli_37.ProcessDetails>(target, 'ProcessDetails').memory,
      'hashCode': (visitor, target) => D4.validateTarget<$dcli_37.ProcessDetails>(target, 'ProcessDetails').hashCode,
    },
    setters: {
      'memoryUnits': (visitor, target, value) => 
        D4.validateTarget<$dcli_37.ProcessDetails>(target, 'ProcessDetails').memoryUnits = value as String?,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_37.ProcessDetails>(target, 'ProcessDetails');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$dcli_37.ProcessDetails>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_37.ProcessDetails>(target, 'ProcessDetails');
        final other = D4.getRequiredArg<$dcli_37.ProcessDetails>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    constructorSignatures: {
      '': 'ProcessDetails(int pid, String name, String memory)',
    },
    methodSignatures: {
      'compareTo': 'int compareTo(ProcessDetails other)',
    },
    getterSignatures: {
      'pid': 'int get pid',
      'name': 'String get name',
      'memoryUnits': 'String? get memoryUnits',
      'memory': 'int get memory',
      'hashCode': 'int get hashCode',
    },
    setterSignatures: {
      'memoryUnits': 'set memoryUnits(dynamic value)',
    },
  );
}

// =============================================================================
// PubCache Bridge
// =============================================================================

BridgedClass _createPubCacheBridge() {
  return BridgedClass(
    nativeType: $dcli_38.PubCache,
    name: 'PubCache',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_38.PubCache();
      },
      'forScope': (visitor, positional, named) {
        return $dcli_38.PubCache.forScope();
      },
    },
    getters: {
      'pathTo': (visitor, target) => D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache').pathTo,
      'pathToBin': (visitor, target) => D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache').pathToBin,
      'pathToHosted': (visitor, target) => D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache').pathToHosted,
      'cacheDir': (visitor, target) => D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache').cacheDir,
      'pathToDartLang': (visitor, target) => D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache').pathToDartLang,
    },
    setters: {
      'pathTo': (visitor, target, value) => 
        D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache').pathTo = value as dynamic,
    },
    methods: {
      'pathToPackage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 2, 'pathToPackage');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'pathToPackage');
        final version = D4.getRequiredArg<String>(positional, 1, 'version', 'pathToPackage');
        return t.pathToPackage(packageName, version);
      },
      'pathToGlobalPackage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'pathToGlobalPackage');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'pathToGlobalPackage');
        return t.pathToGlobalPackage(packageName);
      },
      'isInstalled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'isInstalled');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'isInstalled');
        return t.isInstalled(packageName);
      },
      'findPrimaryVersion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'findPrimaryVersion');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'findPrimaryVersion');
        return t.findPrimaryVersion(packageName);
      },
      'findVersion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 2, 'findVersion');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'findVersion');
        final requestedVersion = D4.getRequiredArg<String>(positional, 1, 'requestedVersion', 'findVersion');
        return t.findVersion(packageName, requestedVersion);
      },
      'globalActivate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'globalActivate');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'globalActivate');
        final version = D4.getOptionalNamedArg<String?>(named, 'version');
        final verbose = D4.getNamedArgWithDefault<bool>(named, 'verbose', false);
        t.globalActivate(packageName, version: version, verbose: verbose);
        return null;
      },
      'globalActivateFromSource': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'globalActivateFromSource');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'globalActivateFromSource');
        final overwrite = D4.getNamedArgWithDefault<bool>(named, 'overwrite', false);
        t.globalActivateFromSource(path, overwrite: overwrite);
        return null;
      },
      'globalDeactivate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'globalDeactivate');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'globalDeactivate');
        t.globalDeactivate(packageName);
        return null;
      },
      'isGloballyActivated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'isGloballyActivated');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'isGloballyActivated');
        return t.isGloballyActivated(packageName);
      },
      'isGloballyActivatedFromSource': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_38.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'isGloballyActivatedFromSource');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'isGloballyActivatedFromSource');
        return t.isGloballyActivatedFromSource(packageName);
      },
    },
    staticGetters: {
      'scopeKey': (visitor) => $dcli_38.PubCache.scopeKey,
      'envVarPubCache': (visitor) => $dcli_38.PubCache.envVarPubCache,
    },
    staticSetters: {
      'scopeKey': (visitor, value) => 
        $dcli_38.PubCache.scopeKey = value as dynamic,
    },
    constructorSignatures: {
      '': 'factory PubCache()',
      'forScope': 'factory PubCache.forScope()',
    },
    methodSignatures: {
      'pathToPackage': 'String pathToPackage(String packageName, String version)',
      'pathToGlobalPackage': 'String pathToGlobalPackage(String packageName)',
      'isInstalled': 'bool isInstalled(String packageName)',
      'findPrimaryVersion': 'Version? findPrimaryVersion(String packageName)',
      'findVersion': 'String? findVersion(String packageName, String requestedVersion)',
      'globalActivate': 'void globalActivate(String packageName, {String? version, bool verbose = false})',
      'globalActivateFromSource': 'void globalActivateFromSource(String path, {bool overwrite = false})',
      'globalDeactivate': 'void globalDeactivate(String packageName)',
      'isGloballyActivated': 'bool isGloballyActivated(String packageName)',
      'isGloballyActivatedFromSource': 'bool isGloballyActivatedFromSource(String packageName)',
    },
    getterSignatures: {
      'pathTo': 'String get pathTo',
      'pathToBin': 'String get pathToBin',
      'pathToHosted': 'String get pathToHosted',
      'cacheDir': 'String get cacheDir',
      'pathToDartLang': 'String get pathToDartLang',
    },
    setterSignatures: {
      'pathTo': 'set pathTo(String value)',
    },
    staticGetterSignatures: {
      'scopeKey': 'dynamic get scopeKey',
      'envVarPubCache': 'dynamic get envVarPubCache',
    },
    staticSetterSignatures: {
      'scopeKey': 'set scopeKey(dynamic value)',
    },
  );
}

// =============================================================================
// Remote Bridge
// =============================================================================

BridgedClass _createRemoteBridge() {
  return BridgedClass(
    nativeType: $dcli_39.Remote,
    name: 'Remote',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_39.Remote();
      },
    },
    methods: {
      'exec': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_39.Remote>(target, 'Remote');
        final host = D4.getRequiredNamedArg<String>(named, 'host', 'exec');
        final command = D4.getRequiredNamedArg<String>(named, 'command', 'exec');
        final agent = D4.getNamedArgWithDefault<bool>(named, 'agent', true);
        final sudo = D4.getNamedArgWithDefault<bool>(named, 'sudo', false);
        final password = D4.getOptionalNamedArg<String?>(named, 'password');
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        if (!named.containsKey('encoding')) {
          t.exec(host: host, command: command, agent: agent, sudo: sudo, password: password, progress: progress);
          return null;
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'exec');
          t.exec(host: host, command: command, agent: agent, sudo: sudo, password: password, progress: progress, encoding: encoding);
          return null;
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'execList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_39.Remote>(target, 'Remote');
        final host = D4.getRequiredNamedArg<String>(named, 'host', 'execList');
        if (!named.containsKey('commands') || named['commands'] == null) {
          throw ArgumentError('execList: Missing required named argument "commands"');
        }
        final commands = D4.coerceList<String?>(named['commands'], 'commands');
        final agent = D4.getNamedArgWithDefault<bool>(named, 'agent', true);
        final sudo = D4.getNamedArgWithDefault<bool>(named, 'sudo', false);
        final password = D4.getOptionalNamedArg<String?>(named, 'password');
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        if (!named.containsKey('encoding')) {
          t.execList(host: host, commands: commands, agent: agent, sudo: sudo, password: password, progress: progress);
          return null;
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'execList');
          t.execList(host: host, commands: commands, agent: agent, sudo: sudo, password: password, progress: progress, encoding: encoding);
          return null;
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'scp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_39.Remote>(target, 'Remote');
        if (!named.containsKey('from') || named['from'] == null) {
          throw ArgumentError('scp: Missing required named argument "from"');
        }
        final from = D4.coerceList<String>(named['from'], 'from');
        final to = D4.getRequiredNamedArg<String>(named, 'to', 'scp');
        final fromHost = D4.getOptionalNamedArg<String?>(named, 'fromHost');
        final toHost = D4.getOptionalNamedArg<String?>(named, 'toHost');
        final fromUser = D4.getOptionalNamedArg<String?>(named, 'fromUser');
        final toUser = D4.getOptionalNamedArg<String?>(named, 'toUser');
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', false);
        final progress = D4.getOptionalNamedArg<$dcli_18.Progress?>(named, 'progress');
        if (!named.containsKey('encoding')) {
          t.scp(from: from, to: to, fromHost: fromHost, toHost: toHost, fromUser: fromUser, toUser: toUser, recursive: recursive, progress: progress);
          return null;
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'scp');
          t.scp(from: from, to: to, fromHost: fromHost, toHost: toHost, fromUser: fromUser, toUser: toUser, recursive: recursive, progress: progress, encoding: encoding);
          return null;
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    constructorSignatures: {
      '': 'factory Remote()',
    },
    methodSignatures: {
      'exec': 'void exec({required String host, required String command, bool agent = true, bool sudo = false, String? password, Progress? progress, Encoding encoding = utf8})',
      'execList': 'void execList({required String host, required List<String?> commands, bool agent = true, bool sudo = false, String? password, Progress? progress, Encoding encoding = utf8})',
      'scp': 'void scp({required List<String> from, required String to, String? fromHost, String? toHost, String? fromUser, String? toUser, bool recursive = false, Progress? progress, Encoding encoding = utf8})',
    },
  );
}

// =============================================================================
// FindProgress Bridge
// =============================================================================

BridgedClass _createFindProgressBridge() {
  return BridgedClass(
    nativeType: $dcli_8.FindProgress,
    name: 'FindProgress',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FindProgress');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'FindProgress');
        final caseSensitive = D4.getRequiredNamedArg<bool>(named, 'caseSensitive', 'FindProgress');
        final recursion = D4.getRequiredNamedArg<bool>(named, 'recursion', 'FindProgress');
        final includeHidden = D4.getRequiredNamedArg<bool>(named, 'includeHidden', 'FindProgress');
        final workingDirectory = D4.getRequiredNamedArg<String>(named, 'workingDirectory', 'FindProgress');
        if (!named.containsKey('types') || named['types'] == null) {
          throw ArgumentError('FindProgress: Missing required named argument "types"');
        }
        final types = D4.coerceList<FileSystemEntityType>(named['types'], 'types');
        return $dcli_8.FindProgress(pattern, caseSensitive: caseSensitive, recursion: recursion, includeHidden: includeHidden, workingDirectory: workingDirectory, types: types);
      },
    },
    getters: {
      'pattern': (visitor, target) => D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').pattern,
      'caseSensitive': (visitor, target) => D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').caseSensitive,
      'recursion': (visitor, target) => D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').recursion,
      'includeHidden': (visitor, target) => D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').includeHidden,
      'workingDirectory': (visitor, target) => D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').workingDirectory,
      'types': (visitor, target) => D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').types,
      'firstLine': (visitor, target) => D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').firstLine,
    },
    setters: {
      'pattern': (visitor, target, value) => 
        D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').pattern = value as String,
      'caseSensitive': (visitor, target, value) => 
        D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').caseSensitive = value as bool,
      'recursion': (visitor, target, value) => 
        D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').recursion = value as bool,
      'includeHidden': (visitor, target, value) => 
        D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').includeHidden = value as bool,
      'workingDirectory': (visitor, target, value) => 
        D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').workingDirectory = value as String,
      'types': (visitor, target, value) => 
        D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress').types = (value as List).cast<FileSystemEntityType>().toList(),
    },
    methods: {
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((String p0) { D4.callInterpreterCallback(visitor, actionRaw, [p0]); });
        return null;
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_8.FindProgress>(target, 'FindProgress');
        return t.toList();
      },
    },
    constructorSignatures: {
      '': 'FindProgress(String pattern, {required bool caseSensitive, required bool recursion, required bool includeHidden, required String workingDirectory, required List<FileSystemEntityType> types})',
    },
    methodSignatures: {
      'forEach': 'void forEach(LineAction action)',
      'toList': 'List<String> toList()',
    },
    getterSignatures: {
      'pattern': 'String get pattern',
      'caseSensitive': 'bool get caseSensitive',
      'recursion': 'bool get recursion',
      'includeHidden': 'bool get includeHidden',
      'workingDirectory': 'String get workingDirectory',
      'types': 'List<FileSystemEntityType> get types',
      'firstLine': 'String? get firstLine',
    },
    setterSignatures: {
      'pattern': 'set pattern(dynamic value)',
      'caseSensitive': 'set caseSensitive(dynamic value)',
      'recursion': 'set recursion(dynamic value)',
      'includeHidden': 'set includeHidden(dynamic value)',
      'workingDirectory': 'set workingDirectory(dynamic value)',
      'types': 'set types(dynamic value)',
    },
  );
}

// =============================================================================
// HeadProgress Bridge
// =============================================================================

BridgedClass _createHeadProgressBridge() {
  return BridgedClass(
    nativeType: $dcli_9.HeadProgress,
    name: 'HeadProgress',
    constructors: {
    },
    methods: {
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_9.HeadProgress>(target, 'HeadProgress');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((String p0) { D4.callInterpreterCallback(visitor, actionRaw, [p0]); });
        return null;
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_9.HeadProgress>(target, 'HeadProgress');
        return t.toList();
      },
    },
    methodSignatures: {
      'forEach': 'void forEach(LineAction action)',
      'toList': 'List<String> toList()',
    },
  );
}

// =============================================================================
// TailProgress Bridge
// =============================================================================

BridgedClass _createTailProgressBridge() {
  return BridgedClass(
    nativeType: $dcli_16.TailProgress,
    name: 'TailProgress',
    constructors: {
    },
    getters: {
      'pathTo': (visitor, target) => D4.validateTarget<$dcli_16.TailProgress>(target, 'TailProgress').pathTo,
      'lines': (visitor, target) => D4.validateTarget<$dcli_16.TailProgress>(target, 'TailProgress').lines,
    },
    setters: {
      'pathTo': (visitor, target, value) => 
        D4.validateTarget<$dcli_16.TailProgress>(target, 'TailProgress').pathTo = value as String,
      'lines': (visitor, target, value) => 
        D4.validateTarget<$dcli_16.TailProgress>(target, 'TailProgress').lines = value as int,
    },
    methods: {
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_16.TailProgress>(target, 'TailProgress');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        t.forEach((String p0) { D4.callInterpreterCallback(visitor, actionRaw, [p0]); });
        return null;
      },
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$dcli_16.TailProgress>(target, 'TailProgress');
        return t.toList();
      },
    },
    methodSignatures: {
      'forEach': 'void forEach(LineAction action)',
      'toList': 'List<String> toList()',
    },
    getterSignatures: {
      'pathTo': 'String get pathTo',
      'lines': 'int get lines',
    },
    setterSignatures: {
      'pathTo': 'set pathTo(dynamic value)',
      'lines': 'set lines(dynamic value)',
    },
  );
}

// =============================================================================
// Which Bridge
// =============================================================================

BridgedClass _createWhichBridge() {
  return BridgedClass(
    nativeType: $dcli_core_15.Which,
    name: 'Which',
    constructors: {
      '': (visitor, positional, named) {
        return $dcli_core_15.Which();
      },
    },
    getters: {
      'progress': (visitor, target) => D4.validateTarget<$dcli_core_15.Which>(target, 'Which').progress,
      'path': (visitor, target) => D4.validateTarget<$dcli_core_15.Which>(target, 'Which').path,
      'paths': (visitor, target) => D4.validateTarget<$dcli_core_15.Which>(target, 'Which').paths,
      'found': (visitor, target) => D4.validateTarget<$dcli_core_15.Which>(target, 'Which').found,
      'notfound': (visitor, target) => D4.validateTarget<$dcli_core_15.Which>(target, 'Which').notfound,
    },
    setters: {
      'progress': (visitor, target, value) => 
        D4.validateTarget<$dcli_core_15.Which>(target, 'Which').progress = value as Stream<String>?,
    },
    constructorSignatures: {
      '': 'Which()',
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

