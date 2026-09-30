// SCF44/AST — the analyzer-free twin of
// `tom_d4rt/test/scf44_member_access_without_import_test.dart`.
//
// `import 'dart:io'; main() => stdout.encoding.name;` failed until the script
// also imported dart:convert, because a stdlib module's type→bridge mapping
// reached the lookup only when the module was imported. A latent registry of
// every stdlib library's bridges now answers a value's bridge; names stay
// import-scoped.
//
// These run against the WORKING TREE of this interpreter, which the exec
// suites cannot (DGUC6), so the bundles are built from `SAstNode`s by hand.

@TestOn('vm')
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

SSimpleIdentifier _id(String n) =>
    SSimpleIdentifier(offset: 0, length: n.length, name: n);

/// `import '<uri>'; main() => <body>;`
Object? _run(String uri, SExpression body) {
  const entry = 'package:probe/main.dart';
  final bundle = AstBundle(
    entryPointUri: entry,
    modules: {
      entry: SCompilationUnit(
        offset: 0,
        length: 0,
        directives: [
          SImportDirective(
            offset: 0,
            length: 0,
            uri: SSimpleStringLiteral(offset: 0, length: 0, value: uri),
          ),
        ],
        declarations: [
          SFunctionDeclaration(
            offset: 0,
            length: 0,
            name: _id('main'),
            functionExpression: SFunctionExpression(
              offset: 0,
              length: 0,
              parameters: SFormalParameterList(offset: 0, length: 0),
              body: SExpressionFunctionBody(
                offset: 0,
                length: 0,
                expression: body,
              ),
            ),
          ),
        ],
      ),
    },
  );
  return (D4rtRunner()..grant(FilesystemPermission.any)).executeBundle(bundle);
}

/// `<target>.<member>.<property>`
SExpression _chain(String target, String member, String property) =>
    SPropertyAccess(
      offset: 0,
      length: 0,
      target: SPrefixedIdentifier(
        offset: 0,
        length: 0,
        prefix: _id(target),
        identifier: _id(member),
      ),
      operator: '.',
      propertyName: _id(property),
    );

void main() {
  group(
    'SCF44/AST: member access needs no import of the declaring library',
    () {
      test('F-SCF44-AST-1: stdout.encoding.name with only dart:io imported '
          '[2026-09-30] (PASS)', () {
        expect(_run('dart:io', _chain('stdout', 'encoding', 'name')), 'utf-8');
      });

      test('F-SCF44-AST-2: systemEncoding.name, a dart:io value whose members '
          'come from dart:convert [2026-09-30] (PASS)', () {
        expect(
          _run(
            'dart:io',
            SPrefixedIdentifier(
              offset: 0,
              length: 0,
              prefix: _id('systemEncoding'),
              identifier: _id('name'),
            ),
          ),
          isA<String>(),
        );
      });

      test('F-SCF44-AST-3: control — the NAME Utf8Codec stays unresolvable '
          'without its import [2026-09-30] (PASS)', () {
        expect(
          () => _run(
            'dart:io',
            SMethodInvocation(
              offset: 0,
              length: 0,
              methodName: _id('Utf8Codec'),
              argumentList: SArgumentList(offset: 0, length: 0),
            ),
          ),
          throwsA(predicate((e) => '$e'.contains('Utf8Codec'))),
        );
      });
    },
  );
}
