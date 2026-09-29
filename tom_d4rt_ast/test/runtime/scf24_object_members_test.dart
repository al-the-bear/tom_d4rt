// SCF24/AST — the analyzer-free twin of
// `tom_d4rt/test/scf24_object_members_test.dart`.
//
// A script class that declares no `toString` still inherits `Object`'s: an
// explicit `C().toString()` raised a no-such-method error, and so did
// `super.toString()` from a class whose superclass is `Object`. These run the
// working tree of this interpreter, which exec cannot (DGUC6), so the bundles
// are built from `SAstNode`s by hand.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SArgumentList _args([List<SExpression> arguments = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: arguments);

SFormalParameterList _noParams() =>
    SFormalParameterList(offset: 0, length: 0, parameters: const []);

SMethodInvocation _call(SExpression? target, String method) =>
    SMethodInvocation(
      offset: 0,
      length: 0,
      target: target,
      operator: target == null ? null : '.',
      methodName: _id(method),
      argumentList: _args(),
    );

/// `class C { [String toString() => <body>;] }`
SClassDeclaration _class({SExpression? toStringBody}) => SClassDeclaration(
  offset: 0,
  length: 0,
  name: _id('C'),
  members: [
    if (toStringBody != null)
      SMethodDeclaration(
        offset: 0,
        length: 0,
        name: _id('toString'),
        returnType: SNamedType(offset: 0, length: 0, name: _id('String')),
        parameters: _noParams(),
        body: SExpressionFunctionBody(
          offset: 0,
          length: 0,
          expression: toStringBody,
        ),
      ),
  ],
);

/// `main() => C().toString();`
Object? _run(SClassDeclaration klass) {
  const entry = 'package:probe/main.dart';
  return D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            klass,
            SFunctionDeclaration(
              offset: 0,
              length: 0,
              name: _id('main'),
              functionExpression: SFunctionExpression(
                offset: 0,
                length: 0,
                parameters: _noParams(),
                body: SExpressionFunctionBody(
                  offset: 0,
                  length: 0,
                  expression: _call(_call(null, 'C'), 'toString'),
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
  group('SCF24/AST: Object members on a script class that declares none', () {
    test('F-SCF24-AST-1: `C().toString()` renders the default '
        '[2026-09-29] (PASS)', () {
      expect(_run(_class()), '<instance of C>');
    });

    test('F-SCF24-AST-2: `super.toString()` from a class whose superclass is '
        '`Object` [2026-09-29] (PASS)', () {
      expect(
        _run(
          _class(
            toStringBody: SBinaryExpression(
              offset: 0,
              length: 0,
              leftOperand: SSimpleStringLiteral(
                offset: 0,
                length: 2,
                value: 'C:',
              ),
              operator: '+',
              rightOperand: _call(
                SSuperExpression(offset: 0, length: 0),
                'toString',
              ),
            ),
          ),
        ),
        'C:<instance of C>',
      );
    });

    test('F-SCF24-AST-3 (rail): a declared `toString` still wins '
        '[2026-09-29] (PASS)', () {
      expect(
        _run(
          _class(
            toStringBody: SSimpleStringLiteral(
              offset: 0,
              length: 4,
              value: 'mine',
            ),
          ),
        ),
        'mine',
      );
    });
  });
}
