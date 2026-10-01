/// WONEPRPD153 — the interpreted call stack, in the analyzer-free line.
///
/// The twin of `tom_d4rt`'s `woneprpd153_interpreted_trace_test.dart`. An error
/// leaving a script carries the script's frames — function and line — read
/// back through `D4rtRunner.lastErrorTrace`. Positions come from the bundle's
/// sources; a bundle built without them yields an empty trace.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

const _entry = 'package:t/main.dart';
const _source =
    'Object? inner() {\n'
    '  throw "deep";\n'
    '}\n'
    '\n'
    'Object? main() {\n'
    '  return inner();\n'
    '}\n';

SFunctionDeclaration _function(String name, SStatement statement) =>
    SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: SSimpleIdentifier(offset: 0, length: name.length, name: name),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          block: SBlock(offset: 0, length: 0, statements: [statement]),
        ),
      ),
    );

AstBundle _bundle({required bool withSources}) {
  final throwAt = _source.indexOf('throw');
  final returnAt = _source.indexOf('return');
  return AstBundle(
    entryPointUri: _entry,
    modules: {
      _entry: SCompilationUnit(
        offset: 0,
        length: _source.length,
        declarations: [
          _function(
            'inner',
            SExpressionStatement(
              offset: throwAt,
              length: 13,
              expression: SThrowExpression(
                offset: throwAt,
                length: 12,
                expression: SSimpleStringLiteral(
                  offset: throwAt + 6,
                  length: 6,
                  value: 'deep',
                ),
              ),
            ),
          ),
          _function(
            'main',
            SReturnStatement(
              offset: returnAt,
              length: 15,
              expression: SMethodInvocation(
                offset: returnAt + 7,
                length: 7,
                methodName: SSimpleIdentifier(
                  offset: returnAt + 7,
                  length: 5,
                  name: 'inner',
                ),
                argumentList: SArgumentList(offset: returnAt + 12, length: 2),
              ),
            ),
          ),
        ],
      ),
    },
    sources: withSources ? {_entry: _source} : null,
  );
}

void main() {
  test('WONEPRPD153-AST-1: a throw two calls deep reports both frames, '
      'innermost first, at their own lines [2026-10-01] (PASS)', () {
    final runner = D4rtRunner();
    expect(
      () => runner.executeBundle(_bundle(withSources: true)),
      throwsA(anything),
    );
    expect(
      [
        for (final f in runner.lastErrorTrace)
          '${f.member}@${f.line}:${f.column}',
      ],
      ['inner@2:3', 'main@6:3'],
    );
    expect(runner.lastErrorTrace.first.source, Uri.parse(_entry));
  });

  test('WONEPRPD153-AST-2: without sources the trace is empty rather than '
      'wrong [2026-10-01] (PASS)', () {
    final runner = D4rtRunner();
    expect(
      () => runner.executeBundle(_bundle(withSources: false)),
      throwsA(anything),
    );
    expect(runner.lastErrorTrace, isEmpty);
  });
}
