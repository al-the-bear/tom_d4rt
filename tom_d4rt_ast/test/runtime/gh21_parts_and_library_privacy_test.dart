// GH21/AST — parts and library privacy in the analyzer-free tree (GitHub
// al-the-bear/tom_d4rt#21).
//
// The mirror of `tom_d4rt/test/gh21_parts_and_library_privacy_test.dart`,
// which runs the issue's five graphs as source. Here each library and each
// part is a hand-built bundle module, as `AstBundler` emits them (it follows
// part directives and bundles a part as a module of its own). `part` and
// `part of` were ignored at run time: a part's declarations never reached its
// library, and a part loaded as a library of its own. A library is now loaded
// with its parts merged in (`AstModuleLoader.libraryUnit`), after checking
// that each part names it and has no directive of its own; a part loaded as a
// library is refused; and a library's exported names leave out its `_` names.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SIntegerLiteral _int(int v) => SIntegerLiteral(offset: 0, length: 1, value: v);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SArgumentList _args() => SArgumentList(offset: 0, length: 0);

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

SPartDirective _part(String uri) =>
    SPartDirective(offset: 0, length: 0, uri: _str(uri));

SPartOfDirective _partOf(String uri) =>
    SPartOfDirective(offset: 0, length: 0, uri: _str(uri));

SPartOfDirective _partOfName(String name) => SPartOfDirective(
  offset: 0,
  length: 0,
  libraryName: SDottedName(offset: 0, length: 0, components: [_id(name)]),
);

SLibraryDirective _library(String name) => SLibraryDirective(
  offset: 0,
  length: 0,
  name: SDottedName(offset: 0, length: 0, components: [_id(name)]),
);

/// `class <name> [extends <base>] { <name>(); [int value() { return v; }] }`
SClassDeclaration _class(
  String name, {
  String? extendsName,
  int? value,
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
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          block: SBlock(offset: 0, length: 0),
        ),
      ),
      if (value != null)
        SMethodDeclaration(
          offset: 0,
          length: 0,
          name: _id('value'),
          returnType: _type('int'),
          parameters: SFormalParameterList(offset: 0, length: 0),
          body: _returns(_int(value)),
        ),
    ],
  ),
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
        parameters: SFormalParameterList(offset: 0, length: 0),
        body: _returns(result),
      ),
    );

/// `<name>()`
SMethodInvocation _call(String name) => SMethodInvocation(
  offset: 0,
  length: 0,
  methodName: _id(name),
  argumentList: _args(),
);

/// `<className>().value()`
SMethodInvocation _valueOfNew(String className) => SMethodInvocation(
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
  methodName: _id('value'),
  argumentList: _args(),
);

SBinaryExpression _plus(SExpression a, SExpression b) => SBinaryExpression(
  offset: 0,
  length: 0,
  leftOperand: a,
  operator: '+',
  rightOperand: b,
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

/// Runs [entry] (default `package:p/main.dart`) of [modules].
Object? _run(
  Map<String, SCompilationUnit> modules, {
  String entry = 'package:p/main.dart',
}) => D4rtRunner().executeBundle(
  AstBundle(entryPointUri: entry, modules: modules),
);

Matcher _refusedWith(String text) =>
    throwsA(predicate((Object e) => e.toString().contains(text), text));

void main() {
  group('GH21/AST: parts', () {
    test('GH21-AST-1: the issue - a public part type across an import cycle '
        '[2026-11-16]', () {
      expect(
        _run({
          'package:p/main.dart': _unit(
            [_import('package:p/owner.dart')],
            [_function('main', _call('value'))],
          ),
          'package:p/owner.dart': _unit(
            [_import('package:p/child.dart'), _part('piece.dart')],
            [_function('value', _valueOfNew('Child'))],
          ),
          'package:p/piece.dart': _unit(
            [_partOf('owner.dart')],
            [_class('Base', value: 11)],
          ),
          'package:p/child.dart': _unit(
            [_import('package:p/owner.dart')],
            [_class('Child', extendsName: 'Base')],
          ),
        }),
        11,
      );
    });

    test('GH21-AST-2: a part shares its library\'s private names, its '
        'library may be named, and the entry may have parts [2026-11-16]', () {
      expect(
        _run({
          'package:p/main.dart': _unit(
            [_library('app'), _part('src/piece.dart')],
            [_function('main', _plus(_valueOfNew('Base'), _call('_hidden')))],
          ),
          'package:p/src/piece.dart': _unit(
            [_partOfName('app')],
            [_class('Base', value: 11), _function('_hidden', _int(1))],
          ),
        }),
        12,
      );
    });

    test('GH21-AST-3: a part that names another library is refused '
        '[2026-11-16]', () {
      expect(
        () => _run({
          'package:p/main.dart': _unit(
            [_import('package:p/owner.dart')],
            [_function('main', _int(1))],
          ),
          'package:p/owner.dart': _unit([_part('piece.dart')]),
          'package:p/piece.dart': _unit([_partOf('other.dart')]),
          'package:p/other.dart': _unit([_part('piece.dart')]),
        }),
        _refusedWith(
          "Expected 'package:p/piece.dart' to be part of "
          "'package:p/owner.dart', not 'package:p/other.dart'",
        ),
      );
      expect(
        () => _run({
          'package:p/main.dart': _unit(
            [_part('piece.dart')],
            [_function('main', _int(1))],
          ),
          'package:p/piece.dart': _unit([_partOfName('app')]),
        }),
        _refusedWith('which has no library name'),
      );
    });

    test('GH21-AST-4: a part missing from the bundle, without part-of, or '
        'with a directive of its own is refused [2026-11-16]', () {
      Map<String, SCompilationUnit> withPiece(SCompilationUnit? piece) => {
        'package:p/main.dart': _unit(
          [_part('piece.dart')],
          [_function('main', _int(1))],
        ),
        'package:p/piece.dart': ?piece,
      };
      expect(
        () => _run(withPiece(null)),
        _refusedWith("The part 'package:p/piece.dart' of"),
      );
      expect(
        () => _run(withPiece(_unit([]))),
        _refusedWith('must have a part-of directive'),
      );
      expect(
        () => _run(
          withPiece(_unit([_partOf('main.dart'), _import('dart:math')])),
        ),
        _refusedWith('has a directive of its own'),
      );
    });

    test('GH21-AST-5: a part is not a library - importing, exporting or '
        'running it is refused [2026-11-16]', () {
      const notALibrary = "'package:p/piece.dart' is a part of another library";
      final graph = {
        'package:p/owner.dart': _unit([_part('piece.dart')]),
        'package:p/piece.dart': _unit(
          [_partOf('owner.dart')],
          [_function('fromPart', _int(19))],
        ),
      };
      expect(
        () => _run({
          ...graph,
          'package:p/main.dart': _unit(
            [_import('package:p/piece.dart')],
            [_function('main', _call('fromPart'))],
          ),
        }),
        _refusedWith(notALibrary),
      );
      expect(
        () => _run({
          ...graph,
          'package:p/barrel.dart': _unit([_export('package:p/piece.dart')]),
          'package:p/main.dart': _unit(
            [_import('package:p/barrel.dart')],
            [_function('main', _call('fromPart'))],
          ),
        }),
        _refusedWith(notALibrary),
      );
      expect(
        () => _run(graph, entry: 'package:p/piece.dart'),
        _refusedWith(notALibrary),
      );
    });
  });

  group('GH21/AST: library privacy', () {
    test('GH21-AST-6: the issue - a private class through an export barrel '
        'is not found [2026-11-16]', () {
      expect(
        () => _run({
          'package:p/main.dart': _unit(
            [_import('package:p/child.dart')],
            [_function('main', _valueOfNew('Child'))],
          ),
          'package:p/barrel.dart': _unit([_export('package:p/base.dart')]),
          'package:p/base.dart': _unit([], [_class('_PrivateBase', value: 13)]),
          'package:p/child.dart': _unit(
            [_import('package:p/barrel.dart')],
            [_class('Child', extendsName: '_PrivateBase')],
          ),
        }),
        _refusedWith("Superclass '_PrivateBase' not found"),
      );
    });

    test('GH21-AST-7: an import does not carry private names; the library\'s '
        'own code still uses them [2026-11-16]', () {
      Map<String, SCompilationUnit> graph(SExpression result) => {
        'package:p/main.dart': _unit(
          [_import('package:p/lib.dart')],
          [_function('main', result)],
        ),
        'package:p/lib.dart': _unit([], [
          _function('_secret', _int(42)),
          _function('reveal', _call('_secret')),
        ]),
      };
      expect(_run(graph(_call('reveal'))), 42);
      expect(() => _run(graph(_call('_secret'))), throwsA(anything));
    });

    test('GH21-AST-8: the control - a private class of an imported '
        'library\'s part is refused [2026-11-16]', () {
      expect(
        () => _run({
          'package:p/main.dart': _unit(
            [_import('package:p/child.dart')],
            [_function('main', _int(1))],
          ),
          'package:p/owner.dart': _unit([_part('piece.dart')]),
          'package:p/piece.dart': _unit(
            [_partOf('owner.dart')],
            [_class('_PrivateBase')],
          ),
          'package:p/child.dart': _unit(
            [_import('package:p/owner.dart')],
            [_class('Child', extendsName: '_PrivateBase')],
          ),
        }),
        _refusedWith("Superclass '_PrivateBase' not found"),
      );
    });
  });
}
