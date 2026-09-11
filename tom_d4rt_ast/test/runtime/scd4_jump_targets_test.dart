/// SCD4 mirror coverage for `tom_d4rt_ast`, running against the WORKING TREE.
///
/// The script-level reproductions live in
/// `tom_d4rt/test/scd4_await_for_break_test.dart`. `tom_d4rt_exec` resolves
/// this package from pub.dev (DGUC6), so a port there measures the published
/// interpreter, not this one. These cases build their bundles from `SAstNode`s
/// by hand, the way `scc40_per_await_site_resumption_test.dart` does, so they
/// need no parser and no publish.
///
/// What they pin, one case each:
///   * `break` / `continue` inside `await for` — both loop-variable forms. The
///     loop was never put on the loop stack, so both failed "outside of a loop".
///   * `break` / `continue` in an async `while`, which the state machine could
///     not leave at all: only `for` loops were on the stack it consulted.
///   * a labelled `break` out of an `await for`, followed by the statements
///     after the loop — labels were ignored, and stepping into the labelled
///     statement exposed a next-statement search that skipped the rest of the
///     block.
///   * a labelled `continue` in synchronous code, where an unlabelled inner
///     loop used to take the label as its own.
///
/// OFFSETS MATTER HERE. `SAstNode.==` is a structural comparison that includes
/// `offset`, and the interpreter still finds a statement in its block with
/// `indexOf`. Two statements built with the same offset and the same shape
/// would be the same statement to it, so every node below takes a fresh
/// offset from [_Ast].
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// Builds mirror-AST nodes, each at its own offset.
class _Ast {
  int _offset = 0;
  int _next() => _offset += 7;

  SSimpleIdentifier id(String name) =>
      SSimpleIdentifier(offset: _next(), length: name.length, name: name);

  SIntegerLiteral int_(int value) =>
      SIntegerLiteral(offset: _next(), length: 1, value: value);

  SListLiteral list(List<SExpression> elements) =>
      SListLiteral(offset: _next(), length: 1, elements: elements);

  SBinaryExpression equals(String name, int value) => SBinaryExpression(
    offset: _next(),
    length: 1,
    leftOperand: id(name),
    operator: '==',
    rightOperand: int_(value),
  );

  SMethodInvocation call(
    SExpression target,
    String method,
    List<SExpression> args,
  ) => SMethodInvocation(
    offset: _next(),
    length: 1,
    target: target,
    operator: '.',
    methodName: id(method),
    argumentList: SArgumentList(offset: _next(), length: 1, arguments: args),
  );

  /// `Stream.fromIterable([...values])`
  SMethodInvocation stream(List<int> values) =>
      call(id('Stream'), 'fromIterable', [list(values.map(int_).toList())]);

  /// `<name>.add(<value>);`
  SExpressionStatement add(String name, SExpression value) =>
      SExpressionStatement(
        offset: _next(),
        length: 1,
        expression: call(id(name), 'add', [value]),
      );

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

  SBlock block(List<SStatement> statements) =>
      SBlock(offset: _next(), length: 1, statements: statements);

  SIfStatement ifThen(SExpression condition, SStatement then) => SIfStatement(
    offset: _next(),
    length: 1,
    condition: condition,
    thenStatement: then,
  );

  SBreakStatement break_([String? label]) => SBreakStatement(
    offset: _next(),
    length: 1,
    label: label == null ? null : id(label),
  );

  SContinueStatement continue_([String? label]) => SContinueStatement(
    offset: _next(),
    length: 1,
    label: label == null ? null : id(label),
  );

  /// `for (var <name> in <iterable>)` — or `await for` when [isAwait].
  SForStatement forIn(
    String name,
    SExpression iterable,
    List<SStatement> body, {
    bool isAwait = false,
  }) => SForStatement(
    offset: _next(),
    length: 1,
    forLoopParts: SForEachPartsWithDeclaration(
      offset: _next(),
      length: 1,
      loopVariable: SDeclaredIdentifier(
        offset: _next(),
        length: 1,
        identifier: id(name),
      ),
      iterable: iterable,
      isAwait: isAwait,
    ),
    body: block(body),
  );

  /// `await for (<name> in <iterable>)` over an existing variable.
  SForStatement awaitForExisting(
    String name,
    SExpression iterable,
    List<SStatement> body,
  ) => SForStatement(
    offset: _next(),
    length: 1,
    forLoopParts: SForEachPartsWithIdentifier(
      offset: _next(),
      length: 1,
      identifier: id(name),
      iterable: iterable,
      isAwait: true,
    ),
    body: block(body),
  );

  SLabeledStatement labelled(String label, SStatement statement) =>
      SLabeledStatement(
        offset: _next(),
        length: 1,
        labels: [SLabel(offset: _next(), length: 1, label: id(label))],
        statement: statement,
      );

  SReturnStatement return_(SExpression value) =>
      SReturnStatement(offset: _next(), length: 1, expression: value);

  /// A bundle whose `main` runs [statements].
  AstBundle program(List<SStatement> statements, {required bool isAsync}) {
    const entryUri = 'package:t/main.dart';
    final mainFn = SFunctionDeclaration(
      offset: _next(),
      length: 4,
      name: id('main'),
      functionExpression: SFunctionExpression(
        offset: _next(),
        length: 1,
        parameters: SFormalParameterList(offset: _next(), length: 1),
        body: SBlockFunctionBody(
          offset: _next(),
          length: 1,
          block: block(statements),
          isAsync: isAsync,
        ),
      ),
    );
    return AstBundle(
      entryPointUri: entryUri,
      modules: {
        entryUri: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [mainFn],
        ),
      },
    );
  }
}

void main() {
  group('SCD4/AST: break and continue reach their loop', () {
    test('F-SCD4-AST-1: break inside await for, declared loop variable '
        '[2026-09-11] (PASS)', () async {
      // var seen = [];
      // await for (var v in Stream.fromIterable([1, 2, 3])) {
      //   seen.add(v);
      //   if (v == 2) break;
      // }
      // return seen;
      final a = _Ast();
      final bundle = a.program([
        a.declare('seen', a.list([])),
        a.forIn('v', a.stream([1, 2, 3]), [
          a.add('seen', a.id('v')),
          a.ifThen(a.equals('v', 2), a.break_()),
        ], isAwait: true),
        a.return_(a.id('seen')),
      ], isAsync: true);
      final result = await D4rtRunner().executeBundleAsAsync<Object?>(bundle);
      expect(result, equals([1, 2]));
    });

    test('F-SCD4-AST-2: continue inside await for over an existing variable '
        '[2026-09-11] (PASS)', () async {
      // var seen = [];
      // var v = 0;
      // await for (v in Stream.fromIterable([1, 2, 3])) {
      //   if (v == 2) continue;
      //   seen.add(v);
      // }
      // seen.add(v);
      // return seen;
      final a = _Ast();
      final bundle = a.program([
        a.declare('seen', a.list([])),
        a.declare('v', a.int_(0)),
        a.awaitForExisting('v', a.stream([1, 2, 3]), [
          a.ifThen(a.equals('v', 2), a.continue_()),
          a.add('seen', a.id('v')),
        ]),
        a.add('seen', a.id('v')),
        a.return_(a.id('seen')),
      ], isAsync: true);
      final result = await D4rtRunner().executeBundleAsAsync<Object?>(bundle);
      expect(result, equals([1, 3, 3]));
    });

    test('F-SCD4-AST-3: break and continue in a while of an async body '
        '[2026-09-11] (PASS)', () async {
      // var seen = [];
      // var n = 0;
      // while (true) {
      //   n++;
      //   if (n == 2) continue;
      //   if (n == 4) break;
      //   seen.add(n);
      // }
      // return seen;
      final a = _Ast();
      final bundle = a.program([
        a.declare('seen', a.list([])),
        a.declare('n', a.int_(0)),
        SWhileStatement(
          offset: a._next(),
          length: 1,
          condition: SBooleanLiteral(offset: a._next(), length: 4, value: true),
          body: a.block([
            SExpressionStatement(
              offset: a._next(),
              length: 1,
              expression: SPostfixExpression(
                offset: a._next(),
                length: 1,
                operand: a.id('n'),
                operator: '++',
              ),
            ),
            a.ifThen(a.equals('n', 2), a.continue_()),
            a.ifThen(a.equals('n', 4), a.break_()),
            a.add('seen', a.id('n')),
          ]),
        ),
        a.return_(a.id('seen')),
      ], isAsync: true);
      final result = await D4rtRunner().executeBundleAsAsync<Object?>(bundle);
      expect(result, equals([1, 3]));
    });

    test('F-SCD4-AST-4: a labelled break leaves an outer await for, and the '
        'statements after it run [2026-09-11] (PASS)', () async {
      // var seen = [];
      // outer:
      // await for (var a in Stream.fromIterable([1, 2])) {
      //   for (var b in [10, 20]) {
      //     if (a == 2) break outer;
      //     seen.add(b);
      //   }
      // }
      // seen.add(0);
      // return seen;
      final a = _Ast();
      final bundle = a.program([
        a.declare('seen', a.list([])),
        a.labelled(
          'outer',
          a.forIn('a', a.stream([1, 2]), [
            a.forIn('b', a.list([a.int_(10), a.int_(20)]), [
              a.ifThen(a.equals('a', 2), a.break_('outer')),
              a.add('seen', a.id('b')),
            ]),
          ], isAwait: true),
        ),
        a.add('seen', a.int_(0)),
        a.return_(a.id('seen')),
      ], isAsync: true);
      final result = await D4rtRunner().executeBundleAsAsync<Object?>(bundle);
      expect(result, equals([10, 20, 0]));
    });

    test('F-SCD4-AST-5: a labelled continue in synchronous code restarts the '
        'outer loop [2026-09-11] (PASS)', () async {
      // var seen = [];
      // outer:
      // for (var a in [1, 2]) {
      //   for (var b in [10, 20]) {
      //     if (b == 20) continue outer;
      //     seen.add(b);
      //   }
      //   seen.add(0);
      // }
      // return seen;
      //
      // [10, 0, 10, 0] is the old answer: the inner loop took `continue
      // outer` as its own, so the append after it ran.
      final a = _Ast();
      final bundle = a.program([
        a.declare('seen', a.list([])),
        a.labelled(
          'outer',
          a.forIn('a', a.list([a.int_(1), a.int_(2)]), [
            a.forIn('b', a.list([a.int_(10), a.int_(20)]), [
              a.ifThen(a.equals('b', 20), a.continue_('outer')),
              a.add('seen', a.id('b')),
            ]),
            a.add('seen', a.int_(0)),
          ]),
        ),
        a.return_(a.id('seen')),
      ], isAsync: false);
      final result = D4rtRunner().executeBundleAs<Object?>(bundle);
      expect(result, equals([10, 10]));
    });
  });
}
