import 'dart:collection';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';
// `CollectionStdlib` — like every other stdlib registrar — is deliberately not
// re-exported from `runtime.dart`; `dart:collection` is registered lazily by
// `ast_module_loader.dart` when a script imports it. Driving that path from a
// unit test would mean building a parsed AST module, so we reach for the
// same-package registrar directly instead of widening the published API.
import 'package:tom_d4rt_ast/src/runtime/stdlib/collection.dart';

/// SC3 mirror coverage for `tom_d4rt_ast`.
///
/// Registration-level rather than script-level: the script-level equivalents
/// live in `tom_d4rt/test/stdlib/collection/`, and `tom_d4rt_exec` (the runner
/// that could execute a script against *this* tree) resolves `tom_d4rt_ast`
/// from pub.dev rather than by path, so it cannot see unpublished local edits.
/// What we can pin here is that both bridges are registered, expose the surface
/// the script tests exercise, read through to the native view, and let the
/// native `UnsupportedError` escape from the mutating members.
void main() {
  late Environment env;
  late InterpreterVisitor visitor;

  setUp(() {
    env = Environment();
    CollectionStdlib.register(env);
    // Method adapters take a non-nullable visitor (only getters accept `null`),
    // so the mutator tests need a real one. None of the members exercised here
    // resolves a name or loads a module, so an empty loader is enough.
    visitor = InterpreterVisitor(
      globalEnvironment: env,
      moduleContext: AstModuleLoader(
        modules: const {},
        globalEnvironment: env,
        runner: D4rtRunner(),
      ),
    );
  });

  group('SC3: UnmodifiableMapView collection bridge', () {
    test('F-SC3-AST-1: is registered under the name UnmodifiableMapView [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('UnmodifiableMapView');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, UnmodifiableMapView);
      expect(bridge.typeParameterCount, 2);
      expect(
          bridge.isAssignable?.call(UnmodifiableMapView<String, int>({'a': 1})),
          isTrue);
      expect(bridge.isAssignable?.call(<String, int>{'a': 1}), isFalse);
    });

    test('F-SC3-AST-2: exposes the wrapping constructor [2026-07-27]', () {
      final bridge = env.findBridgedClassByName('UnmodifiableMapView')!;
      expect(bridge.constructors.keys, contains(''));
    });

    test('F-SC3-AST-3: exposes the read and mutating Map surface [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('UnmodifiableMapView')!;
      expect(
        bridge.methods.keys,
        containsAll(<String>[
          // read-through
          '[]', 'containsKey', 'containsValue', 'forEach', 'map', 'cast',
          // delegated so the native view raises UnsupportedError
          '[]=', 'addAll', 'addEntries', 'clear', 'putIfAbsent', 'remove',
          'removeWhere', 'update', 'updateAll',
        ]),
      );
    });

    test('F-SC3-AST-4: the getters read through to the backing map [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('UnmodifiableMapView')!;
      final view = UnmodifiableMapView<dynamic, dynamic>({'a': 1, 'b': 2});
      expect(bridge.getters['length']!(null, view), 2);
      expect(bridge.getters['isEmpty']!(null, view), isFalse);
      expect(bridge.getters['isNotEmpty']!(null, view), isTrue);
      expect(bridge.getters['keys']!(null, view), orderedEquals(['a', 'b']));
      expect(bridge.getters['values']!(null, view), orderedEquals([1, 2]));
    });

    test('F-SC3-AST-5: the mutators delegate, so the SDK error surfaces [2026-07-27]',
        () {
      // The whole point of delegating rather than intercepting: scripts catch
      // `UnsupportedError`, not a D4rt-specific exception.
      final bridge = env.findBridgedClassByName('UnmodifiableMapView')!;
      final view = UnmodifiableMapView<dynamic, dynamic>({'a': 1});
      expect(
        () => bridge.methods['clear']!(visitor, view, [], {}, []),
        throwsUnsupportedError,
      );
      expect(
        () => bridge.methods['[]=']!(visitor, view, ['b', 2], {}, []),
        throwsUnsupportedError,
      );
      // ... while the read-through members on the same bridge still work.
      expect(bridge.methods['[]']!(visitor, view, ['a'], {}, []), 1);
    });
  });

  group('SC3: UnmodifiableSetView collection bridge', () {
    test('F-SC3-AST-6: is registered under the name UnmodifiableSetView [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('UnmodifiableSetView');
      expect(bridge, isNotNull);
      expect(bridge!.nativeType, UnmodifiableSetView);
      expect(bridge.typeParameterCount, 1);
      expect(bridge.isAssignable?.call(UnmodifiableSetView<int>({1})), isTrue);
      expect(bridge.isAssignable?.call(<int>{1}), isFalse);
    });

    test('F-SC3-AST-7: exposes the read and mutating Set surface [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('UnmodifiableSetView')!;
      expect(
        bridge.methods.keys,
        containsAll(<String>[
          // read-through
          'contains', 'containsAll', 'lookup', 'difference', 'intersection',
          'union', 'forEach', 'map', 'where', 'fold', 'join', 'toList', 'toSet',
          // delegated so the native view raises UnsupportedError
          'add', 'addAll', 'remove', 'removeAll', 'retainAll', 'removeWhere',
          'retainWhere', 'clear',
        ]),
      );
    });

    test('F-SC3-AST-8: the getters read through to the backing set [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('UnmodifiableSetView')!;
      final view = UnmodifiableSetView<dynamic>({'x', 'y'});
      expect(bridge.getters['length']!(null, view), 2);
      expect(bridge.getters['isEmpty']!(null, view), isFalse);
      expect(bridge.getters['first']!(null, view), 'x');
      expect(bridge.getters['last']!(null, view), 'y');
    });

    test('F-SC3-AST-9: the mutators delegate, so the SDK error surfaces [2026-07-27]',
        () {
      final bridge = env.findBridgedClassByName('UnmodifiableSetView')!;
      final view = UnmodifiableSetView<dynamic>({1});
      expect(
        () => bridge.methods['add']!(visitor, view, [2], {}, []),
        throwsUnsupportedError,
      );
      expect(
        () => bridge.methods['clear']!(visitor, view, [], {}, []),
        throwsUnsupportedError,
      );
      // ... while the read-through members on the same bridge still work.
      expect(bridge.methods['contains']!(visitor, view, [1], {}, []), isTrue);
    });

    test('F-SC3-AST-10: the two views stay distinct bridges [2026-07-27]', () {
      // If either bridge captured the other's native type, dispatch would offer
      // the wrong member surface for whichever type lost.
      final mapView = env.findBridgedClassByName('UnmodifiableMapView')!;
      final setView = env.findBridgedClassByName('UnmodifiableSetView')!;
      expect(mapView.isAssignable!(UnmodifiableSetView<int>({1})), isFalse);
      expect(
          setView.isAssignable!(UnmodifiableMapView<String, int>({'a': 1})),
          isFalse);
    });
  });
}
