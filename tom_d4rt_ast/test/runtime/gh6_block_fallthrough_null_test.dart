// GH6/AST — a block-bodied function that runs off its end returns null, in
// the analyzer-free tree (pull request al-the-bear/tom_d4rt#6).
//
// The mirror of `tom_d4rt/test/gh6_block_fallthrough_null_test.dart`, which
// runs source and covers every shape. Here each script is a hand-built bundle,
// so the set is the three places a body's result is decided - a sync block
// body, an async block body, and the bodies that keep their value (an
// explicit return, sync and async expression bodies).

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 2, value: v);

SMethodInvocation _call(String name) => SMethodInvocation(
  offset: 0,
  length: 0,
  methodName: _id(name),
  argumentList: SArgumentList(offset: 0, length: 0),
);

SReturnStatement _ret(SExpression e) =>
    SReturnStatement(offset: 0, length: 0, expression: e);

SExpressionStatement _stmt(SExpression e) =>
    SExpressionStatement(offset: 0, length: 0, expression: e);

SFunctionDeclaration _function(String name, SFunctionBody body) =>
    SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: _id(name),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: body,
      ),
    );

SBlockFunctionBody _block(List<SStatement> s, {bool isAsync = false}) =>
    SBlockFunctionBody(
      offset: 0,
      length: 0,
      isAsync: isAsync,
      block: SBlock(offset: 0, length: 0, statements: s),
    );

SExpressionFunctionBody _arrow(SExpression e, {bool isAsync = false}) =>
    SExpressionFunctionBody(
      offset: 0,
      length: 0,
      expression: e,
      isAsync: isAsync,
    );

/// `probe() { return 41; }` plus [fn], and `main() { return fn(); }`; the
/// result awaited when it is a Future.
Future<Object?> _run(SFunctionDeclaration fn) async {
  const entry = 'package:probe/main.dart';
  final result = D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            _function('probe', _block([_ret(_int(41))])),
            fn,
            _function('main', _block([_ret(_call(fn.name!.name))])),
          ],
        ),
      },
    ),
  );
  return result is Future ? await result : result;
}

void main() {
  group('GH6/AST: a block body that runs off its end returns null', () {
    test('GH6-AST-1: sync - `f() { probe(); }` [2026-11-07]', () async {
      expect(await _run(_function('f', _block([_stmt(_call('probe'))]))), null);
    });

    test(
      'GH6-AST-2: async - `f() async { await probe(); }` [2026-11-07]',
      () async {
        expect(
          await _run(
            _function(
              'f',
              _block([
                _stmt(
                  SAwaitExpression(
                    offset: 0,
                    length: 0,
                    expression: _call('probe'),
                  ),
                ),
              ], isAsync: true),
            ),
          ),
          null,
        );
      },
    );

    test('GH6-AST-3: an explicit return and expression bodies keep their '
        'value [2026-11-07]', () async {
      expect(
        await _run(
          _function('f', _block([_stmt(_call('probe')), _ret(_int(7))])),
        ),
        7,
      );
      expect(await _run(_function('f', _arrow(_call('probe')))), 41);
      expect(
        await _run(
          _function(
            'f',
            _arrow(
              SAwaitExpression(
                offset: 0,
                length: 0,
                expression: _call('probe'),
              ),
              isAsync: true,
            ),
          ),
        ),
        41,
      );
    });
  });
}
