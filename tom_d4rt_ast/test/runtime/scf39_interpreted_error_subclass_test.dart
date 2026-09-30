// SCF39/AST — the analyzer-free twin of
// `tom_d4rt/test/scf39_interpreted_error_subclass_test.dart`.
//
// An interpreted `Error` subclass answered `toString` and `stackTrace` from
// the native `Error` it is built on: `MyError().toString()` printed
// `Instance of 'Error'`, and `stackTrace` stayed null after a throw. It now
// renders as the script class and records a stack trace on its first throw.
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

SArgumentList _args([List<SExpression> a = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

SMethodInvocation _call(
  SExpression? target,
  String method, [
  List<SExpression> a = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(method),
  argumentList: _args(a),
);

SPrefixedIdentifier _get(String target, String name) => SPrefixedIdentifier(
  offset: 0,
  length: 0,
  prefix: _id(target),
  identifier: _id(name),
);

SExpression _eqNull(SExpression e, {bool not = false}) => SBinaryExpression(
  offset: 0,
  length: 0,
  leftOperand: e,
  operator: not ? '!=' : '==',
  rightOperand: SNullLiteral(offset: 0, length: 0),
);

SStatement _final(String name, SExpression init) =>
    SVariableDeclarationStatement(
      offset: 0,
      length: 0,
      variables: SVariableDeclarationList(
        offset: 0,
        length: 0,
        isFinal: true,
        variables: [
          SVariableDeclaration(
            offset: 0,
            length: 0,
            name: _id(name),
            initializer: init,
          ),
        ],
      ),
    );

SBlock _block(List<SStatement> s) =>
    SBlock(offset: 0, length: 0, statements: s);

/// `try { throw e; } catch (_) {}`
SStatement _throwAndCatch() => STryStatement(
  offset: 0,
  length: 0,
  body: _block([
    SExpressionStatement(
      offset: 0,
      length: 0,
      expression: SThrowExpression(offset: 0, length: 0, expression: _id('e')),
    ),
  ]),
  catchClauses: [
    SCatchClause(
      offset: 0,
      length: 0,
      exceptionParameter: _id('_'),
      body: _block(const []),
    ),
  ],
);

/// `class <name> extends <superclass> { <members> }`
SClassDeclaration _class(
  String name,
  String superclass, [
  List<SClassMember> members = const [],
]) => SClassDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  extendsClause: SExtendsClause(
    offset: 0,
    length: 0,
    superclass: _type(superclass),
  ),
  members: members,
);

/// `String toString() => <body>;`
SMethodDeclaration _toString(SExpression body) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id('toString'),
  returnType: _type('String'),
  parameters: SFormalParameterList(offset: 0, length: 0),
  body: SExpressionFunctionBody(offset: 0, length: 0, expression: body),
);

/// Runs `main() { final e = <errorClass>(); <statements> }` with [classes]
/// declared.
Object? _run(
  List<SClassDeclaration> classes,
  String errorClass,
  List<SStatement> statements,
) {
  const entry = 'package:probe/main.dart';
  final bundle = AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [
          ...classes,
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: SFormalParameterList(offset: 0, length: 0),
              body: SBlockFunctionBody(
                offset: 0,
                length: 0,
                block: _block([
                  _final('e', _call(null, errorClass)),
                  ...statements,
                ]),
              ),
            ),
          ),
        ],
      ),
    },
  );
  return D4rtRunner().executeBundle(bundle);
}

SStatement _return(List<SExpression> elements) => SReturnStatement(
  offset: 0,
  length: 0,
  expression: SListLiteral(offset: 0, length: 0, elements: elements),
);

void main() {
  group('SCF39/AST: an interpreted Error subclass', () {
    test('F-SCF39-AST-1: no override renders as the script class '
        '[2026-09-30] (PASS)', () {
      expect(
        _run(
          [_class('MyError', 'Error')],
          'MyError',
          [
            _return([
              _call(_id('e'), 'toString'),
              _call(
                SListLiteral(offset: 0, length: 0, elements: [_id('e')]),
                'toString',
              ),
            ]),
          ],
        ),
        ['<instance of MyError>', '[<instance of MyError>]'],
      );
    });

    test('F-SCF39-AST-2: an override wins, and super.toString() names the '
        'script class [2026-09-30] (PASS)', () {
      expect(
        _run(
          [
            _class('MyError', 'Error', [
              _toString(
                SBinaryExpression(
                  offset: 0,
                  length: 0,
                  leftOperand: SSimpleStringLiteral(
                    offset: 0,
                    length: 0,
                    value: 'X:',
                  ),
                  operator: '+',
                  rightOperand: _call(
                    SSuperExpression(offset: 0, length: 0),
                    'toString',
                  ),
                ),
              ),
            ]),
          ],
          'MyError',
          [
            _return([_call(_id('e'), 'toString')]),
          ],
        ),
        ['X:<instance of MyError>'],
      );
    });

    test('F-SCF39-AST-3: a super-object that overrides toString is the '
        'answer [2026-09-30] (PASS)', () {
      expect(
        _run(
          [_class('ArgErr', 'ArgumentError')],
          'ArgErr',
          [
            _return([
              _call(_id('e'), 'toString'),
              _call(
                SListLiteral(offset: 0, length: 0, elements: [_id('e')]),
                'toString',
              ),
            ]),
          ],
        ),
        ['Invalid argument(s)', '[Invalid argument(s)]'],
      );
    });

    test('F-SCF39-AST-4: stackTrace is null before a throw, set by it, and '
        'kept by a second throw [2026-09-30] (PASS)', () {
      expect(
        _run(
          [_class('MyError', 'Error')],
          'MyError',
          [
            _final('before', _get('e', 'stackTrace')),
            _throwAndCatch(),
            _final('first', _get('e', 'stackTrace')),
            _throwAndCatch(),
            _return([
              _eqNull(_id('before')),
              _eqNull(_id('first'), not: true),
              _call(null, 'identical', [_id('first'), _get('e', 'stackTrace')]),
            ]),
          ],
        ),
        [true, true, true],
      );
    });
  });
}
