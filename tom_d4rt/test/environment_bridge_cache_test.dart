/// Tests for the T4 (plan_2 §6 / F3) negative resolution cache in
/// [Environment.toBridgedInstance].
library;

/// These tests pin the behavioural invariants that negative caching must
/// preserve:
///   - A native type with no bridge keeps throwing on every wrap attempt
///     (caching a miss must not silently start returning null/garbage).
///   - Caching a miss for one type must not poison resolution of an
///     unrelated, properly-bridged type (per-type cache isolation).
///   - Registering a bridge after a miss was cached invalidates the cache,
///     so the next wrap of that type succeeds (a cached miss can still
///     become a hit).
import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

void main() {
  group('T4 negative resolution cache', () {
    late Environment env;

    setUp(() {
      env = Environment();
    });

    test('I-PERF-T4-01: Unbridged type throws on every repeated wrap. '
        '[2026-06-09 00:00] (PASS)', () {
      final widget = _Widget();
      // First call walks the full chain and caches the miss; subsequent
      // calls hit the negative cache. Both must throw identically.
      for (var i = 0; i < 50; i++) {
        expect(
          () => env.toBridgedInstance(widget),
          throwsA(isA<RuntimeD4rtException>()),
          reason: 'iteration $i must still throw for the unbridged type',
        );
      }
    });

    test('I-PERF-T4-02: Cached miss does not poison an unrelated bridged type. '
        '[2026-06-09 00:00] (PASS)', () {
      env.registerBridgeType(_gadgetBridge());

      final widget = _Widget();
      final gadget = _Gadget();

      // Interleave unbridged misses (which populate the negative cache) with
      // bridged hits. The negative cache is keyed per-type, so the gadget
      // must keep resolving correctly regardless of cached widget misses.
      for (var i = 0; i < 20; i++) {
        expect(
          () => env.toBridgedInstance(widget),
          throwsA(isA<RuntimeD4rtException>()),
        );
        final wrapped = env.toBridgedInstance(gadget);
        expect(wrapped, isA<BridgedInstance>());
        expect(wrapped!.bridgedClass.name, equals('Gadget'));
      }
    });

    test('I-PERF-T4-03: Registering a bridge invalidates a cached miss. '
        '[2026-06-09 00:00] (PASS)', () {
      final widget = _Widget();

      // Prime the negative cache with a miss.
      expect(
        () => env.toBridgedInstance(widget),
        throwsA(isA<RuntimeD4rtException>()),
      );

      // Now register a bridge for the exact native type. This must clear the
      // negative cache so the next wrap resolves instead of re-throwing.
      env.registerBridgeType(BridgedClass(nativeType: _Widget, name: 'Widget'));

      final wrapped = env.toBridgedInstance(widget);
      expect(wrapped, isA<BridgedInstance>());
      expect(wrapped!.bridgedClass.name, equals('Widget'));
    });

    test('I-PERF-T4-04: defineBridge also invalidates a cached miss. '
        '[2026-06-09 00:00] (PASS)', () {
      final gadget = _Gadget();

      expect(
        () => env.toBridgedInstance(gadget),
        throwsA(isA<RuntimeD4rtException>()),
      );

      env.defineBridge(_gadgetBridge());

      final wrapped = env.toBridgedInstance(gadget);
      expect(wrapped, isA<BridgedInstance>());
      expect(wrapped!.bridgedClass.name, equals('Gadget'));
    });
  });
}

/// A native type with no registered bridge — always a resolution miss.
class _Widget {}

/// A native type we register a bridge for in the isolation/invalidation tests.
class _Gadget {}

BridgedClass _gadgetBridge() =>
    BridgedClass(nativeType: _Gadget, name: 'Gadget');
