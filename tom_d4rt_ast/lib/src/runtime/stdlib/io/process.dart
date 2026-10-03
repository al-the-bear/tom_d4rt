import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:tom_d4rt_ast/runtime.dart';

/// Bridged implementation of dart:io Process functionality
class ProcessIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: Process,
    name: 'Process',
    isAssignable: (v) => v is Process,
    typeParameterCount: 0,
    staticMethods: {
      'start': (visitor, positionalArgs, namedArgs, _) {
        _checkProcessPermission(visitor, positionalArgs);
        return _start(positionalArgs, namedArgs);
      },
      'run': (visitor, positionalArgs, namedArgs, _) {
        _checkProcessPermission(visitor, positionalArgs);
        return _run(positionalArgs, namedArgs);
      },
      'runSync': (visitor, positionalArgs, namedArgs, _) {
        _checkProcessPermission(visitor, positionalArgs);
        return _runSync(positionalArgs, namedArgs);
      },
      'killPid': (visitor, positionalArgs, namedArgs, _) {
        _checkKillPermission(visitor);
        return _killPid(positionalArgs, namedArgs);
      },
    },
    methods: {
      'kill': (visitor, target, positionalArgs, namedArgs, _) =>
          _kill(target, positionalArgs, namedArgs),
    },
    getters: {
      'exitCode': (visitor, target) => (target as Process).exitCode,
      'pid': (visitor, target) => (target as Process).pid,
      'stdin': (visitor, target) => (target as Process).stdin,
      'stdout': (visitor, target) => (target as Process).stdout,
      'stderr': (visitor, target) => (target as Process).stderr,
    },
  );

  static Future<Process> _start(
    List<dynamic> positionalArgs,
    Map<String, dynamic> namedArgs,
  ) async {
    if (positionalArgs.isEmpty) {
      throw ArgumentD4rtException('Process.start requires executable path');
    }

    final executable = positionalArgs[0].toString();
    final arguments = positionalArgs.length > 1
        ? (positionalArgs[1] as List).map((e) => e.toString()).toList()
        : <String>[];

    final workingDirectory = namedArgs['workingDirectory']?.toString();
    final environment = namedArgs['environment'] as Map?;
    final includeParentEnvironment =
        namedArgs['includeParentEnvironment'] as bool? ?? true;
    final runInShell = namedArgs['runInShell'] as bool? ?? false;
    final mode = namedArgs['mode'] ?? ProcessStartMode.normal;

    return await Process.start(
      executable,
      arguments,
      workingDirectory: workingDirectory,
      environment: environment?.cast(),
      includeParentEnvironment: includeParentEnvironment,
      runInShell: runInShell,
      mode: mode,
    );
  }

  static Future<ProcessResult> _run(
    List<dynamic> positionalArgs,
    Map<String, dynamic> namedArgs,
  ) async {
    if (positionalArgs.isEmpty) {
      throw ArgumentD4rtException('Process.run requires executable path');
    }

    final executable = positionalArgs[0].toString();
    final arguments = positionalArgs.length > 1
        ? (positionalArgs[1] as List).map((e) => e.toString()).toList()
        : <String>[];

    final workingDirectory = namedArgs['workingDirectory']?.toString();
    final environment = namedArgs['environment'] as Map?;
    final includeParentEnvironment =
        namedArgs['includeParentEnvironment'] as bool? ?? true;
    final runInShell = namedArgs['runInShell'] as bool? ?? false;
    final stdoutEncoding =
        namedArgs['stdoutEncoding'] as Encoding? ?? systemEncoding;
    final stderrEncoding =
        namedArgs['stderrEncoding'] as Encoding? ?? systemEncoding;

    return await Process.run(
      executable,
      arguments,
      workingDirectory: workingDirectory,
      environment: environment?.cast(),
      includeParentEnvironment: includeParentEnvironment,
      runInShell: runInShell,
      stdoutEncoding: stdoutEncoding,
      stderrEncoding: stderrEncoding,
    );
  }

  static ProcessResult _runSync(
    List<dynamic> positionalArgs,
    Map<String, dynamic> namedArgs,
  ) {
    if (positionalArgs.isEmpty) {
      throw ArgumentD4rtException('Process.runSync requires executable path');
    }

    // Check process permission
    final executable = positionalArgs[0].toString();
    final arguments = positionalArgs.length > 1
        ? (positionalArgs[1] as List).map((e) => e.toString()).toList()
        : <String>[];

    // Note: We can't get visitor here, so we need to modify the approach
    // The permission check should be done in the static methods wrapper

    final workingDirectory = namedArgs['workingDirectory']?.toString();
    final environment = namedArgs['environment'] as Map?;
    final includeParentEnvironment =
        namedArgs['includeParentEnvironment'] as bool? ?? true;
    final runInShell = namedArgs['runInShell'] as bool? ?? false;
    final stdoutEncoding =
        namedArgs['stdoutEncoding'] as Encoding? ?? systemEncoding;
    final stderrEncoding =
        namedArgs['stderrEncoding'] as Encoding? ?? systemEncoding;

    return Process.runSync(
      executable,
      arguments,
      workingDirectory: workingDirectory,
      environment: environment?.cast(),
      includeParentEnvironment: includeParentEnvironment,
      runInShell: runInShell,
      stdoutEncoding: stdoutEncoding,
      stderrEncoding: stderrEncoding,
    );
  }

  static bool _killPid(
    List<dynamic> positionalArgs,
    Map<String, dynamic> namedArgs,
  ) {
    if (positionalArgs.isEmpty) {
      throw ArgumentD4rtException('Process.killPid requires pid');
    }

    final pid = positionalArgs[0] as int;
    final signal = namedArgs['signal'] ?? ProcessSignal.sigterm;

    return Process.killPid(pid, signal);
  }

  static bool _kill(
    dynamic instance,
    List<dynamic> positionalArgs,
    Map<String, dynamic> namedArgs,
  ) {
    if (instance is! Process) {
      throw ArgumentD4rtException('Invalid process instance');
    }

    final signal = namedArgs['signal'] ?? ProcessSignal.sigterm;
    return instance.kill(signal);
  }

  /// The permission check for [visitor]'s run, or null when nothing is
  /// enforced.
  static bool Function(dynamic)? _permissionCheck(InterpreterVisitor visitor) {
    // The module context answers; with no checker wired it is permissive,
    // as the reference tree is with no interpreter instance.
    return visitor.moduleContext.checkPermission;
  }

  /// Asserts the script may start the process [positionalArgs] describes
  /// (DFIN3).
  ///
  /// THE RULE: a ProcessRunPermission covering the command and its arguments,
  /// OR a FilesystemPermission with `execute` on the executable. Either one is
  /// enough. The executable is the command itself when it names a path, else
  /// the first match on `PATH`, and the check reads its REAL path so a symlink
  /// cannot borrow another file's grant. A command that resolves to no file
  /// can only be allowed by ProcessRunPermission.
  static void _checkProcessPermission(
    InterpreterVisitor visitor,
    List<Object?> positionalArgs,
  ) {
    final check = _permissionCheck(visitor);
    if (check == null) return;

    final command = positionalArgs.isNotEmpty
        ? positionalArgs[0].toString()
        : '';
    final args = positionalArgs.length > 1 && positionalArgs[1] is List
        ? [for (final a in positionalArgs[1] as List) a.toString()]
        : <String>[];

    if (check({'type': 'process', 'command': command, 'args': args})) return;

    final executable = resolveExecutable(command);
    if (executable != null &&
        check({
          'type': 'filesystem',
          'path': executable,
          'read': false,
          'write': false,
          'execute': true,
        })) {
      return;
    }

    throw RuntimeD4rtException(
      'Running "$command" requires a ProcessRunPermission for the command, '
      'or a FilesystemPermission with execute on '
      '${executable == null ? 'its executable' : '"$executable"'}.',
    );
  }

  /// `Process.killPid` names no executable, so only ProcessRunPermission can
  /// allow it.
  static void _checkKillPermission(InterpreterVisitor visitor) {
    final check = _permissionCheck(visitor);
    if (check == null) return;
    if (check({'type': 'process'})) return;
    throw RuntimeD4rtException(
      'Process.killPid requires ProcessRunPermission. '
      'Use d4rt.grant(ProcessRunPermission.any) to allow it.',
    );
  }

  /// The real path of the executable [command] runs, or null when none is
  /// found: the command itself when it names a path, else the first match on
  /// `PATH` (with `PATHEXT` on Windows).
  static String? resolveExecutable(String command) {
    if (command.isEmpty) return null;
    String? real(File f) =>
        f.existsSync() ? f.resolveSymbolicLinksSync() : null;
    if (command.contains('/') || command.contains(Platform.pathSeparator)) {
      return real(File(command).absolute);
    }
    final pathVar = Platform.environment['PATH'] ?? '';
    final extensions = Platform.isWindows
        ? [
            '',
            ...(Platform.environment['PATHEXT'] ?? '.EXE;.BAT;.CMD').split(';'),
          ]
        : const [''];
    for (final dir in pathVar.split(Platform.isWindows ? ';' : ':')) {
      if (dir.isEmpty) continue;
      for (final ext in extensions) {
        final found = real(File('$dir${Platform.pathSeparator}$command$ext'));
        if (found != null) return found;
      }
    }
    return null;
  }
}

/// Bridged implementation of ProcessResult
class ProcessResultIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: ProcessResult,
    name: 'ProcessResult',
    isAssignable: (v) => v is ProcessResult,
    typeParameterCount: 0,
    constructors: {
      '': (visitor, positionalArgs, namedArgs) {
        if (positionalArgs.length != 4 ||
            positionalArgs[0] is! int ||
            positionalArgs[1] is! int) {
          throw RuntimeD4rtException(
            'ProcessResult(pid, exitCode, stdout, stderr) requires two int '
            'arguments followed by the two output values.',
          );
        }
        return ProcessResult(
          positionalArgs[0] as int,
          positionalArgs[1] as int,
          positionalArgs[2],
          positionalArgs[3],
        );
      },
    },
    getters: {
      'exitCode': (visitor, target) => (target as ProcessResult).exitCode,
      'pid': (visitor, target) => (target as ProcessResult).pid,
      'stdout': (visitor, target) => (target as ProcessResult).stdout,
      'stderr': (visitor, target) => (target as ProcessResult).stderr,
    },
  );
}

/// Bridged implementation of ProcessSignal
class ProcessSignalIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: ProcessSignal,
    name: 'ProcessSignal',
    isAssignable: (v) => v is ProcessSignal,
    typeParameterCount: 0,
    staticGetters: {
      'sighup': (visitor) => ProcessSignal.sighup,
      'sigint': (visitor) => ProcessSignal.sigint,
      'sigquit': (visitor) => ProcessSignal.sigquit,
      'sigill': (visitor) => ProcessSignal.sigill,
      'sigtrap': (visitor) => ProcessSignal.sigtrap,
      'sigabrt': (visitor) => ProcessSignal.sigabrt,
      'sigbus': (visitor) => ProcessSignal.sigbus,
      'sigfpe': (visitor) => ProcessSignal.sigfpe,
      'sigkill': (visitor) => ProcessSignal.sigkill,
      'sigusr1': (visitor) => ProcessSignal.sigusr1,
      'sigsegv': (visitor) => ProcessSignal.sigsegv,
      'sigusr2': (visitor) => ProcessSignal.sigusr2,
      'sigpipe': (visitor) => ProcessSignal.sigpipe,
      'sigalrm': (visitor) => ProcessSignal.sigalrm,
      'sigterm': (visitor) => ProcessSignal.sigterm,
      'sigchld': (visitor) => ProcessSignal.sigchld,
      'sigcont': (visitor) => ProcessSignal.sigcont,
      'sigstop': (visitor) => ProcessSignal.sigstop,
      'sigtstp': (visitor) => ProcessSignal.sigtstp,
      'sigttin': (visitor) => ProcessSignal.sigttin,
      'sigttou': (visitor) => ProcessSignal.sigttou,
      'sigurg': (visitor) => ProcessSignal.sigurg,
      'sigxcpu': (visitor) => ProcessSignal.sigxcpu,
      'sigxfsz': (visitor) => ProcessSignal.sigxfsz,
      'sigvtalrm': (visitor) => ProcessSignal.sigvtalrm,
      'sigprof': (visitor) => ProcessSignal.sigprof,
      'sigwinch': (visitor) => ProcessSignal.sigwinch,
      'sigpoll': (visitor) => ProcessSignal.sigpoll,
      'sigsys': (visitor) => ProcessSignal.sigsys,
    },
    getters: {
      'name': (visitor, target) => (target as ProcessSignal).name,
      'signalNumber': (visitor, target) =>
          (target as ProcessSignal).signalNumber,
      'runtimeType': (visitor, target) => (target as ProcessSignal).runtimeType,
      'hashCode': (visitor, target) => (target as ProcessSignal).hashCode,
    },
    methods: {
      'watch': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as ProcessSignal).watch(),
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as ProcessSignal).toString(),
    },
  );
}

/// Bridged implementation of ProcessStartMode
class ProcessStartModeIo {
  static BridgedClass get definition => BridgedClass(
    nativeType: ProcessStartMode,
    name: 'ProcessStartMode',
    isAssignable: (v) => v is ProcessStartMode,
    typeParameterCount: 0,
    staticGetters: {
      'normal': (visitor) => ProcessStartMode.normal,
      'inheritStdio': (visitor) => ProcessStartMode.inheritStdio,
      'detached': (visitor) => ProcessStartMode.detached,
      'detachedWithStdio': (visitor) => ProcessStartMode.detachedWithStdio,
      // `values` is a `static const List`, so it belongs beside the
      // individual constants and not in an instance map.
      'values': (visitor) => ProcessStartMode.values,
    },
    // `ProcessStartMode` is *not* a Dart `enum` — it is a final class with
    // static const instances, so it has no `name` and no `index`. Its
    // `toString()` is what yields the declared name, and adding a synthesised
    // `name` here would let a script write something the SDK rejects.
    methods: {
      'toString': (visitor, target, positionalArgs, namedArgs, _) =>
          (target as ProcessStartMode).toString(),
    },
  );
}
