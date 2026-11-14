// GH47/AST — GitHub #14: the extensions of a library imported with a prefix
// apply implicitly, as those of an unprefixed import do, in the
// analyzer-free tree (ghissues47).
//
// The mirror of `tom_d4rt/test/ghissues47_prefixed_import_extensions_test.dart`,
// which runs source. Here each script is a hand-built bundle. Before the fix
// `import 'package:r/public.dart' as api;` (public.dart exporting an
// extension) left `'a'.x()` without the extension, while the unprefixed import
// applied it: the extension lookup never visited the environments bound to
// import prefixes.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

const _entry = 'package:p/main.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

SSimpleStringLiteral _str(String v) =>
    SSimpleStringLiteral(offset: 0, length: v.length + 2, value: v);

SNamedType _type(String n) => SNamedType(offset: 0, length: 0, name: _id(n));

SFormalParameterList _params() => SFormalParameterList(offset: 0, length: 0);

/// `import '<uri>' [as <prefix>] [hide <hidden>]`
SImportDirective _import(String uri, {String? prefix, String? hide}) =>
    SImportDirective(
      offset: 0,
      length: 0,
      uri: _str(uri),
      prefix: prefix == null ? null : _id(prefix),
      combinators: [
        if (hide != null)
          SHideCombinator(offset: 0, length: 0, hiddenNames: [_id(hide)]),
      ],
    );

/// `extension X on String { String x() => 'x'; }`
final _extension = SExtensionDeclaration(
  offset: 0,
  length: 0,
  name: _id('X'),
  extendedType: _type('String'),
  body: SBlockClassBody(
    offset: 0,
    length: 0,
    members: [
      SMethodDeclaration(
        offset: 0,
        length: 0,
        name: _id('x'),
        returnType: _type('String'),
        parameters: _params(),
        body: SExpressionFunctionBody(
          offset: 0,
          length: 0,
          expression: _str('x'),
        ),
      ),
    ],
  ),
);

/// `package:r/src/encoding.dart` declares the extension,
/// `package:r/public.dart` exports it.
final _modules = <String, SCompilationUnit>{
  'package:r/src/encoding.dart': SCompilationUnit(
    offset: 0,
    length: 0,
    declarations: [_extension],
  ),
  'package:r/public.dart': SCompilationUnit(
    offset: 0,
    length: 0,
    directives: [
      SExportDirective(offset: 0, length: 0, uri: _str('src/encoding.dart')),
    ],
  ),
};

/// Runs `main() => '<receiver>'.<member>()` after [imports].
Object? _run(
  List<SDirective> imports, {
  String member = 'x',
  D4rtRunner? runner,
}) => (runner ?? D4rtRunner()).executeBundle(
  AstBundle(
    entryPointUri: _entry,
    modules: {
      ..._modules,
      _entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: imports,
        declarations: [
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: _params(),
              body: SExpressionFunctionBody(
                offset: 0,
                length: 0,
                expression: SMethodInvocation(
                  offset: 0,
                  length: 0,
                  target: _str('hi'),
                  operator: '.',
                  methodName: _id(member),
                  argumentList: SArgumentList(offset: 0, length: 0),
                ),
              ),
            ),
          ),
        ],
      ),
    },
  ),
);

final Matcher _noExtension = throwsA(
  predicate(
    (Object e) =>
        e.toString().contains('no suitable extension method found') ||
        e.toString().contains('has no instance method named'),
    'no extension applied',
  ),
);

void main() {
  group('GH47/AST: extensions through a prefixed import', () {
    test('F-GH47-AST-1: an extension a prefixed library exports applies '
        '(GitHub #14) [2026-11-14]', () {
      expect(_run([_import('package:r/public.dart', prefix: 'api')]), 'x');
    });

    test('F-GH47-AST-2: the unprefixed control, and no import at all '
        '[2026-11-14]', () {
      expect(_run([_import('package:r/public.dart')]), 'x');
      expect(() => _run([]), _noExtension);
    });

    test('F-GH47-AST-3: hide removes the named extension from the prefixed '
        'import [2026-11-14]', () {
      expect(
        () => _run([_import('package:r/public.dart', prefix: 'api', hide: 'X')]),
        _noExtension,
      );
    });

    test('F-GH47-AST-4: a bridged extension through a prefixed import '
        '[2026-11-14]', () {
      final runner = D4rtRunner()
        ..registerBridgedExtension(
          BridgedExtensionDefinition(
            name: 'Gh47Shout',
            onTypeName: 'String',
            methods: {
              'shout': (visitor, target, positional, named, typeArgs) =>
                  '${(target as String).toUpperCase()}!',
            },
          ),
          'package:b/b.dart',
        );
      expect(
        _run(
          [_import('package:b/b.dart', prefix: 'b')],
          member: 'shout',
          runner: runner,
        ),
        'HI!',
      );
    });
  });
}
