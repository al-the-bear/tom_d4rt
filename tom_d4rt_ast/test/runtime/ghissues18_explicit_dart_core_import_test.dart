// GH18/AST — a library that imports `dart:core` explicitly, imported by an
// entry that declares a class of the same name as one of the library's
// (ghissues18).
//
//   // package:p/types.dart
//   import 'dart:core';
//   abstract class Base { String b() { return 'base'; } }
//   class W extends Base { W(); }
//   // package:p/main.dart (entry)
//   import 'package:p/types.dart' as l;
//   class Base { Base(); }
//   main() { return l.W().b(); }
//
// Measured 2026-11-10 on this tree (0.224.0): without the prefix (F-GH18-AST-2,
// -3) `executeBundle` threw `Unsupported operation: FrozenNameMap is frozen
// and cannot be mutated.` before `main` ran. The entry's pass 1 had created
// its `Base` placeholder, and the import that followed replaced it with the
// library's `Base` (an import won every name conflict), already populated and
// frozen, which pass 2 then wrote into. An imported library's own class lost
// the same way (F-GH18-AST-4): its imports run before its pass 1, which
// skipped a name the import had bound. A library's own class, mixin or enum
// now shadows an imported one, as in Dart. The explicit `dart:core` import is
// how ghissues11 met it; it is not needed for the defect. tom_d4rt had the
// same two paths (its `ghissues18_explicit_dart_core_import_test.dart`).

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

const _entry = 'package:p/main.dart';
const _types = 'package:p/types.dart';

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

SImportDirective _import(String uri, [String? prefix]) => SImportDirective(
  offset: 0,
  length: 0,
  uri: _str(uri),
  prefix: prefix == null ? null : _id(prefix),
);

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

SClassDeclaration _class(
  String name, {
  List<SClassMember> members = const [],
  bool isAbstract = false,
  String? extendsName,
}) => SClassDeclaration(
  offset: 0,
  length: 0,
  isAbstract: isAbstract,
  namePart: SNameWithTypeParameters(offset: 0, length: 0, typeName: _id(name)),
  extendsClause: extendsName == null
      ? null
      : SExtendsClause(offset: 0, length: 0, superclass: _type(extendsName)),
  body: SBlockClassBody(
    offset: 0,
    length: 0,
    members: [_ctor(name), ...members],
  ),
);

/// `types.dart`: `import 'dart:core' [as <corePrefix>];`, an abstract `Base`
/// with `<corePrefix.>String b() { return 'base'; }`, and `class W extends
/// Base`.
SCompilationUnit _typesLibrary({String? corePrefix}) => SCompilationUnit(
  offset: 0,
  length: 0,
  directives: [_import('dart:core', corePrefix)],
  declarations: [
    _class(
      'Base',
      isAbstract: true,
      members: [
        SMethodDeclaration(
          offset: 0,
          length: 0,
          name: _id('b'),
          returnType: _type('String', corePrefix),
          parameters: _params(),
          body: _returns(_str('base')),
        ),
      ],
    ),
    _class('W', extendsName: 'Base'),
  ],
);

/// `<prefix.>className().b()`
SMethodInvocation _newThenB(String className, [String? prefix]) =>
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
      methodName: _id('b'),
      argumentList: _args(),
    );

/// `<name>() { return <result>; }`
SFunctionDeclaration _function(String name, SExpression result) =>
    SFunctionDeclaration(
      offset: 0,
      length: 0,
      name: _id(name),
      functionExpression: SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: _params(),
        body: _returns(result),
      ),
    );

Object? _bundle(Map<String, SCompilationUnit> modules) => D4rtRunner()
    .executeBundle(AstBundle(entryPointUri: _entry, modules: modules));

/// The entry: imports `types.dart` (with [prefix]), declares its own `Base`,
/// and returns `<prefix.>W().b()`.
Object? _run({String? prefix, String? corePrefix}) => _bundle({
  _types: _typesLibrary(corePrefix: corePrefix),
  _entry: SCompilationUnit(
    offset: 0,
    length: 0,
    directives: [_import(_types, prefix)],
    declarations: [_class('Base'), _function('main', _newThenB('W', prefix))],
  ),
});

void main() {
  group('GH18/AST: a library importing dart:core explicitly', () {
    test('F-GH18-AST-1: imported with a prefix by an entry declaring the same '
        'class name [2026-11-10]', () {
      expect(_run(prefix: 'l'), 'base');
    });

    test('F-GH18-AST-2: imported without a prefix by an entry declaring the '
        'same class name [2026-11-10]', () {
      expect(_run(), 'base');
    });

    test('F-GH18-AST-3: the library imports dart:core with a prefix '
        '[2026-11-10]', () {
      expect(_run(prefix: 'l', corePrefix: 'core'), 'base');
      expect(_run(corePrefix: 'core'), 'base');
    });

    test("F-GH18-AST-4: an imported library's own class shadows the class of "
        'the same name it imports [2026-11-10]', () {
      // mid.dart imports types.dart (whose `Base` it would otherwise see) and
      // declares its own `Base`; before the fix pass 1 skipped mid's
      // placeholder because the import had bound the name.
      const mid = 'package:p/mid.dart';
      expect(
        _bundle({
          _types: _typesLibrary(),
          mid: SCompilationUnit(
            offset: 0,
            length: 0,
            directives: [_import(_types)],
            declarations: [
              _class(
                'Base',
                members: [
                  SMethodDeclaration(
                    offset: 0,
                    length: 0,
                    name: _id('b'),
                    returnType: _type('String'),
                    parameters: _params(),
                    body: _returns(_str('own')),
                  ),
                ],
              ),
              _function('viaMid', _newThenB('Base')),
            ],
          ),
          _entry: SCompilationUnit(
            offset: 0,
            length: 0,
            directives: [_import(mid)],
            declarations: [
              _function(
                'main',
                SMethodInvocation(
                  offset: 0,
                  length: 0,
                  methodName: _id('viaMid'),
                  argumentList: _args(),
                ),
              ),
            ],
          ),
        }),
        'own',
      );
    });
  });
}
