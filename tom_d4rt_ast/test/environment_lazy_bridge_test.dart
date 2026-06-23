/// Tests for the thunk-capable bridge registry (import-optimization plan
/// step #3). A bridged class registered via [Environment.defineBridgeLazy] is
/// stored as a deferred `() => BridgedClass` thunk and built — then memoized —
/// only when the name (or native type) is first resolved.
///
/// Twin of `tom_d4rt/test/environment_lazy_bridge_test.dart`.
import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// A trivial native type used as a bridge target.
class _Widget {
  final String label;
  _Widget(this.label);
}

/// A second native type for the same-name collision case.
class _OtherWidget {
  const _OtherWidget();
}

void main() {
  group('IMP-OPT-3: thunk-capable bridge registry', () {
    test(
        'IMP-OPT-3a: defineBridgeLazy defers construction until first lookup',
        () {
      final env = Environment();
      var builds = 0;
      env.defineBridgeLazy('Widget', _Widget, () {
        builds++;
        return BridgedClass(nativeType: _Widget, name: 'Widget');
      });

      // Registration alone must not build the class.
      expect(builds, 0, reason: 'thunk must not run at registration time');

      final resolved = env.findBridgedClassByName('Widget');
      expect(resolved, isNotNull);
      expect(resolved!.name, 'Widget');
      expect(builds, 1, reason: 'first lookup builds the class exactly once');
    });

    test('IMP-OPT-3b: lookup memoizes — the thunk runs at most once', () {
      final env = Environment();
      var builds = 0;
      env.defineBridgeLazy('Widget', _Widget, () {
        builds++;
        return BridgedClass(nativeType: _Widget, name: 'Widget');
      });

      final first = env.findBridgedClassByName('Widget');
      final second = env.findBridgedClassByName('Widget');
      final third = env.findBridgedClassByName('Widget');

      expect(builds, 1, reason: 'subsequent lookups serve the memoized class');
      expect(identical(first, second), isTrue);
      expect(identical(second, third), isTrue);
    });

    test('IMP-OPT-3c: thunk resolves across the enclosing scope chain', () {
      final parent = Environment();
      final child = Environment(enclosing: parent);
      var builds = 0;
      parent.defineBridgeLazy('Widget', _Widget, () {
        builds++;
        return BridgedClass(nativeType: _Widget, name: 'Widget');
      });

      expect(builds, 0);
      final resolved = child.findBridgedClassByName('Widget');
      expect(resolved, isNotNull);
      expect(builds, 1, reason: 'child lookup walks up and builds once');
    });

    test(
        'IMP-OPT-3d: defineBridge (eager API) routes through the thunk + memo',
        () {
      final env = Environment();
      final built = BridgedClass(nativeType: _Widget, name: 'Widget');
      env.defineBridge(built);

      final first = env.findBridgedClassByName('Widget');
      final second = env.findBridgedClassByName('Widget');
      expect(identical(first, built), isTrue,
          reason: 'eager registration serves the same instance');
      expect(identical(first, second), isTrue);
    });

    test('IMP-OPT-3e: same-name collision preserves the displaced bridge', () {
      final env = Environment();
      final first = BridgedClass(nativeType: _Widget, name: 'Widget');
      final second = BridgedClass(nativeType: _OtherWidget, name: 'Widget');
      env.defineBridge(first);
      env.defineBridge(second);

      // Last registration wins as the primary.
      expect(identical(env.findBridgedClassByName('Widget'), second), isTrue);
      // The displaced bridge is still reachable for static/constructor fallback.
      final all = env.findAllBridgedClassesByName('Widget');
      expect(all, containsAll(<BridgedClass>[first, second]));
    });
  });
}
