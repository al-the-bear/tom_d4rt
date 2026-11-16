// ghissues62/AST — an `await` inside an expression or statement form that did
// not hand its suspension up, in the analyzer-free tree.
//
// The mirror of `tom_d4rt/test/ghissues62_await_propagation_test.dart`,
// which runs every form as source against what native Dart answers. Here each
// case is a hand-built bundle: `Future<int> n() async { return 3; }`,
// `Future<bool> t() async { return true; }` and an async `main`.
//
// Measured 2026-11-16 in both trees (identical): `(await n()) is int`
// answered false, `as` cast the interpreter's own AsyncSuspensionRequest, a
// conditional / switch / record used it as a value; a switch statement, an
// `assert`, a pattern declaration and a `throw` had no resumption at all (the
// function completed with null, or a `for` condition and `throw` spun for
// ever); and an if-case in an async function failed even without an await
// ("If condition must evaluate to a boolean, but got int").

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SBlock _block(List<SStatement> statements) =>
    SBlock(offset: 0, length: 0, statements: statements);

SReturnStatement _return(SExpression e) =>
    SReturnStatement(offset: 0, length: 0, expression: e);

SParenthesizedExpression _paren(SExpression e) =>
    SParenthesizedExpression(offset: 0, length: 0, expression: e);

var _nextOffset = 100;

/// `await <name>()`, each site at its own offset as a real parse gives it.
SAwaitExpression _await(String name) {
  final offset = _nextOffset += 20;
  return SAwaitExpression(
    offset: offset,
    length: 12,
    expression: SMethodInvocation(
      offset: offset + 6,
      length: 6,
      methodName: _id(name),
      argumentList: SArgumentList(offset: 0, length: 0),
    ),
  );
}

/// `[async] <name>() { <statements> }`
SFunctionDeclaration _function(
  String name,
  List<SStatement> statements, {
  bool isAsync = true,
}) => SFunctionDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  functionExpression: SFunctionExpression(
    offset: 0,
    length: 0,
    parameters: SFormalParameterList(offset: 0, length: 0),
    body: SBlockFunctionBody(
      offset: 0,
      length: 0,
      isAsync: isAsync,
      block: _block(statements),
    ),
  ),
);

/// Runs `main() async { <statements> }` beside `n()` (3), `t()` (true) and
/// `rec()` ((1, 2)), and awaits its result.
Future<Object?> _run(List<SStatement> statements) async {
  const entry = 'package:p/main.dart';
  final result = D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            _function('n', [_return(_int(3))]),
            _function('t', [
              _return(SBooleanLiteral(offset: 0, length: 4, value: true)),
            ]),
            _function('rec', [
              _return(
                SRecordLiteral(
                  offset: 0,
                  length: 0,
                  fields: [_int(1), _int(2)],
                ),
              ),
            ]),
            _function('main', statements),
          ],
        ),
      },
    ),
  );
  return result is Future ? await result : result;
}

SGuardedPattern _guarded(SDartPattern pattern) =>
    SGuardedPattern(offset: 0, length: 0, pattern: pattern);

SDeclaredVariablePattern _declared(String name, [String? type]) =>
    SDeclaredVariablePattern(
      offset: 0,
      length: 0,
      keyword: type == null ? 'var' : null,
      name: name,
      type: type == null ? null : _type(type),
    );

void main() {
  group('ghissues62/AST: expressions hand an await up', () {
    test('GHI62-AST-1: is, as and a conditional [2026-11-16]', () async {
      expect(
        await _run([
          _return(
            SIsExpression(
              offset: 0,
              length: 0,
              expression: _paren(_await('n')),
              type: _type('int'),
            ),
          ),
        ]),
        isTrue,
      );
      expect(
        await _run([
          _return(
            SAsExpression(
              offset: 0,
              length: 0,
              expression: _paren(_await('n')),
              type: _type('int'),
            ),
          ),
        ]),
        3,
      );
      expect(
        await _run([
          _return(
            SConditionalExpression(
              offset: 0,
              length: 0,
              condition: _paren(_await('t')),
              thenExpression: _str('y'),
              elseExpression: _str('n'),
            ),
          ),
        ]),
        'y',
      );
    });

    test('GHI62-AST-2: a switch expression and a record literal '
        '[2026-11-16]', () async {
      expect(
        await _run([
          _return(
            SSwitchExpression(
              offset: 0,
              length: 0,
              expression: _await('n'),
              cases: [
                SSwitchExpressionCase(
                  offset: 0,
                  length: 0,
                  guardedPattern: _guarded(
                    SConstantPattern(offset: 0, length: 0, expression: _int(3)),
                  ),
                  expression: _str('three'),
                ),
                SSwitchExpressionCase(
                  offset: 0,
                  length: 0,
                  guardedPattern: _guarded(
                    SWildcardPattern(offset: 0, length: 0, name: '_'),
                  ),
                  expression: _str('other'),
                ),
              ],
            ),
          ),
        ]),
        'three',
      );
      expect(
        (await _run([
          _return(
            SRecordLiteral(
              offset: 0,
              length: 0,
              fields: [_paren(_await('n')), _int(1)],
            ),
          ),
        ])).toString(),
        '(3, 1)',
      );
    });
  });

  group('ghissues62/AST: statements are resumed', () {
    test('GHI62-AST-3: an if-case - with and without an await '
        '[2026-11-16]', () async {
      SIfStatement ifCase(SExpression scrutinee) => SIfStatement(
        offset: 0,
        length: 0,
        condition: scrutinee,
        caseClause: SCaseClause(
          offset: 0,
          length: 0,
          guardedPattern: _guarded(_declared('x', 'int')),
        ),
        thenStatement: _return(_id('x')),
      );
      expect(await _run([ifCase(_int(3)), _return(_int(-1))]), 3);
      expect(await _run([ifCase(_str('s')), _return(_int(-1))]), -1);
      expect(await _run([ifCase(_paren(_await('n'))), _return(_int(-1))]), 3);
    });

    test('GHI62-AST-4: a switch statement\'s scrutinee [2026-11-16]', () async {
      expect(
        await _run([
          SSwitchStatement(
            offset: 0,
            length: 0,
            expression: _await('n'),
            members: [
              SSwitchCase(
                offset: 0,
                length: 0,
                expression: _int(3),
                statements: [_return(_str('three'))],
              ),
              SSwitchDefault(
                offset: 0,
                length: 0,
                statements: [_return(_str('other'))],
              ),
            ],
          ),
        ]),
        'three',
      );
    });

    test('GHI62-AST-5: a pattern declaration, an assert and a throw '
        '[2026-11-16]', () async {
      expect(
        await _run([
          SPatternVariableDeclarationStatement(
            offset: 0,
            length: 0,
            declaration: SPatternVariableDeclaration(
              offset: 0,
              length: 0,
              keyword: 'var',
              pattern: SRecordPattern(
                offset: 0,
                length: 0,
                fields: [
                  SPatternField(offset: 0, length: 0, pattern: _declared('a')),
                  SPatternField(offset: 0, length: 0, pattern: _declared('b')),
                ],
              ),
              expression: _await('rec'),
            ),
          ),
          _return(
            SBinaryExpression(
              offset: 0,
              length: 0,
              leftOperand: _id('a'),
              operator: '+',
              rightOperand: _id('b'),
            ),
          ),
        ]),
        3,
      );
      expect(
        await _run([
          SAssertStatement(offset: 0, length: 0, condition: _await('t')),
          _return(_str('ok')),
        ]),
        'ok',
      );
      expect(
        await _run([
          STryStatement(
            offset: 0,
            length: 0,
            body: _block([
              SExpressionStatement(
                offset: 0,
                length: 0,
                expression: SThrowExpression(
                  offset: 0,
                  length: 0,
                  expression: _await('n'),
                ),
              ),
            ]),
            catchClauses: [
              SCatchClause(
                offset: 0,
                length: 0,
                exceptionParameter: _id('e'),
                body: _block([_return(_id('e'))]),
              ),
            ],
          ),
        ]).timeout(const Duration(seconds: 20)),
        3,
      );
    });

    test('GHI62-AST-6: a for condition is evaluated again, not spun on '
        '[2026-11-16]', () async {
      // var i = 0; for (; i < (await n()); i++) {} return i;
      expect(
        await _run([
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
                  name: _id('i'),
                  initializer: _int(0),
                ),
              ],
            ),
          ),
          SForStatement(
            offset: 0,
            length: 0,
            forLoopParts: SForPartsWithExpression(
              offset: 0,
              length: 0,
              condition: SBinaryExpression(
                offset: 0,
                length: 0,
                leftOperand: _id('i'),
                operator: '<',
                rightOperand: _paren(_await('n')),
              ),
              updaters: [
                SPostfixExpression(
                  offset: 0,
                  length: 0,
                  operand: _id('i'),
                  operator: '++',
                ),
              ],
            ),
            body: _block([]),
          ),
          _return(_id('i')),
        ]).timeout(const Duration(seconds: 20)),
        3,
      );
    });
  });
}
