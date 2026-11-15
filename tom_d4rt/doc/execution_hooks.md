# Embedding: per-execution hooks

An application that runs scripts usually needs to know, per execution, when
script code runs: to keep per-run state, to refuse a run, to stop callbacks
that native code still holds once the application has moved on, and to let a
run's cleanup finish while nothing new starts. `D4rtExecutionHooks` gives each
execution a `D4rtExecutionContext` for this.

The same API exists in `tom_d4rt_ast` (`D4rtRunner.executeBundle(bundle,
hooks: ...)`; its [execution_hooks.md](../../tom_d4rt_ast/doc/execution_hooks.md)).

## Contents

- [Turning hooks on](#turning-hooks-on)
- [The lifecycle](#the-lifecycle)
- [Entries](#entries)
- [A complete example](#a-complete-example)
- [Refusing an entry: an exception or a substitute value](#refusing-an-entry-an-exception-or-a-substitute-value)
- [Revocation, accepted work and capabilities](#revocation-accepted-work-and-capabilities)
- [Tracking and drain](#tracking-and-drain)
- [Permissions per run](#permissions-per-run)
- [Output per run](#output-per-run)
- [Zones](#zones)
- [Several executions](#several-executions)
- [What stays the embedder's job](#what-stays-the-embedders-job)
- [Cost](#cost)

## Turning hooks on

Pass `hooks:` to an execute method, or set `D4rt.executionHooks` for every
execution that does not pass its own:

```dart
final d4rt = D4rt();
d4rt.execute(source: script, hooks: D4rtExecutionHooks(onStart: (c) {}));

d4rt.executionHooks = D4rtExecutionHooks(onError: (c, e, s) => log(e));
```

`execute`, `continuedExecute`, `executeProgram` and their async variants take
`hooks:`. An execution without hooks runs exactly as before: no context, no
extra Zone, callbacks in the caller's Zone.

## The lifecycle

1. **`onStart(context)`** — once the bridges are finalized, declarations are
   collected and the visitor exists, before any import is processed and before
   any initializer or `main` runs. (A `library:` root is loaded by the module
   loader, which processes its imports; for it `onStart` runs before that
   load.) Throwing refuses the run: the execute call throws
   `D4rtExecutionRejectedException` carrying the cause, nothing of the script
   has run, there is no `onEnd`, and the context is drained and final.
2. **`onImport(context, uri)`** — once per library the run loads (`dart:`,
   `package:`, transitive ones too), before it is loaded. Throwing refuses the
   import: the run fails there.
3. **The entry function** (`main` or `name:`) is the run's first accepted
   entry.
4. **`onEnd(context, outcome)`** — once, when the entry function's result is
   known (an async entry function: when its Future settles), with a
   `D4rtExecutionOutcome` (`value`, or `error` and `stackTrace`). A run that
   fails before its entry function (an import, a declaration) ends with that
   error.
5. **Entries after the end** — callbacks the host still holds — are allowed and
   counted.
6. **`onDrained(context)`** — each time nothing tracked is pending
   (`context.drained` completes then; a later entry renews it).
7. **`revoke(reason)`** — `onRevoked`, new entries are refused, accepted work
   finishes; the next `onDrained` is the last one, and `drained` completes for
   good.

`onError(context, error, stackTrace)` receives the run's uncaught errors (a
callback that throws with nobody to catch it). Runs without it fall back to the
runner-wide `onUncaughtError`.

## Entries

Every call of interpreted code from native code is an **entry** and passes
`D4.enterInterpreted`:

- `D4.callInterpreterCallback` — converted callbacks (`D4.coerceCallableToFunction`),
  the generated bridges and relaxers;
- the standard library's callbacks (`forEach`, `Timer`, `Future.then`,
  `Stream.listen` …);
- generated proxies (kind `proxyMethod`, name `Class.member`), when generated
  by a `tom_d4rt_generator` for an interpreter that has `D4.enterInterpreted`;
- the entry function itself.

Each entry is a `D4rtEntry`: `kind` (`callback`, `proxyMethod`,
`receiverSuperCall`), `name`, `isNested` (interpreted code of the same run was
on the stack — a `forEach` callback inside `main`), `isAsync` (known once it
returned), `acceptedBeforeRevocation`.

- **`onEntry(context, entry, proceed)`** sees every entry, nested ones
  included. `proceed()` runs it; the hook returns what it should answer.
- **`onNativeEntry(context, entry, proceed)`** sees only entries from native
  code (`!isNested`), inside `onEntry`.

## A complete example

```dart
import 'package:tom_d4rt/d4rt.dart';

/// A capability the host lends to a run: a camera session.
class CameraBridge {
  final sessions = <D4rtExecutionContext, Object>{};

  Object acquire(InterpreterVisitor visitor) {
    final context = D4rtExecutionContext.of(visitor)!;
    // A run that was revoked may not start something new …
    context.checkCapabilityUse('camera.acquire');
    return sessions[context] = Object();
  }

  void release(InterpreterVisitor visitor) {
    final context = D4rtExecutionContext.of(visitor)!;
    // … but cleanup of work accepted before the revocation may finish.
    if (!context.mayUseCapabilities) return;
    sessions.remove(context);
  }
}

Future<void> runScreen(D4rt d4rt, String script, User user) async {
  late D4rtExecutionContext screen;
  final hooks = D4rtExecutionHooks(
    // Per-run state, and refusing a run.
    onStart: (context) {
      if (!user.mayRunScripts) throw StateError('scripts disabled for $user');
      context.data['user'] = user;
      screen = context;
    },
    // Tracking entries: count native entries per run.
    onNativeEntry: (context, entry, proceed) {
      context.data['entries'] = ((context.data['entries'] as int?) ?? 0) + 1;
      return proceed();
    },
    onError: (context, error, stackTrace) => log('script error', error),
    tracking: D4rtTracking.entriesAndTimers,
  );

  d4rt.execute(source: script, hooks: hooks);

  // … the user leaves the screen: nothing new may start, what runs may
  // finish; wait at most two seconds for it.
  await screen.revokeAndDrain(
    'screen closed',
    const Duration(seconds: 1),
    const Duration(seconds: 2),
  );
}
```

`revokeAndDrain(reason, grace, timeout)` is `revoke(reason, grace)` followed
by `drained` (with `timeout`, a `TimeoutException` when it is not drained in
time).

## Refusing an entry: an exception or a substitute value

After `revoke()` a new native entry is refused **before any of its interpreted
code runs**. By default the native caller receives a
`D4rtExecutionRevokedException` — and the native caller is often code the
embedder does not own: a Flutter `CustomPainter.paint`, a `Timer` callback, a
platform channel handler. Two ways to choose:

**The exception** (the default) — right when the caller handles errors, or
when an error report is what you want:

```dart
try {
  heldCallback();
} on D4rtExecutionRevokedException catch (e) {
  log('ignored a callback of a closed run: ${e.reason}');
}
```

**A substitute value** — for a caller that cannot take an exception. An
`onEntry` (or `onNativeEntry`) hook answers without calling `proceed()`; the
refusal happens inside `proceed()`, so the hook decides first:

```dart
final hooks = D4rtExecutionHooks(
  onNativeEntry: (context, entry, proceed) {
    if (context.isRevoked && entry.name == 'MyPainter.shouldRepaint') {
      return false; // never repaint a revoked screen
    }
    return proceed();
  },
);
```

A hook may also refuse by throwing whatever suits its caller.

## Revocation, accepted work and capabilities

`revoke(reason)` marks the context revoked and calls `onRevoked`. From then on:

- a new native entry is refused;
- a nested entry of accepted work still runs (a `forEach` inside cleanup);
- accepted work continues: the entry that was running, its awaits'
  continuations, and — per the tracking policy — the timers and microtasks it
  scheduled;
- each accepted native entry runs in a child Zone that carries it
  (`D4rtEntry.current`); its continuations and the tasks it schedules inherit
  that Zone, so the runtime knows on whose behalf code runs.

The runtime cannot know which bridge call uses a host capability, so the
embedder's capability bridges ask:

- `context.mayUseCapabilities` — true when the run is not revoked, or when the
  code runs on behalf of an entry accepted before the revocation
  (`D4rtEntry.current?.acceptedBeforeRevocation`);
- `context.checkCapabilityUse([name])` — throws
  `D4rtExecutionRevokedException` when not.

**Grace.** `revoke(reason, grace)`: without `grace`, accepted work keeps
capability use until it finishes. With `grace`, once it has elapsed
`mayUseCapabilities` is false for everything of the run, tracked tasks not yet
started are cancelled, and `onRevoked` is called a second time with a
`D4rtGraceExpired` reason. Code already running keeps running — the interpreter
does not kill code (see below).

## Tracking and drain

What "drained" waits for, and what `revoke()` does with scheduled work:

| Preset | Counts |
|--------|--------|
| `D4rtTracking.entriesOnly` (default) | accepted entries until they (and their Futures) finish |
| `D4rtTracking.entriesAndTimers` | and one-shot and periodic `Timer`s the run scheduled |
| `D4rtTracking.everything` | and microtasks |
| `D4rtTracking.everythingCancelOnRevoke` | and `revoke()` cancels what has not started |

Or build one: `D4rtTracking(entries:, timers:, periodicTimers:, microtasks:,
onRevoke: D4rtRevokeAction.keep | cancelNotStarted)`. A periodic timer keeps a
run undrained until it is cancelled. `onTask(context, task)` sees each tracked
timer or microtask as it is scheduled (`D4rtTask.kind`, `duration`).
`context.pendingEntries` / `pendingTasks` / `isDrained` answer the state now.

Helpers:

- `D4rtExecutionHooks.trackingOnly(tracking)` — no callbacks, just counting;
- `D4rtExecutionHooks.merge([a, b])` — combine sets: callbacks in order, entry
  hooks nested (the first outermost), tracking united, permission sets
  intersected, the first output, Zone specifications in order.

## Permissions per run

`grant` / `revoke` on the `D4rt` instance decide for every run. A run's
`permissions:` narrows that: the effective set is `permissions ∩ granted` —
the instance's set is the ceiling, a run can only be narrower, granting more
needs `grant`. The import of `dart:io` / `dart:isolate` and the bridges'
operation checks (`D4rt.checkPermission`, called from the run's Zone) ask the
run's effective set. `context.permissions` answers it, and
`context.revokePermission(p)` narrows it while the run runs: its next
sensitive import or operation is refused; libraries already imported keep
their bridges.

```dart
d4rt.grant(FilesystemPermission.any);
d4rt.execute(
  source: untrustedScript,
  hooks: const D4rtExecutionHooks(permissions: {}), // no dart:io for this one
);
```

## Output per run

```dart
final out = StringBuffer();
d4rt.execute(
  source: script,
  hooks: D4rtExecutionHooks(
    output: D4rtOutput(out: out.write, err: stderrLog.write),
  ),
);
```

`D4rtOutput(out:, err:, captureStdio: true, echo: false, lines: false)`:

- `print` is caught in the execution Zone's print handler: `out` receives the
  text as written (`print('a')` gives `'a\n'`);
- with `captureStdio`, `dart:io`'s `stdout` / `stderr` write to `out` / `err`
  as well (`IOOverrides` in the execution Zone; `stdout.write('a')` gives
  `'a'`, bytes from `stdout.add` are decoded as UTF-8);
- `echo: true` also writes to the real console (the caller's print handler and
  the process's streams);
- `lines: true` delivers whole lines, without their newline; what is left is
  delivered when the run has drained.

On the web there is no `dart:io`: only `print` is captured.

Concurrent runs each reach their own sinks.

## Zones

The execution Zone is forked from the caller's Zone with `zoneSpecification`
(or several, `D4rtExecutionHooks.merge`) and `zoneValues`; the runtime's
tracking and output Zones and the script Zone sit inside it. An accepted
native entry runs in a child Zone of the run, so **a callback fired from
another Zone runs in the run's Zone** (`Zone.current[key]` answers the run's
`zoneValues`). A run without hooks behaves as before: callbacks run in the
caller's Zone.

## Several executions

The context is found from the visitor a callback or proxy captured
(`D4rtExecutionContext.of(visitor)`), or from the current Zone
(`D4rtExecutionContext.current`, `D4rtEntry.current`). Two runs on one `D4rt`
— run 1's callbacks alive while run 2 starts — keep their own contexts;
revoking one leaves the other. `D4rt.visitor` is the most recent run's.

## What stays the embedder's job

- **Hard stops.** The interpreter does not kill running code: a revoked run's
  code that is running keeps running, and a loop that never awaits never
  returns. Run untrusted scripts in an isolate (e.g. `tom_d4rt_host`) when a
  hard stop is needed.
- **Which bridge is a capability.** The runtime offers
  `mayUseCapabilities` / `checkCapabilityUse`; the bridges that lend host
  resources call them.
- **Native objects the script handed out.** A widget, a stream subscription
  or a listener a native framework holds stays held; revocation only refuses
  the interpreted code it would call.

## Cost

Without hooks: one null check per entry and per run, no extra Zone, no
counting. With hooks: a child Zone per accepted native entry, one closure call
per hooked entry, and the bookkeeping of the tracked kinds.
