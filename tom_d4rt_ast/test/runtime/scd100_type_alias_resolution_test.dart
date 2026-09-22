// SCD100/AST — a type alias means its target in the analyzer-free tree too.
//
// The mirror of `tom_d4rt/test/scd100_type_alias_resolution_test.dart`, which
// carries the measurement (nineteen probed shapes: seven legal programs that
// THREW, three that accepted silently what Dart rejects, nine already fine) and
// the reasoning. The registration lives in shared interpreter code, so the
// reference tree's evidence says nothing about this line on its own.
//
// The three cases are the minimum that cannot pass by accident:
//
//   -1 `is` through an alias ANSWERS instead of throwing, and answers both
//      ways — the defect. It raised `Undefined variable: I` before, so a test
//      asserting only the `true` case could be satisfied by an alias that
//      resolved to the wrong thing.
//   -2 declaration order does not matter — the fixpoint. `typedef A = B;`
//      written above `typedef B = int;` resolves on the second round; a
//      single-pass registration passes -1 and fails this.
//   -3 a non-alias program is unaffected — the control for the `as` change,
//      which resolves the written name through the environment before
//      switching on it.
//   -4 a generic BOUND written through an alias runs — sce130, the limit the
//      reference file recorded and left.
//   -5 that bound is ENFORCED, not merely skipped — the discriminator between
//      the fix and simply swallowing the resolution failure.
//   -6 a genuinely undefined bound is still reported — anti-vacuity for -5.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: 0, name: n);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

/// `typedef <alias> = <target>;`
STypedefDeclaration typedefOf(String alias, String target) =>
    STypedefDeclaration(
      offset: 0,
      length: 0,
      name: _id(alias),
      type: _type(target),
    );

/// The bundle for the given typedefs plus `Object? main() => <expression>;`
AstBundle bundleOf(List<STypedefDeclaration> typedefs, SExpression expression) {
  const entry = 'package:probe/main.dart';
  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: const [],
        declarations: [
          ...typedefs,
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
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
                expression: expression,
              ),
            ),
          ),
        ],
      ),
    },
  );
}

/// `<value> is <typeName>`
SExpression isExpr(SExpression value, String typeName) => SIsExpression(
  offset: 0,
  length: 0,
  expression: value,
  type: _type(typeName),
);

SExpression intLit(int v) => SIntegerLiteral(offset: 0, length: 0, value: v);
SExpression strLit(String v) =>
    SSimpleStringLiteral(offset: 0, length: 0, value: v);

/// The bundle for `<typedefs> T pick<T extends <bound>>(T v) => v;` plus
/// `Object? main() => pick<typeArg?>(<argument>);`.
///
/// SCE130: the shape that threw `Undefined variable: N` before the fix,
/// because a type-parameter BOUND is resolved in pass 1 and a type alias is
/// registered in pass 2.
AstBundle boundedPickBundle({
  required List<STypedefDeclaration> typedefs,
  required String bound,
  required SExpression argument,
  String? typeArgument,
}) {
  const entry = 'package:probe/main.dart';
  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: const [],
        declarations: [
          ...typedefs,
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('pick'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              typeParameters: STypeParameterList(
                offset: 0,
                length: 0,
                typeParameters: [
                  STypeParameter(
                    offset: 0,
                    length: 0,
                    name: _id('T'),
                    bound: _type(bound),
                  ),
                ],
              ),
              parameters: SFormalParameterList(
                offset: 0,
                length: 0,
                parameters: [
                  SSimpleFormalParameter(
                    offset: 0,
                    length: 0,
                    name: _id('v'),
                    isRequired: true,
                    type: _type('T'),
                  ),
                ],
              ),
              body: SExpressionFunctionBody(
                offset: 0,
                length: 0,
                expression: _id('v'),
              ),
            ),
          ),
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
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
                  methodName: _id('pick'),
                  typeArguments: typeArgument == null
                      ? null
                      : STypeArgumentList(
                          offset: 0,
                          length: 0,
                          arguments: [_type(typeArgument)],
                        ),
                  argumentList: SArgumentList(
                    offset: 0,
                    length: 0,
                    arguments: [argument],
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

void main() {
  Object? run(List<STypedefDeclaration> typedefs, SExpression e) =>
      D4rtRunner().executeBundleAs<Object?>(bundleOf(typedefs, e));

  group('SCD100/AST: a type alias resolves to its target', () {
    test('F-SCD100-AST-1: `is` through an alias answers, both ways '
        '[2026-09-14] (PASS)', () {
      // Before the fix this THREW `Undefined variable: I` rather than
      // answering. Both directions are asserted: an alias bound to the wrong
      // target would satisfy one of them.
      expect(run([typedefOf('I', 'int')], isExpr(intLit(1), 'I')), isTrue);
      expect(run([typedefOf('I', 'int')], isExpr(strLit('a'), 'I')), isFalse);
    });

    test('F-SCD100-AST-2: declaration order does not matter '
        '[2026-09-14] (PASS)', () {
      // The fixpoint: `A` names `B`, which is declared after it. A
      // single-round registration resolves `B` and leaves `A` unbound, which
      // would throw exactly as before.
      expect(
        run([
          typedefOf('A', 'B'),
          typedefOf('B', 'int'),
        ], isExpr(intLit(1), 'A')),
        isTrue,
      );
    });

    test('F-SCD100-AST-3: a non-alias program is unaffected '
        '[2026-09-14] (PASS)', () {
      // The control for the `as`-path change, which now resolves the written
      // name through the environment before switching on it. A name that is
      // not an alias resolves to its own name, so nothing moves.
      expect(run(const [], isExpr(intLit(1), 'int')), isTrue);
      expect(run(const [], isExpr(strLit('a'), 'int')), isFalse);
    });
    test('F-SCD100-AST-4: a generic BOUND written through an alias runs '
        '[2026-09-22] (PASS)', () {
      // sce130. `typedef N = num; T pick<T extends N>(T v)` threw
      // `Undefined variable: N`: bounds are resolved in pass 1 and aliases are
      // registered in pass 2, so the bound asked for a name nothing had
      // defined yet.
      expect(
        D4rtRunner().executeBundleAs<Object?>(
          boundedPickBundle(
            typedefs: [typedefOf('N', 'num')],
            bound: 'N',
            argument: intLit(3),
          ),
        ),
        3,
      );
    });

    test('F-SCD100-AST-5: the bound is ENFORCED through the alias '
        '[2026-09-22] (PASS)', () {
      // The discriminator between the fix and a retreat: simply making an
      // unresolvable bound lenient would also let -4 run. Pass 2 rebuilds the
      // function after the alias fixpoint, so the bound is real by the time
      // anything consults it.
      expect(
        () => D4rtRunner().executeBundleAs<Object?>(
          boundedPickBundle(
            typedefs: [typedefOf('N', 'num')],
            bound: 'N',
            argument: strLit('a'),
            typeArgument: 'String',
          ),
        ),
        throwsA(
          predicate(
            (Object? e) => e.toString().contains("does not satisfy bound"),
            'reports the unsatisfied bound',
          ),
        ),
      );
      // ... and a satisfying type argument still binds.
      expect(
        D4rtRunner().executeBundleAs<Object?>(
          boundedPickBundle(
            typedefs: [typedefOf('N', 'num')],
            bound: 'N',
            argument: intLit(3),
            typeArgument: 'int',
          ),
        ),
        3,
      );
    });

    test('F-SCD100-AST-6: a genuinely undefined bound is still reported '
        '[2026-09-22] (PASS)', () {
      // ANTI-VACUITY, and the reason pass 2 stays strict. `Nope` is not an
      // alias anyone forgot to register — it is not defined at all, and the
      // program must not start.
      expect(
        () => D4rtRunner().executeBundleAs<Object?>(
          boundedPickBundle(
            typedefs: const [],
            bound: 'Nope',
            argument: intLit(3),
          ),
        ),
        throwsA(
          predicate(
            (Object? e) => e.toString().contains('Nope'),
            'names the undefined bound',
          ),
        ),
      );
    });
  });
}
