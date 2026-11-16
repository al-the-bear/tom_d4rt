// GH20/AST — a top-level function whose signature names a class of a library
// in the same import cycle, in the analyzer-free tree (GitHub
// al-the-bear/tom_d4rt#20).
//
// The mirror of `tom_d4rt/test/gh20_function_signature_import_cycle_test.dart`,
// which runs the issue's three files as source. Here each library is a
// hand-built bundle module of the same graph: `main.dart` imports `node.dart`,
// which imports `helper.dart` before declaring `Node`; `helper.dart` imports
// `node.dart` back. Loading helper.dart failed with `Undefined variable: Node`
// for `T identity<T extends Node>(T x)`, and with `Type 'Node' not found` for
// a return type `Node`. Both are now resolved once the outermost load
// returns; the bound is still checked on a call, the return type (and DFUB6's
// applied return type `List<Node>`) on a return, and an undefined name is
// still reported.
//
// Found with it (GH20-AST-6): a block body returning the function's own type
// parameter refused an interpreted instance; it is now checked against this
// call's type argument.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SNamedType _type(String n, [List<String> args = const []]) => SNamedType(
  offset: 0,
  length: 0,
  name: _id(n),
  typeArguments: args.isEmpty
      ? null
      : STypeArgumentList(
          offset: 0,
          length: 0,
          arguments: [for (final a in args) _type(a)],
        ),
);

SArgumentList _args([List<SExpression> a = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

SFormalParameterList _params([List<SFormalParameter> p = const []]) =>
    SFormalParameterList(offset: 0, length: 0, parameters: p);

SBlockFunctionBody _returns(SExpression e) => SBlockFunctionBody(
  offset: 0,
  length: 0,
  block: SBlock(
    offset: 0,
    length: 0,
    statements: [SReturnStatement(offset: 0, length: 0, expression: e)],
  ),
);

SImportDirective _import(String uri) =>
    SImportDirective(offset: 0, length: 0, uri: _str(uri));

SClassDeclaration _class(
  String name, {
  String? extendsName,
}) => SClassDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id(name)),
  extendsClause: extendsName == null
      ? null
      : SExtendsClause(offset: 0, length: 0, superclass: _type(extendsName)),
  body: SBlockClassBody(
    offset: 0,
    length: 0,
    members: [
      SConstructorDeclaration(
        offset: 0,
        length: 0,
        typeName: _id(name),
        parameters: _params(),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          block: SBlock(offset: 0, length: 0),
        ),
      ),
    ],
  ),
);

/// `<returnType> <name><<T extends bound>>(<params>) { return <result>; }`
SFunctionDeclaration _function(
  String name,
  SExpression result, {
  STypeAnnotation? returnType,
  String? typeParameter,
  String? bound,
  List<SFormalParameter> params = const [],
}) {
  final typeParameters = typeParameter == null
      ? null
      : STypeParameterList(
          offset: 0,
          length: 0,
          typeParameters: [
            STypeParameter(
              offset: 0,
              length: 0,
              name: _id(typeParameter),
              bound: bound == null ? null : _type(bound),
            ),
          ],
        );
  return SFunctionDeclaration(
    offset: 0,
    length: 0,
    name: _id(name),
    returnType: returnType,
    typeParameters: typeParameters,
    functionExpression: SFunctionExpression(
      offset: 0,
      length: 0,
      typeParameters: typeParameters,
      parameters: _params(params),
      body: _returns(result),
    ),
  );
}

/// `<name><<typeArgument>>(<args>)`
SMethodInvocation _call(
  String name, [
  List<SExpression> args = const [],
  String? typeArgument,
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  methodName: _id(name),
  typeArguments: typeArgument == null
      ? null
      : STypeArgumentList(
          offset: 0,
          length: 0,
          arguments: [_type(typeArgument)],
        ),
  argumentList: _args(args),
);

SInstanceCreationExpression _new(String className) =>
    SInstanceCreationExpression(
      offset: 0,
      length: 0,
      constructorName: SConstructorName(
        offset: 0,
        length: 0,
        type: _type(className),
      ),
      argumentList: _args(),
    );

SIsExpression _is(SExpression e, String type) =>
    SIsExpression(offset: 0, length: 0, expression: e, type: _type(type));

SCompilationUnit _unit(
  List<SDirective> directives, [
  List<SCompilationUnitMember> declarations = const [],
]) => SCompilationUnit(
  offset: 0,
  length: 0,
  directives: directives,
  declarations: declarations,
);

/// The issue's graph: `helper.dart` declares [helper] and `marker()`, and
/// `main() { return <result>; }` imports node.dart and helper.dart.
Object? _run(List<SCompilationUnitMember> helper, SExpression result) {
  const entry = 'package:p/main.dart';
  return D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        entry: _unit(
          [_import('package:p/node.dart'), _import('package:p/helper.dart')],
          [_function('main', result)],
        ),
        'package:p/node.dart': _unit(
          [_import('package:p/helper.dart')],
          [
            _class('Node'),
            _class('Leaf', extendsName: 'Node'),
            _function('answer', _call('marker'), returnType: _type('int')),
          ],
        ),
        'package:p/helper.dart': _unit(
          [_import('package:p/node.dart')],
          [...helper, _function('marker', _int(7), returnType: _type('int'))],
        ),
      },
    ),
  );
}

/// `T identity<T extends Node>(T x) { return x; }`
final _identity = _function(
  'identity',
  _id('x'),
  returnType: _type('T'),
  typeParameter: 'T',
  bound: 'Node',
  params: [
    SRegularFormalParameter(
      offset: 0,
      length: 0,
      name: _id('x'),
      type: _type('T'),
    ),
  ],
);

void main() {
  group('GH20/AST: a top-level function signature across an import cycle', () {
    test('GH20-AST-1: the issue - a bound naming the cycle\'s class, never '
        'called [2026-11-16]', () {
      expect(_run([_identity], _call('answer')), 7);
    });

    test('GH20-AST-2: the deferred bound is checked when the function is '
        'called [2026-11-16]', () {
      expect(
        _run([
          _identity,
        ], _is(_call('identity', [_new('Leaf')], 'Leaf'), 'Leaf')),
        isTrue,
      );
      expect(
        () => _run([_identity], _call('identity', [_str('s')], 'String')),
        throwsA(
          predicate(
            (Object e) => e.toString().contains(
              "Type argument 'String' for type parameter 'T' does not satisfy "
              "bound 'Node' in function 'identity'",
            ),
          ),
        ),
      );
    });

    test('GH20-AST-3: a return type naming the cycle\'s class, checked on '
        'return [2026-11-16]', () {
      final make = _function('make', _new('Leaf'), returnType: _type('Node'));
      final bad = _function('bad', _str('s'), returnType: _type('Node'));
      expect(_run([make, bad], _is(_call('make'), 'Leaf')), isTrue);
      expect(
        () => _run([make, bad], _call('bad')),
        throwsA(
          predicate(
            (Object e) => e.toString().contains("return type of 'Node'"),
          ),
        ),
      );
    });

    test('GH20-AST-4: an applied return type `List<Node>` is resolved with '
        'it and still checked [2026-11-16]', () {
      SFunctionDeclaration all(String elementType, SExpression element) =>
          _function(
            'all',
            SListLiteral(
              offset: 0,
              length: 0,
              typeArguments: STypeArgumentList(
                offset: 0,
                length: 0,
                arguments: [_type(elementType)],
              ),
              elements: [element],
            ),
            returnType: _type('List', ['Node']),
          );
      expect(
        _run([all('Leaf', _new('Leaf'))], _is(_call('all'), 'List')),
        isTrue,
      );
      expect(
        () => _run([all('String', _str('s'))], _call('all')),
        throwsA(
          predicate((Object e) => e.toString().contains("can't be returned")),
        ),
      );
    });

    test('GH20-AST-6: a block body returning the function\'s type parameter '
        'is checked against this call\'s type argument [2026-11-16]', () {
      // `T make<T>() { return 's'; }` and `List<T> wrap<T>(T x) { return [x]; }`
      final make = _function(
        'make',
        _str('s'),
        returnType: _type('T'),
        typeParameter: 'T',
      );
      final wrap = _function(
        'wrap',
        SListLiteral(offset: 0, length: 0, elements: [_id('x')]),
        returnType: _type('List', ['T']),
        typeParameter: 'T',
        params: [
          SRegularFormalParameter(
            offset: 0,
            length: 0,
            name: _id('x'),
            type: _type('T'),
          ),
        ],
      );
      expect(_run([make, wrap], _call('make', [], 'String')), 's');
      expect(
        _run([make, wrap], _is(_call('wrap', [_new('Leaf')], 'Leaf'), 'List')),
        isTrue,
      );
      expect(
        () => _run([make, wrap], _call('make', [], 'int')),
        throwsA(
          predicate(
            (Object e) => e.toString().contains(
              "A value of type 'String' can't be returned from the function "
              "'make' because it has a return type of 'int'",
            ),
          ),
        ),
      );
    });

    test('GH20-AST-5: an undefined bound or return type is still reported '
        '[2026-11-16]', () {
      expect(
        () => _run([
          _function('lost', _int(1), typeParameter: 'T', bound: 'Missing'),
        ], _call('answer')),
        throwsA(predicate((Object e) => e.toString().contains('Missing'))),
      );
      expect(
        () => _run([
          _function('lost', _int(1), returnType: _type('Gone')),
        ], _call('answer')),
        throwsA(predicate((Object e) => e.toString().contains("'Gone'"))),
      );
    });
  });
}
