// SCD63/AST — a typed for-each loop variable is checked in the analyzer-free
// tree too.
//
// The mirror of `tom_d4rt/test/scd63_foreach_type_test.dart`, and deliberately
// much smaller. That file runs source, so it can walk all seven for-each
// execution paths and thirteen cases cheaply. This package cannot execute
// source at all — it interprets pre-parsed `SAstNode` trees — so every case
// here is a bundle built by hand, and each one costs a couple of dozen lines.
//
// WHAT IS PINNED HERE IS THE CLAIM, NOT THE CATALOGUE: that the check is live
// in THIS interpreter, and that it is a BINDING check rather than the `is`
// predicate. The shared rule lives in one place
// (`InterpretedFunction.resolveForEachBinding`), so proving it fires from the
// visitor's for-in proves the paths that call the same function; the reference
// tree's value is that it demonstrates all seven for real.
//
// The four cases are the minimum that cannot pass by accident:
//
//   -1 a mismatched element throws           — the defect itself
//   -2 a matching element binds and runs     — the fix must not break loops
//   -3 an untyped loop variable binds anything
//                                            — the annotation, not the loop,
//                                              is what makes the difference
//   -4 `double` widens an `int`              — the case that distinguishes a
//                                              binding check from `is`, since
//                                              `1 is double` is false and
//                                              `for (final double d in [1])`
//                                              is a program Dart accepts
//
// A "throw whenever the loop variable is typed" shortcut passes -1 and fails
// -2 and -4. A check built on `is` passes -1, -2 and -3 and fails -4.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// The bundle for `Object? main()` with a for-each loop over [elements] whose
/// loop variable is `final x` annotated [typeName]; the body returns `x`, and
/// the function returns `'empty'` when the loop never ran.
///
/// A null [typeName] writes the loop variable with no annotation at all.
AstBundle forEachBundle({
  required String? typeName,
  required List<SExpression> elements,
}) {
  const entry = 'package:probe/main.dart';
  SSimpleIdentifier id(String name) =>
      SSimpleIdentifier(offset: 0, length: 0, name: name);

  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: const [],
        declarations: [
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: SFormalParameterList(
                offset: 0,
                length: 0,
                parameters: const [],
              ),
              body: SBlockFunctionBody(
                offset: 0,
                length: 0,
                block: SBlock(
                  offset: 0,
                  length: 0,
                  statements: [
                    SForStatement(
                      offset: 0,
                      length: 0,
                      forLoopParts: SForEachPartsWithDeclaration(
                        offset: 0,
                        length: 0,
                        loopVariable: SDeclaredIdentifier(
                          offset: 0,
                          length: 0,
                          identifier: id('x'),
                          isFinal: true,
                          type: typeName == null
                              ? null
                              : SNamedType(
                                  offset: 0,
                                  length: 0,
                                  name: id(typeName),
                                ),
                        ),
                        iterable: SListLiteral(
                          offset: 0,
                          length: 0,
                          elements: elements,
                        ),
                      ),
                      // Returning from inside the loop makes the value the loop
                      // actually bound observable, which a body that only had
                      // an effect would not be.
                      body: SBlock(
                        offset: 0,
                        length: 0,
                        statements: [
                          SReturnStatement(
                            offset: 0,
                            length: 0,
                            expression: id('x'),
                          ),
                        ],
                      ),
                    ),
                    SReturnStatement(
                      offset: 0,
                      length: 0,
                      expression: SSimpleStringLiteral(
                        offset: 0,
                        length: 0,
                        value: 'empty',
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    },
  );
}

SExpression intLit(int v) => SIntegerLiteral(offset: 0, length: 0, value: v);
SExpression strLit(String v) =>
    SSimpleStringLiteral(offset: 0, length: 0, value: v);
SExpression dblLit(double v) => SDoubleLiteral(offset: 0, length: 0, value: v);

void main() {
  Object? run(String? typeName, List<SExpression> elements) =>
      D4rtRunner().executeBundleAs<Object?>(
        forEachBundle(typeName: typeName, elements: elements),
      );

  group('SCD63/AST: a typed for-each variable is checked', () {
    test('F-SCD63-AST-1: a mismatched element raises TypeError '
        '[2026-09-12] (PASS)', () {
      expect(
        () => run('int', [strLit('two')]),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'message',
            "type 'String' is not a subtype of type 'int'",
          ),
        ),
      );
    });

    test('F-SCD63-AST-2: a matching element binds and the body runs '
        '[2026-09-12] (PASS)', () {
      expect(run('int', [intLit(7)]), 7);
      expect(run('String', [strLit('ok')]), 'ok');
    });

    test('F-SCD63-AST-3: an unannotated loop variable admits anything '
        '[2026-09-12] (PASS)', () {
      // Same bundle, same element — only the annotation is removed. This is
      // what says the check keys off the written type rather than firing on
      // every for-each.
      expect(run(null, [strLit('two')]), 'two');
    });

    test('F-SCD63-AST-4: `double` widens an `int`, as Dart does '
        '[2026-09-12] (PASS)', () {
      // `1 is double` is false, so a check built on the `is` predicate would
      // reject this — but `for (final double d in [1])` is a program real
      // Dart accepts, because the literal widens. The binding check converts.
      expect(run('double', [intLit(1)]), 1.0);
      expect(run('double', [dblLit(2.5)]), 2.5);
    });
  });
}
