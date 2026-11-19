/// GitHub al-the-bear/tom_d4rt#23 on the BUNDLE PATH: a constructor tear-off through an import prefix (`generated.Protocol.new`), the issue's two files (`test/fixtures/ghissues79/`) bundled parse-only and resolving, bundled by `AstBundler`, sent
/// through `toBytes` / `fromBytes` as an app receives a bundle, and run by
/// `D4rtRunner`.
///
/// `ghissues79_prefixed_constructor_tearoff_test.dart` next door is the verbatim port of the analyzer-based suite and
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

import 'fixtures/ghissues79/main.dart' as native;

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

String _read(String file) =>
    File('test/fixtures/ghissues79/$file').readAsStringSync();

void main() {
  tearDownAll(_resolver.dispose);

  for (final resolve in [false, true]) {
    final mode = resolve ? 'resolved' : 'parse-only';
    group('ghissues79 on the bundle path ($mode): prefix.Class.new', () {
      Future<Object?> run(String name) async => D4rtRunner().executeBundle(
        await _bundle(
          {
            'package:p/main.dart': _read('main.dart'),
            'package:p/protocol.dart': _read('protocol.dart'),
          },
          'package:p/main.dart',
          resolve: resolve,
        ),
        name: name,
      );

      test('GH79-B1: GitHub #23\'s repro answers [7, 7, 11, 11] '
          '[2026-11-19]', () async {
        expect(await run('main'), native.main());
      });

      test('GH79-B2: a generative, an implicit, a named and a generic '
          'constructor, and a bridged class, through the prefix '
          '[2026-11-19]', () async {
        expect([
          for (final e in await run('extras') as List) '$e',
        ], native.extras());
      });
    });
  }
}
