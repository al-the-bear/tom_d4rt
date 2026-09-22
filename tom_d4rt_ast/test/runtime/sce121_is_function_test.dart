// SCE121/AST — the analyzer-free twin of
// `tom_d4rt/test/sce121_is_function_test.dart`.
//
// `is Function` answered true for a script function or a closure and false for
// every native one — while `f(1)` on that same tear-off worked. So a script's
// `if (x is Function) x()` guard rejected a value the interpreter could call.
//
// WHAT THIS SIDE UNIQUELY ANSWERS is that the type-test path reaches the
// bridge's `isAssignable` at all. The `Function` bridge file is code-identical
// between the trees (F-SCD49-2), so the one-line rule is the same source; what
// differs is `_valueHasType` in this tree's own `interpreter_visitor.dart`,
// which is the code that has to consult it. The reference suite runs none of
// that copy.
//
// ABLATED 2026-09-22 by removing the `isAssignable` line: F-SCE121-AST-1
// fails ALONE. -2 and -3 pass under both, and they are here for that reason —
// -2 is the half that already worked, so a change that SWAPPED the answer
// instead of widening it fails there, and -3 is the rail against widening too
// far.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SFormalParameterList _noParams() =>
    SFormalParameterList(offset: 0, length: 0, parameters: const []);

/// `<expression> is Function`
SExpression _isFunction(SExpression expression) => SIsExpression(
  offset: 0,
  length: 0,
  expression: expression,
  isNot: false,
  type: SNamedType(offset: 0, length: 0, name: _id('Function')),
);

/// `'abc'.substring` — a bridged instance-method tear-off.
SExpression get _tearOff => SPropertyAccess(
  offset: 0,
  length: 0,
  target: SSimpleStringLiteral(offset: 0, length: 3, value: 'abc'),
  operator: '.',
  propertyName: _id('substring'),
);

/// `main() => <expression>;`
AstBundle _bundle(SExpression expression) {
  const entry = 'package:probe/main.dart';
  return AstBundle(
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
              parameters: _noParams(),
              body: SExpressionFunctionBody(
                offset: 0,
                length: 0,
                expression: expression,
              ),
            ),
          ),
        ],
      ),
    },
  );
}

Object? _run(SExpression e) => D4rtRunner().executeBundle(_bundle(e));

void main() {
  group('SCE121/AST: is Function', () {
    test('F-SCE121-AST-1: a bridged tear-off answers true [2026-09-22] '
        '(PASS)', () {
      expect(_run(_isFunction(_tearOff)), isTrue);
    });

    test('F-SCE121-AST-2: an interpreted closure still answers true '
        '[2026-09-22] (PASS)', () {
      // `(() => 1) is Function` — the half that already worked, so a change
      // that swapped the answer rather than widening it fails here.
      expect(
        _run(
          _isFunction(
            SParenthesizedExpression(
              offset: 0,
              length: 0,
              expression: SFunctionExpression(
                offset: 0,
                length: 0,
                parameters: _noParams(),
                body: SExpressionFunctionBody(
                  offset: 0,
                  length: 0,
                  expression: SIntegerLiteral(offset: 0, length: 1, value: 1),
                ),
              ),
            ),
          ),
        ),
        isTrue,
      );
    });

    test('F-SCE121-AST-3 (rail): a non-callable is still not a Function '
        '[2026-09-22] (PASS)', () {
      expect(
        _run(_isFunction(SIntegerLiteral(offset: 0, length: 1, value: 1))),
        isFalse,
      );
      expect(
        _run(
          _isFunction(SSimpleStringLiteral(offset: 0, length: 3, value: 'abc')),
        ),
        isFalse,
      );
    });
  });
}
