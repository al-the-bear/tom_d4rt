// DART313B1/AST: the members Dart 3.13 added to bridged classes, in the
// analyzer-free tree.
//
// The mirror of `tom_d4rt/test/dart313b1_sdk_313_members_test.dart`, which runs
// source, compares the bit counts with the native ones on 3.13, and holds every
// member newer than the SDK floor to "bridged or declined". Here each script is
// a hand-built bundle through this tree's own stdlib bridges: the two `int` bit
// counts, `Future.pause`, and `List.unmodifiableOf` / `Map.unmodifiableOf`. The
// eight declined `Isolate` members are covered by
// `intentionally_unbridged_test.dart`, which asserts every declined key is
// absent from a fully registered environment.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SListLiteral _list(List<SCollectionElement> e) =>
    SListLiteral(offset: 0, length: 0, elements: e);

/// `<target>.<name>`
SPropertyAccess _prop(SExpression target, String name) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(name),
);

/// `<className>.<method>(<args>)`
SMethodInvocation _static(
  String className,
  String method, [
  List<SExpression> args = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: _id(className),
  operator: '.',
  methodName: _id(method),
  argumentList: SArgumentList(offset: 0, length: 0, arguments: args),
);

/// `main() [async] { return <result>; }` as a bundle, run on [D4rtRunner];
/// the result awaited when it is a Future.
Future<Object?> _run(SExpression result, {bool isAsync = false}) async {
  const entry = 'package:probe/main.dart';
  final value = D4rtRunner().executeBundle(
    AstBundle(
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
                  isAsync: isAsync,
                  block: SBlock(
                    offset: 0,
                    length: 0,
                    statements: [
                      SReturnStatement(
                        offset: 0,
                        length: 0,
                        expression: result,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      },
    ),
  );
  return value is Future ? await value : value;
}

void main() {
  group('DART313B1/AST: the Dart 3.13 members, on every SDK', () {
    test('F-DART313B1-AST-1: int.oneBitCount and int.trailingZeroBitCount '
        '[2026-11-09]', () async {
      final minusOne = SPrefixExpression(
        offset: 0,
        length: 0,
        operator: '-',
        operand: _int(1),
      );
      expect(
        await _run(
          _list([
            _prop(_int(5), 'oneBitCount'),
            _prop(minusOne, 'oneBitCount'),
            _prop(_int(0), 'trailingZeroBitCount'),
            _prop(_int(8), 'trailingZeroBitCount'),
          ]),
        ),
        [2, 64, 64, 3],
      );
    });

    test('F-DART313B1-AST-2: Future.pause completes with no value '
        '[2026-11-09]', () async {
      expect(
        await _run(
          SAwaitExpression(
            offset: 0,
            length: 0,
            expression: _static('Future', 'pause'),
          ),
          isAsync: true,
        ),
        isNull,
      );
    });

    test('F-DART313B1-AST-3: List.unmodifiableOf and Map.unmodifiableOf '
        '[2026-11-09]', () async {
      final result =
          await _run(
                _list([
                  _static('List', 'unmodifiableOf', [
                    _list([_int(1), _int(2)]),
                  ]),
                  _static('Map', 'unmodifiableOf', [
                    SSetOrMapLiteral(
                      offset: 0,
                      length: 0,
                      isMap: true,
                      elements: [
                        SMapLiteralEntry(
                          offset: 0,
                          length: 0,
                          key: _str('a'),
                          value: _int(1),
                        ),
                      ],
                    ),
                  ]),
                ]),
              )
              as List;
      expect(result, [
        [1, 2],
        {'a': 1},
      ]);
      expect(() => (result[0] as List).add(3), throwsUnsupportedError);
      expect(() => (result[1] as Map)['b'] = 2, throwsUnsupportedError);
    });
  });
}
