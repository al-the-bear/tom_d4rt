/// Per-execution hooks for embedders (GitHub #19, ghfeatures1).
///
/// An application that embeds the runtime owns resources and host
/// capabilities a script reaches through bridges. Per script run it can set up
/// state before any interpreted code runs and refuse the run, see every entry
/// of interpreted code from native code, revoke the run (new entries refused,
/// accepted work drains, new capability use refused) and learn when it has
/// drained - all per run, without replacing global bridge registrations.
///
/// Pass [D4rtExecutionHooks] as `hooks:` to an execute method. A run without
/// hooks behaves and costs as before: one null check per entry.
///
/// This file is mirrored between `tom_d4rt` (lib/src/) and `tom_d4rt_ast`
/// (lib/src/runtime/); keep the two identical.
library;

import 'dart:async';

import 'execution_run.dart';
import 'interpreter_visitor.dart';
import 'security/permissions.dart';

/// A hook around an entry; `proceed()` runs it. Return its result (or a
/// substitute without calling `proceed`), or throw to refuse the entry.
typedef D4rtEntryHook =
    Object? Function(
      D4rtExecutionContext context,
      D4rtEntry entry,
      Object? Function() proceed,
    );

/// What a run's hooks are. Given per call (`hooks:`); a runner may hold a
/// default (`executionHooks`).
class D4rtExecutionHooks {
  const D4rtExecutionHooks({
    this.onStart,
    this.onImport,
    this.onEntry,
    this.onNativeEntry,
    this.onTask,
    this.onError,
    this.onEnd,
    this.onRevoked,
    this.onDrained,
    this.tracking = D4rtTracking.entriesOnly,
    this.permissions,
    this.output,
    this.zoneSpecification,
    this.zoneValues,
  }) : _zoneSpecifications = const [];

  const D4rtExecutionHooks._merged({
    this.onStart,
    this.onImport,
    this.onEntry,
    this.onNativeEntry,
    this.onTask,
    this.onError,
    this.onEnd,
    this.onRevoked,
    this.onDrained,
    required this.tracking,
    this.permissions,
    this.output,
    this.zoneValues,
    required List<ZoneSpecification> zoneSpecifications,
  }) : zoneSpecification = null,
       _zoneSpecifications = zoneSpecifications;

  /// Hooks that only count: no callbacks, the given [tracking].
  const D4rtExecutionHooks.trackingOnly(D4rtTracking tracking)
    : this(tracking: tracking);

  /// Before imports, initializers and the entry function. Throw to refuse the
  /// run: the execute method then throws [D4rtExecutionRejectedException].
  final void Function(D4rtExecutionContext context)? onStart;

  /// Before a library is loaded for this run (the entry library's imports and
  /// theirs), once per library. Throw to refuse it; the run fails there.
  final void Function(D4rtExecutionContext context, Uri library)? onImport;

  /// Around EVERY entry, nested ones included ([D4rtEntry.isNested]).
  final D4rtEntryHook? onEntry;

  /// Around native entries only (never nested ones); runs inside [onEntry]
  /// when both are set.
  final D4rtEntryHook? onNativeEntry;

  /// A timer, periodic timer or microtask the run schedules, when [tracking]
  /// observes that kind.
  final void Function(D4rtExecutionContext context, D4rtTask task)? onTask;

  /// An uncaught error of this run. The runner-wide `onUncaughtError` stays
  /// the fallback for runs without it.
  final void Function(
    D4rtExecutionContext context,
    Object error,
    StackTrace stackTrace,
  )?
  onError;

  /// Once, when the run has ended: the entry function's result is available
  /// (an async entry function: its Future settled).
  final void Function(
    D4rtExecutionContext context,
    D4rtExecutionOutcome outcome,
  )?
  onEnd;

  /// When `revoke()` was called (new entries are refused by then); a second
  /// time with a [D4rtGraceExpired] reason when a revoke grace has elapsed.
  final void Function(D4rtExecutionContext context, Object? reason)? onRevoked;

  /// Each time the run becomes drained; the last time once it is revoked.
  final void Function(D4rtExecutionContext context)? onDrained;

  /// What drain counts and what revoke does with scheduled work.
  final D4rtTracking tracking;

  /// This run's permissions; null: the runner's. The runner's set is the
  /// ceiling: the effective set is this set intersected with the runner's.
  final Set<Permission>? permissions;

  /// Where this run's `print` and stdout / stderr go; null: as without hooks.
  final D4rtOutput? output;

  /// The run's execution Zone is forked from the caller's Zone with these.
  final ZoneSpecification? zoneSpecification;
  final Map<Object?, Object?>? zoneValues;

  final List<ZoneSpecification> _zoneSpecifications;

  /// The Zone specifications the execution Zone is forked through, outermost
  /// first (one, or several after [merge]).
  List<ZoneSpecification> get zoneSpecifications => [
    ..._zoneSpecifications,
    ?zoneSpecification,
  ];

  /// Combines hook sets, e.g. a tracking helper and the application's own.
  ///
  /// Callbacks run in list order; entry hooks nest, the first outermost.
  /// Tracking is the union of what each tracks (`cancelNotStarted` when any
  /// asks for it); permissions are intersected; the first [output] wins; Zone
  /// specifications are forked in list order; Zone values are merged, later
  /// ones winning.
  static D4rtExecutionHooks merge(List<D4rtExecutionHooks> hooks) {
    if (hooks.isEmpty) return const D4rtExecutionHooks();
    if (hooks.length == 1) return hooks.first;
    List<T> all<T>(T? Function(D4rtExecutionHooks h) pick) => [
      for (final h in hooks) ?pick(h),
    ];
    final starts = all((h) => h.onStart);
    final imports = all((h) => h.onImport);
    final entries = all((h) => h.onEntry);
    final nativeEntries = all((h) => h.onNativeEntry);
    final tasks = all((h) => h.onTask);
    final errors = all((h) => h.onError);
    final ends = all((h) => h.onEnd);
    final revokes = all((h) => h.onRevoked);
    final drains = all((h) => h.onDrained);
    D4rtEntryHook? nest(List<D4rtEntryHook> list) {
      if (list.isEmpty) return null;
      return (context, entry, proceed) {
        Object? Function() run = proceed;
        for (final hook in list.reversed) {
          final inner = run;
          run = () => hook(context, entry, inner);
        }
        return run();
      };
    }

    Set<Permission>? permissions;
    for (final h in hooks) {
      final set = h.permissions;
      if (set == null) continue;
      permissions = permissions == null
          ? {...set}
          : permissions.intersection(set);
    }
    final zoneValues = <Object?, Object?>{};
    for (final h in hooks) {
      zoneValues.addAll(h.zoneValues ?? const {});
    }
    return D4rtExecutionHooks._merged(
      onStart: starts.isEmpty
          ? null
          : (c) {
              for (final f in starts) {
                f(c);
              }
            },
      onImport: imports.isEmpty
          ? null
          : (c, u) {
              for (final f in imports) {
                f(c, u);
              }
            },
      onEntry: nest(entries),
      onNativeEntry: nest(nativeEntries),
      onTask: tasks.isEmpty
          ? null
          : (c, t) {
              for (final f in tasks) {
                f(c, t);
              }
            },
      onError: errors.isEmpty
          ? null
          : (c, e, s) {
              for (final f in errors) {
                f(c, e, s);
              }
            },
      onEnd: ends.isEmpty
          ? null
          : (c, o) {
              for (final f in ends) {
                f(c, o);
              }
            },
      onRevoked: revokes.isEmpty
          ? null
          : (c, r) {
              for (final f in revokes) {
                f(c, r);
              }
            },
      onDrained: drains.isEmpty
          ? null
          : (c) {
              for (final f in drains) {
                f(c);
              }
            },
      tracking: D4rtTracking.union([for (final h in hooks) h.tracking]),
      permissions: permissions,
      output: hooks
          .map((h) => h.output)
          .firstWhere((o) => o != null, orElse: () => null),
      zoneValues: zoneValues.isEmpty ? null : zoneValues,
      zoneSpecifications: [for (final h in hooks) ...h.zoneSpecifications],
    );
  }
}

/// What revoke does with scheduled work the run tracks.
enum D4rtRevokeAction {
  /// Tracked timers and microtasks still run.
  keep,

  /// Tracked timers and microtasks not started yet never run.
  cancelNotStarted,
}

/// What "drained" waits for, and what revoke does with scheduled work.
class D4rtTracking {
  const D4rtTracking({
    this.entries = true,
    this.timers = false,
    this.periodicTimers = false,
    this.microtasks = false,
    this.onRevoke = D4rtRevokeAction.keep,
  });

  /// Accepted entries until they (and their Futures) finish.
  final bool entries;

  /// One-shot Timers the run scheduled.
  final bool timers;

  /// Periodic Timers; one counts as pending until it is cancelled.
  final bool periodicTimers;

  /// scheduleMicrotask / Future microtasks.
  final bool microtasks;

  final D4rtRevokeAction onRevoke;

  /// Accepted entries only (the default). The specification called this
  /// preset `entries`; Dart cannot name a static like the [entries] field.
  static const entriesOnly = D4rtTracking();

  /// Entries, timers and periodic timers.
  static const entriesAndTimers = D4rtTracking(
    timers: true,
    periodicTimers: true,
  );

  /// Entries, timers, periodic timers and microtasks.
  static const everything = D4rtTracking(
    timers: true,
    periodicTimers: true,
    microtasks: true,
  );

  /// [everything], and revoke cancels what has not started.
  static const everythingCancelOnRevoke = D4rtTracking(
    timers: true,
    periodicTimers: true,
    microtasks: true,
    onRevoke: D4rtRevokeAction.cancelNotStarted,
  );

  /// Whether any task kind is tracked.
  bool get tracksTasks => timers || periodicTimers || microtasks;

  /// What all of [list] track together.
  static D4rtTracking union(List<D4rtTracking> list) => D4rtTracking(
    entries: list.any((t) => t.entries),
    timers: list.any((t) => t.timers),
    periodicTimers: list.any((t) => t.periodicTimers),
    microtasks: list.any((t) => t.microtasks),
    onRevoke: list.any((t) => t.onRevoke == D4rtRevokeAction.cancelNotStarted)
        ? D4rtRevokeAction.cancelNotStarted
        : D4rtRevokeAction.keep,
  );
}

/// Where a run's output goes.
class D4rtOutput {
  const D4rtOutput({
    this.out,
    this.err,
    this.captureStdio = true,
    this.echo = false,
    this.lines = false,
  });

  /// `print` and stdout writes, the text as written (`print` adds its
  /// newline).
  final void Function(String text)? out;

  /// stderr writes.
  final void Function(String text)? err;

  /// Also capture `dart:io` stdout / stderr, not only `print`. Where
  /// `dart:io` does not exist (the web) only `print` is captured.
  final bool captureStdio;

  /// Also write to the real console.
  final bool echo;

  /// Deliver whole lines (without their newline) instead of the text as
  /// written; what is left is flushed when the run has drained.
  final bool lines;
}

/// The run an execute call started, handed to every hook.
abstract interface class D4rtExecutionContext {
  /// Unique per process.
  int get id;

  /// The entry library's URI (or the entry name for a source run).
  String get entryUri;

  /// The run's execution Zone.
  Zone get zone;

  bool get isRevoked;
  Object? get revokeReason;

  /// Whether the entry function's result is available.
  bool get hasEnded;

  /// Accepted entries still running (async ones until their Future settles).
  int get pendingEntries;

  /// Tracked timers / microtasks not yet run (periodic timers until
  /// cancelled).
  int get pendingTasks;

  /// Nothing the tracking policy counts is pending.
  bool get isDrained;

  /// Completes the next time the run is drained; for good once it is revoked
  /// (immediately when it is revoked and drained already).
  Future<void> get drained;

  /// Revokes the run (idempotent): new native entries are refused, accepted
  /// work continues. With [grace], once it has elapsed capability use is
  /// refused for everything of the run and tracked tasks not started are
  /// cancelled.
  void revoke([Object? reason, Duration? grace]);

  /// [revoke], then waits for the final drain; with [timeout], fails with a
  /// [TimeoutException] when the run has not drained by then.
  Future<void> revokeAndDrain([
    Object? reason,
    Duration? grace,
    Duration? timeout,
  ]);

  /// The permissions effective for this run.
  Set<Permission> get permissions;

  /// Narrows this run's permissions while it runs.
  void revokePermission(Permission permission);

  /// The embedder's per-run state.
  Map<Object, Object?> get data;

  /// Whether code running now may use host capabilities of this run: the run
  /// is not revoked, or the code runs on behalf of an entry accepted before
  /// revocation (and no revoke grace has elapsed).
  bool get mayUseCapabilities;

  /// Throws [D4rtExecutionRevokedException] when [mayUseCapabilities] is
  /// false. For capability bridges.
  void checkCapabilityUse([String? capability]);

  /// The run a bridge call belongs to: the run of the visitor it was given.
  static D4rtExecutionContext? of(InterpreterVisitor visitor) =>
      visitor.executionContext;

  /// The run whose Zone the current code runs in.
  static D4rtExecutionContext? get current => currentExecutionRun();
}

/// How native code entered interpreted code.
enum D4rtEntryKind {
  /// A callback: a converted interpreted function, a stdlib callback, a
  /// bridge calling a script closure, the entry function itself.
  callback,

  /// A method of a generated interface proxy.
  proxyMethod,

  /// A receiver proxy calling the script's override of a native member.
  receiverSuperCall,
}

/// One entry of interpreted code from native code.
class D4rtEntry {
  D4rtEntry.internal({
    required this.kind,
    required this.name,
    required this.isNested,
    required this.acceptedBeforeRevocation,
    required Object run,
  }) : runToken = run;

  final D4rtEntryKind kind;

  /// The callable's name, or `Class.member`.
  final String name;

  /// Made while interpreted code of the same run was on the stack.
  final bool isNested;

  /// The callable is async / returned a Future (known once it returned).
  bool get isAsync => _isAsync;
  bool _isAsync = false;

  /// The run was not revoked when the entry was accepted (for a nested entry
  /// or a continuation of accepted work: what the work it belongs to was).
  final bool acceptedBeforeRevocation;

  /// The run this entry belongs to (runtime internal).
  final Object runToken;

  /// Marks the entry async (runtime internal).
  void markAsync() => _isAsync = true;

  /// The accepted native entry the current code runs on behalf of.
  static D4rtEntry? get current => currentAcceptedEntry();

  @override
  String toString() =>
      'D4rtEntry(${kind.name} $name${isNested ? ', nested' : ''})';
}

/// The kind of a scheduled task.
enum D4rtTaskKind { timer, periodicTimer, microtask }

/// A timer, periodic timer or microtask a run scheduled.
class D4rtTask {
  const D4rtTask(this.kind, [this.duration]);
  final D4rtTaskKind kind;
  final Duration? duration;

  @override
  String toString() =>
      'D4rtTask(${kind.name}${duration == null ? '' : ' $duration'})';
}

/// How a run ended.
class D4rtExecutionOutcome {
  const D4rtExecutionOutcome.value(this.value)
    : error = null,
      stackTrace = null;
  const D4rtExecutionOutcome.error(Object this.error, this.stackTrace)
    : value = null;

  /// The entry function's result (single-level unwrapped).
  final Object? value;
  final Object? error;
  final StackTrace? stackTrace;
  bool get isError => error != null;
}

/// The reason a second `onRevoked` carries when a revoke grace has elapsed.
class D4rtGraceExpired {
  const D4rtGraceExpired(this.reason);

  /// The reason given to `revoke`.
  final Object? reason;

  @override
  String toString() => 'D4rtGraceExpired($reason)';
}

/// The run was refused by `onStart`; no script code ran.
class D4rtExecutionRejectedException implements Exception {
  D4rtExecutionRejectedException(this.cause, [this.causeStackTrace]);

  /// What `onStart` threw.
  final Object cause;
  final StackTrace? causeStackTrace;

  @override
  String toString() => 'D4rtExecutionRejectedException: $cause';
}

/// An entry or a capability use was refused because the run is revoked.
class D4rtExecutionRevokedException implements Exception {
  D4rtExecutionRevokedException(this.reason, {this.entry, this.capability});

  /// The reason given to `revoke`.
  final Object? reason;

  /// The refused entry's name, when an entry was refused.
  final String? entry;

  /// The capability named to `checkCapabilityUse`, when one was.
  final String? capability;

  @override
  String toString() {
    final what = entry != null
        ? 'entry $entry'
        : capability != null
        ? 'capability $capability'
        : 'use';
    return 'D4rtExecutionRevokedException: $what refused, the run is revoked'
        '${reason == null ? '' : ' ($reason)'}';
  }
}
