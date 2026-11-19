/// GitHub al-the-bear/tom_d4rt#24 on the BUNDLE PATH: a type argument compared with a type literal that has type arguments (`T == List<String>`), the program `test/fixtures/ghissues80_program.dart` bundled parse-only and resolving, bundled by `AstBundler`, sent
/// through `toBytes` / `fromBytes` as an app receives a bundle, and run by
/// `D4rtRunner`.
///
/// `ghissues80_applied_type_equality_test.dart` next door is the verbatim port of the analyzer-based suite and
/// runs the same cases through `execute(sources:)`. This file is its bundle
/// half, which has no counterpart in `tom_d4rt` and so can only be pinned
/// here; splitting them keeps the shared-name file a verbatim port (see
/// `_plan_e2_static_in_closure_bundle_test.dart`). Expected values are native
/// Dart's, as in the port.
library;

import 'dart:io';

import 'package:test/test.dart';
import 'package:tom_ast_generator/tom_ast_generator.dart' show AstResolver;
import 'package:tom_d4rt_exec/d4rt.dart';

import 'fixtures/ghissues80_program.dart' as native;

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

List<String> _strings(Object? value) => [for (final e in value as List) '$e'];

void main() {
  tearDownAll(_resolver.dispose);

  final source = File(
    'test/fixtures/ghissues80_program.dart',
  ).readAsStringSync();
  for (final resolve in [false, true]) {
    final mode = resolve ? 'resolved' : 'parse-only';
    group('ghissues80 on the bundle path ($mode): applied type equality', () {
      Future<List<String>> run(String name) async => _strings(
        D4rtRunner().executeBundle(
          await _bundle(
            {'package:ghissues80/program.dart': source},
            'package:ghissues80/program.dart',
            resolve: resolve,
          ),
          name: name,
        ),
      );

      test('GH80-B1: the issue, T == List<String> [2026-11-19]', () async {
        expect(await run('issue'), ['true', 'true']);
      });

      test('GH80-B2: the unequal controls stay false [2026-11-19]', () async {
        expect(await run('controls'), _strings(native.controls()));
      });

      test('GH80-B3: equal applied types, their hash and their names '
          '[2026-11-19]', () async {
        expect(await run('equalities'), _strings(native.equalities()));
      });

      test('GH80-B4: constructor tear-offs of an applied class '
          '[2026-11-19]', () async {
        expect(await run('tearOffs'), _strings(native.tearOffs()));
      });
    });
  }
}
