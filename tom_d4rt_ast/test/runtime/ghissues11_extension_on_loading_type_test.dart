// GHI11/AST — an extension whose `on` type is declared in a library that is
// still loading, in the analyzer-free tree (ghissues11, a GitHub
// al-the-bear/tom_d4rt#9 follow-up).
//
// The mirror of `tom_d4rt/test/ghissues11_extension_on_loading_type_test.dart`,
// which runs source. Here each library is a hand-built bundle module: an
// extension a barrel declares before the export that declares its `on` type,
// the same across a two-library import cycle, a prefixed `on` type next to a
// same-named local class, and an undefined `on` type, still reported. Before
// the fix the first three failed with `Could not resolve 'on' type 'Base' for
// extension 'X': Type not found or not a recognized core type.`

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

/// `extension <name> on <prefix.>Base { String x() { return 'x'; } }`
SExtensionDeclaration _extension(
  String name,
  String onType, {
  String? prefix,
}) => SExtensionDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  extendedType: SNamedType(
    offset: 0,
    length: 0,
    name: _id(onType),
    importPrefix: prefix == null ? null : _id(prefix),
  ),
  body: SBlockClassBody(
    offset: 0,
    length: 0,
    members: [_method('x', value: 'x')],
  ),
);

/// `class W extends <prefix.>Base { W(); }`
SClassDeclaration _w({String? prefix}) => SClassDeclaration(
  offset: 0,
  length: 0,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id('W')),
  extendsClause: SExtendsClause(
    offset: 0,
    length: 0,
    superclass: SNamedType(
      offset: 0,
      length: 0,
      name: _id('Base'),
      importPrefix: prefix == null ? null : _id(prefix),
    ),
  ),
  body: SBlockClassBody(offset: 0, length: 0, members: [_ctor('W')]),
);

/// Runs `main() { return W().x(); }` in `package:p/main.dart`, with
/// [directives] and [declarations], against the other [modules].
Object? _run(
  List<SDirective> directives,
  Map<String, SCompilationUnit> modules, {
  List<SCompilationUnitMember> declarations = const [],
}) {
  const entry = 'package:p/main.dart';
  return D4rtRunner().executeBundle(
    AstBundle(
      entryPointUri: entry,
      modules: {
        ...modules,
        entry: _unit(directives, [
          ...declarations,
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: _params(),
              body: _returns(_callOnNew('W', 'x')),
            ),
          ),
        ]),
      },
    ),
  );
}

/// `Base` (abstract, with `b()`) declared in a module importing [back].
SCompilationUnit _baseModule(
  String back, [
  List<SCompilationUnitMember> more = const [],
]) => _unit(
  [_import(back)],
  [
    _class('Base', [
      _ctor('Base'),
      _method('b', value: 'base'),
    ], isAbstract: true),
    ...more,
  ],
);

/// A barrel exporting `user.dart` (first) and `base.dart`, both importing
/// the barrel back.
Map<String, SCompilationUnit> _viaBarrel(List<SCompilationUnitMember> user) => {
  'package:p/barrel.dart': _unit([
    _export('package:p/user.dart'),
    _export('package:p/base.dart'),
  ]),
  'package:p/user.dart': _unit([_import('package:p/barrel.dart')], user),
  'package:p/base.dart': _baseModule('package:p/barrel.dart'),
};

void main() {
  group(
    'GHI11/AST: an extension on a type declared in a library still loading',
    () {
      test('F-GHI11-AST-1: through a barrel that exports the type later '
          '[2026-11-09]', () {
        expect(
          _run([
            _import('package:p/barrel.dart'),
          ], _viaBarrel([_extension('X', 'Base'), _w()])),
          'x',
        );
      });

      test('F-GHI11-AST-2: across a two-library import cycle [2026-11-09]', () {
        // main imports a.dart, whose import of b.dart loads first; b.dart
        // imports a.dart back, still loading, so X is declared before Base.
        expect(
          _run(
            [_import('package:p/a.dart'), _import('package:p/b.dart')],
            {
              'package:p/a.dart': _baseModule('package:p/b.dart', [_w()]),
              'package:p/b.dart': _unit(
                [_import('package:p/a.dart')],
                [_extension('X', 'Base')],
              ),
            },
          ),
          'x',
        );
      });

      test('F-GHI11-AST-3: a prefixed `on` type binds the imported class, not a '
          'same-named local one [2026-11-09]', () {
        expect(
          _run(
            [
              SImportDirective(
                offset: 0,
                length: 0,
                uri: _str('package:p/types.dart'),
                prefix: _id('l'),
              ),
            ],
            {
              'package:p/types.dart': _unit([], [
                _class('Base', [
                  _ctor('Base'),
                  _method('b', value: 'base'),
                ], isAbstract: true),
              ]),
            },
            declarations: [
              _class('Base', [_ctor('Base')]),
              _extension('X', 'Base', prefix: 'l'),
              _w(prefix: 'l'),
            ],
          ),
          'x',
        );
      });

      test('F-GHI11-AST-4: an undefined `on` type is still reported '
          '[2026-11-09]', () {
        expect(
          () => _run([
            _import('package:p/barrel.dart'),
          ], _viaBarrel([_extension('X', 'Missing'), _w()])),
          throwsA(
            predicate(
              (Object e) => e.toString().contains(
                "Could not resolve 'on' type 'Missing' for extension 'X'",
              ),
            ),
          ),
        );
      });
    },
  );
}
