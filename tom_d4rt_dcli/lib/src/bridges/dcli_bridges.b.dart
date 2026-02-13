// D4rt Bridge - Generated file, do not edit
// Sources: 66 files
// Generated: 2026-02-13T14:17:08.144531

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dcli_terminal/src/ansi_color.dart' as ext_dcli_terminal_ansi_color;
import 'package:dcli_terminal/src/format.dart' as ext_dcli_terminal_format;
import 'package:dcli_terminal/src/terminal.dart' as ext_dcli_terminal_terminal;
import 'package:dcli/dcli.dart' as $pkg;
import 'package:dcli_core/dcli_core.dart' as $pkg2;

/// Bridge class for dcli module.
class DcliBridge {
  /// Returns all bridge class definitions.
  static List<BridgedClass> bridgeClasses() {
    return [
      _createRestoreFileExceptionBridge(),
      _createBackupFileExceptionBridge(),
      _createCatExceptionBridge(),
      _createCopyExceptionBridge(),
      _createCreateDirExceptionBridge(),
      _createDeleteExceptionBridge(),
      _createDeleteDirExceptionBridge(),
      _createEnvBridge(),
      _createFindBridge(),
      _createPatternMatcherBridge(),
      _createFindItemBridge(),
      _createFindExceptionBridge(),
      _createFindConfigBridge(),
      _createMoveExceptionBridge(),
      _createMoveDirExceptionBridge(),
      _createMoveTreeExceptionBridge(),
      _createWhichBridge(),
      _createWhichSearchBridge(),
      _createDCliExceptionBridge(),
      _createDCliPlatformBridge(),
      _createLineFileBridge(),
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
      _createFileSyncBridge(),
      _createFileNotFoundExceptionBridge(),
      _createNotAFileExceptionBridge(),
      _createNamedLockBridge(),
      _createLockExceptionBridge(),
      _createProcessDetailsBridge(),
      _createPubCacheBridge(),
      _createRemoteBridge(),
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
      'CatException': 'package:dcli_core/src/functions/cat.dart',
      'CopyException': 'package:dcli_core/src/functions/copy.dart',
      'CreateDirException': 'package:dcli_core/src/functions/create_dir.dart',
      'DeleteException': 'package:dcli_core/src/functions/delete.dart',
      'DeleteDirException': 'package:dcli_core/src/functions/delete_dir.dart',
      'Env': 'package:dcli_core/src/functions/env.dart',
      'Find': 'package:dcli_core/src/functions/find.dart',
      'PatternMatcher': 'package:dcli_core/src/functions/find.dart',
      'FindItem': 'package:dcli_core/src/functions/find.dart',
      'FindException': 'package:dcli_core/src/functions/find.dart',
      'FindConfig': 'package:dcli_core/src/functions/find.dart',
      'MoveException': 'package:dcli_core/src/functions/move.dart',
      'MoveDirException': 'package:dcli_core/src/functions/move_dir.dart',
      'MoveTreeException': 'package:dcli_core/src/functions/move_tree.dart',
      'Which': 'package:dcli_core/src/functions/which.dart',
      'WhichSearch': 'package:dcli_core/src/functions/which.dart',
      'DCliException': 'package:dcli_core/src/util/dcli_exception.dart',
      'DCliPlatform': 'package:dcli_core/src/util/dcli_platform.dart',
      'LineFile': 'package:dcli_core/src/util/line_file.dart',
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
      'FileSync': 'package:dcli/src/util/file_sync.dart',
      'FileNotFoundException': 'package:dcli/src/util/file_util.dart',
      'NotAFileException': 'package:dcli/src/util/file_util.dart',
      'NamedLock': 'package:dcli/src/util/named_lock.dart',
      'LockException': 'package:dcli/src/util/named_lock.dart',
      'ProcessDetails': 'package:dcli/src/util/process_helper.dart',
      'PubCache': 'package:dcli/src/util/pub_cache.dart',
      'Remote': 'package:dcli/src/util/remote.dart',
    };
  }

  /// Returns all bridged enum definitions.
  static List<BridgedEnumDefinition> bridgedEnums() {
    return [
      BridgedEnumDefinition<$pkg2.DCliPlatformOS>(
        name: 'DCliPlatformOS',
        values: $pkg2.DCliPlatformOS.values,
      ),
      BridgedEnumDefinition<ext_dcli_terminal_format.TableAlignment>(
        name: 'TableAlignment',
        values: ext_dcli_terminal_format.TableAlignment.values,
      ),
      BridgedEnumDefinition<ext_dcli_terminal_terminal.TerminalClearMode>(
        name: 'TerminalClearMode',
        values: ext_dcli_terminal_terminal.TerminalClearMode.values,
      ),
      BridgedEnumDefinition<$pkg.FetchMethod>(
        name: 'FetchMethod',
        values: $pkg.FetchMethod.values,
      ),
      BridgedEnumDefinition<$pkg.FetchStatus>(
        name: 'FetchStatus',
        values: $pkg.FetchStatus.values,
      ),
      BridgedEnumDefinition<$pkg.Interval>(
        name: 'Interval',
        values: $pkg.Interval.values,
      ),
      BridgedEnumDefinition<$pkg.SortDirection>(
        name: 'SortDirection',
        values: $pkg.SortDirection.values,
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
            final stdout = (String p0) { (stdoutRaw as InterpretedFunction).call(visitor, [p0]); };
            final wrappedNamed = <Symbol, dynamic>{};
            final stderrRaw = named['stderr'];
            if (stderrRaw != null) {
              wrappedNamed[#stderr] = (String p0) { (stderrRaw as InterpretedFunction).call(visitor, [p0]); };
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

    interpreter.registerGlobalGetter('env', () => $pkg2.env, importPath, sourceUri: 'package:dcli_core/src/functions/env.dart');
    interpreter.registerGlobalGetter('PATH', () => $pkg2.PATH, importPath, sourceUri: 'package:dcli_core/src/functions/env.dart');
    interpreter.registerGlobalGetter('HOME', () => $pkg2.HOME, importPath, sourceUri: 'package:dcli_core/src/functions/env.dart');
    interpreter.registerGlobalGetter('envs', () => $pkg2.envs, importPath, sourceUri: 'package:dcli_core/src/functions/env.dart');
    interpreter.registerGlobalGetter('pwd', () => $pkg2.pwd, importPath, sourceUri: 'package:dcli_core/src/functions/pwd.dart');
    interpreter.registerGlobalGetter('eol', () => $pkg2.eol, importPath, sourceUri: 'package:dcli_core/src/util/platform.dart');
    interpreter.registerGlobalGetter('rootPath', () => $pkg2.rootPath, importPath, sourceUri: 'package:dcli_core/src/util/truepath.dart');
    interpreter.registerGlobalGetter('fileList', () => $pkg.fileList, importPath, sourceUri: 'package:dcli/src/functions/file_list.dart');

    if (errors.isNotEmpty) {
      throw StateError('Bridge registration errors (dcli):\n${errors.join("\n")}');
    }
  }

  /// Returns a map of global function names to their native implementations.
  static Map<String, NativeFunctionImpl> globalFunctions() {
    return {
      'isOnPATH': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isOnPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isOnPATH');
        return $pkg2.isOnPATH(path);
      },
      'withEnvironmentAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'withEnvironmentAsync');
        if (positional.isEmpty) {
          throw ArgumentError('withEnvironmentAsync: Missing required argument "callback" at position 0');
        }
        final callbackRaw = positional[0];
        final callback = () { return (callbackRaw as InterpretedFunction).call(visitor, []) as Future<dynamic>; };
        final environment = D4.getRequiredNamedArg<Map<String, String>>(named, 'environment', 'withEnvironmentAsync');
        return $pkg2.withEnvironmentAsync<dynamic>(callback, environment: environment);
      },
      'devNull': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'devNull');
        final line = D4.getRequiredArg<String?>(positional, 0, 'line', 'devNull');
        return $pkg2.devNull(line);
      },
      'withOpenLineFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'withOpenLineFile');
        final pathToFile = D4.getRequiredArg<String>(positional, 0, 'pathToFile', 'withOpenLineFile');
        if (positional.length <= 1) {
          throw ArgumentError('withOpenLineFile: Missing required argument "action" at position 1');
        }
        final actionRaw = positional[1];
        final action = ($pkg2.LineFile p0) { return (actionRaw as InterpretedFunction).call(visitor, [p0]) as dynamic; };
        final fileMode = D4.getNamedArgWithDefault<FileMode>(named, 'fileMode', FileMode.writeOnlyAppend);
        return $pkg2.withOpenLineFile<dynamic>(pathToFile, action, fileMode: fileMode);
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
        return $pkg2.truepath(part1, part2, part3, part4, part5, part6, part7);
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
        return $pkg2.privatePath(part1, part2, part3, part4, part5, part6, part7);
      },
      'red': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'red');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'red');
        final background = D4.getNamedArgWithDefault<ext_dcli_terminal_ansi_color.AnsiColor>(named, 'background', ext_dcli_terminal_ansi_color.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return ext_dcli_terminal_ansi_color.red(text, background: background, bold: bold);
      },
      'black': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'black');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'black');
        final background = D4.getNamedArgWithDefault<ext_dcli_terminal_ansi_color.AnsiColor>(named, 'background', ext_dcli_terminal_ansi_color.AnsiColor.white);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return ext_dcli_terminal_ansi_color.black(text, background: background, bold: bold);
      },
      'green': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'green');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'green');
        final background = D4.getNamedArgWithDefault<ext_dcli_terminal_ansi_color.AnsiColor>(named, 'background', ext_dcli_terminal_ansi_color.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return ext_dcli_terminal_ansi_color.green(text, background: background, bold: bold);
      },
      'blue': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'blue');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'blue');
        final background = D4.getNamedArgWithDefault<ext_dcli_terminal_ansi_color.AnsiColor>(named, 'background', ext_dcli_terminal_ansi_color.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return ext_dcli_terminal_ansi_color.blue(text, background: background, bold: bold);
      },
      'yellow': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'yellow');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'yellow');
        final background = D4.getNamedArgWithDefault<ext_dcli_terminal_ansi_color.AnsiColor>(named, 'background', ext_dcli_terminal_ansi_color.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return ext_dcli_terminal_ansi_color.yellow(text, background: background, bold: bold);
      },
      'magenta': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'magenta');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'magenta');
        final background = D4.getNamedArgWithDefault<ext_dcli_terminal_ansi_color.AnsiColor>(named, 'background', ext_dcli_terminal_ansi_color.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return ext_dcli_terminal_ansi_color.magenta(text, background: background, bold: bold);
      },
      'cyan': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'cyan');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'cyan');
        final background = D4.getNamedArgWithDefault<ext_dcli_terminal_ansi_color.AnsiColor>(named, 'background', ext_dcli_terminal_ansi_color.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return ext_dcli_terminal_ansi_color.cyan(text, background: background, bold: bold);
      },
      'white': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'white');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'white');
        final background = D4.getNamedArgWithDefault<ext_dcli_terminal_ansi_color.AnsiColor>(named, 'background', ext_dcli_terminal_ansi_color.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return ext_dcli_terminal_ansi_color.white(text, background: background, bold: bold);
      },
      'orange': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'orange');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'orange');
        final background = D4.getNamedArgWithDefault<ext_dcli_terminal_ansi_color.AnsiColor>(named, 'background', ext_dcli_terminal_ansi_color.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return ext_dcli_terminal_ansi_color.orange(text, background: background, bold: bold);
      },
      'grey': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'grey');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'grey');
        final level = D4.getNamedArgWithDefault<double>(named, 'level', 0.5);
        final background = D4.getNamedArgWithDefault<ext_dcli_terminal_ansi_color.AnsiColor>(named, 'background', ext_dcli_terminal_ansi_color.AnsiColor.none);
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return ext_dcli_terminal_ansi_color.grey(text, level: level, background: background, bold: bold);
      },
      'ask': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'ask');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'ask');
        final toLower = D4.getNamedArgWithDefault<bool>(named, 'toLower', false);
        final hidden = D4.getNamedArgWithDefault<bool>(named, 'hidden', false);
        final required = D4.getNamedArgWithDefault<bool>(named, 'required', true);
        final defaultValue = D4.getOptionalNamedArg<String?>(named, 'defaultValue');
        final validator = D4.getNamedArgWithDefault<$pkg.AskValidator>(named, 'validator', $pkg.Ask.dontCare);
        final customErrorMessage = D4.getOptionalNamedArg<String?>(named, 'customErrorMessage');
        if (!named.containsKey('customPrompt')) {
          return $pkg.ask(prompt, toLower: toLower, hidden: hidden, required: required, defaultValue: defaultValue, validator: validator, customErrorMessage: customErrorMessage);
        }
        if (named.containsKey('customPrompt')) {
          final customPromptRaw = named['customPrompt'];
          final customPrompt = (String p0, String? p1, bool p2) { return (customPromptRaw as InterpretedFunction).call(visitor, [p0, p1, p2]) as String; };
          return $pkg.ask(prompt, toLower: toLower, hidden: hidden, required: required, defaultValue: defaultValue, validator: validator, customErrorMessage: customErrorMessage, customPrompt: customPrompt);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'backupFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'backupFile');
        final pathToFile = D4.getRequiredArg<String>(positional, 0, 'pathToFile', 'backupFile');
        final ignoreMissing = D4.getNamedArgWithDefault<bool>(named, 'ignoreMissing', false);
        return $pkg.backupFile(pathToFile, ignoreMissing: ignoreMissing);
      },
      'restoreFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'restoreFile');
        final pathToFile = D4.getRequiredArg<String>(positional, 0, 'pathToFile', 'restoreFile');
        final ignoreMissing = D4.getNamedArgWithDefault<bool>(named, 'ignoreMissing', false);
        return $pkg.restoreFile(pathToFile, ignoreMissing: ignoreMissing);
      },
      'withFileProtectionAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'withFileProtectionAsync');
        final protected = D4.getRequiredArg<List<String>>(positional, 0, 'protected', 'withFileProtectionAsync');
        if (positional.length <= 1) {
          throw ArgumentError('withFileProtectionAsync: Missing required argument "action" at position 1');
        }
        final actionRaw = positional[1];
        final action = () { return (actionRaw as InterpretedFunction).call(visitor, []) as Future<dynamic>; };
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        return $pkg.withFileProtectionAsync<dynamic>(protected, action, workingDirectory: workingDirectory);
      },
      'confirm': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'confirm');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'confirm');
        final defaultValue = D4.getOptionalNamedArg<bool?>(named, 'defaultValue');
        if (!named.containsKey('customPrompt')) {
          return $pkg.confirm(prompt, defaultValue: defaultValue);
        }
        if (named.containsKey('customPrompt')) {
          final customPromptRaw = named['customPrompt'];
          final customPrompt = (String p0, bool? p1) { return (customPromptRaw as InterpretedFunction).call(visitor, [p0, p1]) as String; };
          return $pkg.confirm(prompt, defaultValue: defaultValue, customPrompt: customPrompt);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'delete': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'delete');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'delete');
        final ask = D4.getNamedArgWithDefault<bool>(named, 'ask', false);
        return $pkg.delete(path, ask: ask);
      },
      'echo': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'echo');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'echo');
        final newline = D4.getNamedArgWithDefault<bool>(named, 'newline', false);
        return $pkg.echo(text, newline: newline);
      },
      'fetch': (visitor, positional, named, typeArgs) {
        final url = D4.getRequiredNamedArg<String>(named, 'url', 'fetch');
        final saveToPath = D4.getRequiredNamedArg<String>(named, 'saveToPath', 'fetch');
        final method = D4.getNamedArgWithDefault<$pkg.FetchMethod>(named, 'method', $pkg.FetchMethod.get);
        final headers = D4.getOptionalNamedArg<Map<String, String>?>(named, 'headers');
        final data = D4.getOptionalNamedArg<$pkg.FetchData?>(named, 'data');
        if (!named.containsKey('fetchProgress')) {
          return $pkg.fetch(url: url, saveToPath: saveToPath, method: method, headers: headers, data: data);
        }
        if (named.containsKey('fetchProgress')) {
          final fetchProgressRaw = named['fetchProgress'];
          final fetchProgress = ($pkg.FetchProgress p0) { (fetchProgressRaw as InterpretedFunction).call(visitor, [p0]); };
          return $pkg.fetch(url: url, saveToPath: saveToPath, method: method, headers: headers, data: data, fetchProgress: fetchProgress);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'fetchMultiple': (visitor, positional, named, typeArgs) {
        final urls = D4.getRequiredNamedArg<List<$pkg.FetchUrl>>(named, 'urls', 'fetchMultiple');
        return $pkg.fetchMultiple(urls: urls);
      },
      'find': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'find');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'find');
        final caseSensitive = D4.getNamedArgWithDefault<bool>(named, 'caseSensitive', false);
        final recursive = D4.getNamedArgWithDefault<bool>(named, 'recursive', true);
        final includeHidden = D4.getNamedArgWithDefault<bool>(named, 'includeHidden', false);
        final workingDirectory = D4.getNamedArgWithDefault<String>(named, 'workingDirectory', '.');
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
        if (!named.containsKey('types')) {
          return $pkg.find(pattern, caseSensitive: caseSensitive, recursive: recursive, includeHidden: includeHidden, workingDirectory: workingDirectory, progress: progress);
        }
        if (named.containsKey('types')) {
          final types = D4.getRequiredNamedArg<List<FileSystemEntityType>>(named, 'types', 'find');
          return $pkg.find(pattern, caseSensitive: caseSensitive, recursive: recursive, includeHidden: includeHidden, workingDirectory: workingDirectory, progress: progress, types: types);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'head': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'head');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'head');
        final lines = D4.getRequiredArg<int>(positional, 1, 'lines', 'head');
        return $pkg.head(path, lines);
      },
      'isWritable': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isWritable');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isWritable');
        return $pkg.isWritable(path);
      },
      'isReadable': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isReadable');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isReadable');
        return $pkg.isReadable(path);
      },
      'isExecutable': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isExecutable');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isExecutable');
        return $pkg.isExecutable(path);
      },
      'isMemberOfGroup': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'isMemberOfGroup');
        final group = D4.getRequiredArg<String>(positional, 0, 'group', 'isMemberOfGroup');
        return $pkg.isMemberOfGroup(group);
      },
      'menu': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'menu');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'menu');
        final options = D4.getRequiredNamedArg<List<dynamic>>(named, 'options', 'menu');
        final defaultOption = D4.getOptionalNamedArg<dynamic>(named, 'defaultOption');
        final limit = D4.getOptionalNamedArg<int?>(named, 'limit');
        final formatRaw = named['format'];
        final format = formatRaw == null ? null : (dynamic p0) { return (formatRaw as InterpretedFunction).call(visitor, [p0]) as String; };
        final fromStart = D4.getNamedArgWithDefault<bool>(named, 'fromStart', true);
        if (!named.containsKey('customPrompt')) {
          return $pkg.menu(prompt, options: options, defaultOption: defaultOption, limit: limit, format: format, fromStart: fromStart);
        }
        if (named.containsKey('customPrompt')) {
          final customPromptRaw = named['customPrompt'];
          final customPrompt = (String p0, String? p1) { return (customPromptRaw as InterpretedFunction).call(visitor, [p0, p1]) as String; };
          return $pkg.menu(prompt, options: options, defaultOption: defaultOption, limit: limit, format: format, fromStart: fromStart, customPrompt: customPrompt);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'read': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'read');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'read');
        final delim = D4.getNamedArgWithDefault<String>(named, 'delim', '\n');
        return $pkg.read(path, delim: delim);
      },
      'readStdin': (visitor, positional, named, typeArgs) {
        return $pkg.readStdin();
      },
      'replace': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'replace');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'replace');
        final existing = D4.getRequiredArg<Pattern>(positional, 1, 'existing', 'replace');
        final replacement = D4.getRequiredArg<String>(positional, 2, 'replacement', 'replace');
        final all = D4.getNamedArgWithDefault<bool>(named, 'all', false);
        return $pkg.replace(path, existing, replacement, all: all);
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
          return $pkg.run(commandLine, runInShell: runInShell, nothrow: nothrow, privileged: privileged, workingDirectory: workingDirectory, extensionSearch: extensionSearch);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'run');
          return $pkg.run(commandLine, runInShell: runInShell, nothrow: nothrow, privileged: privileged, workingDirectory: workingDirectory, extensionSearch: extensionSearch, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'startFromArgs': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'startFromArgs');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'startFromArgs');
        final args = D4.getRequiredArg<List<String>>(positional, 1, 'args', 'startFromArgs');
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
        final runInShell = D4.getNamedArgWithDefault<bool>(named, 'runInShell', false);
        final detached = D4.getNamedArgWithDefault<bool>(named, 'detached', false);
        final terminal = D4.getNamedArgWithDefault<bool>(named, 'terminal', false);
        final privileged = D4.getNamedArgWithDefault<bool>(named, 'privileged', false);
        final nothrow = D4.getNamedArgWithDefault<bool>(named, 'nothrow', false);
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final extensionSearch = D4.getNamedArgWithDefault<bool>(named, 'extensionSearch', true);
        final includeParentEnvironment = D4.getNamedArgWithDefault<bool>(named, 'includeParentEnvironment', true);
        if (!named.containsKey('encoding')) {
          return $pkg.startFromArgs(command, args, progress: progress, runInShell: runInShell, detached: detached, terminal: terminal, privileged: privileged, nothrow: nothrow, workingDirectory: workingDirectory, extensionSearch: extensionSearch, includeParentEnvironment: includeParentEnvironment);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'startFromArgs');
          return $pkg.startFromArgs(command, args, progress: progress, runInShell: runInShell, detached: detached, terminal: terminal, privileged: privileged, nothrow: nothrow, workingDirectory: workingDirectory, extensionSearch: extensionSearch, includeParentEnvironment: includeParentEnvironment, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'start': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'start');
        final commandLine = D4.getRequiredArg<String>(positional, 0, 'commandLine', 'start');
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
        final runInShell = D4.getNamedArgWithDefault<bool>(named, 'runInShell', false);
        final detached = D4.getNamedArgWithDefault<bool>(named, 'detached', false);
        final terminal = D4.getNamedArgWithDefault<bool>(named, 'terminal', false);
        final nothrow = D4.getNamedArgWithDefault<bool>(named, 'nothrow', false);
        final privileged = D4.getNamedArgWithDefault<bool>(named, 'privileged', false);
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final extensionSearch = D4.getNamedArgWithDefault<bool>(named, 'extensionSearch', true);
        final includeParentEnvironment = D4.getNamedArgWithDefault<bool>(named, 'includeParentEnvironment', true);
        if (!named.containsKey('encoding')) {
          return $pkg.start(commandLine, progress: progress, runInShell: runInShell, detached: detached, terminal: terminal, nothrow: nothrow, privileged: privileged, workingDirectory: workingDirectory, extensionSearch: extensionSearch, includeParentEnvironment: includeParentEnvironment);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'start');
          return $pkg.start(commandLine, progress: progress, runInShell: runInShell, detached: detached, terminal: terminal, nothrow: nothrow, privileged: privileged, workingDirectory: workingDirectory, extensionSearch: extensionSearch, includeParentEnvironment: includeParentEnvironment, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'sleep': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'sleep');
        final duration = D4.getRequiredArg<int>(positional, 0, 'duration', 'sleep');
        final interval = D4.getNamedArgWithDefault<$pkg.Interval>(named, 'interval', $pkg.Interval.seconds);
        return $pkg.sleep(duration, interval: interval);
      },
      'sleepAsync': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'sleepAsync');
        final duration = D4.getRequiredArg<int>(positional, 0, 'duration', 'sleepAsync');
        final interval = D4.getNamedArgWithDefault<$pkg.Interval>(named, 'interval', $pkg.Interval.seconds);
        return $pkg.sleepAsync(duration, interval: interval);
      },
      'tail': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'tail');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'tail');
        final lines = D4.getRequiredArg<int>(positional, 1, 'lines', 'tail');
        return $pkg.tail(path, lines);
      },
      'which': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'which');
        final appname = D4.getRequiredArg<String>(positional, 0, 'appname', 'which');
        final first = D4.getNamedArgWithDefault<bool>(named, 'first', true);
        final verbose = D4.getNamedArgWithDefault<bool>(named, 'verbose', false);
        final extensionSearch = D4.getNamedArgWithDefault<bool>(named, 'extensionSearch', true);
        final progress = D4.getOptionalNamedArg<Sink<String>?>(named, 'progress');
        return $pkg.which(appname, first: first, verbose: verbose, extensionSearch: extensionSearch, progress: progress);
      },
      'addUnitTestOverrides': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'addUnitTestOverrides');
        final pathToProject = D4.getRequiredArg<String>(positional, 0, 'pathToProject', 'addUnitTestOverrides');
        return $pkg.addUnitTestOverrides(pathToProject);
      },
      'capture': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'capture');
        if (positional.isEmpty) {
          throw ArgumentError('capture: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        final action = () { return (actionRaw as InterpretedFunction).call(visitor, []) as Future<dynamic>; };
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
        return $pkg.capture<dynamic>(action, progress: progress);
      },
      'showEditor': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'showEditor');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'showEditor');
        return $pkg.showEditor(path);
      },
      'withOpenFile': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'withOpenFile');
        final pathToFile = D4.getRequiredArg<String>(positional, 0, 'pathToFile', 'withOpenFile');
        if (positional.length <= 1) {
          throw ArgumentError('withOpenFile: Missing required argument "action" at position 1');
        }
        final actionRaw = positional[1];
        final action = ($pkg.FileSync p0) { return (actionRaw as InterpretedFunction).call(visitor, [p0]) as dynamic; };
        final fileMode = D4.getNamedArgWithDefault<FileMode>(named, 'fileMode', FileMode.writeOnlyAppend);
        return $pkg.withOpenFile<dynamic>(pathToFile, action, fileMode: fileMode);
      },
      'createSymLink': (visitor, positional, named, typeArgs) {
        final targetPath = D4.getRequiredNamedArg<String>(named, 'targetPath', 'createSymLink');
        final linkPath = D4.getRequiredNamedArg<String>(named, 'linkPath', 'createSymLink');
        return $pkg.createSymLink(targetPath: targetPath, linkPath: linkPath);
      },
      'deleteSymlink': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'deleteSymlink');
        final linkPath = D4.getRequiredArg<String>(positional, 0, 'linkPath', 'deleteSymlink');
        return $pkg.deleteSymlink(linkPath);
      },
      'resolveSymLink': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'resolveSymLink');
        final pathToLink = D4.getRequiredArg<String>(positional, 0, 'pathToLink', 'resolveSymLink');
        return $pkg.resolveSymLink(pathToLink);
      },
      'stat': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'stat');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'stat');
        return $pkg.stat(path);
      },
      'fileLength': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'fileLength');
        final pathToFile = D4.getRequiredArg<String>(positional, 0, 'pathToFile', 'fileLength');
        return $pkg.fileLength(pathToFile);
      },
      'calculateHash': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'calculateHash');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'calculateHash');
        return $pkg.calculateHash(path);
      },
      'printerr': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'printerr');
        final object = D4.getRequiredArg<Object?>(positional, 0, 'object', 'printerr');
        return $pkg.printerr(object);
      },
    };
  }

  /// Returns a map of global function names to their canonical source URIs.
  ///
  /// Used for deduplication when the same function is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> globalFunctionSourceUris() {
    return {
      'isOnPATH': 'package:dcli_core/src/functions/env.dart',
      'withEnvironmentAsync': 'package:dcli_core/src/functions/env.dart',
      'devNull': 'package:dcli_core/src/util/dev_null.dart',
      'withOpenLineFile': 'package:dcli_core/src/util/line_file.dart',
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
      'isOnPATH': 'bool isOnPATH(String path)',
      'withEnvironmentAsync': 'Future<R> withEnvironmentAsync(Future<R> Function() callback, {required Map<String, String> environment})',
      'devNull': 'void devNull(String? line)',
      'withOpenLineFile': 'R withOpenLineFile(String pathToFile, R Function(LineFile) action, {FileMode fileMode = FileMode.writeOnlyAppend})',
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
      'package:dcli_core/src/functions/backup.dart',
      'package:dcli_core/src/functions/cat.dart',
      'package:dcli_core/src/functions/copy.dart',
      'package:dcli_core/src/functions/create_dir.dart',
      'package:dcli_core/src/functions/delete.dart',
      'package:dcli_core/src/functions/delete_dir.dart',
      'package:dcli_core/src/functions/env.dart',
      'package:dcli_core/src/functions/find.dart',
      'package:dcli_core/src/functions/move.dart',
      'package:dcli_core/src/functions/move_dir.dart',
      'package:dcli_core/src/functions/move_tree.dart',
      'package:dcli_core/src/functions/pwd.dart',
      'package:dcli_core/src/functions/which.dart',
      'package:dcli_core/src/util/dcli_exception.dart',
      'package:dcli_core/src/util/dcli_platform.dart',
      'package:dcli_core/src/util/dev_null.dart',
      'package:dcli_core/src/util/line_file.dart',
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
    imports.writeln("import 'package:dcli_core/dcli_core.dart';");
    return imports.toString();
  }

  /// Returns a list of bridged enum names.
  static List<String> get enumNames => [
    'DCliPlatformOS',
    'TableAlignment',
    'TerminalClearMode',
    'FetchMethod',
    'FetchStatus',
    'Interval',
    'SortDirection',
  ];

}

// =============================================================================
// RestoreFileException Bridge
// =============================================================================

BridgedClass _createRestoreFileExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg2.RestoreFileException,
    name: 'RestoreFileException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'RestoreFileException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'RestoreFileException');
        return $pkg2.RestoreFileException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.RestoreFileException>(target, 'RestoreFileException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.RestoreFileException>(target, 'RestoreFileException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.RestoreFileException>(target, 'RestoreFileException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg2.RestoreFileException>(target, 'RestoreFileException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.RestoreFileException>(target, 'RestoreFileException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.RestoreFileException>(target, 'RestoreFileException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.RestoreFileException>(target, 'RestoreFileException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.RestoreFileException>(target, 'RestoreFileException');
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
    nativeType: $pkg2.BackupFileException,
    name: 'BackupFileException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'BackupFileException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'BackupFileException');
        return $pkg2.BackupFileException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.BackupFileException>(target, 'BackupFileException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.BackupFileException>(target, 'BackupFileException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.BackupFileException>(target, 'BackupFileException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg2.BackupFileException>(target, 'BackupFileException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.BackupFileException>(target, 'BackupFileException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.BackupFileException>(target, 'BackupFileException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.BackupFileException>(target, 'BackupFileException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.BackupFileException>(target, 'BackupFileException');
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
// CatException Bridge
// =============================================================================

BridgedClass _createCatExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg2.CatException,
    name: 'CatException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CatException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'CatException');
        final stacktrace = D4.getOptionalArg<dynamic>(positional, 1, 'stacktrace');
        return $pkg2.CatException(message, stacktrace);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.CatException>(target, 'CatException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.CatException>(target, 'CatException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.CatException>(target, 'CatException').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.CatException>(target, 'CatException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.CatException>(target, 'CatException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.CatException>(target, 'CatException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.CatException>(target, 'CatException');
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
  );
}

// =============================================================================
// CopyException Bridge
// =============================================================================

BridgedClass _createCopyExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg2.CopyException,
    name: 'CopyException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CopyException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'CopyException');
        return $pkg2.CopyException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.CopyException>(target, 'CopyException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.CopyException>(target, 'CopyException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.CopyException>(target, 'CopyException').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.CopyException>(target, 'CopyException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.CopyException>(target, 'CopyException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.CopyException>(target, 'CopyException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.CopyException>(target, 'CopyException');
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
  );
}

// =============================================================================
// CreateDirException Bridge
// =============================================================================

BridgedClass _createCreateDirExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg2.CreateDirException,
    name: 'CreateDirException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CreateDirException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'CreateDirException');
        return $pkg2.CreateDirException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.CreateDirException>(target, 'CreateDirException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.CreateDirException>(target, 'CreateDirException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.CreateDirException>(target, 'CreateDirException').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.CreateDirException>(target, 'CreateDirException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.CreateDirException>(target, 'CreateDirException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.CreateDirException>(target, 'CreateDirException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.CreateDirException>(target, 'CreateDirException');
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
  );
}

// =============================================================================
// DeleteException Bridge
// =============================================================================

BridgedClass _createDeleteExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg2.DeleteException,
    name: 'DeleteException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DeleteException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DeleteException');
        return $pkg2.DeleteException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.DeleteException>(target, 'DeleteException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.DeleteException>(target, 'DeleteException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.DeleteException>(target, 'DeleteException').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.DeleteException>(target, 'DeleteException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.DeleteException>(target, 'DeleteException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.DeleteException>(target, 'DeleteException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.DeleteException>(target, 'DeleteException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'DeleteException(String message)',
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
  );
}

// =============================================================================
// DeleteDirException Bridge
// =============================================================================

BridgedClass _createDeleteDirExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg2.DeleteDirException,
    name: 'DeleteDirException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DeleteDirException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DeleteDirException');
        return $pkg2.DeleteDirException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.DeleteDirException>(target, 'DeleteDirException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.DeleteDirException>(target, 'DeleteDirException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.DeleteDirException>(target, 'DeleteDirException').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.DeleteDirException>(target, 'DeleteDirException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.DeleteDirException>(target, 'DeleteDirException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.DeleteDirException>(target, 'DeleteDirException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.DeleteDirException>(target, 'DeleteDirException');
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
  );
}

// =============================================================================
// Env Bridge
// =============================================================================

BridgedClass _createEnvBridge() {
  return BridgedClass(
    nativeType: $pkg2.Env,
    name: 'Env',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg2.Env();
      },
      'forScope': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'Env');
        if (positional.isEmpty) {
          throw ArgumentError('Env: Missing required argument "map" at position 0');
        }
        final map = D4.coerceMap<String, String>(positional[0], 'map');
        return $pkg2.Env.forScope(map);
      },
    },
    getters: {
      'caseSensitive': (visitor, target) => D4.validateTarget<$pkg2.Env>(target, 'Env').caseSensitive,
      'entries': (visitor, target) => D4.validateTarget<$pkg2.Env>(target, 'Env').entries,
      'HOME': (visitor, target) => D4.validateTarget<$pkg2.Env>(target, 'Env').HOME,
      'delimiterForPATH': (visitor, target) => D4.validateTarget<$pkg2.Env>(target, 'Env').delimiterForPATH,
    },
    methods: {
      'addAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'addAll');
        if (positional.isEmpty) {
          throw ArgumentError('addAll: Missing required argument "other" at position 0');
        }
        final other = D4.coerceMap<String, String>(positional[0], 'other');
        t.addAll(other);
        return null;
      },
      'exists': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'exists');
        final key = D4.getRequiredArg<String>(positional, 0, 'key', 'exists');
        return t.exists(key);
      },
      'appendToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'appendToPATH');
        final newPath = D4.getRequiredArg<String>(positional, 0, 'newPath', 'appendToPATH');
        t.appendToPATH(newPath);
        return null;
      },
      'prependToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'prependToPATH');
        final newPath = D4.getRequiredArg<String>(positional, 0, 'newPath', 'prependToPATH');
        t.prependToPATH(newPath);
        return null;
      },
      'removeFromPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'removeFromPATH');
        final oldPath = D4.getRequiredArg<String>(positional, 0, 'oldPath', 'removeFromPATH');
        t.removeFromPATH(oldPath);
        return null;
      },
      'addToPATHIfAbsent': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'addToPATHIfAbsent');
        final newPath = D4.getRequiredArg<String>(positional, 0, 'newPath', 'addToPATHIfAbsent');
        t.addToPATHIfAbsent(newPath);
        return null;
      },
      'isOnPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'isOnPATH');
        final checkPath = D4.getRequiredArg<String>(positional, 0, 'checkPath', 'isOnPATH');
        return t.isOnPATH(checkPath);
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.Env>(target, 'Env');
        return t.toJson();
      },
      'fromJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.Env>(target, 'Env');
        D4.requireMinArgs(positional, 1, 'fromJson');
        final json = D4.getRequiredArg<String>(positional, 0, 'json', 'fromJson');
        t.fromJson(json);
        return null;
      },
      '[]': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.Env>(target, 'Env');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]');
        return t[index];
      },
      '[]=': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.Env>(target, 'Env');
        final index = D4.getRequiredArg<String>(positional, 0, 'index', 'operator[]=');
        final value = D4.getRequiredArg<String?>(positional, 1, 'value', 'operator[]=');
        t[index] = value;
        return null;
      },
    },
    staticGetters: {
      'scopeKey': (visitor) => $pkg2.Env.scopeKey,
    },
    staticSetters: {
      'scopeKey': (visitor, value) => 
        $pkg2.Env.scopeKey = value as dynamic,
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
// Find Bridge
// =============================================================================

BridgedClass _createFindBridge() {
  return BridgedClass(
    nativeType: $pkg2.Find,
    name: 'Find',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg2.Find();
      },
    },
    staticGetters: {
      'file': (visitor) => $pkg2.Find.file,
      'directory': (visitor) => $pkg2.Find.directory,
      'link': (visitor) => $pkg2.Find.link,
    },
    constructorSignatures: {
      '': 'Find()',
    },
    staticGetterSignatures: {
      'file': 'FileSystemEntityType get file',
      'directory': 'FileSystemEntityType get directory',
      'link': 'FileSystemEntityType get link',
    },
  );
}

// =============================================================================
// PatternMatcher Bridge
// =============================================================================

BridgedClass _createPatternMatcherBridge() {
  return BridgedClass(
    nativeType: $pkg2.PatternMatcher,
    name: 'PatternMatcher',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'PatternMatcher');
        final pattern = D4.getRequiredArg<String>(positional, 0, 'pattern', 'PatternMatcher');
        final workingDirectory = D4.getRequiredNamedArg<String>(named, 'workingDirectory', 'PatternMatcher');
        final caseSensitive = D4.getRequiredNamedArg<bool>(named, 'caseSensitive', 'PatternMatcher');
        return $pkg2.PatternMatcher(pattern, workingDirectory: workingDirectory, caseSensitive: caseSensitive);
      },
    },
    getters: {
      'pattern': (visitor, target) => D4.validateTarget<$pkg2.PatternMatcher>(target, 'PatternMatcher').pattern,
      'workingDirectory': (visitor, target) => D4.validateTarget<$pkg2.PatternMatcher>(target, 'PatternMatcher').workingDirectory,
      'regEx': (visitor, target) => D4.validateTarget<$pkg2.PatternMatcher>(target, 'PatternMatcher').regEx,
      'caseSensitive': (visitor, target) => D4.validateTarget<$pkg2.PatternMatcher>(target, 'PatternMatcher').caseSensitive,
      'directoryParts': (visitor, target) => D4.validateTarget<$pkg2.PatternMatcher>(target, 'PatternMatcher').directoryParts,
    },
    setters: {
      'pattern': (visitor, target, value) => 
        D4.validateTarget<$pkg2.PatternMatcher>(target, 'PatternMatcher').pattern = value as String,
      'workingDirectory': (visitor, target, value) => 
        D4.validateTarget<$pkg2.PatternMatcher>(target, 'PatternMatcher').workingDirectory = value as String,
      'regEx': (visitor, target, value) => 
        D4.validateTarget<$pkg2.PatternMatcher>(target, 'PatternMatcher').regEx = value as RegExp,
      'caseSensitive': (visitor, target, value) => 
        D4.validateTarget<$pkg2.PatternMatcher>(target, 'PatternMatcher').caseSensitive = value as bool,
      'directoryParts': (visitor, target, value) => 
        D4.validateTarget<$pkg2.PatternMatcher>(target, 'PatternMatcher').directoryParts = value as int,
    },
    methods: {
      'match': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.PatternMatcher>(target, 'PatternMatcher');
        D4.requireMinArgs(positional, 1, 'match');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'match');
        return t.match(path);
      },
      'buildRegEx': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.PatternMatcher>(target, 'PatternMatcher');
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
      'directoryParts': 'set directoryParts(dynamic value)',
    },
  );
}

// =============================================================================
// FindItem Bridge
// =============================================================================

BridgedClass _createFindItemBridge() {
  return BridgedClass(
    nativeType: $pkg2.FindItem,
    name: 'FindItem',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FindItem');
        final pathTo = D4.getRequiredArg<String>(positional, 0, 'pathTo', 'FindItem');
        final type = D4.getRequiredArg<FileSystemEntityType>(positional, 1, 'type', 'FindItem');
        return $pkg2.FindItem(pathTo, type);
      },
    },
    getters: {
      'pathTo': (visitor, target) => D4.validateTarget<$pkg2.FindItem>(target, 'FindItem').pathTo,
      'type': (visitor, target) => D4.validateTarget<$pkg2.FindItem>(target, 'FindItem').type,
    },
    setters: {
      'pathTo': (visitor, target, value) => 
        D4.validateTarget<$pkg2.FindItem>(target, 'FindItem').pathTo = value as String,
      'type': (visitor, target, value) => 
        D4.validateTarget<$pkg2.FindItem>(target, 'FindItem').type = value as FileSystemEntityType,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.FindItem>(target, 'FindItem');
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
    nativeType: $pkg2.FindException,
    name: 'FindException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FindException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'FindException');
        return $pkg2.FindException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.FindException>(target, 'FindException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.FindException>(target, 'FindException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.FindException>(target, 'FindException').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.FindException>(target, 'FindException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.FindException>(target, 'FindException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.FindException>(target, 'FindException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.FindException>(target, 'FindException');
        return t.toJsonString();
      },
    },
    constructorSignatures: {
      '': 'FindException(String message)',
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
  );
}

// =============================================================================
// FindConfig Bridge
// =============================================================================

BridgedClass _createFindConfigBridge() {
  return BridgedClass(
    nativeType: $pkg2.FindConfig,
    name: 'FindConfig',
    constructors: {
      'build': (visitor, positional, named) {
        final pattern = D4.getRequiredNamedArg<String>(named, 'pattern', 'FindConfig');
        final workingDirectory = D4.getRequiredNamedArg<String>(named, 'workingDirectory', 'FindConfig');
        final includeHidden = D4.getRequiredNamedArg<bool>(named, 'includeHidden', 'FindConfig');
        final caseSensitive = D4.getRequiredNamedArg<bool>(named, 'caseSensitive', 'FindConfig');
        return $pkg2.FindConfig.build(pattern: pattern, workingDirectory: workingDirectory, includeHidden: includeHidden, caseSensitive: caseSensitive);
      },
    },
    getters: {
      'workingDirectory': (visitor, target) => D4.validateTarget<$pkg2.FindConfig>(target, 'FindConfig').workingDirectory,
      'pattern': (visitor, target) => D4.validateTarget<$pkg2.FindConfig>(target, 'FindConfig').pattern,
      'includeHidden': (visitor, target) => D4.validateTarget<$pkg2.FindConfig>(target, 'FindConfig').includeHidden,
      'caseSensitive': (visitor, target) => D4.validateTarget<$pkg2.FindConfig>(target, 'FindConfig').caseSensitive,
      'matcher': (visitor, target) => D4.validateTarget<$pkg2.FindConfig>(target, 'FindConfig').matcher,
    },
    setters: {
      'workingDirectory': (visitor, target, value) => 
        D4.validateTarget<$pkg2.FindConfig>(target, 'FindConfig').workingDirectory = value as String,
      'pattern': (visitor, target, value) => 
        D4.validateTarget<$pkg2.FindConfig>(target, 'FindConfig').pattern = value as String,
      'includeHidden': (visitor, target, value) => 
        D4.validateTarget<$pkg2.FindConfig>(target, 'FindConfig').includeHidden = value as bool,
      'caseSensitive': (visitor, target, value) => 
        D4.validateTarget<$pkg2.FindConfig>(target, 'FindConfig').caseSensitive = value as bool,
      'matcher': (visitor, target, value) => 
        D4.validateTarget<$pkg2.FindConfig>(target, 'FindConfig').matcher = value as $pkg2.PatternMatcher,
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
// MoveException Bridge
// =============================================================================

BridgedClass _createMoveExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg2.MoveException,
    name: 'MoveException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MoveException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'MoveException');
        return $pkg2.MoveException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.MoveException>(target, 'MoveException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.MoveException>(target, 'MoveException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.MoveException>(target, 'MoveException').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.MoveException>(target, 'MoveException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.MoveException>(target, 'MoveException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.MoveException>(target, 'MoveException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.MoveException>(target, 'MoveException');
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
  );
}

// =============================================================================
// MoveDirException Bridge
// =============================================================================

BridgedClass _createMoveDirExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg2.MoveDirException,
    name: 'MoveDirException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MoveDirException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'MoveDirException');
        return $pkg2.MoveDirException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.MoveDirException>(target, 'MoveDirException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.MoveDirException>(target, 'MoveDirException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.MoveDirException>(target, 'MoveDirException').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.MoveDirException>(target, 'MoveDirException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.MoveDirException>(target, 'MoveDirException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.MoveDirException>(target, 'MoveDirException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.MoveDirException>(target, 'MoveDirException');
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
  );
}

// =============================================================================
// MoveTreeException Bridge
// =============================================================================

BridgedClass _createMoveTreeExceptionBridge() {
  return BridgedClass(
    nativeType: $pkg2.MoveTreeException,
    name: 'MoveTreeException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'MoveTreeException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'MoveTreeException');
        return $pkg2.MoveTreeException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.MoveTreeException>(target, 'MoveTreeException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.MoveTreeException>(target, 'MoveTreeException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.MoveTreeException>(target, 'MoveTreeException').stackTrace,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.MoveTreeException>(target, 'MoveTreeException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.MoveTreeException>(target, 'MoveTreeException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.MoveTreeException>(target, 'MoveTreeException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.MoveTreeException>(target, 'MoveTreeException');
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
  );
}

// =============================================================================
// Which Bridge
// =============================================================================

BridgedClass _createWhichBridge() {
  return BridgedClass(
    nativeType: $pkg2.Which,
    name: 'Which',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg2.Which();
      },
    },
    getters: {
      'progress': (visitor, target) => D4.validateTarget<$pkg2.Which>(target, 'Which').progress,
      'path': (visitor, target) => D4.validateTarget<$pkg2.Which>(target, 'Which').path,
      'paths': (visitor, target) => D4.validateTarget<$pkg2.Which>(target, 'Which').paths,
      'found': (visitor, target) => D4.validateTarget<$pkg2.Which>(target, 'Which').found,
      'notfound': (visitor, target) => D4.validateTarget<$pkg2.Which>(target, 'Which').notfound,
    },
    setters: {
      'progress': (visitor, target, value) => 
        D4.validateTarget<$pkg2.Which>(target, 'Which').progress = value as Stream<String>,
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

// =============================================================================
// WhichSearch Bridge
// =============================================================================

BridgedClass _createWhichSearchBridge() {
  return BridgedClass(
    nativeType: $pkg2.WhichSearch,
    name: 'WhichSearch',
    constructors: {
      'found': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'WhichSearch');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'WhichSearch');
        final exePath = D4.getRequiredArg<String?>(positional, 1, 'exePath', 'WhichSearch');
        return $pkg2.WhichSearch.found(path, exePath);
      },
      'notfound': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'WhichSearch');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'WhichSearch');
        return $pkg2.WhichSearch.notfound(path);
      },
    },
    getters: {
      'path': (visitor, target) => D4.validateTarget<$pkg2.WhichSearch>(target, 'WhichSearch').path,
      'found': (visitor, target) => D4.validateTarget<$pkg2.WhichSearch>(target, 'WhichSearch').found,
      'exePath': (visitor, target) => D4.validateTarget<$pkg2.WhichSearch>(target, 'WhichSearch').exePath,
    },
    setters: {
      'path': (visitor, target, value) => 
        D4.validateTarget<$pkg2.WhichSearch>(target, 'WhichSearch').path = value as String,
      'found': (visitor, target, value) => 
        D4.validateTarget<$pkg2.WhichSearch>(target, 'WhichSearch').found = value as bool,
      'exePath': (visitor, target, value) => 
        D4.validateTarget<$pkg2.WhichSearch>(target, 'WhichSearch').exePath = value as String?,
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
    nativeType: $pkg2.DCliException,
    name: 'DCliException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DCliException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'DCliException');
        final stackTrace = D4.getOptionalArg<dynamic>(positional, 1, 'stackTrace');
        return $pkg2.DCliException(message, stackTrace);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DCliException');
        final jsonStr = D4.getRequiredArg<String>(positional, 0, 'jsonStr', 'DCliException');
        return $pkg2.DCliException.fromJson(jsonStr);
      },
      'from': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DCliException');
        final cause = D4.getRequiredArg<Object?>(positional, 0, 'cause', 'DCliException');
        final stackTrace = D4.getRequiredArg<dynamic>(positional, 1, 'stackTrace', 'DCliException');
        return $pkg2.DCliException.from(cause, stackTrace);
      },
      'fromException': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DCliException');
        final cause = D4.getRequiredArg<Object?>(positional, 0, 'cause', 'DCliException');
        return $pkg2.DCliException.fromException(cause);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.DCliException>(target, 'DCliException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.DCliException>(target, 'DCliException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.DCliException>(target, 'DCliException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg2.DCliException>(target, 'DCliException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.DCliException>(target, 'DCliException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.DCliException>(target, 'DCliException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.DCliException>(target, 'DCliException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.DCliException>(target, 'DCliException');
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
    nativeType: $pkg2.DCliPlatform,
    name: 'DCliPlatform',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg2.DCliPlatform();
      },
      'forScope': (visitor, positional, named) {
        final overriddenPlatform = D4.getOptionalNamedArg<$pkg2.DCliPlatformOS?>(named, 'overriddenPlatform');
        return $pkg2.DCliPlatform.forScope(overriddenPlatform: overriddenPlatform);
      },
    },
    getters: {
      'overriddenPlatform': (visitor, target) => D4.validateTarget<$pkg2.DCliPlatform>(target, 'DCliPlatform').overriddenPlatform,
      'isMacOS': (visitor, target) => D4.validateTarget<$pkg2.DCliPlatform>(target, 'DCliPlatform').isMacOS,
      'isLinux': (visitor, target) => D4.validateTarget<$pkg2.DCliPlatform>(target, 'DCliPlatform').isLinux,
      'isWindows': (visitor, target) => D4.validateTarget<$pkg2.DCliPlatform>(target, 'DCliPlatform').isWindows,
    },
    setters: {
      'overriddenPlatform': (visitor, target, value) => 
        D4.validateTarget<$pkg2.DCliPlatform>(target, 'DCliPlatform').overriddenPlatform = value as $pkg2.DCliPlatformOS?,
    },
    staticGetters: {
      'scopeKey': (visitor) => $pkg2.DCliPlatform.scopeKey,
    },
    staticSetters: {
      'scopeKey': (visitor, value) => 
        $pkg2.DCliPlatform.scopeKey = value as dynamic,
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
      'scopeKey': 'dynamic get scopeKey',
    },
    staticSetterSignatures: {
      'scopeKey': 'set scopeKey(dynamic value)',
    },
  );
}

// =============================================================================
// LineFile Bridge
// =============================================================================

BridgedClass _createLineFileBridge() {
  return BridgedClass(
    nativeType: $pkg2.LineFile,
    name: 'LineFile',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LineFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'LineFile');
        final fileMode = D4.getNamedArgWithDefault<FileMode>(named, 'fileMode', FileMode.writeOnlyAppend);
        return $pkg2.LineFile(path, fileMode: fileMode);
      },
    },
    getters: {
      'length': (visitor, target) => D4.validateTarget<$pkg2.LineFile>(target, 'LineFile').length,
    },
    methods: {
      'flush': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.LineFile>(target, 'LineFile');
        t.flush();
        return null;
      },
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.LineFile>(target, 'LineFile');
        t.close();
        return null;
      },
      'readAll': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.LineFile>(target, 'LineFile');
        D4.requireMinArgs(positional, 1, 'readAll');
        if (positional.isEmpty) {
          throw ArgumentError('readAll: Missing required argument "handleLine" at position 0');
        }
        final handleLineRaw = positional[0];
        t.readAll((String p0) { return (handleLineRaw as InterpretedFunction).call(visitor, [p0]) as bool; });
        return null;
      },
      'write': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.LineFile>(target, 'LineFile');
        D4.requireMinArgs(positional, 1, 'write');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'write');
        final newline = D4.getOptionalNamedArg<String?>(named, 'newline');
        t.write(line, newline: newline);
        return null;
      },
      'append': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.LineFile>(target, 'LineFile');
        D4.requireMinArgs(positional, 1, 'append');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'append');
        final newline = D4.getOptionalNamedArg<String?>(named, 'newline');
        t.append(line, newline: newline);
        return null;
      },
      'read': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.LineFile>(target, 'LineFile');
        final lineDelimiter = D4.getOptionalNamedArg<String?>(named, 'lineDelimiter');
        return t.read(lineDelimiter: lineDelimiter);
      },
      'truncate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.LineFile>(target, 'LineFile');
        t.truncate();
        return null;
      },
      'open': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.LineFile>(target, 'LineFile');
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
    nativeType: $pkg2.RunException,
    name: 'RunException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'RunException');
        final cmdLine = D4.getRequiredArg<String>(positional, 0, 'cmdLine', 'RunException');
        final exitCode = D4.getRequiredArg<int?>(positional, 1, 'exitCode', 'RunException');
        final reason = D4.getRequiredArg<String>(positional, 2, 'reason', 'RunException');
        final stackTrace = D4.getOptionalNamedArg<dynamic>(named, 'stackTrace');
        return $pkg2.RunException(cmdLine, exitCode, reason, stackTrace: stackTrace);
      },
      'fromJson': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'RunException');
        if (positional.isEmpty) {
          throw ArgumentError('RunException: Missing required argument "json" at position 0');
        }
        final json = D4.coerceMap<String, dynamic>(positional[0], 'json');
        return $pkg2.RunException.fromJson(json);
      },
      'fromJsonString': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'RunException');
        final jsonString = D4.getRequiredArg<String>(positional, 0, 'jsonString', 'RunException');
        return $pkg2.RunException.fromJsonString(jsonString);
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
        return $pkg2.RunException.withArgs(cmd, args, exitCode, reason, stackTrace: stackTrace);
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
        return $pkg2.RunException.fromException(exception, cmd, args, stackTrace: stackTrace);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg2.RunException>(target, 'RunException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg2.RunException>(target, 'RunException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg2.RunException>(target, 'RunException').stackTrace,
      'cmdLine': (visitor, target) => D4.validateTarget<$pkg2.RunException>(target, 'RunException').cmdLine,
      'exitCode': (visitor, target) => D4.validateTarget<$pkg2.RunException>(target, 'RunException').exitCode,
      'reason': (visitor, target) => D4.validateTarget<$pkg2.RunException>(target, 'RunException').reason,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg2.RunException>(target, 'RunException').stackTrace = value as dynamic,
      'cmdLine': (visitor, target, value) => 
        D4.validateTarget<$pkg2.RunException>(target, 'RunException').cmdLine = value as String,
      'exitCode': (visitor, target, value) => 
        D4.validateTarget<$pkg2.RunException>(target, 'RunException').exitCode = value as int?,
      'reason': (visitor, target, value) => 
        D4.validateTarget<$pkg2.RunException>(target, 'RunException').reason = value as String,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.RunException>(target, 'RunException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.RunException>(target, 'RunException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.RunException>(target, 'RunException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.RunException>(target, 'RunException');
        return t.toJsonString();
      },
      'toJsonMap': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.RunException>(target, 'RunException');
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
    nativeType: $pkg2.StackList,
    name: 'StackList',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg2.StackList();
      },
      'fromList': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'StackList');
        if (positional.isEmpty) {
          throw ArgumentError('StackList: Missing required argument "initialStack" at position 0');
        }
        final initialStack = D4.coerceList<dynamic>(positional[0], 'initialStack');
        return $pkg2.StackList.fromList(initialStack);
      },
    },
    getters: {
      'isEmpty': (visitor, target) => D4.validateTarget<$pkg2.StackList>(target, 'StackList').isEmpty,
    },
    methods: {
      'push': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.StackList>(target, 'StackList');
        D4.requireMinArgs(positional, 1, 'push');
        final item = D4.getRequiredArg<dynamic>(positional, 0, 'item', 'push');
        t.push(item);
        return null;
      },
      'pop': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.StackList>(target, 'StackList');
        return t.pop();
      },
      'peek': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.StackList>(target, 'StackList');
        return t.peek();
      },
      'asList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg2.StackList>(target, 'StackList');
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
    nativeType: $pkg.Ansi,
    name: 'Ansi',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Ansi();
      },
    },
    staticGetters: {
      'isSupported': (visitor) => $pkg.Ansi.isSupported,
      'resetEmitAnsi': (visitor) => $pkg.Ansi.resetEmitAnsi,
      'esc': (visitor) => $pkg.Ansi.esc,
    },
    staticMethods: {
      'strip': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'strip');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'strip');
        return $pkg.Ansi.strip(line);
      },
    },
    staticSetters: {
      'isSupported': (visitor, value) => 
        $pkg.Ansi.isSupported = value as dynamic,
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
    nativeType: ext_dcli_terminal_ansi_color.AnsiColor,
    name: 'AnsiColor',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AnsiColor');
        final code = D4.getRequiredArg<int>(positional, 0, 'code', 'AnsiColor');
        final bold = D4.getNamedArgWithDefault<bool>(named, 'bold', true);
        return ext_dcli_terminal_ansi_color.AnsiColor(code, bold: bold);
      },
    },
    getters: {
      'code': (visitor, target) => D4.validateTarget<ext_dcli_terminal_ansi_color.AnsiColor>(target, 'AnsiColor').code,
      'bold': (visitor, target) => D4.validateTarget<ext_dcli_terminal_ansi_color.AnsiColor>(target, 'AnsiColor').bold,
    },
    methods: {
      'apply': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_ansi_color.AnsiColor>(target, 'AnsiColor');
        D4.requireMinArgs(positional, 1, 'apply');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'apply');
        if (!named.containsKey('background')) {
          return t.apply(text);
        }
        if (named.containsKey('background')) {
          final background = D4.getRequiredNamedArg<ext_dcli_terminal_ansi_color.AnsiColor>(named, 'background', 'apply');
          return t.apply(text, background: background);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    staticGetters: {
      'codeBlack': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.codeBlack,
      'codeRed': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.codeRed,
      'codeGreen': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.codeGreen,
      'codeYellow': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.codeYellow,
      'codeBlue': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.codeBlue,
      'codeMagenta': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.codeMagenta,
      'codeCyan': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.codeCyan,
      'codeWhite': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.codeWhite,
      'codeOrange': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.codeOrange,
      'codeGrey': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.codeGrey,
      'black': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.black,
      'red': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.red,
      'green': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.green,
      'yellow': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.yellow,
      'blue': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.blue,
      'magenta': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.magenta,
      'cyan': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.cyan,
      'white': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.white,
      'orange': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.orange,
      'none': (visitor) => ext_dcli_terminal_ansi_color.AnsiColor.none,
    },
    staticMethods: {
      'reset': (visitor, positional, named, typeArgs) {
        return ext_dcli_terminal_ansi_color.AnsiColor.reset();
      },
      'fgReset': (visitor, positional, named, typeArgs) {
        return ext_dcli_terminal_ansi_color.AnsiColor.fgReset();
      },
      'bgReset': (visitor, positional, named, typeArgs) {
        return ext_dcli_terminal_ansi_color.AnsiColor.bgReset();
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
    nativeType: ext_dcli_terminal_format.Format,
    name: 'Format',
    constructors: {
      '': (visitor, positional, named) {
        return ext_dcli_terminal_format.Format();
      },
    },
    methods: {
      'row': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_format.Format>(target, 'Format');
        D4.requireMinArgs(positional, 1, 'row');
        if (positional.isEmpty) {
          throw ArgumentError('row: Missing required argument "cols" at position 0');
        }
        final cols = D4.coerceList<String?>(positional[0], 'cols');
        final widths = D4.coerceListOrNull<int>(named['widths'], 'widths');
        final alignments = D4.coerceListOrNull<ext_dcli_terminal_format.TableAlignment>(named['alignments'], 'alignments');
        final delimiter = D4.getOptionalNamedArg<String?>(named, 'delimiter');
        return t.row(cols, widths: widths, alignments: alignments, delimiter: delimiter);
      },
      'limitString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_format.Format>(target, 'Format');
        D4.requireMinArgs(positional, 1, 'limitString');
        final display = D4.getRequiredArg<String>(positional, 0, 'display', 'limitString');
        final width = D4.getNamedArgWithDefault<int>(named, 'width', 40);
        return t.limitString(display, width: width);
      },
      'percentage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_format.Format>(target, 'Format');
        D4.requireMinArgs(positional, 2, 'percentage');
        final progress = D4.getRequiredArg<double>(positional, 0, 'progress', 'percentage');
        final precision = D4.getRequiredArg<int>(positional, 1, 'precision', 'percentage');
        return t.percentage(progress, precision);
      },
      'bytesAsReadable': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_format.Format>(target, 'Format');
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
    nativeType: ext_dcli_terminal_terminal.Terminal,
    name: 'Terminal',
    constructors: {
      '': (visitor, positional, named) {
        return ext_dcli_terminal_terminal.Terminal();
      },
    },
    getters: {
      'isAnsi': (visitor, target) => D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal').isAnsi,
      'column': (visitor, target) => D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal').column,
      'columns': (visitor, target) => D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal').columns,
      'row': (visitor, target) => D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal').row,
      'hasTerminal': (visitor, target) => D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal').hasTerminal,
      'rows': (visitor, target) => D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal').rows,
      'lines': (visitor, target) => D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal').lines,
    },
    setters: {
      'column': (visitor, target, value) => 
        D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal').column = value as dynamic,
      'row': (visitor, target, value) => 
        D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal').row = value as dynamic,
    },
    methods: {
      'clearScreen': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal');
        final mode = D4.getNamedArgWithDefault<ext_dcli_terminal_terminal.TerminalClearMode>(named, 'mode', ext_dcli_terminal_terminal.TerminalClearMode.all);
        t.clearScreen(mode: mode);
        return null;
      },
      'overwriteLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal');
        D4.requireMinArgs(positional, 1, 'overwriteLine');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'overwriteLine');
        t.overwriteLine(text);
        return null;
      },
      'write': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal');
        D4.requireMinArgs(positional, 1, 'write');
        final text = D4.getRequiredArg<String>(positional, 0, 'text', 'write');
        t.write(text);
        return null;
      },
      'writeLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal');
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
        final t = D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal');
        final mode = D4.getNamedArgWithDefault<ext_dcli_terminal_terminal.TerminalClearMode>(named, 'mode', ext_dcli_terminal_terminal.TerminalClearMode.all);
        t.clearLine(mode: mode);
        return null;
      },
      'showCursor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal');
        final show = D4.getRequiredNamedArg<bool>(named, 'show', 'showCursor');
        t.showCursor(show: show);
        return null;
      },
      'cursorUp': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal');
        t.cursorUp();
        return null;
      },
      'cursorDown': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal');
        t.cursorDown();
        return null;
      },
      'cursorLeft': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal');
        t.cursorLeft();
        return null;
      },
      'cursorRight': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal');
        t.cursorRight();
        return null;
      },
      'startOfLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal');
        t.startOfLine();
        return null;
      },
      'home': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ext_dcli_terminal_terminal.Terminal>(target, 'Terminal');
        t.home();
        return null;
      },
    },
    staticMethods: {
      'previousLine': (visitor, positional, named, typeArgs) {
        return ext_dcli_terminal_terminal.Terminal.previousLine();
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
    nativeType: $pkg.Ask,
    name: 'Ask',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Ask();
      },
    },
    staticGetters: {
      'dontCare': (visitor) => $pkg.Ask.dontCare,
      'required': (visitor) => $pkg.Ask.required,
      'email': (visitor) => $pkg.Ask.email,
      'fqdn': (visitor) => $pkg.Ask.fqdn,
      'date': (visitor) => $pkg.Ask.date,
      'integer': (visitor) => $pkg.Ask.integer,
      'decimal': (visitor) => $pkg.Ask.decimal,
      'alpha': (visitor) => $pkg.Ask.alpha,
      'alphaNumeric': (visitor) => $pkg.Ask.alphaNumeric,
    },
    staticMethods: {
      'defaultPrompt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 3, 'defaultPrompt');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'defaultPrompt');
        final defaultValue = D4.getRequiredArg<String?>(positional, 1, 'defaultValue', 'defaultPrompt');
        final hidden = D4.getRequiredArg<bool>(positional, 2, 'hidden', 'defaultPrompt');
        return $pkg.Ask.defaultPrompt(prompt, defaultValue, hidden);
      },
      'any': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'any');
        if (positional.isEmpty) {
          throw ArgumentError('any: Missing required argument "validators" at position 0');
        }
        final validators = D4.coerceList<$pkg.AskValidator>(positional[0], 'validators');
        return $pkg.Ask.any(validators);
      },
      'all': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'all');
        if (positional.isEmpty) {
          throw ArgumentError('all: Missing required argument "validators" at position 0');
        }
        final validators = D4.coerceList<$pkg.AskValidator>(positional[0], 'validators');
        return $pkg.Ask.all(validators);
      },
      'ipAddress': (visitor, positional, named, typeArgs) {
        final version = D4.getNamedArgWithDefault<int>(named, 'version', $pkg.AskValidatorIPAddress.either);
        return $pkg.Ask.ipAddress(version: version);
      },
      'regExp': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'regExp');
        final regExp = D4.getRequiredArg<String>(positional, 0, 'regExp', 'regExp');
        final error = D4.getOptionalNamedArg<String?>(named, 'error');
        return $pkg.Ask.regExp(regExp, error: error);
      },
      'lengthMax': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'lengthMax');
        final maxLength = D4.getRequiredArg<int>(positional, 0, 'maxLength', 'lengthMax');
        return $pkg.Ask.lengthMax(maxLength);
      },
      'lengthMin': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'lengthMin');
        final minLength = D4.getRequiredArg<int>(positional, 0, 'minLength', 'lengthMin');
        return $pkg.Ask.lengthMin(minLength);
      },
      'lengthRange': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'lengthRange');
        final minLength = D4.getRequiredArg<int>(positional, 0, 'minLength', 'lengthRange');
        final maxLength = D4.getRequiredArg<int>(positional, 1, 'maxLength', 'lengthRange');
        return $pkg.Ask.lengthRange(minLength, maxLength);
      },
      'valueRange': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'valueRange');
        final minValue = D4.getRequiredArg<num>(positional, 0, 'minValue', 'valueRange');
        final maxValue = D4.getRequiredArg<num>(positional, 1, 'maxValue', 'valueRange');
        return $pkg.Ask.valueRange(minValue, maxValue);
      },
      'inList': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'inList');
        if (positional.isEmpty) {
          throw ArgumentError('inList: Missing required argument "validItems" at position 0');
        }
        final validItems = D4.coerceList<Object>(positional[0], 'validItems');
        final caseSensitive = D4.getNamedArgWithDefault<bool>(named, 'caseSensitive', false);
        return $pkg.Ask.inList(validItems, caseSensitive: caseSensitive);
      },
      'url': (visitor, positional, named, typeArgs) {
        final protocols = named.containsKey('protocols') && named['protocols'] != null
            ? D4.coerceList<String>(named['protocols'], 'protocols')
            : const ['https'];
        return $pkg.Ask.url(protocols: protocols);
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
    nativeType: $pkg.AskValidatorException,
    name: 'AskValidatorException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'AskValidatorException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'AskValidatorException');
        return $pkg.AskValidatorException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.AskValidatorException>(target, 'AskValidatorException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.AskValidatorException>(target, 'AskValidatorException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.AskValidatorException>(target, 'AskValidatorException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.AskValidatorException>(target, 'AskValidatorException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AskValidatorException>(target, 'AskValidatorException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AskValidatorException>(target, 'AskValidatorException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AskValidatorException>(target, 'AskValidatorException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AskValidatorException>(target, 'AskValidatorException');
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
    nativeType: $pkg.AskValidator,
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
    nativeType: $pkg.AskValidatorIPAddress,
    name: 'AskValidatorIPAddress',
    constructors: {
      '': (visitor, positional, named) {
        if (!named.containsKey('version')) {
          return $pkg.AskValidatorIPAddress();
        }
        if (named.containsKey('version')) {
          final version = D4.getRequiredNamedArg<int>(named, 'version', 'AskValidatorIPAddress');
          return $pkg.AskValidatorIPAddress(version: version);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'version': (visitor, target) => D4.validateTarget<$pkg.AskValidatorIPAddress>(target, 'AskValidatorIPAddress').version,
    },
    methods: {
      'validate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.AskValidatorIPAddress>(target, 'AskValidatorIPAddress');
        D4.requireMinArgs(positional, 1, 'validate');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'validate');
        final customErrorMessage = D4.getOptionalNamedArg<String?>(named, 'customErrorMessage');
        return t.validate(line, customErrorMessage: customErrorMessage);
      },
    },
    staticGetters: {
      'either': (visitor) => $pkg.AskValidatorIPAddress.either,
      'ipv4': (visitor) => $pkg.AskValidatorIPAddress.ipv4,
      'ipv6': (visitor) => $pkg.AskValidatorIPAddress.ipv6,
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
    nativeType: $pkg.Confirm,
    name: 'Confirm',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Confirm();
      },
    },
    staticMethods: {
      'defaultPrompt': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 2, 'defaultPrompt');
        final prompt = D4.getRequiredArg<String>(positional, 0, 'prompt', 'defaultPrompt');
        final defaultValue = D4.getRequiredArg<bool?>(positional, 1, 'defaultValue', 'defaultPrompt');
        return $pkg.Confirm.defaultPrompt(prompt, defaultValue);
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
    nativeType: $pkg.FetchData,
    name: 'FetchData',
    constructors: {
      'fromString': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FetchData');
        final string = D4.getRequiredArg<String>(positional, 0, 'string', 'FetchData');
        final mimeType = D4.getNamedArgWithDefault<String>(named, 'mimeType', 'text/plain');
        return $pkg.FetchData.fromString(string, mimeType: mimeType);
      },
      'fromFile': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FetchData');
        final pathToData = D4.getRequiredArg<String>(positional, 0, 'pathToData', 'FetchData');
        final mimeType = D4.getOptionalNamedArg<String?>(named, 'mimeType');
        return $pkg.FetchData.fromFile(pathToData, mimeType: mimeType);
      },
      'fromBytes': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FetchData');
        if (positional.isEmpty) {
          throw ArgumentError('FetchData: Missing required argument "bytes" at position 0');
        }
        final bytes = D4.coerceList<int>(positional[0], 'bytes');
        final mimeType = D4.getNamedArgWithDefault<String>(named, 'mimeType', 'application/octet-stream');
        return $pkg.FetchData.fromBytes(bytes, mimeType: mimeType);
      },
      'fromStream': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FetchData');
        final stream = D4.getRequiredArg<Stream<List<int>>>(positional, 0, 'stream', 'FetchData');
        final mimeType = D4.getNamedArgWithDefault<String>(named, 'mimeType', 'application/octet-stream');
        return $pkg.FetchData.fromStream(stream, mimeType: mimeType);
      },
    },
    getters: {
      'mimeType': (visitor, target) => D4.validateTarget<$pkg.FetchData>(target, 'FetchData').mimeType,
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
    nativeType: $pkg.FetchUrl,
    name: 'FetchUrl',
    constructors: {
      '': (visitor, positional, named) {
        final url = D4.getRequiredNamedArg<String>(named, 'url', 'FetchUrl');
        final saveToPath = D4.getRequiredNamedArg<String>(named, 'saveToPath', 'FetchUrl');
        final headers = D4.coerceMapOrNull<String, String>(named['headers'], 'headers');
        final method = D4.getNamedArgWithDefault<$pkg.FetchMethod>(named, 'method', $pkg.FetchMethod.get);
        final data = D4.getOptionalNamedArg<$pkg.FetchData?>(named, 'data');
        if (!named.containsKey('progress')) {
          return $pkg.FetchUrl(url: url, saveToPath: saveToPath, headers: headers, method: method, data: data);
        }
        if (named.containsKey('progress')) {
          final progressRaw = named['progress'];
          final progress = ($pkg.FetchProgress p0) { (progressRaw as InterpretedFunction).call(visitor, [p0]); };
          return $pkg.FetchUrl(url: url, saveToPath: saveToPath, headers: headers, method: method, data: data, progress: progress);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'url': (visitor, target) => D4.validateTarget<$pkg.FetchUrl>(target, 'FetchUrl').url,
      'saveToPath': (visitor, target) => D4.validateTarget<$pkg.FetchUrl>(target, 'FetchUrl').saveToPath,
      'progress': (visitor, target) => D4.validateTarget<$pkg.FetchUrl>(target, 'FetchUrl').progress,
      'method': (visitor, target) => D4.validateTarget<$pkg.FetchUrl>(target, 'FetchUrl').method,
      'headers': (visitor, target) => D4.validateTarget<$pkg.FetchUrl>(target, 'FetchUrl').headers,
      'data': (visitor, target) => D4.validateTarget<$pkg.FetchUrl>(target, 'FetchUrl').data,
    },
    setters: {
      'headers': (visitor, target, value) => 
        D4.validateTarget<$pkg.FetchUrl>(target, 'FetchUrl').headers = (value as Map).cast<String, String>(),
      'data': (visitor, target, value) => 
        D4.validateTarget<$pkg.FetchUrl>(target, 'FetchUrl').data = value as $pkg.FetchData?,
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
    nativeType: $pkg.FetchProgress,
    name: 'FetchProgress',
    constructors: {
    },
    getters: {
      'headers': (visitor, target) => D4.validateTarget<$pkg.FetchProgress>(target, 'FetchProgress').headers,
      'responseCode': (visitor, target) => D4.validateTarget<$pkg.FetchProgress>(target, 'FetchProgress').responseCode,
      'status': (visitor, target) => D4.validateTarget<$pkg.FetchProgress>(target, 'FetchProgress').status,
      'fetch': (visitor, target) => D4.validateTarget<$pkg.FetchProgress>(target, 'FetchProgress').fetch,
      'length': (visitor, target) => D4.validateTarget<$pkg.FetchProgress>(target, 'FetchProgress').length,
      'downloaded': (visitor, target) => D4.validateTarget<$pkg.FetchProgress>(target, 'FetchProgress').downloaded,
      'progress': (visitor, target) => D4.validateTarget<$pkg.FetchProgress>(target, 'FetchProgress').progress,
      'prior': (visitor, target) => D4.validateTarget<$pkg.FetchProgress>(target, 'FetchProgress').prior,
    },
    setters: {
      'prior': (visitor, target, value) => 
        D4.validateTarget<$pkg.FetchProgress>(target, 'FetchProgress').prior = value as $pkg.FetchProgress?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FetchProgress>(target, 'FetchProgress');
        return t.toString();
      },
    },
    staticMethods: {
      'showBytes': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'showBytes');
        final progress = D4.getRequiredArg<$pkg.FetchProgress>(positional, 0, 'progress', 'showBytes');
        return $pkg.FetchProgress.showBytes(progress);
      },
      'show': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'show');
        final progress = D4.getRequiredArg<$pkg.FetchProgress>(positional, 0, 'progress', 'show');
        final formatRaw = named['format'];
        final format = formatRaw == null ? null : ($pkg.FetchProgress p0) { return (formatRaw as InterpretedFunction).call(visitor, [p0]) as String; };
        return $pkg.FetchProgress.show(progress, format: format);
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
    nativeType: $pkg.FetchException,
    name: 'FetchException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FetchException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'FetchException');
        return $pkg.FetchException(message);
      },
      'fromException': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FetchException');
        final cause = D4.getRequiredArg<SocketException>(positional, 0, 'cause', 'FetchException');
        return $pkg.FetchException.fromException(cause);
      },
      'fromHttpError': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'FetchException');
        final errorCode = D4.getRequiredArg<int?>(positional, 0, 'errorCode', 'FetchException');
        final reasonPhrase = D4.getRequiredArg<String>(positional, 1, 'reasonPhrase', 'FetchException');
        return $pkg.FetchException.fromHttpError(errorCode, reasonPhrase);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.FetchException>(target, 'FetchException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.FetchException>(target, 'FetchException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.FetchException>(target, 'FetchException').stackTrace,
      'errorCode': (visitor, target) => D4.validateTarget<$pkg.FetchException>(target, 'FetchException').errorCode,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.FetchException>(target, 'FetchException').stackTrace = value as dynamic,
      'errorCode': (visitor, target, value) => 
        D4.validateTarget<$pkg.FetchException>(target, 'FetchException').errorCode = value as int?,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FetchException>(target, 'FetchException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FetchException>(target, 'FetchException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FetchException>(target, 'FetchException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FetchException>(target, 'FetchException');
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
    nativeType: $pkg.ReadException,
    name: 'ReadException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ReadException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'ReadException');
        final stacktrace = D4.getOptionalArg<dynamic>(positional, 1, 'stacktrace');
        return $pkg.ReadException(message, stacktrace);
      },
    },
    constructorSignatures: {
      '': 'ReadException(dynamic message, [dynamic stacktrace])',
    },
  );
}

// =============================================================================
// Progress Bridge
// =============================================================================

BridgedClass _createProgressBridge() {
  return BridgedClass(
    nativeType: $pkg.Progress,
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
          return $pkg.Progress((String p0) { (stdoutRaw as InterpretedFunction).call(visitor, [p0]); }, captureStdout: captureStdout, captureStderr: captureStderr);
        }
        if (named.containsKey('stderr') && !named.containsKey('encoding')) {
          final stderr = D4.getRequiredNamedArg<dynamic>(named, 'stderr', 'Progress');
          return $pkg.Progress((String p0) { (stdoutRaw as InterpretedFunction).call(visitor, [p0]); }, captureStdout: captureStdout, captureStderr: captureStderr, stderr: stderr);
        }
        if (!named.containsKey('stderr') && named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $pkg.Progress((String p0) { (stdoutRaw as InterpretedFunction).call(visitor, [p0]); }, captureStdout: captureStdout, captureStderr: captureStderr, encoding: encoding);
        }
        if (named.containsKey('stderr') && named.containsKey('encoding')) {
          final stderr = D4.getRequiredNamedArg<dynamic>(named, 'stderr', 'Progress');
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $pkg.Progress((String p0) { (stdoutRaw as InterpretedFunction).call(visitor, [p0]); }, captureStdout: captureStdout, captureStderr: captureStderr, stderr: stderr, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'print': (visitor, positional, named) {
        final capture = D4.getNamedArgWithDefault<bool>(named, 'capture', false);
        if (!named.containsKey('encoding')) {
          return $pkg.Progress.print(capture: capture);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $pkg.Progress.print(capture: capture, encoding: encoding);
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
          return $pkg.Progress.both((String p0) { (bothRaw as InterpretedFunction).call(visitor, [p0]); });
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $pkg.Progress.both((String p0) { (bothRaw as InterpretedFunction).call(visitor, [p0]); }, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'capture': (visitor, positional, named) {
        final captureStdout = D4.getNamedArgWithDefault<bool>(named, 'captureStdout', true);
        final captureStderr = D4.getNamedArgWithDefault<bool>(named, 'captureStderr', true);
        if (!named.containsKey('encoding')) {
          return $pkg.Progress.capture(captureStdout: captureStdout, captureStderr: captureStderr);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $pkg.Progress.capture(captureStdout: captureStdout, captureStderr: captureStderr, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'devNull': (visitor, positional, named) {
        if (!named.containsKey('encoding')) {
          return $pkg.Progress.devNull();
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $pkg.Progress.devNull(encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'printStdErr': (visitor, positional, named) {
        final capture = D4.getNamedArgWithDefault<bool>(named, 'capture', false);
        if (!named.containsKey('encoding')) {
          return $pkg.Progress.printStdErr(capture: capture);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $pkg.Progress.printStdErr(capture: capture, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'printStdOut': (visitor, positional, named) {
        final capture = D4.getNamedArgWithDefault<bool>(named, 'capture', false);
        if (!named.containsKey('encoding')) {
          return $pkg.Progress.printStdOut(capture: capture);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $pkg.Progress.printStdOut(capture: capture, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'stream': (visitor, positional, named) {
        final includeStderr = D4.getNamedArgWithDefault<bool>(named, 'includeStderr', false);
        if (!named.containsKey('encoding')) {
          return $pkg.Progress.stream(includeStderr: includeStderr);
        }
        if (named.containsKey('encoding')) {
          final encoding = D4.getRequiredNamedArg<Encoding>(named, 'encoding', 'Progress');
          return $pkg.Progress.stream(includeStderr: includeStderr, encoding: encoding);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
    },
    getters: {
      'exitCode': (visitor, target) => D4.validateTarget<$pkg.Progress>(target, 'Progress').exitCode,
      'lines': (visitor, target) => D4.validateTarget<$pkg.Progress>(target, 'Progress').lines,
      'stream': (visitor, target) => D4.validateTarget<$pkg.Progress>(target, 'Progress').stream,
      'firstLine': (visitor, target) => D4.validateTarget<$pkg.Progress>(target, 'Progress').firstLine,
    },
    methods: {
      'toList': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Progress>(target, 'Progress');
        return t.toList();
      },
      'forEach': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Progress>(target, 'Progress');
        D4.requireMinArgs(positional, 1, 'forEach');
        if (positional.isEmpty) {
          throw ArgumentError('forEach: Missing required argument "print" at position 0');
        }
        final printRaw = positional[0];
        t.forEach((String p0) { (printRaw as InterpretedFunction).call(visitor, [p0]); });
        return null;
      },
      'toParagraph': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Progress>(target, 'Progress');
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
    nativeType: $pkg.PackedResource,
    name: 'PackedResource',
    constructors: {
    },
    getters: {
      'content': (visitor, target) => D4.validateTarget<$pkg.PackedResource>(target, 'PackedResource').content,
      'checksum': (visitor, target) => D4.validateTarget<$pkg.PackedResource>(target, 'PackedResource').checksum,
      'originalPath': (visitor, target) => D4.validateTarget<$pkg.PackedResource>(target, 'PackedResource').originalPath,
    },
    methods: {
      'unpack': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PackedResource>(target, 'PackedResource');
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
    nativeType: $pkg.Resources,
    name: 'Resources',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Resources();
      },
    },
    getters: {
      'pathToRegistry': (visitor, target) => D4.validateTarget<$pkg.Resources>(target, 'Resources').pathToRegistry,
      'resourceRoot': (visitor, target) => D4.validateTarget<$pkg.Resources>(target, 'Resources').resourceRoot,
      'generatedRoot': (visitor, target) => D4.validateTarget<$pkg.Resources>(target, 'Resources').generatedRoot,
    },
    methods: {
      'pack': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Resources>(target, 'Resources');
        t.pack();
        return null;
      },
      'isExcluded': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Resources>(target, 'Resources');
        D4.requireMinArgs(positional, 2, 'isExcluded');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isExcluded');
        if (positional.length <= 1) {
          throw ArgumentError('isExcluded: Missing required argument "excludes" at position 1');
        }
        final excludes = D4.coerceList<String>(positional[1], 'excludes');
        return t.isExcluded(path, excludes);
      },
      'getExcludedPaths': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Resources>(target, 'Resources');
        D4.requireMinArgs(positional, 3, 'getExcludedPaths');
        final yaml = D4.getRequiredArg<dynamic>(positional, 0, 'yaml', 'getExcludedPaths');
        final path = D4.getRequiredArg<String>(positional, 1, 'path', 'getExcludedPaths');
        final index = D4.getRequiredArg<int>(positional, 2, 'index', 'getExcludedPaths');
        return t.getExcludedPaths(yaml, path, index);
      },
    },
    staticGetters: {
      'pathToPackYaml': (visitor) => $pkg.Resources.pathToPackYaml,
      'scopeKeyProjectRoot': (visitor) => $pkg.Resources.scopeKeyProjectRoot,
      'projectRoot': (visitor) => $pkg.Resources.projectRoot,
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
    nativeType: $pkg.ResourceException,
    name: 'ResourceException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ResourceException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'ResourceException');
        return $pkg.ResourceException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.ResourceException>(target, 'ResourceException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.ResourceException>(target, 'ResourceException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.ResourceException>(target, 'ResourceException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.ResourceException>(target, 'ResourceException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ResourceException>(target, 'ResourceException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ResourceException>(target, 'ResourceException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ResourceException>(target, 'ResourceException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ResourceException>(target, 'ResourceException');
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
    nativeType: $pkg.DartProject,
    name: 'DartProject',
    constructors: {
      'create': (visitor, positional, named) {
        final pathTo = D4.getRequiredNamedArg<String>(named, 'pathTo', 'DartProject');
        final templateName = D4.getRequiredNamedArg<String>(named, 'templateName', 'DartProject');
        return $pkg.DartProject.create(pathTo: pathTo, templateName: templateName);
      },
      'fromCache': (visitor, positional, named) {
        D4.requireMinArgs(positional, 2, 'DartProject');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'DartProject');
        final version = D4.getRequiredArg<String>(positional, 1, 'version', 'DartProject');
        return $pkg.DartProject.fromCache(name, version);
      },
      'fromPath': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DartProject');
        final pathToSearchFrom = D4.getRequiredArg<String>(positional, 0, 'pathToSearchFrom', 'DartProject');
        final search = D4.getNamedArgWithDefault<bool>(named, 'search', true);
        return $pkg.DartProject.fromPath(pathToSearchFrom, search: search);
      },
    },
    getters: {
      'pubSpec': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pubSpec,
      'pathToProjectRoot': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pathToProjectRoot,
      'pathToDartToolDir': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pathToDartToolDir,
      'pathToDartToolPackageConfig': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pathToDartToolPackageConfig,
      'pathToBinDir': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pathToBinDir,
      'pathToExampleDir': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pathToExampleDir,
      'pathToLibDir': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pathToLibDir,
      'pathToLibSrcDir': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pathToLibSrcDir,
      'pathToTestDir': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pathToTestDir,
      'pathToToolDir': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pathToToolDir,
      'pathToAnalysisOptions': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pathToAnalysisOptions,
      'pathToPubSpec': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pathToPubSpec,
      'pathToPubSpecLock': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').pathToPubSpecLock,
      'isReadyToRun': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').isReadyToRun,
      'isFlutterProject': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').isFlutterProject,
      'hasPubSpec': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').hasPubSpec,
      'hasAnalysisOptions': (visitor, target) => D4.validateTarget<$pkg.DartProject>(target, 'DartProject').hasAnalysisOptions,
    },
    methods: {
      'doctor': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartProject>(target, 'DartProject');
        t.doctor();
        return null;
      },
      'warmup': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartProject>(target, 'DartProject');
        final background = D4.getNamedArgWithDefault<bool>(named, 'background', false);
        final upgrade = D4.getNamedArgWithDefault<bool>(named, 'upgrade', false);
        return t.warmup(background: background, upgrade: upgrade);
      },
      'clean': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartProject>(target, 'DartProject');
        return t.clean();
      },
      'compile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartProject>(target, 'DartProject');
        final install = D4.getNamedArgWithDefault<bool>(named, 'install', false);
        final overwrite = D4.getNamedArgWithDefault<bool>(named, 'overwrite', false);
        return t.compile(install: install, overwrite: overwrite);
      },
    },
    staticGetters: {
      'current': (visitor) => $pkg.DartProject.current,
      'self': (visitor) => $pkg.DartProject.self,
    },
    staticMethods: {
      'findProject': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'findProject');
        final pathToSearchFrom = D4.getRequiredArg<String>(positional, 0, 'pathToSearchFrom', 'findProject');
        final search = D4.getNamedArgWithDefault<bool>(named, 'search', true);
        return $pkg.DartProject.findProject(pathToSearchFrom, search: search);
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
    nativeType: $pkg.DartProjectException,
    name: 'DartProjectException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DartProjectException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'DartProjectException');
        return $pkg.DartProjectException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.DartProjectException>(target, 'DartProjectException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.DartProjectException>(target, 'DartProjectException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.DartProjectException>(target, 'DartProjectException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.DartProjectException>(target, 'DartProjectException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartProjectException>(target, 'DartProjectException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartProjectException>(target, 'DartProjectException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartProjectException>(target, 'DartProjectException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartProjectException>(target, 'DartProjectException');
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
    nativeType: $pkg.TemplateNotFoundException,
    name: 'TemplateNotFoundException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'TemplateNotFoundException');
        final pathTo = D4.getRequiredArg<String>(positional, 0, 'pathTo', 'TemplateNotFoundException');
        return $pkg.TemplateNotFoundException(pathTo);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.TemplateNotFoundException>(target, 'TemplateNotFoundException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.TemplateNotFoundException>(target, 'TemplateNotFoundException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.TemplateNotFoundException>(target, 'TemplateNotFoundException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.TemplateNotFoundException>(target, 'TemplateNotFoundException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TemplateNotFoundException>(target, 'TemplateNotFoundException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TemplateNotFoundException>(target, 'TemplateNotFoundException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TemplateNotFoundException>(target, 'TemplateNotFoundException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.TemplateNotFoundException>(target, 'TemplateNotFoundException');
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
    nativeType: $pkg.InvalidProjectTemplateException,
    name: 'InvalidProjectTemplateException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InvalidProjectTemplateException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'InvalidProjectTemplateException');
        return $pkg.InvalidProjectTemplateException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidProjectTemplateException>(target, 'InvalidProjectTemplateException');
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
    nativeType: $pkg.DartScript,
    name: 'DartScript',
    constructors: {
      'createScript': (visitor, positional, named) {
        final project = D4.getRequiredNamedArg<$pkg.DartProject>(named, 'project', 'DartScript');
        final scriptName = D4.getRequiredNamedArg<String>(named, 'scriptName', 'DartScript');
        final templateName = D4.getRequiredNamedArg<String>(named, 'templateName', 'DartScript');
        return $pkg.DartScript.createScript(project: project, scriptName: scriptName, templateName: templateName);
      },
      'fromFile': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'DartScript');
        final scriptPathTo = D4.getRequiredArg<String>(positional, 0, 'scriptPathTo', 'DartScript');
        final project = D4.getOptionalNamedArg<$pkg.DartProject?>(named, 'project');
        return $pkg.DartScript.fromFile(scriptPathTo, project: project);
      },
    },
    getters: {
      'pathToScript': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').pathToScript,
      'scriptName': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').scriptName,
      'pathToScriptDirectory': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').pathToScriptDirectory,
      'pubsecNameKey': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').pubsecNameKey,
      'basename': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').basename,
      'pathToPubSpec': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').pathToPubSpec,
      'isReadyToRun': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').isReadyToRun,
      'isCompiled': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').isCompiled,
      'isInstalled': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').isInstalled,
      'isPubGlobalActivated': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').isPubGlobalActivated,
      'pathToProjectRoot': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').pathToProjectRoot,
      'project': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').project,
      'doctor': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').doctor,
      'pubSpec': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').pubSpec,
      'exeName': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').exeName,
      'pathToExe': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').pathToExe,
      'pathToInstalledExe': (visitor, target) => D4.validateTarget<$pkg.DartScript>(target, 'DartScript').pathToInstalledExe,
    },
    methods: {
      'compile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartScript>(target, 'DartScript');
        final install = D4.getNamedArgWithDefault<bool>(named, 'install', false);
        final overwrite = D4.getNamedArgWithDefault<bool>(named, 'overwrite', false);
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        t.compile(install: install, overwrite: overwrite, workingDirectory: workingDirectory);
        return null;
      },
      'run': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartScript>(target, 'DartScript');
        final args = named.containsKey('args') && named['args'] != null
            ? D4.coerceList<String>(named['args'], 'args')
            : const <String>[];
        return t.run(args: args);
      },
      'start': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartScript>(target, 'DartScript');
        final args = named.containsKey('args') && named['args'] != null
            ? D4.coerceList<String>(named['args'], 'args')
            : const <String>[];
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
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
        final t = D4.validateTarget<$pkg.DartScript>(target, 'DartScript');
        t.runPubGet();
        return null;
      },
    },
    staticGetters: {
      'self': (visitor) => $pkg.DartScript.self,
      'current': (visitor) => $pkg.DartScript.current,
    },
    staticMethods: {
      'sansRoot': (visitor, positional, named, typeArgs) {
        D4.requireMinArgs(positional, 1, 'sansRoot');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'sansRoot');
        return $pkg.DartScript.sansRoot(path);
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
    nativeType: $pkg.DartSdk,
    name: 'DartSdk',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.DartSdk();
      },
    },
    getters: {
      'pathToSdk': (visitor, target) => D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk').pathToSdk,
      'pathToDartExe': (visitor, target) => D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk').pathToDartExe,
      'pathToPubExe': (visitor, target) => D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk').pathToPubExe,
      'pathToDartToNativeExe': (visitor, target) => D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk').pathToDartToNativeExe,
      'versionMajor': (visitor, target) => D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk').versionMajor,
      'versionMinor': (visitor, target) => D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk').versionMinor,
      'useDartCommand': (visitor, target) => D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk').useDartCommand,
      'useDartDocCommand': (visitor, target) => D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk').useDartDocCommand,
      'version': (visitor, target) => D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk').version,
      'pathToPackageConfig': (visitor, target) => D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk').pathToPackageConfig,
    },
    methods: {
      'getVersion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        return t.getVersion();
      },
      'runDartCompiler': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'runDartCompiler');
        final script = D4.getRequiredArg<$pkg.DartScript>(positional, 0, 'script', 'runDartCompiler');
        final pathToExe = D4.getRequiredNamedArg<String>(named, 'pathToExe', 'runDartCompiler');
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        t.runDartCompiler(script, pathToExe: pathToExe, progress: progress, workingDirectory: workingDirectory);
        return null;
      },
      'run': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        if (!named.containsKey('args') || named['args'] == null) {
          throw ArgumentError('run: Missing required named argument "args"');
        }
        final args = D4.coerceList<String>(named['args'], 'args');
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
        final detached = D4.getNamedArgWithDefault<bool>(named, 'detached', false);
        final terminal = D4.getNamedArgWithDefault<bool>(named, 'terminal', false);
        final nothrow = D4.getNamedArgWithDefault<bool>(named, 'nothrow', false);
        return t.run(args: args, workingDirectory: workingDirectory, progress: progress, detached: detached, terminal: terminal, nothrow: nothrow);
      },
      'runPub': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        if (!named.containsKey('args') || named['args'] == null) {
          throw ArgumentError('runPub: Missing required named argument "args"');
        }
        final args = D4.coerceList<String>(named['args'], 'args');
        final workingDirectory = D4.getOptionalNamedArg<String?>(named, 'workingDirectory');
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
        final nothrow = D4.getNamedArgWithDefault<bool>(named, 'nothrow', false);
        return t.runPub(args: args, workingDirectory: workingDirectory, progress: progress, nothrow: nothrow);
      },
      'runDartDoc': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        final pathToProject = D4.getOptionalNamedArg<String?>(named, 'pathToProject');
        final pathToDoc = D4.getOptionalNamedArg<String?>(named, 'pathToDoc');
        final args = named.containsKey('args') && named['args'] != null
            ? D4.coerceList<String>(named['args'], 'args')
            : const <String>[];
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
        final nothrow = D4.getNamedArgWithDefault<bool>(named, 'nothrow', false);
        return t.runDartDoc(pathToProject: pathToProject, pathToDoc: pathToDoc, args: args, progress: progress, nothrow: nothrow);
      },
      'isPubGetRequired': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'isPubGetRequired');
        final workingDirectory = D4.getRequiredArg<String>(positional, 0, 'workingDirectory', 'isPubGetRequired');
        return t.isPubGetRequired(workingDirectory);
      },
      'runPubGet': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'runPubGet');
        final workingDirectory = D4.getRequiredArg<String?>(positional, 0, 'workingDirectory', 'runPubGet');
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
        final compileExecutables = D4.getNamedArgWithDefault<bool>(named, 'compileExecutables', false);
        t.runPubGet(workingDirectory, progress: progress, compileExecutables: compileExecutables);
        return null;
      },
      'runPubUpgrade': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'runPubUpgrade');
        final workingDirectory = D4.getRequiredArg<String?>(positional, 0, 'workingDirectory', 'runPubUpgrade');
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
        final compileExecutables = D4.getNamedArgWithDefault<bool>(named, 'compileExecutables', false);
        t.runPubUpgrade(workingDirectory, progress: progress, compileExecutables: compileExecutables);
        return null;
      },
      'installFromArchive': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'installFromArchive');
        final defaultDartSdkPath = D4.getRequiredArg<String>(positional, 0, 'defaultDartSdkPath', 'installFromArchive');
        final askUser = D4.getNamedArgWithDefault<bool>(named, 'askUser', true);
        return t.installFromArchive(defaultDartSdkPath, askUser: askUser);
      },
      'resolveArchitecture': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        return t.resolveArchitecture();
      },
      'globalActivate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'globalActivate');
        final package = D4.getRequiredArg<String>(positional, 0, 'package', 'globalActivate');
        t.globalActivate(package);
        return null;
      },
      'globalActivateFromPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'globalActivateFromPath');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'globalActivateFromPath');
        t.globalActivateFromPath(path);
        return null;
      },
      'globalDeactivate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'globalDeactivate');
        final package = D4.getRequiredArg<String>(positional, 0, 'package', 'globalDeactivate');
        t.globalDeactivate(package);
        return null;
      },
      'isPackageGloballyActivated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'isPackageGloballyActivated');
        final package = D4.getRequiredArg<String>(positional, 0, 'package', 'isPackageGloballyActivated');
        return t.isPackageGloballyActivated(package);
      },
      'isPackageGlobalActivateFromPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.DartSdk>(target, 'DartSdk');
        D4.requireMinArgs(positional, 1, 'isPackageGlobalActivateFromPath');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'isPackageGlobalActivateFromPath');
        t.isPackageGlobalActivateFromPath(path);
        return null;
      },
    },
    staticGetters: {
      'dartExeName': (visitor) => $pkg.DartSdk.dartExeName,
      'pubExeName': (visitor) => $pkg.DartSdk.pubExeName,
      'dart2NativeExeName': (visitor) => $pkg.DartSdk.dart2NativeExeName,
      'isUsingDartFromFlutter': (visitor) => $pkg.DartSdk.isUsingDartFromFlutter,
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
    nativeType: $pkg.Settings,
    name: 'Settings',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Settings();
      },
      'forScope': (visitor, positional, named) {
        return $pkg.Settings.forScope();
      },
    },
    getters: {
      'version': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').version,
      'dcliDir': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').dcliDir,
      'isMacOS': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').isMacOS,
      'isLinux': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').isLinux,
      'isWindows': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').isWindows,
      'pathToScript': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').pathToScript,
      'pathToDCli': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').pathToDCli,
      'pathToDCliBin': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').pathToDCliBin,
      'pathToTemplate': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').pathToTemplate,
      'pathToTemplateProject': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').pathToTemplateProject,
      'pathToTemplateProjectCustom': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').pathToTemplateProjectCustom,
      'pathToTemplateScript': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').pathToTemplateScript,
      'pathToTemplateScriptCustom': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').pathToTemplateScriptCustom,
      'isVerbose': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').isVerbose,
      'logger': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').logger,
      'isInstalled': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').isInstalled,
      'installCompletedIndicator': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').installCompletedIndicator,
      'isStackEmpty': (visitor, target) => D4.validateTarget<$pkg.Settings>(target, 'Settings').isStackEmpty,
    },
    setters: {
      'version': (visitor, target, value) => 
        D4.validateTarget<$pkg.Settings>(target, 'Settings').version = value as String?,
      'dcliDir': (visitor, target, value) => 
        D4.validateTarget<$pkg.Settings>(target, 'Settings').dcliDir = value as dynamic,
    },
    methods: {
      'setVerbose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Settings>(target, 'Settings');
        final enabled = D4.getRequiredNamedArg<bool>(named, 'enabled', 'setVerbose');
        t.setVerbose(enabled: enabled);
        return null;
      },
      'verbose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Settings>(target, 'Settings');
        D4.requireMinArgs(positional, 1, 'verbose');
        final string = D4.getRequiredArg<String?>(positional, 0, 'string', 'verbose');
        t.verbose(string);
        return null;
      },
    },
    staticGetters: {
      'scopeKey': (visitor) => $pkg.Settings.scopeKey,
      'templateDir': (visitor) => $pkg.Settings.templateDir,
      'dcliAppName': (visitor) => $pkg.Settings.dcliAppName,
    },
    staticSetters: {
      'scopeKey': (visitor, value) => 
        $pkg.Settings.scopeKey = value as dynamic,
      'mock': (visitor, value) => 
        $pkg.Settings.mock = value as dynamic,
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
    nativeType: $pkg.Shell,
    name: 'Shell',
    constructors: {
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').name,
      'hasStartScript': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').hasStartScript,
      'startScriptName': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').startScriptName,
      'pathToStartScript': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').pathToStartScript,
      'canModifyPath': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').canModifyPath,
      'isCompletionSupported': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').isCompletionSupported,
      'isCompletionInstalled': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').isCompletionInstalled,
      'isSudo': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').isSudo,
      'loggedInUser': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').loggedInUser,
      'isPrivilegedUser': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').isPrivilegedUser,
      'isPrivilegedPasswordRequired': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').isPrivilegedPasswordRequired,
      'isPrivilegedProcess': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').isPrivilegedProcess,
      'installInstructions': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').installInstructions,
      'pid': (visitor, target) => D4.validateTarget<$pkg.Shell>(target, 'Shell').pid,
    },
    methods: {
      'matchByName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'matchByName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'matchByName');
        return t.matchByName(name);
      },
      'addToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'addToPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'addToPATH');
        return t.addToPATH(path);
      },
      'appendToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'appendToPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'appendToPATH');
        return t.appendToPATH(path);
      },
      'prependToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'prependToPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'prependToPATH');
        return t.prependToPATH(path);
      },
      'addFileAssocation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'addFileAssocation');
        final dcliPath = D4.getRequiredArg<String>(positional, 0, 'dcliPath', 'addFileAssocation');
        t.addFileAssocation(dcliPath);
        return null;
      },
      'installTabCompletion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        final quiet = D4.getNamedArgWithDefault<bool>(named, 'quiet', true);
        t.installTabCompletion(quiet: quiet);
        return null;
      },
      'releasePrivileges': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        t.releasePrivileges();
        return null;
      },
      'restorePrivileges': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        t.restorePrivileges();
        return null;
      },
      'withPrivileges': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'withPrivileges');
        if (positional.isEmpty) {
          throw ArgumentError('withPrivileges: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        final allowUnprivileged = D4.getNamedArgWithDefault<bool>(named, 'allowUnprivileged', false);
        t.withPrivileges(() { (actionRaw as InterpretedFunction).call(visitor, []); }, allowUnprivileged: allowUnprivileged);
        return null;
      },
      'withPrivilegesAsync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'withPrivilegesAsync');
        if (positional.isEmpty) {
          throw ArgumentError('withPrivilegesAsync: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        final allowUnprivileged = D4.getNamedArgWithDefault<bool>(named, 'allowUnprivileged', false);
        return t.withPrivilegesAsync(() { return (actionRaw as InterpretedFunction).call(visitor, []) as Future<void>; }, allowUnprivileged: allowUnprivileged);
      },
      'privilegesRequiredMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        D4.requireMinArgs(positional, 1, 'privilegesRequiredMessage');
        final appname = D4.getRequiredArg<String>(positional, 0, 'appname', 'privilegesRequiredMessage');
        return t.privilegesRequiredMessage(appname);
      },
      'install': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        final installDart = D4.getNamedArgWithDefault<bool>(named, 'installDart', false);
        return t.install(installDart: installDart);
      },
      'checkInstallPreconditions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Shell>(target, 'Shell');
        return t.checkInstallPreconditions();
      },
    },
    staticGetters: {
      'current': (visitor) => $pkg.Shell.current,
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
    nativeType: $pkg.ShellException,
    name: 'ShellException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ShellException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'ShellException');
        return $pkg.ShellException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.ShellException>(target, 'ShellException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.ShellException>(target, 'ShellException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.ShellException>(target, 'ShellException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.ShellException>(target, 'ShellException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ShellException>(target, 'ShellException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ShellException>(target, 'ShellException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ShellException>(target, 'ShellException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ShellException>(target, 'ShellException');
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
    nativeType: $pkg.ShellDetection,
    name: 'ShellDetection',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.ShellDetection();
      },
    },
    methods: {
      'identifyShell': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ShellDetection>(target, 'ShellDetection');
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
    nativeType: $pkg.UnknownShell,
    name: 'UnknownShell',
    constructors: {
      'withPid': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'UnknownShell');
        final pid = D4.getRequiredArg<int?>(positional, 0, 'pid', 'UnknownShell');
        final processName = D4.getOptionalNamedArg<String?>(named, 'processName');
        return $pkg.UnknownShell.withPid(pid, processName: processName);
      },
    },
    getters: {
      'processName': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').processName,
      'pid': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').pid,
      'canModifyPath': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').canModifyPath,
      'isCompletionInstalled': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').isCompletionInstalled,
      'isCompletionSupported': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').isCompletionSupported,
      'name': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').name,
      'hashCode': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').hashCode,
      'hasStartScript': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').hasStartScript,
      'startScriptName': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').startScriptName,
      'pathToStartScript': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').pathToStartScript,
      'isPrivilegedUser': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').isPrivilegedUser,
      'loggedInUser': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').loggedInUser,
      'isSudo': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').isSudo,
      'isPrivilegedProcess': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').isPrivilegedProcess,
      'isPrivilegedPasswordRequired': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').isPrivilegedPasswordRequired,
      'installInstructions': (visitor, target) => D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell').installInstructions,
    },
    methods: {
      'addToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'addToPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'addToPATH');
        return t.addToPATH(path);
      },
      'appendToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'appendToPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'appendToPATH');
        return t.appendToPATH(path);
      },
      'prependToPATH': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'prependToPATH');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'prependToPATH');
        return t.prependToPATH(path);
      },
      'appendPathToMacOsPathd': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'appendPathToMacOsPathd');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'appendPathToMacOsPathd');
        return t.appendPathToMacOsPathd(path);
      },
      'installTabCompletion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        final quiet = D4.getNamedArgWithDefault<bool>(named, 'quiet', false);
        t.installTabCompletion(quiet: quiet);
        return null;
      },
      'privilegesRequiredMessage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'privilegesRequiredMessage');
        final app = D4.getRequiredArg<String>(positional, 0, 'app', 'privilegesRequiredMessage');
        return t.privilegesRequiredMessage(app);
      },
      'install': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        final installDart = D4.getNamedArgWithDefault<bool>(named, 'installDart', false);
        final activate = D4.getNamedArgWithDefault<bool>(named, 'activate', true);
        return t.install(installDart: installDart, activate: activate);
      },
      'checkInstallPreconditions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        return t.checkInstallPreconditions();
      },
      'releasePrivileges': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        t.releasePrivileges();
        return null;
      },
      'restorePrivileges': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        t.restorePrivileges();
        return null;
      },
      'withPrivileges': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'withPrivileges');
        if (positional.isEmpty) {
          throw ArgumentError('withPrivileges: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        final allowUnprivileged = D4.getNamedArgWithDefault<bool>(named, 'allowUnprivileged', false);
        t.withPrivileges(() { (actionRaw as InterpretedFunction).call(visitor, []); }, allowUnprivileged: allowUnprivileged);
        return null;
      },
      'withPrivilegesAsync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'withPrivilegesAsync');
        if (positional.isEmpty) {
          throw ArgumentError('withPrivilegesAsync: Missing required argument "action" at position 0');
        }
        final actionRaw = positional[0];
        final allowUnprivileged = D4.getNamedArgWithDefault<bool>(named, 'allowUnprivileged', false);
        return t.withPrivilegesAsync(() { return (actionRaw as InterpretedFunction).call(visitor, []) as Future<void>; }, allowUnprivileged: allowUnprivileged);
      },
      'addFileAssocation': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'addFileAssocation');
        final dcliPath = D4.getRequiredArg<String>(positional, 0, 'dcliPath', 'addFileAssocation');
        t.addFileAssocation(dcliPath);
        return null;
      },
      'matchByName': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        D4.requireMinArgs(positional, 1, 'matchByName');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'matchByName');
        return t.matchByName(name);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.UnknownShell>(target, 'UnknownShell');
        final other = D4.getRequiredArg<$pkg.UnknownShell>(positional, 0, 'other', 'operator==');
        return t == other;
      },
    },
    staticGetters: {
      'shellName': (visitor) => $pkg.UnknownShell.shellName,
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
    nativeType: $pkg.DCliPaths,
    name: 'DCliPaths',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.DCliPaths();
      },
    },
    getters: {
      'dcliName': (visitor, target) => D4.validateTarget<$pkg.DCliPaths>(target, 'DCliPaths').dcliName,
      'dcliInstallName': (visitor, target) => D4.validateTarget<$pkg.DCliPaths>(target, 'DCliPaths').dcliInstallName,
      'dcliCompleteName': (visitor, target) => D4.validateTarget<$pkg.DCliPaths>(target, 'DCliPaths').dcliCompleteName,
      'pathToDCli': (visitor, target) => D4.validateTarget<$pkg.DCliPaths>(target, 'DCliPaths').pathToDCli,
    },
    setters: {
      'dcliName': (visitor, target, value) => 
        D4.validateTarget<$pkg.DCliPaths>(target, 'DCliPaths').dcliName = value as String,
      'dcliInstallName': (visitor, target, value) => 
        D4.validateTarget<$pkg.DCliPaths>(target, 'DCliPaths').dcliInstallName = value as String,
      'dcliCompleteName': (visitor, target, value) => 
        D4.validateTarget<$pkg.DCliPaths>(target, 'DCliPaths').dcliCompleteName = value as String,
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
    nativeType: $pkg.InvalidArgumentException,
    name: 'InvalidArgumentException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InvalidArgumentException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'InvalidArgumentException');
        return $pkg.InvalidArgumentException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.InvalidArgumentException>(target, 'InvalidArgumentException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.InvalidArgumentException>(target, 'InvalidArgumentException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.InvalidArgumentException>(target, 'InvalidArgumentException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.InvalidArgumentException>(target, 'InvalidArgumentException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidArgumentException>(target, 'InvalidArgumentException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidArgumentException>(target, 'InvalidArgumentException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidArgumentException>(target, 'InvalidArgumentException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidArgumentException>(target, 'InvalidArgumentException');
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
    nativeType: $pkg.InvalidTemplateException,
    name: 'InvalidTemplateException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InvalidTemplateException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'InvalidTemplateException');
        return $pkg.InvalidTemplateException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.InvalidTemplateException>(target, 'InvalidTemplateException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.InvalidTemplateException>(target, 'InvalidTemplateException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.InvalidTemplateException>(target, 'InvalidTemplateException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.InvalidTemplateException>(target, 'InvalidTemplateException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidTemplateException>(target, 'InvalidTemplateException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidTemplateException>(target, 'InvalidTemplateException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidTemplateException>(target, 'InvalidTemplateException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InvalidTemplateException>(target, 'InvalidTemplateException');
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
    nativeType: $pkg.InstallException,
    name: 'InstallException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'InstallException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'InstallException');
        return $pkg.InstallException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.InstallException>(target, 'InstallException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.InstallException>(target, 'InstallException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.InstallException>(target, 'InstallException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.InstallException>(target, 'InstallException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InstallException>(target, 'InstallException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InstallException>(target, 'InstallException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InstallException>(target, 'InstallException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.InstallException>(target, 'InstallException');
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
    nativeType: $pkg.ProcessSyncException,
    name: 'ProcessSyncException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ProcessSyncException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'ProcessSyncException');
        return $pkg.ProcessSyncException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.ProcessSyncException>(target, 'ProcessSyncException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.ProcessSyncException>(target, 'ProcessSyncException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.ProcessSyncException>(target, 'ProcessSyncException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.ProcessSyncException>(target, 'ProcessSyncException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ProcessSyncException>(target, 'ProcessSyncException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ProcessSyncException>(target, 'ProcessSyncException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ProcessSyncException>(target, 'ProcessSyncException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ProcessSyncException>(target, 'ProcessSyncException');
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
    nativeType: $pkg.FileSort,
    name: 'FileSort',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 5, 'FileSort');
        final inputPath = D4.getRequiredArg<String>(positional, 0, 'inputPath', 'FileSort');
        final outputPath = D4.getRequiredArg<String>(positional, 1, 'outputPath', 'FileSort');
        if (positional.length <= 2) {
          throw ArgumentError('FileSort: Missing required argument "columns" at position 2');
        }
        final columns = D4.coerceList<$pkg.Column>(positional[2], 'columns');
        final fieldDelimiter = D4.getRequiredArg<String?>(positional, 3, 'fieldDelimiter', 'FileSort');
        final lineDelimiter = D4.getRequiredArg<String?>(positional, 4, 'lineDelimiter', 'FileSort');
        final verbose = D4.getNamedArgWithDefault<bool?>(named, 'verbose', false);
        return $pkg.FileSort(inputPath, outputPath, columns, fieldDelimiter, lineDelimiter, verbose: verbose);
      },
    },
    getters: {
      'verbose': (visitor, target) => D4.validateTarget<$pkg.FileSort>(target, 'FileSort').verbose,
    },
    methods: {
      'sort': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileSort>(target, 'FileSort');
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
        return $pkg.FileSort.expandColumns(values);
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
// FileSync Bridge
// =============================================================================

BridgedClass _createFileSyncBridge() {
  return BridgedClass(
    nativeType: $pkg.FileSync,
    name: 'FileSync',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FileSync');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'FileSync');
        final fileMode = D4.getNamedArgWithDefault<FileMode>(named, 'fileMode', FileMode.writeOnlyAppend);
        return $pkg.FileSync(path, fileMode: fileMode);
      },
    },
    getters: {
      'path': (visitor, target) => D4.validateTarget<$pkg.FileSync>(target, 'FileSync').path,
      'length': (visitor, target) => D4.validateTarget<$pkg.FileSync>(target, 'FileSync').length,
    },
    methods: {
      'readLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileSync>(target, 'FileSync');
        final lineDelimiter = D4.getOptionalNamedArg<String?>(named, 'lineDelimiter');
        return t.readLine(lineDelimiter: lineDelimiter);
      },
      'flush': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileSync>(target, 'FileSync');
        t.flush();
        return null;
      },
      'close': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileSync>(target, 'FileSync');
        t.close();
        return null;
      },
      'read': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileSync>(target, 'FileSync');
        D4.requireMinArgs(positional, 1, 'read');
        if (positional.isEmpty) {
          throw ArgumentError('read: Missing required argument "lineAction" at position 0');
        }
        final lineActionRaw = positional[0];
        t.read((String p0) { return (lineActionRaw as InterpretedFunction).call(visitor, [p0]) as bool; });
        return null;
      },
      'resolveSymLink': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileSync>(target, 'FileSync');
        return t.resolveSymLink();
      },
      'write': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileSync>(target, 'FileSync');
        D4.requireMinArgs(positional, 1, 'write');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'write');
        final newline = D4.getOptionalNamedArg<String?>(named, 'newline');
        t.write(line, newline: newline);
        return null;
      },
      'writeFromSync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileSync>(target, 'FileSync');
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
        final t = D4.validateTarget<$pkg.FileSync>(target, 'FileSync');
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
        final t = D4.validateTarget<$pkg.FileSync>(target, 'FileSync');
        D4.requireMinArgs(positional, 1, 'append');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'append');
        final newline = D4.getOptionalNamedArg<String?>(named, 'newline');
        t.append(line, newline: newline);
        return null;
      },
      'truncate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileSync>(target, 'FileSync');
        t.truncate();
        return null;
      },
    },
    staticMethods: {
      'tempFile': (visitor, positional, named, typeArgs) {
        final suffix = D4.getOptionalNamedArg<String?>(named, 'suffix');
        return $pkg.FileSync.tempFile(suffix: suffix);
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
    nativeType: $pkg.FileNotFoundException,
    name: 'FileNotFoundException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'FileNotFoundException');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'FileNotFoundException');
        return $pkg.FileNotFoundException(path);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.FileNotFoundException>(target, 'FileNotFoundException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.FileNotFoundException>(target, 'FileNotFoundException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.FileNotFoundException>(target, 'FileNotFoundException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.FileNotFoundException>(target, 'FileNotFoundException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileNotFoundException>(target, 'FileNotFoundException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileNotFoundException>(target, 'FileNotFoundException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileNotFoundException>(target, 'FileNotFoundException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.FileNotFoundException>(target, 'FileNotFoundException');
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
    nativeType: $pkg.NotAFileException,
    name: 'NotAFileException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'NotAFileException');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'NotAFileException');
        return $pkg.NotAFileException(path);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.NotAFileException>(target, 'NotAFileException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.NotAFileException>(target, 'NotAFileException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.NotAFileException>(target, 'NotAFileException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.NotAFileException>(target, 'NotAFileException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.NotAFileException>(target, 'NotAFileException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.NotAFileException>(target, 'NotAFileException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.NotAFileException>(target, 'NotAFileException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.NotAFileException>(target, 'NotAFileException');
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
    nativeType: $pkg.NamedLock,
    name: 'NamedLock',
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'NamedLock');
        final lockPath = D4.getOptionalNamedArg<String?>(named, 'lockPath');
        final description = D4.getNamedArgWithDefault<String>(named, 'description', '');
        final timeout = D4.getNamedArgWithDefault<Duration>(named, 'timeout', const Duration(seconds: 30));
        return $pkg.NamedLock(name: name, lockPath: lockPath, description: description, timeout: timeout);
      },
    },
    getters: {
      'port': (visitor, target) => D4.validateTarget<$pkg.NamedLock>(target, 'NamedLock').port,
      'name': (visitor, target) => D4.validateTarget<$pkg.NamedLock>(target, 'NamedLock').name,
      'incLockCount': (visitor, target) => D4.validateTarget<$pkg.NamedLock>(target, 'NamedLock').incLockCount,
      'decLockCount': (visitor, target) => D4.validateTarget<$pkg.NamedLock>(target, 'NamedLock').decLockCount,
    },
    methods: {
      'withLock': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.NamedLock>(target, 'NamedLock');
        D4.requireMinArgs(positional, 1, 'withLock');
        if (positional.isEmpty) {
          throw ArgumentError('withLock: Missing required argument "fn" at position 0');
        }
        final fnRaw = positional[0];
        final waiting = D4.getOptionalNamedArg<String?>(named, 'waiting');
        return t.withLock(() { (fnRaw as InterpretedFunction).call(visitor, []); }, waiting: waiting);
      },
      'withLockAsync': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.NamedLock>(target, 'NamedLock');
        D4.requireMinArgs(positional, 1, 'withLockAsync');
        if (positional.isEmpty) {
          throw ArgumentError('withLockAsync: Missing required argument "fn" at position 0');
        }
        final fnRaw = positional[0];
        final waiting = D4.getOptionalNamedArg<String?>(named, 'waiting');
        return t.withLockAsync(() { return (fnRaw as InterpretedFunction).call(visitor, []) as Future<void>; }, waiting: waiting);
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
    nativeType: $pkg.LockException,
    name: 'LockException',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'LockException');
        final message = D4.getRequiredArg<dynamic>(positional, 0, 'message', 'LockException');
        return $pkg.LockException(message);
      },
    },
    getters: {
      'message': (visitor, target) => D4.validateTarget<$pkg.LockException>(target, 'LockException').message,
      'cause': (visitor, target) => D4.validateTarget<$pkg.LockException>(target, 'LockException').cause,
      'stackTrace': (visitor, target) => D4.validateTarget<$pkg.LockException>(target, 'LockException').stackTrace,
    },
    setters: {
      'stackTrace': (visitor, target, value) => 
        D4.validateTarget<$pkg.LockException>(target, 'LockException').stackTrace = value as dynamic,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LockException>(target, 'LockException');
        return t.toString();
      },
      'printStackTrace': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LockException>(target, 'LockException');
        t.printStackTrace();
        return null;
      },
      'toJson': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LockException>(target, 'LockException');
        return t.toJson();
      },
      'toJsonString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.LockException>(target, 'LockException');
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
    nativeType: $pkg.ProcessDetails,
    name: 'ProcessDetails',
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 3, 'ProcessDetails');
        final pid = D4.getRequiredArg<int>(positional, 0, 'pid', 'ProcessDetails');
        final name = D4.getRequiredArg<String>(positional, 1, 'name', 'ProcessDetails');
        final memory = D4.getRequiredArg<String>(positional, 2, 'memory', 'ProcessDetails');
        return $pkg.ProcessDetails(pid, name, memory);
      },
    },
    getters: {
      'pid': (visitor, target) => D4.validateTarget<$pkg.ProcessDetails>(target, 'ProcessDetails').pid,
      'name': (visitor, target) => D4.validateTarget<$pkg.ProcessDetails>(target, 'ProcessDetails').name,
      'memoryUnits': (visitor, target) => D4.validateTarget<$pkg.ProcessDetails>(target, 'ProcessDetails').memoryUnits,
      'memory': (visitor, target) => D4.validateTarget<$pkg.ProcessDetails>(target, 'ProcessDetails').memory,
      'hashCode': (visitor, target) => D4.validateTarget<$pkg.ProcessDetails>(target, 'ProcessDetails').hashCode,
    },
    setters: {
      'memoryUnits': (visitor, target, value) => 
        D4.validateTarget<$pkg.ProcessDetails>(target, 'ProcessDetails').memoryUnits = value as String?,
    },
    methods: {
      'compareTo': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ProcessDetails>(target, 'ProcessDetails');
        D4.requireMinArgs(positional, 1, 'compareTo');
        final other = D4.getRequiredArg<$pkg.ProcessDetails>(positional, 0, 'other', 'compareTo');
        return t.compareTo(other);
      },
      '==': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.ProcessDetails>(target, 'ProcessDetails');
        final other = D4.getRequiredArg<$pkg.ProcessDetails>(positional, 0, 'other', 'operator==');
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
    nativeType: $pkg.PubCache,
    name: 'PubCache',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.PubCache();
      },
      'forScope': (visitor, positional, named) {
        return $pkg.PubCache.forScope();
      },
    },
    getters: {
      'pathTo': (visitor, target) => D4.validateTarget<$pkg.PubCache>(target, 'PubCache').pathTo,
      'pathToBin': (visitor, target) => D4.validateTarget<$pkg.PubCache>(target, 'PubCache').pathToBin,
      'pathToHosted': (visitor, target) => D4.validateTarget<$pkg.PubCache>(target, 'PubCache').pathToHosted,
      'cacheDir': (visitor, target) => D4.validateTarget<$pkg.PubCache>(target, 'PubCache').cacheDir,
      'pathToDartLang': (visitor, target) => D4.validateTarget<$pkg.PubCache>(target, 'PubCache').pathToDartLang,
    },
    setters: {
      'pathTo': (visitor, target, value) => 
        D4.validateTarget<$pkg.PubCache>(target, 'PubCache').pathTo = value as dynamic,
    },
    methods: {
      'pathToPackage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 2, 'pathToPackage');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'pathToPackage');
        final version = D4.getRequiredArg<String>(positional, 1, 'version', 'pathToPackage');
        return t.pathToPackage(packageName, version);
      },
      'pathToGlobalPackage': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'pathToGlobalPackage');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'pathToGlobalPackage');
        return t.pathToGlobalPackage(packageName);
      },
      'isInstalled': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'isInstalled');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'isInstalled');
        return t.isInstalled(packageName);
      },
      'findPrimaryVersion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'findPrimaryVersion');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'findPrimaryVersion');
        return t.findPrimaryVersion(packageName);
      },
      'findVersion': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 2, 'findVersion');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'findVersion');
        final requestedVersion = D4.getRequiredArg<String>(positional, 1, 'requestedVersion', 'findVersion');
        return t.findVersion(packageName, requestedVersion);
      },
      'globalActivate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'globalActivate');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'globalActivate');
        final version = D4.getOptionalNamedArg<String?>(named, 'version');
        final verbose = D4.getNamedArgWithDefault<bool>(named, 'verbose', false);
        t.globalActivate(packageName, version: version, verbose: verbose);
        return null;
      },
      'globalActivateFromSource': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'globalActivateFromSource');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'globalActivateFromSource');
        final overwrite = D4.getNamedArgWithDefault<bool>(named, 'overwrite', false);
        t.globalActivateFromSource(path, overwrite: overwrite);
        return null;
      },
      'globalDeactivate': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'globalDeactivate');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'globalDeactivate');
        t.globalDeactivate(packageName);
        return null;
      },
      'isGloballyActivated': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'isGloballyActivated');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'isGloballyActivated');
        return t.isGloballyActivated(packageName);
      },
      'isGloballyActivatedFromSource': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.PubCache>(target, 'PubCache');
        D4.requireMinArgs(positional, 1, 'isGloballyActivatedFromSource');
        final packageName = D4.getRequiredArg<String>(positional, 0, 'packageName', 'isGloballyActivatedFromSource');
        return t.isGloballyActivatedFromSource(packageName);
      },
    },
    staticGetters: {
      'scopeKey': (visitor) => $pkg.PubCache.scopeKey,
      'envVarPubCache': (visitor) => $pkg.PubCache.envVarPubCache,
    },
    staticSetters: {
      'scopeKey': (visitor, value) => 
        $pkg.PubCache.scopeKey = value as dynamic,
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
    nativeType: $pkg.Remote,
    name: 'Remote',
    constructors: {
      '': (visitor, positional, named) {
        return $pkg.Remote();
      },
    },
    methods: {
      'exec': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$pkg.Remote>(target, 'Remote');
        final host = D4.getRequiredNamedArg<String>(named, 'host', 'exec');
        final command = D4.getRequiredNamedArg<String>(named, 'command', 'exec');
        final agent = D4.getNamedArgWithDefault<bool>(named, 'agent', true);
        final sudo = D4.getNamedArgWithDefault<bool>(named, 'sudo', false);
        final password = D4.getOptionalNamedArg<String?>(named, 'password');
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
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
        final t = D4.validateTarget<$pkg.Remote>(target, 'Remote');
        final host = D4.getRequiredNamedArg<String>(named, 'host', 'execList');
        if (!named.containsKey('commands') || named['commands'] == null) {
          throw ArgumentError('execList: Missing required named argument "commands"');
        }
        final commands = D4.coerceList<String?>(named['commands'], 'commands');
        final agent = D4.getNamedArgWithDefault<bool>(named, 'agent', true);
        final sudo = D4.getNamedArgWithDefault<bool>(named, 'sudo', false);
        final password = D4.getOptionalNamedArg<String?>(named, 'password');
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
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
        final t = D4.validateTarget<$pkg.Remote>(target, 'Remote');
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
        final progress = D4.getOptionalNamedArg<$pkg.Progress?>(named, 'progress');
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

