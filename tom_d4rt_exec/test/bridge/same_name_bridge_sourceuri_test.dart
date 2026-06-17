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

    test(
        'B2-CLASH-1: importing tom_doc_scanner resolves its MarkdownParser '
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

    test(
        'B2-CLASH-3: when BOTH same-name libraries are imported, each static '
        'still resolves to the library that declared it [2026-06-17]', () {
      // PUBLISH-GATED: the shadow-fallback fix lives in tom_d4rt_ast's
      // Environment + InterpreterVisitor and exec's tolerant module loader.
      // exec depends on the *published* tom_d4rt_ast (hosted, not a path dep —
      // path overrides are forbidden by the workspace rules), so this end-to-end
      // case only goes green once tom_d4rt_ast ships the fix and exec's
      // constraint is bumped. Remove this skip then.
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

      expect(interpreter.execute(source: source), 'doc-scanner-id:Hello World');
    },
        skip: 'Publish-gated: needs tom_d4rt_ast shipped with the same-name '
            'bridge shadow-fallback fix and exec constraint bumped.');
  });
}
