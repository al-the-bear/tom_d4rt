// D4rt Bridge - Generated file, do not edit
// Sources: 10 files
// Generated: 2026-03-12T17:03:34.096535

// ignore_for_file: unused_import, deprecated_member_use, prefer_function_declarations_over_variables

import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/tom_d4rt.dart';
import 'dart:async';
import 'dart:io';

import 'package:tom_d4rt/src/bridge/bridged_types.dart' as $tom_d4rt_1;
import 'package:tom_d4rt/src/bridge/registration.dart' as $tom_d4rt_2;
import 'package:tom_d4rt/src/callable.dart' as $tom_d4rt_3;
import 'package:tom_d4rt/src/d4rt_base.dart' as $tom_d4rt_4;
import 'package:tom_d4rt/src/interpreter_visitor.dart' as $tom_d4rt_5;
import 'package:tom_d4rt/src/introspection.dart' as $tom_d4rt_6;
import 'package:tom_d4rt/src/runtime_interfaces.dart' as $tom_d4rt_7;
import 'package:tom_d4rt/src/security/permissions.dart' as $tom_d4rt_8;
import 'package:tom_d4rt_dcli/src/api/cli_controller.dart' as $tom_d4rt_dcli_1;
import 'package:tom_d4rt_dcli/src/api/cli_exceptions.dart' as $tom_d4rt_dcli_2;
import 'package:tom_d4rt_dcli/src/api/cli_result_types.dart' as $tom_d4rt_dcli_3;
import 'package:tom_d4rt_dcli/src/api/cli_runtime.dart' as $tom_d4rt_dcli_4;
import 'package:tom_d4rt_dcli/src/api/cli_state.dart' as $tom_d4rt_dcli_5;
import 'package:tom_d4rt_dcli/src/api/execution_context.dart' as $tom_d4rt_dcli_6;
import 'package:tom_d4rt/src/exceptions.dart' as $aux_tom_d4rt;

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
      _createD4rtBridge(),
    ];
  }

  /// Returns a map of class names to their canonical source URIs.
  ///
  /// Used for deduplication when the same class is exported through
  /// multiple barrels (e.g., tom_core_kernel and tom_core_server).
  static Map<String, String> classSourceUris() {
    return {
      'D4rtCliApi': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_api.dart',
      'D4rtCliController': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_controller.dart',
      'CliGlobalHolder': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_controller.dart',
      'CliException': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_exceptions.dart',
      'CliFileNotFoundException': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_exceptions.dart',
      'DirectoryNotFoundException': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_exceptions.dart',
      'ExecutionException': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_exceptions.dart',
      'ReplayException': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_exceptions.dart',
      'InvalidMultilineModeException': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_exceptions.dart',
      'MaxNestingDepthException': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_exceptions.dart',
      'CliNotInitializedException': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_exceptions.dart',
      'ExecuteResult': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_result_types.dart',
      'ImportInfo': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_result_types.dart',
      'SymbolInfo': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_result_types.dart',
      'CliRuntime': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_runtime.dart',
      'CliRuntimeImpl': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_runtime.dart',
      'CliState': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_state.dart',
      'VerificationFailure': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\cli_test_utils.dart',
      'ExecutionContext': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\execution_context.dart',
      'ContextStack': 'C:\Code\al_the_bear\inhouse\second_wind\enterprise_flutter\tom_agent_container\tom_ai\d4rt\tom_d4rt_dcli\lib\src\api\execution_context.dart',
      'D4rt': 'C:\Users\alexi\AppData\Local\Pub\Cache\hosted\pub.dev\tom_d4rt-1.8.11\lib\src\d4rt_base.dart',
    };
  }

    isAssignable: (v) => v is D4rtCliApi,
    constructors: {
    },
    getters: {
      'isMultilineMode': (visitor, target) => D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi').isMultilineMode,
      'multilineMode': (visitor, target) => D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi').multilineMode,
      'multilineBuffer': (visitor, target) => D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi').multilineBuffer,
      'd4rt': (visitor, target) => D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi').d4rt,
      'dataDirectory': (visitor, target) => D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi').dataDirectory,
      'toolName': (visitor, target) => D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi').toolName,
      'currentSessionId': (visitor, target) => D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi').currentSessionId,
      'configuration': (visitor, target) => D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi').configuration,
      'runtime': (visitor, target) => D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi').runtime,
    },
    methods: {
      'processPrompt': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'processPrompt');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'processPrompt');
        return t.processPrompt(line);
      },
      'processPrompts': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'processPrompts');
        if (positional.isEmpty) {
          throw ArgumentError('processPrompts: Missing required argument "lines" at position 0');
        }
        final lines = D4.coerceList<String>(positional[0], 'lines');
        final continueOnError = D4.getNamedArgWithDefault<bool>(named, 'continueOnError', false);
        return t.processPrompts(lines, continueOnError: continueOnError);
      },
      'help': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.help();
      },
      'info': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        final name = D4.getOptionalArg<String?>(positional, 0, 'name');
        return t.info(name);
      },
      'classes': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.classes();
      },
      'enums': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.enums();
      },
      'methods': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.methods();
      },
      'variables': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.variables();
      },
      'imports': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.imports();
      },
      'registeredClasses': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.registeredClasses();
      },
      'registeredEnums': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.registeredEnums();
      },
      'registeredMethods': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.registeredMethods();
      },
      'registeredVariables': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.registeredVariables();
      },
      'registeredImports': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.registeredImports();
      },
      'showInit': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.showInit();
      },
      'clear': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        t.clear();
        return null;
      },
      'define': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 2, 'define');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'define');
        final template = D4.getRequiredArg<String>(positional, 1, 'template', 'define');
        t.define(name, template);
        return null;
      },
      'undefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'undefine');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'undefine');
        return t.undefine(name);
      },
      'defines': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.defines();
      },
      'loadDefines': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'loadDefines');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadDefines');
        return t.loadDefines(path);
      },
      'invokeDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'invokeDefine');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invokeDefine');
        final args = positional.length > 1
            ? D4.coerceListOrNull<String>(positional[1], 'args')
            : null;
        return t.invokeDefine(name, args);
      },
      'expandDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'expandDefine');
        final input = D4.getRequiredArg<String>(positional, 0, 'input', 'expandDefine');
        return t.expandDefine(input);
      },
      'sessions': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.sessions();
      },
      'scripts': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.scripts();
      },
      'plays': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.plays();
      },
      'executes': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.executes();
      },
      'ls': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        final path = D4.getOptionalArg<String?>(positional, 0, 'path');
        return t.ls(path);
      },
      'cd': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'cd');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'cd');
        return t.cd(path);
      },
      'cwd': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.cwd();
      },
      'home': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.home();
      },
      'startDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        t.startDefine();
        return null;
      },
      'startScript': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        t.startScript();
        return null;
      },
      'startFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        t.startFile();
        return null;
      },
      'startExecute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        t.startExecute();
        return null;
      },
      'end': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        return t.end();
      },
      'clearMultilineBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        t.clearMultilineBuffer();
        return null;
      },
      'execute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'execute');
        final source = D4.getRequiredArg<String>(positional, 0, 'source', 'execute');
        final basePath = D4.getOptionalNamedArg<String?>(named, 'basePath');
        return t.execute(source, basePath: basePath);
      },
      'executeFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'executeFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'executeFile');
        return t.executeFile(path);
      },
      'executeContinued': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'executeContinued');
        final source = D4.getRequiredArg<String>(positional, 0, 'source', 'executeContinued');
        final basePath = D4.getOptionalNamedArg<String?>(named, 'basePath');
        return t.executeContinued(source, basePath: basePath);
      },
      'file': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'file');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'file');
        return t.file(path);
      },
      'script': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'script');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'script');
        return t.script(path);
      },
      'load': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'load');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'load');
        return t.load(path);
      },
      'replay': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'replay');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'replay');
        return t.replay(path);
      },
      'session': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'session');
        final sessionId = D4.getRequiredArg<String>(positional, 0, 'sessionId', 'session');
        return t.session(sessionId);
      },
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        final replayPath = D4.getOptionalNamedArg<String?>(named, 'replayPath');
        return t.reset(replayPath: replayPath);
      },
      'loadFile': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'loadFile');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadFile');
        return t.loadFile(path);
      },
      'loadScript': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'loadScript');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadScript');
        return t.loadScript(path);
      },
      'loadReplay': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'loadReplay');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'loadReplay');
        return t.loadReplay(path);
      },
      'loadSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'loadSession');
        final sessionId = D4.getRequiredArg<String>(positional, 0, 'sessionId', 'loadSession');
        return t.loadSession(sessionId);
      },
      'eval': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
        D4.requireMinArgs(positional, 1, 'eval');
        final expression = D4.getRequiredArg<String>(positional, 0, 'expression', 'eval');
        return t.eval(expression);
      },
      'closeSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<D4rtCliApi>(target, 'D4rtCliApi');
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
    nativeType: $tom_d4rt_dcli_1.D4rtCliController,
    name: 'D4rtCliController',
    isAssignable: (v) => v is $tom_d4rt_dcli_1.CliGlobalHolder,
    constructors: {
      '': (visitor, positional, named) {
        return $tom_d4rt_dcli_1.CliGlobalHolder();
      },
    },
    getters: {
      'controller': (visitor, target) => (D4.validateTarget<$tom_d4rt_dcli_1.CliGlobalHolder>(target, 'CliGlobalHolder') as dynamic).controller,
      'isInitialized': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_1.CliGlobalHolder>(target, 'CliGlobalHolder').isInitialized,
    },
    methods: {
      'initialize': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_1.CliGlobalHolder>(target, 'CliGlobalHolder');
        D4.requireMinArgs(positional, 1, 'initialize');
        final controller = D4.getRequiredArg<$tom_d4rt_dcli_1.D4rtCliController>(positional, 0, 'controller', 'initialize');
        t.initialize(controller);
        return null;
      },
      'reset': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_1.CliGlobalHolder>(target, 'CliGlobalHolder');
        t.reset();
        return null;
      },
    },
    constructorSignatures: {
      '': 'CliGlobalHolder()',
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
    nativeType: $tom_d4rt_dcli_2.CliException,
    name: 'CliException',
    isAssignable: (v) => v is CliFileNotFoundException,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'CliFileNotFoundException');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'CliFileNotFoundException');
        return CliFileNotFoundException(path);
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<CliFileNotFoundException>(target, 'CliFileNotFoundException').command,
      'stackTrace': (visitor, target) => D4.validateTarget<CliFileNotFoundException>(target, 'CliFileNotFoundException').stackTrace,
      'message': (visitor, target) => D4.validateTarget<CliFileNotFoundException>(target, 'CliFileNotFoundException').message,
      'path': (visitor, target) => D4.validateTarget<CliFileNotFoundException>(target, 'CliFileNotFoundException').path,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CliFileNotFoundException>(target, 'CliFileNotFoundException');
        return t.toString();
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CliFileNotFoundException>(target, 'CliFileNotFoundException');
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
    nativeType: DirectoryNotFoundException,
    name: 'DirectoryNotFoundException',
    isAssignable: (v) => v is ExecutionException,
    constructors: {
      '': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ExecutionException');
        final message = D4.getRequiredArg<String>(positional, 0, 'message', 'ExecutionException');
        final command = D4.getOptionalNamedArg<String?>(named, 'command');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        return ExecutionException(message, command: command, stackTrace: stackTrace);
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<ExecutionException>(target, 'ExecutionException').command,
      'stackTrace': (visitor, target) => D4.validateTarget<ExecutionException>(target, 'ExecutionException').stackTrace,
      'message': (visitor, target) => D4.validateTarget<ExecutionException>(target, 'ExecutionException').message,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ExecutionException>(target, 'ExecutionException');
        return t.toString();
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<ExecutionException>(target, 'ExecutionException');
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
    nativeType: ReplayException,
    name: 'ReplayException',
    isAssignable: (v) => v is InvalidMultilineModeException,
    constructors: {
      '': (visitor, positional, named) {
        final currentMode = D4.getRequiredNamedArg<String>(named, 'currentMode', 'InvalidMultilineModeException');
        final attemptedMethod = D4.getRequiredNamedArg<String>(named, 'attemptedMethod', 'InvalidMultilineModeException');
        return InvalidMultilineModeException(currentMode: currentMode, attemptedMethod: attemptedMethod);
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<InvalidMultilineModeException>(target, 'InvalidMultilineModeException').command,
      'stackTrace': (visitor, target) => D4.validateTarget<InvalidMultilineModeException>(target, 'InvalidMultilineModeException').stackTrace,
      'message': (visitor, target) => D4.validateTarget<InvalidMultilineModeException>(target, 'InvalidMultilineModeException').message,
      'currentMode': (visitor, target) => D4.validateTarget<InvalidMultilineModeException>(target, 'InvalidMultilineModeException').currentMode,
      'attemptedMethod': (visitor, target) => D4.validateTarget<InvalidMultilineModeException>(target, 'InvalidMultilineModeException').attemptedMethod,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<InvalidMultilineModeException>(target, 'InvalidMultilineModeException');
        return t.toString();
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<InvalidMultilineModeException>(target, 'InvalidMultilineModeException');
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
    nativeType: MaxNestingDepthException,
    name: 'MaxNestingDepthException',
    isAssignable: (v) => v is CliNotInitializedException,
    constructors: {
      '': (visitor, positional, named) {
        return CliNotInitializedException();
      },
    },
    getters: {
      'command': (visitor, target) => D4.validateTarget<CliNotInitializedException>(target, 'CliNotInitializedException').command,
      'stackTrace': (visitor, target) => D4.validateTarget<CliNotInitializedException>(target, 'CliNotInitializedException').stackTrace,
      'message': (visitor, target) => D4.validateTarget<CliNotInitializedException>(target, 'CliNotInitializedException').message,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CliNotInitializedException>(target, 'CliNotInitializedException');
        return t.toString();
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<CliNotInitializedException>(target, 'CliNotInitializedException');
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
    nativeType: $tom_d4rt_dcli_3.ExecuteResult,
    name: 'ExecuteResult',
    isAssignable: (v) => v is $tom_d4rt_dcli_3.ExecuteResult,
    constructors: {
      '': (visitor, positional, named) {
        final success = D4.getRequiredNamedArg<bool>(named, 'success', 'ExecuteResult');
        final error = D4.getOptionalNamedArg<String?>(named, 'error');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        final sourcesLoaded = D4.getNamedArgWithDefault<int>(named, 'sourcesLoaded', 1);
        if (!named.containsKey('result')) {
          return $tom_d4rt_dcli_3.ExecuteResult(success: success, error: error, stackTrace: stackTrace, sourcesLoaded: sourcesLoaded);
        }
        if (named.containsKey('result')) {
          final result = D4.getRequiredNamedArg<dynamic>(named, 'result', 'ExecuteResult');
          return $tom_d4rt_dcli_3.ExecuteResult(success: success, error: error, stackTrace: stackTrace, sourcesLoaded: sourcesLoaded, result: result);
        }
        throw StateError('Unreachable: all named parameter combinations should be covered');
      },
      'success': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ExecuteResult');
        final result = D4.getRequiredArg<dynamic>(positional, 0, 'result', 'ExecuteResult');
        return $tom_d4rt_dcli_3.ExecuteResult.success(result);
      },
      'failure': (visitor, positional, named) {
        D4.requireMinArgs(positional, 1, 'ExecuteResult');
        final error = D4.getRequiredArg<String?>(positional, 0, 'error', 'ExecuteResult');
        final stackTrace = D4.getOptionalNamedArg<StackTrace?>(named, 'stackTrace');
        return $tom_d4rt_dcli_3.ExecuteResult.failure(error, stackTrace: stackTrace);
      },
    },
    getters: {
      'success': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_3.ExecuteResult>(target, 'ExecuteResult').success,
      'result': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_3.ExecuteResult>(target, 'ExecuteResult').result,
      'error': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_3.ExecuteResult>(target, 'ExecuteResult').error,
      'stackTrace': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_3.ExecuteResult>(target, 'ExecuteResult').stackTrace,
      'sourcesLoaded': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_3.ExecuteResult>(target, 'ExecuteResult').sourcesLoaded,
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
    nativeType: $tom_d4rt_dcli_3.ImportInfo,
    name: 'ImportInfo',
    isAssignable: (v) => v is $tom_d4rt_dcli_3.SymbolInfo,
    constructors: {
      '': (visitor, positional, named) {
        final name = D4.getRequiredNamedArg<String>(named, 'name', 'SymbolInfo');
        final kind = D4.getRequiredNamedArg<$tom_d4rt_dcli_3.SymbolKind>(named, 'kind', 'SymbolInfo');
        final documentation = D4.getOptionalNamedArg<String?>(named, 'documentation');
        final details = named.containsKey('details') && named['details'] != null
            ? D4.coerceMap<String, dynamic>(named['details'], 'details')
            : const <String, dynamic>{};
        return $tom_d4rt_dcli_3.SymbolInfo(name: name, kind: kind, documentation: documentation, details: details);
      },
    },
    getters: {
      'name': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_3.SymbolInfo>(target, 'SymbolInfo').name,
      'kind': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_3.SymbolInfo>(target, 'SymbolInfo').kind,
      'documentation': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_3.SymbolInfo>(target, 'SymbolInfo').documentation,
      'details': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_3.SymbolInfo>(target, 'SymbolInfo').details,
    },
    methods: {
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_3.SymbolInfo>(target, 'SymbolInfo');
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
    nativeType: $tom_d4rt_dcli_4.CliRuntime,
    name: 'CliRuntime',
        D4.validateTarget<$tom_d4rt_dcli_4.CliRuntime>(target, 'CliRuntime').processDirectory = D4.extractBridgedArg<String>(value, 'processDirectory'),
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
    nativeType: CliRuntimeImpl,
    name: 'CliRuntimeImpl',
        D4.validateTarget<CliRuntimeImpl>(target, 'CliRuntimeImpl').processDirectory = D4.extractBridgedArg<String>(value, 'processDirectory'),
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
    nativeType: $tom_d4rt_dcli_5.CliState,
    name: 'CliState',
        D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState').sessionFile = D4.extractBridgedArgOrNull<RandomAccessFile>(value, 'sessionFile'),
      'currentSessionId': (visitor, target, value) => 
        D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState').currentSessionId = D4.extractBridgedArgOrNull<String>(value, 'currentSessionId'),
    },
    methods: {
      'cd': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'cd');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'cd');
        return t.cd(path);
      },
      'home': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        return t.home();
      },
      'resolvePath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'resolvePath');
        final path = D4.getRequiredArg<String>(positional, 0, 'path', 'resolvePath');
        return t.resolvePath(path);
      },
      'getDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'getDefine');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'getDefine');
        return t.getDefine(name);
      },
      'setDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 2, 'setDefine');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'setDefine');
        final value = D4.getRequiredArg<String?>(positional, 1, 'value', 'setDefine');
        t.setDefine(name, value);
        return null;
      },
      'removeDefine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'removeDefine');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'removeDefine');
        t.removeDefine(name);
        return null;
      },
      'clearDefines': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        t.clearDefines();
        return null;
      },
      'getSessionPath': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'getSessionPath');
        final sessionId = D4.getRequiredArg<String>(positional, 0, 'sessionId', 'getSessionPath');
        return t.getSessionPath(sessionId);
      },
      'startSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'startSession');
        final sessionId = D4.getRequiredArg<String>(positional, 0, 'sessionId', 'startSession');
        return t.startSession(sessionId);
      },
      'closeSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        t.closeSession();
        return null;
      },
      'recordToSession': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        D4.requireMinArgs(positional, 1, 'recordToSession');
        final command = D4.getRequiredArg<String>(positional, 0, 'command', 'recordToSession');
        t.recordToSession(command);
        return null;
      },
      'clearMultilineBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        t.clearMultilineBuffer();
        return null;
      },
      'dispose': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
        (t as dynamic).dispose();
        return null;
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_5.CliState>(target, 'CliState');
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
    nativeType: VerificationFailure,
    name: 'VerificationFailure',
    isAssignable: (v) => v is $tom_d4rt_dcli_6.ExecutionContext,
    constructors: {
      '': (visitor, positional, named) {
        final workingDirectory = D4.getRequiredNamedArg<String>(named, 'workingDirectory', 'ExecutionContext');
        final sourceFile = D4.getOptionalNamedArg<String?>(named, 'sourceFile');
        final recordToSession = D4.getNamedArgWithDefault<bool>(named, 'recordToSession', true);
        final silent = D4.getNamedArgWithDefault<bool>(named, 'silent', false);
        final parent = D4.getOptionalNamedArg<$tom_d4rt_dcli_6.ExecutionContext?>(named, 'parent');
        return $tom_d4rt_dcli_6.ExecutionContext(workingDirectory: workingDirectory, sourceFile: sourceFile, recordToSession: recordToSession, silent: silent, parent: parent);
      },
    },
    getters: {
      'workingDirectory': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext').workingDirectory,
      'sourceFile': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext').sourceFile,
      'recordToSession': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext').recordToSession,
      'silent': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext').silent,
      'parent': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext').parent,
      'multilineMode': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext').multilineMode,
      'multilineBuffer': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext').multilineBuffer,
      'isMultilineMode': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext').isMultilineMode,
      'isRoot': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext').isRoot,
      'depth': (visitor, target) => D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext').depth,
    },
    setters: {
      'multilineMode': (visitor, target, value) => 
        D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext').multilineMode = D4.extractBridgedArg<$tom_d4rt_dcli_6.MultilineMode>(value, 'multilineMode'),
    },
    methods: {
      'clearMultilineBuffer': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext');
        t.clearMultilineBuffer();
        return null;
      },
      'startMultilineMode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext');
        D4.requireMinArgs(positional, 1, 'startMultilineMode');
        final mode = D4.getRequiredArg<$tom_d4rt_dcli_6.MultilineMode>(positional, 0, 'mode', 'startMultilineMode');
        t.startMultilineMode(mode);
        return null;
      },
      'addMultilineLine': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext');
        D4.requireMinArgs(positional, 1, 'addMultilineLine');
        final line = D4.getRequiredArg<String>(positional, 0, 'line', 'addMultilineLine');
        t.addMultilineLine(line);
        return null;
      },
      'getMultilineCode': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext');
        return t.getMultilineCode();
      },
      'toString': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_dcli_6.ExecutionContext>(target, 'ExecutionContext');
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
    nativeType: $tom_d4rt_dcli_6.ContextStack,
    name: 'ContextStack',
        t.registertopLevelFunction(name, ($tom_d4rt_5.InterpreterVisitor p0, List<Object?> p1, Map<String, Object?> p2, List<$tom_d4rt_7.RuntimeType>? p3) { return D4.castCallbackResult<Object?>(D4.callInterpreterCallback(visitor!, functionRaw, [p0, p1, p2, p3])); }, library, sourceUri: sourceUri, signature: signature);
        return null;
      },
      'registerGlobalVariable': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        D4.requireMinArgs(positional, 3, 'registerGlobalVariable');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'registerGlobalVariable');
        final value = D4.getRequiredArg<Object?>(positional, 1, 'value', 'registerGlobalVariable');
        final library = D4.getRequiredArg<String>(positional, 2, 'library', 'registerGlobalVariable');
        final sourceUri = D4.getOptionalNamedArg<String?>(named, 'sourceUri');
        t.registerGlobalVariable(name, value, library, sourceUri: sourceUri);
        return null;
      },
      'registerGlobalGetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        D4.requireMinArgs(positional, 3, 'registerGlobalGetter');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'registerGlobalGetter');
        if (positional.length <= 1) {
          throw ArgumentError('registerGlobalGetter: Missing required argument "getter" at position 1');
        }
        final getterRaw = positional[1];
        final library = D4.getRequiredArg<String>(positional, 2, 'library', 'registerGlobalGetter');
        final sourceUri = D4.getOptionalNamedArg<String?>(named, 'sourceUri');
        t.registerGlobalGetter(name, () { return D4.castCallbackResult<Object?>(D4.callInterpreterCallback(visitor!, getterRaw, [])); }, library, sourceUri: sourceUri);
        return null;
      },
      'registerGlobalSetter': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        D4.requireMinArgs(positional, 3, 'registerGlobalSetter');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'registerGlobalSetter');
        if (positional.length <= 1) {
          throw ArgumentError('registerGlobalSetter: Missing required argument "setter" at position 1');
        }
        final setterRaw = positional[1];
        final library = D4.getRequiredArg<String>(positional, 2, 'library', 'registerGlobalSetter');
        final sourceUri = D4.getOptionalNamedArg<String?>(named, 'sourceUri');
        t.registerGlobalSetter(name, (Object? p0) { D4.callInterpreterCallback(visitor, setterRaw, [p0]); }, library, sourceUri: sourceUri);
        return null;
      },
      'validateRegistrations': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        final source = D4.getRequiredNamedArg<String>(named, 'source', 'validateRegistrations');
        final sources = D4.coerceMapOrNull<String, String>(named['sources'], 'sources');
        final basePath = D4.getOptionalNamedArg<String?>(named, 'basePath');
        final allowFileSystemImports = D4.getNamedArgWithDefault<bool>(named, 'allowFileSystemImports', false);
        return t.validateRegistrations(source: source, sources: sources, basePath: basePath, allowFileSystemImports: allowFileSystemImports);
      },
      'setDebug': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        D4.requireMinArgs(positional, 1, 'setDebug');
        final enabled = D4.getRequiredArg<bool>(positional, 0, 'enabled', 'setDebug');
        t.setDebug(enabled);
        return null;
      },
      'grant': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        D4.requireMinArgs(positional, 1, 'grant');
        final permission = D4.getRequiredArg<$tom_d4rt_8.Permission>(positional, 0, 'permission', 'grant');
        t.grant(permission);
        return null;
      },
      'revoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        D4.requireMinArgs(positional, 1, 'revoke');
        final permission = D4.getRequiredArg<$tom_d4rt_8.Permission>(positional, 0, 'permission', 'revoke');
        t.revoke(permission);
        return null;
      },
      'hasPermission': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        D4.requireMinArgs(positional, 1, 'hasPermission');
        final permission = D4.getRequiredArg<$tom_d4rt_8.Permission>(positional, 0, 'permission', 'hasPermission');
        return t.hasPermission(permission);
      },
      'checkPermission': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        D4.requireMinArgs(positional, 1, 'checkPermission');
        final operation = D4.getRequiredArg<dynamic>(positional, 0, 'operation', 'checkPermission');
        return t.checkPermission(operation);
      },
      'getConfiguration': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        return t.getConfiguration();
      },
      'getEnvironmentState': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        return t.getEnvironmentState();
      },
      'execute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        final source = D4.getOptionalNamedArg<String?>(named, 'source');
        final name = D4.getNamedArgWithDefault<String>(named, 'name', 'main');
        final positionalArgs = D4.coerceListOrNull<Object?>(named['positionalArgs'], 'positionalArgs');
        final namedArgs = D4.coerceMapOrNull<String, Object?>(named['namedArgs'], 'namedArgs');
        final args = D4.getOptionalNamedArg<Object?>(named, 'args');
        final library = D4.getOptionalNamedArg<String?>(named, 'library');
        final sources = D4.coerceMapOrNull<String, String>(named['sources'], 'sources');
        final basePath = D4.getOptionalNamedArg<String?>(named, 'basePath');
        final allowFileSystemImports = D4.getNamedArgWithDefault<bool>(named, 'allowFileSystemImports', false);
        return t.execute(source: source, name: name, positionalArgs: positionalArgs, namedArgs: namedArgs, args: args, library: library, sources: sources, basePath: basePath, allowFileSystemImports: allowFileSystemImports);
      },
      'continuedExecute': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        final source = D4.getOptionalNamedArg<String?>(named, 'source');
        final name = D4.getNamedArgWithDefault<String>(named, 'name', 'main');
        final positionalArgs = D4.coerceListOrNull<Object?>(named['positionalArgs'], 'positionalArgs');
        final namedArgs = D4.coerceMapOrNull<String, Object?>(named['namedArgs'], 'namedArgs');
        final library = D4.getOptionalNamedArg<String?>(named, 'library');
        return t.continuedExecute(source: source, name: name, positionalArgs: positionalArgs, namedArgs: namedArgs, library: library);
      },
      'analyze': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        final source = D4.getRequiredNamedArg<String>(named, 'source', 'analyze');
        final sources = D4.coerceMapOrNull<String, String>(named['sources'], 'sources');
        final includeBuiltins = D4.getNamedArgWithDefault<bool>(named, 'includeBuiltins', false);
        return t.analyze(source: source, sources: sources, includeBuiltins: includeBuiltins);
      },
      'eval': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        D4.requireMinArgs(positional, 1, 'eval');
        final expression = D4.getRequiredArg<String>(positional, 0, 'expression', 'eval');
        return t.eval(expression);
      },
      'invoke': (visitor, target, positional, named, typeArgs) {
        final t = D4.validateTarget<$tom_d4rt_4.D4rt>(target, 'D4rt');
        D4.requireMinArgs(positional, 2, 'invoke');
        final name = D4.getRequiredArg<String>(positional, 0, 'name', 'invoke');
        if (positional.length <= 1) {
          throw ArgumentError('invoke: Missing required argument "positionalArgs" at position 1');
        }
        final positionalArgs = D4.coerceList<Object?>(positional[1], 'positionalArgs');
        final namedArgs = positional.length > 2 && positional[2] != null
            ? D4.coerceMap<String, Object?>(positional[2], 'namedArgs')
            : const <String, Object?>{};
        final sources = positional.length > 3
            ? D4.coerceMapOrNull<String, String>(positional[3], 'sources')
            : null;
        return t.invoke(name, positionalArgs, namedArgs, sources);
      },
    },
    constructorSignatures: {
      '': 'D4rt()',
    },
    methodSignatures: {
      'registerBridgedEnum': 'void registerBridgedEnum(BridgedEnumDefinition definition, String library, {String? sourceUri})',
      'registerBridgedClass': 'void registerBridgedClass(BridgedClass definition, String library, {String? sourceUri})',
      'registerBridgedExtension': 'void registerBridgedExtension(BridgedExtensionDefinition definition, String library, {String? sourceUri})',
      'registertopLevelFunction': 'void registertopLevelFunction(String? name, NativeFunctionImpl function, String library, {String? sourceUri, String? signature})',
      'registerGlobalVariable': 'void registerGlobalVariable(String name, Object? value, String library, {String? sourceUri})',
      'registerGlobalGetter': 'void registerGlobalGetter(String name, Object? Function() getter, String library, {String? sourceUri})',
      'registerGlobalSetter': 'void registerGlobalSetter(String name, void Function(Object?) setter, String library, {String? sourceUri})',
      'validateRegistrations': 'List<String> validateRegistrations({required String source, Map<String, String>? sources, String? basePath, bool allowFileSystemImports = false})',
      'setDebug': 'void setDebug(bool enabled)',
      'grant': 'void grant(Permission permission)',
      'revoke': 'void revoke(Permission permission)',
      'hasPermission': 'bool hasPermission(Permission permission)',
      'checkPermission': 'bool checkPermission(dynamic operation)',
      'getConfiguration': 'D4rtConfiguration getConfiguration()',
      'getEnvironmentState': 'EnvironmentState? getEnvironmentState()',
      'execute': 'dynamic execute({String? source, String name = \'main\', List<Object?>? positionalArgs, Map<String, Object?>? namedArgs, Object? args, String? library, Map<String, String>? sources, String? basePath, bool allowFileSystemImports = false})',
      'continuedExecute': 'dynamic continuedExecute({String? source, String name = \'main\', List<Object?>? positionalArgs, Map<String, Object?>? namedArgs, String? library})',
      'analyze': 'IntrospectionResult analyze({required String source, Map<String, String>? sources, bool includeBuiltins = false})',
      'eval': 'dynamic eval(String expression)',
      'invoke': 'dynamic invoke(String name, List<Object?> positionalArgs, [Map<String, Object?> namedArgs = const {}, Map<String, String>? sources])',
    },
    getterSignatures: {
      'visitor': 'InterpreterVisitor? get visitor',
    },
  );
}

