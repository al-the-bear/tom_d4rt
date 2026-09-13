/// SCD77 mirror coverage for `tom_d4rt_ast`.
///
/// `Uri.isScheme` moved from the `Uri` bridge's `getters` map to its `methods`
/// map — it is `bool isScheme(String)` in the SDK — and the shadowed
/// `TimeoutException.toString` getter was deleted. Both stdlib trees are
/// asserted code-identical by F-SCD49-2, so the change landed here in the same
/// commit; this file is what says the analyzer-free interpreter still CALLS it
/// correctly, which the reference tree's own script test cannot say about this
/// runtime.
///
/// **Scope.** `tom_d4rt_ast` cannot parse Dart source, so the bundle below is a
/// hand-built `SAstNode` tree for `Uri.parse('https://a.b/c').isScheme(...)`.
/// The three-case script-level suite lives in
/// `tom_d4rt/test/scd77_uri_is_scheme_test.dart`; it cannot be run against this
/// tree, because `tom_d4rt_exec` — the only runner with a parser — resolves
/// `tom_d4rt_ast` from pub.dev rather than by path (DGUC6).
///
/// **Control.** Reverting `isScheme` to a getter leaves this PASSING, because
/// the interpreter's property-access-then-call path resolves a getter that
/// returns a tear-off just as well — which is the whole reason the shape
/// survived for months, and confirmed by running the reference's script suite
/// on `tom_d4rt_exec` against published 0.65.0, where the getter is still in
/// place: all three cases pass. `F-SCD77-4` in `scc24_native_name_coverage_test.dart` is
/// the case with teeth against that revert. What this file catches is an adapter
/// that reads the wrong argument: swapping `positionalArgs[0]` for a literal
/// fails the false case below.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

void main() {
  SSimpleIdentifier ident(String name) =>
      SSimpleIdentifier(offset: 0, length: name.length, name: name);

  SArgumentList args(List<SExpression> arguments) =>
      SArgumentList(offset: 0, length: 0, arguments: arguments);

  SExpression str(String value) =>
      SSimpleStringLiteral(offset: 0, length: 0, value: value);

  /// `main() => Uri.parse('<uri>').isScheme('<scheme>');`
  AstBundle isSchemeBundle(String uri, String scheme) {
    const entryUri = 'package:t/main.dart';
    final call = SMethodInvocation(
      offset: 0,
      length: 0,
      target: SMethodInvocation(
        offset: 0,
        length: 0,
        target: ident('Uri'),
        operator: '.',
        methodName: ident('parse'),
        argumentList: args([str(uri)]),
      ),
      operator: '.',
      methodName: ident('isScheme'),
      argumentList: args([str(scheme)]),
    );
    return AstBundle(
      entryPointUri: entryUri,
      modules: {
        entryUri: SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            SFunctionDeclaration(
              offset: 0,
              length: 0,
              name: ident('main'),
              functionExpression: SFunctionExpression(
                offset: 0,
                length: 0,
                parameters: SFormalParameterList(offset: 0, length: 0),
                body: SExpressionFunctionBody(
                  offset: 0,
                  length: 0,
                  expression: call,
                ),
              ),
            ),
          ],
        ),
      },
    );
  }

  group('SCD77/AST: isScheme is callable as a method', () {
    test('F-SCD77-AST-1: isScheme answers for the scheme it was asked about '
        '[2026-09-13]', () {
      expect(
        D4rtRunner().executeBundle(isSchemeBundle('https://a.b/c', 'https')),
        isTrue,
      );
      expect(
        D4rtRunner().executeBundle(isSchemeBundle('https://a.b/c', 'http')),
        isFalse,
        reason:
            'an adapter that ignored positionalArgs[0] would pass the case '
            'above and fail this one',
      );
    });
  });
}
