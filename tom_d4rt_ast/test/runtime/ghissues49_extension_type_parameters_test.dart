// GH49/AST — GitHub #18: an extension's own type parameters are bound, in
// the analyzer-free tree (ghissues49).
//
// The mirror of `tom_d4rt/test/ghissues49_extension_type_parameters_test.dart`,
// which runs source. Here each script is a hand-built bundle. Before the fix
// `extension KeyKind<K, V> on Map<K, V> { String keyKind() => K.toString(); }`
// threw `Undefined variable: K` for every receiver. K and V are now bound from
// the receiver's written type (a typed local, parameter or field), else from
// its runtime type arguments, else dynamic.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

const _entry = 'package:p/main.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

/// `<name>[<arguments>]`
SNamedType _type(String name, [List<String> arguments = const []]) =>
    SNamedType(
      offset: 0,
      length: 0,
      name: _id(name),
      typeArguments: arguments.isEmpty
          ? null
          : STypeArgumentList(
              offset: 0,
              length: 0,
              arguments: [for (final a in arguments) _type(a)],
            ),
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

/// `String <name>() => <typeParameter>.toString();`
SMethodDeclaration _kind(String name, String typeParameter) =>
    SMethodDeclaration(
      offset: 0,
      length: 0,
      name: _id(name),
      returnType: _type('String'),
      parameters: SFormalParameterList(offset: 0, length: 0),
      body: SExpressionFunctionBody(
        offset: 0,
        length: 0,
        expression: _call(_id(typeParameter), 'toString'),
      ),
    );

/// `extension KeyKind<K, V> on Map<K, V> { keyKind(), valueKind() }`
final _extension = SExtensionDeclaration(
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
    members: [_kind('keyKind', 'K'), _kind('valueKind', 'V')],
  ),
);

/// `final <type> <name> = <initializer>;`
SVariableDeclarationStatement _local(
  String name,
  SExpression initializer, [
  SNamedType? type,
]) => SVariableDeclarationStatement(
  offset: 0,
  length: 0,
  variables: SVariableDeclarationList(
    offset: 0,
    length: 0,
    isFinal: true,
    type: type,
    variables: [
      SVariableDeclaration(
        offset: 0,
        length: 0,
        name: _id(name),
        initializer: initializer,
      ),
    ],
  ),
);

/// Runs `main() { <statements> return [<results>]; }` with the extension and
/// the bridged `sameMap()` (a native `Map<String, int>`).
Object? _run(List<SStatement> statements, List<SExpression> results) {
  final runner = D4rtRunner()
    ..registerTopLevelFunction(
      'sameMap',
      (visitor, positional, named, typeArgs) => <String, int>{'x': 7},
      'package:n/n.dart',
    );
  return runner.executeBundle(
    AstBundle(
      entryPointUri: _entry,
      modules: {
        _entry: SCompilationUnit(
          offset: 0,
          length: 0,
          directives: [
            SImportDirective(offset: 0, length: 0, uri: _str('package:n/n.dart')),
          ],
          declarations: [
            _extension,
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
                      ...statements,
                      SReturnStatement(
                        offset: 0,
                        length: 0,
                        expression: SListLiteral(
                          offset: 0,
                          length: 0,
                          elements: results,
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
    ),
  );
}

void main() {
  group('GH49/AST: an extension\'s type parameters', () {
    test('F-GH49-AST-1: the issue - two declared views of one map '
        '(GitHub #18) [2026-11-14]', () {
      expect(
        _run(
          [
            _local('narrow', _call(null, 'sameMap'), _type('Map', ['String', 'int'])),
            _local('wide', _id('narrow'), _type('Map', ['dynamic', 'dynamic'])),
          ],
          [_call(_id('narrow'), 'keyKind'), _call(_id('wide'), 'keyKind')],
        ),
        ['String', 'dynamic'],
      );
    });

    test('F-GH49-AST-2: an untyped receiver binds K and V from the native '
        'map\'s runtime type arguments [2026-11-14]', () {
      expect(
        _run(
          [_local('m', _call(null, 'sameMap'))],
          [_call(_id('m'), 'keyKind'), _call(_id('m'), 'valueKind')],
        ),
        ['String', 'int'],
      );
    });

    test('F-GH49-AST-3: no written or reified type arguments bind dynamic '
        '[2026-11-14]', () {
      expect(
        _run(
          [
            _local(
              'm',
              SSetOrMapLiteral(offset: 0, length: 0, elements: const []),
            ),
          ],
          [_call(_id('m'), 'keyKind')],
        ),
        ['dynamic'],
      );
    });
  });
}
