/// ghissues67 (found measuring GitHub al-the-bear/tom_d4rt#18) on the BUNDLE PATH: a collection keeps its written type arguments - #18's map cases (Serverpod's `toJson()` on an empty map), bundled by `AstBundler`, sent
/// through `toBytes` / `fromBytes` as an app receives a bundle, and run by
/// `D4rtRunner`.
///
/// `ghissues67_written_collection_type_arguments_test.dart` next door is the verbatim port of the analyzer-based suite and
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

const _extensions = """
extension MapJson<K, V> on Map<K, V> {
  Object toJson() => K == String ? <String, Object?>{} : <Object?>[];
}
""";

/// Runs [body] (statements ending in a `return`) after [_extensions] from a
/// bundle, each element of the returned list as Dart's `toString` renders it.
Future<List<String>> run(String body) async {
  final result = D4rtRunner().executeBundle(
    await _bundle({
      'package:p/main.dart': '$_extensions\ndynamic main() {\n$body\n}',
    }, 'package:p/main.dart'),
  );
  return [for (final value in result as List) '$value'];
}

void main() {
  tearDownAll(_resolver.dispose);

  group('ghissues67 on the bundle path: #18\'s map cases', () {
    test('GH67-B1: Serverpod\'s case - toJson() on an empty map chooses by '
        'its written K [2026-11-19]', () async {
      expect(
        await run("""
final Map<String, int> narrow = {};
final Map<dynamic, dynamic> wide = narrow;
return [<String, int>{}.toJson(), narrow.toJson(), wide.toJson()];
"""),
        ['{}', '{}', '[]'],
      );
    });

    test('GH67-B2: a literal\'s runtimeType names its written type arguments '
        '[2026-11-19]', () async {
      expect(
        await run("""
final m = <String, int>{};
return [<String>[].runtimeType, m.runtimeType, <String>{}.runtimeType,
  <String>[] is List<int>];
"""),
        ['List<String>', '_Map<String, int>', '_Set<String>', 'false'],
      );
    });
  });
}
