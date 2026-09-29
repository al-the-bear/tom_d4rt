// SCF27/AST — the analyzer-free twin of
// `tom_d4rt/test/scf27_bounded_class_construction_test.dart`.
//
// A bounded generic class constructed without a written type argument filled
// the parameter with `dynamic` — the interpreter's "unknown" — and then
// refused it against the bound. The bound is now checked for written
// arguments only, as it already was for generic functions. These run the
// working tree of this interpreter, which exec cannot (DGUC6):
//
//     class Box<T extends num> { Box(); }
//     main() => Box<...>();   // with no argument, <int>, <String>

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

Object? _run(String? typeArg) {
  const entry = 'package:probe/main.dart';
  return D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            SClassDeclaration(
              offset: 0,
              length: 0,
              name: _id('Box'),
              typeParameters: STypeParameterList(
                offset: 0,
                length: 0,
                typeParameters: [
                  STypeParameter(
                    offset: 0,
                    length: 0,
                    name: _id('T'),
                    bound: _type('num'),
                  ),
                ],
              ),
              members: [
                SConstructorDeclaration(
                  offset: 0,
                  length: 0,
                  returnType: _id('Box'),
                  parameters: SFormalParameterList(offset: 0, length: 0),
                  body: SBlockFunctionBody(
                    offset: 0,
                    length: 0,
                    block: SBlock(offset: 0, length: 0),
                  ),
                ),
              ],
            ),
            SFunctionDeclaration(
              offset: 0,
              length: 0,
              name: _id('main'),
              functionExpression: SFunctionExpression(
                offset: 0,
                length: 0,
                parameters: SFormalParameterList(offset: 0, length: 0),
                body: SExpressionFunctionBody(
                  offset: 0,
                  length: 0,
                  expression: SIsExpression(
                    offset: 0,
                    length: 0,
                    expression: SMethodInvocation(
                      offset: 0,
                      length: 0,
                      methodName: _id('Box'),
                      typeArguments: typeArg == null
                          ? null
                          : STypeArgumentList(
                              offset: 0,
                              length: 0,
                              arguments: [_type(typeArg)],
                            ),
                      argumentList: SArgumentList(offset: 0, length: 0),
                    ),
                    type: _type('Box'),
                  ),
                ),
              ),
            ),
          ],
        ),
      },
    ),
  );
}

void main() {
  group('SCF27/AST: a bounded generic class without a written argument', () {
    test('F-SCF27-AST-1: `Box()` constructs [2026-09-29] (PASS)', () {
      expect(_run(null), isTrue);
    });

    test('F-SCF27-AST-2 (control): `Box<int>()` constructs '
        '[2026-09-29] (PASS)', () {
      expect(_run('int'), isTrue);
    });

    test('F-SCF27-AST-3 (control): `Box<String>()` is still refused '
        '[2026-09-29] (PASS)', () {
      expect(
        () => _run('String'),
        throwsA(
          predicate(
            (e) => '$e'.contains(
              "Type argument 'String' for type parameter 'T' does not "
              "satisfy bound 'num' in class 'Box'",
            ),
          ),
        ),
      );
    });
  });
}
