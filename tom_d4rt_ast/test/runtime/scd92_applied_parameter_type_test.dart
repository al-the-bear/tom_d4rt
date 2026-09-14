// SCD92/AST — a binding check compares declared TYPE ARGUMENTS in the
// analyzer-free tree too.
//
// The mirror of `tom_d4rt/test/scd92_applied_parameter_type_test.dart`, and
// deliberately much smaller. That file runs source, so it can walk twenty
// shapes cheaply. This package cannot execute source at all — it interprets
// pre-parsed `SAstNode` trees — so every case here is a bundle built by hand.
//
// WHAT IS PINNED HERE IS THE CLAIM, NOT THE CATALOGUE: that the applied check
// is live in THIS interpreter, and that its permissive fallback is too. The
// shared rule lives in one place (`ResolvedBinding._checkTypeArguments`, fed by
// `Environment.appliedRuntimeTypeOf`), so proving it fires from a parameter
// bind proves the for-each path that resolves the same binding; the reference
// tree's value is that it demonstrates every exemption for real.
//
// The four cases are the minimum that cannot pass by accident:
//
//   -1 a mismatched element type throws   — the defect itself
//   -2 a matching one binds               — the check must not reject correct
//                                           programs
//   -3 an empty collection binds          — the permissive fallback, which is
//                                           what keeps a check that runs on
//                                           every argument of every call safe
//   -4 a raw annotation binds             — the type arguments, not the
//                                           collection, are what make the
//                                           difference
//
// A "throw whenever a generic parameter meets a collection" shortcut passes -1
// and fails -2, -3 and -4. A check that compared arguments by name rather than
// by subtyping passes all four here and fails the reference tree's covariance
// case (F-SCD92-4).

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// The bundle for `Object? main() => f(<elements>);` where `f` takes a single
/// parameter written `List<typeArgument>` — or a raw `List` when
/// [typeArgument] is null — and returns it.
AstBundle appliedParameterBundle({
  required String? typeArgument,
  required List<SExpression> elements,
}) {
  const entry = 'package:probe/main.dart';
  SSimpleIdentifier id(String name) =>
      SSimpleIdentifier(offset: 0, length: 0, name: name);

  final listType = SNamedType(
    offset: 0,
    length: 0,
    name: id('List'),
    typeArguments: typeArgument == null
        ? null
        : STypeArgumentList(
            offset: 0,
            length: 0,
            arguments: [
              SNamedType(offset: 0, length: 0, name: id(typeArgument)),
            ],
          ),
  );

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
            name: id('f'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: SFormalParameterList(
                offset: 0,
                length: 0,
                parameters: [
                  SSimpleFormalParameter(
                    offset: 0,
                    length: 0,
                    name: id('xs'),
                    isRequired: true,
                    type: listType,
                  ),
                ],
              ),
              body: SExpressionFunctionBody(
                offset: 0,
                length: 0,
                expression: id('xs'),
              ),
            ),
          ),
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
              body: SExpressionFunctionBody(
                offset: 0,
                length: 0,
                expression: SMethodInvocation(
                  offset: 0,
                  length: 0,
                  methodName: id('f'),
                  argumentList: SArgumentList(
                    offset: 0,
                    length: 0,
                    arguments: [
                      SListLiteral(offset: 0, length: 0, elements: elements),
                    ],
                  ),
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

void main() {
  Object? run(String? typeArgument, List<SExpression> elements) =>
      D4rtRunner().executeBundleAs<Object?>(
        appliedParameterBundle(typeArgument: typeArgument, elements: elements),
      );

  group('SCD92/AST: declared type arguments are checked at binding', () {
    test('F-SCD92-AST-1: a mismatched element type raises TypeError '
        '[2026-09-14] (PASS)', () {
      expect(
        () => run('String', [intLit(1)]),
        throwsA(
          isA<TypeError>().having(
            (e) => e.toString(),
            'message',
            "type 'List<int>' is not a subtype of type 'List<String>' of 'xs'",
          ),
        ),
      );
    });

    test(
      'F-SCD92-AST-2: a matching element type binds [2026-09-14] (PASS)',
      () {
        expect(run('String', [strLit('a')]), ['a']);
        expect(run('int', [intLit(1)]), [1]);
      },
    );

    test('F-SCD92-AST-3: an empty collection stays permissive '
        '[2026-09-14] (PASS)', () {
      // No element to read a type from. A check that guessed here would reject
      // `f([])`, which is a correct program.
      expect(run('String', const []), isEmpty);
    });

    test('F-SCD92-AST-4: a raw annotation admits anything '
        '[2026-09-14] (PASS)', () {
      // Same bundle, same argument — only the type arguments are removed. This
      // is what says the check keys off the written arguments rather than
      // firing on every collection parameter.
      expect(run(null, [intLit(1)]), [1]);
    });
  });
}
