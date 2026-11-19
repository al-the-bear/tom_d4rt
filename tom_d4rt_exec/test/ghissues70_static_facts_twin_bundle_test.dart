/// ghissues70 (GitHub al-the-bear/tom_d4rt#18, resolved bundles) on the BUNDLE PATH: #18's map cases (`test/fixtures/ghissues70_map_cases.dart.txt`, the source of tom_d4rt_ast's fixture), parse-only and through `AstBundler(config: AstBundlerConfig(resolve: true))`, whose static facts give native Dart's answers, bundled by `AstBundler`, sent
/// through `toBytes` / `fromBytes` as an app receives a bundle, and run by
/// `D4rtRunner`.
///
/// `ghissues70_static_facts_twin_test.dart` next door is the verbatim port of the analyzer-based suite and
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

const _entry = 'package:map_repro/entry.dart';
const _native = 'package:map_repro/native.dart';

/// The host library, registered at run time; the resolver checks against it
/// (tom_ast_generator's `tool/write_resolved_bundle_fixture.dart`).
const _stub = """
Map<String, int> sameMap() => throw UnimplementedError();
Map<String, int> emptyMap() => throw UnimplementedError();
Set<String> sameSet() => throw UnimplementedError();
""";

D4rtRunner _runner() => D4rtRunner()
  ..registerTopLevelFunction(
    'sameMap',
    (visitor, positional, named, typeArgs) => <String, int>{'x': 7},
    _native,
  )
  ..registerTopLevelFunction(
    'emptyMap',
    (visitor, positional, named, typeArgs) => <String, int>{},
    _native,
  )
  ..registerTopLevelFunction(
    'sameSet',
    (visitor, positional, named, typeArgs) => <String>{'a'},
    _native,
  );

Future<AstBundle> _fixtureBundle(String name, {required bool resolve}) =>
    _bundle(
      {_entry: File('test/fixtures/$name.dart.txt').readAsStringSync()},
      _entry,
      resolve: resolve,
      bridged: {_native},
      stubs: {_native: _stub},
    );

List<String> _strings(Object? value) => [for (final e in value as List) '$e'];

void main() {
  tearDownAll(_resolver.dispose);

  group('ghissues70 on the bundle path: #18\'s map cases', () {
    test(
      'GH70-B1: a resolved bundle answers as native Dart [2026-11-19]',
      () async {
        final bundle = await _fixtureBundle(
          'ghissues70_map_cases',
          resolve: true,
        );
        expect(bundle.facts, isNotNull);
        expect(_strings(_runner().executeBundle(bundle)), [
          'String',
          'dynamic',
          'String',
          '{}',
          '[]',
          '{}',
          'wide',
          'narrow',
          'true',
          'int',
          'int',
          'String',
        ]);
      },
    );

    test('GH70-B2: a parse-only bundle approximates from run-time values, as '
        'the source path does (Lim-13) [2026-11-19]', () async {
      final bundle = await _fixtureBundle(
        'ghissues70_map_cases',
        resolve: false,
      );
      expect(bundle.facts, isNull);
      expect(_strings(_runner().executeBundle(bundle)), [
        'String',
        'dynamic',
        'dynamic',
        '{}',
        '[]',
        '{}',
        'wide',
        'wide',
        'true',
        'dynamic',
        'T',
        'dynamic',
      ]);
    });
  });
}
