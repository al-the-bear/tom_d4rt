// SCF29/AST — the analyzer-free twin of
// `tom_d4rt/test/scf29_await_resumption_routes_test.dart`.
//
// Four await-resumption routes double-evaluated a site or dropped one: an
// `=>` body whose invocation held two awaits (Q), an `if` condition (R), a
// `while` condition (S), and an assignment whose right-hand side held two
// (T). Each now hands its unit back to the state machine so the resolved
// sites replay. `next()` pops from `[1, 2, 4, 8]` — powers of two, so the sum
// of two awaited values names which entries were taken, and a doubled
// evaluation shows up as a wrong VALUE, not only as a wrong count.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String name) =>
    SSimpleIdentifier(offset: 0, length: name.length, name: name);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SVariableDeclarationStatement _declare(String name, SExpression init) =>
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

/// `await next()`, each site at its own offset as a real parse would give.
SAwaitExpression _awaitNext(int offset) => SAwaitExpression(
  offset: offset,
  length: 12,
  expression: SMethodInvocation(
    offset: offset,
    length: 6,
    methodName: _id('next'),
    argumentList: SArgumentList(offset: 0, length: 0),
  ),
);

SMethodInvocation _add(SExpression a, SExpression b) => SMethodInvocation(
  offset: 0,
  length: 0,
  methodName: _id('add'),
  argumentList: SArgumentList(offset: 0, length: 0, arguments: [a, b]),
);

SBinaryExpression _bin(SExpression l, String op, SExpression r) =>
    SBinaryExpression(
      offset: 0,
      length: 0,
      leftOperand: l,
      operator: op,
      rightOperand: r,
    );

SReturnStatement _return(SExpression e) =>
    SReturnStatement(offset: 0, length: 0, expression: e);

SBlock _block(List<SStatement> statements) =>
    SBlock(offset: 0, length: 0, statements: statements);

SFunctionDeclarationStatement _localFn(
  String name,
  List<String> params,
  SFunctionBody body,
) => SFunctionDeclarationStatement(
  offset: 0,
  length: 0,
  functionDeclaration: SFunctionDeclaration(
    offset: 0,
    length: 0,
    name: _id(name),
    functionExpression: SFunctionExpression(
      offset: 0,
      length: 0,
      parameters: SFormalParameterList(
        offset: 0,
        length: 0,
        parameters: [
          for (final p in params)
            SSimpleFormalParameter(offset: 0, length: 0, name: _id(p)),
        ],
      ),
      body: body,
    ),
  ),
);

/// `var q = [1, 2, 4, 8]; next() async => q.removeAt(0);
/// int add(a, b) => a + b;` then [statements], in an async `main`.
Future<Object?> _run(List<SStatement> statements) {
  const entry = 'package:t/main.dart';
  return D4rtRunner().executeBundleAsAsync<Object?>(
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
                  block: _block([
                    _declare(
                      'q',
                      SListLiteral(
                        offset: 0,
                        length: 0,
                        elements: [
                          for (final v in [1, 2, 4, 8]) _int(v),
                        ],
                      ),
                    ),
                    _localFn(
                      'next',
                      const [],
                      SBlockFunctionBody(
                        offset: 0,
                        length: 0,
                        isAsync: true,
                        block: _block([
                          _return(
                            SMethodInvocation(
                              offset: 0,
                              length: 0,
                              target: _id('q'),
                              operator: '.',
                              methodName: _id('removeAt'),
                              argumentList: SArgumentList(
                                offset: 0,
                                length: 0,
                                arguments: [_int(0)],
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                    _localFn(
                      'add',
                      const ['a', 'b'],
                      SExpressionFunctionBody(
                        offset: 0,
                        length: 0,
                        expression: _bin(_id('a'), '+', _id('b')),
                      ),
                    ),
                    ...statements,
                  ]),
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
  group('SCF29/AST: the four routes resume without re-evaluating', () {
    test('F-SCF29-AST-1 (Q): an `=>` body whose invocation holds two awaits '
        '[2026-09-29] (PASS)', () async {
      // Future<int> f() async => add(await next(), await next());
      // return await f();                                  -> 1 + 2
      expect(
        await _run([
          _localFn(
            'f',
            const [],
            SExpressionFunctionBody(
              offset: 0,
              length: 0,
              isAsync: true,
              expression: _add(_awaitNext(100), _awaitNext(200)),
            ),
          ),
          _return(
            SAwaitExpression(
              offset: 300,
              length: 9,
              expression: SMethodInvocation(
                offset: 300,
                length: 3,
                methodName: _id('f'),
                argumentList: SArgumentList(offset: 0, length: 0),
              ),
            ),
          ),
        ]),
        3,
      );
    });

    test('F-SCF29-AST-2 (R): an `if` condition whose invocation holds two '
        'awaits [2026-09-29] (PASS)', () async {
      // if (add(await next(), await next()) == 3) return 1; return 0;
      expect(
        await _run([
          SIfStatement(
            offset: 0,
            length: 0,
            condition: _bin(
              _add(_awaitNext(400), _awaitNext(500)),
              '==',
              _int(3),
            ),
            thenStatement: _return(_int(1)),
          ),
          _return(_int(0)),
        ]),
        1,
      );
    });

    test('F-SCF29-AST-3 (S): a `while` condition whose invocation holds an '
        'await [2026-09-29] (PASS)', () async {
      // var n = 0; while (add(await next(), 0) < 2) { n = n + 1; } return n;
      // 1 < 2 runs the body once; 2 < 2 ends the loop.
      expect(
        await _run([
          _declare('n', _int(0)),
          SWhileStatement(
            offset: 0,
            length: 0,
            condition: _bin(_add(_awaitNext(600), _int(0)), '<', _int(2)),
            body: _block([
              SExpressionStatement(
                offset: 0,
                length: 0,
                expression: SAssignmentExpression(
                  offset: 0,
                  length: 0,
                  leftHandSide: _id('n'),
                  operator: '=',
                  rightHandSide: _bin(_id('n'), '+', _int(1)),
                ),
              ),
            ]),
          ),
          _return(_id('n')),
        ]),
        1,
      );
    });

    test('F-SCF29-AST-4 (T): an assignment whose RHS holds two awaits '
        '[2026-09-29] (PASS)', () async {
      // var s = 0; s = (await next()) + (await next()); return s;  -> 1 + 2
      expect(
        await _run([
          _declare('s', _int(0)),
          SExpressionStatement(
            offset: 0,
            length: 0,
            expression: SAssignmentExpression(
              offset: 0,
              length: 0,
              leftHandSide: _id('s'),
              operator: '=',
              rightHandSide: _bin(_awaitNext(700), '+', _awaitNext(800)),
            ),
          ),
          _return(_id('s')),
        ]),
        3,
      );
    });
  });
}
