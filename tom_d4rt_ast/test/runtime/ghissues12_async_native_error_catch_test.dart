// GHI12/AST — in an `async` function a native error from a bridged call is
// caught as itself, in the analyzer-free tree (ghissues12).
//
// The mirror of `tom_d4rt/test/ghissues12_async_native_error_catch_test.dart`,
// which runs source over the whole sync / async matrix. Here each script is a
// hand-built bundle: an `async` main whose try body makes a bridged call that
// throws natively (`int.parse('x')`, `List.unmodifiable([1]).add(2)`), caught
// by `on FormatException` and by a bare `catch` that checks
// `e is UnsupportedError`, with and without an `await` before the try. Before
// the fix the async state machine bound the RuntimeD4rtException wrapper:
// `on FormatException` did not match and the `is` check was false.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SArgumentList _args([List<SExpression> a = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SReturnStatement _return(SExpression e) =>
    SReturnStatement(offset: 0, length: 0, expression: e);

SBlock _block(List<SStatement> s) =>
    SBlock(offset: 0, length: 0, statements: s);

/// `<target>.<method>(<args>)`
SMethodInvocation _call(
  SExpression target,
  String method, [
  List<SExpression> args = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  methodName: _id(method),
  argumentList: _args(args),
);

/// `int.parse('x');`
SStatement get _badParse => SExpressionStatement(
  offset: 0,
  length: 0,
  expression: _call(_id('int'), 'parse', [_str('x')]),
);

/// `List.unmodifiable([1]).add(2);`
SStatement get _unmodifiableAdd => SExpressionStatement(
  offset: 0,
  length: 0,
  expression: _call(
    _call(_id('List'), 'unmodifiable', [
      SListLiteral(offset: 0, length: 0, elements: [_int(1)]),
    ]),
    'add',
    [_int(2)],
  ),
);

/// `try { <body> } <clauses>`
STryStatement _try(SStatement body, List<SCatchClause> clauses) =>
    STryStatement(
      offset: 0,
      length: 0,
      body: _block([body]),
      catchClauses: clauses,
    );

/// `on <type> catch (e) { return <result>; }`, or `catch (e)` without [type].
SCatchClause _catch(SExpression result, {String? type}) => SCatchClause(
  offset: 0,
  length: 0,
  exceptionType: type == null ? null : _type(type),
  exceptionParameter: _id('e'),
  body: _block([_return(result)]),
);

/// Runs `main() async { [await null;] <statements> }` and awaits it.
Future<Object?> _runAsync(
  List<SStatement> statements, {
  bool afterAwait = false,
}) async {
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
                  block: _block([
                    if (afterAwait)
                      SExpressionStatement(
                        offset: 0,
                        length: 0,
                        expression: SAwaitExpression(
                          offset: 0,
                          length: 0,
                          expression: SNullLiteral(offset: 0, length: 4),
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
  return result is Future ? await result : result;
}

void main() {
  group('GHI12/AST: a native error from a bridged call in an async catch', () {
    for (final afterAwait in const [false, true]) {
      final label = afterAwait ? 'after an await' : 'before any await';

      test('F-GHI12-AST-1: $label: `on FormatException` matches a native '
          'FormatException [2026-11-09]', () async {
        expect(
          await _runAsync([
            _try(_badParse, [
              _catch(_str('on'), type: 'FormatException'),
              _catch(_str('other')),
            ]),
          ], afterAwait: afterAwait),
          'on',
        );
      });

      test('F-GHI12-AST-2: $label: a bare catch binds the native '
          'UnsupportedError [2026-11-09]', () async {
        expect(
          await _runAsync([
            _try(_unmodifiableAdd, [
              _catch(
                SIsExpression(
                  offset: 0,
                  length: 0,
                  expression: _id('e'),
                  type: _type('UnsupportedError'),
                ),
              ),
            ]),
          ], afterAwait: afterAwait),
          isTrue,
        );
      });
    }
  });
}
