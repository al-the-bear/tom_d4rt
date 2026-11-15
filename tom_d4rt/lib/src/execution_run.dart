/// The runtime side of per-execution hooks (GitHub #19, ghfeatures1): the
/// [ExecutionRun] behind a [D4rtExecutionContext]. Not exported; the runners,
/// the module loaders and `D4.enterInterpreted` drive it.
///
/// This file is mirrored between `tom_d4rt` (lib/src/) and `tom_d4rt_ast`
/// (lib/src/runtime/); keep the two identical.
library;

import 'dart:async';

import 'execution_hooks.dart';
import 'security/permissions.dart';
import 'stdio_capture_stub.dart' if (dart.library.io) 'stdio_capture_io.dart';

/// Zone key under which a run's execution Zone (and every Zone below it)
/// carries its [ExecutionRun].
final Object _runKey = Object();

/// Zone key under which an accepted native entry's child Zone carries it.
final Object _entryKey = Object();

/// The run whose Zone the current code runs in.
D4rtExecutionContext? currentExecutionRun() =>
    Zone.current[_runKey] as ExecutionRun?;

/// The accepted native entry the current code runs on behalf of.
D4rtEntry? currentAcceptedEntry() => Zone.current[_entryKey] as D4rtEntry?;

/// One execution with hooks: its state, its Zones and its bookkeeping.
class ExecutionRun implements D4rtExecutionContext {
  ExecutionRun({
    required this.hooks,
    required this.entryUri,
    required bool Function(dynamic operation) runnerCheck,
    required Set<Permission> Function() runnerGranted,
    this.owner,
  }) : _runnerCheck = runnerCheck,
       _runnerGranted = runnerGranted,
       _runPermissions = hooks.permissions == null
           ? null
           : {...hooks.permissions!};

  static int _nextId = 1;

  final D4rtExecutionHooks hooks;

  /// The runner that executes this run.
  final Object? owner;

  @override
  final int id = _nextId++;

  @override
  final String entryUri;

  final bool Function(dynamic operation) _runnerCheck;
  final Set<Permission> Function() _runnerGranted;

  /// The run's own set before the runner's ceiling; null: the runner's.
  Set<Permission>? _runPermissions;

  @override
  final Map<Object, Object?> data = {};

  Zone? _zone;

  @override
  Zone get zone => _zone ?? Zone.current;

  /// The innermost runtime Zone (the script Zone); accepted native entries
  /// fork their child Zone from it. Set by the runner.
  Zone? scriptZone;

  bool _started = false;
  bool _revoked = false;
  Object? _revokeReason;
  bool _graceExpired = false;
  bool _ended = false;
  bool _final = false;
  int _pendingEntries = 0;
  int _pendingTasks = 0;
  Completer<void> _drainedCompleter = Completer<void>();
  final Set<String> _importsSeen = {};
  final List<_TrackedTask> _tasks = [];
  final StringBuffer _outLine = StringBuffer();
  final StringBuffer _errLine = StringBuffer();

  // ---------------------------------------------------------------------------
  // D4rtExecutionContext
  // ---------------------------------------------------------------------------

  @override
  bool get isRevoked => _revoked;

  @override
  Object? get revokeReason => _revokeReason;

  @override
  bool get hasEnded => _ended;

  @override
  int get pendingEntries => _pendingEntries;

  @override
  int get pendingTasks => _pendingTasks;

  @override
  bool get isDrained => _pendingEntries == 0 && _pendingTasks == 0;

  @override
  Future<void> get drained => _drainedCompleter.future;

  @override
  void revoke([Object? reason, Duration? grace]) {
    if (_revoked) return;
    _revoked = true;
    _revokeReason = reason;
    if (grace != null) {
      Zone.root.createTimer(grace, () => _expireGrace(reason));
    }
    _notify(() => hooks.onRevoked?.call(this, reason));
    if (hooks.tracking.onRevoke == D4rtRevokeAction.cancelNotStarted) {
      _cancelNotStarted();
    }
    if (isDrained) _signalDrained();
  }

  @override
  Future<void> revokeAndDrain([
    Object? reason,
    Duration? grace,
    Duration? timeout,
  ]) {
    revoke(reason, grace);
    final future = drained;
    return timeout == null ? future : future.timeout(timeout);
  }

  void _expireGrace(Object? reason) {
    if (_graceExpired) return;
    _graceExpired = true;
    _cancelNotStarted();
    _notify(() => hooks.onRevoked?.call(this, D4rtGraceExpired(reason)));
    if (isDrained) _signalDrained();
  }

  @override
  Set<Permission> get permissions {
    final granted = _runnerGranted();
    final own = _runPermissions;
    return own == null ? {...granted} : own.intersection(granted);
  }

  @override
  void revokePermission(Permission permission) {
    (_runPermissions ??= {..._runnerGranted()}).remove(permission);
  }

  /// The run's answer for a permission check: the runner allows [operation]
  /// and so does the run's own set.
  bool checkPermission(dynamic operation) {
    if (!_runnerCheck(operation)) return false;
    final own = _runPermissions;
    if (own == null) return true;
    for (final permission in own) {
      if (permission.allows(operation)) return true;
    }
    return false;
  }

  @override
  bool get mayUseCapabilities {
    if (!_revoked) return true;
    if (_graceExpired) return false;
    final entry = currentAcceptedEntry();
    return entry != null &&
        identical(entry.runToken, this) &&
        entry.acceptedBeforeRevocation;
  }

  @override
  void checkCapabilityUse([String? capability]) {
    if (!mayUseCapabilities) {
      throw D4rtExecutionRevokedException(
        _revokeReason,
        capability: capability,
      );
    }
  }

  // ---------------------------------------------------------------------------
  // Zones
  // ---------------------------------------------------------------------------

  /// Forks the run's Zones from the current Zone: the embedder's
  /// specifications (the first carries the run and the embedder's values),
  /// then the runtime's task tracking and output capture when the hooks ask
  /// for them. Returns the Zone the runtime's script Zone is forked from.
  ///
  /// Forked once; a second call answers the same Zone.
  Zone forkExecutionZones() => _runtimeZone ??= _forkExecutionZones();

  Zone? _runtimeZone;

  Zone _forkExecutionZones() {
    var zone = Zone.current;
    final values = <Object?, Object?>{...?hooks.zoneValues, _runKey: this};
    final specs = hooks.zoneSpecifications;
    if (specs.isEmpty) {
      zone = zone.fork(zoneValues: values);
    } else {
      for (var i = 0; i < specs.length; i++) {
        zone = zone.fork(
          specification: specs[i],
          zoneValues: i == 0 ? values : null,
        );
      }
    }
    _zone = zone;
    final runtimeSpec = _runtimeSpecification();
    if (runtimeSpec != null) zone = zone.fork(specification: runtimeSpec);
    final output = hooks.output;
    if (output != null && output.captureStdio) {
      zone = forkStdioCapture(
        zone,
        out: (text) => _write(text, isErr: false),
        err: (text) => _write(text, isErr: true),
        echo: output.echo,
      );
    }
    return zone;
  }

  ZoneSpecification? _runtimeSpecification() {
    final tracking = hooks.tracking;
    final output = hooks.output;
    if (!tracking.tracksTasks && output == null) return null;
    return ZoneSpecification(
      print: output == null
          ? null
          : (self, parent, zone, line) {
              if (output.out == null || output.echo) {
                parent.print(zone, line);
              }
              if (output.out != null) _write('$line\n', isErr: false);
            },
      createTimer: !tracking.timers
          ? null
          : (self, parent, zone, duration, callback) {
              final task = _TrackedTask(this, D4rtTaskKind.timer);
              task.timer = parent.createTimer(zone, duration, () {
                if (task.cancelled) return;
                try {
                  callback();
                } finally {
                  task.finish();
                }
              });
              _track(task, D4rtTask(D4rtTaskKind.timer, duration));
              return task;
            },
      createPeriodicTimer: !tracking.periodicTimers
          ? null
          : (self, parent, zone, period, callback) {
              final task = _TrackedTask(this, D4rtTaskKind.periodicTimer);
              task.timer = parent.createPeriodicTimer(zone, period, (_) {
                if (task.cancelled) return;
                callback(task);
              });
              _track(task, D4rtTask(D4rtTaskKind.periodicTimer, period));
              return task;
            },
      scheduleMicrotask: !tracking.microtasks
          ? null
          : (self, parent, zone, callback) {
              final task = _TrackedTask(this, D4rtTaskKind.microtask);
              parent.scheduleMicrotask(zone, () {
                if (task.cancelled) return;
                try {
                  callback();
                } finally {
                  task.finish();
                }
              });
              _track(task, const D4rtTask(D4rtTaskKind.microtask));
            },
    );
  }

  void _track(_TrackedTask task, D4rtTask description) {
    _tasks.add(task);
    _pendingTasks++;
    if (hooks.onTask != null) {
      _notify(() => hooks.onTask!(this, description));
    }
  }

  void _taskFinished(_TrackedTask task) {
    _tasks.remove(task);
    _pendingTasks--;
    if (isDrained) _signalDrained();
  }

  void _cancelNotStarted() {
    for (final task in List.of(_tasks)) {
      task.cancel();
    }
  }

  // ---------------------------------------------------------------------------
  // Output
  // ---------------------------------------------------------------------------

  void _write(String text, {required bool isErr}) {
    final output = hooks.output!;
    final sink = isErr ? output.err : output.out;
    if (sink == null) return;
    if (!output.lines) {
      sink(text);
      return;
    }
    final buffer = isErr ? _errLine : _outLine;
    buffer.write(text);
    final content = buffer.toString();
    final last = content.lastIndexOf('\n');
    if (last < 0) return;
    buffer
      ..clear()
      ..write(content.substring(last + 1));
    for (final line in content.substring(0, last).split('\n')) {
      sink(line);
    }
  }

  void _flushLines() {
    final output = hooks.output;
    if (output == null || !output.lines) return;
    if (_outLine.isNotEmpty) {
      output.out?.call(_outLine.toString());
      _outLine.clear();
    }
    if (_errLine.isNotEmpty) {
      output.err?.call(_errLine.toString());
      _errLine.clear();
    }
  }

  // ---------------------------------------------------------------------------
  // Lifecycle
  // ---------------------------------------------------------------------------

  /// Calls `onStart`. A throw refuses the run: it is drained and final, and
  /// [D4rtExecutionRejectedException] is thrown.
  ///
  /// Called once; a second call does nothing.
  void start() {
    if (_started) return;
    _started = true;
    final onStart = hooks.onStart;
    if (onStart == null) return;
    try {
      onStart(this);
    } catch (error, stackTrace) {
      _final = true;
      _revoked = true;
      _revokeReason = error;
      if (!_drainedCompleter.isCompleted) _drainedCompleter.complete();
      throw D4rtExecutionRejectedException(error, stackTrace);
    }
  }

  /// Calls `onImport` for [library] once per run.
  void checkImport(Uri library) {
    final onImport = hooks.onImport;
    if (onImport == null) return;
    if (!_importsSeen.add(library.toString())) return;
    onImport(this, library);
  }

  /// Runs the entry function [invoke] as the run's first accepted work and
  /// reports its outcome to `onEnd` (an async entry: when its Future
  /// settles).
  Object? runEntryFunction(
    String name,
    Object? Function() invoke,
    Object? Function(Object? value) unwrap,
  ) {
    return enter(
      D4rtEntryKind.callback,
      name,
      false,
      invoke,
      onSettled: (value, error, stackTrace) => _end(
        error == null
            ? D4rtExecutionOutcome.value(unwrap(value))
            : D4rtExecutionOutcome.error(error, stackTrace),
      ),
      isEntryFunction: true,
    );
  }

  /// Ends the run with [error] when it failed before its entry function ran
  /// (an import, a declaration); a no-op once it has ended.
  void endWithError(Object error, StackTrace stackTrace) =>
      _end(D4rtExecutionOutcome.error(error, stackTrace));

  void _end(D4rtExecutionOutcome outcome) {
    if (_ended) return;
    _ended = true;
    _notify(() => hooks.onEnd?.call(this, outcome));
  }

  /// One entry of interpreted code from native code.
  ///
  /// A native entry after revocation is refused (when the hooks proceed)
  /// unless it runs on behalf of accepted work (a continuation, a timer that
  /// work scheduled); a nested entry always runs. An accepted native entry runs in
  /// a child Zone of the script Zone carrying it ([D4rtEntry.current]), so a
  /// callback fired from another Zone runs in the run's Zone.
  Object? enter(
    D4rtEntryKind kind,
    String name,
    bool isNested,
    Object? Function() invoke, {
    void Function(Object? value, Object? error, StackTrace? stackTrace)?
    onSettled,
    bool isEntryFunction = false,
  }) {
    final enclosing = currentAcceptedEntry();
    final ownEnclosing =
        enclosing != null && identical(enclosing.runToken, this)
        ? enclosing
        : null;
    // Part of accepted work: a nested entry (interpreted code of the run is
    // on the stack) or a native entry on behalf of an accepted entry (a
    // continuation, a timer that work scheduled). It keeps the standing of
    // the work it belongs to.
    final partOfAccepted = isNested || ownEnclosing != null;
    final entry = D4rtEntry.internal(
      kind: kind,
      name: name,
      isNested: isNested,
      acceptedBeforeRevocation: partOfAccepted && ownEnclosing != null
          ? ownEnclosing.acceptedBeforeRevocation
          : !_revoked,
      run: this,
    );

    Object? accepted() {
      // A new native entry after revocation is refused before any of its
      // interpreted code runs. Checked when the hooks proceed, so a hook may
      // answer a substitute value instead (§6).
      if (_revoked && !partOfAccepted && !isEntryFunction) {
        throw D4rtExecutionRevokedException(_revokeReason, entry: name);
      }
      final counts = hooks.tracking.entries;
      if (counts) _pendingEntries++;
      var settled = false;
      void settle(Object? value, Object? error, StackTrace? stackTrace) {
        if (settled) return;
        settled = true;
        onSettled?.call(value, error, stackTrace);
        if (counts) {
          _pendingEntries--;
          if (isDrained) _signalDrained();
        }
      }

      final Object? result;
      try {
        final childZone = isNested ? null : _entryZone(entry);
        result = childZone == null ? invoke() : childZone.run(invoke);
      } catch (error, stackTrace) {
        settle(null, error, stackTrace);
        rethrow;
      }
      if (result is Future) {
        entry.markAsync();
        // Settle alongside the caller: the Future handed back is the
        // callable's own (its type and its unhandled-error reporting stay as
        // they are); this listener only does the bookkeeping.
        result.then<void>(
          (value) => settle(value, null, null),
          onError: (Object error, StackTrace stackTrace) =>
              settle(null, error, stackTrace),
        );
        return result;
      }
      settle(result, null, null);
      return result;
    }

    Object? Function() run = accepted;
    final onNativeEntry = hooks.onNativeEntry;
    if (!isNested && onNativeEntry != null) {
      final inner = run;
      run = () => onNativeEntry(this, entry, inner);
    }
    final onEntry = hooks.onEntry;
    if (onEntry != null) {
      final inner = run;
      run = () => onEntry(this, entry, inner);
    }
    return run();
  }

  Zone? _entryZone(D4rtEntry entry) {
    final base = scriptZone ?? _zone;
    if (base == null) return null;
    return base.fork(zoneValues: {_entryKey: entry});
  }

  void _signalDrained() {
    if (_final) return;
    _flushLines();
    if (_revoked) _final = true;
    _notify(() => hooks.onDrained?.call(this));
    if (!_drainedCompleter.isCompleted) _drainedCompleter.complete();
    if (!_final) _drainedCompleter = Completer<void>();
  }

  /// Runs a notification hook; a throw is reported as an uncaught error of
  /// the run rather than unwinding runtime bookkeeping.
  void _notify(void Function() call) {
    try {
      call();
    } catch (error, stackTrace) {
      zone.handleUncaughtError(error, stackTrace);
    }
  }

  /// Reports an uncaught error of the run to `onError`; false when the run
  /// has none.
  bool reportError(Object error, StackTrace stackTrace) {
    final onError = hooks.onError;
    if (onError == null) return false;
    onError(this, error, stackTrace);
    return true;
  }
}

/// A tracked timer, periodic timer or microtask.
class _TrackedTask implements Timer {
  _TrackedTask(this._run, this.kind);

  final ExecutionRun _run;
  final D4rtTaskKind kind;
  Timer? timer;
  bool cancelled = false;
  bool _finished = false;

  void finish() {
    if (_finished) return;
    _finished = true;
    _run._taskFinished(this);
  }

  @override
  void cancel() {
    if (_finished) return;
    cancelled = true;
    timer?.cancel();
    finish();
  }

  @override
  bool get isActive => !_finished && (timer?.isActive ?? true);

  @override
  int get tick => timer?.tick ?? 0;
}
