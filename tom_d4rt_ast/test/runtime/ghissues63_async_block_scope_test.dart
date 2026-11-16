// ghissues63/AST — in an async function a block's local variable leaked out of
// the block and overwrote an outer one of the same name, in the
// analyzer-free tree.
//
// The mirror of `tom_d4rt/test/ghissues63_async_block_scope_test.dart`, which
// runs twenty shapes as source against native Dart's output. Here each case
// is a hand-built bundle: the todo's three shapes and a `while` body that must
// be a fresh scope every iteration. The async state machine runs a block's
// statements one by one; each block it enters now gets an environment of its
// own (`_blockEnvironmentFor`), reused while it stays inside, an `await`
// included.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SBlock _block(List<SStatement> statements) =>
    SBlock(offset: 0, length: 0, statements: statements);

SReturnStatement _return(SExpression e) =>
    SReturnStatement(offset: 0, length: 0, expression: e);

var _nextOffset = 100;

/// `await null;`, each at its own offset as a real parse gives it.
SExpressionStatement _awaitNull() {
  final offset = _nextOffset += 20;
  return SExpressionStatement(
    offset: offset,
    length: 11,
    expression: SAwaitExpression(
      offset: offset,
      length: 10,
      expression: SNullLiteral(offset: offset + 6, length: 4),
    ),
  );
}

/// `var <name> [= <init>];`
SVariableDeclarationStatement _var(String name, [SExpression? init]) =>
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
            name: _id(name),
            initializer: init,
          ),
        ],
      ),
    );

SBinaryExpression _bin(SExpression l, String op, SExpression r) =>
    SBinaryExpression(
      offset: 0,
      length: 0,
      leftOperand: l,
      operator: op,
      rightOperand: r,
    );

SExpressionStatement _statement(SExpression e) =>
    SExpressionStatement(offset: 0, length: 0, expression: e);

SBooleanLiteral get _true => SBooleanLiteral(offset: 0, length: 4, value: true);

/// Runs `main() async { <statements> }` and awaits its result.
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
                  isAsync: true,
                  block: _block(statements),
                ),
              ),
            ),
          ],
        ),
      },
    ),
  );
  return result is Future ? await result : result;
}

void main() {
  group('ghissues63/AST: a block is a scope in an async function', () {
    test('GHI63-AST-1: an if block, without and with an await '
        '[2026-11-16]', () async {
      // var x = 1; if (true) { var x = 2; [await null;] } return x;
      for (final withAwait in [false, true]) {
        expect(
          await _run([
            _var('x', _int(1)),
            SIfStatement(
              offset: 0,
              length: 0,
              condition: _true,
              thenStatement: _block([
                _var('x', _int(2)),
                if (withAwait) _awaitNull(),
              ]),
            ),
            _return(_id('x')),
          ]),
          1,
          reason: withAwait ? 'with an await' : 'without an await',
        );
      }
    });

    test('GHI63-AST-2: a bare block with an await [2026-11-16]', () async {
      // var x = 1; { var x = 2; await null; } return x;
      expect(
        await _run([
          _var('x', _int(1)),
          _block([_var('x', _int(2)), _awaitNull()]),
          _return(_id('x')),
        ]),
        1,
      );
    });

    test('GHI63-AST-3: a while body is a fresh scope every iteration '
        '[2026-11-16]', () async {
      // var out = []; var i = 0;
      // while (i < 2) { var v; if (i == 0) v = 1; await null; out.add(v); i++; }
      // return out;
      expect(
        await _run([
          _var('out', SListLiteral(offset: 0, length: 0)),
          _var('i', _int(0)),
          SWhileStatement(
            offset: 0,
            length: 0,
            condition: _bin(_id('i'), '<', _int(2)),
            body: _block([
              _var('v'),
              SIfStatement(
                offset: 0,
                length: 0,
                condition: _bin(_id('i'), '==', _int(0)),
                thenStatement: _statement(
                  SAssignmentExpression(
                    offset: 0,
                    length: 0,
                    leftHandSide: _id('v'),
                    operator: '=',
                    rightHandSide: _int(1),
                  ),
                ),
              ),
              _awaitNull(),
              _statement(
                SMethodInvocation(
                  offset: 0,
                  length: 0,
                  target: _id('out'),
                  operator: '.',
                  methodName: _id('add'),
                  argumentList: SArgumentList(
                    offset: 0,
                    length: 0,
                    arguments: [_id('v')],
                  ),
                ),
              ),
              _statement(
                SPostfixExpression(
                  offset: 0,
                  length: 0,
                  operand: _id('i'),
                  operator: '++',
                ),
              ),
            ]),
          ),
          _return(_id('out')),
        ]),
        [1, null],
      );
    });
  });
}
