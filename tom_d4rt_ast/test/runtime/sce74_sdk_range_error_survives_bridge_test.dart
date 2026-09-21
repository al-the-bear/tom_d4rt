// SCE74, analyzer-free side: an SDK range error survives the call layer.
//
// The defect was not in any adapter, which is why grepping `stdlib` for it
// found nothing. `BridgedMethodCallable.call` caught `ArgumentError` to improve
// the message for adapter arity problems — and `RangeError extends
// ArgumentError`, `IndexError implements RangeError`, so that one clause
// swallowed every SDK RANGE failure raised by ANY bridged method and reissued
// it as an uncatchable `RuntimeD4rtException`.
//
// WHY THIS FILE EXISTS BESIDE THE SOURCE-SIDE ONE. The script-level matrix
// lives in `tom_d4rt/test/stdlib/sce74_sdk_error_type_parity_test.dart`; this
// package has no parser, and `tom_d4rt_exec` — the only runner that could
// execute a script against THIS tree — resolves `tom_d4rt_ast` from pub.dev
// rather than by path, so it cannot see unpublished local edits (DGUC6). The
// mirror guard keeps `callable.dart` identical between the trees, but it tells
// you the two files AGREE, not that either is correct. This is the tree a
// Flutter app ships, so the clause being right in THIS copy is what decides
// whether an app's `on RangeError` works.
//
// AND WHY IT GOES THROUGH `BridgedMethodCallable` RATHER THAN THE ADAPTER.
// The sibling cases in `stdlib_double_linked_queue_test.dart` invoke adapters
// directly — `queueMethod('removeFirst')(visitor, queue, …)` — which is the
// right shape for asserting what an ADAPTER does, and would pass here whether
// the fix existed or not: it never enters the call layer that was wrong.

import 'dart:collection';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// The stdlib registrars are deliberately NOT re-exported from `runtime.dart`
// — `dart:collection` is registered lazily when a script imports it, and
// driving that path from a unit test would mean building a parsed AST module.
// `BridgedMethodCallable` and `BridgedInstance`, by contrast, do come from
// `runtime.dart`, so only these two reach into the package.
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/core.dart';

import '../bridge_reachability.dart';

void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    CoreStdlib.register(env);
    CollectionStdlib.register(env);
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  group('SCE74: the call layer does not swallow an SDK range error', () {
    /// Calls [member] on [native] THROUGH the bridged-call layer, which is the
    /// layer the fix is in.
    Object? callThroughBridge(
      String className,
      Object native,
      String member,
      List<Object?> args,
    ) {
      final bridge = env.findBridgedClassByName(className)!;
      // RESOLVED BY REACHABILITY, not indexed out of this bridge — and that is
      // the whole reason the queues were affected while `HashSet` was not.
      // `ListQueue` declares no `elementAt`; it inherits `Iterable`'s
      // delegating adapter, and that route runs through the call layer below.
      // A set with its own adapter never enters it, so a test written against
      // `HashSet` would have passed throughout the defect's life.
      final adapter = findReachableMethod(env, className, member)!;
      final instance = BridgedInstance(bridge, native);
      return BridgedMethodCallable(
        instance,
        adapter,
        member,
      ).call(visitor, args);
    }

    test('F-SCE74-AST-1: `elementAt` out of range stays a RangeError '
        '[2026-09-21] (PASS)', () {
      // Dart answers `IndexError`, which implements `RangeError`. Before the
      // narrowing this arrived as `RuntimeD4rtException: Invalid arguments for
      // bridged method 'ListQueue.elementAt'`, so a script's `on RangeError`
      // never fired.
      expect(
        () => callThroughBridge(
          'ListQueue',
          ListQueue<dynamic>(),
          'elementAt',
          [0],
        ),
        throwsA(isA<RangeError>()),
      );
    });

    test('F-SCE74-AST-2 (control): a plain ArgumentError is still rewrapped '
        '[2026-09-21] (PASS)', () {
      // The arm was NARROWED, not deleted, and this is what says so. An
      // adapter raising a plain `ArgumentError` for an argument-shape problem
      // has no SDK counterpart, so it should still arrive as an interpreter
      // error with the bridge and member named. Deleting the clause instead of
      // narrowing it would make this fail.
      final bridge = env.findBridgedClassByName('ListQueue')!;
      final instance = BridgedInstance(bridge, ListQueue<dynamic>());
      expect(
        () => BridgedMethodCallable(instance, (
          visitor,
          target,
          positional,
          named,
          typeArgs,
        ) {
          throw ArgumentError('adapter says no');
        }, 'syntheticMember').call(visitor, const []),
        throwsA(
          allOf(
            isA<RuntimeD4rtException>(),
            isNot(isA<RangeError>()),
            predicate<Object>(
              (e) => '$e'.contains('syntheticMember'),
              'names the member',
            ),
          ),
        ),
      );
    });
  });
}
