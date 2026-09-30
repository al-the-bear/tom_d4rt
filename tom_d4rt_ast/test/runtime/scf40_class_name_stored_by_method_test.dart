// SCF40/AST — the analyzer-free twin of
// `tom_d4rt/test/scf40_class_name_stored_by_method_test.dart`.
//
// A class name stored in a set or map through a METHOD (`add`) or an index
// assignment (`m[String] = v`) was stored as its `BridgedClass`, so a lookup
// by `x.runtimeType` missed. It is now stored as its native `Type`, as a
// literal already was (SCD198).
//
// These run against the WORKING TREE of this interpreter, which the exec
// suites cannot (DGUC6), so the bundles are built from `SAstNode`s by hand.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SArgumentList _args([List<SExpression> a = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

SMethodInvocation _call(
  SExpression? target,
  String method, [
  List<SExpression> a = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(method),
  argumentList: _args(a),
);

/// `'x'.runtimeType`
SExpression _stringRuntimeType() => SPropertyAccess(
  offset: 0,
  length: 0,
  target: SSimpleStringLiteral(offset: 0, length: 3, value: 'x'),
  operator: '.',
  propertyName: _id('runtimeType'),
);

SIndexExpression _index(String target, SExpression key) =>
    SIndexExpression(offset: 0, length: 0, target: _id(target), index: key);

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

/// `<Type>{}`
SSetOrMapLiteral _typeSet() => SSetOrMapLiteral(
  offset: 0,
  length: 0,
  isSet: true,
  typeArguments: STypeArgumentList(
    offset: 0,
    length: 0,
    arguments: [SNamedType(offset: 0, length: 0, name: _id('Type'))],
  ),
);

SStatement _expr(SExpression e) =>
    SExpressionStatement(offset: 0, length: 0, expression: e);

/// Runs `main() { <statements> }`.
Object? _run(List<SStatement> statements) {
  const entry = 'package:probe/main.dart';
  final bundle = AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
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
                block: SBlock(offset: 0, length: 0, statements: statements),
              ),
            ),
          ),
        ],
      ),
    },
  );
  return D4rtRunner().executeBundle(bundle);
}

void main() {
  group('SCF40/AST: a class name stored by method or index', () {
    test('F-SCF40-AST-1: Set.add, then contains by runtimeType '
        '[2026-09-30] (PASS)', () {
      expect(
        _run([
          _final('s', _typeSet()),
          _expr(_call(_id('s'), 'add', [_id('String')])),
          SReturnStatement(
            offset: 0,
            length: 0,
            expression: _call(_id('s'), 'contains', [_stringRuntimeType()]),
          ),
        ]),
        isTrue,
      );
    });

    test('F-SCF40-AST-2: map and identity-map index assignment '
        '[2026-09-30] (PASS)', () {
      SStatement store(String map) => _expr(
        SAssignmentExpression(
          offset: 0,
          length: 0,
          leftHandSide: _index(map, _id('String')),
          operator: '=',
          rightHandSide: SIntegerLiteral(offset: 0, length: 1, value: 1),
        ),
      );
      expect(
        _run([
          _final('m', SSetOrMapLiteral(offset: 0, length: 0, isMap: true)),
          _final('i', _call(_id('Map'), 'identity')),
          store('m'),
          store('i'),
          SReturnStatement(
            offset: 0,
            length: 0,
            expression: SListLiteral(
              offset: 0,
              length: 0,
              elements: [
                _index('m', _stringRuntimeType()),
                _index('i', _stringRuntimeType()),
              ],
            ),
          ),
        ]),
        [1, 1],
      );
    });

    test('F-SCF40-AST-3: a list literal carries a class name as its Type '
        '[2026-09-30] (PASS)', () {
      expect(
        _run([
          _final('s', _typeSet()),
          _expr(
            _call(_id('s'), 'addAll', [
              SListLiteral(offset: 0, length: 0, elements: [_id('String')]),
            ]),
          ),
          SReturnStatement(
            offset: 0,
            length: 0,
            expression: _call(_id('s'), 'contains', [_stringRuntimeType()]),
          ),
        ]),
        isTrue,
      );
    });
  });
}
