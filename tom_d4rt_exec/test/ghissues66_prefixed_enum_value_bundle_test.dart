/// ghissues66 (GitHub al-the-bear/tom_d4rt#21 follow-up) on the BUNDLE PATH: an enum value reached through an import prefix (`s.AppLocale.zhCn` of a Slang-shaped enum), bundled by `AstBundler`, sent
/// through `toBytes` / `fromBytes` as an app receives a bundle, and run by
/// `D4rtRunner`.
///
/// `ghissues66_prefixed_enum_value_test.dart` next door is the verbatim port of the analyzer-based suite and
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

Future<Object?> run(Map<String, String> files) async =>
    D4rtRunner().executeBundle(
      await _bundle({
        for (final MapEntry(:key, :value) in files.entries)
          'package:fixture/$key': value,
      }, 'package:fixture/main.dart'),
    );

/// Slang's generated shape, as in the port.
const _strings = """
mixin BaseAppLocale<E extends BaseAppLocale<E, T>, T> {
  String get languageCode;
  String? get countryCode;
  String get tag =>
      countryCode == null ? languageCode : '\$languageCode-\$countryCode';
}
class Translations {}
enum AppLocale with BaseAppLocale<AppLocale, Translations> {
  en(languageCode: 'en'),
  zhCn(languageCode: 'zh', countryCode: 'CN');

  const AppLocale({required this.languageCode, this.countryCode});
  @override
  final String languageCode;
  @override
  final String? countryCode;
}
""";

void main() {
  tearDownAll(_resolver.dispose);

  group('ghissues66 on the bundle path: an enum value through a prefix', () {
    test('GH66-B1: the issue - `s.AppLocale.zhCn` [2026-11-19]', () async {
      expect(
        await run({
          'strings.dart': _strings,
          'main.dart': """
import 'strings.dart' as s;
main() => [
  s.AppLocale.zhCn.tag,
  s.AppLocale.zhCn.name,
  s.AppLocale.zhCn.index,
  identical(s.AppLocale.zhCn, s.AppLocale.values[1]),
];
""",
        }),
        ['zh-CN', 'zhCn', 1, true],
      );
    });

    test('GH66-B2: a plain enum through a prefix [2026-11-19]', () async {
      expect(
        await run({
          'e.dart': 'enum Color { red, green }',
          'main.dart':
              "import 'e.dart' as e; "
              'main() => [e.Color.green.toString(), e.Color.green.index, '
              'e.Color.values.length];',
        }),
        ['Color.green', 1, 2],
      );
    });
  });
}
