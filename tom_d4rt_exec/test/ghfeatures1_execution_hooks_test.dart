// ghfeatures1 — per-execution hooks (GitHub #19): the tests of the
// specification's §16 (`_ai/quests/d4rt/ghfeatures1_execution_hooks.spec.md`).
//
// An execution with `hooks:` (or the runner's `executionHooks`) gets a
// `D4rtExecutionContext`: `onStart` may refuse it, `onImport` sees its
// libraries, every entry of interpreted code from native code passes
// `D4.enterInterpreted` (converted callbacks, stdlib callbacks, generated
// proxies) and with it `onEntry` / `onNativeEntry`; `revoke()` refuses new
// entries while accepted work finishes; tracking decides what `drained` waits
// for; a run may narrow the runner's permissions and capture its own output.
// Without hooks nothing changes. The same tests run in tom_d4rt_ast
// (test/runtime/ghfeatures1_execution_hooks_test.dart); the generator's
// emission is tested in tom_d4rt_generator
// (test/ghfeatures1_proxy_entry_test.dart).

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';
import 'package:tom_d4rt_ast/src/runtime/stdio_capture_stub.dart' as web;

const _host = 'package:host/host.dart';

/// A callback a script handed to the host, with the visitor of its run.
typedef _Held = ({InterpreterVisitor visitor, Object? callback});

/// A native abstract class a script implements; its proxy is written as the
/// generator emits it for an interpreter with `D4.enterInterpreted`.
abstract class Gh19Greeter {
  String greet(String name);
}

class _Gh19GreeterProxy extends Gh19Greeter {
  _Gh19GreeterProxy(this.onGreet);
  final String Function(String) onGreet;

  @override
  String greet(String name) => onGreet(name);
}

/// The host side of a test: the bridges a script calls and what they saw.
class _Host {
  final held = <_Held>[];
  final gates = <Completer<Object?>>[];
  late final D4rt d4rt;

  _Host() {
    d4rt = D4rt()
      ..registertopLevelFunction('hold', (v, a, n, t) {
        held.add((visitor: v, callback: a[0]));
        return null;
      }, _host)
      ..registertopLevelFunction(
        'ctxId',
        (v, a, n, t) => D4rtExecutionContext.of(v)?.id,
        _host,
      )
      ..registertopLevelFunction(
        'currentId',
        (v, a, n, t) => D4rtExecutionContext.current?.id,
        _host,
      )
      ..registertopLevelFunction('useCapability', (v, a, n, t) {
        D4rtExecutionContext.of(v)!.checkCapabilityUse('cap');
        return 'used';
      }, _host)
      ..registertopLevelFunction('gate', (v, a, n, t) {
        final gate = Completer<Object?>();
        gates.add(gate);
        return gate.future;
      }, _host)
      ..registertopLevelFunction(
        'zoneTag',
        (v, a, n, t) => Zone.current[#gh19Tag],
        _host,
      )
      ..registertopLevelFunction(
        'canFs',
        (v, a, n, t) =>
            d4rt.checkPermission({'type': 'filesystem', 'pathAgnostic': true}),
        _host,
      )
      ..registertopLevelFunction('greetWith', (v, a, n, t) {
        final greeter = D4.extractBridgedArg<Gh19Greeter>(a[0], 'g', v);
        return greeter.greet(a[1] as String);
      }, _host)
      ..registerBridgedClass(
        BridgedClass(
          nativeType: Gh19Greeter,
          name: 'Gh19Greeter',
          isAbstract: true,
          methods: {
            'greet': (visitor, target, positional, named, typeArgs) =>
                (target as Gh19Greeter).greet(positional[0] as String),
          },
        ),
        _host,
      );
    D4.registerInterfaceProxy(
      'Gh19Greeter',
      (visitor, instance) => _Gh19GreeterProxy(
        (name) =>
            D4.enterInterpreted(
                  visitor,
                  instance.klass.findInstanceMethod('greet')!.bind(instance),
                  [name],
                  {},
                  D4rtEntryKind.proxyMethod,
                  'Gh19Greeter.greet',
                )
                as String,
      ),
    );
  }

  /// Runs `<body>` as a script importing the host library.
  Object? run(String body, {D4rtExecutionHooks? hooks}) => d4rt.execute(
    source: "import '$_host';\nimport 'dart:async';\n$body",
    hooks: hooks,
  );

  /// Calls the [i]th held callback from native code.
  Object? call(int i, [List<Object?> args = const []]) =>
      D4.callInterpreterCallback(held[i].visitor, held[i].callback, args);

  void open(int i, [Object? value]) => gates[i].complete(value);
}

/// Waits for the event loop to run timers and microtasks.
Future<void> _settle([int ms = 0]) =>
    Future<void>.delayed(Duration(milliseconds: ms));

void main() {
  group('ghfeatures1: per-execution hooks', () {
    test('EH-1: onStart throws - the run is refused before any import, '
        'initializer or main runs [2026-11-15]', () async {
      final host = _Host();
      final imports = <Uri>[];
      late D4rtExecutionContext context;
      final hooks = D4rtExecutionHooks(
        onStart: (c) {
          context = c;
          throw StateError('not now');
        },
        onImport: (c, uri) => imports.add(uri),
      );
      expect(
        () => host.run(
          'final x = hold(1);\nmain() { hold(2); return x; }',
          hooks: hooks,
        ),
        throwsA(
          isA<D4rtExecutionRejectedException>().having(
            (e) => e.cause,
            'cause',
            isA<StateError>(),
          ),
        ),
      );
      expect(host.held, isEmpty);
      expect(imports, isEmpty);
      expect(context.isRevoked, isTrue);
      await context.drained.timeout(const Duration(seconds: 1));
      // A `library:` root loads its imports itself: the run starts first.
      expect(
        () => host.d4rt.execute(
          library: 'package:p/main.dart',
          sources: {
            'package:p/main.dart': "import '$_host';\nmain() => hold(3);",
          },
          hooks: hooks,
        ),
        throwsA(isA<D4rtExecutionRejectedException>()),
      );
      expect(host.held, isEmpty);
      expect(imports, isEmpty);
    });

    test('EH-2: onImport refuses a library - the run fails at that import '
        'and nothing of it ran [2026-11-15]', () {
      final host = _Host();
      final imports = <String>[];
      D4rtExecutionOutcome? outcome;
      expect(
        () => host.run(
          "import 'dart:math';\nmain() { hold(1); }",
          hooks: D4rtExecutionHooks(
            onImport: (c, uri) {
              imports.add('$uri');
              if ('$uri' == 'dart:math') throw StateError('refused $uri');
            },
            onEnd: (c, o) => outcome = o,
          ),
        ),
        throwsA(predicate((e) => '$e'.contains('refused dart:math'))),
      );
      expect(imports, contains('dart:math'));
      expect(host.held, isEmpty);
      expect(outcome?.isError, isTrue);
    });

    test('EH-3: D4rtExecutionContext.of(visitor) and .current inside a '
        'bridge answer the run [2026-11-15]', () {
      final host = _Host();
      int? id;
      final result = host.run(
        'main() => [ctxId(), currentId()];',
        hooks: D4rtExecutionHooks(onStart: (c) => id = c.id),
      );
      expect(result, [id, id]);
      expect(id, isNotNull);
      // Without hooks there is no context.
      expect(host.run('main() => [ctxId(), currentId()];'), [null, null]);
    });

    test('EH-4: onEntry sees a nested forEach callback with isNested; '
        'onNativeEntry does not [2026-11-15]', () {
      final host = _Host();
      final entries = <String>[];
      final native = <String>[];
      host.run(
        'main() { [1, 2].forEach((x) {}); }',
        hooks: D4rtExecutionHooks(
          onEntry: (c, e, proceed) {
            entries.add('${e.name}:${e.isNested}');
            return proceed();
          },
          onNativeEntry: (c, e, proceed) {
            native.add(e.name);
            return proceed();
          },
        ),
      );
      expect(entries, ['main:false', '<closure>:true', '<closure>:true']);
      expect(native, ['main']);
    });

    test('EH-5: a held callback runs before revoke(), is refused after it, '
        'and a hook may answer a substitute instead [2026-11-15]', () {
      final host = _Host();
      late D4rtExecutionContext context;
      host.run(
        "main() { hold(() => 'ran'); }",
        hooks: D4rtExecutionHooks(onStart: (c) => context = c),
      );
      expect(host.call(0), 'ran');
      context.revoke('bye');
      expect(
        () => host.call(0),
        throwsA(
          isA<D4rtExecutionRevokedException>().having(
            (e) => e.reason,
            'reason',
            'bye',
          ),
        ),
      );

      final substitute = _Host();
      substitute.run(
        "main() { hold(() => 'ran'); }",
        hooks: D4rtExecutionHooks(
          onStart: (c) => context = c,
          onEntry: (c, e, proceed) =>
              c.isRevoked && !e.isNested ? 'substitute' : proceed(),
        ),
      );
      context.revoke();
      expect(substitute.call(0), 'substitute');
    });

    test('EH-6: accepted async work finishes after revoke(); its capability '
        'use passes, new work\'s is refused [2026-11-15]', () async {
      final host = _Host();
      late D4rtExecutionContext context;
      final result =
          host.run(
                "main() async { hold(() => useCapability()); await gate(); "
                'return useCapability(); }',
                hooks: D4rtExecutionHooks(onStart: (c) => context = c),
              )
              as Future;
      // An async main runs its body from a microtask.
      await _settle();
      context.revoke('closing');
      expect(context.mayUseCapabilities, isFalse);
      expect(() => host.call(0), throwsA(isA<D4rtExecutionRevokedException>()));
      host.open(0);
      expect(await result, 'used');
      await context.drained.timeout(const Duration(seconds: 1));
    });

    test('EH-7: tracking - drain waits for timers, cancelNotStarted cancels, '
        'a periodic timer blocks drain [2026-11-15]', () async {
      // Entries only: drained once main returned.
      var host = _Host();
      late D4rtExecutionContext context;
      host.run(
        'main() { Timer(Duration(milliseconds: 20), () => hold(1)); }',
        hooks: D4rtExecutionHooks(onStart: (c) => context = c),
      );
      expect(context.isDrained, isTrue);

      // Timers tracked: drained once the timer ran.
      host = _Host();
      host.run(
        'main() { Timer(Duration(milliseconds: 20), () => hold(1)); }',
        hooks: D4rtExecutionHooks(
          onStart: (c) => context = c,
          tracking: D4rtTracking.entriesAndTimers,
        ),
      );
      expect(context.isDrained, isFalse);
      expect(context.pendingTasks, 1);
      await context.drained.timeout(const Duration(seconds: 1));
      expect(host.held, hasLength(1));

      // cancelNotStarted: revoke cancels the timer that has not fired.
      host = _Host();
      host.run(
        'main() { Timer(Duration(milliseconds: 50), () => hold(1)); }',
        hooks: D4rtExecutionHooks(
          onStart: (c) => context = c,
          tracking: D4rtTracking.everythingCancelOnRevoke,
        ),
      );
      context.revoke();
      await context.drained.timeout(const Duration(milliseconds: 20));
      await _settle(80);
      expect(host.held, isEmpty);

      // A periodic timer keeps the run undrained until it is cancelled.
      host = _Host();
      host.run(
        'main() { var n = 0; Timer.periodic(Duration(milliseconds: 5), '
        '(t) { n++; if (n == 3) { t.cancel(); hold(n); } }); }',
        hooks: D4rtExecutionHooks(
          onStart: (c) => context = c,
          tracking: D4rtTracking.entriesAndTimers,
        ),
      );
      expect(context.isDrained, isFalse);
      await context.drained.timeout(const Duration(seconds: 1));
      expect(host.held.single.callback, 3);
    });

    test('EH-8: a callback fired from another Zone runs in the execution '
        'Zone; without hooks, in the caller\'s Zone [2026-11-15]', () {
      final host = _Host();
      host.run(
        'main() { hold(() => zoneTag()); }',
        hooks: const D4rtExecutionHooks(zoneValues: {#gh19Tag: 'execution'}),
      );
      host.run('main() { hold(() => zoneTag()); }');
      Object? fromOther(int i) =>
          runZoned(() => host.call(i), zoneValues: {#gh19Tag: 'other'});
      expect(fromOther(0), 'execution');
      expect(fromOther(1), 'other');
    });

    test('EH-9: two runs interleaved on one runner keep their contexts; '
        'revoking one leaves the other [2026-11-15]', () {
      final host = _Host();
      final contexts = <D4rtExecutionContext>[];
      final hooks = D4rtExecutionHooks(onStart: contexts.add);
      host.run('main() { hold(() => ctxId()); }', hooks: hooks);
      host.run('main() { hold(() => ctxId()); }', hooks: hooks);
      expect(host.call(0), contexts[0].id);
      expect(host.call(1), contexts[1].id);
      expect(contexts[0].id, isNot(contexts[1].id));
      contexts[0].revoke();
      expect(() => host.call(0), throwsA(isA<D4rtExecutionRevokedException>()));
      expect(host.call(1), contexts[1].id);
    });

    test('EH-10: a generated interface proxy\'s methods pass onEntry with '
        'kind proxyMethod [2026-11-15]', () {
      final host = _Host();
      final entries = <String>[];
      final result = host.run(
        "class G extends Gh19Greeter { String greet(String n) => 'hi ' + n; }\n"
        "main() { hold(G()); return greetWith(G(), 'ann'); }",
        hooks: D4rtExecutionHooks(
          onEntry: (c, e, proceed) {
            entries.add('${e.kind.name} ${e.name} ${e.isNested}');
            return proceed();
          },
        ),
      );
      expect(result, 'hi ann');
      expect(entries, contains('proxyMethod Gh19Greeter.greet true'));
      // Called by the host after main: a native entry.
      entries.clear();
      final proxy = D4.extractBridgedArg<Gh19Greeter>(
        host.held.single.callback,
        'g',
        host.held.single.visitor,
      );
      expect(proxy.greet('bo'), 'hi bo');
      expect(entries, ['proxyMethod Gh19Greeter.greet false']);
    });

    test('EH-11: onError per run; onUncaughtError still receives the errors '
        'of runs without it [2026-11-15]', () async {
      final host = _Host();
      final perRun = <Object>[];
      final runnerWide = <Object>[];
      host.d4rt.onUncaughtError = (e, s) => runnerWide.add(e);
      const script = "main() { Timer(Duration.zero, () => throw 'boom'); }";
      host.run(
        script,
        hooks: D4rtExecutionHooks(onError: (c, e, s) => perRun.add(e)),
      );
      host.run(script, hooks: const D4rtExecutionHooks());
      await _settle(20);
      expect(perRun, ['boom']);
      expect(runnerWide, ['boom']);
    });

    test('EH-12: revokeAndDrain with and without timeout; merge '
        '[2026-11-15]', () async {
      final host = _Host();
      final contexts = <D4rtExecutionContext>[];
      final hooks = D4rtExecutionHooks(
        onStart: contexts.add,
        tracking: D4rtTracking.entriesAndTimers,
      );
      host.run(
        'main() { Timer(Duration(milliseconds: 20), () => hold(1)); }',
        hooks: hooks,
      );
      await contexts[0].revokeAndDrain('done');
      expect(host.held, hasLength(1));
      expect(contexts[0].isDrained, isTrue);

      host.run(
        'main() { Timer(Duration(seconds: 5), () => hold(2)); }',
        hooks: D4rtExecutionHooks(
          onStart: contexts.add,
          tracking: D4rtTracking.everything,
        ),
      );
      await expectLater(
        contexts[1].revokeAndDrain(
          'done',
          null,
          const Duration(milliseconds: 20),
        ),
        throwsA(isA<TimeoutException>()),
      );

      final log = <String>[];
      final merged = D4rtExecutionHooks.merge([
        D4rtExecutionHooks(
          onStart: (c) => log.add('a start'),
          onEntry: (c, e, proceed) {
            log.add('a in');
            final r = proceed();
            log.add('a out');
            return r;
          },
        ),
        D4rtExecutionHooks(
          onStart: (c) => log.add('b start'),
          onEntry: (c, e, proceed) {
            log.add('b in');
            final r = proceed();
            log.add('b out');
            return r;
          },
          tracking: D4rtTracking.entriesAndTimers,
        ),
      ]);
      expect(merged.tracking.timers, isTrue);
      host.run('main() => 1;', hooks: merged);
      expect(log, ['a start', 'b start', 'a in', 'b in', 'b out', 'a out']);
    });

    test('EH-13: revoke with grace - after it capability use is refused, '
        'tasks are cancelled and onRevoked gets D4rtGraceExpired '
        '[2026-11-15]', () async {
      final host = _Host();
      late D4rtExecutionContext context;
      final reasons = <Object?>[];
      final result =
          host.run(
                'main() async { Timer(Duration(milliseconds: 200), '
                '() => hold(1)); await gate(); return useCapability(); }',
                hooks: D4rtExecutionHooks(
                  onStart: (c) => context = c,
                  onRevoked: (c, reason) => reasons.add(reason),
                  tracking: D4rtTracking.entriesAndTimers,
                ),
              )
              as Future;
      await _settle();
      context.revoke('closing', const Duration(milliseconds: 20));
      expect(reasons, ['closing']);
      await _settle(50);
      expect(reasons, hasLength(2));
      expect(
        reasons[1],
        isA<D4rtGraceExpired>().having((g) => g.reason, 'reason', 'closing'),
      );
      expect(context.pendingTasks, 0);
      host.open(0);
      await expectLater(result, throwsA(isA<D4rtExecutionRevokedException>()));
      await _settle(220);
      expect(host.held, isEmpty);
    });

    test('EH-14: per-run permissions narrow the runner\'s and never widen '
        'them; revokePermission during a run [2026-11-15]', () async {
      final host = _Host();
      const io = "import 'dart:io';\nmain() => canFs();";
      // The runner grants nothing: a run's set cannot widen it.
      expect(
        () => host.run(
          io,
          hooks: D4rtExecutionHooks(permissions: {FilesystemPermission.any}),
        ),
        throwsA(predicate((e) => '$e'.contains('dart:io'))),
      );
      host.d4rt.grant(FilesystemPermission.any);
      expect(host.run(io), isTrue);
      // A narrower run cannot import dart:io while the runner could.
      expect(
        () => host.run(io, hooks: const D4rtExecutionHooks(permissions: {})),
        throwsA(predicate((e) => '$e'.contains('dart:io'))),
      );
      // Two runs with different sets.
      final contexts = <D4rtExecutionContext>[];
      host.run(
        'main() { hold(() => canFs()); }',
        hooks: D4rtExecutionHooks(onStart: contexts.add, permissions: {}),
      );
      host.run(
        'main() { hold(() => canFs()); }',
        hooks: D4rtExecutionHooks(
          onStart: contexts.add,
          permissions: {FilesystemPermission.any},
        ),
      );
      expect([host.call(0), host.call(1)], [false, true]);
      expect(contexts[0].permissions, isEmpty);
      expect(contexts[1].permissions, {FilesystemPermission.any});
      // revokePermission narrows the run while it runs.
      late D4rtExecutionContext context;
      final result =
          host.run(
                'main() async { final a = canFs(); await gate(); '
                'return [a, canFs()]; }',
                hooks: D4rtExecutionHooks(onStart: (c) => context = c),
              )
              as Future;
      await _settle();
      context.revokePermission(FilesystemPermission.any);
      host.open(0);
      expect(await result, [true, false]);
      expect(
        host.d4rt.checkPermission({'type': 'filesystem', 'pathAgnostic': true}),
        isTrue,
      );
    });

    test('EH-15: output - print and stdout of a run reach its sink and not a '
        'concurrent run\'s; echo; lines; the web stub [2026-11-15]', () async {
      final host = _Host()..d4rt.grant(FilesystemPermission.any);
      final a = <String>[];
      final b = <String>[];
      const script =
          "import 'dart:io';\n"
          "main(List<String> args) async { print(args[0] + '1'); await gate(); "
          "stdout.write(args[0] + '2'); }";
      final ra =
          host.d4rt.execute(
                source: "import '$_host';\n$script",
                positionalArgs: [
                  ['a'],
                ],
                hooks: D4rtExecutionHooks(output: D4rtOutput(out: a.add)),
              )
              as Future;
      final rb =
          host.d4rt.execute(
                source: "import '$_host';\n$script",
                positionalArgs: [
                  ['b'],
                ],
                hooks: D4rtExecutionHooks(output: D4rtOutput(out: b.add)),
              )
              as Future;
      await _settle();
      host
        ..open(1)
        ..open(0);
      await Future.wait([ra, rb]);
      expect(a, ['a1\n', 'a2']);
      expect(b, ['b1\n', 'b2']);

      // echo: the caller's print handler sees the line too.
      for (final echo in [false, true]) {
        final seen = <String>[];
        final out = <String>[];
        runZoned(
          () => host.run(
            "main() { print('x'); }",
            hooks: D4rtExecutionHooks(
              output: D4rtOutput(out: out.add, echo: echo),
            ),
          ),
          zoneSpecification: ZoneSpecification(
            print: (self, parent, zone, line) => seen.add(line),
          ),
        );
        expect(out, ['x\n']);
        expect(seen, echo ? ['x'] : isEmpty);
      }

      // lines: whole lines; the rest when the run has drained.
      final lines = <String>[];
      host.run(
        "import 'dart:io';\nmain() { stdout.write('ab'); stdout.write('c\\nd'); "
        "print('e'); stdout.write('tail'); }",
        hooks: D4rtExecutionHooks(
          output: D4rtOutput(out: lines.add, lines: true),
        ),
      );
      expect(lines, ['abc', 'de', 'tail']);

      // Without dart:io only print is captured: the Zone stays as it is.
      final zone = Zone.current;
      expect(
        web.forkStdioCapture(zone, out: (_) {}, err: (_) {}, echo: false),
        same(zone),
      );
    });

    test('EH-16: without hooks nothing changes - no context, no extra Zone, '
        'callbacks in the caller\'s Zone [2026-11-15]', () {
      final host = _Host();
      Zone? scriptZone;
      host.d4rt.registertopLevelFunction('zoneNow', (v, a, n, t) {
        scriptZone = Zone.current;
        return D4rtExecutionContext.of(v);
      }, _host);
      final outer = Zone.current;
      expect(host.run('main() { hold(() => 1); return zoneNow(); }'), isNull);
      // The script Zone is forked straight from the caller's.
      expect(scriptZone!.parent, same(outer));
      expect(host.held.single.visitor.executionContext, isNull);
      expect(host.call(0), 1);
    });
  });
}
