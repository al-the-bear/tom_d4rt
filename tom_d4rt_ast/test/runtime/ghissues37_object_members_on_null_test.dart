// GH37/AST — Object's members answer on null, as in Dart, in the
// analyzer-free tree (ghissues37).
//
// The mirror of `tom_d4rt/test/ghissues37_object_members_on_null_test.dart`,
// which runs source. Here each script is a hand-built bundle with a top-level
// `Object? v;`. Before the fix `null.toString()`, `null.hashCode`,
// `v.runtimeType` and `null.noSuchMethod(...)` threw the null error.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNullLiteral _null() => SNullLiteral(offset: 0, length: 4);

SMethodInvocation _call(
  SExpression? target,
  String name, [
  List<SExpression> args = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(name),
  argumentList: SArgumentList(offset: 0, length: 0, arguments: args),
);

SPropertyAccess _get(SExpression target, String name) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(name),
);

/// `v.<name>` - a prefixed identifier on the top-level `Object? v;`.
SPrefixedIdentifier _onV(String name) => SPrefixedIdentifier(
  offset: 0,
  length: 0,
  prefix: _id('v'),
  identifier: _id(name),
);

Object? _run(SExpression result) {
  const entry = 'package:p/main.dart';
  return D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            STopLevelVariableDeclaration(
              offset: 0,
              length: 0,
              variables: SVariableDeclarationList(
                offset: 0,
                length: 0,
                type: SNamedType(
                  offset: 0,
                  length: 0,
                  name: _id('Object'),
                  isNullable: true,
                ),
                variables: [
                  SVariableDeclaration(offset: 0, length: 0, name: _id('v')),
                ],
              ),
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
                  expression: result,
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
  group('GH37/AST: Object members on null', () {
    test('F-GH37-AST-1: toString() and hashCode on a null literal '
        '[2026-11-10]', () {
      expect(
        _run(
          SListLiteral(
            offset: 0,
            length: 0,
            elements: [_call(_null(), 'toString'), _get(_null(), 'hashCode')],
          ),
        ),
        ['null', null.hashCode],
      );
    });

    test('F-GH37-AST-2: runtimeType and hashCode on a null variable '
        '[2026-11-10]', () {
      expect(
        _run(
          SListLiteral(
            offset: 0,
            length: 0,
            elements: [_onV('runtimeType'), _onV('hashCode')],
          ),
        ),
        [null.runtimeType, null.hashCode],
      );
    });

    test('F-GH37-AST-3: noSuchMethod on null throws a NoSuchMethodError '
        '[2026-11-10]', () {
      expect(
        () => _run(
          _call(_null(), 'noSuchMethod', [
            _call(_id('Invocation'), 'method', [
              SSymbolLiteral(offset: 0, length: 2, value: 'm'),
              SListLiteral(offset: 0, length: 0, elements: const []),
            ]),
          ]),
        ),
        throwsA(isA<NoSuchMethodError>()),
      );
    });

    test('F-GH37-AST-4: every other member on null is still an error '
        '[2026-11-10]', () {
      expect(() => _run(_onV('length')), throwsA(anything));
      expect(() => _run(_call(_null(), 'foo')), throwsA(anything));
    });
  });
}
