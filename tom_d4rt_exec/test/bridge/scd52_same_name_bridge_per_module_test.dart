// SCD52 — two libraries may register the same bridge name, and importing one
// resolves to that one.
//
// This is the capability exec did not have. Until SCD52 its `ModuleLoader`
// registered every bridge for a URI into `globalEnvironment`, as a side effect
// of `_fetchModuleSource` being asked for source text. One flat scope cannot
// hold two `MarkdownParser`s, so the second registration shadowed the first and
// which one a script got depended on registration ORDER rather than on what it
// imported. `tom_d4rt` and `tom_d4rt_ast` had both moved to per-module
// environments (GEN-100) and could express this; exec could not.
//
// Ported from `tom_d4rt/test/bridge/same_name_bridge_sourceuri_test.dart`
// (B2-CLASH-1 and -2), which is where the reference pins the same behaviour.
//
// MEASURED BOTH WAYS, because a test that passes after a refactor proves
// nothing on its own about the refactor. The result corrected a prediction:
//
//   F-SCD52-1, -2  pass BEFORE the restructure as well.
//   F-SCD52-3, -4  pass before it too.
//
// So exec was NOT broken here, and this file is a regression guard rather than
// evidence of a fix. The reason the one-library cases were never at risk is
// that registration is driven by IMPORT: a library nobody imports never reaches
// the environment, so with one import there is no second `MarkdownParser` to
// shadow anything, flat scope or not. The two-import cases DO put both names in
// scope at once, and they were already handled — by the ambiguity machinery
// (`AmbiguousBridgedNameException` and the `<package>.Name` qualifier), which
// sits above the loader and did not depend on where the bridges were
// registered.
//
// That is worth stating plainly because SCD52 predicted the opposite: it listed
// "bridges leak into the global scope, so exec cannot express `show`/`hide` or
// same-name-in-two-libraries the way the other two can" as a live consequence.
// For same-name-in-two-libraries, measured, it is not.
//
// The four cases are kept anyway. They pin behaviour that the restructure moved
// house — the bridges now live in per-module environments — and nothing else in
// exec's suite covered the two-import clash at all.

import 'package:test/test.dart';
import 'package:tom_d4rt_exec/d4rt.dart';

class DocScannerMarkdownParser {}

class Md2LatexMarkdownParser {}

void main() {
  group('SCD52: same bridge name in two libraries', () {
    late D4rt interpreter;

    BridgedClass docScannerParser() => BridgedClass(
      nativeType: DocScannerMarkdownParser,
      name: 'MarkdownParser',
      constructors: {},
      staticMethods: {
        'generateId':
            (
              InterpreterVisitor visitor,
              List<Object?> positional,
              Map<String, Object?> named,
              List<RuntimeType>? typeArgs,
            ) {
              return 'doc-scanner-id:${positional.first}';
            },
      },
    );

    BridgedClass md2latexParser() => BridgedClass(
      nativeType: Md2LatexMarkdownParser,
      name: 'MarkdownParser',
      constructors: {},
      staticMethods: {
        'toLatex':
            (
              InterpreterVisitor visitor,
              List<Object?> positional,
              Map<String, Object?> named,
              List<RuntimeType>? typeArgs,
            ) {
              return 'latex:${positional.first}';
            },
      },
    );

    setUp(() {
      interpreter = D4rt();
    });

    test('F-SCD52-1: importing tom_doc_scanner resolves ITS MarkdownParser '
        'even though tom_md2latex registered the name afterwards '
        '[2026-09-12]', () {
      // doc_scanner FIRST, so a last-wins flat scope hands back md2latex's.
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
      expect(
        interpreter.execute(source: source),
        'doc-scanner-id:Hello World',
        reason:
            'The script imported tom_doc_scanner, so it must get that '
            "library's MarkdownParser. Getting md2latex's means bridge names "
            'are living in one flat scope again and the later registration '
            'shadowed the earlier.',
      );
    });

    test('F-SCD52-2: and the same with the registration order reversed '
        '[2026-09-12]', () {
      // The mirror. Without it a loader that simply preferred the FIRST
      // registration would pass the case above while being just as wrong.
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
      expect(
        interpreter.execute(source: source),
        'latex:Hello World',
        reason:
            'The script imported tom_md2latex. Getting doc_scanner\'s '
            'MarkdownParser means resolution follows registration order '
            'rather than the import.',
      );
    });

    /// Registers both libraries, which is what puts two `MarkdownParser`s in
    /// one scope — the shape a flat global registry cannot represent.
    void registerBoth() {
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
    }

    test('F-SCD52-3: with BOTH libraries imported the bare name is rejected, '
        'as Dart rejects it [2026-09-12]', () {
      // The REPL/replay shape: an init source imports every registered bridge
      // library, so both names land in one scope unprefixed. Picking whichever
      // bridge happens to declare the requested member would bind the name to
      // a class the author never named.
      registerBoth();
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

    test('F-SCD52-4: qualifying by package name reaches each declaring '
        'library [2026-09-12]', () {
      // The escape hatch the ambiguity error points at. Refusing the bare name
      // costs nothing: both classes stay reachable.
      registerBoth();
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
    });
  });
}
