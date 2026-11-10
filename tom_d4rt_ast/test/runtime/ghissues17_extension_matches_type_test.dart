// GH17/AST — an extension applies to subtypes of its `on` type, not to any
// type of the same name, in the analyzer-free tree (ghissues17).
//
// The mirror of `tom_d4rt/test/ghissues17_extension_matches_type_test.dart`,
// which runs source. Here each script is a hand-built bundle: an extension on
// a prefixed imported `Base` next to a local `Base`, and an extension on one
// of two bridges named `Gh17Token`. Before the fix `Environment.
// _matchesExtensionType` also accepted a type of the same NAME, so the local
// `Base` and the other bridge got the extension; the local `Base` then failed
// inside it ("Error executing extension method").

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

const _entry = 'package:p/main.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SNamedType _type(String n, [String? prefix]) => SNamedType(
  offset: 0,
  length: 0,
  name: _id(n),
  importPrefix: prefix == null ? null : _id(prefix),
);

SArgumentList _args() => SArgumentList(offset: 0, length: 0);

SFormalParameterList _params() => SFormalParameterList(offset: 0, length: 0);

SBlockFunctionBody _returns(SExpression e) => SBlockFunctionBody(
  offset: 0,
  length: 0,
  block: SBlock(
    offset: 0,
    length: 0,
    statements: [SReturnStatement(offset: 0, length: 0, expression: e)],
  ),
);

SImportDirective _import(String uri, String prefix) =>
    SImportDirective(offset: 0, length: 0, uri: _str(uri), prefix: _id(prefix));

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

/// `String <name>() { return '<value>'; }`
SMethodDeclaration _method(String name, String value) => SMethodDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  returnType: _type('String'),
  parameters: _params(),
  body: _returns(_str(value)),
);

/// `class <name> [extends <prefix.>Base] { <name>(); ... }`
SClassDeclaration _class(
  String name, {
  List<SClassMember> members = const [],
  bool isAbstract = false,
  SNamedType? extendsType,
}) => SClassDeclaration(
  offset: 0,
  length: 0,
  isAbstract: isAbstract,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id(name)),
  extendsClause: extendsType == null
      ? null
      : SExtendsClause(offset: 0, length: 0, superclass: extendsType),
  body: SBlockClassBody(
    offset: 0,
    length: 0,
    members: [_ctor(name), ...members],
  ),
);

/// `extension X on <onType> { String x() { return 'x'; } }`
SExtensionDeclaration _extension(SNamedType onType) => SExtensionDeclaration(
  offset: 0,
  length: 0,
  name: _id('X'),
  extendedType: onType,
  body: SBlockClassBody(offset: 0, length: 0, members: [_method('x', 'x')]),
);

/// `main() { return <prefix.>name().x(); }`
SFunctionDeclaration _mainCallingX(String className, [String? prefix]) =>
    SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: _id('main'),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: _params(),
        body: _returns(
          SMethodInvocation(
            offset: 0,
            length: 0,
            target: SInstanceCreationExpression(
              offset: 0,
              length: 0,
              constructorName: SConstructorName(
                offset: 0,
                length: 0,
                type: _type(className, prefix),
              ),
              argumentList: _args(),
            ),
            operator: '.',
            methodName: _id('x'),
            argumentList: _args(),
          ),
        ),
      ),
    );

Object? _run(
  List<SDirective> directives,
  List<SCompilationUnitMember> declarations, {
  Map<String, SCompilationUnit> modules = const {},
  D4rtRunner? runner,
}) => (runner ?? D4rtRunner()).executeBundle(
  AstBundle(
    entryPointUri: _entry,
    modules: {
      ...modules,
      _entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: directives,
        declarations: declarations,
      ),
    },
  ),
);

/// The refusal of a member no extension supplies — not an extension that ran
/// on the wrong type and failed inside.
final Matcher _noExtension = throwsA(
  predicate(
    (Object e) =>
        (e.toString().contains('no suitable extension method found') ||
            e.toString().contains('has no instance method named')) &&
        !e.toString().contains('Error executing extension method'),
    'no extension applied',
  ),
);

class _NativeTokenA {}

class _NativeTokenB {}

D4rtRunner _twoTokens() => D4rtRunner()
  ..registerBridgedClass(
    BridgedClass(
      nativeType: _NativeTokenA,
      name: 'Gh17Token',
      constructors: {'': (visitor, positional, named) => _NativeTokenA()},
    ),
    'package:a/a.dart',
  )
  ..registerBridgedClass(
    BridgedClass(
      nativeType: _NativeTokenB,
      name: 'Gh17Token',
      constructors: {'': (visitor, positional, named) => _NativeTokenB()},
    ),
    'package:b/b.dart',
  );

void main() {
  group('GH17/AST: an extension does not apply by name', () {
    test('F-GH17-AST-1: an extension on an imported class is not applied to a '
        'local class of the same name [2026-11-10]', () {
      // types.dart: `abstract class Base { String b() { return 'base'; } }`
      final types = SCompilationUnit(
        offset: 0,
        length: 0,
        declarations: [
          _class('Base', isAbstract: true, members: [_method('b', 'base')]),
        ],
      );
      List<SCompilationUnitMember> declarations(SFunctionDeclaration main) => [
        _class('Base'),
        _extension(_type('Base', 'l')),
        _class('W', extendsType: _type('Base', 'l')),
        main,
      ];
      final directives = [_import('package:p/types.dart', 'l')];
      final modules = {'package:p/types.dart': types};
      expect(
        _run(directives, declarations(_mainCallingX('W')), modules: modules),
        'x',
      );
      expect(
        () => _run(
          directives,
          declarations(_mainCallingX('Base')),
          modules: modules,
        ),
        _noExtension,
      );
    });

    test('F-GH17-AST-2: an extension on one bridge is not applied to another '
        'bridge of the same name [2026-11-10]', () {
      final directives = [
        _import('package:a/a.dart', 'a'),
        _import('package:b/b.dart', 'b'),
      ];
      final extension = _extension(_type('Gh17Token', 'a'));
      expect(
        _run(directives, [
          extension,
          _mainCallingX('Gh17Token', 'a'),
        ], runner: _twoTokens()),
        'x',
      );
      expect(
        () => _run(directives, [
          extension,
          _mainCallingX('Gh17Token', 'b'),
        ], runner: _twoTokens()),
        _noExtension,
      );
    });
  });
}
