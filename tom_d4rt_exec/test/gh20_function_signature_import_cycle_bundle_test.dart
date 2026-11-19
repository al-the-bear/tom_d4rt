/// GitHub al-the-bear/tom_d4rt#20 on the BUNDLE PATH: a top-level function whose signature names a class of a library in the same import cycle, the reporter's path (`AstBundler(explicitSources: ...)`), bundled by `AstBundler`, sent
/// through `toBytes` / `fromBytes` as an app receives a bundle, and run by
/// `D4rtRunner`.
///
/// `gh20_function_signature_import_cycle_test.dart` next door is the verbatim port of the analyzer-based suite and
/// runs the same cases through `execute(sources:)`. This file is its bundle
/// half, which has no counterpart in `tom_d4rt` and so can only be pinned
/// here; splitting them keeps the shared-name file a verbatim port (see
/// `_plan_e2_static_in_closure_bundle_test.dart`). Expected values are native
/// Dart's, as in the port.
library;

import 'package:test/test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstResolver;
import 'package:tom_d4rt_exec/d4rt.dart';

final _resolver = AstResolver();

/// [sources] bundled from [entry] by the [AstBundler] - parse-only, or with
/// [resolve] the resolving check and its static facts - sent through
/// `toBytes` / `fromBytes` as an app receives a bundle.
Future<AstBundle> _bundle(
  Map<String, String> sources,
  String entry, {
  bool resolve = false,
  Set<String> bridged = const {},
  Map<String, String> stubs = const {},
}) async {
  final bundle = await AstBundler(
    explicitSources: sources,
    bridgedLibraries: bridged,
    declarationStubs: stubs,
    fileAccessValidator: (_) => false,
    config: AstBundlerConfig(resolve: resolve),
    resolver: _resolver,
  ).createFromSource(sources[entry]!, sourcePath: entry);
  return AstBundle.fromBytes(bundle.toBytes());
}

Matcher refusedWith(String text) =>
    throwsA(predicate((Object e) => e.toString().contains(text), text));

/// The issue's graph: `helper.dart` declares [helper] and `marker()`.
Future<Object?> run(
  String helper, {
  String main = 'main() => answer();',
}) async => D4rtRunner().executeBundle(
  await _bundle({
    'package:p/main.dart':
        "import 'package:p/node.dart';\n"
        "import 'package:p/helper.dart';\n$main",
    'package:p/node.dart':
        "import 'package:p/helper.dart';\n"
        'class Node {}\n'
        'class Leaf extends Node {}\n'
        'int answer() => marker();',
    'package:p/helper.dart':
        "import 'package:p/node.dart';\n$helper\nint marker() => 7;",
  }, 'package:p/main.dart'),
);

void main() {
  tearDownAll(_resolver.dispose);

  group('gh20 on the bundle path: a signature across an import cycle', () {
    test('GH20-B1: the issue - a bound naming the cycle\'s class, never '
        'called [2026-11-19]', () async {
      expect(await run('T identity<T extends Node>(T x) => x;'), 7);
      expect(await run('T identity<T>(T x) => x;'), 7);
    });

    test('GH20-B2: the deferred bound is checked when the function is called '
        '[2026-11-19]', () async {
      expect(
        await run(
          'T identity<T extends Node>(T x) => x;',
          main: 'main() => identity<Leaf>(Leaf()) is Leaf;',
        ),
        isTrue,
      );
      await expectLater(
        run(
          'T identity<T extends Node>(T x) => x;',
          main: "main() => identity<String>('s');",
        ),
        refusedWith(
          "Type argument 'String' for type parameter 'T' does not satisfy "
          "bound 'Node' in function 'identity'",
        ),
      );
    });

    test('GH20-B3: a return type naming the cycle\'s class - plain, '
        'nullable, a getter, async [2026-11-19]', () async {
      expect(
        // `run` is async, so it awaits the Future the async main returns.
        await run(
          'Node make(Node n) => n;\n'
          'Node? maybe() => null;\n'
          'Node get first => Leaf();\n'
          'Future<Node> later() async => Leaf();',
          main:
              'main() async { final last = await later(); '
              'return [make(Leaf()) is Leaf, maybe(), first is Leaf, '
              'last is Leaf]; }',
        ),
        [true, null, true, true],
      );
    });

    test('GH20-B4: an undefined bound or return type is still reported '
        '[2026-11-19]', () async {
      await expectLater(
        run('T lost<T extends Missing>(T x) => x;'),
        refusedWith('Missing'),
      );
      await expectLater(
        run('Gone lost() => null;'),
        refusedWith("Type 'Gone' not found"),
      );
    });
  });
}
