// GH9/AST — a class whose supertype (or a type bound it uses) is declared in a
// library that is still loading, in the analyzer-free tree (GitHub
// al-the-bear/tom_d4rt#9).
//
// The mirror of `tom_d4rt/test/gh9_import_cycle_test.dart`, which runs source
// and covers every shape, plus intl 0.20.3 itself. Here each library is a
// hand-built bundle module, so the set is the issue's two mechanisms and the
// check that survives them: an interface across an import cycle, a superclass
// a barrel exports later, a method bound a barrel exports later, and a
// deferred class still rejected for a missing interface member.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

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

SExportDirective _export(String uri) =>
    SExportDirective(offset: 0, length: 0, uri: _str(uri));

SConstructorDeclaration _ctor(String className) => SConstructorDeclaration(
  offset: 0,
  length: 0,
  typeName: _id(className),
  parameters: _params(),
  body: SBlockFunctionBody(
    offset: 0,
    length: 0,
    block: SBlock(offset: 0, length: 0),
  ),
);

/// `String <name>() { return '<value>'; }`, or abstract without [value].
SMethodDeclaration _method(
  String name, {
  String? value,
  STypeParameterList? typeParameters,
  List<SFormalParameter> params = const [],
}) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  returnType: _type('String'),
  isAbstract: value == null,
  typeParameters: typeParameters,
  parameters: _params(params),
  body: value == null
      ? SEmptyFunctionBody(offset: 0, length: 0)
      : _returns(_str(value)),
);

SClassDeclaration _class(
  String name,
  List<SClassMember> members, {
  bool isAbstract = false,
  String? extendsName,
  List<String> implementsNames = const [],
}) => SClassDeclaration(
  offset: 0,
  length: 0,
  isAbstract: isAbstract,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id(name)),
  extendsClause: extendsName == null
      ? null
      : SExtendsClause(offset: 0, length: 0, superclass: _type(extendsName)),
  implementsClause: implementsNames.isEmpty
      ? null
      : SImplementsClause(
          offset: 0,
          length: 0,
          interfaces: [for (final n in implementsNames) _type(n)],
        ),
  body: SBlockClassBody(offset: 0, length: 0, members: members),
);

/// `<className>().<method>(<args>)`
SMethodInvocation _callOnNew(
  String className,
  String method, [
  List<SExpression> args = const [],
]) => SMethodInvocation(
  offset: 0,
  length: 0,
  target: SInstanceCreationExpression(
    offset: 0,
    length: 0,
    constructorName: SConstructorName(
      offset: 0,
      length: 0,
      type: _type(className),
    ),
    argumentList: _args(),
  ),
  operator: '.',
  methodName: _id(method),
  argumentList: _args(args),
);

SCompilationUnit _unit(
  List<SDirective> directives, [
  List<SCompilationUnitMember> declarations = const [],
]) => SCompilationUnit(
  offset: 0,
  length: 0,
  directives: directives,
  declarations: declarations,
);

/// Runs `main() { return <result>; }` in `package:p/main.dart`, which
/// imports [entryImport], against the other [modules].
Object? _run(
  String entryImport,
  Map<String, SCompilationUnit> modules,
  SExpression result,
) {
  const entry = 'package:p/main.dart';
  return D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        ...modules,
        entry: _unit(
          [_import(entryImport)],
          [
            SFunctionDeclaration(
              offset: 0,
              length: 0,
              name: _id('main'),
              functionExpression: SFunctionExpression(
                offset: 0,
                length: 0,
                parameters: _params(),
                body: _returns(result),
              ),
            ),
          ],
        ),
      },
    ),
  );
}

/// A barrel exporting `user.dart` (first) and `base.dart`, both importing
/// the barrel back; `base.dart` declares `Base` (with `b()`) and `Iface`.
Map<String, SCompilationUnit> _viaBarrel(List<SCompilationUnitMember> user) => {
  'package:p/barrel.dart': _unit([
    _export('package:p/user.dart'),
    _export('package:p/base.dart'),
  ]),
  'package:p/user.dart': _unit([_import('package:p/barrel.dart')], user),
  'package:p/base.dart': _unit(
    [_import('package:p/barrel.dart')],
    [
      _class('Base', [
        _ctor('Base'),
        _method('b', value: 'base'),
      ], isAbstract: true),
      _class('Iface', [_method('i')], isAbstract: true),
    ],
  ),
};

void main() {
  group('GH9/AST: supertypes declared in a library still loading', () {
    test('GH9-AST-1: implements an interface across an import cycle '
        '[2026-11-07]', () {
      expect(
        // Entered through helpers, as intl's `intl_helpers.dart` is: its
        // import of lookup runs before helpers has declared MessageLookup.
        _run('package:p/helpers.dart', {
          'package:p/helpers.dart': _unit(
            [
              _import('package:p/lookup.dart'),
              _export('package:p/lookup.dart'),
            ],
            [_class('MessageLookup', [], isAbstract: true)],
          ),
          'package:p/lookup.dart': _unit(
            [_import('package:p/helpers.dart')],
            [
              _class(
                'CompositeMessageLookup',
                [_ctor('CompositeMessageLookup'), _method('name', value: 'c')],
                implementsNames: ['MessageLookup'],
              ),
            ],
          ),
        }, _callOnNew('CompositeMessageLookup', 'name')),
        'c',
      );
    });

    test('GH9-AST-2: extends a class a barrel exports later [2026-11-07]', () {
      expect(
        _run(
          'package:p/barrel.dart',
          _viaBarrel([
            _class('Parser', [_ctor('Parser')], extendsName: 'Base'),
          ]),
          _callOnNew('Parser', 'b'),
        ),
        'base',
      );
    });

    test('GH9-AST-3: a method type-parameter bound a barrel exports later '
        '[2026-11-07]', () {
      // class Format { String parseWith<P extends Base>(P p) => 'parsed'; }
      expect(
        _run(
          'package:p/barrel.dart',
          _viaBarrel([
            _class('Parser', [_ctor('Parser')], extendsName: 'Base'),
            _class('Format', [
              _ctor('Format'),
              _method(
                'parseWith',
                value: 'parsed',
                typeParameters: STypeParameterList(
                  offset: 0,
                  length: 0,
                  typeParameters: [
                    STypeParameter(
                      offset: 0,
                      length: 0,
                      name: _id('P'),
                      bound: _type('Base'),
                    ),
                  ],
                ),
                params: [
                  SRegularFormalParameter(
                    offset: 0,
                    length: 0,
                    name: _id('p'),
                    type: _type('P'),
                  ),
                ],
              ),
            ]),
          ]),
          _callOnNew('Format', 'parseWith', [
            SInstanceCreationExpression(
              offset: 0,
              length: 0,
              constructorName: SConstructorName(
                offset: 0,
                length: 0,
                type: _type('Parser'),
              ),
              argumentList: _args(),
            ),
          ]),
        ),
        'parsed',
      );
    });

    test('GH9-AST-4: a deferred class missing an interface member is still '
        'rejected [2026-11-07]', () {
      expect(
        () => _run(
          'package:p/barrel.dart',
          _viaBarrel([
            _class('Bad', [_ctor('Bad')], implementsNames: ['Iface']),
          ]),
          _str('unreached'),
        ),
        throwsA(
          predicate(
            (Object e) =>
                e.toString().contains("interface method 'i'") &&
                e.toString().contains("'Bad'"),
          ),
        ),
      );
    });
  });
}
