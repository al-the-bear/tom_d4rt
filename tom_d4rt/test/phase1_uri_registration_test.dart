/// Phase-1 regression tests for the import-optimization plan (step #6).
///
/// These lock in the three Phase-1 guarantees so a later refactor cannot
/// silently regress them:
///
///  (a) The bridge registries are URI-keyed (`Map<uri, Map<name, …>>`), so
///      resolving / registering one library URI touches **only** that URI's
///      bucket — O(matched), never an O(total) scan of every registered URI.
///      The old design was `List<Map<uri, X>>` (one single-entry map per
///      element, scanned in full per import); a revert would break the bucket
///      isolation asserted here.
///  (b) `BridgedEnumDefinition.buildBridgedEnum()` is memoized (step #4).
///  (c) Name + native-type resolution still work through the lazy thunk / memo
///      path (step #3).
///
/// Twin of `tom_d4rt_ast/test/runtime/phase1_uri_registration_test.dart`.
///
/// `D4rt` does not expose its element registries publicly (the AST twin's
/// [D4rtRunner] does), so the URI-keyed structure (a) is asserted on the maps
/// fed to [ModuleLoader] and the selective-registration behaviour is proven by
/// driving the loader directly. The keyed-insert performed by
/// `registerBridgedClass`/`registerBridgedEnum` is already covered by
/// `test/bridge/reexport_deduplication_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt/src/module_loader.dart';

/// Trivial native enum used as a bridge target for the memo case.
enum _Phase { red, green, blue }

/// Trivial native type used as a bridge target for the thunk case.
class _Lazy {
  const _Lazy();
}

void main() {
  /// A marker [BridgedClass] — we never instantiate the native type.
  BridgedClass marker(String name) =>
      BridgedClass(nativeType: Object, name: name);

  /// Wraps [name] as a URI-keyed [LibraryClass] bucket entry.
  Map<String, Map<String, LibraryClass>> classBuckets(
      Map<String, String> nameToUri) {
    final out = <String, Map<String, LibraryClass>>{};
    nameToUri.forEach((name, uri) {
      (out[uri] ??= {})[name] = LibraryClass(marker(name), sourceUri: uri);
    });
    return out;
  }

  group('IMP-OPT-6: Phase-1 registration is O(matched)', () {
    test(
        'IMP-OPT-6a: registries are URI-keyed with isolated per-URI buckets',
        () {
      final uris = List.generate(5, (i) => 'package:lib$i/lib$i.dart');
      final classes = classBuckets({
        for (var i = 0; i < uris.length; i++) 'Class$i': uris[i],
      });

      // One bucket per URI — not a flat list of single-entry maps.
      expect(classes.length, 5);

      // Each URI's bucket holds exactly that URI's class, nothing else.
      for (var i = 0; i < uris.length; i++) {
        expect(classes[uris[i]]!.keys, ['Class$i'],
            reason: 'bucket for ${uris[i]} is isolated to its own class');
      }

      // Resolving one URI is a single keyed bucket read — it never sees
      // another URI's class (the O(matched) property the loader relies on).
      final lib3 = classes['package:lib3/lib3.dart']!;
      expect(lib3.containsKey('Class3'), isTrue);
      for (var i = 0; i < uris.length; i++) {
        if (i == 3) continue;
        expect(lib3.containsKey('Class$i'), isFalse);
      }

      // A URI with no bridges is an O(1) miss — no scan needed.
      expect(classes.containsKey('package:none/none.dart'), isFalse);
    });

    test(
        'IMP-OPT-6b: loading one URI does not register unrelated URIs\' bridges',
        () {
      final classes = classBuckets({
        'AClass': 'package:a/a.dart',
        'BClass': 'package:b/b.dart',
      });

      final env = Environment();
      final loader = ModuleLoader(
        env,
        <String, String>{},
        <String, Map<String, LibraryEnum>>{},
        classes,
      );

      final module = loader.loadModule(Uri.parse('package:a/a.dart'));

      // The imported URI's bridge is present in its module environment.
      expect(module.exportedEnvironment.findBridgedClassByName('AClass'),
          isNotNull);
      // The unrelated URI was never imported, so its bridge must NOT have
      // been pulled into this module's environment — proving registration is
      // selective per URI, not a global dump of every registered bridge.
      expect(module.exportedEnvironment.findBridgedClassByName('BClass'),
          isNull);
    });

    test('IMP-OPT-6c: buildBridgedEnum is memoized (step #4 cross-check)', () {
      final def = BridgedEnumDefinition<_Phase>(
        name: 'Phase',
        values: _Phase.values,
      );
      final first = def.buildBridgedEnum();
      final second = def.buildBridgedEnum();
      expect(identical(first, second), isTrue,
          reason: 'the enum is built once and cached');
    });

    test(
        'IMP-OPT-6d: name + type resolution work through the thunk/memo path '
        '(step #3 cross-check)', () {
      final env = Environment();
      var builds = 0;
      env.defineBridgeLazy('Lazy', _Lazy, () {
        builds++;
        return BridgedClass(nativeType: _Lazy, name: 'Lazy');
      });

      // Registration alone must not build the class.
      expect(builds, 0);

      final resolved = env.findBridgedClassByName('Lazy');
      expect(resolved, isNotNull);
      expect(resolved!.name, 'Lazy');
      expect(builds, 1, reason: 'first lookup builds the class exactly once');

      // Subsequent lookups serve the memoized class.
      env.findBridgedClassByName('Lazy');
      expect(builds, 1);
    });
  });
}
