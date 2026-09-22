// SCE113/AST — the analyzer-free twin of
// `tom_d4rt/test/sce113_function_apply_symbol_keys_test.dart`.
//
// `Function.apply`'s named arguments are keyed by `Symbol` in the SDK
// signature and were read as `Map<String, Object?>` by the adapter, so the
// only spelling a script could use was one no Dart program can contain. The
// reference test carries the full account; this side asks the same question of
// the interpreter that has no analyzer behind it.
//
// THE NAME EXTRACTION IS WHY THIS TWIN IS NOT OPTIONAL. `MirrorSystem.getName`
// is unavailable here, so the adapter reads the name off `Symbol.toString()`.
// That is a property of the RUNTIME rather than of the parse, and this tree is
// the one that has to hold it on a platform without mirrors.
//
// ABLATED 2026-09-22 by restoring the `D4.coerceMap<String, Object?>` call:
// -1, -2 and -4 fail, -3 fails on the message, -5 passes under both.

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  var offset = 0;
  int next() => offset += 7;

  SSimpleIdentifier id(String n) =>
      SSimpleIdentifier(offset: next(), length: n.length, name: n);
  SIntegerLiteral int_(int v) =>
      SIntegerLiteral(offset: next(), length: 1, value: v);
  SSimpleStringLiteral str(String v) =>
      SSimpleStringLiteral(offset: next(), length: v.length, value: v);
  SSymbolLiteral sym(String n) =>
      SSymbolLiteral(offset: next(), length: n.length + 1, value: n);
  SNullLiteral nul() => SNullLiteral(offset: next(), length: 4);

  SExpression binary(SExpression l, String op, SExpression r) =>
      SBinaryExpression(
        offset: next(),
        length: 0,
        leftOperand: l,
        operator: op,
        rightOperand: r,
      );

  SListLiteral list(List<SExpression> items) =>
      SListLiteral(offset: next(), length: 0, elements: items);

  /// A map literal — `{<k>: <v>, …}` — with whatever key expressions are given.
  SSetOrMapLiteral map(List<(SExpression, SExpression)> entries) =>
      SSetOrMapLiteral(
        offset: next(),
        length: 0,
        isMap: true,
        elements: [
          for (final (k, v) in entries)
            SMapLiteralEntry(offset: next(), length: 0, key: k, value: v),
        ],
      );

  /// `Function.apply(<callee>, <positional>, <named>)`, or the two-argument
  /// form when [named] is omitted.
  SMethodInvocation applyCall(
    String callee,
    SExpression positional, [
    SExpression? named,
  ]) => SMethodInvocation(
    offset: next(),
    length: 0,
    target: id('Function'),
    operator: '.',
    methodName: id('apply'),
    argumentList: SArgumentList(
      offset: next(),
      length: 0,
      arguments: [id(callee), positional, ?named],
    ),
  );

  /// `f(a, {b = 0, c = 0}) => a + b * 10 + c * 100;` when [withPositional],
  /// and `g({b = 0, c = 0}) => b * 10 + c * 100;` when not.
  ///
  /// A digit per parameter, so that a named argument landing on the wrong
  /// parameter is a different answer rather than a differently-ordered one.
  /// `g` exists because `Function.apply(f, null)` is correctly a missing-
  /// required-argument error — the nullable positional list means "none", not
  /// "whatever the callee needs".
  SFunctionDeclaration callee(String name, {required bool withPositional}) {
    SDefaultFormalParameter namedParam(String n) => SDefaultFormalParameter(
      offset: next(),
      length: 0,
      isPositional: false,
      isNamed: true,
      parameter: SSimpleFormalParameter(
        offset: next(),
        length: 0,
        name: id(n),
        isPositional: false,
        isNamed: true,
      ),
      defaultValue: int_(0),
    );

    return SFunctionDeclaration(
      offset: next(),
      length: 0,
      name: id(name),
      functionExpression: SFunctionExpression(
        offset: next(),
        length: 0,
        parameters: SFormalParameterList(
          offset: next(),
          length: 0,
          parameters: [
            if (withPositional)
              SSimpleFormalParameter(
                offset: next(),
                length: 0,
                name: id('a'),
                // `tom_ast_generator` copies the analyzer's `isRequired`, which
                // is true for a required positional. Leaving it at its default
                // declares an OPTIONAL positional, which binds `null` instead
                // of reporting the missing argument.
                isRequired: true,
              ),
            namedParam('b'),
            namedParam('c'),
          ],
        ),
        body: SExpressionFunctionBody(
          offset: next(),
          length: 0,
          expression: binary(
            withPositional
                ? binary(id('a'), '+', binary(id('b'), '*', int_(10)))
                : binary(id('b'), '*', int_(10)),
            '+',
            binary(id('c'), '*', int_(100)),
          ),
        ),
      ),
    );
  }

  /// `main() { return <expression>; }`, with `f` and `g` declared beside it.
  AstBundle bundleOf(SExpression expression) {
    const entryUri = 'package:t/main.dart';
    return AstBundle(
      entryPointUri: entryUri,
      modules: {
        entryUri: SCompilationUnit(
          offset: next(),
          length: 0,
          declarations: [
            callee('f', withPositional: true),
            callee('g', withPositional: false),
            SFunctionDeclaration(
              offset: next(),
              length: 0,
              name: id('main'),
              functionExpression: SFunctionExpression(
                offset: next(),
                length: 0,
                parameters: SFormalParameterList(offset: next(), length: 0),
                body: SBlockFunctionBody(
                  offset: next(),
                  length: 0,
                  block: SBlock(
                    offset: next(),
                    length: 0,
                    statements: [
                      SReturnStatement(
                        offset: next(),
                        length: 0,
                        expression: expression,
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

  Object? run(SExpression e) => D4rtRunner().executeBundle(bundleOf(e));

  /// The message raised by running [e], or `'no throw'`.
  String rejection(SExpression e) {
    try {
      run(e);
    } on ArgumentD4rtException catch (err) {
      return err.toString();
    }
    return 'no throw';
  }

  group('SCE113/AST: Function.apply takes Symbol keys', () {
    test('F-SCE113-AST-1: the legal spelling reaches the named parameter '
        '[2026-09-22] (PASS)', () {
      // main() { return Function.apply(f, [1], {#b: 2}); }
      expect(
        run(applyCall('f', list([int_(1)]), map([(sym('b'), int_(2))]))),
        21,
      );
    });

    test('F-SCE113-AST-2: several named arguments, in either order '
        '[2026-09-22] (PASS)', () {
      expect(
        run(
          applyCall(
            'f',
            list([int_(1)]),
            map([(sym('b'), int_(2)), (sym('c'), int_(3))]),
          ),
        ),
        321,
      );
      expect(
        run(
          applyCall(
            'f',
            list([int_(1)]),
            map([(sym('c'), int_(3)), (sym('b'), int_(2))]),
          ),
        ),
        321,
      );
    });

    test('F-SCE113-AST-3: a String key is rejected and the message shows the '
        'legal spelling [2026-09-22] (PASS)', () {
      final message = rejection(
        applyCall('f', list([int_(1)]), map([(str('b'), int_(2))])),
      );
      expect(message, contains('keyed by Symbol, not String'));
      expect(message, contains('{#b: ...}'));
    });

    test('F-SCE113-AST-4: both argument lists are nullable [2026-09-22] '
        '(PASS)', () {
      // `null` is legal for either and means "no arguments".
      expect(run(applyCall('f', list([int_(1)]), nul())), 1);
      expect(run(applyCall('g', nul(), map([(sym('b'), int_(2))]))), 20);
    });

    test('F-SCE113-AST-5 (control): the forms that already worked still work '
        '[2026-09-22] (PASS)', () {
      expect(run(applyCall('f', list([int_(1)]))), 1);
      expect(run(applyCall('f', list([int_(1)]), map([]))), 1);
    });
  });
}
