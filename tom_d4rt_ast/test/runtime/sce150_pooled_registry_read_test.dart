/// SCE150 — the read-side registries answer for the POOL, not only for the
/// registrations this instance happened to make.
///
/// Bridge registration is pooled per process (import-optimization steps
/// #19/#20): `providePackage` returns true on the second instance, so its
/// caller SKIPS the `register*` block — and with it the dual-write into the
/// instance maps. The interpreter went on resolving everything, because it
/// reads the pool. The public getters did not, because they read only the
/// instance maps. A second interpreter in one process therefore reported
/// EMPTY registries while working perfectly.
///
/// WHY IT WAS WORTH FIXING RATHER THAN DOCUMENTING: the failure surfaced
/// layers away from its cause. `AstBundler(bridgedLibraries:
/// runner.bridgedLibraryUris)` stopped skipping bridged imports and the compile
/// died with `Package import "package:flutter/material.dart" is not bridged and
/// not in the same package` — a message about a missing bridge, for a bridge
/// that was present and working. Nothing in the getters' names or doc comments
/// hinted at a dependence on construction order.
///
/// F-SCE150-4 is the control that stops the fix over-reaching: an instance sees
/// the packages it was GRANTED and no others. Merging the whole pool would
/// leak one interpreter's bridges into another's answer, which is the property
/// `_allowedPackages` exists to hold.
@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  const pkg = 'sce150_pkg';
  const otherPkg = 'sce150_other_pkg';
  const lib = 'package:sce150/registry.dart';
  const otherLib = 'package:sce150/other.dart';

  setUp(D4rtRunner.debugResetPool);
  tearDownAll(D4rtRunner.debugResetPool);

  /// A runner that has been granted [package], registering into it only when
  /// it is the first to arrive — the canonical `providePackage` call site.
  D4rtRunner provide(String package, String library) {
    final runner = D4rtRunner();
    if (runner.providePackage(package) == false) {
      runner.registerTopLevelFunction('fn', (v, t, p, n) => 1, library);
      runner.registerGlobalVariable('v', 2, library);
      runner.registerGlobalGetter('g', () => 3, library);
    }
    return runner;
  }

  group('SCE150: a pooled instance reports what it has bridged', () {
    test('F-SCE150-1: the SECOND instance reports the same bridged library '
        'URIs as the first [2026-09-22]', () {
      final first = provide(pkg, lib);
      expect(first.bridgedLibraryUris, equals({lib}));

      final second = provide(pkg, lib);
      // Pre-fix: {} — the second instance skipped registration, so its
      // instance maps were never written and the getter had nothing to read.
      expect(second.bridgedLibraryUris, equals({lib}));
    });

    test('F-SCE150-2: every read-side registry answers on the second '
        'instance [2026-09-22]', () {
      provide(pkg, lib);
      final second = provide(pkg, lib);

      // Pre-fix all three were empty. They are listed separately rather than
      // as one assertion because they are seven independent maps merged from
      // one pool walk, and a merge that reached only some of them would pass a
      // single spot check.
      expect(second.libraryFunctions[lib], isNotNull);
      expect(second.libraryFunctions[lib]!.containsKey('fn'), isTrue);
      expect(second.libraryVariables[lib]?.containsKey('v'), isTrue);
      expect(second.libraryGetters[lib]?.containsKey('g'), isTrue);
    });

    test('F-SCE150-3: a registration made AFTER the first read is visible '
        '[2026-09-22]', () {
      final runner = provide(pkg, lib);
      expect(runner.bridgedLibraryUris, equals({lib}));

      // The merged view is cached, so the cache has to notice a later write.
      // `_bundleFor` is the choke point every `register*` passes through and
      // is where the pool's revision moves; if the cache keyed on anything
      // less exact than that, this would still report the old set.
      runner.registerTopLevelFunction('late', (v, t, p, n) => 4, otherLib);
      expect(runner.bridgedLibraryUris, equals({lib, otherLib}));
    });

    test('F-SCE150-4 (control): an instance does NOT see a package it was not '
        'granted [2026-09-22]', () {
      provide(otherPkg, otherLib);

      // A second runner granted only `pkg`. `otherPkg` is in the pool, so a
      // fix that merged the whole pool instead of the granted packages would
      // report `otherLib` here — one interpreter's bridges leaking into
      // another's answer, which is what `_allowedPackages` exists to prevent.
      final granted = provide(pkg, lib);
      expect(granted.bridgedLibraryUris, equals({lib}));
      expect(granted.libraryFunctions.containsKey(otherLib), isFalse);
    });

    test('F-SCE150-5 (control): a runner granted nothing reports nothing '
        '[2026-09-22]', () {
      provide(pkg, lib);
      // No `providePackage` at all: the legacy shape, whose registrations go
      // to the synthetic default package. It must not inherit `pkg`'s.
      expect(D4rtRunner().bridgedLibraryUris, isEmpty);
    });
  });
}
