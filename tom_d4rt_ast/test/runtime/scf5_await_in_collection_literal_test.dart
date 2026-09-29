/// SCF5 / SCE80 mirror coverage for `tom_d4rt_ast`, running against the
/// WORKING TREE.
///
/// An `await` inside a list, set or map literal used to store the
/// interpreter's own `AsyncSuspensionRequest` as the element:
/// `[await a(), 9]` answered `[Instance of 'AsyncSuspensionRequest', 9]`. SCE80
/// fixed it in both trees (`_processCollectionElement` now returns the
/// suspension instead of storing it), and `tom_d4rt/test/
/// scc12_await_in_finally_test.dart` pins it script-level, as does exec's port
/// — but exec resolves `tom_d4rt_ast` from pub.dev (DGUC6), so that port
/// certifies the published interpreter, not this tree. These cases build the
/// five shapes SCF5 was filed with from `SAstNode`s, so a regression in the
/// tree is seen before a publish carries it.
///
/// Every case compares CONTENTS. A sentinel is an element like any other, so a
/// length check reads a broken literal as healthy — SCE80's own first probe
/// did exactly that.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// Builds mirror-AST nodes, each await at its own offset: the per-site replay
/// cache is keyed by position, and two sites sharing one would replay each
/// other's value.
class _Ast {
  int _offset = 0;
  int _next() => _offset += 11;

  SSimpleIdentifier id(String name) =>
      SSimpleIdentifier(offset: _next(), length: name.length, name: name);

  SIntegerLiteral int_(int value) =>
      SIntegerLiteral(offset: _next(), length: 1, value: value);

  /// `await Future.value(<value>)`
  SAwaitExpression await_(int value) => SAwaitExpression(
    offset: _next(),
    length: 20,
    expression: SMethodInvocation(
      offset: _next(),
      length: 14,
      target: id('Future'),
      operator: '.',
      methodName: id('value'),
      argumentList: SArgumentList(
        offset: _next(),
        length: 3,
        arguments: [int_(value)],
      ),
    ),
  );

  SListLiteral list(List<SCollectionElement> elements) =>
      SListLiteral(offset: _next(), length: 1, elements: elements);

  /// `<int>{...}`
  SSetOrMapLiteral intSet(List<SCollectionElement> elements) =>
      SSetOrMapLiteral(
        offset: _next(),
        length: 1,
        typeArguments: STypeArgumentList(
          offset: _next(),
          length: 5,
          arguments: [SNamedType(offset: _next(), length: 3, name: id('int'))],
        ),
        elements: elements,
        isSet: true,
      );

  /// `{"<key>": <value>}`
  SSetOrMapLiteral map(String key, SExpression value) => SSetOrMapLiteral(
    offset: _next(),
    length: 1,
    elements: [
      SMapLiteralEntry(
        offset: _next(),
        length: 1,
        key: SSimpleStringLiteral(
          offset: _next(),
          length: key.length + 2,
          value: key,
        ),
        value: value,
      ),
    ],
    isMap: true,
  );

  SReturnStatement return_(SExpression value) =>
      SReturnStatement(offset: _next(), length: 1, expression: value);

  SVariableDeclarationStatement declare(String name, SExpression init) =>
      SVariableDeclarationStatement(
        offset: _next(),
        length: 1,
        variables: SVariableDeclarationList(
          offset: _next(),
          length: 1,
          variables: [
            SVariableDeclaration(
              offset: _next(),
              length: 1,
              name: id(name),
              initializer: init,
            ),
          ],
        ),
      );

  AstBundle _bundle(SFunctionBody body) {
    const entryUri = 'package:t/main.dart';
    return AstBundle(
      entryPointUri: entryUri,
      modules: {
        entryUri: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            SFunctionDeclaration(
              offset: _next(),
              length: 4,
              name: id('main'),
              functionExpression: SFunctionExpression(
                offset: _next(),
                length: 1,
                parameters: SFormalParameterList(offset: _next(), length: 1),
                body: body,
              ),
            ),
          ],
        ),
      },
    );
  }

  /// `main() async { <statements> }`
  AstBundle blockBody(List<SStatement> statements) => _bundle(
    SBlockFunctionBody(
      offset: _next(),
      length: 1,
      isAsync: true,
      block: SBlock(offset: _next(), length: 1, statements: statements),
    ),
  );

  /// `main() async => <expression>;`
  AstBundle expressionBody(SExpression expression) => _bundle(
    SExpressionFunctionBody(
      offset: _next(),
      length: 1,
      expression: expression,
      isAsync: true,
    ),
  );
}

Future<Object?> _run(AstBundle bundle) =>
    D4rtRunner().executeBundleAsAsync<Object?>(bundle);

void main() {
  group('SCF5/AST: an await in a collection literal yields its value', () {
    test(
      'F-SCF5-AST-1: main() async => [await a(), 9] [2026-09-29] (PASS)',
      () async {
        final a = _Ast();
        final bundle = a.expressionBody(a.list([a.await_(2), a.int_(9)]));
        expect(await _run(bundle), orderedEquals([2, 9]));
      },
    );

    test('F-SCF5-AST-2: return [await a(), 9] from a block body '
        '[2026-09-29] (PASS)', () async {
      final a = _Ast();
      final bundle = a.blockBody([
        a.return_(a.list([a.await_(2), a.int_(9)])),
      ]);
      expect(await _run(bundle), orderedEquals([2, 9]));
    });

    test('F-SCF5-AST-3: var l = [await a(), 9]; return l; '
        '[2026-09-29] (PASS)', () async {
      final a = _Ast();
      final bundle = a.blockBody([
        a.declare('l', a.list([a.await_(2), a.int_(9)])),
        a.return_(a.id('l')),
      ]);
      expect(await _run(bundle), orderedEquals([2, 9]));
    });

    test('F-SCF5-AST-4: return {"k": await a()} [2026-09-29] (PASS)', () async {
      final a = _Ast();
      final bundle = a.blockBody([a.return_(a.map('k', a.await_(2)))]);
      expect(await _run(bundle), equals({'k': 2}));
    });

    test(
      'F-SCF5-AST-5: return <int>{await a(), 9} [2026-09-29] (PASS)',
      () async {
        final a = _Ast();
        final bundle = a.blockBody([
          a.return_(a.intSet([a.await_(2), a.int_(9)])),
        ]);
        expect(await _run(bundle), equals(<int>{2, 9}));
      },
    );

    test('F-SCF5-AST-6: two awaits in one literal, each its own value '
        '[2026-09-29] (PASS)', () async {
      final a = _Ast();
      final bundle = a.blockBody([
        a.return_(a.list([a.await_(2), a.await_(3), a.int_(9)])),
      ]);
      expect(await _run(bundle), orderedEquals([2, 3, 9]));
    });
  });
}
