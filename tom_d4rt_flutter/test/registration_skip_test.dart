// Import-optimization step #19 — registration-skip + lazy-thunk verification.
//
// Unlike every other test under this folder, this is a pure in-process unit
// test: it does NOT spawn the HTTP companion app. The Flutter conformance
// corpus drives a shared local HTTP server and so MUST run serially; this
// test touches none of that machinery, so it is safe to run alongside the
// rest of the suite.
//
// What it proves about `SourceFlutterD4rt._registerBridges`:
//   1. The first construction pools the `tom_d4rt_flutter` package bundle in
//      the process-global `D4rt` pool, and that bundle holds bridged classes
//      registered as lazy thunks (the import-optimization payload).
//   2. A second `SourceFlutterD4rt()` in the same process reuses the pooled
//      bundle — the pooled class count is unchanged, i.e. the expensive
//      `register*` block ran exactly once.
//   3. The skip path is the `providePackage(...) == true` branch: a fresh,
//      independent `D4rt` asked to provide the already-pooled package gets
//      `true` back (the "already pooled, skip registration" signal the guard
//      keys on).

import 'package:flutter_test/flutter_test.dart';
import 'package:tom_d4rt/d4rt.dart';
import 'package:tom_d4rt_flutter/tom_d4rt_flutter.dart';

void main() {
  const packageName = 'tom_d4rt_flutter';

  setUp(D4rt.debugResetPool);
  tearDown(D4rt.debugResetPool);

  test('first SourceFlutterD4rt pools the package with lazy-thunk classes', () {
    expect(D4rt.debugPooledPackages, isNot(contains(packageName)),
        reason: 'pool should be clean before the first construction');

    SourceFlutterD4rt();

    expect(D4rt.debugPooledPackages, contains(packageName),
        reason: 'construction must pool the tom_d4rt_flutter bundle');
    expect(D4rt.debugPooledClassCount(packageName), greaterThan(0),
        reason: 'lazy bridge thunks must be pooled as bridged classes');
  });

  test('second SourceFlutterD4rt reuses the pool (registration skipped)', () {
    SourceFlutterD4rt();
    final afterFirst = D4rt.debugPooledClassCount(packageName);
    expect(afterFirst, greaterThan(0));

    SourceFlutterD4rt();
    final afterSecond = D4rt.debugPooledClassCount(packageName);

    expect(afterSecond, equals(afterFirst),
        reason: 're-registration must be skipped — the pooled class count '
            'must not change when a second instance is constructed');
  });

  test('providePackage returns true once the package is pooled (skip signal)',
      () {
    // Prime the pool through the public entry point.
    SourceFlutterD4rt();

    // A fresh, independent interpreter sees the package as already pooled and
    // is told to skip its own registration block — exactly the branch the
    // guard in _registerBridges relies on.
    final fresh = D4rt();
    expect(fresh.providePackage(packageName), isTrue,
        reason: 'an already-pooled package must report true so the caller '
            'skips the expensive register* block');
  });
}
