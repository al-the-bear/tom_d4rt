// SCF25/AST — the analyzer-free twin of
// `tom_d4rt/test/scf25_bare_accessor_test.dart`.
//
// A getter and a setter of one name were both bound under the plain name, so
// the second replaced the first; a bare read of a getter returned the getter
// function, and a bare write rebound the name and never called the setter.
// A setter is now bound under `v=`. These run the working tree of this
// interpreter, which exec cannot (DGUC6), so the bundle is built by hand:
//
//     int _x = 0;
//     int get v => _x;
//     set v(int n) { _x = n * 10; }
//     main() { <statements> }

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _int() => SNamedType(offset: 0, length: 0, name: _id('int'));

SIntegerLiteral _lit(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SFormalParameterList _params([List<SFormalParameter> ps = const []]) =>
    SFormalParameterList(offset: 0, length: 0, parameters: ps);

SExpressionStatement _stmt(SExpression e) =>
    SExpressionStatement(offset: 0, length: 0, expression: e);

SAssignmentExpression _assign(String name, SExpression value) =>
    SAssignmentExpression(
      offset: 0,
      length: 0,
      leftHandSide: _id(name),
      operator: '=',
      rightHandSide: value,
    );

SFunctionDeclaration _fn(
  String name,
  SFunctionBody body, {
  bool isGetter = false,
  bool isSetter = false,
  SFormalParameterList? params,
}) => SFunctionDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  isGetter: isGetter,
  isSetter: isSetter,
  functionExpression: SFunctionExpression(
    offset: 0,
    length: 0,
    parameters: isGetter ? null : (params ?? _params()),
    body: body,
  ),
);

Object? _run(List<SStatement> mainBody) {
  const entry = 'package:probe/main.dart';
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
                type: _int(),
                variables: [
                  SVariableDeclaration(
                    offset: 0,
                    length: 0,
                    name: _id('_x'),
                    initializer: _lit(0),
                  ),
                ],
              ),
            ),
            _fn(
              'v',
              SExpressionFunctionBody(
                offset: 0,
                length: 0,
                expression: _id('_x'),
              ),
              isGetter: true,
            ),
            _fn(
              'v',
              SBlockFunctionBody(
                offset: 0,
                length: 0,
                block: SBlock(
                  offset: 0,
                  length: 0,
                  statements: [
                    _stmt(
                      _assign(
                        '_x',
                        SBinaryExpression(
                          offset: 0,
                          length: 0,
                          leftOperand: _id('n'),
                          operator: '*',
                          rightOperand: _lit(10),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              isSetter: true,
              params: _params([
                SSimpleFormalParameter(
                  offset: 0,
                  length: 0,
                  type: _int(),
                  name: _id('n'),
                  isRequired: true,
                ),
              ]),
            ),
            _fn(
              'main',
              SBlockFunctionBody(
                offset: 0,
                length: 0,
                block: SBlock(offset: 0, length: 0, statements: mainBody),
              ),
            ),
          ],
        ),
      },
    ),
  );
}

SReturnStatement _return(SExpression e) =>
    SReturnStatement(offset: 0, length: 0, expression: e);

void main() {
  group('SCF25/AST: bare accessors are called, not rebound', () {
    test('F-SCF25-AST-1: a bare write calls the setter and a bare read the '
        'getter of one name [2026-09-29] (PASS)', () {
      expect(_run([_stmt(_assign('v', _lit(2))), _return(_id('v'))]), 20);
    });

    test('F-SCF25-AST-2: the write reached the setter, not a rebinding '
        '[2026-09-29] (PASS)', () {
      expect(_run([_stmt(_assign('v', _lit(3))), _return(_id('_x'))]), 30);
    });

    test('F-SCF25-AST-3 (rail): a local of the same name shadows the pair '
        '[2026-09-29] (PASS)', () {
      expect(
        _run([
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
                  name: _id('v'),
                  initializer: _lit(1),
                ),
              ],
            ),
          ),
          _stmt(_assign('v', _lit(2))),
          _return(
            SBinaryExpression(
              offset: 0,
              length: 0,
              leftOperand: _id('v'),
              operator: '+',
              rightOperand: _id('_x'),
            ),
          ),
        ]),
        2,
      );
    });
  });
}
