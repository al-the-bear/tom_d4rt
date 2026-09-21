// SCE84/AST — the bridge's construction model, asked without a parser.
//
// The behaviour twin is
// `tom_d4rt/test/stdlib/collection/sce84_linked_list_subclass_test.dart`,
// which runs the script the todo reported:
//
//     class E extends LinkedListEntry<E> { final int v; E(this.v); }
//     final l = LinkedList<E>(); l.add(E(1));
//
// That failed in the implicit `super()` — `Constructor LinkedListEntry(value)
// expects one positional argument` — because the bridge wrapped
// `BridgedLinkedListEntry`, whose constructor took the entry's value. The SDK
// declares `abstract base mixin class LinkedListEntry<E extends
// LinkedListEntry<E>>` with an implicit zero-argument constructor, and
// subclassing is the only way `LinkedList` is usable at all.
//
// This tree has no parser, so the same question is put to the adapters: the
// constructor's arity, the surface's shape, and — the half that is not about
// construction — that an entry carrying an interpreted instance reads as that
// instance rather than as itself.
//
// ABLATED by restoring the value-taking constructor: 2 of 5 go red, AST-1 and
// AST-2 — the two that are about the constructor. AST-3 survives because the
// surface is a separate removal (the `value` getter), and AST-4 and AST-5 are
// about the proxy tie and the argument diagnostic. The reference twin's split
// under the same ablation is 11 of 12, which is the difference between asking
// a script and asking an adapter: every script has to construct an entry
// first.

import 'dart:collection';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection/linked_list.dart';
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

  group('SCE84/AST: LinkedListEntry follows the SDK construction model', () {
    test('F-SCE84-AST-1: the constructor takes no arguments [2026-09-21] '
        '(PASS)', () {
      // What the implicit `super()` of a script's subclass calls. It is
      // invoked with no arguments and nothing else, so an adapter demanding
      // one made the type unsubclassable.
      final made = env
          .findBridgedClassByName('LinkedListEntry')!
          .constructors['']!(visitor, [], {});
      expect(made, isA<BridgedLinkedListEntry>());
    });

    test('F-SCE84-AST-2: the value-taking form is refused, naming what to '
        'write instead [2026-09-21] (PASS)', () {
      // Not in the SDK, so a script using it ran here and did not compile as
      // Dart. The message has to say what to write, or removing it just moves
      // the dead end.
      expect(
        () => env.findBridgedClassByName('LinkedListEntry')!.constructors['']!(
          visitor,
          ['a'],
          {},
        ),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            allOf(
              contains('takes no arguments'),
              contains('extends LinkedListEntry'),
            ),
          ),
        ),
      );
    });

    test('F-SCE84-AST-3: the entry surface is the SDK\'s six members '
        '[2026-09-21] (PASS)', () {
      // `value` went with the constructor: the SDK's entry carries no payload,
      // and a script's subclass is where one belongs. Written out rather than
      // asserted with `containsAll`, which cannot say a member is gone.
      final entry = env.findBridgedClassByName('LinkedListEntry')!;
      expect(
        entry.methods.keys.toSet(),
        equals({'insertAfter', 'insertBefore', 'unlink'}),
      );
      expect(entry.getters.keys.toSet(), equals({'list', 'next', 'previous'}));
    });

    test('F-SCE84-AST-4: adding a script subclass ties the entry to the '
        'instance [2026-09-21] (PASS)', () {
      // The tie that makes `list.first.myField` reach the script's class. The
      // native list can only hold native entries, so the entry the interpreter
      // created for the implicit `super()` carries its owner — and this is the
      // path that sets it, because the constructor adapter is called without
      // `this` and cannot.
      final list = LinkedList<BridgedLinkedListEntry>();
      final native =
          env.findBridgedClassByName('LinkedListEntry')!.constructors['']!(
                visitor,
                [],
                {},
              )
              as BridgedLinkedListEntry;
      expect(
        D4.interpretedBehind(native),
        isNull,
        reason: 'a fresh entry stands for nothing yet',
      );

      final instance = InterpretedInstance(
        InterpretedClass(
          'E',
          null,
          env,
          const [],
          const {},
          const {},
          const {},
          const {},
          const {},
          const {},
          const {},
          const {},
          const {},
        ),
      )..bridgedSuperObject = native;

      findReachableMethod(env, 'LinkedList', 'add')!(
        visitor,
        list,
        [instance],
        {},
        null,
      );
      expect(list.length, 1);
      expect(
        D4.interpretedBehind(list.first),
        same(instance),
        reason: 'the entry the list holds must read back as the script object',
      );
    });

    test('F-SCE84-AST-5: add refuses something that is not an entry '
        '[2026-09-21] (PASS)', () {
      // The widened argument handling accepts an interpreted instance whose
      // bridged super-part is an entry; it must not have widened into
      // accepting anything.
      final list = LinkedList<BridgedLinkedListEntry>();
      expect(
        () => findReachableMethod(env, 'LinkedList', 'add')!(
          visitor,
          list,
          ['not an entry'],
          {},
          null,
        ),
        throwsA(
          isA<RuntimeD4rtException>().having(
            (e) => e.toString(),
            'message',
            contains('LinkedList.add'),
          ),
        ),
      );
    });
  });
}
