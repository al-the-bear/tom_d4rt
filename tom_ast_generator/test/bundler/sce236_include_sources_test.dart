// SCE236 — the bundler can carry each module's source, so the analyzer-free
// interpreter can quote a script in a diagnostic.
//
// `AstBundle.sources` existed, and serialised, but no bundler ever filled it.
// `AstBundlerConfig.includeSources` does. It is off by default: it costs bundle
// size, and a release bundle may not want to ship its source.

import 'package:test/test.dart';
import 'package:tom_ast_generator/src/bundler/ast_bundler.dart';
import 'package:tom_d4rt_ast/runtime.dart' show AstBundle;

const _helper = 'int add(int a, int b) => a + b;';
const _main = '''
import 'package:helper/helper.dart';

void main() { add(1, 2); }
''';

void main() {
  test('F-SCE236-GEN-1: with includeSources, every bundled module carries its '
      'source [2026-09-29] (PASS)', () async {
    final bundle = await AstBundler(
      explicitSources: {'package:helper/helper.dart': _helper},
      config: const AstBundlerConfig(includeSources: true),
    ).createFromSource(_main);

    expect(bundle.sources, {
      'main.dart': _main,
      'package:helper/helper.dart': _helper,
    });
    // The offsets the interpreter quotes by index into exactly these strings.
    final add =
        bundle.modules['package:helper/helper.dart']!.declarations.single;
    expect(_helper.substring(add.offset, add.offset + add.length), _helper);
  });

  test('F-SCE236-GEN-2: the sources survive the JSON round trip '
      '[2026-09-29] (PASS)', () async {
    final bundle = await AstBundler(
      explicitSources: {'package:helper/helper.dart': _helper},
      config: const AstBundlerConfig(includeSources: true),
    ).createFromSource(_main);
    expect(AstBundle.fromJson(bundle.toJson()).sources, bundle.sources);
  });

  test('F-SCE236-GEN-3: by default no source is bundled [2026-09-29] '
      '(PASS)', () async {
    final bundle = await AstBundler(
      explicitSources: {'package:helper/helper.dart': _helper},
    ).createFromSource(_main);
    expect(bundle.sources, isNull);
  });
}
