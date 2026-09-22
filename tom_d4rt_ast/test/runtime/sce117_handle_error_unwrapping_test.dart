// SCE117/AST — the analyzer-free twin of
// `tom_d4rt/test/sce117_handle_error_unwrapping_test.dart`.
//
// SCD73 made the unwrapping of the interpreter's internal exception
// unconditional for every callback the zone REGISTERS, and left one route it
// could not reach: a handler passed to `Stream.handleError`, which the SDK
// invokes with no zone registration at all. `Zone.errorCallback` fires for that
// shape and — the reason it is the right seam and not merely an available one —
// is NOT an error-zone hook, so `Zone.errorZone` still resolves to the parent's
// and F-SCD73-AST-2's property is untouched.
//
// WHY THIS TREE NEEDS ITS OWN CASE: the zone specification is a SEPARATE COPY
// in `D4rtRunner`, not shared code. Nothing in the reference tree's suite runs
// a line of it. The mirror rule says the fix lands in both; this is what says
// it landed.
//
// ABLATED 2026-09-22 by removing `errorCallback` from `D4rtRunner`'s
// `_scriptZoneSpecification`: F-SCE117-AST-1 fails with an
// `InternalInterpreterD4rtException`.

@TestOn('vm')
library;

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String name) =>
    SSimpleIdentifier(offset: 0, length: name.length, name: name);

SArgumentList _args([List<SExpression> arguments = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: arguments);

SFormalParameterList _params(List<String> names) => SFormalParameterList(
  offset: 0,
  length: 0,
  parameters: [
    for (final name in names)
      SSimpleFormalParameter(offset: 0, length: 0, name: _id(name)),
  ],
);

SInstanceCreationExpression _new(
  String type, [
  List<SExpression> args = const [],
]) => SInstanceCreationExpression(
  offset: 0,
  length: 0,
  constructorName: SConstructorName(
    offset: 0,
    length: 0,
    type: SNamedType(offset: 0, length: 0, name: _id(type)),
  ),
  argumentList: _args(args),
);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length, value: v);

/// `(<params>) { <statements> }`
SFunctionExpression _closure(List<String> params, List<SStatement> body) =>
    SFunctionExpression(
      offset: 0,
      length: 0,
      parameters: _params(params),
      body: SBlockFunctionBody(
        offset: 0,
        length: 0,
        block: SBlock(offset: 0, length: 0, statements: body),
      ),
    );

SMethodInvocation _call(
  SExpression? target,
  String method, [
  List<SExpression> args = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(method),
  argumentList: _args(args),
);

/// `await Future.delayed(Duration(milliseconds: <ms>));`
SStatement _awaitDelay(int ms) => SExpressionStatement(
  offset: 0,
  length: 0,
  expression: SAwaitExpression(
    offset: 0,
    length: 0,
    expression: _call(_id('Future'), 'delayed', [
      SInstanceCreationExpression(
        offset: 0,
        length: 0,
        constructorName: SConstructorName(
          offset: 0,
          length: 0,
          type: SNamedType(offset: 0, length: 0, name: _id('Duration')),
        ),
        argumentList: SArgumentList(
          offset: 0,
          length: 0,
          arguments: [
            SNamedExpression(
              offset: 0,
              length: 0,
              name: SLabel(offset: 0, length: 0, label: _id('milliseconds')),
              expression: SIntegerLiteral(offset: 0, length: 2, value: ms),
            ),
          ],
        ),
      ),
    ]),
  ),
);

/// ```
/// main() async {
///   var c = StreamController();
///   c.stream.handleError((e) { throw StateError('he'); }).listen((x) {});
///   c.addError(ArgumentError('orig'));
///   await Future.delayed(Duration(milliseconds: 30));
///   return 'script-completed';
/// }
/// ```
AstBundle _handleErrorBundle() {
  const entryUri = 'package:t/main.dart';

  final declareController = SVariableDeclarationStatement(
    offset: 0,
    length: 0,
    variables: SVariableDeclarationList(
      offset: 0,
      length: 0,
      variables: [
        SVariableDeclaration(
          offset: 0,
          length: 0,
          name: _id('c'),
          initializer: _new('StreamController'),
        ),
      ],
    ),
  );

  final throwingHandler = _closure('e'.split(','), [
    SExpressionStatement(
      offset: 0,
      length: 0,
      expression: SThrowExpression(
        offset: 0,
        length: 0,
        expression: _new('StateError', [_str('he')]),
      ),
    ),
  ]);

  final attach = SExpressionStatement(
    offset: 0,
    length: 0,
    expression: _call(
      _call(
        SPropertyAccess(
          offset: 0,
          length: 0,
          target: _id('c'),
          operator: '.',
          propertyName: _id('stream'),
        ),
        'handleError',
        [throwingHandler],
      ),
      'listen',
      [
        _closure(['x'], const []),
      ],
    ),
  );

  final addError = SExpressionStatement(
    offset: 0,
    length: 0,
    expression: _call(_id('c'), 'addError', [
      _new('ArgumentError', [_str('orig')]),
    ]),
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
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: SFormalParameterList(offset: 0, length: 0),
              body: SBlockFunctionBody(
                offset: 0,
                length: 0,
                isAsync: true,
                block: SBlock(
                  offset: 0,
                  length: 0,
                  statements: [
                    declareController,
                    attach,
                    addError,
                    _awaitDelay(30),
                    SReturnStatement(
                      offset: 0,
                      length: 0,
                      expression: _str('script-completed'),
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

void main() {
  group('SCE117/AST: the handleError seam', () {
    test('F-SCE117-AST-1: a handleError handler that throws arrives unwrapped '
        '[2026-09-22] (PASS)', () async {
      final zoneErrors = <Object>[];
      Object? result;

      await runZonedGuarded(() async {
        final raw = D4rtRunner().executeBundle(_handleErrorBundle());
        result = raw is Future ? await raw : raw;
      }, (error, _) => zoneErrors.add(error));
      await Future<void>.delayed(const Duration(milliseconds: 80));

      expect(result, 'script-completed');
      expect(zoneErrors, hasLength(1));
      expect(zoneErrors.single, isNot(isA<InternalInterpreterD4rtException>()));
      expect(zoneErrors.single, isA<StateError>());
      expect((zoneErrors.single as StateError).message, 'he');
      // Still correct on a value that no longer needs it, so an embedder's
      // defensive call has not become a bug.
      expect(unwrapScriptError(zoneErrors.single), same(zoneErrors.single));
    });
  });
}
