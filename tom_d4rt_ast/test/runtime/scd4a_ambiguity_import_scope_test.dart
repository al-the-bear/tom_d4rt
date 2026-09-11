/// SCD4 (scd4_aicv) — a bridged name two packages share is judged over what
/// the SCRIPT imports, not over everything the host registered.
///
/// `D4rtRunner`'s warm parent is a name baseline: it registers every bridged
/// class of every registered library into one environment, which every script
/// encloses. Two libraries declaring `MarkdownParser` therefore made the bare
/// name ambiguous there — in every script, whatever it imported.
///
/// A name the script's imports bring in is found in the script's own scope
/// first, so this only surfaces when an import's recorded export surface is
/// missing the name and the lookup falls through to the baseline. That is not
/// hypothetical: `cupertino/contextmenu_test.dart` hit it with `TextStyle`
/// while importing only cupertino, foundation and material (the platform
/// half of that case is AMBIG-P*; this file is the package-vs-package half).
/// Here the barrel re-exports nothing, and the class is registered under the
/// package's `src/` library — the same shape, reproduced.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class _ScannerParser {}

class _LatexParser {}

void main() {
  const scannerBarrel = 'package:tom_doc_scanner/tom_doc_scanner.dart';
  const scannerSrc = 'package:tom_doc_scanner/src/markdown_parser.dart';
  const latexBarrel = 'package:tom_md2latex/tom_md2latex.dart';
  const latexSrc = 'package:tom_md2latex/src/markdown_parser.dart';

  var offset = 0;
  int next() => offset += 5;

  BridgedClass parser(Type nativeType, String answer) => BridgedClass(
    nativeType: nativeType,
    name: 'MarkdownParser',
    staticMethods: {'id': (visitor, positional, named, typeArgs) => answer},
  );

  /// Both packages register a `MarkdownParser` under their `src/` library;
  /// each barrel carries only a marker, so importing the barrel does not
  /// bring `MarkdownParser` into the script's own scope.
  D4rtRunner runner() => D4rtRunner()
    ..registerBridgedClass(
      BridgedClass(nativeType: Object, name: 'DocScanner'),
      scannerBarrel,
      sourceUri: scannerBarrel,
    )
    ..registerBridgedClass(
      parser(_ScannerParser, 'scanner'),
      scannerSrc,
      sourceUri: scannerSrc,
    )
    ..registerBridgedClass(
      BridgedClass(nativeType: Object, name: 'Md2Latex'),
      latexBarrel,
      sourceUri: latexBarrel,
    )
    ..registerBridgedClass(
      parser(_LatexParser, 'latex'),
      latexSrc,
      sourceUri: latexSrc,
    );

  SImportDirective importOf(String uri, {String? prefix}) => SImportDirective(
    offset: next(),
    length: 1,
    uri: SSimpleStringLiteral(offset: next(), length: 1, value: uri),
    prefix: prefix == null
        ? null
        : SSimpleIdentifier(offset: next(), length: 1, name: prefix),
  );

  /// `main() => MarkdownParser.id();` under [imports].
  AstBundle bundle(List<SImportDirective> imports) {
    const entry = 'package:t/main.dart';
    final call = SMethodInvocation(
      offset: next(),
      length: 1,
      target: SSimpleIdentifier(
        offset: next(),
        length: 14,
        name: 'MarkdownParser',
      ),
      operator: '.',
      methodName: SSimpleIdentifier(offset: next(), length: 2, name: 'id'),
      argumentList: SArgumentList(offset: next(), length: 2),
    );
    final mainFn = SFunctionDeclaration(
      offset: next(),
      length: 4,
      name: SSimpleIdentifier(offset: next(), length: 4, name: 'main'),
      functionExpression: SFunctionExpression(
        offset: next(),
        length: 1,
        parameters: SFormalParameterList(offset: next(), length: 1),
        body: SBlockFunctionBody(
          offset: next(),
          length: 1,
          block: SBlock(
            offset: next(),
            length: 1,
            statements: [
              SReturnStatement(offset: next(), length: 1, expression: call),
            ],
          ),
        ),
      ),
    );
    return AstBundle(
      entryPointUri: entry,
      modules: {
        entry: SCompilationUnit(
          offset: 0,
          length: 0,
          directives: imports,
          declarations: [mainFn],
        ),
      },
    );
  }

  group('SCD4A/AST: ambiguity follows the script\'s imports', () {
    test('F-SCD4A-AST-1: a script importing one package gets that package\'s '
        'class [2026-09-11] (PASS)', () {
      expect(
        runner().executeBundleAs<Object?>(bundle([importOf(scannerBarrel)])),
        'scanner',
      );
      expect(
        runner().executeBundleAs<Object?>(bundle([importOf(latexBarrel)])),
        'latex',
      );
    });

    test('F-SCD4A-AST-2: a script importing both packages is still refused, '
        'as Dart refuses it [2026-09-11] (PASS)', () {
      expect(
        () => runner().executeBundleAs<Object?>(
          bundle([importOf(scannerBarrel), importOf(latexBarrel)]),
        ),
        throwsA(
          isA<AmbiguousBridgedNameException>().having(
            (e) => e.candidatesByQualifier.keys,
            'qualifiers',
            unorderedEquals(<String>['tom_doc_scanner', 'tom_md2latex']),
          ),
        ),
      );
    });

    test('F-SCD4A-AST-3: a prefixed import does not put its package in scope '
        'for bare names [2026-09-11] (PASS)', () {
      expect(
        () => runner().executeBundleAs<Object?>(
          bundle([importOf(scannerBarrel, prefix: 'ds')]),
        ),
        throwsA(isA<AmbiguousBridgedNameException>()),
      );
    });
  });
}
