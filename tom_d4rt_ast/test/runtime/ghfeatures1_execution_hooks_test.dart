// ghfeatures1/AST — per-execution hooks (GitHub #19) in the analyzer-free
// tree: the tests of the specification's §16
// (`_ai/quests/d4rt/ghfeatures1_execution_hooks.spec.md`).
//
// The mirror of `tom_d4rt/test/ghfeatures1_execution_hooks_test.dart`, which
// runs source. Here each script is a hand-built bundle; where the source test
// counts in the script, the host counts (EH-7), and where it passes an
// argument to `main`, the two runs differ in a literal (EH-15). An execution
// with `hooks:` (or the runner's `executionHooks`) gets a
// `D4rtExecutionContext`: `onStart` may refuse it, `onImport` sees its
// libraries, every entry of interpreted code from native code passes
// `D4.enterInterpreted` and with it `onEntry` / `onNativeEntry`; `revoke()`
// refuses new entries while accepted work finishes; tracking decides what
// `drained` waits for; a run may narrow the runner's permissions and capture
// its own output. Without hooks nothing changes.

@TestOn('vm')
library;

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdio_capture_stub.dart' as web;

const _entry = 'package:p/main.dart';
const _host = 'package:host/host.dart';

// ---------------------------------------------------------------------------
// AST builders
// ---------------------------------------------------------------------------

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SNamedType _type(String name) =>
    SNamedType(offset: 0, length: 0, name: _id(name));

SFormalParameterList _params([List<(String, String)> params = const []]) =>
    SFormalParameterList(
      offset: 0,
      length: 0,
      parameters: [
        for (final (type, name) in params)
          SRegularFormalParameter(
            offset: 0,
            length: 0,
            name: _id(name),
            type: _type(type),
          ),
      ],
    );

/// `<target>.<name>(<args>)`, or `<name>(<args>)` without a target.
SMethodInvocation _call(
  SExpression? target,
  String name, [
  List<SArgument> args = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(name),
  argumentList: SArgumentList(offset: 0, length: 0, arguments: args),
);

SNamedArgument _named(String name, SExpression value) => SNamedArgument(
  offset: 0,
  length: 0,
  name: _id(name),
  argumentExpression: value,
);

/// `Duration(milliseconds: <ms>)`
SMethodInvocation _ms(int ms) =>
    _call(null, 'Duration', [_named('milliseconds', _int(ms))]);

/// `(<params>) => <body>`
SFunctionExpression _arrow(
  SExpression body, [
  List<(String, String)> params = const [],
]) => SFunctionExpression(
  offset: 0,
  length: 0,
  parameters: _params(params),
  body: SExpressionFunctionBody(offset: 0, length: 0, expression: body),
);

/// `(<params>) { <statements> }`
SFunctionExpression _block(
  List<SStatement> statements, [
  List<(String, String)> params = const [],
]) => SFunctionExpression(
  offset: 0,
  length: 0,
  parameters: _params(params),
  body: SBlockFunctionBody(
    offset: 0,
    length: 0,
    block: SBlock(offset: 0, length: 0, statements: statements),
  ),
);

SListLiteral _list(List<SExpression> elements) =>
    SListLiteral(offset: 0, length: 0, elements: elements);

SAwaitExpression _await(SExpression e) =>
    SAwaitExpression(offset: 0, length: 0, expression: e);

SBinaryExpression _plus(SExpression left, SExpression right) =>
    SBinaryExpression(
      offset: 0,
      length: 0,
      leftOperand: left,
      operator: '+',
      rightOperand: right,
    );

SExpressionStatement _do(SExpression e) =>
    SExpressionStatement(offset: 0, length: 0, expression: e);

SReturnStatement _return(SExpression e) =>
    SReturnStatement(offset: 0, length: 0, expression: e);

SVariableDeclarationList _final(String name, SExpression initializer) =>
    SVariableDeclarationList(
      offset: 0,
      length: 0,
      isFinal: true,
      variables: [
        SVariableDeclaration(
          offset: 0,
          length: 0,
          name: _id(name),
          initializer: initializer,
        ),
      ],
    );

/// `final <name> = <initializer>;`
SVariableDeclarationStatement _var(String name, SExpression initializer) =>
    SVariableDeclarationStatement(
      offset: 0,
      length: 0,
      variables: _final(name, initializer),
    );

SImportDirective _import(String uri) =>
    SImportDirective(offset: 0, length: 0, uri: _str(uri));

/// `main() { <statements> }`, `async` with [isAsync].
SFunctionDeclaration _main(
  List<SStatement> statements, {
  bool isAsync = false,
}) => SFunctionDeclaration(
  offset: 0,
  length: 0,
  name: _id('main'),
  functionExpression: SFunctionExpression(
    offset: 0,
    length: 0,
    parameters: _params(),
    body: SBlockFunctionBody(
      offset: 0,
      length: 0,
      isAsync: isAsync,
      block: SBlock(offset: 0, length: 0, statements: statements),
    ),
  ),
);

/// `class G extends Gh19Greeter { String greet(String n) => 'hi ' + n; }`
final _greeterClass = SClassDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id('G')),
  extendsClause: SExtendsClause(
    offset: 0,
    length: 0,
    superclass: _type('Gh19Greeter'),
  ),
  body: SBlockClassBody(
    offset: 0,
    length: 0,
    members: [
      SMethodDeclaration(
        offset: 0,
        length: 0,
        name: _id('greet'),
        returnType: _type('String'),
        parameters: _params([('String', 'n')]),
        body: SExpressionFunctionBody(
          offset: 0,
          length: 0,
          expression: _plus(_str('hi '), _id('n')),
        ),
      ),
    ],
  ),
);

/// A bundle whose entry imports the host library, `dart:async` and
/// [imports], and declares [declarations] and [main].
AstBundle _bundle(
  SFunctionDeclaration main, {
  List<String> imports = const [],
  List<SCompilationUnitMember> declarations = const [],
}) => AstBundle(
  entryPointUri: _entry,
  modules: {
    _entry: SCompilationUnit(
      offset: 0,
      length: 0,
      directives: [
        _import(_host),
        _import('dart:async'),
        for (final uri in imports) _import(uri),
      ],
      declarations: [...declarations, main],
    ),
  },
);

// ---------------------------------------------------------------------------
// Host
// ---------------------------------------------------------------------------

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
  var ticks = 0;
  late final D4rtRunner runner;

  _Host() {
    runner = D4rtRunner()
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
        (v, a, n, t) => v.moduleContext.checkPermission({
          'type': 'filesystem',
          'pathAgnostic': true,
        }),
        _host,
      )
      ..registertopLevelFunction('tick', (v, a, n, t) {
        // The host counts the ticks of a periodic timer and cancels it at 3.
        final timer = D4.unwrapInterpreterValue(a[0]) as Timer;
        if (++ticks == 3) {
          timer.cancel();
          held.add((visitor: v, callback: ticks));
        }
        return null;
      }, _host)
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

  /// Runs [main] in a bundle importing the host library.
  Object? run(
    SFunctionDeclaration main, {
    D4rtExecutionHooks? hooks,
    List<String> imports = const [],
    List<SCompilationUnitMember> declarations = const [],
  }) => runner.executeBundle(
    _bundle(main, imports: imports, declarations: declarations),
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

/// `main() { hold(() => <body>); }`
SFunctionDeclaration _holding(SExpression body) => _main([
  _do(_call(null, 'hold', [_arrow(body)])),
]);

/// `main() { Timer(Duration(milliseconds: <ms>), () => hold(<n>)); }`
SFunctionDeclaration _timerHolding(int ms, int n) => _main([
  _do(
    _call(null, 'Timer', [
      _ms(ms),
      _arrow(_call(null, 'hold', [_int(n)])),
    ]),
  ),
]);

void main() {
  group('ghfeatures1/AST: per-execution hooks', () {
    test('EH-1: onStart throws - the run is refused before any import, '
        'initializer or main runs [2026-11-15]', () async {
      final host = _Host();
      final imports = <Uri>[];
      late D4rtExecutionContext context;
      expect(
        () => host.run(
          _main([
            _do(_call(null, 'hold', [_int(2)])),
            _return(_id('x')),
          ]),
          declarations: [
            STopLevelVariableDeclaration(
              offset: 0,
              length: 0,
              variables: _final('x', _call(null, 'hold', [_int(1)])),
            ),
          ],
          hooks: D4rtExecutionHooks(
            onStart: (c) {
              context = c;
              throw StateError('not now');
            },
            onImport: (c, uri) => imports.add(uri),
          ),
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
    });

    test('EH-2: onImport refuses a library - the run fails at that import '
        'and nothing of it ran [2026-11-15]', () {
      final host = _Host();
      final imports = <String>[];
      D4rtExecutionOutcome? outcome;
      expect(
        () => host.run(
          _main([
            _do(_call(null, 'hold', [_int(1)])),
          ]),
          imports: ['dart:math'],
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
      final main = _main([
        _return(_list([_call(null, 'ctxId'), _call(null, 'currentId')])),
      ]);
      final result = host.run(
        main,
        hooks: D4rtExecutionHooks(onStart: (c) => id = c.id),
      );
      expect(result, [id, id]);
      expect(id, isNotNull);
      expect(host.run(main), [null, null]);
    });

    test('EH-4: onEntry sees a nested forEach callback with isNested; '
        'onNativeEntry does not [2026-11-15]', () {
      final host = _Host();
      final entries = <String>[];
      final native = <String>[];
      host.run(
        _main([
          _do(
            _call(_list([_int(1), _int(2)]), 'forEach', [
              _block(const [], [('int', 'x')]),
            ]),
          ),
        ]),
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
        _holding(_str('ran')),
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
        _holding(_str('ran')),
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
                _main([
                  _do(
                    _call(null, 'hold', [_arrow(_call(null, 'useCapability'))]),
                  ),
                  _do(_await(_call(null, 'gate'))),
                  _return(_call(null, 'useCapability')),
                ], isAsync: true),
                hooks: D4rtExecutionHooks(onStart: (c) => context = c),
              )
              as Future;
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
      var host = _Host();
      late D4rtExecutionContext context;
      host.run(
        _timerHolding(20, 1),
        hooks: D4rtExecutionHooks(onStart: (c) => context = c),
      );
      expect(context.isDrained, isTrue);

      host = _Host();
      host.run(
        _timerHolding(20, 1),
        hooks: D4rtExecutionHooks(
          onStart: (c) => context = c,
          tracking: D4rtTracking.entriesAndTimers,
        ),
      );
      expect(context.isDrained, isFalse);
      expect(context.pendingTasks, 1);
      await context.drained.timeout(const Duration(seconds: 1));
      expect(host.held, hasLength(1));

      host = _Host();
      host.run(
        _timerHolding(50, 1),
        hooks: D4rtExecutionHooks(
          onStart: (c) => context = c,
          tracking: D4rtTracking.everythingCancelOnRevoke,
        ),
      );
      context.revoke();
      await context.drained.timeout(const Duration(milliseconds: 20));
      await _settle(80);
      expect(host.held, isEmpty);

      host = _Host();
      host.run(
        _main([
          _do(
            _call(_id('Timer'), 'periodic', [
              _ms(5),
              _arrow(_call(null, 'tick', [_id('t')]), [('Timer', 't')]),
            ]),
          ),
        ]),
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
      final main = _holding(_call(null, 'zoneTag'));
      host.run(
        main,
        hooks: const D4rtExecutionHooks(zoneValues: {#gh19Tag: 'execution'}),
      );
      host.run(main);
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
      final main = _holding(_call(null, 'ctxId'));
      host.run(main, hooks: hooks);
      host.run(main, hooks: hooks);
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
        _main([
          _do(_call(null, 'hold', [_call(null, 'G')])),
          _return(_call(null, 'greetWith', [_call(null, 'G'), _str('ann')])),
        ]),
        declarations: [_greeterClass],
        hooks: D4rtExecutionHooks(
          onEntry: (c, e, proceed) {
            entries.add('${e.kind.name} ${e.name} ${e.isNested}');
            return proceed();
          },
        ),
      );
      expect(result, 'hi ann');
      expect(entries, contains('proxyMethod Gh19Greeter.greet true'));
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
      host.runner.onUncaughtError = (e, s) => runnerWide.add(e);
      final main = _main([
        _do(
          _call(null, 'Timer', [
            _ms(0),
            _arrow(
              SThrowExpression(offset: 0, length: 0, expression: _str('boom')),
            ),
          ]),
        ),
      ]);
      host.run(
        main,
        hooks: D4rtExecutionHooks(onError: (c, e, s) => perRun.add(e)),
      );
      host.run(main, hooks: const D4rtExecutionHooks());
      await _settle(20);
      expect(perRun, ['boom']);
      expect(runnerWide, ['boom']);
    });

    test('EH-12: revokeAndDrain with and without timeout; merge '
        '[2026-11-15]', () async {
      final host = _Host();
      final contexts = <D4rtExecutionContext>[];
      host.run(
        _timerHolding(20, 1),
        hooks: D4rtExecutionHooks(
          onStart: contexts.add,
          tracking: D4rtTracking.entriesAndTimers,
        ),
      );
      await contexts[0].revokeAndDrain('done');
      expect(host.held, hasLength(1));
      expect(contexts[0].isDrained, isTrue);

      host.run(
        _timerHolding(5000, 2),
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
      host.run(_main([_return(_int(1))]), hooks: merged);
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
                _main([
                  _do(
                    _call(null, 'Timer', [
                      _ms(200),
                      _arrow(_call(null, 'hold', [_int(1)])),
                    ]),
                  ),
                  _do(_await(_call(null, 'gate'))),
                  _return(_call(null, 'useCapability')),
                ], isAsync: true),
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
      final io = _main([_return(_call(null, 'canFs'))]);
      Object? runIo({D4rtExecutionHooks? hooks}) =>
          host.run(io, imports: ['dart:io'], hooks: hooks);
      expect(
        () => runIo(
          hooks: D4rtExecutionHooks(permissions: {FilesystemPermission.any}),
        ),
        throwsA(predicate((e) => '$e'.contains('dart:io'))),
      );
      host.runner.grant(FilesystemPermission.any);
      expect(runIo(), isTrue);
      expect(
        () => runIo(hooks: const D4rtExecutionHooks(permissions: {})),
        throwsA(predicate((e) => '$e'.contains('dart:io'))),
      );
      final contexts = <D4rtExecutionContext>[];
      final holding = _holding(_call(null, 'canFs'));
      host.run(
        holding,
        hooks: D4rtExecutionHooks(onStart: contexts.add, permissions: {}),
      );
      host.run(
        holding,
        hooks: D4rtExecutionHooks(
          onStart: contexts.add,
          permissions: {FilesystemPermission.any},
        ),
      );
      expect([host.call(0), host.call(1)], [false, true]);
      expect(contexts[0].permissions, isEmpty);
      expect(contexts[1].permissions, {FilesystemPermission.any});
      late D4rtExecutionContext context;
      final result =
          host.run(
                _main([
                  _var('a', _call(null, 'canFs')),
                  _do(_await(_call(null, 'gate'))),
                  _return(_list([_id('a'), _call(null, 'canFs')])),
                ], isAsync: true),
                hooks: D4rtExecutionHooks(onStart: (c) => context = c),
              )
              as Future;
      await _settle();
      context.revokePermission(FilesystemPermission.any);
      host.open(0);
      expect(await result, [true, false]);
      expect(
        host.runner.checkPermission({
          'type': 'filesystem',
          'pathAgnostic': true,
        }),
        isTrue,
      );
    });

    test('EH-15: output - print and stdout of a run reach its sink and not a '
        'concurrent run\'s; echo; lines; the web stub [2026-11-15]', () async {
      final host = _Host()..runner.grant(FilesystemPermission.any);
      SFunctionDeclaration twoPart(String tag) => _main([
        _do(_call(null, 'print', [_str('${tag}1')])),
        _do(_await(_call(null, 'gate'))),
        _do(_call(_id('stdout'), 'write', [_str('${tag}2')])),
      ], isAsync: true);
      final a = <String>[];
      final b = <String>[];
      final ra =
          host.run(
                twoPart('a'),
                imports: ['dart:io'],
                hooks: D4rtExecutionHooks(output: D4rtOutput(out: a.add)),
              )
              as Future;
      final rb =
          host.run(
                twoPart('b'),
                imports: ['dart:io'],
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

      for (final echo in [false, true]) {
        final seen = <String>[];
        final out = <String>[];
        runZoned(
          () => host.run(
            _main([
              _do(_call(null, 'print', [_str('x')])),
            ]),
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

      final lines = <String>[];
      SExpressionStatement write(String text) =>
          _do(_call(_id('stdout'), 'write', [_str(text)]));
      host.run(
        _main([
          write('ab'),
          write('c\nd'),
          _do(_call(null, 'print', [_str('e')])),
          write('tail'),
        ]),
        imports: ['dart:io'],
        hooks: D4rtExecutionHooks(
          output: D4rtOutput(out: lines.add, lines: true),
        ),
      );
      expect(lines, ['abc', 'de', 'tail']);

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
      host.runner.registertopLevelFunction('zoneNow', (v, a, n, t) {
        scriptZone = Zone.current;
        return D4rtExecutionContext.of(v);
      }, _host);
      final outer = Zone.current;
      expect(
        host.run(
          _main([
            _do(_call(null, 'hold', [_arrow(_int(1))])),
            _return(_call(null, 'zoneNow')),
          ]),
        ),
        isNull,
      );
      expect(scriptZone!.parent, same(outer));
      expect(host.held.single.visitor.executionContext, isNull);
      expect(host.call(0), 1);
    });
  });
}
