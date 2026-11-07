// GH7/AST — an interpreted class whose path to a bridged type runs through
// interpreted interfaces, in the analyzer-free tree (pull request
// al-the-bear/tom_d4rt#7).
//
// The mirror of `tom_d4rt/test/gh7_transitive_bridged_interface_test.dart`,
// which runs source and covers every shape. Here each script is a hand-built
// bundle, so the set is the walk's edges and its two refusals: an interface
// that implements the bridge, one that extends it, a mixin whose interface
// reaches it, a cyclic graph that ends, and a bridge of the same name over
// another native type.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

abstract class Gh7Shape {}

/// Two unrelated native classes, each bridged under the name `Gh7Token`.
class _TokenA {}

class _TokenB {}

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SImportDirective _import(String uri) =>
    SImportDirective(offset: 0, length: 0, uri: _str(uri));

SArgumentList _args([List<SExpression> a = const []]) =>
    SArgumentList(offset: 0, length: 0, arguments: a);

SBlockFunctionBody _returns(SExpression e) => SBlockFunctionBody(
  offset: 0,
  length: 0,
  block: SBlock(
    offset: 0,
    length: 0,
    statements: [SReturnStatement(offset: 0, length: 0, expression: e)],
  ),
);

SBlockClassBody _emptyBody() => SBlockClassBody(offset: 0, length: 0);

/// A class body; a concrete class gets `<className>() {}`, which a hand-built
/// bundle has to spell out.
SBlockClassBody _body(String className, {required bool isAbstract}) =>
    SBlockClassBody(
      offset: 0,
      length: 0,
      members: [
        if (!isAbstract)
          SConstructorDeclaration(
            offset: 0,
            length: 0,
            typeName: _id(className),
            parameters: SFormalParameterList(offset: 0, length: 0),
            body: SBlockFunctionBody(
              offset: 0,
              length: 0,
              block: SBlock(offset: 0, length: 0),
            ),
          ),
      ],
    );

SImplementsClause? _implements(List<String> names) => names.isEmpty
    ? null
    : SImplementsClause(
        offset: 0,
        length: 0,
        interfaces: [for (final n in names) _type(n)],
      );

SClassDeclaration _class(
  String name, {
  bool isAbstract = false,
  String? extendsName,
  List<String> implementsNames = const [],
  List<String> withNames = const [],
}) => SClassDeclaration(
  offset: 0,
  length: 0,
  isAbstract: isAbstract,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id(name)),
  extendsClause: extendsName == null
      ? null
      : SExtendsClause(offset: 0, length: 0, superclass: _type(extendsName)),
  implementsClause: _implements(implementsNames),
  withClause: withNames.isEmpty
      ? null
      : SWithClause(
          offset: 0,
          length: 0,
          mixinTypes: [for (final n in withNames) _type(n)],
        ),
  body: _body(name, isAbstract: isAbstract),
);

/// `<name>(<paramType> p) { return <result>; }`, or `main()` without a type.
SFunctionDeclaration _function(
  String name,
  SExpression result, [
  String? paramType,
]) => SFunctionDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  functionExpression: SFunctionExpression(
    offset: 0,
    length: 0,
    parameters: SFormalParameterList(
      offset: 0,
      length: 0,
      parameters: [
        if (paramType != null)
          SRegularFormalParameter(
            offset: 0,
            length: 0,
            name: _id('p'),
            type: _type(paramType),
          ),
      ],
    ),
    body: _returns(result),
  ),
);

/// `<className>()`
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

/// `<function>(<className>())`
SMethodInvocation _callWithNew(String function, String className) =>
    SMethodInvocation(
      offset: 0,
      length: 0,
      methodName: _id(function),
      argumentList: _args([_new(className)]),
    );

/// `<className>() is <typeName>`
SIsExpression _isNew(String className, String typeName) => SIsExpression(
  offset: 0,
  length: 0,
  expression: _new(className),
  type: _type(typeName),
);

SListLiteral _list(List<SExpression> e) =>
    SListLiteral(offset: 0, length: 0, elements: e);

SCompilationUnit _unit(
  List<String> imports,
  List<SCompilationUnitMember> declarations,
) => SCompilationUnit(
  offset: 0,
  length: 0,
  directives: [for (final uri in imports) _import(uri)],
  declarations: declarations,
);

D4rtRunner _runner() {
  D4rtRunner register(D4rtRunner runner, Type type, String name, String uri) =>
      runner..registerBridgedClass(
        BridgedClass(nativeType: type, name: name, isAbstract: true),
        uri,
        sourceUri: uri,
      );
  final runner = D4rtRunner();
  register(runner, Gh7Shape, 'Gh7Shape', 'package:shapes/shapes.dart');
  register(runner, _TokenA, 'Gh7Token', 'package:a/a.dart');
  register(runner, _TokenB, 'Gh7Token', 'package:b/b.dart');
  return runner;
}

/// [declarations] after the shapes import, `take(Gh7Shape p) { return 'ok'; }`
/// and `main() { return <result>; }`.
Object? _run(List<SCompilationUnitMember> declarations, SExpression result) {
  const entry = 'package:probe/main.dart';
  return _runner().executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        entry: _unit(
          ['package:shapes/shapes.dart'],
          [
            ...declarations,
            _function('take', _str('ok'), 'Gh7Shape'),
            _function('main', result),
          ],
        ),
      },
    ),
  );
}

/// `[take(<className>()), <className>() is Gh7Shape]`
SListLiteral _bindsAndIs(String className) =>
    _list([_callWithNew('take', className), _isNew(className, 'Gh7Shape')]);

final _rejected = throwsA(
  predicate(
    (Object e) => e.toString().contains("is not a subtype of type 'Gh7Shape'"),
  ),
);

void main() {
  group('GH7/AST: interpreted paths to a bridged type', () {
    test('GH7-AST-1: through an interpreted interface that implements it '
        '[2026-11-07]', () {
      expect(
        _run([
          _class('I', isAbstract: true, implementsNames: ['Gh7Shape']),
          _class('ViaI', implementsNames: ['I']),
        ], _bindsAndIs('ViaI')),
        ['ok', true],
      );
    });

    test('GH7-AST-2: through an interpreted interface that extends it '
        '[2026-11-07]', () {
      expect(
        _run([
          _class('J', isAbstract: true, extendsName: 'Gh7Shape'),
          _class('ViaJ', implementsNames: ['J']),
        ], _bindsAndIs('ViaJ')),
        ['ok', true],
      );
    });

    test('GH7-AST-3: through a mixin whose interface reaches it '
        '[2026-11-07]', () {
      expect(
        _run([
          _class('I', isAbstract: true, implementsNames: ['Gh7Shape']),
          SMixinDeclaration(
            offset: 0,
            length: 0,
            name: _id('M'),
            implementsClause: _implements(['I']),
            body: _emptyBody(),
          ),
          _class('WithM', withNames: ['M']),
        ], _bindsAndIs('WithM')),
        ['ok', true],
      );
    });
  });

  group('GH7/AST: what is still refused', () {
    test('GH7-AST-4: a cyclic interface graph ends in a refusal '
        '[2026-11-07]', () {
      final cycle = [
        _class('A', isAbstract: true, implementsNames: ['B']),
        _class('B', isAbstract: true, implementsNames: ['A']),
        _class('C', implementsNames: ['A']),
        _class('U'),
      ];
      expect(_run(cycle, _list([_isNew('C', 'Gh7Shape'), _isNew('C', 'U')])), [
        false,
        false,
      ]);
      expect(() => _run(cycle, _callWithNew('take', 'C')), _rejected);
    }, timeout: const Timeout(Duration(seconds: 30)));

    test('GH7-AST-5: a bridge of the same name over another native type is '
        'not the type [2026-11-07]', () {
      // ua.dart sees library a's Gh7Token, ub.dart library b's; the two are
      // never in one scope.
      Object? tokens(SExpression result) {
        const entry = 'package:p/main.dart';
        return _runner().executeBundle(
          AstBundle(
            entryPointUri: entry,
            modules: {
              'package:p/ua.dart': _unit(
                ['package:a/a.dart'],
                [
                  _class('I', isAbstract: true, implementsNames: ['Gh7Token']),
                  _class('X', implementsNames: ['Gh7Token']),
                  _class('Y', implementsNames: ['I']),
                  _function('takeA', _str('a'), 'Gh7Token'),
                ],
              ),
              'package:p/ub.dart': _unit(
                ['package:b/b.dart'],
                [_function('takeB', _str('b'), 'Gh7Token')],
              ),
              entry: _unit(
                ['package:p/ua.dart', 'package:p/ub.dart'],
                [_function('main', result)],
              ),
            },
          ),
        );
      }

      expect(
        tokens(_list([_callWithNew('takeA', 'X'), _callWithNew('takeA', 'Y')])),
        ['a', 'a'],
      );
      for (final className in ['X', 'Y']) {
        expect(
          () => tokens(_callWithNew('takeB', className)),
          throwsA(
            predicate(
              (Object e) =>
                  e.toString().contains("is not a subtype of type 'Gh7Token'"),
            ),
          ),
        );
      }
    });
  });
}
