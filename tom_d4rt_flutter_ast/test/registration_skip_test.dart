// Import-optimization step #20 — registration-skip + lazy-thunk verification.
//
// Unlike the conformance corpus under this folder, this is a pure in-process
// unit test: it does NOT spawn the HTTP companion app. The Flutter corpus
// drives a shared local HTTP server and so MUST run serially; this test
// touches none of that machinery, so it is safe to run alongside the suite.
//
// What it proves about `FlutterD4rt._registerBridges` (the AST twin of
// `SourceFlutterD4rt`):
//   1. The first construction pools the `tom_d4rt_flutter_ast` package bundle
//      in the process-global `D4rtRunner` pool, and that bundle holds bridged
//      classes registered as lazy thunks (the import-optimization payload).
//   2. A second `FlutterD4rt()` in the same process reuses the pooled bundle —
//      the pooled class count is unchanged, i.e. the expensive `register*`
//      block ran exactly once.
//   3. The skip path is the `providePackage(...) == true` branch: a fresh,
//      independent `D4rtRunner` asked to provide the already-pooled package
//      gets `true` back (the "already pooled, skip registration" signal the
//      guard keys on).

import 'package:flutter_test/flutter_test.dart';
// `D4rtRunner`, `D4rt`, `AstBundle`, … are re-exported by the package barrel.
import 'package:tom_d4rt_flutter_ast/tom_d4rt_flutter_ast.dart';

void main() {
  const packageName = 'tom_d4rt_flutter_ast';

  setUp(D4rtRunner.debugResetPool);
  tearDown(D4rtRunner.debugResetPool);

  test('first FlutterD4rt pools the package with lazy-thunk classes', () {
    expect(D4rtRunner.debugPooledPackages, isNot(contains(packageName)),
        reason: 'pool should be clean before the first construction');

    FlutterD4rt();

    expect(D4rtRunner.debugPooledPackages, contains(packageName),
        reason: 'construction must pool the tom_d4rt_flutter_ast bundle');
    expect(D4rtRunner.debugPooledClassCount(packageName), greaterThan(0),
        reason: 'lazy bridge thunks must be pooled as bridged classes');
  });

  test('second FlutterD4rt reuses the pool (registration skipped)', () {
    FlutterD4rt();
    final afterFirst = D4rtRunner.debugPooledClassCount(packageName);
    expect(afterFirst, greaterThan(0));

    FlutterD4rt();
    final afterSecond = D4rtRunner.debugPooledClassCount(packageName);

    expect(afterSecond, equals(afterFirst),
        reason: 're-registration must be skipped — the pooled class count '
            'must not change when a second instance is constructed');
  });

  test('providePackage returns true once the package is pooled (skip signal)',
      () {
    // Prime the pool through the public entry point.
    FlutterD4rt();

    // A fresh, independent interpreter sees the package as already pooled and
    // is told to skip its own registration block — exactly the branch the
    // guard in _registerBridges relies on.
    final fresh = D4rtRunner();
    expect(fresh.providePackage(packageName), isTrue,
        reason: 'an already-pooled package must report true so the caller '
            'skips the expensive register* block');
  });
}
