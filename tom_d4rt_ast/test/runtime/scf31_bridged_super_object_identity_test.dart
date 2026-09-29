// SCF31/AST — the analyzer-free twin of
// `tom_d4rt/test/bridge/scf31_bridged_super_object_identity_test.dart`.
//
// A script subclass of a CONCRETE bridged class has no proxy: its base is
// constructed natively and that object is what native code holds and hands
// back. The checks now recognise it as the instance whose
// `bridgedSuperObject` it is, so a parameter declared as the script class
// binds it and `is` answers for the instance — and an unrelated base does
// not.
//
// These run against the WORKING TREE of this interpreter, which the exec
// suites cannot (DGUC6), so the bundles are built from `SAstNode`s by hand.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class _NativeBox {
  int value = 1;
}

Object? _held;

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SArgumentList _args([List<SExpression> arguments = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: arguments);

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

/// `class MeasureBox extends Box { int extra = 7; }`
SClassDeclaration _measureBox() => SClassDeclaration(
  offset: 0,
  length: 0,
  name: _id('MeasureBox'),
  extendsClause: SExtendsClause(offset: 0, length: 0, superclass: _type('Box')),
  members: [
    SFieldDeclaration(
      offset: 0,
      length: 0,
      fields: SVariableDeclarationList(
        offset: 0,
        length: 0,
        type: _type('int'),
        variables: [
          SVariableDeclaration(
            offset: 0,
            length: 0,
            name: _id('extra'),
            initializer: SIntegerLiteral(offset: 0, length: 1, value: 7),
          ),
        ],
      ),
    ),
  ],
);

/// `int size(MeasureBox b) => b.extra;`
SFunctionDeclaration _size() => SFunctionDeclaration(
  offset: 0,
  length: 0,
  name: _id('size'),
  functionExpression: SFunctionExpression(
    offset: 0,
    length: 0,
    parameters: SFormalParameterList(
      offset: 0,
      length: 0,
      parameters: [
        SSimpleFormalParameter(
          offset: 0,
          length: 0,
          name: _id('b'),
          type: _type('MeasureBox'),
        ),
      ],
    ),
    body: SExpressionFunctionBody(
      offset: 0,
      length: 0,
      expression: SPrefixedIdentifier(
        offset: 0,
        length: 0,
        prefix: _id('b'),
        identifier: _id('extra'),
      ),
    ),
  ),
);

/// `main() { Box.stash(<stashed>()); return <result>; }`
AstBundle _bundle(String stashed, SExpression result) {
  const entry = 'package:probe/main.dart';
  return AstBundle(
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
              value: 'package:test/box.dart',
            ),
          ),
        ],
        declarations: [
          _measureBox(),
          _size(),
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: SFormalParameterList(
                offset: 0,
                length: 0,
                parameters: const [],
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
                      expression: _call(_id('Box'), 'stash', [
                        // `Box()` / `MeasureBox()` without `new` parses as a
                        // method invocation, and the converter keeps that.
                        _call(null, stashed),
                      ]),
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
}

Object? _run(String stashed, SExpression result) {
  _held = null;
  final runner = D4rtRunner()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: _NativeBox,
        name: 'Box',
        constructors: {'': (visitor, positional, named) => _NativeBox()},
        staticMethods: {
          // Native code keeps the NATIVE object, as a framework keeps a
          // render object.
          'stash': (visitor, positional, named, typeArgs) {
            final value = positional[0];
            _held = value is InterpretedInstance
                ? value.bridgedSuperObject
                : value;
            return null;
          },
          'last': (visitor, positional, named, typeArgs) => _held,
        },
      ),
      'package:test/box.dart',
    );
  return runner.executeBundle(_bundle(stashed, result));
}

SExpression get _last => _call(_id('Box'), 'last');

SIsExpression _isMeasureBox() => SIsExpression(
  offset: 0,
  length: 0,
  expression: _last,
  type: _type('MeasureBox'),
);

void main() {
  group('SCF31/AST: a bridged super object is recognised as its instance', () {
    test('F-SCF31-AST-1: a parameter declared as the script class binds the '
        'native object handed back [2026-09-29] (PASS)', () {
      expect(_run('MeasureBox', _call(null, 'size', [_last])), 7);
    });

    test(
      'F-SCF31-AST-2: `is` answers for the instance [2026-09-29] (PASS)',
      () {
        expect(_run('MeasureBox', _isMeasureBox()), isTrue);
      },
    );

    test('F-SCF31-AST-3: control — a base nobody subclassed is still a base '
        '[2026-09-29] (PASS)', () {
      expect(_run('Box', _isMeasureBox()), isFalse);
      expect(
        () => _run('Box', _call(null, 'size', [_last])),
        throwsA(predicate((e) => '$e'.contains("'MeasureBox'"))),
      );
    });

    test('F-SCF31-AST-4: values an Expando refuses are never looked up '
        '[2026-09-29] (PASS)', () {
      // `interpretedBehind` is asked about every operand of `==`.
      for (final v in <Object>[1, 1.5, 's', true, (1, 2)]) {
        expect(D4.interpretedBehind(v), isNull, reason: '$v');
      }
    });
  });
}
