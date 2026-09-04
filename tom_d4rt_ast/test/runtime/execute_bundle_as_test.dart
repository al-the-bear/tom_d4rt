/// Tests for [D4rtRunner.executeBundleAs] /
/// [D4rtRunner.executeBundleAsAsync] — the typed entry points introduced
/// in step 2 of `d4rt_consolidation_plan.md`.
///
/// The analyzer-free package can't parse Dart source, so the bundle is
/// hand-built from `SAstNode`s — the goal of this suite is purely to
/// verify the typed-entry-point glue (forward to `executeBundle`, then
/// apply [D4.unwrapAs]). Comprehensive unwrap-path coverage lives in
/// `unwrap_as_test.dart`; comprehensive bundle scenarios with a source
/// parser live in `tom_d4rt_exec/test/d4rt_execute_bundle_as_test.dart`.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  /// Builds an [AstBundle] containing a single module whose `main`
  /// function returns the literal [returnValue] as an `int`.
  AstBundle intBundle(
    int returnValue, {
    String entryUri = 'package:t/main.dart',
  }) {
    final mainFn = SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: SSimpleIdentifier(offset: 0, length: 4, name: 'main'),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          block: SBlock(
            offset: 0,
            length: 0,
            statements: [
              SReturnStatement(
                offset: 0,
                length: 0,
                expression: SIntegerLiteral(
                  offset: 0,
                  length: 1,
                  value: returnValue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    final unit = SCompilationUnit(offset: 0, length: 0, declarations: [mainFn]);
    return AstBundle(entryPointUri: entryUri, modules: {entryUri: unit});
  }

  group('D4rtRunner.executeBundleAs<T>', () {
    test('returns the raw int when T == int', () {
      final runner = D4rtRunner();
      final result = runner.executeBundleAs<int>(intBundle(42));
      expect(result, 42);
    });

    test('returns null when T is nullable and bundle returns null', () {
      // We can't synthesise a `null`-returning function via an integer
      // literal helper, so we fall back to running a no-statement body
      // (returns null implicitly) and asking for a nullable T.
      final mainFn = SFunctionDeclaration(
        offset: 0,
        length: 0,
        name: SSimpleIdentifier(offset: 0, length: 4, name: 'main'),
        functionExpression: SFunctionExpression(
          offset: 0,
          length: 0,
          parameters: SFormalParameterList(offset: 0, length: 0),
          body: SBlockFunctionBody(
            offset: 0,
            length: 0,
            block: SBlock(offset: 0, length: 0, statements: []),
          ),
        ),
      );
      final unit = SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [mainFn],
      );
      final bundle = AstBundle(
        entryPointUri: 'package:t/main.dart',
        modules: {'package:t/main.dart': unit},
      );

      final runner = D4rtRunner();
      final result = runner.executeBundleAs<int?>(bundle);

      expect(result, isNull);
    });

    test('throws D4UnwrapException when result is not a T', () {
      final runner = D4rtRunner();

      expect(
        () => runner.executeBundleAs<String>(intBundle(7)),
        throwsA(
          isA<D4UnwrapException>()
              .having((e) => e.expectedType, 'expectedType', 'String')
              .having((e) => e.actualType, 'actualType', 'int'),
        ),
      );
    });
  });

  group('D4rtRunner.executeBundleAsAsync<T>', () {
    test('passes through synchronous int results', () async {
      final runner = D4rtRunner();

      final result = await runner.executeBundleAsAsync<int>(intBundle(11));

      expect(result, 11);
    });

    test('throws D4UnwrapException for sync mismatched type', () async {
      final runner = D4rtRunner();

      await expectLater(
        runner.executeBundleAsAsync<String>(intBundle(11)),
        throwsA(
          isA<D4UnwrapException>()
              .having((e) => e.expectedType, 'expectedType', 'String')
              .having((e) => e.actualType, 'actualType', 'int'),
        ),
      );
    });
  });
}
