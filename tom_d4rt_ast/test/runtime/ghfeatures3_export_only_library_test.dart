// ghfeatures3/AST — a bridged library whose bridges are only re-exports,
// class aliases or function typedefs is importable, in the analyzer-free tree.
//
// The mirror of `tom_d4rt/test/ghfeatures3_export_only_library_test.dart`,
// which runs source; here each script is a hand-built bundle. The loader
// decided whether a URI is a bridged library from classes, enums, functions,
// variables, getters, setters and extensions only, so a pure export barrel
// could not be imported (measured 2026-11-15 on tom_d4rt 1.264.0 / tom_d4rt_ast
// 0.244.0, tree). Re-exports, aliases and typedefs now count.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class Gh3A {
  String get name => 'a';
}

class Gh3B {
  String get name => 'b';
}

const _entry = 'package:p/main.dart';
const _a = 'package:gh3/src/a.dart';
const _b = 'package:gh3/src/b.dart';
const _barrel = 'package:gh3/gh3.dart';
const _aliases = 'package:gh3/legacy.dart';
const _typedefs = 'package:gh3/callbacks.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SNamedType _type(String name) =>
    SNamedType(offset: 0, length: 0, name: _id(name));

/// `<name>()`.
SMethodInvocation _call(String name, [List<SArgument> args = const []]) =>
    SMethodInvocation(
      offset: 0,
      length: 0,
      methodName: _id(name),
      argumentList: SArgumentList(offset: 0, length: 0, arguments: args),
    );

SPropertyAccess _get(SExpression target, String name) => SPropertyAccess(
  offset: 0,
  length: 0,
  target: target,
  operator: '.',
  propertyName: _id(name),
);

SIsExpression _is(SExpression e, String type) =>
    SIsExpression(offset: 0, length: 0, expression: e, type: _type(type));

SListLiteral _list(List<SExpression> elements) =>
    SListLiteral(offset: 0, length: 0, elements: elements);

SFormalParameterList _params([List<(String, String)> params = const []]) =>
    SFormalParameterList(
      offset: 0,
      length: 0,
      parameters: [
        for (final (type, name) in params)
          SRegularFormalParameter(
            offset: 0,
            length: 0,
            name: _id(name),
            type: _type(type),
          ),
      ],
    );

SFunctionDeclaration _function(
  String name,
  SExpression body, [
  List<(String, String)> params = const [],
]) => SFunctionDeclaration(
  offset: 0,
  length: 0,
  name: _id(name),
  functionExpression: SFunctionExpression(
    offset: 0,
    length: 0,
    parameters: _params(params),
    body: SExpressionFunctionBody(offset: 0, length: 0, expression: body),
  ),
);

BridgedClass _bridge(Type type, String name, Object Function() create) =>
    BridgedClass(
      nativeType: type,
      name: name,
      constructors: {'': (visitor, positional, named) => create()},
      getters: {'name': (visitor, target) => (target as dynamic).name},
    );

D4rtRunner _runner() => D4rtRunner()
  ..registerBridgedClass(_bridge(Gh3A, 'Gh3A', Gh3A.new), _a)
  ..registerBridgedClass(_bridge(Gh3B, 'Gh3B', Gh3B.new), _b)
  ..registerLibraryReExport(_barrel, _a)
  ..registerLibraryReExport(_barrel, _b)
  ..registerClassAlias('OldA', 'Gh3A', _aliases)
  ..registerLibraryReExport(_aliases, _a)
  ..registerFunctionTypedef(
    'Gh3Callback',
    _typedefs,
    requiredPositional: 0,
    maxPositional: 0,
  );

/// Runs a bundle importing [import] with [declarations] (`main` among them).
Object? _run(String import, List<SCompilationUnitMember> declarations) =>
    _runner().executeBundle(
      AstBundle(
        entryPointUri: _entry,
        modules: {
          _entry: SCompilationUnit(
            offset: 0,
            length: 0,
            directives: [
              SImportDirective(
                offset: 0,
                length: 0,
                uri: SSimpleStringLiteral(
                  offset: 0,
                  length: import.length + 2,
                  value: import,
                ),
              ),
            ],
            declarations: declarations,
          ),
        },
      ),
    );

void main() {
  group('ghfeatures3/AST: export-only bridged libraries', () {
    test('GHF3-AST-1: a pure export barrel offers what it re-exports '
        '[2026-11-15]', () {
      expect(
        _run(_barrel, [
          _function(
            'main',
            _list([_get(_call('Gh3A'), 'name'), _get(_call('Gh3B'), 'name')]),
          ),
        ]),
        ['a', 'b'],
      );
    });

    test('GHF3-AST-2: a library of aliases and one re-export: the alias and '
        'the re-exported class resolve [2026-11-15]', () {
      expect(
        _run(_aliases, [
          _function(
            'main',
            _list([_get(_call('OldA'), 'name'), _is(_call('OldA'), 'Gh3A')]),
          ),
        ]),
        ['a', true],
      );
    });

    test('GHF3-AST-3: a library of typedefs only: its typedef names a type '
        '[2026-11-15]', () {
      final emptyClosure = SFunctionExpression(
        offset: 0,
        length: 0,
        parameters: _params(),
        body: SBlockFunctionBody(
          offset: 0,
          length: 0,
          block: SBlock(offset: 0, length: 0, statements: const []),
        ),
      );
      expect(
        _run(_typedefs, [
          _function(
            'call',
            SSimpleStringLiteral(offset: 0, length: 8, value: 'called'),
            [('Gh3Callback', 'f')],
          ),
          _function('main', _call('call', [emptyClosure])),
        ]),
        'called',
      );
    });

    test('GHF3-AST-4: a URI with nothing registered is still not a bridged '
        'library [2026-11-15]', () {
      expect(
        () => _run('package:gh3/missing.dart', [
          _function('main', SIntegerLiteral(offset: 0, length: 1, value: 1)),
        ]),
        throwsA(predicate((e) => '$e'.contains('package:gh3/missing.dart'))),
      );
    });
  });
}
