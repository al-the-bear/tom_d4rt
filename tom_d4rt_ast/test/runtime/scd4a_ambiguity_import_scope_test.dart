/// SCD4 (scd4_aicv) — a bridged name two packages share is judged over what
/// the SCRIPT imports, not over everything the host registered.
///
/// Until SCF9 `D4rtRunner`'s warm parent was a NAME baseline: every bridged
/// class of every registered library was bound in one environment every script
/// enclosed, so a name no import carried still resolved through it — the
/// shape `cupertino/contextmenu_test.dart` met with `TextStyle`. These cases
/// used to pin that baseline. SCF9 made the warm parent register bridge TYPES
/// only, as `tom_d4rt`'s always has, and they now assert what the reference
/// answers: a bare name resolves only through the script's own imports.
///
///   * F-SCD4A-AST-1 — importing one barrel that exports the class gets it.
///   * F-SCD4A-AST-2 — importing both is refused, as Dart refuses it.
///   * F-SCD4A-AST-3 — a PREFIXED import brings no bare name at all: undefined.
///     (Against the baseline this answered "ambiguous", from classes the script
///     never imported.)
///   * F-SCD4A-AST-4 — a barrel that does not export the class leaves it
///     undefined. (Against the baseline it resolved anyway.)
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_ast/runtime.dart';

class _ScannerParser {}

/// An error naming [name] as undefined — the reference's answer for a bare
/// name no import of the script carries.
Matcher _undefined(String name) => predicate<Object>(
  (e) => '$e'.contains('Undefined') && '$e'.contains(name),
  'an undefined-name error for $name',
);

extension on D4rtRunner {
  /// [registerBridgedClass] when [condition] holds; keeps the fixture's
  /// cascade linear.
  void registerBridgedClassIf(
    bool condition,
    BridgedClass bridged,
    String library,
    String sourceUri,
  ) {
    if (condition) registerBridgedClass(bridged, library, sourceUri: sourceUri);
  }
}

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

  /// Both packages register a `MarkdownParser` under their `src/` library.
  /// When [barrelsExport], each barrel re-exports it as well (registered under
  /// the barrel with the `src/` source URI, which is how a re-export is
  /// recorded); otherwise the barrel carries only a marker.
  D4rtRunner runner({bool barrelsExport = true}) => D4rtRunner()
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
    )
    ..registerBridgedClassIf(
      barrelsExport,
      parser(_ScannerParser, 'scanner'),
      scannerBarrel,
      scannerSrc,
    )
    ..registerBridgedClassIf(
      barrelsExport,
      parser(_LatexParser, 'latex'),
      latexBarrel,
      latexSrc,
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

    test('F-SCD4A-AST-3: a prefixed import brings no bare name — undefined, '
        'not ambiguous [2026-09-29] (PASS)', () {
      expect(
        () => runner().executeBundleAs<Object?>(
          bundle([importOf(scannerBarrel, prefix: 'ds')]),
        ),
        throwsA(_undefined('MarkdownParser')),
      );
    });

    test('F-SCD4A-AST-4: a barrel that does not export the class leaves the '
        'bare name undefined [2026-09-29] (PASS)', () {
      expect(
        () => runner(
          barrelsExport: false,
        ).executeBundleAs<Object?>(bundle([importOf(scannerBarrel)])),
        throwsA(_undefined('MarkdownParser')),
      );
    });
  });
}
