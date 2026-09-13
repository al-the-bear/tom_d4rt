/// SCD73 mirror coverage for `tom_d4rt_ast`.
///
/// The contract: with **no** `onUncaughtError` hook, an error escaping an
/// interpreted callback reaches the embedder's own zone as the value the script
/// threw, not as `InternalInterpreterD4rtException`. The mechanism is a zone
/// d4rt now forks unconditionally, specifying only the `register*Callback`
/// hooks — which is *not* an error zone, so the embedder keeps theirs and an
/// ordinary script failure still reaches the caller of `executeBundle`.
///
/// SCD73 was filed stating that this was unavailable, because unwrapping needs
/// to intercept the error and the only interception point is
/// `handleUncaughtError`, which makes the zone an error zone. The missing idea
/// is that a callback can be observed **at registration** instead.
///
/// **Scope of this file.** `tom_d4rt_ast` cannot parse Dart source, so the
/// bundle below is a hand-built `SAstNode` tree: `Future.value(1).then((v) {
/// throw 'escaped'; });`, deliberately unawaited. That is the smallest
/// registered-callback escape expressible without a parser — a `Timer` or a
/// `StreamController` would need several more nodes each, and the eight-case
/// script-level suite lives in
/// `tom_d4rt/test/scd73_no_hook_unwrapping_test.dart`. It cannot be run against
/// *this* tree, because `tom_d4rt_exec` (the only runner with a source parser)
/// resolves `tom_d4rt_ast` from pub.dev rather than by path and so never sees
/// unpublished local edits (DGUC6).
///
/// **Control.** Reverting either half of the zone change — the register hooks,
/// or the unconditional fork — fails F-SCD73-AST-1. F-SCD73-AST-2 and -3 are
/// rails: -2 is the property F-SCB9-12 failed on when the error-zone half was
/// made unconditional during SCC23, asserted here because the fork is now
/// unconditional; -3 covers `unwrapScriptError`, the documented remedy for the
/// one escape route with no registration seam (`Stream.handleError`).
library;

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  SSimpleIdentifier ident(String name) =>
      SSimpleIdentifier(offset: 0, length: name.length, name: name);

  SArgumentList args(List<SExpression> arguments) =>
      SArgumentList(offset: 0, length: 0, arguments: arguments);

  /// `Future.value(1).then((v) { throw '<message>'; });` as a statement, left
  /// unawaited so the failure belongs to the platform rather than to the
  /// script's own future chain. The `then` continuation is registered with the
  /// zone, which is the seam under test.
  SStatement unawaitedThenThrow(String message) => SExpressionStatement(
    offset: 0,
    length: 0,
    expression: SMethodInvocation(
      offset: 0,
      length: 0,
      target: SMethodInvocation(
        offset: 0,
        length: 0,
        target: ident('Future'),
        operator: '.',
        methodName: ident('value'),
        argumentList: args([SIntegerLiteral(offset: 0, length: 1, value: 1)]),
      ),
      operator: '.',
      methodName: ident('then'),
      argumentList: args([
        SFunctionExpression(
          offset: 0,
          length: 0,
          parameters: SFormalParameterList(
            offset: 0,
            length: 0,
            parameters: [
              SSimpleFormalParameter(offset: 0, length: 0, name: ident('v')),
            ],
          ),
          body: SBlockFunctionBody(
            offset: 0,
            length: 0,
            block: SBlock(
              offset: 0,
              length: 0,
              statements: [
                SExpressionStatement(
                  offset: 0,
                  length: 0,
                  expression: SThrowExpression(
                    offset: 0,
                    length: 0,
                    expression: SSimpleStringLiteral(
                      offset: 0,
                      length: 0,
                      value: message,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    ),
  );

  /// `await Future.delayed(Duration(milliseconds: <ms>));`
  SStatement awaitDelay(int ms) => SExpressionStatement(
    offset: 0,
    length: 0,
    expression: SAwaitExpression(
      offset: 0,
      length: 0,
      expression: SMethodInvocation(
        offset: 0,
        length: 0,
        target: ident('Future'),
        operator: '.',
        methodName: ident('delayed'),
        argumentList: args([
          SInstanceCreationExpression(
            offset: 0,
            length: 0,
            constructorName: SConstructorName(
              offset: 0,
              length: 0,
              type: SNamedType(offset: 0, length: 0, name: ident('Duration')),
            ),
            argumentList: SArgumentList(
              offset: 0,
              length: 0,
              arguments: [
                SNamedExpression(
                  offset: 0,
                  length: 0,
                  name: SLabel(
                    offset: 0,
                    length: 0,
                    label: ident('milliseconds'),
                  ),
                  expression: SIntegerLiteral(offset: 0, length: 1, value: ms),
                ),
              ],
            ),
          ),
        ]),
      ),
    ),
  );

  /// Wraps [statements] in `main() async { ... }` and packs a one-module bundle.
  AstBundle asyncBundleOf(List<SStatement> statements) {
    const entryUri = 'package:t/main.dart';
    final mainFn = SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: ident('main'),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          isAsync: true,
          block: SBlock(offset: 0, length: 0, statements: statements),
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

  group('SCD73/AST: the no-hook embedder sees what the script threw', () {
    test('F-SCD73-AST-1: a then-continuation that throws arrives unwrapped '
        '[2026-09-13]', () async {
      final zoneErrors = <Object>[];

      await runZonedGuarded(() async {
        final raw = D4rtRunner().executeBundle(
          asyncBundleOf([unawaitedThenThrow('escaped'), awaitDelay(40)]),
        );
        if (raw is Future) await raw;
      }, (error, _) => zoneErrors.add(error));
      await Future<void>.delayed(const Duration(milliseconds: 60));

      expect(zoneErrors, hasLength(1));
      expect(
        zoneErrors.single,
        'escaped',
        reason:
            'with no hook set, the embedder now receives the thrown value '
            'rather than the interpreter-internal wrapper around it',
      );
    });

    test('F-SCD73-AST-2: forking always did not make d4rt the error zone '
        '[2026-09-13]', () {
      // The failure this guards is a hang, not a failure: an awaiting caller
      // registers its listener outside the zone, Dart refuses to carry the
      // error across an error-zone boundary, and the returned future never
      // completes. F-SCB9-12 caught it in the reference tree when the
      // error-zone half was made unconditional.
      final runner = D4rtRunner();
      expect(
        () => runner.executeBundle(
          asyncBundleOf([
            SExpressionStatement(
              offset: 0,
              length: 0,
              expression: SThrowExpression(
                offset: 0,
                length: 0,
                expression: SSimpleStringLiteral(
                  offset: 0,
                  length: 0,
                  value: 'mine',
                ),
              ),
            ),
          ]),
        ),
        throwsA(anything),
        reason: 'a script failure still belongs to the caller',
      );
    });

    test(
      'F-SCD73-AST-3: unwrapScriptError peels both levels and passes anything '
      'else through untouched [2026-09-13]',
      () {
        // It is the documented remedy for `Stream.handleError`, whose handler
        // the SDK invokes with no zone registration — so it has to work, and it
        // runs on every callback registered while a script executes, so
        // "leaves everything else alone" is a safety property.
        final native = StateError('native');
        expect(identical(unwrapScriptError(native), native), isTrue);
        expect(unwrapScriptError('a string'), 'a string');

        final wrapped = InternalInterpreterD4rtException(native);
        expect(identical(unwrapScriptError(wrapped), native), isTrue);
        expect(
          identical(unwrapScriptError(unwrapScriptError(wrapped)), native),
          isTrue,
          reason:
              'the zone seam and the hook both apply it, so an escape through '
              'a registered callback is unwrapped twice',
        );
      },
    );
  });
}
