// SCF19/AST — the analyzer-free twin of
// `tom_d4rt/test/scf19_inherited_bridged_member_test.dart`.
//
// An interpreted class extending a bridged class reached the members that
// class's bridge DECLARES and none it inherits: `class MyQ extends ListQueue`
// had `removeFirst` but no `elementAt`, `first` or `map`, whether reached as
// `q.elementAt`, bare `elementAt` inside a method, or `super.elementAt`. A
// bridge carries only its declared members; a bare `ListQueue` instance finds
// `Iterable.elementAt` through the visitor's supertype walk, and the bridged
// superclass path had no such walk. `BridgedClass.findReachable*Adapter` is
// that walk, used wherever an interpreted instance consults its bridged
// superclass.
//
// These run against the WORKING TREE of this interpreter, which the exec
// suites cannot (DGUC6), so the bundles are built from `SAstNode`s by hand.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SArgumentList _args([List<SExpression> arguments = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: arguments);

SFormalParameterList _noParams() =>
    SFormalParameterList(offset: 0, length: 0, parameters: const []);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SMethodInvocation _call(
  SExpression? target,
  String method, [
  List<SExpression> args = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(method),
  argumentList: _args(args),
);

SMethodDeclaration _method(String name, SExpression body) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  parameters: _noParams(),
  body: SExpressionFunctionBody(offset: 0, length: 0, expression: body),
);

/// ```
/// class MyQ extends ListQueue {
///   bare() => elementAt(0);
///   viaSuper() => super.elementAt(0);
///   declared() => super.removeFirst();
/// }
/// ```
SClassDeclaration _myQ() => SClassDeclaration(
  offset: 0,
  length: 0,
  name: _id('MyQ'),
  extendsClause: SExtendsClause(
    offset: 0,
    length: 0,
    superclass: _type('ListQueue'),
  ),
  members: [
    _method('bare', _call(null, 'elementAt', [_int(0)])),
    _method(
      'viaSuper',
      _call(SSuperExpression(offset: 0, length: 0), 'elementAt', [_int(0)]),
    ),
    _method(
      'declared',
      _call(SSuperExpression(offset: 0, length: 0), 'removeFirst'),
    ),
  ],
);

/// `main() { var q = MyQ(); q.addLast(7); return <result>; }`
AstBundle _bundle(SExpression result) {
  const entry = 'package:probe/main.dart';
  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [
          SImportDirective(
            offset: 0,
            length: 0,
            uri: SSimpleStringLiteral(
              offset: 0,
              length: 0,
              value: 'dart:collection',
            ),
          ),
        ],
        declarations: [
          _myQ(),
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: _noParams(),
              body: SBlockFunctionBody(
                offset: 0,
                length: 0,
                block: SBlock(
                  offset: 0,
                  length: 0,
                  statements: [
                    SVariableDeclarationStatement(
                      offset: 0,
                      length: 0,
                      variables: SVariableDeclarationList(
                        offset: 0,
                        length: 0,
                        variables: [
                          SVariableDeclaration(
                            offset: 0,
                            length: 0,
                            name: _id('q'),
                            // `MyQ()` with no `new` parses as a method invocation, and the
                            // converter keeps that shape.
                            initializer: _call(null, 'MyQ'),
                          ),
                        ],
                      ),
                    ),
                    SExpressionStatement(
                      offset: 0,
                      length: 0,
                      expression: _call(_id('q'), 'addLast', [_int(7)]),
                    ),
                    SReturnStatement(offset: 0, length: 0, expression: result),
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

Object? _run(SExpression result) => D4rtRunner().executeBundle(_bundle(result));

void main() {
  group(
    'SCF19/AST: an interpreted subclass reaches inherited bridged members',
    () {
      test(
        'F-SCF19-AST-1: `q.elementAt(0)` on the subclass [2026-09-29] (PASS)',
        () {
          expect(_run(_call(_id('q'), 'elementAt', [_int(0)])), 7);
        },
      );

      test('F-SCF19-AST-2: bare `elementAt(0)` inside a method '
          '[2026-09-29] (PASS)', () {
        expect(_run(_call(_id('q'), 'bare')), 7);
      });

      test('F-SCF19-AST-3: `super.elementAt(0)` [2026-09-29] (PASS)', () {
        expect(_run(_call(_id('q'), 'viaSuper')), 7);
      });

      test('F-SCF19-AST-4: an inherited getter, `q.first` '
          '[2026-09-29] (PASS)', () {
        expect(
          _run(
            SPrefixedIdentifier(
              offset: 0,
              length: 0,
              prefix: _id('q'),
              identifier: _id('first'),
            ),
          ),
          7,
        );
      });

      test('F-SCF19-AST-5: a DECLARED member still resolves, '
          '`super.removeFirst()` [2026-09-29] (PASS)', () {
        // The control: this worked before, through the bridge's own map, and
        // the walk must not have displaced it.
        expect(_run(_call(_id('q'), 'declared')), 7);
      });
    },
  );
}
