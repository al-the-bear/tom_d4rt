// SCE126/AST — the analyzer-free twin of
// `tom_d4rt/test/sce126_stdlib_guard_sweep_test.dart`.
//
// The sweep compared 63 expressions against real Dart and found ONE divergence
// in the stdlib bridges: `String.fromCharCodes` cast its argument to `List`
// where the SDK declares `Iterable<int>`, so a `Set` or a lazy iterable raised
// `_TypeError` for input real Dart accepts.
//
// WHAT THIS SIDE UNIQUELY ANSWERS is nothing about the bridge file — the two
// stdlib trees are code-identical (F-SCD49-2), so the cast is the same source.
// What differs is the ARGUMENT that reaches it: this tree builds its `Set` and
// its `.where(…)` through its own collection literals and its own
// `InterpretedFunction` closures, and hands the adapter whatever those
// produce. A fix that worked only because the reference's list shape happened
// to satisfy `as List` would fail here.
//
// ABLATED 2026-09-22 by restoring `as List`: F-SCE126-AST-1 fails, -2 passes.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SArgumentList _args([List<SExpression> a = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 2, value: v);

/// `String.fromCharCodes(<argument>)`
SExpression _fromCharCodes(SExpression argument) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: _id('String'),
  operator: '.',
  methodName: _id('fromCharCodes'),
  argumentList: _args([argument]),
);

/// `{97, 98}` — a SET literal, which is an Iterable and is not a List.
SExpression get _codeSet => SSetOrMapLiteral(
  offset: 0,
  length: 0,
  isSet: true,
  elements: [_int(97), _int(98)],
);

/// `[97, 98]` — the shape that always worked.
SExpression get _codeList =>
    SListLiteral(offset: 0, length: 0, elements: [_int(97), _int(98)]);

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
              parameters: SFormalParameterList(offset: 0, length: 0),
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
  group('SCE126/AST: a member declaring Iterable accepts one', () {
    test('F-SCE126-AST-1: a Set reaches String.fromCharCodes [2026-09-22] '
        '(PASS)', () {
      expect(_run(_fromCharCodes(_codeSet)), 'ab');
    });

    test('F-SCE126-AST-2 (control): a List still does [2026-09-22] (PASS)', () {
      // The shape that always worked, so a fix that traded one domain for
      // another fails here rather than passing quietly.
      expect(_run(_fromCharCodes(_codeList)), 'ab');
    });
  });
}
