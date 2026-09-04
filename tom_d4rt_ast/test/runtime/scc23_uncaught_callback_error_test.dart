/// SCC23 mirror coverage for `tom_d4rt_ast`.
///
/// The contract under test: an error that escapes an interpreted callback the
/// *platform* invoked — a `Stream.listen` body, a `handleError` handler, a
/// `Timer` — reaches the embedder through [D4rtRunner.onUncaughtError] instead
/// of vanishing into the enclosing zone, where a script has no way to observe
/// it (`Zone`, `runZoned` and `runZonedGuarded` are deliberately unbridged).
///
/// Setting the hook is what makes d4rt fork a zone at all. That is a
/// constraint, not a convenience: a zone specifying `handleUncaughtError` *is*
/// a new error zone, and Dart refuses to deliver an error across an error-zone
/// boundary, so forking unconditionally would stop an ordinary script failure
/// from ever reaching the caller of `executeBundle`. With no hook there is no
/// zone and therefore no behaviour change by construction.
///
/// **Scope of this file.** `tom_d4rt_ast` cannot parse Dart source, so the
/// bundles below are hand-built `SAstNode` trees and the scripts they express
/// are necessarily small. The script-level suite — sixteen cases covering
/// `onData` / `onError` / `onDone` / `handleError` / `Timer`, unwrapping,
/// containment and the delivery-path symmetry — lives in
/// `tom_d4rt/test/scc23_uncaught_callback_error_test.dart`. It cannot be run
/// against *this* tree, because `tom_d4rt_exec` (the only runner with a source
/// parser) resolves `tom_d4rt_ast` from pub.dev rather than by path and so
/// never sees unpublished local edits (DGUC6).
library;

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  SSimpleIdentifier ident(String name) =>
      SSimpleIdentifier(offset: 0, length: name.length, name: name);

  /// Wraps [statements] in `main() { ... }` and packs it into a one-module
  /// bundle.
  AstBundle bundleOf(List<SStatement> statements) {
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
          block: SBlock(offset: 0, length: 0, statements: statements),
        ),
      ),
    );
    return AstBundle(
      entryPointUri: entryUri,
      modules: {
        entryUri: SCompilationUnit(offset: 0, length: 0, declarations: [mainFn]),
      },
    );
  }

  /// `return <value>;`
  SStatement returnInt(int value) => SReturnStatement(
        offset: 0,
        length: 0,
        expression: SIntegerLiteral(offset: 0, length: 1, value: value),
      );

  /// `throw '<message>';`
  SStatement throwString(String message) => SExpressionStatement(
        offset: 0,
        length: 0,
        expression: SThrowExpression(
          offset: 0,
          length: 0,
          expression:
              SSimpleStringLiteral(offset: 0, length: 0, value: message),
        ),
      );

  /// `Future.error('<message>');` — deliberately un-awaited, so the failure
  /// belongs to the platform rather than to the script's own future chain.
  /// This is the smallest escape expressible without a parser.
  SStatement unawaitedFutureError(String message) => SExpressionStatement(
        offset: 0,
        length: 0,
        expression: SMethodInvocation(
          offset: 0,
          length: 0,
          target: ident('Future'),
          operator: '.',
          methodName: ident('error'),
          argumentList: SArgumentList(
            offset: 0,
            length: 0,
            arguments: [
              SSimpleStringLiteral(offset: 0, length: 0, value: message),
            ],
          ),
        ),
      );

  group('SCC23/AST: the embedder hook', () {
    test(
        'F-SCC23-AST-1: onUncaughtError is null by default and installing one '
        'leaves an ordinary result untouched [2026-09-04]', () {
      expect(D4rtRunner().onUncaughtError, isNull,
          reason: 'the hook is opt-in; no hook means no forked zone at all');

      final runner = D4rtRunner();
      runner.onUncaughtError = (_, _) {};
      expect(runner.executeBundle(bundleOf([returnInt(42)])), 42);
    });

    test(
        'F-SCC23-AST-2: a synchronous script error still throws out of '
        'executeBundle and is not also reported as an escape [2026-09-04]', () {
      final escapes = <Object>[];
      final runner = D4rtRunner();
      runner.onUncaughtError = (error, _) => escapes.add(error);

      expect(() => runner.executeBundle(bundleOf([throwString('boom')])),
          throwsA(anything));
      expect(escapes, isEmpty,
          reason: 'errors the caller can already observe are not routed to '
              'the hook — only escapes are');
    });

    test(
        'F-SCC23-AST-3: an error the platform raises outside the script future '
        'chain reaches the hook, unwrapped [2026-09-04]', () async {
      final escapes = <Object>[];
      final zoneErrors = <Object>[];

      await runZonedGuarded(() async {
        final runner = D4rtRunner();
        runner.onUncaughtError = (error, _) => escapes.add(error);
        runner.executeBundle(
            bundleOf([unawaitedFutureError('escaped'), returnInt(1)]));
        await Future<void>.delayed(const Duration(milliseconds: 40));
      }, (error, _) => zoneErrors.add(error));

      expect(escapes, hasLength(1));
      expect(escapes.single, 'escaped',
          reason: 'the interpreter-internal wrapper is removed before the '
              'value leaves the sandbox, so the embedder sees what the script '
              'actually threw');
      expect(zoneErrors, isEmpty,
          reason: 'a hook *contains* the error — that is what makes it usable '
              'as a sandbox boundary by a host running untrusted script');
    });

    test(
        'F-SCC23-AST-4: with no hook the escape still reaches the enclosing '
        'zone [2026-09-04]', () async {
      final zoneErrors = <Object>[];

      await runZonedGuarded(() async {
        D4rtRunner().executeBundle(
            bundleOf([unawaitedFutureError('escaped'), returnInt(1)]));
        await Future<void>.delayed(const Duration(milliseconds: 40));
      }, (error, _) => zoneErrors.add(error));

      expect(zoneErrors, hasLength(1),
          reason: 'the pre-existing routing is untouched when no hook is set; '
              'this is the property F-SCB9-14 depends on');
    });

    test('F-SCC23-AST-5: a hook that throws is not lost [2026-09-04]',
        () async {
      final zoneErrors = <Object>[];

      await runZonedGuarded(() async {
        final runner = D4rtRunner();
        runner.onUncaughtError = (_, _) => throw StateError('hook failed');
        runner.executeBundle(
            bundleOf([unawaitedFutureError('escaped'), returnInt(1)]));
        await Future<void>.delayed(const Duration(milliseconds: 40));
      }, (error, _) => zoneErrors.add(error));

      expect(zoneErrors, hasLength(1));
      expect(zoneErrors.single, isA<StateError>(),
          reason: "an embedder's hook is ordinary code and can be wrong; "
              'losing both errors would be the worst available outcome');
    });
  });
}
