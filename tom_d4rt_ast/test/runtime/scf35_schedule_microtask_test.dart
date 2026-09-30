// SCF35/AST — the analyzer-free twin of
// `tom_d4rt/test/scf35_schedule_microtask_test.dart`.
//
// `scheduleMicrotask` was undefined in both trees and recorded as unbridged in
// neither. It is now a `dart:async` global whose callback runs under the Timer
// discipline: deferred to the microtask queue, and an error it throws reaches
// `onUncaughtError` unwrapped (SCC23).
//
// These run against the WORKING TREE of this interpreter, which the exec
// suites cannot (DGUC6), so the bundles are built from `SAstNode`s by hand.

@TestOn('vm')
library;

import 'dart:async';

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SArgumentList _args(List<SExpression> arguments) =>
    SArgumentList(offset: 0, length: 0, arguments: arguments);

SMethodInvocation _call(
  SExpression? target,
  String method,
  List<SExpression> args,
) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(method),
  argumentList: _args(args),
);

SStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: 0, value: v);

SExpressionStatement _stmt(SExpression e) =>
    SExpressionStatement(offset: 0, length: 0, expression: e);

/// `() { <statements> }`
SFunctionExpression _closure(List<SStatement> statements) =>
    SFunctionExpression(
      offset: 0,
      length: 0,
      parameters: SFormalParameterList(offset: 0, length: 0),
      body: SBlockFunctionBody(
        offset: 0,
        length: 0,
        block: SBlock(offset: 0, length: 0, statements: statements),
      ),
    );

/// `import 'dart:async'; main() { <statements> }`
AstBundle _bundle(List<SStatement> statements) {
  const entry = 'package:probe/main.dart';
  return AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [
          SImportDirective(offset: 0, length: 0, uri: _str('dart:async')),
        ],
        declarations: [
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: _closure(statements),
          ),
        ],
      ),
    },
  );
}

/// `final log = [];`
SStatement _declareLog() => SVariableDeclarationStatement(
  offset: 0,
  length: 0,
  variables: SVariableDeclarationList(
    offset: 0,
    length: 0,
    isFinal: true,
    variables: [
      SVariableDeclaration(
        offset: 0,
        length: 0,
        name: _id('log'),
        initializer: SListLiteral(offset: 0, length: 0),
      ),
    ],
  ),
);

SStatement _logAdd(String value) =>
    _stmt(_call(_id('log'), 'add', [_str(value)]));

SStatement _return(SExpression e) =>
    SReturnStatement(offset: 0, length: 0, expression: e);

void main() {
  group('SCF35/AST: scheduleMicrotask', () {
    test('F-SCF35-AST-1: the callback runs after the synchronous rest of the '
        'script [2026-09-30] (PASS)', () async {
      // main() { final log = []; scheduleMicrotask(() { log.add('m'); });
      //          log.add('sync'); return log; }
      final log =
          D4rtRunner().executeBundle(
                _bundle([
                  _declareLog(),
                  _stmt(
                    _call(null, 'scheduleMicrotask', [
                      _closure([_logAdd('m')]),
                    ]),
                  ),
                  _logAdd('sync'),
                  _return(_id('log')),
                ]),
              )
              as List;
      expect(log, ['sync'], reason: 'the microtask has not run yet');
      await Future<void>.delayed(Duration.zero);
      expect(log, ['sync', 'm']);
    });

    test('F-SCF35-AST-2: an error thrown in the callback reaches '
        'onUncaughtError unwrapped [2026-09-30] (PASS)', () async {
      final escapes = <Object>[];
      await runZonedGuarded(() async {
        final runner = D4rtRunner()
          ..onUncaughtError = (error, _) => escapes.add(error);
        final result = runner.executeBundle(
          _bundle([
            _stmt(
              _call(null, 'scheduleMicrotask', [
                _closure([
                  _stmt(
                    SThrowExpression(
                      offset: 0,
                      length: 0,
                      expression: _str('from the microtask'),
                    ),
                  ),
                ]),
              ]),
            ),
            _return(SIntegerLiteral(offset: 0, length: 1, value: 1)),
          ]),
        );
        expect(result, 1);
        await Future<void>.delayed(const Duration(milliseconds: 20));
      }, (error, _) => fail('escaped the hook: $error'));
      expect(escapes, ['from the microtask']);
    });

    test('F-SCF35-AST-3: a non-function argument is refused by name '
        '[2026-09-30] (PASS)', () {
      expect(
        () => D4rtRunner().executeBundle(
          _bundle([
            _stmt(
              _call(null, 'scheduleMicrotask', [
                SIntegerLiteral(offset: 0, length: 1, value: 5),
              ]),
            ),
          ]),
        ),
        throwsA(
          predicate(
            (e) => '$e'.contains('scheduleMicrotask requires one positional'),
          ),
        ),
      );
    });
  });
}
