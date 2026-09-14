// SCD121/AST — a variable declaration whose initializer holds more than one
// `await` keeps all of them, in the analyzer-free tree.
//
// The mirror of `tom_d4rt/test/scd121_var_decl_multi_await_test.dart`, and
// smaller. That file runs source, so it can put the fix through five shapes
// cheaply; this package interprets pre-parsed `SAstNode` trees, so each case is
// a bundle built by hand.
//
// WHAT THE DEFECT WAS. The resumption branch for a declaration bound
// `futureResult` — the value of ONE await — straight to the variable and moved
// on, so `var s = (await a) + (await b);` bound `s = 1` and everything else in
// the initializer was discarded.
//
// COUNTING CALLS IS THE POINT, not decoration. The discarded operands were
// evaluated, so a repair can produce the right sum by evaluating an operand
// twice and still be wrong — which the first attempt did, giving 5 instead of
// 3. `next()` here is a native counter, so the test reads the call count
// directly out of Dart rather than through the script.
//
// TWO ARITIES, because the first attempt was right for two awaits and wrong for
// three: its extra evaluation compounded. One case would not have caught it.
//
// AND IT PINS THE IDENTITY-KEYING CLAIM SCC40 COULD NOT. `resolvedAwaitResults`
// is a `Map.identity()`, and `SAstNode` overrides `==` with a `toJson()`
// deep-diff — so two await sites whose entire subtrees serialize identically
// would FUSE under value equality. `scc40_per_await_site_resumption_test.dart`
// says so and deliberately leaves the claim unpinned, because constructing it
// needs two identical subtrees resolving to DIFFERENT values, which is exactly
// `await Counter.next()` written twice, which is exactly the shape that landed
// on this defect.
//
// It is pinned here for free: the two sites below are structurally identical
// and resolve to 1 and 2. Under value equality they are one key, both replay
// the same value, and the sum is 2 or 4 — never 3. No separate case is needed,
// and a separate case asserting the same arithmetic would be worse, because it
// would look like an independent witness and not be one.
//
// CONTROL, measured. Reverting both halves of the fix gives `+0 -2` with `1`
// and `1` for the sums — the original defect. Reverting ONLY the
// `visitBinaryExpression` operand ordering gives `4` and `11`: the declaration
// route now keeps every operand, but each suspending await still costs a
// discarded evaluation of the one to its right, so the values are built from
// the wrong calls. Both halves are load-bearing and each is caught here.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

/// The native counter the script awaits. Every call is a call the script asked
/// for; a discarded evaluation shows up here and nowhere else.
class Counter {
  static int calls = 0;
  static Future<int> next() async {
    calls += 1;
    return calls;
  }
}

SSimpleIdentifier _id(String name) =>
    SSimpleIdentifier(offset: 0, length: 0, name: name);

SArgumentList _args() =>
    SArgumentList(offset: 0, length: 0, arguments: const []);

/// `await Counter.next()`
SAwaitExpression _awaitNext() => SAwaitExpression(
  offset: 0,
  length: 0,
  expression: SMethodInvocation(
    offset: 0,
    length: 0,
    target: _id('Counter'),
    operator: '.',
    methodName: _id('next'),
    argumentList: _args(),
  ),
);

/// A bundle for
///
///     main() async {
///       var s = (await Counter.next()) + ... + (await Counter.next());
///       return s;
///     }
///
/// with [awaits] await sites in the one initializer. Each site is its own node,
/// which is what the per-site resumption cache keys on.
AstBundle sumBundle(int awaits) {
  const entry = 'package:probe/main.dart';

  SExpression sum = _awaitNext();
  for (var i = 1; i < awaits; i++) {
    sum = SBinaryExpression(
      offset: 0,
      length: 0,
      leftOperand: sum,
      operator: '+',
      rightOperand: _awaitNext(),
    );
  }

  final declaration = SVariableDeclarationStatement(
    offset: 0,
    length: 0,
    variables: SVariableDeclarationList(
      offset: 0,
      length: 0,
      variables: [
        SVariableDeclaration(
          offset: 0,
          length: 0,
          name: _id('s'),
          initializer: sum,
        ),
      ],
    ),
  );

  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: const [],
        declarations: [
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: SFormalParameterList(
                offset: 0,
                length: 0,
                parameters: const [],
              ),
              body: SBlockFunctionBody(
                offset: 0,
                length: 0,
                isAsync: true,
                block: SBlock(
                  offset: 0,
                  length: 0,
                  statements: [
                    declaration,
                    SReturnStatement(
                      offset: 0,
                      length: 0,
                      expression: _id('s'),
                    ),
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

D4rtRunner counterRunner() => D4rtRunner()
  ..registerBridgedClass(
    BridgedClass(
      nativeType: Counter,
      name: 'Counter',
      staticMethods: {
        'next': (visitor, positional, named, typeArgs) => Counter.next(),
      },
    ),
    'package:probe/counter.dart',
    sourceUri: 'package:probe/counter.dart',
  );

void main() {
  setUp(() => Counter.calls = 0);

  group('SCD121/AST: a declaration keeps every await in its initializer', () {
    test(
      'F-SCD121-AST-1: two awaits in one initializer both count, and cost two '
      'calls [2026-09-14]',
      () async {
        final result = await counterRunner().executeBundleAsAsync<Object?>(
          sumBundle(2),
        );
        expect(result, equals(3), reason: 'pre-fix this was 1');
        expect(
          Counter.calls,
          equals(2),
          reason: 'a third call means an operand was evaluated and discarded',
        );
      },
    );

    test('F-SCD121-AST-2: three awaits, three calls [2026-09-14]', () async {
      // The arity the first repair attempt got wrong: its extra evaluation
      // compounded, so two awaits looked nearly right and three did not.
      final result = await counterRunner().executeBundleAsAsync<Object?>(
        sumBundle(3),
      );
      expect(result, equals(6), reason: 'pre-fix this was 1');
      expect(Counter.calls, equals(3));
    });
  });
}
