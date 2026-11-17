// ghissues67/AST — a collection a script creates keeps its written type
// arguments, in the analyzer-free tree.
//
// The mirror of
// `tom_d4rt/test/ghissues67_written_collection_type_arguments_test.dart`,
// which runs ten source shapes against native Dart's output. Here each case
// is a hand-built bundle: a written collection's `runtimeType`, `is` on an
// empty one (which passed every element check before), `as`, a script class
// as the type argument, and an extension's `K` bound from the written type -
// the `MapJsonExtension` case of GitHub #18. The collection stays the native
// object; its written type arguments are recorded beside it
// (`recordWrittenCollectionTypeArguments`).

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

/// `<name>[<arguments>]`
SNamedType _type(String name, [List<String> arguments = const []]) =>
    SNamedType(
      offset: 0,
      length: 0,
      name: _id(name),
      typeArguments: arguments.isEmpty ? null : _typeArgs(arguments),
    );

STypeArgumentList _typeArgs(List<String> names) => STypeArgumentList(
  offset: 0,
  length: 0,
  arguments: [for (final n in names) _type(n)],
);

/// `<T>[]`
SListLiteral _list(List<String> typeArguments) =>
    SListLiteral(offset: 0, length: 0, typeArguments: _typeArgs(typeArguments));

/// `<K, V>{}`
SSetOrMapLiteral _map(String k, String v) => SSetOrMapLiteral(
  offset: 0,
  length: 0,
  typeArguments: _typeArgs([k, v]),
  isMap: true,
);

/// `<value> is <type>`
SIsExpression _is(SExpression value, SNamedType type) =>
    SIsExpression(offset: 0, length: 0, expression: value, type: type);

/// `<target>.runtimeType`
SPropertyAccess _runtimeType(SExpression target) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id('runtimeType'),
);

/// `<target>.<name>()`
SMethodInvocation _call(SExpression? target, String name) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: target,
  operator: target == null ? null : '.',
  methodName: _id(name),
  argumentList: SArgumentList(offset: 0, length: 0),
);

/// `extension KeyKind<K, V> on Map<K, V> { String keyKind() => K.toString(); }`
final _keyKind = SExtensionDeclaration(
  offset: 0,
  length: 0,
  name: _id('KeyKind'),
  typeParameters: STypeParameterList(
    offset: 0,
    length: 0,
    typeParameters: [
      STypeParameter(offset: 0, length: 0, name: _id('K')),
      STypeParameter(offset: 0, length: 0, name: _id('V')),
    ],
  ),
  extendedType: _type('Map', ['K', 'V']),
  body: SBlockClassBody(
    offset: 0,
    length: 0,
    members: [
      SMethodDeclaration(
        offset: 0,
        length: 0,
        name: _id('keyKind'),
        returnType: _type('String'),
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SExpressionFunctionBody(
          offset: 0,
          length: 0,
          expression: _call(_id('K'), 'toString'),
        ),
      ),
    ],
  ),
);

/// `class P {}`
final _classP = SClassDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id('P')),
  body: SBlockClassBody(offset: 0, length: 0),
);

/// Runs `main() => [<results>]` after [declarations], each result rendered
/// as its `toString`.
List<String> _run(
  List<SExpression> results, [
  List<SCompilationUnitMember> declarations = const [],
]) {
  final result = D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: 'package:p/main.dart',
      modules: {
        'package:p/main.dart': SCompilationUnit(
          offset: 0,
          length: 0,
          declarations: [
            ...declarations,
            SFunctionDeclaration(
              offset: 0,
              length: 0,
              name: _id('main'),
              functionExpression: SFunctionExpression(
                offset: 0,
                length: 0,
                parameters: SFormalParameterList(offset: 0, length: 0),
                body: SExpressionFunctionBody(
                  offset: 0,
                  length: 0,
                  expression: SListLiteral(
                    offset: 0,
                    length: 0,
                    elements: results,
                  ),
                ),
              ),
            ),
          ],
        ),
      },
    ),
  );
  return [for (final value in result! as List) '$value'];
}

void main() {
  group('ghissues67/AST: written collection type arguments', () {
    test('GH67-AST-1: runtimeType names the written type arguments '
        '[2026-11-17]', () {
      expect(
        _run([
          _runtimeType(_list(['String'])),
          _runtimeType(_map('String', 'int')),
        ]),
        ['List<String>', '_Map<String, int>'],
      );
    });

    test('GH67-AST-2: an empty collection is tested by its written type '
        '[2026-11-17]', () {
      expect(
        _run([
          _is(_list(['String']), _type('List', ['int'])),
          _is(_list(['String']), _type('List', ['String'])),
          _is(_map('String', 'int'), _type('Map', ['int', 'int'])),
          _is(_list(['int']), _type('List', ['num'])),
          _is(_list(['num']), _type('List', ['int'])),
        ]),
        ['false', 'true', 'false', 'true', 'false'],
      );
    });

    test('GH67-AST-3: as refuses a collection whose written type does not '
        'fit [2026-11-17]', () {
      expect(
        () => _run([
          SAsExpression(
            offset: 0,
            length: 0,
            expression: _list(['String']),
            type: _type('List', ['int']),
          ),
        ]),
        throwsA(
          predicate(
            (Object e) => '$e'.contains('value of type List<String>'),
            'a cast error naming List<String>',
          ),
        ),
      );
    });

    test('GH67-AST-4: a script class as the type argument, and K bound from '
        'the written type (GitHub #18) [2026-11-17]', () {
      expect(
        _run(
          [
            _is(_list(['P']), _type('List', ['P'])),
            _is(_list(['P']), _type('List', ['String'])),
            _runtimeType(_list(['P'])),
            _call(_map('String', 'int'), 'keyKind'),
          ],
          [_classP, _keyKind],
        ),
        ['true', 'false', 'List<P>', 'String'],
      );
    });
  });
}
