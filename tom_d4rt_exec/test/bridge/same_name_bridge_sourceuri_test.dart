/// Regression (AST interpreter): same-name bridges from different libraries
/// must resolve to the library the script actually imports — not the last one
/// registered.
///
/// End-to-end twin of `tom_d4rt/test/bridge/same_name_bridge_sourceuri_test.dart`
/// running through the analyzer-free (`tom_d4rt_ast`) interpreter via the
/// `tom_d4rt_exec` source entry point. See that file for the full "B2
/// MarkdownParser clash" narrative.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

class DocScannerMarkdownParser {}

class Md2LatexMarkdownParser {}

void main() {
  group('Same-name bridge resolution by importing library (AST)', () {
    late D4rt interpreter;

    BridgedClass docScannerParser() => BridgedClass(
      nativeType: DocScannerMarkdownParser,
      name: 'MarkdownParser',
      constructors: {},
      staticMethods: {
        'generateId': (visitor, positional, named, typeArgs) =>
            'doc-scanner-id:${positional.first}',
      },
    );

    BridgedClass md2latexParser() => BridgedClass(
      nativeType: Md2LatexMarkdownParser,
      name: 'MarkdownParser',
      constructors: {},
      staticMethods: {
        'toLatex': (visitor, positional, named, typeArgs) =>
            'latex:${positional.first}',
      },
    );

    setUp(() {
      interpreter = D4rt();
    });

    test('B2-CLASH-1: importing tom_doc_scanner resolves its MarkdownParser '
        'static even when tom_md2latex registered a same-name bridge after it '
        '[2026-06-17]', () {
      interpreter.registerBridgedClass(
        docScannerParser(),
        'package:tom_doc_scanner/tom_doc_scanner.dart',
        sourceUri: 'package:tom_doc_scanner/src/markdown_parser.dart',
      );
      interpreter.registerBridgedClass(
        md2latexParser(),
        'package:tom_md2latex/tom_md2latex.dart',
        sourceUri: 'package:tom_md2latex/src/markdown_parser.dart',
      );

      const source = '''
import 'package:tom_doc_scanner/tom_doc_scanner.dart';

String main() {
  return MarkdownParser.generateId('Hello World');
}
''';

      expect(interpreter.execute(source: source), 'doc-scanner-id:Hello World');
    });

    test('B2-CLASH-3: when BOTH same-name libraries are imported the bare name '
        'is rejected, as in Dart [2026-06-17]', () {
      // Dart rejects such a reference and asks for a prefix, and so does d4rt —
      // the earlier behaviour of picking whichever bridge happened to declare
      // the requested member bound the name to a class the author never named.
      interpreter.registerBridgedClass(
        docScannerParser(),
        'package:tom_doc_scanner/tom_doc_scanner.dart',
        sourceUri: 'package:tom_doc_scanner/src/markdown_parser.dart',
      );
      interpreter.registerBridgedClass(
        md2latexParser(),
        'package:tom_md2latex/tom_md2latex.dart',
        sourceUri: 'package:tom_md2latex/src/markdown_parser.dart',
      );

      const source = '''
import 'package:tom_doc_scanner/tom_doc_scanner.dart';
import 'package:tom_md2latex/tom_md2latex.dart';

String main() {
  return MarkdownParser.generateId('Hello World');
}
''';

      expect(
        () => interpreter.execute(source: source),
        throwsA(
          isA<AmbiguousBridgedNameException>().having(
            (e) => e.candidatesByQualifier.keys,
            'qualifiers',
            containsAll(<String>['tom_doc_scanner', 'tom_md2latex']),
          ),
        ),
      );
    });

    test(
      'B2-CLASH-4: qualifying by package name reaches each declaring library '
      '[2026-08-03]',
      () {
        // The escape hatch the ambiguity error points at. Both classes stay
        // reachable — nothing is lost by refusing the bare name.
        interpreter.registerBridgedClass(
          docScannerParser(),
          'package:tom_doc_scanner/tom_doc_scanner.dart',
          sourceUri: 'package:tom_doc_scanner/src/markdown_parser.dart',
        );
        interpreter.registerBridgedClass(
          md2latexParser(),
          'package:tom_md2latex/tom_md2latex.dart',
          sourceUri: 'package:tom_md2latex/src/markdown_parser.dart',
        );

        const source = '''
import 'package:tom_doc_scanner/tom_doc_scanner.dart';
import 'package:tom_md2latex/tom_md2latex.dart';

String main() {
  return tom_doc_scanner.MarkdownParser.generateId('Hello World') +
      '|' +
      tom_md2latex.MarkdownParser.toLatex('Hello World');
}
''';

        expect(
          interpreter.execute(source: source),
          'doc-scanner-id:Hello World|latex:Hello World',
        );
      },
    );
  });
}
