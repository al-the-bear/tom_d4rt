// SCF38/AST — the analyzer-free twin of
// `tom_d4rt/test/bridge/scf38_native_closure_bridge_test.dart`.
//
// A function type prints as `(params) => Ret`, and the name-shaped bridge
// passes read its RETURN type: a host-built `(int x) => x` was claimed by the
// `int` bridge and a `() => Map<String, Object>` tear-off by `Map`. A native
// function value now resolves to the `Function` bridge, and calling it stays
// a native call.
//
// These run against the WORKING TREE of this interpreter, which the exec
// suites cannot (DGUC6), so the bundles are built from `SAstNode`s by hand.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class _Host {}

final _closures = <String, Object>{
  'intToInt': (int x) => x,
  'mapTearOff': _mapFactory,
};

Map<String, Object> _mapFactory() => {'k': 1};

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SArgumentList _args(List<SExpression> a) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

/// `Host.closure('<name>')`.
SExpression _hostClosure(String name) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: _id('Host'),
  operator: '.',
  methodName: _id('closure'),
  argumentList: _args([
    SSimpleStringLiteral(offset: 0, length: 0, value: name),
  ]),
);

SExpression _call(SExpression? target, String method, [List<SExpression>? a]) =>
    SMethodInvocation(
      offset: 0,
      length: 0,
      target: target,
      operator: target == null ? null : '.',
      methodName: _id(method),
      argumentList: _args(a ?? const []),
    );

/// Runs `main() { final f = Host.closure('<closure>'); return RESULT; }`.
Object? _run(String closure, SExpression result) {
  const entry = 'package:probe/main.dart';
  final bundle = AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [
          SImportDirective(
            offset: 0,
            length: 0,
            uri: SSimpleStringLiteral(
              offset: 0,
              length: 0,
              value: 'package:test/host.dart',
            ),
          ),
        ],
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
                block: SBlock(
                  offset: 0,
                  length: 0,
                  statements: [
                    SVariableDeclarationStatement(
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
                            name: _id('f'),
                            initializer: _hostClosure(closure),
                          ),
                        ],
                      ),
                    ),
                    SReturnStatement(offset: 0, length: 0, expression: result),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    },
  );
  final runner = D4rtRunner()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: _Host,
        name: 'Host',
        staticMethods: {
          'closure': (visitor, positional, named, typeArgs) =>
              _closures[positional[0] as String],
        },
      ),
      'package:test/host.dart',
    );
  return runner.executeBundle(bundle);
}

void main() {
  group('SCF38/AST: a host-built closure is a Function', () {
    test('F-SCF38-AST-1: toBridgedInstance resolves (int) => int and a '
        '() => Map tear-off to Function [2026-09-30] (PASS)', () {
      final env = Environment();
      Stdlib(env).register();
      for (final closure in [(int x) => x, _mapFactory]) {
        expect(
          env.toBridgedInstance(closure)?.bridgedClass.name,
          'Function',
          reason: '${closure.runtimeType}',
        );
      }
    });

    test('F-SCF38-AST-2: toString, hashCode and runtimeType answer as a '
        'function does [2026-09-30] (PASS)', () {
      final closure = _closures['intToInt']!;
      expect(
        _run(
          'intToInt',
          SListLiteral(
            offset: 0,
            length: 0,
            elements: [
              _call(_id('f'), 'toString'),
              SPrefixedIdentifier(
                offset: 0,
                length: 0,
                prefix: _id('f'),
                identifier: _id('hashCode'),
              ),
              _call(
                SPrefixedIdentifier(
                  offset: 0,
                  length: 0,
                  prefix: _id('f'),
                  identifier: _id('runtimeType'),
                ),
                'toString',
              ),
            ],
          ),
        ),
        [closure.toString(), closure.hashCode, closure.runtimeType.toString()],
      );
    });

    test('F-SCF38-AST-3: the Map-returning tear-off is not a Map, and still '
        'calls [2026-09-30] (PASS)', () {
      expect(
        () => _run(
          'mapTearOff',
          SPrefixedIdentifier(
            offset: 0,
            length: 0,
            prefix: _id('f'),
            identifier: _id('length'),
          ),
        ),
        throwsA(predicate((e) => '$e'.contains('length'))),
      );
      expect(_run('mapTearOff', _call(null, 'f')), {'k': 1});
    });

    test('F-SCF38-AST-4: calling a host closure is unchanged '
        '[2026-09-30] (PASS)', () {
      expect(
        _run(
          'intToInt',
          SBinaryExpression(
            offset: 0,
            length: 0,
            leftOperand: _call(null, 'f', [
              SIntegerLiteral(offset: 0, length: 2, value: 41),
            ]),
            operator: '+',
            rightOperand: SIntegerLiteral(offset: 0, length: 1, value: 1),
          ),
        ),
        42,
      );
    });
  });
}
