import 'dart:io';
import 'dart:convert';
import 'package:tom_d4rt_ast/runtime.dart';

import '../stream_listen.dart';

class StdinIo {
  static BridgedClass get definition => BridgedClass(
        nativeType: Stdin,
        name: 'Stdin',
        isAssignable: (v) => v is Stdin,
        typeParameterCount: 0,
        methods: {
          'readLineSync': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as Stdin).readLineSync(
                  encoding:
                      namedArgs['encoding'] as Encoding? ?? systemEncoding,
                  retainNewlines:
                      namedArgs['retainNewlines'] as bool? ?? false),
          'readByteSync': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as Stdin).readByteSync(),
          'listen': (visitor, target, positionalArgs, namedArgs, _) =>
              bridgedStreamListen(visitor, target as Stdin, positionalArgs,
                  namedArgs),
        },
        getters: {
          'hasTerminal': (visitor, target) => (target as Stdin).hasTerminal,
          'echoMode': (visitor, target) => (target as Stdin).echoMode,
          'lineMode': (visitor, target) => (target as Stdin).lineMode,
          'echoNewlineMode': (visitor, target) =>
              (target as Stdin).echoNewlineMode,
        },
      );
}

class StdoutIo {
  static BridgedClass get definition => BridgedClass(
        nativeType: Stdout,
        name: 'Stdout',
        isAssignable: (v) => v is Stdout,
        typeParameterCount: 0,
        constructors: {},
        methods: {
          'write': (visitor, target, positionalArgs, namedArgs, _) {
            (target as Stdout).write(positionalArgs[0]);
            return null;
          },
          'writeln': (visitor, target, positionalArgs, namedArgs, _) {
            (target as Stdout)
                .writeln(positionalArgs.isNotEmpty ? positionalArgs[0] : '');
            return null;
          },
          'writeAll': (visitor, target, positionalArgs, namedArgs, _) {
            final stdout = target as Stdout;
            if (positionalArgs.isEmpty || positionalArgs[0] is! Iterable) {
              throw RuntimeD4rtException('writeAll requires an Iterable argument.');
            }
            stdout.writeAll(
              positionalArgs[0] as Iterable<dynamic>,
              positionalArgs.length > 1 ? positionalArgs[1] as String : '',
            );
            return null;
          },
          'add': (visitor, target, positionalArgs, namedArgs, _) {
            final stdout = target as Stdout;
            if (positionalArgs.length != 1 || positionalArgs[0] is! List) {
              throw RuntimeD4rtException('add requires a List<int> argument.');
            }
            stdout.add(positionalArgs[0] as List<int>);
            return null;
          },
          'addStream': (visitor, target, positionalArgs, namedArgs, _) {
            final stdout = target as Stdout;
            if (positionalArgs.length != 1 ||
                positionalArgs[0] is! Stream<List<int>>) {
              throw RuntimeD4rtException(
                  'addStream requires a Stream<List<int>> argument.');
            }
            return stdout.addStream(positionalArgs[0] as Stream<List<int>>);
          },
          'flush': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as Stdout).flush(),
          'close': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as Stdout).close(),
          'addError': (visitor, target, positionalArgs, namedArgs, _) {
            final stdout = target as Stdout;
            if (positionalArgs.isEmpty) {
              throw RuntimeD4rtException(
                  'addError requires at least one argument (error).');
            }
            stdout.addError(
              positionalArgs[0]!,
              positionalArgs.length > 1
                  ? positionalArgs[1] as StackTrace?
                  : null,
            );
            return null;
          },
          'toString': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as Stdout).toString(),
        },
        getters: {
          'encoding': (visitor, target) => (target as Stdout).encoding,
          'done': (visitor, target) => (target as Stdout).done,
          'supportsAnsiEscapes': (visitor, target) =>
              (target as Stdout).supportsAnsiEscapes,
          'terminalLines': (visitor, target) =>
              (target as Stdout).terminalLines,
          'terminalColumns': (visitor, target) =>
              (target as Stdout).terminalColumns,
          'hasTerminal': (visitor, target) => (target as Stdout).hasTerminal,
          'runtimeType': (visitor, target) => (target as Stdout).runtimeType,
          'hashCode': (visitor, target) => (target as Stdout).hashCode,
        },
        setters: {
          'encoding': (visitor, target, value) {
            if (value is! Encoding) {
              throw RuntimeD4rtException(
                  'encoding setter requires an Encoding argument.');
            }
            (target as Stdout).encoding = value;
            return;
          },
        },
      );
}

class StdioTypeIo {
  static BridgedClass get definition => BridgedClass(
        nativeType: StdioType,
        name: 'StdioType',
        isAssignable: (v) => v is StdioType,
        typeParameterCount: 0,
        // These are `static const` on the SDK type. They were registered as
        // instance getters, so `StdioType.terminal` could not resolve — leaving
        // `stdioType()` returning a value no script could compare against.
        staticGetters: {
          'terminal': (visitor) => StdioType.terminal,
          'pipe': (visitor) => StdioType.pipe,
          'file': (visitor) => StdioType.file,
          'other': (visitor) => StdioType.other,
        },
        methods: {
          'toString': (visitor, target, positionalArgs, namedArgs, _) =>
              (target as StdioType).toString(),
        },
        getters: {
          'name': (visitor, target) => (target as StdioType).name,
          'hashCode': (visitor, target) => (target as StdioType).hashCode,
          'runtimeType': (visitor, target) => (target as StdioType).runtimeType,
        },
      );
}

class IoStdioStdlib {
  static void register(Environment environment) {
    // Register classes
    environment.defineBridge(StdinIo.definition);
    environment.defineBridge(StdoutIo.definition);
    environment.defineBridge(StdioTypeIo.definition);
    environment.define('stdin', stdin);
    environment.define('stdout', stdout);
    environment.define('stderr', stderr);

    // `stdioType` is the only way to obtain a StdioType, so registering the
    // class without it left the type inert — nothing could produce a value.
    environment.define(
        'stdioType',
        NativeFunction((visitor, arguments, namedArguments, typeArguments) {
          if (arguments.length != 1) {
            throw RuntimeD4rtException(
                'stdioType requires exactly one argument.');
          }
          return stdioType(arguments[0]);
        }, arity: 1, name: 'stdioType'));
  }
}
