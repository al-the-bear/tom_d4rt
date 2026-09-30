// SCF37/AST — the analyzer-free twin of
// `tom_d4rt/test/bridge/scf37_bridged_property_increment_test.dart`.
//
// `b.v++` / `++b.v` on a bridged getter/setter pair threw "Cannot
// increment/decrement property on non-instance object", while `b.v += 1`
// worked. The increment and decrement paths now step a bridged property
// through its getter and setter adapters.
//
// These run against the WORKING TREE of this interpreter, which the exec
// suites cannot (DGUC6), so the bundles are built from `SAstNode`s by hand.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class _NativeBox {
  _NativeBox(this.v);
  num v;
}

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

/// `b.v`, as the parser spells a property read on a plain identifier.
SPrefixedIdentifier _bv() => SPrefixedIdentifier(
  offset: 0,
  length: 0,
  prefix: _id('b'),
  identifier: _id('v'),
);

/// `(b).v`, which the parser keeps as a property access.
SPropertyAccess _parenBv() => SPropertyAccess(
  offset: 0,
  length: 0,
  target: SParenthesizedExpression(offset: 0, length: 0, expression: _id('b')),
  operator: '.',
  propertyName: _id('v'),
);

SStatement _final(String name, SExpression init) =>
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
            name: _id(name),
            initializer: init,
          ),
        ],
      ),
    );

/// Runs `main() { final b = Box(1); final r = STEP; return [r, b.v]; }`
/// with the `Box` bridge, where STEP is [step].
Object? _run(SExpression step) {
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
              value: 'package:test/box.dart',
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
                    _final(
                      'b',
                      SMethodInvocation(
                        offset: 0,
                        length: 0,
                        methodName: _id('Box'),
                        argumentList: SArgumentList(
                          offset: 0,
                          length: 0,
                          arguments: [
                            SIntegerLiteral(offset: 0, length: 1, value: 1),
                          ],
                        ),
                      ),
                    ),
                    _final('r', step),
                    SReturnStatement(
                      offset: 0,
                      length: 0,
                      expression: SListLiteral(
                        offset: 0,
                        length: 0,
                        elements: [_id('r'), _bv()],
                      ),
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
  final runner = D4rtRunner()
    ..registerBridgedClass(
      BridgedClass(
        nativeType: _NativeBox,
        name: 'Box',
        constructors: {
          '': (visitor, positional, named) => _NativeBox(positional[0] as num),
        },
        getters: {'v': (visitor, target) => (target as _NativeBox).v},
        setters: {
          'v': (visitor, target, value) =>
              (target as _NativeBox).v = value as num,
        },
      ),
      'package:test/box.dart',
    );
  return runner.executeBundle(bundle);
}

void main() {
  group('SCF37/AST: ++ and -- on a bridged property', () {
    test('F-SCF37-AST-1: postfix yields the old value and stores the new '
        '[2026-09-30] (PASS)', () {
      expect(
        _run(
          SPostfixExpression(
            offset: 0,
            length: 0,
            operand: _bv(),
            operator: '++',
          ),
        ),
        [1, 2],
      );
      expect(
        _run(
          SPostfixExpression(
            offset: 0,
            length: 0,
            operand: _bv(),
            operator: '--',
          ),
        ),
        [1, 0],
      );
    });

    test('F-SCF37-AST-2: prefix yields the new value [2026-09-30] (PASS)', () {
      expect(
        _run(
          SPrefixExpression(
            offset: 0,
            length: 0,
            operand: _bv(),
            operator: '++',
          ),
        ),
        [2, 2],
      );
      expect(
        _run(
          SPrefixExpression(
            offset: 0,
            length: 0,
            operand: _bv(),
            operator: '--',
          ),
        ),
        [0, 0],
      );
    });

    test('F-SCF37-AST-3: a property-access operand [2026-09-30] (PASS)', () {
      expect(
        _run(
          SPostfixExpression(
            offset: 0,
            length: 0,
            operand: _parenBv(),
            operator: '++',
          ),
        ),
        [1, 2],
      );
      expect(
        _run(
          SPrefixExpression(
            offset: 0,
            length: 0,
            operand: _parenBv(),
            operator: '--',
          ),
        ),
        [0, 0],
      );
    });
  });
}
