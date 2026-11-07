// GitHub al-the-bear/tom_d4rt#9 — the bundler parses at the interpreters'
// language version, not at the analyzer's newest one.
//
// Measured 2026-11-07 on 0.2.1 (analyzer 14.7.0): bundling the unmodified
// intl 0.20.3 sources failed before anything ran, with `Parse errors in
// package:intl/src/intl/compact_number_format.dart: Can't have modifier
// 'final' here` - intl declares `num parse(final String inputText)`, and
// `parseString` without a feature set parses at the analyzer's newest language
// version, which rejects a `final` parameter. Both interpreters parse source
// at a fixed language version (`D4rt._parseSource`); the bundler now uses the
// same one, so a library a script can run is also a library it can bundle.

import 'package:test/test.dart';
import 'package:tom_ast_generator/src/bundler/ast_bundler.dart';

const _lib = '''
num parse(final String inputText) => num.parse(inputText);
''';

void main() {
  test('GH9-BUNDLE-1: a library with a final parameter bundles '
      '[2026-11-07]', () async {
    final bundle =
        await AstBundler(
          explicitSources: {'package:lib/lib.dart': _lib},
        ).createFromSource('''
import 'package:lib/lib.dart';
num main() => parse('41') + 1;
''');
    expect(bundle.modules.keys, contains('package:lib/lib.dart'));
  });

  test('GH9-BUNDLE-2: so does an entry source with one [2026-11-07]', () async {
    final bundle = await AstBundler().createFromSource(
      'int twice(final int x) => x * 2;\nint main() => twice(21);',
    );
    expect(bundle.modules, isNotEmpty);
  });
}
