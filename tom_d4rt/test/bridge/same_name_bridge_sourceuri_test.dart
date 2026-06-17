/// Regression: same-name bridges from different libraries must resolve to the
/// library the script actually imports — not the last one registered.
///
/// Scenario (the "B2 MarkdownParser clash"): two unrelated packages,
/// `tom_doc_scanner` and `tom_md2latex`, each register a `BridgedClass` named
/// `MarkdownParser`. They live at different canonical source URIs and expose
/// different static methods (`generateId`/`extractText` vs `toLatex`). Bridge
/// registration into the environment keys by *simple name*, so the last
/// registration silently shadows the first. A script that imports ONLY
/// `tom_doc_scanner` and calls `MarkdownParser.generateId(...)` then resolves
/// the wrong (md2latex) bridge and fails.
///
/// The fix is sourceUri-qualified bridge resolution: the import that brought
/// the name into scope must determine which underlying bridge a static call
/// targets.
library;

import 'package:test/test.dart';
import 'package:tom_d4rt/d4rt.dart';

/// Distinct native types so the two bridges have different `nativeType`.
class DocScannerMarkdownParser {}

class Md2LatexMarkdownParser {}

void main() {
  group('Same-name bridge resolution by importing library', () {
    late D4rt interpreter;

    BridgedClass docScannerParser() => BridgedClass(
          nativeType: DocScannerMarkdownParser,
          name: 'MarkdownParser',
          constructors: {},
          staticMethods: {
            'generateId': (InterpreterVisitor visitor,
                List<Object?> positional,
                Map<String, Object?> named,
                List<RuntimeType>? typeArgs) {
              return 'doc-scanner-id:${positional.first}';
            },
          },
        );

    BridgedClass md2latexParser() => BridgedClass(
          nativeType: Md2LatexMarkdownParser,
          name: 'MarkdownParser',
          constructors: {},
          staticMethods: {
            'toLatex': (InterpreterVisitor visitor,
                List<Object?> positional,
                Map<String, Object?> named,
                List<RuntimeType>? typeArgs) {
              return 'latex:${positional.first}';
            },
          },
        );

    setUp(() {
      interpreter = D4rt();
    });

    test(
        'B2-CLASH-1: importing tom_doc_scanner resolves its MarkdownParser '
        'static even when tom_md2latex registered a same-name bridge after it '
        '[2026-06-17]', () {
      // doc_scanner registered FIRST.
      interpreter.registerBridgedClass(
        docScannerParser(),
        'package:tom_doc_scanner/tom_doc_scanner.dart',
        sourceUri: 'package:tom_doc_scanner/src/markdown_parser.dart',
      );
      // md2latex registered AFTER — last-wins would shadow doc_scanner.
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

      final result = interpreter.execute(source: source);
      expect(result, 'doc-scanner-id:Hello World');
    });

    test(
        'B2-CLASH-2: importing tom_md2latex resolves its MarkdownParser static '
        'even when tom_doc_scanner registered a same-name bridge after it '
        '[2026-06-17]', () {
      // Reverse registration order: md2latex first, doc_scanner after.
      interpreter.registerBridgedClass(
        md2latexParser(),
        'package:tom_md2latex/tom_md2latex.dart',
        sourceUri: 'package:tom_md2latex/src/markdown_parser.dart',
      );
      interpreter.registerBridgedClass(
        docScannerParser(),
        'package:tom_doc_scanner/tom_doc_scanner.dart',
        sourceUri: 'package:tom_doc_scanner/src/markdown_parser.dart',
      );

      const source = '''
import 'package:tom_md2latex/tom_md2latex.dart';

String main() {
  return MarkdownParser.toLatex('Hello World');
}
''';

      final result = interpreter.execute(source: source);
      expect(result, 'latex:Hello World');
    });

    test(
        'B2-CLASH-3: when BOTH same-name libraries are imported, each static '
        'still resolves to the library that declared it [2026-06-17]', () {
      // This mirrors the REPL/replay scenario: the init source imports every
      // registered bridge library, so both MarkdownParser bridges land in one
      // environment. A bare `MarkdownParser.generateId(...)` then resolves by
      // simple name — last-wins shadowing makes the doc_scanner static
      // disappear. With sourceUri-qualified resolution, both statics must
      // remain reachable through their declaring library.
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

      final result = interpreter.execute(source: source);
      expect(result, 'doc-scanner-id:Hello World');
    });
  });
}
